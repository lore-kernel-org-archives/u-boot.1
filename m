Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FC606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GPJc+d1T;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256 header.s=20240125 header.b=My+oG3is
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66BAD60673;
	Wed, 28 Oct 2026 02:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v0CjgHZJyMvJ; Wed, 28 Oct 2026 02:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 155CB60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793153283;
	b=q/cl7kGBp9G5VZR5uj9yIGyAJqoCfiX/VXgYMTmLJnljsHNiUzbs2MWWeu2arryWShKq
	 sPfrqxNGjc7ho4kTlaNSGiHkXvt7yQ2G96GUoItEe1PEBqm1nV22wWe0SMHzm6Z5CSHO+
	 wxglSTwTqk3dnSWf+O8yjbrg2njJx65O0A2ka4fY9b9edfXZz+epQV9aRHGuzUsY94hWw
	 fDujNlH3ycBW/7ctym9YJUagPwALVuPwagCk0BKeTgaI71UlKMciNZvj5MuCbtVujgjcL
	 95mGO8zdk0b1ECYVI7/sA32snkX3m3BCNLbO9wMKYQitvpCVSPdx7MuKxVkl1+5fzsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793153283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/rJOnwvpWWcP5qjMkaS7E6emDaDx4e8kGorUimzIDjE=;
	b=SaQfyOmaJmxwNm1jgT4HtImJvUpPPP2ui5aqvgc5hs+u+y2SqOd2WH2DLyD4s5UwJUfm
	 HAi6xffpkx1UyR5HBby4B4WQxD8e9Gry2SHS0A0Elqg1OsvYiiD7QKgb4xs7yUZnOU72F
	 8aghFTogMbEY28OldozYIKtkpc4uSLdvxTLUvcwzo10hLutWzk0auej5o6qdHoThxUWjs
	 l+XBqjF1IAuDbbOWPPxyfk71/PrioaVmhPsYQL701wxgBVkW3LoywUbY3+JBPNfLhpuVP
	 1TvzH8l93nPXVQoRlno0CxZabyQ2Mgp5c2WxSJDbM9rg2751rM4UDRO6fs2BKzFG1IQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793153283;
	bh=/rJOnwvpWWcP5qjMkaS7E6emDaDx4e8kGorUimzIDjE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GPJc+d1TG9RVcLiWbjOQj2mufMMAy+VVJuS5V5tD74DC0ULRWGIvqZ0oGeXvWL13o
	 /As0wLI5iuUlCrWxV0xK7v4DliJ3nuw3b6k8WXrb0w76ACaXpSgnZnjYGvfLsy2189
	 y5x/Rf7JHKxdIqKp6Y/BPr4GM0T6wTgZK8VSp5FQQBS4q+Kx4sAh0esrhEC/4bgX0P
	 VpxLGKtRupgH/THLx1AzVM7qgQtQFDqPOpISoMiCCGutDVv0/QsAV5nWEYqdE4NxFF
	 COVBgdDbHZg06ik+HmXmT6fIPDfyDYWn7d+/JitilI7i7jhpiDrdLnQJ1csYaXBV6D
	 Fz0IHfgIbkeuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 155CB60613;
	Wed, 28 Oct 2026 02:08:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A3C15473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 02:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95EFF4057C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 02:08:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EuZYLKDceCyU for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 02:08:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F5BF4055D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=153.128.190.146
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793153280;
 b=OkWBt2zKHP3GmCVlP+OH0/NzH41uddFfQmVdmoMWjSZTgwHe6PmQl9ziC6Aw0wRG85yy
 316Yyz+4H9W2f5PEiEQn7b5Km9u2j2PRDcaz/l9p9gZSCrRHT8TCvIiJK96ZCoazes6Wm
 i0GIdD5MTqm+tBpnicwrFM2bDszIKuwsFkelqy9hwsL6Rd7EbX8S6/4xAgkPRpSrfA4RE
 SC6SlgrNMadTHdZ9NGAzW85KSnExGy+Hl/Ay6+GZ81QbBZHpQQ69lQkdokmZ0xfjrlVbH
 BEhbblDLn262TISaRh+dcTnafhTttXNhNsWM5GxllZB+KtLJAXHFJakHLJgGAKInxOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793153280;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Received:
 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=/rJOnwvpWWcP5qjMkaS7E6emDaDx4e8kGorUimzIDjE=;
 b=kfCVSw+R1oEqHZiQauZWnjeCtgf9TQazsepuwnIXzXjyKIspBchkwbGeOAYZ7DVxy4uN
 TFg431qZw9yjjGeACtmahL0YMQQcL6TmsSTvrzPyoIcPYhELT9FS3JlF4m7jfDRlcRqaz
 9ld8BxXlNJirkZgZ5kjZL6+MEmqK/OjhiY0BzCHjHzeT/YusrZ+KJF7pdTnM54Lmg1kQF
 MDXY+w6ODNvqKvREssO1x+W0N4YfK3RouTDQ8Z0gwt7MDUc47/Ik/9QDaVpeVBe2XUUQ/
 EO3RLhzS7La3xKS/q35yrcXeU8L9j1H+7NXSiDVOppxKQZ1jW9GuzAsxbf+phvTeufA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=docomonet.jp;
 dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=My+oG3is; 
 arc=none smtp.remote-ip=153.128.190.146
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.128.190.146;
 helo=ocn-dfr-mts-121c1.ocn.ad.jp; envelope-from=y-asai.0816@docomonet.jp;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=docomonet.jp
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=My+oG3is
Received: from ocn-dfr-mts-121c1.ocn.ad.jp (ocn-dfr-mts-121c1.ocn.ad.jp
 [153.128.190.146])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F5BF4055D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 02:07:58 +0000 (UTC)
Received: from ocn-ckd-mts-115c37.ocn.ad.jp (ocn-ckd-mts-115c37.ocn.ad.jp
 [122.28.97.102])
 by ocn-dfr-mts-121c1.ocn.ad.jp (Postfix) with ESMTP id 3C4ED1E4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:07:56 +0900 (JST)
Received: from ocn-spm-mts-107c1.ocn.ad.jp (ocn-spm-mts-107c1.ocn.ad.jp
 [153.128.190.238])
 by ocn-ckd-mts-115c37.ocn.ad.jp (Postfix) with ESMTP id 577154001ECB;
 Wed, 28 Oct 2026 11:07:49 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
 s=20240125; t=1793153269;
 bh=iNRiZlu9IC6Rfy+NboV+O7EYNyBmbWYAoUDNx9tgjaM=;
 h=From:To:Cc:Subject:Date:From;
 b=My+oG3isUbV1V4h22cZeTP5vT4Ckiy3BXMjxOyHxazHSZBZSzfM5UCLsEhPLf7d4N
 byQVZrsHVg/w4KmXBVm00MPGXz7BCDzX3ZorvuUbh3Kkeq6JR6Zulv/TkhbQGTRB6e
 RlRnW6d8sK07KHvn706GDz+4ok1KChPJgFt9aqYI=
Received: from ocn-vc-mts-109c1.ocn.ad.jp ([153.149.236.232])
 by ocn-spm-mts-107c1 with ngmta
 id 19cdeccd-18e28f65da036f51; Wed, 28 Oct 2026 11:07:49 +0900
Received: from ocn-sdpx-mts-110c1.ocn.ad.jp ([153.128.117.202])
 by ocn-vc-mts-109c1 with ngmta
 id 9cbfcde7-18e28f65bacba12f; Wed, 28 Oct 2026 11:07:49 +0900
Received: from X870E-AORUS-MASTER.kkp-group.com (p3688129-ipoe.ipoe.ocn.ne.jp
 [153.238.101.128])
 by ocn-sdpx-mts-110c1.ocn.ad.jp (Postfix) with ESMTPA;
 Wed, 28 Oct 2026 11:07:48 +0900 (JST)
From: Shigeaki Asai <y-asai.0816@docomonet.jp>
To: quentin.schulz@cherry.de,
	u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 Shigeaki Asai <y-asai.0816@docomonet.jp>
Subject: [PATCH v2] power: regulator: rk8xx: add RK818 LDO9 support
Date: Wed, 28 Oct 2026 11:06:18 +0900
Message-ID: <20261028020618.2844987-1-y-asai.0816@docomonet.jp>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
LDO_REG9 indexes past the end of the table. Its voltage reads back as
garbage and it cannot be enabled or set.

Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
registers (bit 5), and its voltage selector lives in
BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.

Add the table entry and handle LDO9 in the enable and suspend enable
helpers.

This patch was written with the help of Claude (claude-opus-5-5).

Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- Put the rk818_ldo[] entry on a single line like the others (Quentin)
- Resend, as v1 did not reach the list (mail setup problem on my side)

 drivers/power/regulator/rk8xx.c | 45 +++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 88453bb7bdb..d573d7a778c 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -60,6 +60,8 @@
 #define RK818_BUCK4_VSEL_MASK		0x1f
 #define RK818_LDO_VSEL_MASK		0x1f
 #define RK818_LDO3_ON_VSEL_MASK	0xf
+/* LDO9 is switched from REG_DCDC_EN and REG_SLEEP_SET_OFF1 */
+#define RK818_LDO9_EN_MASK		BIT(5)
 #define RK818_BOOST_ON_VSEL_MASK	0xe0
 #define RK818_USB_ILIM_SEL_MASK		0x0f
 #define RK818_USB_CHG_SD_VSEL_MASK	0x70
@@ -297,6 +299,7 @@ static const struct rk8xx_reg_info rk818_ldo[] = {
 	{  800000, 100000, REG_LDO6_ON_VSEL, REG_LDO6_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
 	{  800000, 100000, REG_LDO7_ON_VSEL, REG_LDO7_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
 	{ 1800000, 100000, REG_LDO8_ON_VSEL, REG_LDO8_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
+	{ 1800000, 100000, REG_BOOST_LDO9_ON_VSEL, REG_BOOST_LDO9_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
 };
 #endif
 
@@ -695,8 +698,13 @@ static int _ldo_get_enable(struct udevice *pmic, int ldo)
 		break;
 	case RK808_ID:
 	case RK818_ID:
-		mask = 1 << ldo;
-		ret = pmic_reg_read(pmic, REG_LDO_EN);
+		if (priv->variant == RK818_ID && ldo == 8) {
+			mask = RK818_LDO9_EN_MASK;
+			ret = pmic_reg_read(pmic, REG_DCDC_EN);
+		} else {
+			mask = 1 << ldo;
+			ret = pmic_reg_read(pmic, REG_LDO_EN);
+		}
 		if (ret < 0)
 			return ret;
 		break;
@@ -804,9 +812,15 @@ static int _ldo_set_enable(struct udevice *pmic, int ldo, bool enable)
 		break;
 	case RK808_ID:
 	case RK818_ID:
-		mask = 1 << ldo;
-		ret = pmic_clrsetbits(pmic, REG_LDO_EN, mask,
-				       enable ? mask : 0);
+		if (priv->variant == RK818_ID && ldo == 8) {
+			mask = RK818_LDO9_EN_MASK;
+			en_reg = REG_DCDC_EN;
+		} else {
+			mask = 1 << ldo;
+			en_reg = REG_LDO_EN;
+		}
+		ret = pmic_clrsetbits(pmic, en_reg, mask,
+				      enable ? mask : 0);
 		break;
 	case RK809_ID:
 	case RK817_ID:
@@ -906,9 +920,15 @@ static int _ldo_set_suspend_enable(struct udevice *pmic, int ldo, bool enable)
 		break;
 	case RK808_ID:
 	case RK818_ID:
-		mask = 1 << ldo;
-		ret = pmic_clrsetbits(pmic, REG_SLEEP_SET_OFF2, mask,
-				      enable ? 0 : mask);
+		if (priv->variant == RK818_ID && ldo == 8) {
+			mask = RK818_LDO9_EN_MASK;
+			ret = pmic_clrsetbits(pmic, REG_SLEEP_SET_OFF1, mask,
+					      enable ? 0 : mask);
+		} else {
+			mask = 1 << ldo;
+			ret = pmic_clrsetbits(pmic, REG_SLEEP_SET_OFF2, mask,
+					      enable ? 0 : mask);
+		}
 		break;
 	case RK809_ID:
 	case RK817_ID:
@@ -981,8 +1001,13 @@ static int _ldo_get_suspend_enable(struct udevice *pmic, int ldo)
 		break;
 	case RK808_ID:
 	case RK818_ID:
-		mask = 1 << ldo;
-		val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF2);
+		if (priv->variant == RK818_ID && ldo == 8) {
+			mask = RK818_LDO9_EN_MASK;
+			val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF1);
+		} else {
+			mask = 1 << ldo;
+			val = pmic_reg_read(pmic, REG_SLEEP_SET_OFF2);
+		}
 		if (val < 0)
 			return val;
 		ret = (val & mask) ? 0 : 1;
-- 
2.43.0

