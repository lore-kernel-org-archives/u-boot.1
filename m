Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B77CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D4387018;
	Wed, 18 Oct 2023 20:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697653090;
	bh=LKpAIEZKkgQjAHm0sk4jDl95K168/MmS3lYBkhOTMFE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c9N+tqzPH2AhQB4AD2uVhSW4vsuwHtvkpVGEPo/lqBLX8VB2CENQUrLHknDoPStgL
	 TYVlthql11kHf9WqnD7bc0BBWAjQN0ftyd+VQzsIBGvhKCU7WHPDP9l4weS/jzlRj9
	 gjqgjZSH6Dey08DmIEKF1w/aNVoZ+8TxpLZMTgS9EWOLO7+24Yw7QNZ601Z3Qs9LMk
	 w+ELowN8sJrI3WFxxVVN7JJEfIkPUxrzWI8hKOB1Vlc308pqFVEsn14n/udx7D8zOv
	 71pbcGXB5GGLs++cbhDz/YSWiC2ZGOZjl6s2/ZAOY/xBwWWOnsynycf6Ikzx9APoPh
	 kUMMBHftglSXA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EDC687028; Wed, 18 Oct 2023 20:18:01 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A936687024
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S9fGb3bSgz1sBq3;
 Wed, 18 Oct 2023 20:17:59 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S9fGb2F8rz1qqlS;
 Wed, 18 Oct 2023 20:17:59 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id CAUwSbKaROAx; Wed, 18 Oct 2023 20:17:58 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Wed, 18 Oct 2023 20:17:58 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: =?utf-8?q?S=C3=A9bastien?= Szymanski
X-Patchwork-Id: 1843177
X-Patchwork-Delegate: sbabic@denx.de
To: =?utf-8?q?S=C3=A9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/2] arm: dts: imx93-11x11-evk: add bootph-some-ram property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Message-Id: <20231018181801.9EDC687028@phobos.denx.de>
Date: Wed, 18 Oct 2023 20:17:59 +0200 (CEST)
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

> i.MX93 11x11 EVK fails to boot:
> U-Boot SPL 2023.10-00558-g65b9b3462bec-dirty (Oct 03 2023 - 17:40:10 +0200)
> SOC: 0xa0009300
> LC: 0x40010
> M33 prepare ok
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> image offset 0x8000, pagesize 0x200, ivt offset 0x0
> Load image from 0x44400 by ROM_API
> NOTICE:  BL31: v2.8(release):android-13.0.0_2.0.0-0-ge4b2dbfa52f5
> NOTICE:  BL31: Built : 17:52:46, Sep 28 2023
> That's because commit 9e644284ab81 ("dm: core: Report
> bootph-pre-ram/sram node as pre-reloc after relocation"):
> 	"[This] changes behavior of what nodes are bound in the U-Boot
> 	proper pre-relocation phase. Change to bootph-all or add
> 	bootph-some-ram prop to restore prior behavior."
> Fix this by adding bootph-some-ram prop as suggested by the commit
> above.
> Fixes: 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node as pre-relo=
c after relocation")
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DENX Software Engineering GmbH,        Managing Director: Erika Unter =20
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
