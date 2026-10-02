Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F9CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2776881458;
	Fri,  2 Oct 2026 21:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-Qhsy46MGzG; Fri,  2 Oct 2026 21:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E5728144E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976685;
	b=mKnGK7rPo7uSrEofUbl7IOSp5e7rDGJZB7CQVRKiQgylPaHwPy/IEnufngt2at0u1fED
	 9V7t+lP1jBiB8g2KrVkxYvDnHdOH/BDiv0AmF3qaSx/H/DseGgq+S2RF/+PQkwiM0FTah
	 IGvXDq6iozhpiDc5tW4gW3IftD8Z+8PjwllyhuKs/5t5fuCF2Xo9B4G698LIYZz30L0vp
	 wUcF0dyVZystzj7SgZG/KALaGaXuszsPUZrZoghmBAhpSL/TohS+R7979r4AgkyzbQctF
	 iZmMyXXLBJS5q7dmXj6myKV4Ivt3AvpTORWxcAZjuGwNbal+YO5XCIJoX1fbDtFZrUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+0Fqrru3eXGylqSeI1mUcyFd8I6oE1IfU/NYrESckbg=;
	b=PsbsQroKLLqS4TPwBc7T+ORDfl0wqONNI6D35MhCf9ce43WBQxMTR7ZfiriR53fDOKAx
	 V2GAkPZ/b/EhGeuNp/0Gs8J97zhVgprdR5RyntlTJB7FEykCNvBlTJskR29hUrohIow8U
	 WKcolIHzYPGQA5rURq3Yjf4ZXyW6d4DNUpIJ8COk8tMj9KQ4jwyB5VyjTr9tdRgiI8yYu
	 fFdU29bDVQDiXELHI0uD6PdHMCmTX6Sk48uICQ0TOR/NJRn2fSugDF1nAgm+XQJGgfRib
	 KrxCfloseY8UN3LZE4RmWc3gUzOUolhMfeLOSs0yYr9PqF1d2Abh32/nF4hmgJnsOew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976685;
	bh=+0Fqrru3eXGylqSeI1mUcyFd8I6oE1IfU/NYrESckbg=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eR8jWs7i8ivqZdLKA/8wGW5i96ru5BuwNPpbNMxPZCvm8xpxb/5MJNEBFi6OixW5V
	 ZFymY4Up0afRDm6TPbBPyHzpXtrNGwHjuI+whX38abyrxq8o0//39MudS3GluZ4CCt
	 08UeaN/cfaTDr0Z18fPs2sFH20UX9axj4ddup0IIo4iM7Pp4AziVO6j5vRGOLTnMi6
	 2/ebi+BsCLrJu2dJUMCMjY1xO3zebuY9qXmwhLdVTCZvnJHOz6XVma9i3Py+F8coqW
	 ImZnFEkq22tETf2SlUTrMUFse8jlQqslppmAujxs0e7IrJDcbitFuI17iWZJXgKl4V
	 UCEWYkZBhN5LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E5728144E;
	Fri,  2 Oct 2026 21:31:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B14FC34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9789860D92
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WC7Mo2IJbv-t for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ED1C760D70
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976655;
 b=Nvc/MeGtSX/Ud9Y8C4S3E/o/6Un6gvo00o4V42OMysm4crH2h2BYIvWDY5+sEJBzNlbw
 VYkXmZ72VEIXwW+kkfStBN6hy1frch/ruuD9gN2uUdUxUy59lX67l7pvcPOO4Ug6+9ZCu
 a7wiVuH/pNywLZgudhh5vLO9mMqQRE+85EE9/6RHiy6YgDMSp5YO2lz1cyuXGAYGztxDR
 lE5L4VFt0SYAt0uNVH5SdzXaoJ/aR7dkCgF+b4e+DSzAJg6cTnY4uCAixCJncncx0yi/r
 7Gq/zgodvumr6iKlB0r0Y0wknUQzYItjCJH2oR89cX/81WN3yUHEjpq7eQGKLEdzsEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976655;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=+0Fqrru3eXGylqSeI1mUcyFd8I6oE1IfU/NYrESckbg=;
 b=DY6N6laBoFrLnZ4tJRUD7u4xFG4NCMNXaKR26ZLcmmrrQrkbI53Q9HznJACKb9zuzyBA
 fDHkHUR5oSqRKNoYXif3GM5J0fF6l+lbbYAeNVgP2otTT7OnsALJEq+QjFro+gK0+2ruF
 C52G6XGFd4UyEu6qRj/4RlhGT/QVK0CFBr8+MDQe2RwCd7JmU6DngYHhBLVMh+cloNYNn
 YUtkeuRrynioUBMNgScEMFUMcLNP9BZf7cz+zIMLCF1baWDGdyQwbQ2BJz1/CAMKCXpHJ
 H5N9DVXio2k8+NAUuwDof58BPRebGje/57DcM4dKkxrttmDydC2LMSZOQMPUjIz1irg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=hr0QDjrp; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=hr0QDjrp
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED1C760D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976648; x=1791235848;
 bh=+0Fqrru3eXGylqSeI1mUcyFd8I6oE1IfU/NYrESckbg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=hr0QDjrpED0nqQ8EtnnyUSa6rSsdxAxtAnlvDuChKv/YcIwlxpEsQOPgf7MKlX0XZ
 LZgVfqgPt/UGbNEm24oPV67epXK+UFBINQ6qsr3h2d6d80RhNH0OkUsO1u/ibBNP/Y
 xEc3Yx8fh0OR82NdeqOXtLitYDOsAONqCMy67X4T3fMNxwGmtD4/k8qSIL3rTpcwG8
 bB/JxI5xU8IpIOKmLWLOS4PMFzrXxBxTynqQRalvWbSOU+MnZB9V8kKzkRbf4CDsNK
 35GBMS1Ncb6bG8C6iEcUrwszKDKC9vBWlQV/cmUS+rCQM2tXBfJI/mDi3WnAx9NFzx
 n4UmTVG+92Z7w==
Date: Fri, 02 Oct 2026 21:30:42 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 2/9] pci: spacemit: hold the PHY interface in reset until link
 start
Message-ID: <b8f3a43efb9393b4a852c1d8ee9674e7c8a2a894.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: d0e233ce333a987d3364dd3703f36b3e26af3863
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The probe sets APP_HOLD_PHY_RST and clears it again straight away,
before the PHY is initialised, so the controller's PIPE interface comes
out of reset while the PHY is still unconfigured and its PLL unlocked.

Linux's pcie-spacemit-k1 driver sets APP_HOLD_PHY_RST at probe and
clears it only in start_link(), in the same write that sets LTSSM_EN.
FreeBSD's spacemit_pcie driver, which runs these controllers on the
OrangePi RV2 and R2S, does the same and notes that releasing the PIPE
interface before the PHY is ready leaves the LTSSM stuck in Detect.

Keep the bit set through PHY init. The write that enables the LTSSM
already clears it.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 7ca5a5ad1a..04b3161e94 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -245,12 +245,14 @@ static int pcie_dw_spacemit_probe(struct udevice *dev=
)
=20
 =09ret =3D generic_phy_get_by_index_nodev(port, 0, &phy0);
 =09if (!ret) {
+=09=09/*
+=09=09 * Hold the PHY interface in reset through PHY init; it is
+=09=09 * released together with LTSSM_EN when link training starts.
+=09=09 */
 =09=09reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE_CMD);
 =09=09reg |=3D DEVICE_TYPE_RC | APP_HOLD_PHY_RST | PCIE_PHY_LANE_CTRL_MASK=
;
 =09=09reg &=3D ~GLOBAL_PHY_RST;
 =09=09spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
-=09=09reg &=3D ~(u32)APP_HOLD_PHY_RST;
-=09=09spacemit_pcie_writel(pci, PCIECTRL_K1X_CONF_DEVICE_CMD, reg);
=20
 =09=09ret =3D generic_phy_init(&phy0);
 =09=09if (ret) {
--=20
2.55.0


