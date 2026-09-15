Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D2C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 17:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E93F6074D;
	Tue, 15 Sep 2026 17:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hmP5LfYRo3r1; Tue, 15 Sep 2026 17:56:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EBAC1606CE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789494977;
	b=qgAuqZ2/k6C1tanFIeEw50idH1p1kaFjFsUSamUjseU7W8L0LHegz82PLhi+csnR6QU+
	 HnPo6Qx5VtbOjZ78P7AtMlvC6TxDfewX4YEx01ZY6yBHTFJJ5GdkEmEEZndLuwblA1Ll9
	 +I1cj3Uwg7fHKBjFMhsFmxRa2eNYPT3VEBOVQaZ/Q66TDdGAIt+JIaLQPZKv8I2+HF8u6
	 x4I8TxbscuKT0HXQqx5QKPoZwmwT/9eYH31/1FSfBbEF8FEy15X9bOWwoquxVx5UPpKiY
	 4ahwXGn2ATss5I41nQAtmx73+/KrW1dfWLUpvGj/iB9Rp0YekW+KICw3wFutj+rcyHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789494977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bVQ8SpH6uU5wwbav3vOXspJUcgMuBasJdOt4Mtx2hGs=;
	b=p98rshxUNfj+y29ZWF4sVrBic2UUBQQIDKw429qywNlP5Lhr3fmhEgTLuLc3cl8GadMq
	 Q3+tLL3nhaTQ4FMh2qtprEOLxIDk3qAX3v1m4NOXQa9uN6PvdytpdXNU68vN23ZhN2JeV
	 kNC9SGlHYDrpVjFnnqJ6ZrR+BinsrZO5siSg30AdKgUy4vehBZCs8YJ8RG5unvJmoaDDr
	 wrsJdoCJsvDFDD7rc1emcWd8m4x9gD+/gJAQuTVzcgJgrTPZs7FFO2LTXcgl4kZ151H6m
	 QMs2EEDex50lpRCzY1+04adLv0EmguYUOdHcJ6DrM0ppNdS/fN+3dH5xjA7fLX9mbGQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789494977;
	bh=bVQ8SpH6uU5wwbav3vOXspJUcgMuBasJdOt4Mtx2hGs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZTqqmORBCk+QUHh5Qss58kjO+BRYwStok+ztE9ell15/1CtgOoAhS9b+D7a+AssDF
	 IFQbr9K11tvu0CgWVrvH3MEdnPUkcpCsO0XGKSrXWoU3XGdpbU1kdGahsDyVQgu5JB
	 wnfFHVyZdeTCnqLBCIsbvDsWDXBdvZTjYua/okUS6tVoyTzlJw5Ck8k17hlIV7nf2y
	 212eRlRk4M146e/kygxwAWMYSs98kN99/MsFUA7N7BCHiBXlzY33oyuRafawArgyjB
	 zP5xyHS/LkxGVFwg/6MZCVH4SKY1sFTMnK7PWMYoOMVeFjRc2D7R9rRRZw+PFmdnd4
	 SM9OSDAJkQkew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBAC1606CE;
	Tue, 15 Sep 2026 17:56:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F8F82E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 17:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35190400FF
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 17:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNHfgR8Y17e9 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 17:56:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B4F19400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789494975;
 b=sVdpnlR3PH3bOgxMfQg+yCK1ikxPbDD8DwConuJYu/3ZN24RSUvHthTKXcKEOgjZnDXY
 Kn8qrYRCXDxIyyWkoAdIssNx8oJatQRROekTympWULaqLlpusN+/MIZVonfQDCsc4QlgC
 bEFbQkntirRwYM7hU0wbtzmt+nin2FUXGHdUkBWPrTu/Cyw70MoACArcwtrQndvXlcW0h
 V1R9CDupaYrQDMo9fuwTgY9W/vstx7P7MSDAl+9upVctbgqLuQiVh3ZhsRYnw3Eq14EPh
 GC+sLe9B05A3ZJVi1+VfVUWP7Ui/xBwl25K+QoNc22pod40XkwUfcUAOq43t9vt8waw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789494975;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=bVQ8SpH6uU5wwbav3vOXspJUcgMuBasJdOt4Mtx2hGs=;
 b=lmwjN/blrMX7afwVd6rdDF5WMffrzi0H1EVsfVamemGt3dLB4qAaMF39g559/2HRKkeo
 qwqfKrRea26pD0NLZDCcqSHUWgcueosnqFhWelUfnAmRTtA0f7WzIyTRT5o1zFXzjgOMQ
 ArnQYAMVbmgViDRBsUYGiVktiI1/PKjLJ7JLnNzGWUmSRCVt9oTS6ScHNufMoVRg6R9Rv
 1LtS8lgrNMUrjnBtOP9iezSXbUVr7eaV22ZRc0QorWTXzRDorVidCY0ehWykmicOJ5kRw
 3o/6yN+gLkpjz8eHwOw9QYzkra2O/Pz0xdU0AYNzlBKAuYXpwzy8UnVh5jxElyso7Ug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LN7Y9tWc; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=dsankouski@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LN7Y9tWc
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4F19400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 17:56:11 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a605c198fdso145070a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789494970; x=1790099770;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bVQ8SpH6uU5wwbav3vOXspJUcgMuBasJdOt4Mtx2hGs=;
 b=LN7Y9tWctazNUh86JsC7vNQMEuIvKv4s67sln1sC3gHpDUFQcVuTOfmRbqLwbK99Zn
 TuMAUr1nga5ZLFA9gIHyLl8J+ID8OEI4WoYf7NjEWOgdMbvJxP7QyP12wnD0wZZB8gcf
 RcblcOoUWezGUb3ygkBuR7k+UBT2TBLeccJlt/hMFO/GFRUgoUJRSXBH/cDR2Vfa+aBK
 0Dpo1mNZcBhmDQuDdxITjC7S5KcHe/hAq5uSUKG/P12tdgo0IQrdZWCpnil5Ps9AX2vD
 J+7h80FBLaLZM16JGtifikjOwwEaBbQJb2YPr5k+IvWtDv/VecGJVa6hrVL9RcpDIydH
 EbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789494970; x=1790099770;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bVQ8SpH6uU5wwbav3vOXspJUcgMuBasJdOt4Mtx2hGs=;
 b=YdDeNEM9DaMXhXmslXplpSiZ7fxKiiWCOopV+KL82/3VY3UObG+xNJX00EA5SL1ldr
 4ei83VkidNnBgj7U11EM19hAhBsJ1AVk7cYShimbQdP1ZsswJHdz+kN7ADyjq+Gr/vEf
 DLZVpj3lLE0Z7xul7KjAJDExLVyFBDt6BKBpMX3xbbJZ585KM8Mh0msfSGuummB6Hvqg
 RK2M4eamt7+ry+KJLXGzFWJ2LRKvnHQjljHISpVGCAwaT47ZCYgaB1Nos0oVjiYO1SdX
 AKzgXGO47RlCyCXxTesyW4gDttBfCDVkFyS3MVxsPpvncv42NCm/ngsbJlZzhxq/0qk+
 HtQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMPZuEe5d2rfgHdufrhi6HuRY4R3w0dUPM/Tcjs6gZbhIQDkRhzYh0GrHKopIzLzlOJ+kct2I=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ki61OYMlIBC9+JWOYXSj8yVh3saTvHPGHMJWCzPPP7qyLhvngH
 wK+zVB9xcpchJwnb4Ost6nBneW5DHDlsmc/yrCLGGM+n2oZCn1FkyV2r
X-Gm-Gg: AYBFou3hIMnh6zY1yPewOJ7Y40ohBfUndCRlVNPkEs7xT3q64jx5e1olbMa5bdnCRv/
 Nb6Iyqk2eM2B7D0GdaxMA+djkcDJ+eoXQq7DfNNHj88D5gIBp9OknZCHxk/bKUg0xMYIbz5pSFf
 7EY6EW+xSI9XCSuAguJq7rOfYEtw40NFrUCm9n/gzA7lkVOjaa4QYV770YsF+TX5z55YWTgY3vA
 zU3X3wo3aBQIx9AdQq/5zEM1cXYL06fB5/ygC+k797v+W3X/tikG48UpMmBlrC/KFOq6i/tchJQ
 Lomnh2ozP08gKmdnqiY8lQz4uNqMRM9T5iR2ivIabSGGKPf0er6GPPQqVo87/CVAM4XjYWbkRcE
 6uKCed35PQPZ0ByXc7viwPcQ/vZpW77LDcY5nlsK50z4ZDCuNwGWOyimtEL5t8h1mFBXK2RcYBE
 WpkTE4y00+ONykkXguyHhp1/fvtYyBhEghr92kHSorKlJ/IBmFg2rRN78rKMoe089Xtolp
X-Received: by 2002:a05:6402:3245:b0:6a9:d755:82a9 with SMTP id
 4fb4d7f45d1cf-6a9f626d30fmr4223510a12.24.1789494969399; 
 Tue, 15 Sep 2026 10:56:09 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.239])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2a272dsm62660a12.28.2026.09.15.10.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:56:07 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 15 Sep 2026 20:55:52 +0300
Subject: [PATCH v2] regulator: qcom-rpmh-regulator: add support for PM8998
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-pm8998_rpmh_regulators-v2-1-14542b548859@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKiGqWoC/42NQQqDMBBFryJZN8UE0aSr3qOIJJlRp5gqiUqLe
 PdGe4EuH/z338YiBsLIbtnGAq4UaXwlkJeMud68OuQEiZnMZZlXuea24JNXWqsmTL5vAnbLYOY
 xRA6irKwC7awElvwpYEvv8/tR/zgu9oluPg6PRU8xmZ8zvopj909nFVxwAIUturIwLdw7b2i4u
 tGzet/3L4M0s3DUAAAA
X-Change-ID: 20260709-b4-pm8998_rpmh_regulators-d167b8d9cb2d
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789494965; l=8185;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=wbsoqwnb9unG5UjvIRjecYWq48yu08ujsu6s59kJBAU=;
 b=QjBTrKSM7QIAB+lLbpwkaH1svVMiNs5J3UVukJ07hGPE0qgXOE4YxpZOCho5PhHwbjvllDA3B
 SeiMeNldUwDBh+IScrSVO3orQ0Vv73+XWV2pMMLX70C7SyieAryKBdG
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=
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

Add the PM8998 regulator data found on Qualcomm platforms.
These regulator tables are imported and adapted from the Linux driver
to enable support for these PMICs in U-Boot.

Linux source: 46fc033eba4 ("regulator: add QCOM RPMh regulator driver").

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Add the PM8998 regulator data found on Qualcomm platforms.
These regulator tables are imported from the Linux driver
to enable support for these PMICs in U-Boot.

This is used by starqltechn sdcard.

Linux source: 46fc033eba4 ("regulator: add QCOM RPMh regulator driver").
---
Changes in v2:
- Add linux source link in commit message.
- Link to v1: https://patch.msgid.link/20260709-b4-pm8998_rpmh_regulators-v1-1-dd8efec64afd@gmail.com
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 133 ++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index c458f227bed49a6ce0e1b396f1ef85d4b80ab6bc..caeba4c8ee6ad2d7071a6e6c913444420f682480 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -464,6 +464,26 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_bob[] = {
 	},
 };
 
+static struct dm_regulator_mode pmic_mode_map_pmic4_smps[] = {
+	{
+		.id = REGULATOR_MODE_RETENTION,
+		.register_value = PMIC4_SMPS_MODE_RETENTION,
+		.name = "PMIC4_SMPS_MODE_RETENTION"
+	}, {
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC4_SMPS_MODE_PFM,
+		.name = "PMIC4_SMPS_MODE_PFM"
+	}, {
+		.id = REGULATOR_MODE_AUTO,
+		.register_value = PMIC4_SMPS_MODE_AUTO,
+		.name = "PMIC4_SMPS_MODE_AUTO"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC4_SMPS_MODE_PWM,
+		.name = "PMIC4_SMPS_MODE_PWM"
+	},
+};
+
 static struct dm_regulator_mode pmic_mode_map_pmic5_smps[] = {
 	{
 		.id = REGULATOR_MODE_RETENTION,
@@ -484,6 +504,24 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_smps[] = {
 	},
 };
 
+static const struct rpmh_vreg_hw_data pmic4_hfsmps3 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.n_voltages = 216,
+	.pmic_mode_map = pmic_mode_map_pmic4_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_smps),
+};
+
+static const struct rpmh_vreg_hw_data pmic4_ftsmps426 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
+	.n_voltages = 259,
+	.pmic_mode_map = pmic_mode_map_pmic4_smps,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_smps),
+};
+
 static const struct rpmh_vreg_hw_data pmic5_bob = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -563,6 +601,52 @@ static struct dm_regulator_mode pmic_mode_map_pmic5_ldo[] = {
 	},
 };
 
+static struct dm_regulator_mode pmic_mode_map_pmic4_ldo[] = {
+	{
+		.id = REGULATOR_MODE_RETENTION,
+		.register_value = PMIC4_LDO_MODE_RETENTION,
+		.name = "PMIC4_LDO_MODE_RETENTION"
+	}, {
+		.id = REGULATOR_MODE_LPM,
+		.register_value = PMIC4_LDO_MODE_LPM,
+		.name = "PMIC4_LDO_MODE_LPM"
+	}, {
+		.id = REGULATOR_MODE_HPM,
+		.register_value = PMIC4_LDO_MODE_HPM,
+		.name = "PMIC4_LDO_MODE_HPM"
+	},
+};
+
+static const struct rpmh_vreg_hw_data pmic4_pldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
+	.n_voltages = 256,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
+};
+
+static const struct rpmh_vreg_hw_data pmic4_pldo_lv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
+	.n_voltages = 128,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
+};
+
+static const struct rpmh_vreg_hw_data pmic4_nldo = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
+	.n_voltages = 128,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic4_ldo,
+	.n_modes = ARRAY_SIZE(pmic_mode_map_pmic4_ldo),
+};
+
 static const struct rpmh_vreg_hw_data pmic5_pldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -837,6 +921,51 @@ static const struct rpmh_vreg_init_data pm8350c_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pm8998_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic4_ftsmps426, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic4_ftsmps426, "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic4_hfsmps3,   "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic4_hfsmps3,   "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic4_hfsmps3,   "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic4_ftsmps426, "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic4_ftsmps426, "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic4_ftsmps426, "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic4_ftsmps426, "vdd-s9"),
+	RPMH_VREG("smps10", "smp%s10", &pmic4_ftsmps426, "vdd-s10"),
+	RPMH_VREG("smps11", "smp%s11", &pmic4_ftsmps426, "vdd-s11"),
+	RPMH_VREG("smps12", "smp%s12", &pmic4_ftsmps426, "vdd-s12"),
+	RPMH_VREG("smps13", "smp%s13", &pmic4_ftsmps426, "vdd-s13"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic4_nldo,      "vdd-l1-l27"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic4_nldo,      "vdd-l3-l11"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic4_nldo,      "vdd-l4-l5"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic4_nldo,      "vdd-l4-l5"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic4_pldo,      "vdd-l6"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic4_pldo,      "vdd-l9"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic4_nldo,      "vdd-l3-l11"),
+	RPMH_VREG("ldo12",  "ldo%s12", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo13",  "ldo%s13", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo14",  "ldo%s14", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic4_pldo_lv,   "vdd-l7-l12-l14-l15"),
+	RPMH_VREG("ldo16",  "ldo%s16", &pmic4_pldo,      "vdd-l16-l28"),
+	RPMH_VREG("ldo17",  "ldo%s17", &pmic4_nldo,      "vdd-l2-l8-l17"),
+	RPMH_VREG("ldo18",  "ldo%s18", &pmic4_pldo,      "vdd-l18-l22"),
+	RPMH_VREG("ldo19",  "ldo%s19", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo20",  "ldo%s20", &pmic4_pldo,      "vdd-l20-l24"),
+	RPMH_VREG("ldo21",  "ldo%s21", &pmic4_pldo,      "vdd-l13-l19-l21"),
+	RPMH_VREG("ldo22",  "ldo%s22", &pmic4_pldo,      "vdd-l18-l22"),
+	RPMH_VREG("ldo23",  "ldo%s23", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo24",  "ldo%s24", &pmic4_pldo,      "vdd-l20-l24"),
+	RPMH_VREG("ldo25",  "ldo%s25", &pmic4_pldo,      "vdd-l10-l23-l25"),
+	RPMH_VREG("ldo26",  "ldo%s26", &pmic4_nldo,      "vdd-l26"),
+	RPMH_VREG("ldo27",  "ldo%s27", &pmic4_nldo,      "vdd-l1-l27"),
+	RPMH_VREG("ldo28",  "ldo%s28", &pmic4_pldo,      "vdd-l16-l28"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm7325_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps520, "vdd-s2"),
@@ -1010,6 +1139,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
 		.compatible = "qcom,pm8550vs-rpmh-regulators",
 		.data = (ulong)pm8550vs_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8998-rpmh-regulators",
+		.data = (ulong)pm8998_vreg_data,
+	},
 	{
 		.compatible = "qcom,pmc8380-rpmh-regulators",
 		.data = (ulong)pmc8380_vreg_data,

---
base-commit: d27c992cebb95bd903d09f3d1da55032a7a145da
change-id: 20260709-b4-pm8998_rpmh_regulators-d167b8d9cb2d

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>

