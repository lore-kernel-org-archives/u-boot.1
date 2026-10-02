Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496A1CA5FE6
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDE2760DED;
	Fri,  2 Oct 2026 22:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dj-WM5ibhq7U; Fri,  2 Oct 2026 22:10:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 45E0E60DC4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979009;
	b=UCRlktBNz8U1IafTtDQeWR1kICWShx5uYHGerUGQplk9e5rNR+oNIkoa+UPvhjNV0pdb
	 HPtHE6afMPeXpnE4p28Jt0SRNJCIAQhYf7wBIayWuAdUovWgXadct6sQwh/CbtK5yyqbP
	 kR73DP2lreVHIz0HXinN7IuggeraevD3vlj93C6zQ6fXGM97btpvu636XtKF3pk9GYGAx
	 uuKJlXD5GH+GwwT+JaxPKezwmeplvuoEWIFLbIpP7EJRRm+UDJZ6gE+XDFPYInrTS5DH4
	 TVkChOrHQffad6JXhBV+4rR1aqdmJsKOJrsTbFB+RBr+XRnsZofsUhETTJxZlMPkzaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d1qjgXYdaEfdq/BPn3ylWDchZA5r8Xt0kDAmmbr6/tQ=;
	b=sPwWhOhjJ83vG11VsLRL2WJAvXqyzr0tLxt4eElSezstNUQJ68k8nmmPuZaEYw/XWc64
	 vdvEdHss5SfF+twKa7o0TCPhVKvk+5HJFAeoXtQYxJwDk7y/3gSDKRnqEURUdveRl6D68
	 GfIC7vhAEDLjKPiTbK1nxJyNlTAnwW5uBicZQDjjXkJV19TWNT9g+0ymUlP7upqewvhU6
	 f9v+A2khuib8UoPBmzp13lExtr4RmZlH4pF8MM4bvEk6TUt9nzXWsfLpt6Qj1WhDyhF2b
	 iD9+iWf96plQ10q9yxeurgms5DJga+Gz/ydvA/tlqH7jOnbgXrXoPKr5L7GPb6TW6mA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979009;
	bh=d1qjgXYdaEfdq/BPn3ylWDchZA5r8Xt0kDAmmbr6/tQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l6mKcHXEQV2AXdOPq2oXY4uSaUTQgiO5RUomCYnCrobXI3IeRzRaNJXnJufI8hFiM
	 D8VVcSRSE4xFOsYcFUCMIFvMhHm2PBfDhg1T4NC5H0XvvmObqKlCudsoMMEOP8Bfzw
	 Qe2XpHw0TmugQPkjP6y/j5Cs49bTEEJgECEkNfNHcfu0xZ9Sjs5xRWRaoAG9Xh3bgX
	 /EwULTZZUyw5nAGMr6SMQYA4fqdD2L9PXxg0YFA/csjbfvZc37USoSeSNQV3A1U2l6
	 abGkhVxdkBOtejMPeuVuYRBnfTZXdFwDZ71CtKvD86LpyK4yRanobT87E/s3tOS7KO
	 u5ERqUCiN8nmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45E0E60DC4;
	Fri,  2 Oct 2026 22:10:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B6961D2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D32981432
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:40:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Wix3v5fkB7A for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:40:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 646698142F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=79.135.106.110
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790977250;
 b=IgwII40HEaADrDN7+iNy9kRARD1/nktaxNiM+XZyqVqWNo8DQcssfHRXjreijjfI4WqL
 Vauig8Jidt3Lip3U1nJ7/qvDurOw6W/hK3FBQwjoEUdC3QXSoD53NvVqvFpvqgQcShf0m
 T7bsfUN71LBk/c8WUrTvH5t7yUolSEONjuIFoF8VJfsPsqGiia3RPntTp4970kF65+Ezv
 wEM9fDFpScuA02MxqMu127pUo+Q/57ETcIuwz9RAH43P1Z3R6luaB6SwXEpiSCfQ1ll0c
 xms57Dg2cuTkmgBp+OvMe3i+IET4VS9MJcpkJJf6+vP7SxpBQgvemjIbS2bFBqH9BfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790977250;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=d1qjgXYdaEfdq/BPn3ylWDchZA5r8Xt0kDAmmbr6/tQ=;
 b=DKBwW09l2bZf/1MewduTsq1xHWyOn+WKhmu/bFzrMqJ8NmWb6QjSkAjqAhoKsDCHMiQT
 6y5mDhnfrT2nhbXVpVfYQsyvStFK8dE4zMWSLlC03CB9LwikjlXSMP1DHPUfx+QziG4TX
 1IU/Q+O/xIcTD2gbiwjlsfbT9GddYsGIGGFu0iKf52402W7Nas3gltoaefw2IyVkLZYri
 udDFtVLKzj5fBMLvWGDj7yHL5l0VjnoAYgxkvul3CBJM5282ymulm+OH108vDQX5bdHJr
 TUDPQJOyU967xoYxY5/DwWX8+/WL+le1HIdustnS0zkbu7Qy+spKjjhhfkB/ZI4X6QQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=BpfclwVx; 
 arc=none smtp.remote-ip=79.135.106.110
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.110;
 helo=mail-106110.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=BpfclwVx
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 646698142F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976615; x=1791235815;
 bh=d1qjgXYdaEfdq/BPn3ylWDchZA5r8Xt0kDAmmbr6/tQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=BpfclwVxkNhYtuP/Ia3Ggw7EOpWWnVl1JGOIJcwkGoXGjcBP/zwnNncni4Y3vSufi
 Q338iKPGW9R7nI2ET7Pd6A8hKLbDTcgoD8IAbGCllDIXJx8dgyBO94CrarUgBOR4XI
 5w/WGNhLW/fZ43tq87Ffppw51233T3UfDIra4gFXFjdmFJ7XBTBw8IgKfL2m9iA5Ob
 uRlxivDxBmCutKQRSNuUUpHMlKrcaAUhKgrcXsoINEltjgL0wXmMTLSDiI0iiCdpar
 gKwGzxDC7an8Ic0WkzIvWqhvPzBDZJiNmSFsagEPHCdu0DvZpNp2X+GJ4bacZk+wNZ
 /7uw4CDo21ZNg==
Date: Fri, 02 Oct 2026 21:30:12 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 4/7] phy: spacemit: k1: program the termination fields properly
Message-ID: <c15412d8a7be3790d99f507f9e9e5dd3113f13d1.1790975597.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 96624d9d5aa9a222bb24513918a49eb4e0ef19e6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 22:10:03 +0000
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

The RX and TX termination values measured by the combo PHY are OR'd
into AFE_RTERM_REG (PCIE_RX_REG1) and TX_RTERM_REG (PCIE_TX_REG1)
without clearing those fields first, so any bit already set there,
by reset or by an earlier stage, ends up in the result. EN_RTERM,
which enables the refclock receiver termination, is never set.

Linux's k1_pcie_phy_init_pcie() clears each field before writing
the calibrated value and sets EN_RTERM, on every lane. Do the same.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/phy/spacemit/phy-k1-pcie.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-=
k1-pcie.c
index 308f7dec79..ab8349f7d1 100644
--- a/drivers/phy/spacemit/phy-k1-pcie.c
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -231,10 +231,15 @@ static int k1_pcie_phy_init(struct phy *phy)
=20
 =09lane =3D (k1_phy->pcie_lanes =3D=3D 1) ? 1 : 2;
=20
-=09/* Apply rterm calibration value: LSB to RX_REG1 */
+=09/*
+=09 * Apply rterm calibration value: LSB to RX_REG1, and enable
+=09 * refclock receiver termination
+=09 */
 =09for (i =3D 0; i < lane; i++) {
 =09=09val =3D readl(regs + PCIE_RX_REG1 + PHY_LANE_OFFSET * i);
+=09=09val &=3D ~AFE_RTERM_REG;
 =09=09val |=3D FIELD_PREP(AFE_RTERM_REG, k1_phy_rterm_rx());
+=09=09val |=3D EN_RTERM;
 =09=09writel(val, regs + PCIE_RX_REG1 + PHY_LANE_OFFSET * i);
 =09}
=20
@@ -248,6 +253,7 @@ static int k1_pcie_phy_init(struct phy *phy)
 =09/* Apply rterm MSB to TX_REG1 */
 =09for (i =3D 0; i < lane; i++) {
 =09=09val =3D readl(regs + PCIE_TX_REG1 + PHY_LANE_OFFSET * i);
+=09=09val &=3D ~TX_RTERM_REG;
 =09=09val |=3D FIELD_PREP(TX_RTERM_REG, k1_phy_rterm_tx());
 =09=09writel(val, regs + PCIE_TX_REG1 + PHY_LANE_OFFSET * i);
 =09}
--=20
2.55.0


