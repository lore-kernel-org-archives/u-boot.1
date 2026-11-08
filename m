Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5D606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Na72GWQ7;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=wCWXwv3w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEDE36065F;
	Sun,  8 Nov 2026 08:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DdHRKT705dxP; Sun,  8 Nov 2026 08:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC17060601
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794125073;
	b=U+MPTLcYb/Mbs49nGTD88uYc5EWV98Y6DonNU3/LxBJrJvkcmTYlKi7pKCHe46/iAp7l
	 YDlPnyiH62a/hbRHjD2cdDMD4HsXvJw3zWEJs5aK85o4wsec+AGGpSNyHwIGDo66Oj2Xe
	 93YGPPz6NvQdPsyQi19N/U5Q66le/a+odHWg57d2ikE4qM4c/trH1DhBdjbNVA5U1Ta6V
	 y+2pTZ6EMJr2VVp0A4m8I31Ni7Zkl4jQX+kzAVudz1woCLuABhLXIbTizIF3meZN89dVA
	 BcBn2nrpZT3Tpjzibwk7gW3onFO8Mmp6CDNfFYTd684PtugXDPNxk53r/Mh9Og6amGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794125073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ytF6CUt242rKnSbkipfx1IFzUwk5x0G88iWqw4jOV5Y=;
	b=LyJGSQDx4K7Q7vNWXvD9taeTUBbgxcijY6H2alh1U/dgoebvOX4BWQDsW0y03QmOinPg
	 1QYPCae5VgD3iEWvBr2+sRoWOrUyEuF5EflgdEuVVnp1YU8Y5VrT1aqExoRs6DPqrs//m
	 TBSBV66/vYD+qMc9ulskc+gTwesiMTtrWZNr0fgyF7jgGDQzQ7hjl5/lH6ti9S/HuodHR
	 i+Fh0DjMvMQ+tShAeBQEsdmJbxbbaF4BdmNKQ+jO3Web088L8mUl/AVOWcCTW7BVUINWF
	 A6vSYOob3l/iinsZkeGYQlMIi1vzMggW8B8PsA6DkCOAcq8+xszZVbtWU/MUm/kFD0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794125073;
	bh=ytF6CUt242rKnSbkipfx1IFzUwk5x0G88iWqw4jOV5Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Na72GWQ7t+I3IgGQYyydbfeaqqqDIX+66JYz1x+BpUUieF2n6O+gr3ZwG+pN9751w
	 TIzo8MlRYnHD9/5nclvUFlV1VTbzKYxb0rukcHucpkB/a7mVgKJRw3ulDeGWGb0n7d
	 umIVoJDW6n8DBNlU6wwGEpP2I281Y/jE9KoS11+sQKv9AW6CuLYeSrJM673pINB8ez
	 cUdi/wDSVspsebMlJrRnO2Di+kwVtYtyLS4MEDICLz1RdxhA/b3KbKN9WlzOCMTfMG
	 +gwSGCfF9s1mXDBRtz3d9OAxiqAmGLdr013o++RX1SPh1WW/Gcv07dNIPV+2CEK+f3
	 Pf14zr3xrp1TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC17060601;
	Sun,  8 Nov 2026 08:04:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C34C2FE
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 08:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E4AB4061A
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 08:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7fsMRtrLHBxK for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 08:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF3C140609
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:96:8a00::1200:5b3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:96:8a00::1200:5b3; helo=mxc-3-5b3.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=wCWXwv3w
Received: from mxc-3-5b3.seznam.cz (mxc-3-5b3.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:5b3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF3C140609
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 08:04:27 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxc-59f7fd7d85-bz2kn
 (smtpc-mxc-59f7fd7d85-bz2kn [2a02:598:96:8a00::1200:5b3])
 id 42e4b944bc100bee426a375c; Sun, 08 Nov 2026 09:04:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1794125063; bh=ytF6CUt242rKnSbkipfx1IFzUwk5x0G88iWqw4jOV5Y=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=wCWXwv3wBffYdr3O9od4PEf0W3KPApqxbvbs6g619MF+mOdZJk+Z/ZgidNWlqQHKN
 SFGU8BIc9YZc8tWqe9SVWfG2ndlDgy6wnfrmpRqBBIWFA7JBmw4WdnePS3pGbvbIGU
 /ZHPUTQ/UkUXrDo2Wq5Rwb/uzIyWWhfjUGn+4Cf/VTDmdqpT6Q2GCBHA/bVdcmh47e
 hS/r/Sbvnv0YX43f0J6/SQ4zcM8bbLsIQmMPUf9ggDcRScCPraYLeaoQFhABE1Ml6c
 Tt+PvGMM6RL4pAqQhLq6JHwTe+Zu/7rgc9tmBmo0P0EGvGr5L0YGJbpmqiW3gTQ/Pg
 UWWovH/zyVc4g==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Sun, 08 Nov 2026 09:03:35 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Stefano Babic" <sbabic@nabladev.com>,
 "Fabio Estevam" <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Peng Fan" <peng.fan@nxp.com>,
 "Ye Li" <ye.li@nxp.com>, "Alice Guo" <alice.guo@nxp.com>
Subject: =?utf-8?q?=5BPATCH=5D_imx9=3A_soc=3A_read_the_SoC_information_aft?=
 =?utf-8?q?er_relocation_with_SKIP=5FEARLY=5FDM_?=
Date: Sun, 08 Nov 2026 09:03:35 +0100 (CET)
Message-Id: <1Bx.ZqLe.4vhwbiJKX2M.1gy2pN@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

imx9_probe_mu() reads the SoC information (type and revision, lifecycle
and UID) from ELE before relocation only. With CONFIG_SKIP_EARLY_DM there=

is no driver model before relocation, so the information is never read
and gd->arch.soc_rev stays zero. get_cpu_rev() then returns a bogus value,=

is_imx91() and is_imx93() are false and e.g. the FEC driver accesses the=

reserved MIB RAM registers, which ends with an SError on the first network=

access.

Read the information after relocation if SKIP_EARLY_DM is enabled. The
data cache is enabled at that time and ELE writes the data directly to
the memory, so use a cache line aligned buffer and flush and invalidate
it around the request like do_ele_info() does.

Tested on an i.MX91 board with SKIP_EARLY_DM enabled.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 arch/arm/mach-imx/imx9/soc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c=

index dcf2fff1aa6..b7e90e160b5 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -9,6 +9,7 @@
 #include <cpu_func.h>
 #include <init.h>
 #include <log.h>
+#include <memalign.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -742,7 +743,8 @@ int imx9_probe_mu(void)
 	ofnode node;
 	int ret;
 	u32 res;
-	struct ele_get_info_data info;
+	ALLOC_CACHE_ALIGN_BUFFER(struct ele_get_info_data, info, 1);
+	ulong end =3D (ulong)info + roundup(sizeof(*info), ARCH_DMA_MINALIGN);=

 
 	node =3D ofnode_by_compatible(ofnode_null(), "fsl,imx93-mu-s4");
 	if (!ofnode_valid(node))
@@ -752,14 +754,18 @@ int imx9_probe_mu(void)
 	if (ret)
 		return ret;
 
-	if (gd->flags & GD_FLG_RELOC)
+	if ((gd->flags & GD_FLG_RELOC) && !IS_ENABLED(CONFIG_SKIP_EARLY_DM))
 		return 0;
 
-	ret =3D ele_get_info(&info, &res);
+	flush_dcache_range((ulong)info, end);
+
+	ret =3D ele_get_info(info, &res);
 	if (ret)
 		return ret;
 
-	set_cpu_info(&info);
+	invalidate_dcache_range((ulong)info, end);
+
+	set_cpu_info(info);
 
 	return 0;
 }
-- 
2.43.0
