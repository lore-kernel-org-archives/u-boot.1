Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD53C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 029CB607F3;
	Wed, 16 Sep 2026 09:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G0JYFhTOVpkC; Wed, 16 Sep 2026 09:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 24A826080A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551473;
	b=L9thhtyxbJXDqmbgoSakHdfIewtece/Jg3GxrK6EG8aWPsdpGJqA2SLuHxXZO3kQmFIE
	 Pl7M9sneogNdbBezx+T2/kXvdvyFIChnjYpDLynGJi+7Go0RrtS1rHvSgL/Rk3W0bdE7x
	 KtKH1GHdsMw0t0GmAwOK0cMmvPkLL/hZi0vr+V9NNk38GlYB39l+7Jw33DY8U+FKoQ/S1
	 zqiJgjVUGF6kfJ5neDgGPIwDBipvCd89zWbO6gOXOAJtklwNIalSCk+u2oDsZDCTEGzOa
	 TmKK2AVmKlb9C9SLHFxOooNFpr/fLngGneGKCN5lwjnhdRCe9ak4cnlkBOa+CgiyIdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RWfyM0/B7X2CIlGjgm8bffdzdGRz6odFHXMfnoP2j54=;
	b=FFu5ww531aPQ2u26zmm74sY5Bhi5JK4yHYRQxgL23GOrKEXkHVSYnIcNdiXS+2ECx82a
	 nG7vFwto/TZyUUSt+eEkZ3f3zadwKPdhE8f/ZjaGukH2cShOwwWjTP0/nnbdIyBCvSKZt
	 JsPAysZo+4uf+kLwPUgt1BB8H7LVi/54trS+azucCSz9nZkY20NwoPElo9hXjLR0+7Z2x
	 /lvQPldz+OnFthMgyxslv/pzIgUZtMGbk073KZrRLQRMHN8N+rM9DoyIzFRYLkaNh4uqA
	 8SBraLk6ds/ax6ELXEHTpBmb640vpHuB3Un9WfqEs10gKqqT1mA5pdqQ2IuX4VlvnBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJa8tbgz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551473;
	bh=RWfyM0/B7X2CIlGjgm8bffdzdGRz6odFHXMfnoP2j54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DyRP+tpwX3wKOmGzANoHzg67/o1NyzmzoyoWKfjPUuQUnvKJUIMBtSS3wtxPgBctD
	 2nKMktUoVYNuoYh2bKhNVBYnl4UaQcm4SgtSK+VWJJ+swg74Tq2Uw6n7ZOUz15ZDul
	 EBKw13yIZC0TX/Wds7wLfqHYqybtpEkWkWkF1fkuaLgtuwqihVJ63qon2O3TVjdKuH
	 wXcm5AEZMU6n5jiWrhaGviahHl6tJ/R8tcIN9Id7zQrgq0QrAnBMj87SMNHNKFLRRo
	 U5VZq/aytAQJOtQP7hY3PReFa/2RVwW4Oxjcs2FWKu0x8U9qgKo8EOz2YUwC6dND6C
	 hz0YAtWE65n5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24A826080A;
	Wed, 16 Sep 2026 09:37:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2C31224
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96BFC607F3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rghWx7-HAq4z for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EC41F607EF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551469;
 b=EP/frmepBilakf257bpNn3aZ36e79jl8ITH5kbrtbIeLmSPGIBxQWrkbTPFPTTyieqW9
 gdaiSLVM5HhgSCtd+5QEFxVs0EouT2TM0TNJATJDee/+XjNCjPxoSKUdQqWcfCGj1nw2V
 Obbq2orc2lFwy3Y5zSQsOMgdtZCFQ2ecXycI0rPdB6N9S3zDNGLJlrBKyXVvU3UMDzAcS
 CWOujm5ZRNOsCUwhDavsuPgyCbYx9J2jiMSsoYCf3gf94TpEtYQvUcizuP+4i6mKUZFX+
 Gfa3orfrLHkKvswgiQ8WXPvlvf3t1E6BirlFHgXVwMsrO2YA0JpFnFIFPuGHjxN6biQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551469;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=RWfyM0/B7X2CIlGjgm8bffdzdGRz6odFHXMfnoP2j54=;
 b=iHBqNKOGNaTnV93LNnMyQ4iQxHpO4IddfwsgRzrMRhuO0/g9Nq+m1KtGefbz4WRbfrry
 ehPlPRZJkDmoKhdaOpQUH9SOSnleAg4We5Amns5K6Hn04eWb9u3OwQt/bRE2N3bgY/KbX
 4hwmyJ4aYoMFBMq/NK38gMSYkAASQr3CqpEAIFjhwUmEqdZ26ogNdzuF8GtHyIu73Jz3h
 1xQkfNLybSaE2qTdmWXYUY34hgdl5+QuQ6Q31V+1dqnHSiKn6TDLFPtnNnb2BTEAPLi3J
 QfQbMQmS07EW1J1GNliLx1tG+5UJ8PPyqEmrD12xD73ie1wfU1pRj4sViSHjqmMx31Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iJa8tbgz; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=iJa8tbgz
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EC41F607EF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 241D943961;
 Wed, 16 Sep 2026 09:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B641F000FF;
 Wed, 16 Sep 2026 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551468;
 bh=RWfyM0/B7X2CIlGjgm8bffdzdGRz6odFHXMfnoP2j54=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iJa8tbgzPZLlT8UhW1+fDkrInwMR3k1BEgeHRxC5xWxbA6r/HL2jvopUtUo2ob+hD
 /LHyq935oMXEaLg6TypcuZDZdx8j3jU1E8SPbFKi+5GcJKsxQN9yuhzqNRIsR6+Dk+
 2WXGZx/X+Jxx3N5GAZbU3JZ3EVvRnG0kghCLnoLmOZsGovbnglPutSIKARRrwPKrUB
 8Vx76zF744pZBHcGna89DQuCXNkR6orfG8FQsJFzFi9J5B4leG0LrcVIRLqW0JAfIp
 MUBhZteLd3ul8KLP81HVcrL85XRXxG3QzD6LZDQbEQdE92oey2nuhzYfDs28Wf5in1
 TeAivSegNScSg==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:37 +0200
Subject: [PATCH 5/8] mmc: arm_pl180: Power down card supplies at OS handoff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-5-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

PL180 card supplies remain enabled after probing and while U-Boot is
running. They are no longer needed once control is handed to the operating
system.

When regulator support is enabled, mark the driver for removal during OS
preparation and disable its VMMC and VQMMC supplies from the remove
callback.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 8627196a8050..9c18b666e4d2 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -50,6 +50,22 @@ static int arm_pl180_set_supply_voltage(struct udevice *supply)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+static int arm_pl180_disable_supply(struct udevice *supply)
+{
+	int ret;
+
+	if (!supply)
+		return 0;
+
+	ret = regulator_set_enable_if_allowed(supply, false);
+	if (ret == -ENOSYS)
+		return 0;
+
+	return ret;
+}
+#endif
+
 static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
 {
 	u32 hoststatus, statusmask;
@@ -494,6 +510,22 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+static int arm_pl180_mmc_remove(struct udevice *dev)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	int ret, vmmc_ret;
+
+	ret = arm_pl180_disable_supply(mmc->vqmmc_supply);
+	if (mmc->vmmc_supply != mmc->vqmmc_supply)
+		vmmc_ret = arm_pl180_disable_supply(mmc->vmmc_supply);
+	else
+		vmmc_ret = 0;
+
+	return ret ? ret : vmmc_ret;
+}
+#endif
+
 int arm_pl180_mmc_bind(struct udevice *dev)
 {
 	struct arm_pl180_mmc_plat *plat = dev_get_plat(dev);
@@ -557,8 +589,14 @@ U_BOOT_DRIVER(arm_pl180_mmc) = {
 	.of_match = arm_pl180_mmc_match,
 	.ops = &arm_pl180_dm_mmc_ops,
 	.probe = arm_pl180_mmc_probe,
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	.remove = arm_pl180_mmc_remove,
+#endif
 	.of_to_plat = arm_pl180_mmc_of_to_plat,
 	.bind = arm_pl180_mmc_bind,
 	.priv_auto	= sizeof(struct pl180_mmc_host),
 	.plat_auto	= sizeof(struct arm_pl180_mmc_plat),
+#if CONFIG_IS_ENABLED(DM_REGULATOR)
+	.flags = DM_FLAG_OS_PREPARE,
+#endif
 };

-- 
2.55.0

