Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9CCCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E55A60D9E;
	Fri,  2 Oct 2026 21:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oAYxQBJ8Q0QA; Fri,  2 Oct 2026 21:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7ED0560D96
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976670;
	b=dJRJ+Zm6GaQgKbsEJJvE/msMEFIm3URl3KqSxn0o/DJvW4QMDfzwA1cqY8m1LELTyhvL
	 8etZdZFYOv4mnjzZRJHPHlyBukKl49vuL4wVmRmxJuqKa4umj2CMrG8gecINMztqarOPs
	 KxqXDMdWxrtq3NAISkWMKjAQgajQpuOZcDZ2Om6wH+q435kMrDMvHfCtg2vNkeNgJSkU5
	 47KJaHXQ0A4SLA8yersXnGMu8fbaXekBppdHl4LDHNCCKEHeE2UnArs5Ka9fbRqlOWkae
	 0Ca8YXrajvVt9SVqO/kXrchy0uXMM4jqR1xGWx/LxldqzjGBs6NDmwSwenflYSb3jsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GRb4Ji59EUTwgafCasLgTUFDkpcYpKJfsy9GAEb2A2o=;
	b=jtyTVx7gxEVKSc+12CBgIdI+iU/WM9u6Y5261yT4AOjWTF01tqdpii8D3fuzDDoddRfu
	 ++SmVy6z42Z2URyJauwB0uIKgYcnCMKMPC76c9ejKqHo1TqH2iyGxdfszU42hu21fNA03
	 xLRPP5CvjtepuXQ/orP4de3u/se0kSRdYbpK5RTFyMY0YzGhV1DUCTKz7TI/dpOdH9kfi
	 kyehjgYrKUKQkq4LAOBOFgelUnE1bvq5CwRI02g/8n6vR6L7+y7Y6L1dCconIWp3s3coJ
	 vp/6jfN+Yy6Mp1tLoCqM5RSURGMnsce1nm64nNu5y/fs3+xCeX6NpqXtaKb9b2jTAZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Sr6yYTQo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976670;
	bh=GRb4Ji59EUTwgafCasLgTUFDkpcYpKJfsy9GAEb2A2o=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8CEIk1MfctyswKsCJ0UudDqopnXj5o0nwqz09VpwaRyTGy7lBSexo8DwBoY2cUio
	 h+ni+ODn8l5qrUSVmypCvO96QMG4Nu/CoE18fqop/yALHRwJ0u4vsq9j4RdY/kgqG3
	 3qNciKxJm9H2SrAZrl7ClvrTxirSDRebX2VRNBb2wTM96cq1oeaglKQBrXliTm7gW/
	 Gww32pHI6Y1hpI+Iq0ncZjPxaA8WTmuPIiGRHefgqjIsKSgd7tNVlczYsUmqDjrJ0e
	 2Dp3ZMzmv4AxmQTdcH5//fTWiHyjTNls1ipg6jo2fTBBnwAC2kp+IG7p+JtYRRl59q
	 FJDJ9de0I1bBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7ED0560D96;
	Fri,  2 Oct 2026 21:31:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F145179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6086D60D92
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OnBxPLm5i61 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E5F1660D70
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976628;
 b=pt8P+5atWlSqxGvl0TVHxQmMcTUnwjZRzI7QAp3DoyjGgRYTMgviz1OcYTWo+YFYnmgJ
 9aqCfmCl/ShF2LqM6e4v8Qkx7ZcqAQjkhNRzxOUR/VKBfDAtntx8ehOE8Cd0srvuk2VzG
 WcTBKuQfvJGeYa0FiZMYhyMQrFJJqkBbJH03DQ57n+cdvyHyB+VOLeBraey6L3JRY37Hp
 xe0wcvKvhbDQR4Szmk15y3mIajixxNswoRUEogsEAMUl+4zZTLjJjOAczx24yeFWshlEI
 ROsF/iKBf5gRTzRna6SWcu/NLinyuxcFH1rgIG5eUTVDkaJqmQDeWLYc7wJ9WbN5Adw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976628;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=GRb4Ji59EUTwgafCasLgTUFDkpcYpKJfsy9GAEb2A2o=;
 b=ACa6HHkLCXFpi0VC++u7qiU7h7foSFriI54uiyPOhG5kORmxprmVGxK/cHGDDWyMny/t
 uc223ePRiEhmMNLYV3GohtOPbOa7ymwSH36J8vSQ1U8H1OPyAa/0L+7XRWKqIgcrTSO9T
 mgXmMxzOyaRItvvsXXittm6DiKZxjIbuJXZesTlIyVNOMEv45eMneYHyY52L95uECO9jQ
 ctd8jhVuXv+IFbAa9HT/KQ/RhmPN3YFEAN3rYJ2NrX2LuYdSn9ZjpNvk5n5RRPuHMJikQ
 gzcRxFyyauPNjbLPKGgopurwZ8/FVWHDaE2lKULgma29eQmHo3YkdrBjwNDFDd/sV2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=Sr6yYTQo; 
 arc=none smtp.remote-ip=109.224.244.17
X-Greylist: delayed 65 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 21:30:27 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=Sr6yYTQo
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.17;
 helo=mail-24417.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5F1660D70
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976626; x=1791235826;
 bh=GRb4Ji59EUTwgafCasLgTUFDkpcYpKJfsy9GAEb2A2o=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Sr6yYTQoTfyYFzTi0KEn9mov5DS0WgVl8BGJTqWBaT0axv/8HHS/eg4XnoQrVQIUB
 wyAoRJa6Yqyv7fXm+014syvAdu0ZfJ41z5G/PDSZ5jOus8JzdYDeglbuqIkHgvGeZR
 GSFAogGHzc3m/zix2SuFVo14SltgnSBVVBOL5Layw6lLvntPV3vWnboldMBdXRQfYh
 7MKoJrSCIFBqYiDOdQeCuT6gQJUO+HjCW87QO2Dyl0jh28du8iK+VrLoDRkyWxLF8y
 Q/so+/crZKGWikl1Ssry6Tu9pPDhYw4Y3g18RydnvJ4E8W7aFOBEDxflT+rUqRpfLx
 NOFFCphCC8OHA==
Date: Fri, 02 Oct 2026 21:30:22 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 6/7] phy: spacemit: k1: don't overwrite whole PLL control
 registers
Message-ID: <c30fb31cd4fa39c5a322116b99ef0efc91316bcb.1790975597.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: afa65ef4b27ac64c906490943217d8f437e148d1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:30:59 +0000
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

To start the PHY PLL, init writes 0xb78 over the whole of
PCIE_PU_ADDR_CLK_CFG, and CFG_FORCE_RCV_RETRY over the whole of
PCIE_RC_DONE_STATUS, clearing every other field of both. 0xb78 is
CFG_SW_PHY_INIT_DONE, CFG_INTERNAL_TIMER_ADJ =3D 6 (PCIe) and four
undocumented low bits. The lane 1 register is written even when the
PHY has only one lane, as the combo PHY always does.

Linux's PLL prepare sets CFG_INTERNAL_TIMER_ADJ to TIMER_ADJ_PCIE on
each lane in use, sets CFG_FORCE_RCV_RETRY, clears REF_100_WSSC along
with selecting the 24 MHz reference in PCIE_PU_PLL_1, and only then
sets CFG_SW_PHY_INIT_DONE on each lane to start the PLL, all with
read-modify-write. Do the same here, using the existing named fields
instead of the magic value.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/phy/spacemit/phy-k1-pcie.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-=
k1-pcie.c
index 0e18f29024..c3d29d6a2a 100644
--- a/drivers/phy/spacemit/phy-k1-pcie.c
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -311,9 +311,9 @@ static int k1_pcie_phy_init(struct phy *phy)
 =09val |=3D FIELD_PREP(CFG_REFCLK_MODE, RFCLK_MODE_DRIVER);
 =09writel(val, regs + PHY_LANE_OFFSET + PCIE_LTSSM_DIS_ENTRY);
=20
-=09/* Configure PLL: select 24MHz reference */
+=09/* Configure PLL: select 24MHz reference, no 100MHz SSC input */
 =09val =3D readl(regs + PCIE_PU_PLL_1);
-=09val &=3D ~FREF_SEL;
+=09val &=3D ~(FREF_SEL | REF_100_WSSC);
 =09writel(val, regs + PCIE_PU_PLL_1);
=20
 =09val =3D readl(regs + PCIE_PU_PLL_1);
@@ -330,15 +330,26 @@ static int k1_pcie_phy_init(struct phy *phy)
 =09val &=3D ~SSC_DEP_SEL;
 =09writel(val, regs + PCIE_PU_PLL_1);
=20
-=09/* Set PU_ADDR_CLK_CFG for both lanes */
-=09val =3D 0x00000B78;
-=09writel(val, regs + PCIE_PU_ADDR_CLK_CFG);
-=09writel(val, regs + PHY_LANE_OFFSET + PCIE_PU_ADDR_CLK_CFG);
+=09/* Set the PCIe internal timer adjustment for all lanes */
+=09for (i =3D 0; i < lane; i++) {
+=09=09val =3D readl(regs + PCIE_PU_ADDR_CLK_CFG + PHY_LANE_OFFSET * i);
+=09=09val &=3D ~CFG_INTERNAL_TIMER_ADJ;
+=09=09val |=3D FIELD_PREP(CFG_INTERNAL_TIMER_ADJ, TIMER_ADJ_PCIE);
+=09=09writel(val, regs + PCIE_PU_ADDR_CLK_CFG + PHY_LANE_OFFSET * i);
+=09}
=20
-=09/* Force receiver done */
-=09val =3D CFG_FORCE_RCV_RETRY;
+=09/* Force receiver retry */
+=09val =3D readl(regs + PCIE_RC_DONE_STATUS);
+=09val |=3D CFG_FORCE_RCV_RETRY;
 =09writel(val, regs + PCIE_RC_DONE_STATUS);
=20
+=09/* PLL configuration is done; start the PLL on all lanes */
+=09for (i =3D 0; i < lane; i++) {
+=09=09val =3D readl(regs + PCIE_PU_ADDR_CLK_CFG + PHY_LANE_OFFSET * i);
+=09=09val |=3D CFG_SW_PHY_INIT_DONE;
+=09=09writel(val, regs + PCIE_PU_ADDR_CLK_CFG + PHY_LANE_OFFSET * i);
+=09}
+
 =09/* Wait for PLL lock */
 =09ret =3D readl_poll_timeout(regs + PCIE_PU_ADDR_CLK_CFG, val,
 =09=09=09=09 val & PLL_READY, PLL_TIMEOUT_US);
--=20
2.55.0


