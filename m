Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AE5C47074
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 07:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D78A876A6;
	Mon,  1 Jan 2024 08:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kl77Xxbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A88E1876DE; Mon,  1 Jan 2024 08:48:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2BF871CC
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 08:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704095265; x=1704700065; i=xypron.glpk@gmx.de;
 bh=P05rjC6VIo6Z5xKy3egSPyzN7yww9KZvX6iorDxd8HA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=kl77Xxbesxr71gPfvE+gashMVOd947K/2XCeGnBwXBDw8wkCuFfzP0ITSrTjAn1x
 PEitdmDuSwRN6lZ//TkEKFPdksSRQGhaeRTccK/EZx+kMiduA2Dw6p/SWzhd1TrlP
 mgPr4NTt45OJxDSrOXEvGRYs0QQIMI1kaWZqWF9oohksDtYPqaka/67XczdLOPr2J
 jBgRac5VVGJuY3zreJMeSQmIMGsZvxRnZX54KbLbVLuByP8KIRq2gjJxYkAj9JG2M
 qglQOSnLPP7aUOpjtiip+Kv7JqXLPIX4ud037hnCE/PdTLLGvZziVGxKzlA6q/6Kg
 IBoDN7FCIgDVKexdVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDnI-1rVi0c3wUQ-00CjFJ; Mon, 01
 Jan 2024 08:47:45 +0100
Date: Mon, 01 Jan 2024 08:47:42 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Igor Prusov <ivprusov@salutedevices.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: Re: [PATCH v5 00/12] smbios: Deal with tables beyond 4GB
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTj0Ef1VQMA2nc7xN4i8hyZbkLVZ+gMyybSPKOcjfpy14A@mail.gmail.com>
References: <20231231152555.464874-1-sjg@chromium.org>
 <4683F3D9-7D61-4D26-B1F2-3DB07D009AE1@gmx.de>
 <54057bef-4466-43cb-a832-4b904f03b559@gmx.de>
 <CAFLszTj0Ef1VQMA2nc7xN4i8hyZbkLVZ+gMyybSPKOcjfpy14A@mail.gmail.com>
Message-ID: <22301360-DB0C-4361-A3AC-658FEC35F382@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:72mXpeE1/4DpcmDi0+0niIEba60Gw9/v+Q/m8LcwASmvsC41gHj
 CBmCxuIk1Trr9Gfc1xFEV8J9+NPcg03TvcFRCrWhvu/esBF+iJv+YRHbSq7pEPhDozqfM1b
 607zSqIdD3vVXfv/n5TT6t63dlU3CTApv0OeYHDhTjvfJlCKuQ6Tp0cdw5TW7mXeMJkqN+7
 Gcw3FUzoVXW3jdFijaquQ==
UI-OutboundReport: notjunk:1;M01:P0:UFdkHJqhVOI=;kWNKy4cqPnn9LOXkHM+s0IZDK2b
 NATWsve4RSGFs9jejM88JzvtH77tJ7Ghaqi7BYUyV7PxTrtmC9VdKvLKiFehzWTMgYDXifVNH
 m19XxruCsm8Fy+YncP9sa1fLEZjtjMgCwKSzLgFzxNKE37Iw84qstAC7yT+Xm0xuj2PRiSGGs
 P3WRnRvOSHSS9tQlPGiv2vGGfUzd7unutKjmMaafdmaiuSn89wFYkuzW4VfS8cqiHOqt+UdLa
 HFnr9aAw4kgMH1V+oFSS1+aLl9Zq4cM9pKMArB5a5yLjaJFx7sENunfnz83l2cRc4pv+PgvuN
 Z3l5yivrS2UgPCdo5AemU2GsRkGzWGpHa8sTXPWEDsNcbUwh5FRvR5HKLRcyNyQQG0tCzmAh6
 LEqkloEjHfQFyfQ8/YfjI7Zqh4FfbhER3zoYKnZtUvNUBd2Qr+6D7vToWQ35jTFAhs26LdymQ
 H9qSNM+DG4gCXq+qW3sguHmJW10dufCHXH27QJxkGdRGntIeNAAdhoYb99lZAU1pkeNXcOuzy
 DKZRfQfp7gCOZ+xCd4efejIQIzH9GjjYlR6vylKzHAhDffIbxa6grk0wdvLe+qJUFV+uVmX1p
 LAo6+9MNMu7qtpTGrcp8fPQx4j7lnWZ3ffSRq1A1OK6C4FFIlB3CHwpduztI9W3qHHyfqamLL
 G2ywBlw+GGdplA3twHAC1bXR0BJhgjW13tSIynpS8lX2451RPTJVTHxtTtctKNA+mX7Vk4GYe
 Bgea9PotBgXawZCNhykdHf5uPXGHT1rN9O4+DjR/+1iL0MWHPmRKYxoIKychvziibJ6fGfaTf
 VZEju3h7nzh7F1MThepvD4i8v9TkLRPvdUZvUSZlH7Nns0mO+CdMx16u9LteZJwWlfoWyXyx3
 D8I0XvHrZ17MNq1H1DyLsEm0EKKTvK46wd6Ex/DxyzUEwYWPbDWZ5IfXc49joR2Vl3ZGa/ZPU
 +UcLd4C/bbUuayAUuY1lR0DBTio=
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



Am 1=2E Januar 2024 01:37:39 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Heinrich,
>
>On Sun, Dec 31, 2023 at 9:07=E2=80=AFAM Heinrich Schuchardt <xypron=2Eglp=
k@gmx=2Ede> wrote:
>>
>> On 12/31/23 16:56, Heinrich Schuchardt wrote:
>> >
>> >
>> > Am 31=2E Dezember 2023 16:25:43 MEZ schrieb Simon Glass <sjg@chromium=
=2Eorg>:
>> >> When the malloc() region extends beyond 4GB on ARM we may end up wit=
h
>> >> an SMBIOS table in that region=2E
>> >>
>> >> Add support for writing an SMBIOS3 table, which supports a 64-bit
>> >> address=2E
>> >>
>> >> Note that this problem does not happen on x86 since it requires the
>> >> tables to be placed just below 1MB in memory, unless
>> >> CONFIG_BLOBLIST_TABLES is enabled=2E
>> >
>> > The ACPI specification only requires that a low memory RSDP exists on=
 non-UEFI x86 systems=2E
>> >
>> > Nothing stops us from copying the RSDP only to low memory when not bo=
oting via EFI=2E Maybe that way we could have more common code=2E But this =
is beyond the scope of this series=2E
>> >
>>
>> Same is true for the SMBIOS anchor=2E You could have all tables in high
>> memory and only copy the anchor to low memory when booting non-UEFI x86=
=2E
>
>Yes, that's right=2E=2E=2Edo you think it is worth mentioning that, thoug=
h?

Reducing the x86 speific code is something we   should investigate in futu=
re=2E The current patch series looks good to me and hopefully will be merge=
d soon=2E

Regards

Heinrich


>
>[=2E=2E]
>
>Regards,
>Simon
