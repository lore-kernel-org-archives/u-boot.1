Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98430CE7AAE
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 10:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D5084088;
	Fri, 14 Nov 2025 11:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="nyUJgrwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B813E83F4F; Fri, 14 Nov 2025 11:57:16 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35BA84068
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1763117834; x=1763722634; i=smoch@web.de;
 bh=e1ym1lN95NolqzDT08JlpRyjac74RcuxWFU4QkhCju8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=nyUJgrwENcf1DP3WXLFvoD4BRbbBOsi/BxnHuyfuzCdUDSBU8el7r9qnYgb2B5oz
 KsBn+bn749zXP7sUsoZTMVgHAegK54AzZtls4zOLKaWalFUSCoRrtmaQEH8Xg+5gl
 F2p9nLJ8iWKsMOW+xeYCmB9vjZadAI/CZZ8e/+3Ab0ZuIwvW6QKX2Ylz0sfQ8n/2c
 S19tLMTrHlfQv9zkC+wPXRKlcmBkPyujdghJg8hJHbv5aJVuHL3fYBUh4M51lb7q8
 +Y+Z9sc1Y4DCao+DxwiT+2T1UHd6EcMMjbXEiRSuz14BPW42xQfrO5F2mp2avi3mE
 KPkqvU2jijMtfRu6Bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([78.54.190.247]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLifk-1vbWtm150q-00KDhu; Fri, 14
 Nov 2025 11:57:14 +0100
Message-ID: <36f11b16-2389-4636-9cfb-c8d05cf81b7e@web.de>
Date: Fri, 14 Nov 2025 11:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: tbs2910: Disable EFI partition, MP, sysboot, bind
 commands
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>
References: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
 <4298f3c8-5aa6-49d7-a8c8-693590dbdc32@web.de>
 <8d5f1351-5ab7-4650-a84c-d8991acc3cf4@mailbox.org>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <8d5f1351-5ab7-4650-a84c-d8991acc3cf4@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BDRS47qgDtHH78Ft7sPTG3OzuJ+Xe023ckJTVtB/TD4JPyMmzOm
 uwkjKZudd55YulZBGmF1rl/JGRm+TOzeFYG5606J173VByh7HZqWTuuou2vnHM4vtmdaHpC
 TJCgaUV3w2XiPo/D9kZ3Wps/euB5S3cHm6ZzPE2ZPYyrL3UMQulGoXxpFBAUn63InAR4R1I
 8DOLQcsCpKFEsBX6XEnrg==
UI-OutboundReport: notjunk:1;M01:P0:NPSvOOxmwgQ=;FrYT/bexcwgv5jJ0SQwrtNXIcJr
 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
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

On 14.11.25 11:36, Marek Vasut wrote:
> On 11/14/25 10:53 AM, S=C3=B6ren Moch wrote:
>> On 13.11.25 16:18, Marek Vasut wrote:
>>> This board is just short of overflowing the size limit, disable
>>> support for EFI partition since EFI support is already disabled,
>>> and disable a couple of commands which are also likely unused to
>>> keep the board below limit.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Thanks for finding additional useful options to reduce code size!
> More like use-less options,=20
If you want to make this distinction, fine with me.
This just should read: Thanks for you efforts to improve the defconfig=20
towards reduced code size, which indeed is very critical for this board.
> but can you please at least try whether the machine still boots and=20
> check whether those options are really not used on this system ?
>
> Thank you !
Do you really think I (as board maintainer) would Ack this patch when I=20
wouldn't find the changes reasonable!?
And of course I also tested this (on top of v2025.10) and the board=20
still boots.

Regards,
Soeren
