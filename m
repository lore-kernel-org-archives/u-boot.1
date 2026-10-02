Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA59CA5FE4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A62C48137A;
	Fri,  2 Oct 2026 21:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fjCmBuNY_eus; Fri,  2 Oct 2026 21:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C2FE813A3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976666;
	b=dgv/EX/folkHk4jEyENWQNyM4tBKmP73XMESUsV7oeulmG+1LMnchNgeV5nSGoy5l6pM
	 w/NNpzmhHgHs46KGlFVZNmaYHAqJrhKEge7zJ9jbNUu3X/JoffGzXN6cKV2k7oYPSS7SQ
	 4Ef6NDvy3MZ5107g0C47UGg9FUtqGwyBF/53e9HBni4KG253/F8IK7GnIR/3M4kUKijuj
	 nvMfCT3CogZvqKikLJiK+KyQ9RAuWQo9JHy6ht9sRzguRTTAw9i4A4Nm0l5nG9oUlnHNQ
	 2Z5O5fbwXfzglKmBRGvwg/AJ5f+Sz+i+prfUa0MKyq+2f197wuUtS2ZEGFkKqVF6XNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m9C0+Hd/OxKylw56K4tYEB9N8+7bGe7YRb5AU61aDck=;
	b=Gz1BBsVAukrkPnzRB4NDngzxyEuIp+RrUDpgUfNuDOMB2S0brAuezvdjgzPdecQS5TnJ
	 S/y5xOXPbYcTSTsZKMDO6zq16nYB6wNBYf9nD9NKEeidXlM4NQNCZcIAou8/vmpbuiYta
	 CB+9p+/PEV0glHFVVp6G+ntN+43FvqJ4iNDccQHA3UruXJWHhB2TueX3GsEmBg3b48XBq
	 7TfUCG0r1kylQM8vhZxxO9Lis2tZeoC6s8VK13GUCpdBwKRY0Pf0iItOXO4TvsvbtZEn6
	 9OPVjyGqEKZ1n6HJRjrItj2wZ6cPweWmJbwzpCVHgmoh5jQiBj/fQfS5KyTs/gZvNaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=tE2sVOxz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976666;
	bh=m9C0+Hd/OxKylw56K4tYEB9N8+7bGe7YRb5AU61aDck=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTUiykM61xyH7DIKBSNGQ9/k/TkLXBXvrkp/drbXj3NzcJIpwnPl5v5XOW9nrxPpA
	 ud5H780CvcSTP4IiRyIYgiqODjHfIxfizEQ/mpYuukjbfx6k9FOy6Wdet8xMrAjmPo
	 C6EDuMlSpOTqlAbz38u1ZILgVIESzia42pep2Ztf72E+Ad9zd1gHJGebb3bb0Embo2
	 MQ0TJeCJUWdhHtvUybbUcy2i0jdY6nGOW31flVHY4ktA3toRtkt4LgVH+fgnOWPmaZ
	 XcKMxagov7i2G+JJ2t2rjlTblK3x5PDUs4H2wqoR7khZ9Acj12wqoHrLsBwj5Ft8tf
	 4YtgfqxMU+CiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C2FE813A3;
	Fri,  2 Oct 2026 21:31:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A8A3734D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A3B881365
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qbt9UdA1U0ca for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:30:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C542D81370
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976605;
 b=SapUoyZvWfj/EZs5JHujxSiN2n6K8iZImWFoZ7WWfZbtObJOJdzPfeb1aH1O375AvRHI
 RBqaE2GchjMYTiCwCuvy35D3gfVGgNOvU/F36f96voVRpkLn/JHV3CnUaHr+sqTEP/5nf
 xbpMnlQzuURu2CTgU/8PzEI1UfPh/rTCnwlA3K/ya0YTzeohl/HVAeOASMIrDtqftMO9f
 h5TI95mHeClLr9R4wrD/l4hSQzlQAoD7kwucqS2PxEoODUkxvoXcRPBAUt9VTWHdyHoFK
 6TQHP3YgElMtWlVFdMl9opUqf30i1fh9CCLZ+5gBGhFOLd92lw2BFNMuMjfkqOjt+Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976605;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=m9C0+Hd/OxKylw56K4tYEB9N8+7bGe7YRb5AU61aDck=;
 b=Z65LHVCsetYrWyTLzrR+y0yKc03tgCxXA7oNZ1iaZ/KBg1wmc1BkokxXKRtQmdPd63f3
 GW3zdAirf/I9QoY3rrcG+q7A7FnNPfuKwGRrzgpEKS0Dqor6Shc0m6B5MXgFklipgL4T1
 hEy2NoOB1v1SCWSVXK8TNT2kDsekqhBD25TfqRlrcJQNYZXF09sDf1T1Si/0S9/oh6WsG
 xdbTO3HpIp0ZSa8YLCf62v3+OmusYynUhLJ8Vk8zSiZdIeArUIC1eCWv4aEKvKBLTIHlV
 h78BAM51owOC3EGnVjFYFvuWhVYKl0fagTgiVOzG/9wPAx0oTXVQkFN+SgtngKKSnyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=tE2sVOxz; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=tE2sVOxz
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C542D81370
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976597; x=1791235797;
 bh=m9C0+Hd/OxKylw56K4tYEB9N8+7bGe7YRb5AU61aDck=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=tE2sVOxzthYWvZrDW+t0gYkAxZ7rGXwn9Hz7jHKEcouJ43ni3SZVaaYLz6pkQ0POD
 /fmNaS0Hv2MR7EXJGdsyfl4Qii9lcKK4Dco3MvDFPdA4SyuhxW/JzrxoEvG58WhlH0
 j8LLmrBggK/bZxhdVWUQKEuA8kyE/3u/voLhhL2daAprL3iIIcDA9poEvfHhAsVj7K
 0VzVaOwcc/58IemlUlUGKztbSwJ4mlU0NBAlx31Og7nZ1Xc/XSH5R/D/mVYX7d2IW9
 yISRFCW56JSNwTNLKJM+bkQFYiJ2mxt4O9WeTSfLk09ziz2osiPvJskQTP96S6DHQu
 qTsPyWUsiGHTA==
Date: Fri, 02 Oct 2026 21:29:52 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
Subject: [PATCH 1/7] phy: spacemit: k1: enable refclk and deassert the PHY
 reset at probe
Message-ID: <40be5679408eabffea146616801c6d976dc45ff9.1790975597.git.DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975597.git.DaveWK225@protonmail.com>
References: <cover.1790975597.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 5576cc6775b8f765d0a6c0c19a912d796f42aeb4
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

The driver gets the clocks and resets listed in the device tree with
clk_get_bulk() and reset_get_bulk(), but never enables or deasserts
any of them, and only warns if getting them fails. The combo PHY
instead clears GLOBAL_PHY_RST by hand in the APMU before calibrating,
and ports B and C rely on the PCIe controller driver to do the same
for them.

Linux gets the "phy" reset of every K1 PCIe PHY deasserted at probe
(devm_reset_control_get_exclusive_deasserted()) and leaves it that
way; the "refclk" oscillator is the parent of the PHY PLL and is
enabled with it. Do the same here: at probe, before any PHY register
is accessed, enable "refclk" and deassert the "phy" reset, and fail
the probe if either cannot be got or enabled. The combo PHY's PCIe
port A application clocks and resets are not part of this: the
calibration handles them, as it does in Linux.

The calibration no longer needs to clear GLOBAL_PHY_RST itself, since
that is the bit the "phy" reset controls.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/phy/spacemit/phy-k1-pcie.c | 69 ++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/spacemit/phy-k1-pcie.c b/drivers/phy/spacemit/phy-=
k1-pcie.c
index e54742a2a9..b445ee9d01 100644
--- a/drivers/phy/spacemit/phy-k1-pcie.c
+++ b/drivers/phy/spacemit/phy-k1-pcie.c
@@ -92,7 +92,6 @@
 #define PCIE_CLK_RES_CTRL=09=090x03cc
 #define PCIE_APP_HOLD_PHY_RST=09=09BIT(30)
 #define DEVICE_TYPE_RC=09=09=09BIT(31)
-#define GLOBAL_PHY_RST=09=09=09BIT(8)
=20
 #define APMU_CLK_GATE_MASK=09=090x3f
=20
@@ -107,8 +106,8 @@ struct k1_pcie_phy {
 =09void __iomem *apmu_base;=09/* only for combo PHY */
 =09u32 pcie_lanes;
 =09bool is_combo;
-=09struct clk_bulk clks;
-=09struct reset_ctl_bulk rst;
+=09struct clk refclk;
+=09struct reset_ctl phy_rst;
 };
=20
 static bool k1_phy_rterm_valid(void)
@@ -155,13 +154,11 @@ int k1_pcie_combo_phy_calibrate(struct udevice *dev, =
struct k1_pcie_phy *k1_phy)
=20
 =09/*
 =09 * Initialize the APMU control register: set RC mode, enable
-=09 * clock gates (bits 0-5), deassert PHY global reset, then
-=09 * release the PHY hold.  Without this the PHY registers are
-=09 * not accessible and reads will hang.
+=09 * clock gates (bits 0-5), then release the PHY hold.  The PHY
+=09 * (global) reset was deasserted at probe.
 =09 */
 =09val =3D readl(k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
 =09val |=3D DEVICE_TYPE_RC | PCIE_APP_HOLD_PHY_RST | APMU_CLK_GATE_MASK;
-=09val &=3D ~GLOBAL_PHY_RST;
 =09writel(val, k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
 =09val &=3D ~PCIE_APP_HOLD_PHY_RST;
 =09writel(val, k1_phy->apmu_base + PCIE_CLK_RES_CTRL);
@@ -384,6 +381,48 @@ static const struct phy_ops k1_pcie_phy_ops =3D {
 =09.exit=09=09=3D k1_pcie_phy_exit,
 };
=20
+/*
+ * Enable the 24 MHz reference clock that feeds the PHY PLL, and
+ * deassert the PHY (global) reset, leaving it deasserted.  This must
+ * happen before any PHY register is accessed.
+ */
+static int k1_pcie_phy_enable_resources(struct udevice *dev,
+=09=09=09=09=09struct k1_pcie_phy *k1_phy)
+{
+=09int ret;
+
+=09ret =3D clk_get_by_name(dev, "refclk", &k1_phy->refclk);
+=09if (ret) {
+=09=09dev_err(dev, "failed to get refclk: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D clk_enable(&k1_phy->refclk);
+=09if (ret) {
+=09=09dev_err(dev, "failed to enable refclk: %d\n", ret);
+=09=09return ret;
+=09}
+
+=09ret =3D reset_get_by_name(dev, "phy", &k1_phy->phy_rst);
+=09if (ret) {
+=09=09dev_err(dev, "failed to get phy reset: %d\n", ret);
+=09=09goto err_clk;
+=09}
+
+=09ret =3D reset_deassert(&k1_phy->phy_rst);
+=09if (ret) {
+=09=09dev_err(dev, "failed to deassert phy reset: %d\n", ret);
+=09=09goto err_clk;
+=09}
+
+=09return 0;
+
+err_clk:
+=09clk_disable(&k1_phy->refclk);
+
+=09return ret;
+}
+
 static int k1_pcie_phy_probe(struct udevice *dev)
 {
 =09struct k1_pcie_phy *k1_phy =3D dev_get_priv(dev);
@@ -425,13 +464,9 @@ static int k1_pcie_phy_probe(struct udevice *dev)
 =09=09if (!k1_phy->apmu_base)
 =09=09=09return -EINVAL;
=20
-=09=09ret =3D clk_get_bulk(dev, &k1_phy->clks);
-=09=09if (ret)
-=09=09=09dev_warn(dev, "failed to get clocks: %d\n", ret);
-
-=09=09ret =3D reset_get_bulk(dev, &k1_phy->rst);
+=09=09ret =3D k1_pcie_phy_enable_resources(dev, k1_phy);
 =09=09if (ret)
-=09=09=09dev_warn(dev, "failed to get resets: %d\n", ret);
+=09=09=09return ret;
=20
 =09=09ret =3D k1_pcie_combo_phy_calibrate(dev, k1_phy);
 =09=09if (ret)
@@ -461,13 +496,9 @@ static int k1_pcie_phy_probe(struct udevice *dev)
 =09=09=09return -ENOENT;
 =09=09}
=20
-=09=09ret =3D clk_get_bulk(dev, &k1_phy->clks);
+=09=09ret =3D k1_pcie_phy_enable_resources(dev, k1_phy);
 =09=09if (ret)
-=09=09=09dev_warn(dev, "failed to get clocks: %d\n", ret);
-
-=09=09ret =3D reset_get_bulk(dev, &k1_phy->rst);
-=09=09if (ret)
-=09=09=09dev_warn(dev, "failed to get resets: %d\n", ret);
+=09=09=09return ret;
 =09}
=20
 =09dev_dbg(dev, "probed (combo=3D%d lanes=3D%u rterm=3D0x%02x)\n",
--=20
2.55.0


