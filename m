Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC41D116E2
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C05EF843EA;
	Thu, 27 Nov 2025 15:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jSiCszVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421198439C; Thu, 27 Nov 2025 13:33:15 +0100 (CET)
Received: from mx-relay47-hz3.antispameurope.com
 (mx-relay47-hz3.antispameurope.com [94.100.134.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016AC8438A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 13:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0419b688bb=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=CIKuO7rkmS2jycqnLPgQsPWzZhKKNWKCMOB3H+rFGi4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764246792;
 b=tM952/8lCJu3tV3jxMljBgzaCEZ3bbkIJfangrwQJH5ySOmQISUIwGZM4xDFoiBZge8eL8gU
 yFQ/wmRuz5+cxW7EzYDl0rI32Ba/bZDd/P+iubrR5GE6X1AwQrfnyIfhFt+RhNHPfN/nGcQmDzt
 Es21xGf9m1soUtAfN17iNcFC6VwmgF0/40Wn2LgaI0OT+P251D92SX0tj5M+UD6rF0SNd6Aq5NN
 LX+AWL21KPwh5q87NtIOJlmcn7yxr5tcscg+eHPpyq33R2+LMAXx6g2l2hw67F8UCGsA1x//qNh
 7f7fPfu3uFzJ5ZeyxXTw+WsvsmMMluq8AZbzx5t+Ye+NA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764246792;
 b=WNOLJSmBEjPPoUPCV+KQstn/ZYtzEp7RSo/a+Mpg6u73bCJfOvwFxlvqdy+NtmwizmipTaRH
 Ui5cqEYbIiSPofUjrPy/TIT/pzMhCCJWUDYCfZ6NmHR4XZos4w9Sh610dE10MuTRJccnNHfC8TL
 k+DFaaT0/ZXDtfsuIVK+MP66ngUJLjVq+Uv5b30vRgZALx1k5DwzXDpMEgIfQ7MAOiqtERbr8az
 QHzsCDIi0P/PunwmztojY5AuBv8Ng5yb1+BuUtgTev2r0srb2QlwzmX9cxa1YntJGK3tMWHkvvV
 B6lJK8hS2rg29kbzpf/+SSC141AcF6wPBypM1Bf5PRatw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay47-hz3.antispameurope.com; Thu, 27 Nov 2025 13:33:11 +0100
Received: from he-web01-hz1.hornetsecurity.com (unknown [10.1.31.91])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 915315A081F;
 Thu, 27 Nov 2025 13:32:59 +0100 (CET)
From: =?utf-8?q?alexander=2Efeilke=40ew=2Etq-group=2Ecom?=
 <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20251126145621.GS2125796@bill-the-cat>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20251125161427.1155-1-Alexander.Feilke@ew.tq-group.com>
 <20251125163524.GQ2125796@bill-the-cat>
 <2db22e-6926d980-129-2e0bef80@48422766>
 <20251126145621.GS2125796@bill-the-cat>
Date: Thu, 27 Nov 2025 13:32:59 +0100
Cc: "Simon Glass" <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, "Fabio Estevam" <festevam@gmail.com>
To: "Tom Rini" <trini@konsulko.com>
MIME-Version: 1.0
Message-ID: <2fe6d5-69284500-3b-1b12cb00@46524667>
Subject: =?utf-8?q?Re=3A?= [BUG] silent hangup when debugging 
 =?utf-8?q?lib/fdtdec=2Ec?=
User-Agent: SOGoMail 5.12.1
Content-Transfer-Encoding: quoted-printable
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay47-hz3.antispameurope.com with 4dHG6g6Kwjz4MXxv
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: d039e2350952714abe15da9fec4d6d18
X-cloud-security: scantime:2.580
DKIM-Signature: a=rsa-sha256;
 bh=CIKuO7rkmS2jycqnLPgQsPWzZhKKNWKCMOB3H+rFGi4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764246791; v=1;
 b=jSiCszVPigaprN9+/ANuaLt9pJ0PPDWeyk9FqjQjVTy2FHgHJWAZuP4FdDIGW2FVL8pgRtIS
 TpuHv4VzqLiJGgsCnMQufjd5VOEhGZLvjA5iOO7uclaPW74Sm/gSvsvYYOLQe7UVWUm735EN+pd
 lpD7Mk+IjSBkw4edUIR38+KS73gjz8SVSZT7gh0h3tMH1YyO6V6vr5Mje/TuvbmWI2I4O1fhrUZ
 3vFbQhvMLBx1IFK/yscBSKCURdcaXuZHwaD4K1uRr9621ubLm/rtzgRfOCEX2sR6Y2JXsyFUGxA
 ezk4p9wZIYrwTUsGENP5eMU8X32U7sRbWkv/V3jvYXgRA==
X-Mailman-Approved-At: Thu, 27 Nov 2025 15:25:27 +0100
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

On Wednesday, November 26, 2025 15:56 CET, Tom Rini <trini@konsulko.com=
> wrote:
> On Wed, Nov 26, 2025 at 11:41:14AM +0100, alexander.feilke@ew.tq-grou=
p.com wrote:
> > On Tuesday, November 25, 2025 17:35 CET, Tom Rini <trini@konsulko.c=
om> wrote:
> >=20
> > > On Tue, Nov 25, 2025 at 05:14:12PM +0100, Alexander Feilke wrote:
> > >=20
> > > > From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
> > > >=20
> > > > Description: U-Boot hangs silently during boot when enabling DE=
BUG in
> > > > lib/fdtdec.c
> > > >=20
> > > > Not sure if its really a bug or rather a configuration issue on=
 my side.
> > > >=20
> > > > Minimal steps to reproduce: <see patch>
> > > >=20
> > > > The hang is caused by `panic("FDT overlap");` later inside the =
if block.
> > > > (see `lib/fdtdec.c:1279` in `fdt=5Ffind=5Fseparate(void)`)
> > > >=20
> > > > Additionally, no boot log can be seen because serial is initial=
ized after
> > > > loading the devicetree in this boot stage (see `common/board=5F=
r.c:665` in
> > > > `initcall=5Frun=5Fr(void)`)
> > > >=20
> > > > Tested on i.MX6 with configs for tqma6d=5Fmba6 and other tq boa=
rds that aren't,
> > > > mainlined yet (tqma6ulx=5Fmba6ul and tqma7d=5Fmba7).
> > > >=20
> > > > Any idea what to look for to fix this on our side?
> > > >=20
> > > > Thanks in advance,
> > > > Alexander
> > >=20
> > > For very early failures you might need to look at enabling DEBUG=5F=
UART
> > > which wires in a more direct "just write this to serial port".
> > >=20
> > > --=20
> > > Tom
> >=20
> > Thanks for pointing that out. The debug log shows that the global d=
ata is
> > still located in the SRAM after relocation.
> > Printing all variables involved in the panic condition shows, that =
the stack
> > pointer also overflowed, so there appear to be two separate issues.
> >=20
> > if (top > (void *)gd || top > (void *)&stack=5Fptr) {
> >=20
> > including top, sp and sys=5Finit=5Fsp=5Faddr for completeness:
> >=20
> > <debug=5Fuart>
> > FDT 8789d3a0 gd 0091de40
> > top 878a7aa8 sp 878543e7
> > sys=5Finit=5Fsp=5Faddr 0091ff20
> > FDT overlap
> > resetting ...
> > System reset not supported on this platform
> > ### ERROR ### Please RESET the board ###
> >=20
> >=20
> > Note: I don't use CUSTOM=5FSYS=5FINIT=5FSP=5FADDR so the default is=
 used. GENERATED=5FGBL=5FDATA=5FSIZE is 0xe0
> >=20
> > #define SYS=5FINIT=5FSP=5FADDR	(CFG=5FSYS=5FINIT=5FRAM=5FADDR + CFG=
=5FSYS=5FINIT=5FRAM=5FSIZE
> >  - GENERATED=5FGBL=5FDATA=5FSIZE)
> > #define CFG=5FSYS=5FINIT=5FRAM=5FADDR	IRAM=5FBASE=5FADDR
> > #define CFG=5FSYS=5FINIT=5FRAM=5FSIZE	IRAM=5FSIZE
> >=20
> > Do you have any idea how to address these two problems?
>=20
> Are there similar configs upstream? I know that imx6 is not generally
> broken, I boot my mx6cuboxi on current next (and master recently) and
> it's not failing like that, for example. Also, adding in one of the i=
mx
> custodians..
>=20
> --=20
> Tom

I can reproduce this with a build from master with our upstream tqma6q=5F=
mba6=5Fmmc=5Fdefconfig, after integrating debug uart:

<debug=5Fuart>
FDT 4fc78990 gd 0093de20
top 4fc836c0 sp 4fc00000
sys=5Finit=5Fsp=5Faddr 0093ff10
gbl=5Fdata=5Fsize 000000f0
FDT overlap
resetting ...

I also have a mx7dsabresd but I cannot bring it to boot with a master b=
uild unfortunately.

