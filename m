Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADD7CA5FE7
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CEEA813A1;
	Fri,  2 Oct 2026 21:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IZgrlzIsMjc5; Fri,  2 Oct 2026 21:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 67528813DC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976726;
	b=Ld4xXGNkRvGAg9FTtPFIk06eIrAj3v2vgEcPXScB+wr09Nzt9AHegxYPCA00fYm5kmMW
	 N09fljRHfOzZ2Wfxk6+vw+8o9NQRoCwKy6o9HLELolagQfV/a6rIp8mO1uK/HvzMOVqfw
	 197M9n2F9mOxFgcYr6V7IKtVxjpZ7hv/8yTVvASyohGNagYgvSx8ShUIz+1XyXqT1l3jH
	 LKqCpc3BmcVsAHTNdAb5zNLsM4UjzCiO0BozKLR5c/hAxkzBCGXgot3p/os6TEXdVS5aI
	 gfNL21+u+OMdqasBQTNCQ9TVVSL0NXn6hXIE6GO42NBq3A6QZkWj8NVLwW6QUa5699g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/AhhOsrIDb2DoQlbCPExs8hTAp5nXUh3JvmqgvlBmTs=;
	b=g0br5Z3XiAEw1JCnceTaoLthQKMshQK1hUyDtC/TQPCt/Hhmu3Pu3q0g2OZRgPK5bLbr
	 5wvXIW0wAXszYArVHZ/SrzMQEqQC/Z8mWsqn/ljqfBlsCQsCjf0wl7WI50roZCJv/ACow
	 +FxOJLIENK10THCJMPABc/6KAF/1IoKBc+ilFyU//j8DjXJdHQiDJsCVumluSNgdfQGQG
	 KRoErmv7JPDog+aLISiOR7mT7ui3p+Y3KDqO0Ug4rhLLJMhBd2pEmGCK28lo8YX31jXs3
	 F73mWrQ2+v+zDeM3LPYsHYtMgRMfD/TRByegfVe3BMcJtFuNthE9bMHzHCr+exAxr0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976726;
	bh=/AhhOsrIDb2DoQlbCPExs8hTAp5nXUh3JvmqgvlBmTs=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HJZzf2frfQ4bcp5om9aEg1czAIjNGINBvcRyyRH3BrPZRvc9yTLzbn9KXGXFhlMDc
	 gLo2SfHvDNVpLcVZujqq1/u0MYZQAlqbKzCEJvvMTral3/A9EYb7ie9toTO91IXRtz
	 vUMmdjpI//j7dOI6nJKMpvBE0dEl610E19J52JyBYCFtXXNdLuHGiiBavBgT+EGYss
	 3FSdxGd9kCv8EPDuN2dnb5fI1rH4HWEUBt9ZY4FMdCrtqHvS7Gf58hBAvHnT8tP6Z2
	 TvAGbU1cDs1+lDDy0Oy2LHWfdgBJ7I6lm2CMBHUnyfAtdZM3nt9UjFS4I9w0PP+3SN
	 mxUvpweKIXq1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67528813DC;
	Fri,  2 Oct 2026 21:32:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C312282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5143D60DBD
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tjb9UylunkFv for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4FD9260D97
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976688;
 b=iIfIA3nrwA0iVmpX/uQAQUghhIaLF1Ruw8Sop0wBk84c1uRzw8C8DbYZulxIMDPJlJF+
 10gSONi5S/qBO9B4mX+5Uo8LxBj0LZzsIPku9sKYDDcNobSvRwvpKe1iHKBJ6np5mfBCa
 XNgET/V7KiX357DslFSVkjQeN/xX74Gf07k/REi5MJuc67yVZnpqa/rZcgAAHatVBQNAh
 TU+T/16x8dcEgUgHbRNK41/M1I5I6Qz90fbbqD5Krof1kmszilw7sGGA2pN/4z3qeizQ3
 bFs7t+SEb7iyq84wBmV3+xaBXtJ7oNboxroQlc3OhAPY9GQBDRe4nxSxZV52ZkvsXaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976688;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=/AhhOsrIDb2DoQlbCPExs8hTAp5nXUh3JvmqgvlBmTs=;
 b=jNDLiLeT5pDOerZCWs4tqcX0eHNu6x0hRCcvuJWMasSytnYZwjEyhFJ3WLoOWcwztFK3
 cRQdwUUJYoHyKh9EpjOTInqPkO/XL4o2GrirV/iSC8PYIGrbuA6QH8/h68p9RsHWzaA/X
 hg1mUSN8ejtrwqkW+mKHSO+TPTG52xlJJhXq5GRk7uuhiptMDOWFiU0QrlPLOcHstrlBI
 1KNHTK1nZne239dExJVAybrS62EixxKwueStHeb1yy15Yg5H/xgDZOE15iHHG3RcWZO6b
 79f5yhsnK8jyLWBU+CArbWUZVNHbKgqMJDJ68QvCAaEPnKsbvRs5pGmqgHTQMr+xIMg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=O2OGCeie; 
 arc=none smtp.remote-ip=185.70.43.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.16;
 helo=mail-4316.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=O2OGCeie
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FD9260D97
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976685; x=1791235885;
 bh=/AhhOsrIDb2DoQlbCPExs8hTAp5nXUh3JvmqgvlBmTs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=O2OGCeieRz4eGT5RgegOx/EbmitjyVF3+SavdUwSzWYI38N2L60Bm+9kTK7MIjsVp
 VpY94250Bm7xWjm8k/xFFym9BcqCPXzO/svaFPc2BPfQ/xFFOcsG368jFW3VHn0NOc
 dA4nYcAucpK2rKMErtI/ezirs0j+eaqby7eZkp4rXogr2hvs/vYNLH2kTht8j08pqU
 lITMp9Uau6QtwXziw7p8IS/gejDgGfiALiEV08RsbiAGVr6zEOPCHXu0+KLfMZa5Mm
 69EKzJk+kFN5V3fO+ZwiPVbrHsdsBoXWi8bpfq9BneXcH3PZuL2R73e/VUgCmFUCOS
 5tDuoYUOBXq0Q==
Date: Fri, 02 Oct 2026 21:31:21 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 8/9] pci: spacemit: set the link width from num-lanes
Message-ID: <73651a416255d0af9319f8f3c38c7a1630dedaf8.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975598.git.DaveWK225@protonmail.com>
References: <cover.1790975598.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 0c84a8222da175ccca8c303cb8d5930fbed05005
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:32:02 +0000
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

The driver never reads the standard "num-lanes" property, so a board
cannot set the width of a port: the OrangePi RV2's M.2 slot on port B
is wired for two lanes, and other boards may use only one of the two.

Linux's DesignWare core reads "num-lanes" and, when it is set,
programs the port link mode, the link width and speed control register
and the Maximum Link Width in Link Capabilities from it, leaving the
hardware default otherwise. dw_pcie_link_set_max_link_width() in
pcie_dw_common does exactly that; call it before link training.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/pci/pcie_dw_spacemit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemit.=
c
index 3b5c2dc4e0..9b299ca17a 100644
--- a/drivers/pci/pcie_dw_spacemit.c
+++ b/drivers/pci/pcie_dw_spacemit.c
@@ -41,6 +41,7 @@ struct pcie_dw_spacemit {
 =09struct reset_ctl_bulk=09rsts;
 =09struct udevice=09=09*vpcie3v3;=09/* slot supply, if described */
 =09u32=09=09=09max_link_speed;=09/* 0: hardware default */
+=09u32=09=09=09num_lanes;=09/* 0: hardware default */
 };
=20
 static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32 o=
ffset)
@@ -93,6 +94,9 @@ static void pcie_dw_configure(struct pcie_dw_spacemit *pc=
i)
 =09=09writew(lnkctl2, cap + PCI_EXP_LNKCTL2);
 =09}
=20
+=09/* Link width from "num-lanes"; without it, keep the hardware's */
+=09dw_pcie_link_set_max_link_width(&pci->dw, pci->num_lanes);
+
 =09dw_pcie_dbi_write_enable(&pci->dw, false);
 }
=20
@@ -406,6 +410,8 @@ static int pcie_dw_spacemit_of_to_plat(struct udevice *=
dev)
 =09=09pcie->max_link_speed =3D 0;
 =09}
=20
+=09pcie->num_lanes =3D dev_read_u32_default(dev, "num-lanes", 0);
+
 =09/* Derive port ID from DBI base address */
 =09pcie->port_id =3D (dbi_addr - SPACEMIT_PCIE_DBI_BASE) / SPACEMIT_PCIE_D=
BI_STRIDE;
=20
--=20
2.55.0


