Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AC1D10F40
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7059184236;
	Wed, 26 Nov 2025 14:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="n7LPkjh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0964583F70; Wed, 26 Nov 2025 11:41:26 +0100 (CET)
Received: from mx-relay49-hz3.antispameurope.com
 (mx-relay49-hz3.antispameurope.com [94.100.134.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E680D83F2E
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 11:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0418545a05=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate49-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=RN0eUf+LNL+cY77fwHtiX5Yk+cz76kYtwHn6vGTqDQY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1764153683;
 b=F2tqWTDkBFiEjAi/mJyJ5bx6wm4lTPFTkMnaZdAjsQB7VjU4F3Fs0anx5aOAMis7dlycx9Q+
 Lg8+ZbXl0I2dNe/tOVyHrduE9/c6c+1jm6b9GrQn13byLUm8ExVtHk9x5SeZ8f4pqaI71w2x2ky
 uwZYF+hoVoNCjLA+eeVKQECNuqPMbb8WoptLiMwzFeaN6BnrVEASw50quwgIsS5bcguZIUTOXCB
 70sbqbEfRdd9Z6oSID3EABDgdOHl5P/p+xSX9oPPu3RdWEV/JlEE2vBsC5ZEFkBTWgoWrzl645/
 K9pIQ9J8eZd1KoyEfcvshKaEb97MNmecjI2/dyz70w3GA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1764153683;
 b=qoAzzJSVJbVxev5zp9ih7GE6j5Q3tzHrAzlXu78U3M5nzqaCMtESJrCT/2648SmzHxx+4tti
 tAbrub3S3Wa3O3/sPVgtw/iXPL2gkb1LkpZJOQCuVihI8fsCzoVCjXDIq9yFkSlWw7qMOHp5qpN
 2PtWZG1ySBcKrQDctQSz66cNUJbRbKePO6X1H1cKk0iRp6WZczBDqY0y/Zxm5FOumlPmKIUiWQp
 Pvow/Z2xqPF7SuE3RqUdtZkdivsNOTyH9kZe76wwluRp9KLiSubdVmixWcP+Lk7GnCZq/o5ed3+
 Gryp19ecMRna0bmcMgdgnDT+PXo0cC0sKyloUJKgLCRPg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay49-hz3.antispameurope.com; Wed, 26 Nov 2025 11:41:23 +0100
Received: from he-web01-hz1.hornetsecurity.com (unknown [10.1.31.91])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 87022A41379;
 Wed, 26 Nov 2025 11:41:14 +0100 (CET)
From: =?utf-8?q?alexander=2Efeilke=40ew=2Etq-group=2Ecom?=
 <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20251125163524.GQ2125796@bill-the-cat>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20251125161427.1155-1-Alexander.Feilke@ew.tq-group.com>
 <20251125163524.GQ2125796@bill-the-cat>
Date: Wed, 26 Nov 2025 11:41:14 +0100
Cc: "Simon Glass" <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
To: "Tom Rini" <trini@konsulko.com>
MIME-Version: 1.0
Message-ID: <2db22e-6926d980-129-2e0bef80@48422766>
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
 mx-relay49-hz3.antispameurope.com with 4dGbhB5ZX6z3yYmw
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 8bb1d2c7ae153f190c506527a427bbf7
X-cloud-security: scantime:2.013
DKIM-Signature: a=rsa-sha256;
 bh=RN0eUf+LNL+cY77fwHtiX5Yk+cz76kYtwHn6vGTqDQY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1764153682; v=1;
 b=n7LPkjh1vY9hvxUDqBo+QA+15XbGfiCLCENz6qWQHfbdcKsLHmipGS3gCmGkTIO7aNMUkjHa
 DNE75c7bn/X7RdgIr5/y9aCTO3+i6m7xvQ7U3bhSCVu88qMjACdqUtKpA9Rj8kN9r+lNa6D0yp3
 eCIONiNebgI5TJ5mcU5qkNDcyTeMzYlLyTO86wfwXOElMmf9K+saj43L5FQHZtFa3223j2Oab3N
 KqMdl3BUNT+r+gJRtgBF3kEjg/F72ErBAut7C8oyROUMTvVpASeAfO22lug64yE7qd/tsJAryKE
 XiKnfGmsSzfcg9yWNeJjVltcbTcJMTYKTrYSblQJ9exZg==
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
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

On Tuesday, November 25, 2025 17:35 CET, Tom Rini <trini@konsulko.com> =
wrote:

> On Tue, Nov 25, 2025 at 05:14:12PM +0100, Alexander Feilke wrote:
>=20
> > From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
> >=20
> > Description: U-Boot hangs silently during boot when enabling DEBUG =
in
> > lib/fdtdec.c
> >=20
> > Not sure if its really a bug or rather a configuration issue on my =
side.
> >=20
> > Minimal steps to reproduce: <see patch>
> >=20
> > The hang is caused by `panic("FDT overlap");` later inside the if b=
lock.
> > (see `lib/fdtdec.c:1279` in `fdt=5Ffind=5Fseparate(void)`)
> >=20
> > Additionally, no boot log can be seen because serial is initialized=
 after
> > loading the devicetree in this boot stage (see `common/board=5Fr.c:=
665` in
> > `initcall=5Frun=5Fr(void)`)
> >=20
> > Tested on i.MX6 with configs for tqma6d=5Fmba6 and other tq boards =
that aren't,
> > mainlined yet (tqma6ulx=5Fmba6ul and tqma7d=5Fmba7).
> >=20
> > Any idea what to look for to fix this on our side?
> >=20
> > Thanks in advance,
> > Alexander
>=20
> For very early failures you might need to look at enabling DEBUG=5FUA=
RT
> which wires in a more direct "just write this to serial port".
>=20
> --=20
> Tom

Thanks for pointing that out. The debug log shows that the global data =
is
still located in the SRAM after relocation.
Printing all variables involved in the panic condition shows, that the =
stack
pointer also overflowed, so there appear to be two separate issues.

if (top > (void *)gd || top > (void *)&stack=5Fptr) {

including top, sp and sys=5Finit=5Fsp=5Faddr for completeness:

<debug=5Fuart>
FDT 8789d3a0 gd 0091de40
top 878a7aa8 sp 878543e7
sys=5Finit=5Fsp=5Faddr 0091ff20
FDT overlap
resetting ...
System reset not supported on this platform
### ERROR ### Please RESET the board ###


Note: I don't use CUSTOM=5FSYS=5FINIT=5FSP=5FADDR so the default is use=
d. GENERATED=5FGBL=5FDATA=5FSIZE is 0xe0

#define SYS=5FINIT=5FSP=5FADDR	(CFG=5FSYS=5FINIT=5FRAM=5FADDR + CFG=5FS=
YS=5FINIT=5FRAM=5FSIZE
 - GENERATED=5FGBL=5FDATA=5FSIZE)
#define CFG=5FSYS=5FINIT=5FRAM=5FADDR	IRAM=5FBASE=5FADDR
#define CFG=5FSYS=5FINIT=5FRAM=5FSIZE	IRAM=5FSIZE

Do you have any idea how to address these two problems?

Alexander

