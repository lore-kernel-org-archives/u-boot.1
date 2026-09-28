Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FFCCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 16:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51526606EA;
	Mon, 28 Sep 2026 16:29:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fpJWJwlKZfXS; Mon, 28 Sep 2026 16:29:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A4930606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790612974;
	b=NDMTgkq+twfiTLr2WX9eSPBJJDkJsXLmHXgUf6tsy1BtjySHrxf1ut2RufiJUo232sfA
	 85dNi2eOVzJHU0PM+6IhCqLcf/WoxZbgegiKPWJw+BCU8TXr+IJ6NSwfynMCfZflIUNKh
	 Z2fUFKLJoOldCI/Nn6KemZhlXG1ITJxla3jDVMAzz0yS231QOwxbknSp1Z9jRenWF7TEd
	 eT6KjILhFDK8/9YVFfPHsyWOPEqFMqubnjeGlbwWHA9YiK8PPYD6o1XRhkne4ybqdhriY
	 0IVlrUu9MaHDP7lUXaxgM2xfe0cDWB03VMvK1H7DyParXUAS9uBimiNIEGE3obMxhCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790612974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=54PfNBVw9Mgz5Ebz2CcO1nEk5ADAZrgjM1MF6Ph6ubM=;
	b=VDzUVix1WyikxsPVca/QAs7CWvqZOeht0njEDnm4ZzcovWuXNtJ8scm++b5GlAx+lDnw
	 GXZ99EKfU3QFQjOtozpFTIr7HPPosE0giCRgUWAnD1QpIPZ7bK3RnBI34n2nfUe9mLcqt
	 4ZGPUmQVOrVIIBP+B3iW5WnC/i7GRDErakPdObDWykaoJVNrXc3uRc0sf3OSHSo40rmqz
	 Ib4oxLzdzbIoHNvUkET2T+wQODUU0bhuJ8ABaB/518IDBoHhkczNbpAYrQRpCydSMM+ct
	 EcIJ+rAP3SsmcToRVdNX/AIq3/aG3V9+hnkm4RBzdDUFkzukYRiCf5kEs6tpLi4m8eA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=YcwJ+who;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790612974;
	bh=54PfNBVw9Mgz5Ebz2CcO1nEk5ADAZrgjM1MF6Ph6ubM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHNrBKbVNyBYDmiWp4GyIk1Mq3J+LEzNgC1+9m9MgIFu4YZvRp6hz+SNPAmDqdnGj
	 Rl6CFEKXVPGzfeJsoxik6ljuzLV6JLNVN1RviR5bEjOkXih/Xs758qg9YJZm/yLho6
	 kQVdZw05pvJCfK7ZFW48GbtQU7z59+yihok+JRCkU/U1iGk+/5Zrx35OYgulP+JL7B
	 O8nlBSuUaOH+ig5oAybkm5rMgHEH6vR/b1+hmzPx24ApPgGwHiRUwjVXCa1UXLT1oz
	 nf/LvK1Up+yANYtWMuDWDq6EZ720w2OAmph4zMCchlrJXXUpXYF5XvdDHgXtAUHgZE
	 Lg/WjC0yszTHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4930606C2;
	Mon, 28 Sep 2026 16:29:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8844532F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E8BA606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XFs3G9UPK44 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A12B1605B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790612972;
 b=Dw4k7Ub9h9+dRwzjEVB3JsAPT9/Y5lRuieB0PMZykgM4iAyormzMzVaTuP/WY4z6h/gT
 MuncRSRsw+KuWf/l9ZRuEWDXIiFp6cAKLy5kkxT1oDSEB0Xi4E4ax5YGvy1KnI3cTB53H
 Pk7P8DZo96M3MNMuim1uiVEAjLj5VgeMyxvFgBdFDOxWlGHHPnWZxFooSrw5kiXJyFIF7
 SIB8kP8N6NLnR+WSAV6ATn2xFFUt2yyQT/hYn3Wybpe9aG4pjBtjoEk/Aos7Zcs1GUEY4
 AO6kcH21MRjVzQ3ooVs2WVIggPIxGqmMN1wi9xWY05Bwgv+5Qa6QcfwVmsFITDSzS0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790612972;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=54PfNBVw9Mgz5Ebz2CcO1nEk5ADAZrgjM1MF6Ph6ubM=;
 b=VbWlX7T/0fTWW/MhPkl5r0Cra2sEuafHiHeoyWWB4TekcuC+lmZGUoV9/qMNOdJkNkbQ
 vVdeIWGMMxY8QW35KwANdkqw6yRdSwuW3CcNhaHrGcUVjhRvFHm5MHtLM+0fkKdkTeuLI
 O22jdGS9cl2BH1yh4fYfI4a32w2f+A+ERQQ3GJGQq+GWuEgStwTP5f3QB2rfcWoDnzNeS
 K1bYsNTgf0eAtrcEIHHMB5O6OqW8zdtLAPkARMqBnnQEUfshRJDLv5Kg4aKV4ZksS7FRJ
 8D9KfxDAWqkvEW4zF4sfNg9ij4/XoqzZt2hb59+HnZNWyUwGWJxM2boIwWbuQWtKmHA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=YcwJ+who; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=YcwJ+who
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A12B1605B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 752FBB00576;
 Mon, 28 Sep 2026 18:29:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790612970;
 bh=04ME1mEMXoB4WoHNRouiS2d20nQ3cAn9LdQ32jAo4bA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YcwJ+whobGvxZYpUnn0RE40jolXcyBPot2OgkTCrH5IGHfZF2subsF0kZV92cAAnA
 lH5V9MORzYdHF3HoGGdl8fWob0+K8VexWFAn3WLBq8jD5IWZrmcl1RtVFb5Ih8etRT
 qF4ZRMHWpc7RiyIhIMAIzA7ZFp5luD6Pnw8VmHjW/VL521j+e5S9SzKpj38l7V6jkc
 gIbkknGKz0GJ/zlpVxkO34aovNK6qJxjMhn/OA+p0T7RKEm7XShgIv6jEjyzVoALh+
 xcBu2g0OuyfClYCpmyCJ9+JuPK9jXJ4CPWmpBe1EJLgki0oiuWpoKYab5LYliQOtNQ
 1DOJ6PzkdaODA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 1/4] power: regulator: pmbus: check the device in the
 exported helpers
Date: Mon, 28 Sep 2026 18:29:01 +0200
Message-ID: <20260928162904.1143614-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928162904.1143614-1-vjardin@free.fr>
References: <20260928162904.1143614-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

pmbus_regulator_read_temp() takes any struct udevice and reads its
private data as a struct pmbus_regulator_priv.

Add a pmbus_regulator_dev_priv() in order to return the private data of
a device for which driver uses pmbus_regulator_ops, the ops every PMBus
chip driver installs, and use it in pmbus_regulator_read_temp().

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/power/regulator/pmbus_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/power/regulator/pmbus_helper.c b/drivers/power/regulator/pmbus_helper.c
index 4763470442d..1809c6cdfb5 100644
--- a/drivers/power/regulator/pmbus_helper.c
+++ b/drivers/power/regulator/pmbus_helper.c
@@ -144,6 +144,15 @@ const struct dm_regulator_ops pmbus_regulator_ops = {
 	.set_enable = pmbus_regulator_set_enable,
 };
 
+static struct pmbus_regulator_priv *
+pmbus_regulator_dev_priv(struct udevice *dev)
+{
+	if (!dev || !dev->driver || dev->driver->ops != &pmbus_regulator_ops)
+		return NULL;
+
+	return dev_get_priv(dev);
+}
+
 int pmbus_regulator_read_temp(struct udevice *reg_dev, int *temp_mc)
 {
 	struct pmbus_regulator_priv *priv;
@@ -153,7 +162,7 @@ int pmbus_regulator_read_temp(struct udevice *reg_dev, int *temp_mc)
 
 	if (!reg_dev || !temp_mc)
 		return -EINVAL;
-	priv = dev_get_priv(reg_dev);
+	priv = pmbus_regulator_dev_priv(reg_dev);
 	if (!priv || !priv->i2c_dev)
 		return -ENODEV;
 
-- 
2.43.0

