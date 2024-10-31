Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E958EE67485
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 22:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C74C889E9;
	Thu, 31 Oct 2024 23:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZCn1E1YK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254DA88E0F; Thu, 31 Oct 2024 23:31:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD0B881A5
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 23:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730413865; x=1731018665; i=xypron.glpk@gmx.de;
 bh=HIU1+wamuJC+1r8/fJoWOeDw6FZQ9bwZt7ArLEZYOEQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZCn1E1YK7f72YRNq4ay1sjQBw/DL8AhgpSFNfMI6gw0yETUaqEuL69ei+Jxa0kNe
 LS3iBL59A3N1VSIsXBWHNilSjFfsQrt6DUpX6ZazfHHGnBQN5Q3k/bxtMaWn7+G3h
 1fDij75PWFfPFPepjMGhn4+3Aa6ACtg9OeNhngxjRkSMdaFvroTeSduy6Y0Ujr4sT
 Ne+iI3w0q0Yzn8Kpiv779AYHroagWc9XlqDx09I7+POv9YHuGEI39nL88tTYrnLYa
 47kwdIEN2tICSGKd+B5uvfXNlqS1wb3IvsgHZsYtSdPL4Rp/jjy09orNb4YPkH23I
 nr4IYPWtKj4wvon53A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([87.215.50.114]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRk3-1tiSPp3Fgv-00h7SP; Thu, 31
 Oct 2024 23:31:05 +0100
Date: Thu, 31 Oct 2024 23:30:58 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 10/15] efi_loader: Add support for logging EFI calls
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTj9EhCKkxjBotx-CvuKjuV2T7C6CyJTpHB59nerLavKjA@mail.gmail.com>
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-11-sjg@chromium.org>
 <A00AAF0F-5E6B-4DE3-B18A-DD564026D3A8@gmx.de>
 <CAFLszTj9EhCKkxjBotx-CvuKjuV2T7C6CyJTpHB59nerLavKjA@mail.gmail.com>
Message-ID: <00941595-FD52-44B3-B618-CCC43F7342CB@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0g0E+qP0kULFKOEsT7BFQK0ZSJSppuUoV0s8hiXO/AkctJX97hH
 PY7im3NlFjoslO8nCnzi9BcmssPvbJACnmJIKWL61vP/hkeVtiZ9TUdIOz8uJAhLKT7qywz
 OAE8bfPdRzYFqUd3mYUbH+4mbQkEfqYqhFzY/einwGI6lw4dyFIT+2x200HoYKkSBEy36j0
 IEnqSxpXKzLNdoNfQLrAQ==
UI-OutboundReport: notjunk:1;M01:P0:+cJUJt9hVak=;yVATLtoMXWQwcY5A/zPsjDx2rnm
 +jMvnT3QPIBDxDEZ69je/Qh60++n95nP2w12ikU0FiftLNX0LbzPdIIz7Fm8kYvnAfsirleUO
 hjyhxHNDdOap7uYJGZPW8vMxn8EX3UKlgLLH3PrYSho+AyZwtgbttjlKQYG9b9NRnfx/z1XSZ
 mwF2Cp8cCWj/TUjHaIxA3YxW+C6Yg6jfs+gPJzTm5u5sYvVD78vxb5sZgvskn3EofFkdneZ6p
 2eBP7hHbsJQIvRtDel9eF+qV3qsapLZJaYy+8AHQRwx3G7vxo44fsOAESipen5en7jtpZV5zQ
 DiGCH6v6gICNYI/8wKLkZiC84I6wqnZDrg/jCwUOGKuDphdIC5yTq/fGAkRTnzckwqLTZILgP
 tcCfCoBuQkDeTTrae/Eb5oL/svrcainYJKk+XPUv/wwKOTdakQfzO6CcOHxAbfaE3TpVud6A/
 sjLExQDT0F7u1Ms2O9lokSBWVGuHG3jLxjWX84uFyP1hzwhBdSGjDltmOE1ggRMW2Z+lBWEoK
 +EQKGiRuTUMeoh5JhV2bckqcuGQ432wmpnz3ZIq8NYE8/SAK88JRovZktOo6MdeO2i6MKNgeD
 HtmzzVvtDdYhRqq6wyPACxEjnh+STu3b0+5XlrLpOidnVH/pHuqR9zQUUvYSl+sd4UqwulacY
 KPW5Pr/Zh977IHmW2SA/WHwxjMAKbU+AXePdU2vKwk1f3tnorYV0ApzSJikfaieyRTX2pB5Ah
 d8zdmIM60ZxYhyfkIOzOznWqLiXQb7EL9VV4dIzAE6BgX0Z6EM61Nszfuw1tkuXy7UVuy6ew0
 lcWRFSXfLVtC1GrHWioVqUNg==
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



Am 31=2E Oktober 2024 19:01:47 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi Heinrich,
>
>On Tue, 29 Oct 2024 at 23:32, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>>
>>
>> Am 28=2E Oktober 2024 13:48:01 MEZ schrieb Simon Glass <sjg@chromium=2E=
org>:
>> >The current logging system suffers from some disadvantages, mainly tha=
t
>> >it writes its output to the console and cannot be easily reviewed=2E
>> >
>> >Add a dedicated log, storing records in a binary format and including
>> >the result codes and any return values from each call=2E The log is bu=
ilt
>> >sequentially in memory and can be reviewed after any EFI operation=2E =
It
>> >could potentially be written to media for later review, but that is no=
t
>> >implemented so far=2E
>>
>> An EFI specific solution is not a good approach as it does not scale to=
 other parts of the code=2E  Please, implement a log driver to collect the =
messages that you are interested in=2E
>>
>
>I can do that too, but it isn't as easy to programmatically parse=2E I'd
>like to track what calls are made and understand better what is going
>on when Ubuntu boots, etc=2E

What makes calls to log_debug hard to parse? We have __FILE__, __LINE__, _=
_func__, and message text available as individual fields=2E

What information are you missing?

For tracking function calls we already have a trace capability in U-Boot=
=2E

Best regards

Heinrich


>
>Regards,
>Simon
