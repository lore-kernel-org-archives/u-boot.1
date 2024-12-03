Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DADE6C5F6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBAF8951C;
	Tue,  3 Dec 2024 04:31:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="m3bhjcAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBC7895E0; Tue,  3 Dec 2024 04:31:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01E608950E
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733196683; x=1733801483; i=xypron.glpk@gmx.de;
 bh=40voMKTXDa9c9du1wvxiDT8a5se2ZotBd+qbyLHd8+E=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=m3bhjcArYg880srEJkqAqLb/72gQsT1bkQGACAz1iVJp3/Bqm5FYTzryJQGbtYpp
 vof5nTBY98ugK7DO9gUHWivW0a+fMVhgg9DbIdkBFmEaO2hWemjMTJUkTMaaqO59r
 v8ymT+gI+OTxwBiKw0oycLpWpx/KzNxtVZ2AcpPjqMllsS2CUSS3woWhsQd0MutOP
 1ILimnc6MrptqDi1jUH29+OTFPaWh0Qbm1K4EnUY4kl2CDi4swa9v7evMfwUM352k
 thO/5zRYUd07mv1AWsBmv/S0dSO1mHU/salodzhOGua9XW3znbXBHRp5isVND0FcK
 0BZ4VI9QFwioolXDAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1tBJFB3yJ9-00Yi6S; Tue, 03
 Dec 2024 04:31:23 +0100
Date: Tue, 03 Dec 2024 04:31:22 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/7] efi_loader: Add support for logging to a buffer
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTi0SQft1EUh4GYrkcC3F+r_s9h2PcMWWUjtGTVSLAUkhA@mail.gmail.com>
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <CAFLszTi0SQft1EUh4GYrkcC3F+r_s9h2PcMWWUjtGTVSLAUkhA@mail.gmail.com>
Message-ID: <D513D326-41A6-425E-B11F-85958065BCD2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+vJuA4UVrUd8TdMlbWEZ2J3jb6pU7b0SM1K1EgY00WY05dM16xj
 pqpisPMAi+0K7ISkAfl8SqGWuPf69Epum92vE0cAYuICHjlhBg2Wats/cBelnfSeIpRkdEA
 wttmccTSG934Iqvw7Gt9ffDMaMseEw8Z/99EpMbvvXC7ACL06uOqT5qgOadNXFH7KJL2SP3
 bzoDwAt/4o2Cygerg/6sA==
UI-OutboundReport: notjunk:1;M01:P0:FFOpzhDPc98=;Jsancj13Lrz6MOuE2hEjaRk3YGR
 J0uFMO0XjEAL/HV4wkT6ZOnSaMsBguDv3wjcC0cda0F6pXqGhrOCkbA2fHarfyk90FpJeynep
 w8F//6+OCH0Uxml35vs6rAL5kPQ9Ki3XSvrN2+yGRHsRQt3MKRVu2uaED48isVahIZOW5BM82
 UJQp2MGUmpZK6gjG9oFHk+tZuixUeeCTYBe3Eh+DN11fB/Mdw9EM9OAxMeKeAPESqTeFXItQe
 Zg6uW603KfOIWMHApWdgY7moYrKjAGm2Wi+Q36cw4HbZLiOjuHf4CNwrFs9buFmUf5DDU2gRT
 tSQ80H6/75qAwLtlvKD89WuDh8MXX8OQn2nK1m5VTt9vRS4xIjXxXSuf4GcesgTkENW04IM1W
 8dKHml1O9XpymRvNhvLp43kdgUa1FiSbcGbDPgR4oooNVWSrSTr1jYKSd7A6wRT8lppW3RV4Q
 PdTN9FYCfW7iK/yyJMqmUO6DGgUNEGwvM72VKpaNuzxHttqQ50SEyvbN+B0BHvIrsWWfM6Jp6
 oyXCdZl5RGEXnMS3ruKjy6XWCAHNRBtopGW2D4sUT39HcQFtcpVllsw78xG58PXnCFQ9D0F8j
 46G5NT9b41p6jYBSyP4k8c9LKQK82SZvdZP1yIZa5J28LTY0yXygq27W2wvpdI9uNuAiYj8VV
 QqhW2i52HmnooHZqg7uH8GgC1cVgrwtkuhLkT2te3Ry8MQXKW2JS7OVISUuVveMz0Vv4T37CA
 DpUKH3hRuViIynqKrSLcfvjqEVckiW1e98NVjoUQQYzu+U3iJa8ayEVhIky2hO+yzL9z6ckPd
 JUrBGvtSwShuAfSzuuFq1CUZklj2Bcruqr3g1Rp6MfAwIRdWX28o+njwt6kqi/0+5EyCX7jVR
 C2W3mdqe4hXa4fJ3jsOcVKLikPvXHOe3LvpRRXZCNGPtzbVrNKEvftmv9t2J1RNFRuBd5JO4R
 04pldV+27lO/TMXBnv7+KmO8c/ze/CaFwq1LNvmoLS5AK8D9BDbYu3PQcwHaSMeB1Sj+3CHBs
 ZaGTKMTb8TW4rGrUP5lFwxL/Pu3CDHcQ5K72SNAnAkxgB5kazMWeDTDnM0Qa80pfHui1UUAkY
 loaFDE8q5TNp9tA0qg+MwQfpQHU22i
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

Am 3=2E Dezember 2024 01:23:26 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>=
:
>Hi Heinrich,
>
>On Sun, 1 Dec 2024 at 17:24, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>=
 wrote:
>>
>> Am 2=2E Dezember 2024 01:12:36 MEZ schrieb Simon Glass <sjg@chromium=2E=
org>:
>> >It is a bit of a pain to log EFI boot-services calls at present=2E The
>> >output goes to the console so cannot easily be inspected later=2E Also=
 it

You could use U-Boot's syslog driver=2E Or Linux tee command to solve the =
problem=2E

Both would allow post mortem analysis=2E Post mortem analysis is not possi=
ble when using a buffer in U-Boot=2E

So this series seems to be less then ideal=2E

>> >would be useful to be able to store the log and review it later, perha=
ps
>> >after something has gone wrong=2E
>> >
>> >This series makes a start on implementing a log-to-buffer feature=2E I=
t
>> >provides a simple 'efidebug log' command to inspect the buffer=2E For =
now,
>> >only memory allocations are logged=2E
>>
>> In my previous review I suggested to move your work to the level of the=
 logging library lib/log=2Ec=2E
>
>Well, we could do that, if we actually have a need for programmatic
>logging of other subsystems=2E

Just do it right the first time=2E

Best regards

Heinrich

>
>>
>> Why are you reiterating your series without exposing why an EFI specifi=
c solution=2E should be desireable?
>
>I don't see that need yet, or at least, not for the purpose I am
>heading towards=2E In any case, we can easily refactor the code later if
>it is needed=2E For now I believe that this logging feature will help to
>tame some of the troubles we have=2E
>
>[=2E=2E]
>
>Regards,
>Simon

