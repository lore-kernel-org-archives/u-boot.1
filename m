Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C3EC7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 07:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFAE80C83;
	Fri, 20 Jun 2025 09:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="XPkSBL5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1A582C55; Fri, 20 Jun 2025 09:28:25 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A4B48006D
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 09:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3CE581FBD6;
 Fri, 20 Jun 2025 09:28:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1750404502;
 bh=nBa8sFqtkOHZ+L+9f5aR4M9GO+Swq6SNSzQJl3vvOok=; h=From:To:Subject;
 b=XPkSBL5TtalhqhT/UUbgvTTIlH2LRoRdKS9V+FFmwMZc7kiFcPyzOEOpoh1EiXBoP
 XVY1lVroirYlWSNoq/78Nw8t4hdEF4+fowMWO7BGkM+y/utGjI3jZDpmVfO1IKiukS
 /EVnpR3QZ+6ohDWBHc6u5PvoYoREKxUSu3XiF2kcUt3aeg+2mOhFE9Fr8KXWzTNXS3
 h3ZIh6Lfx3dtTiiGdmz08+5u/ZLbvzmVv6QU4kcpiGSRPTW+M7GGAvilgyt7C4tXUR
 ZNE1c+AyPIGr0+dBva+HCp+l2Nez1PHd6jqLn65xZEL9YNdt5n7CvSORwmYI5O5EsN
 s8ABlJSe5c1tw==
Date: Fri, 20 Jun 2025 09:28:16 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>,
 "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 Enric Balletbo i Serra <eballetb@redhat.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 0/8] (no cover subject)
Message-ID: <20250620072816.GA5437@francesco-nb>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
 <CAOMZO5CpcBTKQW4O6qFH4TgvsBBzmud1MQOEtz1i0V3UApz-sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CpcBTKQW4O6qFH4TgvsBBzmud1MQOEtz1i0V3UApz-sQ@mail.gmail.com>
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

Hello Fabio, Alice

On Thu, Jun 19, 2025 at 10:01:52PM -0300, Fabio Estevam wrote:
> On Wed, Jun 18, 2025 at 4:30 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wrote:
> >
> > imx: update the building bootloader image related part for
> > i.MX8QXP, i.MX8QM and i.MX95 B0.
> 
> This way it is written above it looks like a cleanup, but if I
> understand correctly, there was a bug report from Enric, so should
> this entire series target master as a bug fix?
> 
> Francesco brought a good point: are other imx8qxp/qm boards affected?
> Could you make the fix to all boards?

I have not looked into the details myself (no time, sorry), but I
had a quick look at our CI and current master U-Boot is able to boot
on both apalis-imx8 and colibri-imx8x.

```
U-Boot 2025.07-rc4-0.0.0-devel+git.a239cdc0bd4b (Jun 17 2025 - 23:21:42 +0000)
CPU:   NXP i.MX8QM RevB A53 at 1200 MHz - invalid sensor data
DRAM:  8 GiB
Core:  161 devices, 19 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial@5a070000
Out:   serial@5a070000
Err:   serial@5a070000
Model: Toradex 0067 Apalis iMX8QM 8GB WB IT V1.1B
Serial#: 15543176
Boot:  MMC0
Reset cause: POR
Build: SCFW 83624b99, SECO-FW 7d5462e6, ATF android
Net:   eth0: ethernet@5b040000
```


```
U-Boot 2025.07-rc4-0.0.0-devel+git.a239cdc0bd4b (Jun 17 2025 - 23:21:42 +0000)
CPU:   NXP i.MX8QXP RevC A35 at 1200 MHz at 33C
DRAM:  2 GiB
Core:  110 devices, 21 uclasses, devicetree: separate
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
Loading Environment from MMC... Reading from MMC(0)... OK
In:    serial@5a090000
Out:   serial@5a090000
Err:   serial@5a090000
Model: Toradex 0050 Colibri iMX8QXP 2GB IT V1.0E
Serial#: 14986935
Boot:  MMC0
Reset cause: POR
Build: SCFW 83624b99, SECO-FW c9de51c0, ATF android
Net:   eth0: ethernet@5b040000
```

Francesco

