Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D8AE9E30F
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 14:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD8783A47;
	Wed, 11 Feb 2026 15:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NnOUuisC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 974FD83A5A; Wed, 11 Feb 2026 15:30:21 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6784883015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 15:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-94ab69af6c8so527815241.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 06:30:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770820218; cv=none;
 d=google.com; s=arc-20240605;
 b=Ynfj+wvd0RPkuCFcFRDocJiR2VUbI4/RceBNw9eFKwfnuiXC2/9mlwWQQEIpoQHyEi
 Feaqo8/YG5PU2VbYDvBei3OPhFGOzw1xdOBhRY73wz4+pxa8a8TZyRscb506tu8EOfv2
 kK3c3E7pnf8EoXjnke4IPr0ePGt9Jw1fGmkHEfDCBs2rhJtofDy5a7A8KApfV6pL5CS9
 2jzSiGdI2HJw2lCsSmAERv+ktYOQfj+LrfUm5SgF0MTk5s+1lGm3gOICAVqjVJUfW//l
 crpimqFbhxhP7ZeIUacAxw3pt2oGDH7FFbm0hmIkIZJj36rWamB1OPLZYL6bjbEE76R1
 M9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LU+Yzjdd0UvtSuphi9amYCZI1NykC9RJObyD/Wk8tCE=;
 fh=D/ePnVBOyQPDnq87C+r5ZXDXxyREYv6WnYagZMJLnVk=;
 b=JDUIBcb+H5kNetOK9TdDNo/RpcdoRxl3z1d61/pEplCR19qD/5yUVceV4CfNsFiezE
 CEpl/qAaOTCWomKpVabzOTxfmYlVeIYmssFkHbjzSZfOh1XBXYIr+vvCyX9kVfTRVJPX
 EMYllqz989lMKQynU5D/F7LVLe8YsVWESJ6a5xhRGbZhKorLxMzE1MSrisTLdK+qGh1x
 hi3mpwMYZyQPhXXU7jPBRGhyTrWyGDai1sITJPbGnS+p5Sgca1IEfIlG8UisKzl7uzij
 RVcVf8F5VZ6wShdcvRNHYLF1w8VpmdPdtSr4xskKpqY2+th1IXE4Qk7nboFa895vbyEY
 guvw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770820218; x=1771425018; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LU+Yzjdd0UvtSuphi9amYCZI1NykC9RJObyD/Wk8tCE=;
 b=NnOUuisCXMgXbenpUy+vlsNAUlNzVGX+ZZKCtyiJAYJ7H24kCGlkxNYrvjZMbz7pap
 OQdFuyxJeE1fg663v8n3eaqrs9BwIgUxuYqf4XDe1uTPZX5N1AaiinnahfZpAiZF1TpZ
 dEZOj/0s05BFx2UWms0jgql96Duzr9Ga6toYcAr+TXW9l386i+RyWxtfU6NN3vGwLRbU
 yMlWB2x5fIYigUKJ/0Wki5Qvudl+Cuw/mC5+I8VZ1aTKaLHuozBmkykfVsH6D9lujV3o
 fkMViSe7C/3PTNlMBY7E4FQcMxVl6t6ZjxRuYArAPoBRmnMsrG55i7MLFq3Rrs3NL+z1
 4ypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770820218; x=1771425018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LU+Yzjdd0UvtSuphi9amYCZI1NykC9RJObyD/Wk8tCE=;
 b=HsGCKD0/043YFx8iEqDht0loqP7nr/oWEMnXxQRIKLcmOOqkI8WNSrauoKOndW7R5M
 OX/OhQ0LqPRlcVfBvG4DrBoN65PkLREHxLTiOCJrPYYFOoxSLacx4I8ChoqFHDAUL6Ck
 WlLBvcEarhtmB/8mPk2KaLq4lGgOlnSpRLop/5fMmPmRIoC3Bj1hfJ3fEAAM/7Zc78iL
 FcJT4/ixppuRIR6DSg3ng6pWb1hThb5VYTX2GGQw5LJXXgV8wlPvPwPjRZBMjpfY5waI
 Y8z+bfrrD2QCiw7PY3mgrFfZHrlZgMDD/muD/1bexQ78bWv+hNJTS/tbErlDK11z6lfW
 tv9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV280LebOlQCf3NihC5JPpND3hsdvZqE0tdYyrfMSuTzl4c5G8uhmKIPyoOxm4jJjNOGIUdQSE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8rVyd18DXy04B1vJB40IfiLTSbZFC2IRdH3709V3P+nVzz82u
 0k/Ms7oqSbOQiLGIQJFaI6SFfBA6gte58tqLBoLvTOKKO7RVfSLCbNpB/il0QiM1rfos4AGjHc8
 ebNioAxv1bBrFMJBTPdPSZI8dLNhvTrI=
X-Gm-Gg: AZuq6aIMXTo+qMMofIoBqIa+BqkixXtZJKYsDKpCluVaGO6oAfmqxDopAjAheysDzFE
 As8fNwV+g8kBoQiZWb9A+2YKvRGKz23pMAOfQKwCf6RrsN8NVuZ02jD7B3JvbEuu2D8YpKEGp08
 kVHl/ir+FIz4eBWOxvf58IXyaSmmz7hKbr8QlDdMN0o4JugHEvSuVQ+jlB0GKQRfAktTVJjUXCs
 jtYagGkUwoF1cJlsQE7kAh6mfSdw1hPot5ikGf1AREvn/kBf69v/o52uviOqaiRB0a9dNA50uJS
 N39/1T56IVWcSMFmQpE=
X-Received: by 2002:a05:6102:c08:b0:5f1:b69b:f9e3 with SMTP id
 ada2fe7eead31-5fc46e85a9fmr2105667137.12.1770820217821; Wed, 11 Feb 2026
 06:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20251128163535.2301653-1-raymondmaoca@gmail.com>
 <CAMDkj5zb1qhAR-uf=trSsGEwXmx5TiXc=agX5w5GnjMrP_Nqyg@mail.gmail.com>
 <20260204161345.GY2603314@bill-the-cat>
 <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
In-Reply-To: <CAC_iWj+qEmxNeGVBcLcrzNM=BkVj0QW2VYW6ZNGTKD6BeRTNHA@mail.gmail.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 11 Feb 2026 09:30:04 -0500
X-Gm-Features: AZwV_Qh9kQXgOkummiMw8RQCf13MHbmeNz3KXvS84xsqan2KKlbyADMXJXC0A10
Message-ID: <CAMDkj5yg24MwQz4G8Y62S7mB_6D=p+0Qrooe77RKQ+C4CPwA1Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Implement all missing SMBIOS types required by
 distro tooling
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ilias,

On Wed, Feb 11, 2026 at 4:32=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> Apologies for the late reply.
>
> I did test the patches but I see something weird on smbios type 17.
>
> Handle 0x0008, DMI type 17, 104 bytes
> Memory Device
>         Array Handle: 0x0000
>         Error Information Handle: Not Provided
>         Total Width: Unknown
>         Data Width: Unknown
>         Size: No Module Installed
>         Form Factor: <OUT OF SPEC>
>         Set: None
>         Locator: <BAD INDEX>
>         Bank Locator: <BAD INDEX>
>         Type: Unknown
>         Type Detail: Other Unknown Fast-paged Static Column
> Pseudo-static RAMBus Synchronous
>         Speed: 512 MT/s
>         Manufacturer: <BAD INDEX>
>         Serial Number: Not Specified
>         Asset Tag: Not Specified
>         Part Number: Not Specified
>         Rank: Unknown
>         Configured Memory Speed: Unknown
>         Minimum Voltage: Unknown
>         Maximum Voltage: Unknown
>         Configured Voltage: Unknown
>         Memory Technology: <OUT OF SPEC>
>         Memory Operating Mode Capability: None
>         Firmware Version: Not Specified
>         Module Manufacturer ID: Bank 3, Hex 0x04
>         Module Product ID: Unknown
>         Memory Subsystem Controller Manufacturer ID: Unknown
>         Memory Subsystem Controller Product ID: Unknown
>         Non-Volatile Size: 16383 PB
>         Volatile Size: Unknown
>         Cache Size: Unknown
>         Logical Size: Unknown
>
> Any idea what <BAD INDEX> and <OUT OF SPEC> represent?
> I tested this in QEMU
>

I just retested it by below qemu cmd after I rebased it to the current mast=
er:
qemu-system-aarch64  -bios u-boot.bin -machine virt -cpu cortex-a57 -m
2G  -nographic

Below is the type17 I got:
```
Handle 0x0008, DMI type 17, 104 bytes at 0xbe678141
Memory Device:
Physical Memory Array Handle: 0x0000
Memory Error Information Handle: 0xfffe
Total Width: 0x0000
Data Width: 0x0000
Size: 0xffff
Form Factor: Unknown
Device Set: 0x00ff
Device Locator:
Bank Locator:
Memory Type: Unknown
Type Detail: 0x0004
Speed: 0x0000
Manufacturer:
Serial Number:
Asset Tag:
Part Number:
Attributes: 0x0000
Extended Size: 0x00000000
Configured Memory Speed: 0x0000
Minimum voltage: 0x0000
Maximum voltage: 0x0000
Configured voltage: 0x0000
Memory Technology: Unknown
Memory Operating Mode Capability: 0x0004
Firmware Version:
Module Manufacturer ID: 0x0000
Module Product ID: 0x0000
Memory Subsystem Controller Manufacturer ID: 0x0000
Memory Subsystem Controller Product ID: 0x0000
Non-volatile Size: 0xffffffffffffffff
Volatile Size: 0xffffffffffffffff
Cache Size: 0xffffffffffffffff
Logical Size: 0xffffffffffffffff
Extended Speed: 0x0000
Extended Configured Memory Speed: 0x0000
PMIC0 Manufacturer ID: 0x0000
PMIC0 Revision Number: 0x0000
RCD Manufacturer ID: 0x0000
RCD Revision Number: 0x0000
```

If you didn't use smbios_generic.dtsi to insert new nodes, or add new
'memory@' / 'memory-controller@' nodes into your DT, you should get
the same result as mine by default.
If you still can not get it, can you give me your build instruction
and qemu cmd for reproducing?

Regards,
Raymond


> Regards
> /Ilias
>
> On Wed, 4 Feb 2026 at 18:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Feb 04, 2026 at 11:12:42AM -0500, Raymond Mao wrote:
> >
> > > Hi,
> > >
> > > Anyone have a chance to review this patch set? It is the last piece o=
f
> > > work to support all required SMBIOS types in U-Boot.
> >
> > I've been waiting for Ilias or Heinrich to have time to look at this.
> >
> > --
> > Tom
