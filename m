Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B89CA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 16:29:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40855606F5;
	Mon, 28 Sep 2026 16:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UszIWdu9000; Mon, 28 Sep 2026 16:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 72F9B606D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790612992;
	b=geQtwSx725s2q1SBjtbaMYKzntvnmkB4s4QMKlyYVJXF6i/Ky1V2tUAkhcXA7OubU97M
	 SXrCR8XgCL2H5BlNAzbk9TRculYl/eHrAtGBY2+GMn86L3SE2LdKY0wtaieQe+N9GtWVR
	 +2KDcID84CaX+EPSK58GwNPuysrC+1Hw3+Nxfh6fw21UtdIKrn5dUD7xh8juZ4cxdEtpI
	 i8oCGuowAkjwI5T4FVPaA7rXJxfh+VDyG8L/BFeJYzw/xF8dhQVFdBt4S5e5aM0mt6t4X
	 b1lJJkgkYB8AjyQtKDsGQmqW16q9+qhXZVylwQFO35l7GjzC67/HZ1RebT1PhyFrcYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790612992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=24VrbfgzdrU3pspxHkXvmClcyLApGZFyWFLsRp5gpec=;
	b=VmGwk9bpVAQWPuWvUdAKgUWAB3Q6TBH7feS18omgYSmpenij69cmN3HWFyXar8kQ8Zzu
	 2IgzjRg0dirBN34rh/fC5gcmMZRz0YKQChwovreHNtsi3Yhntz5fhiP+Sf9ARoKWb1xpG
	 WqZ1aD+w7mndywVw9IMUKyeSGVT3mAPM1NHAiqooH59+1A3ipuMeQKtdT/9C/ims5RDR6
	 HOxiTmJQW1NhjcXhp8/zQecQtYOF65GmMTO6+B/T5w7YJ1toXRvfrZE1uT+f9UzBOqYIb
	 6buy7GhyxFq0be6fgsFo9P5p+qbadqcsUDeLeGbfO2Ib/nmkugQjn1FwS9KZF0YwMnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790612992;
	bh=24VrbfgzdrU3pspxHkXvmClcyLApGZFyWFLsRp5gpec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=meCXXiHYFzBDFVj2YiWvMeOFrQaFzA6lJ+0p4XGf13+/IGvZTUBSYvK84v8EIsQ1N
	 30Ls5IXv8BSvPJe3T4VuFoJ2snmmEHzlyH9bYV0eTN1CHYTLcJiQQ1VH4/lEBgZmXB
	 8wfU1iTgjRgQ/XfjSOzMoV4IJUdvjGdOilxsgo5bv7Mx9E8MYx0ISnu//4/o78aAJk
	 qiAcOcHxu76Kuf2pVScPQckqTrwpwuHsskId3fmOGldlPXjdRxEbYTYuBfMSs2Iz7u
	 7beAAfAWW67e/sW41H9kzpSreRH2mx3ITNJRXf+85knmDVO+gZj5LxYtJ1hEes0MdY
	 xyc16L2TC0pWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72F9B606D0;
	Mon, 28 Sep 2026 16:29:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B942924E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB1A5400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cpdwur9i1ErA for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6128B400B4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790612989;
 b=nUaYSMy3Tlza9wi5A9l/xC9/K0pDXzP2gYIh2gNz/u9s4pTURJ4yI7HvYqPpwTc7iKDF
 QLAzTyvIVNuwImmwxRxuvnCd3mvFWlWjb4ww4e8GbxYYkHESgR9LRa/gx9H6GxHuAqoTw
 Hm2B4QKNNEOStP67lim1M2ds7D9cTZg0ehizOU8pXrl9rQOGex5VTRh7uHFrtaoFxdnL5
 E5NVaSiz6jvU8qQcPr2vM7nVz6T2/K3PIuCqj6fSRSnwRKdgaAJpXc/FIB0HGVjxwVqPc
 ApaalXo0Er7r2KkCVJAxQDSqK06Huozt3FHWmZb9iFsVX/fE0iNBJJfVLT2upN6mTGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790612989;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=24VrbfgzdrU3pspxHkXvmClcyLApGZFyWFLsRp5gpec=;
 b=SCtelziS2OtKRLerUX+dJyE2BALZQX0pk3hz5RnIoTNQCp+tIp1b5i+y+yZoYrApTPuz
 RvIDiTU2lrHkQMC255jqsSMyx2Z0UjsAzf4jeLBU5cu+f50kALZpbRNkms12uZU97vsCe
 irXZ6IHuvsVpiJblbxpUvqWjaFvksfypPoIwcy2TZdbWlLYrJ1zo+vgz1xnq47QJQKLWK
 tTfIXaSaxGdD1YdFwuGWilDyxsyfd/fLk3opwVm24CYy2jA2tEUp8uE0UyTk93gi3TVx1
 BslfOBYv3XPRMbFwhezbLqq3Ho6eqmtE9howGWBLqnwtXslX6PdAGYqIR+ob3h1Ng1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b="aEQq/4LV"; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=aEQq/4LV
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6128B400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 59C2FB0054C;
 Mon, 28 Sep 2026 18:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790612987;
 bh=G/k01c1ryOujHSGZKWoD/3pOdR5phKA8B9vJCuWOdqE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aEQq/4LVcOD3UXZWzgPQTQ8WdD1ObDF364lMrZrq9ECa1huYSuEqlE6iaHp2FQK5E
 o7SXTg51BB2ABPScAcaXA8h8tTTulMpw7h76VsqBvI0zuypJ3xprkDm34Z6jlrJkUx
 9KbDZz8Aza94jTwEv2rBA2mIvZBm35yDunSOpxqZeVKHyepIOfd1drmbReXqDwKaYP
 Cn0C0U53wqZu3zIuy2S8MonoNmj+bKC06hV28ojct3CtHR1zU1uydDYMch/Cetzdxv
 LBHxdCgfO01vTsTJP+hnenruNY/ypfDhgC83WZSOVW4cIFMdH/ygwHxqwbyCSWQ14T
 gU02zZmQcraOQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 2/4] power: regulator: pmbus: read back the VOUT_COMMAND
 setpoint
Date: Mon, 28 Sep 2026 18:29:02 +0200
Message-ID: <20260928162904.1143614-3-vjardin@free.fr>
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

regulator_get_value() returns READ_VOUT, the output as measured.

On a regulator with a load line (droop) configured, that sits below the
setpoint under load, so a caller cannot tell from it what
regulator_set_value() last wrote, nor whether the setpoint already
has the value it wants.

Add pmbus_regulator_read_vout_command(): let's read VOUT_COMMAND (21h) and
decode it exactly like READ_VOUT, through the chip's pmbus_driver_info and
VOUT_MODE, without exposing pmbus_regulator_priv.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 drivers/power/regulator/pmbus_helper.c | 53 ++++++++++++++++++++------
 include/pmbus.h                        | 14 +++++++
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/power/regulator/pmbus_helper.c b/drivers/power/regulator/pmbus_helper.c
index 1809c6cdfb5..6c76ee91c9c 100644
--- a/drivers/power/regulator/pmbus_helper.c
+++ b/drivers/power/regulator/pmbus_helper.c
@@ -34,12 +34,28 @@ static int pmbus_regulator_select_page(struct pmbus_regulator_priv *priv)
 	return dm_i2c_write(priv->i2c_dev, PMBUS_PAGE, &p, 1);
 }
 
+static int pmbus_regulator_vout_to_uv(struct pmbus_regulator_priv *priv,
+				      u16 raw, u8 vout_mode)
+{
+	s64 uv;
+
+	if (priv->info)
+		uv = pmbus_reg2data(priv->info, PSC_VOLTAGE_OUT, raw, vout_mode);
+	else
+		uv = pmbus_reg2data_linear16(raw, vout_mode);
+
+	if (uv > INT_MAX)
+		uv = INT_MAX;
+	if (uv < INT_MIN)
+		uv = INT_MIN;
+	return (int)uv;
+}
+
 static int pmbus_regulator_get_value(struct udevice *dev)
 {
 	struct pmbus_regulator_priv *priv = dev_get_priv(dev);
 	u8 vout_mode = 0;
 	u16 raw = 0;
-	s64 uv;
 	int ret;
 
 	ret = pmbus_regulator_select_page(priv);
@@ -49,16 +65,7 @@ static int pmbus_regulator_get_value(struct udevice *dev)
 	if (pmbus_read_word(priv->i2c_dev, PMBUS_READ_VOUT, &raw))
 		return -EIO;
 
-	if (priv->info)
-		uv = pmbus_reg2data(priv->info, PSC_VOLTAGE_OUT, raw, vout_mode);
-	else
-		uv = pmbus_reg2data_linear16(raw, vout_mode);
-
-	if (uv > INT_MAX)
-		uv = INT_MAX;
-	if (uv < INT_MIN)
-		uv = INT_MIN;
-	return (int)uv;
+	return pmbus_regulator_vout_to_uv(priv, raw, vout_mode);
 }
 
 static int pmbus_regulator_set_value(struct udevice *dev, int uV)
@@ -187,6 +194,30 @@ int pmbus_regulator_read_temp(struct udevice *reg_dev, int *temp_mc)
 	return 0;
 }
 
+int pmbus_regulator_read_vout_command(struct udevice *reg_dev, int *uV)
+{
+	struct pmbus_regulator_priv *priv;
+	u8 vout_mode = 0;
+	u16 raw = 0;
+	int ret;
+
+	if (!reg_dev || !uV)
+		return -EINVAL;
+	priv = pmbus_regulator_dev_priv(reg_dev);
+	if (!priv || !priv->i2c_dev)
+		return -ENODEV;
+
+	ret = pmbus_regulator_select_page(priv);
+	if (ret)
+		return ret;
+	if (pmbus_read_byte(priv->i2c_dev, PMBUS_VOUT_MODE, &vout_mode) ||
+	    pmbus_read_word(priv->i2c_dev, PMBUS_VOUT_COMMAND, &raw))
+		return -EIO;
+
+	*uV = pmbus_regulator_vout_to_uv(priv, raw, vout_mode);
+	return 0;
+}
+
 enum pmbus_data_format
 pmbus_regulator_identify_vout(struct udevice *i2c_dev,
 			      struct pmbus_driver_info *info)
diff --git a/include/pmbus.h b/include/pmbus.h
index bb85a61e62a..e91d97a0b10 100644
--- a/include/pmbus.h
+++ b/include/pmbus.h
@@ -466,6 +466,20 @@ void pmbus_print_status_word(struct udevice *chip);
  */
 int pmbus_regulator_read_temp(struct udevice *reg_dev, int *temp_mc);
 
+/*
+ * pmbus_regulator_read_vout_command() - the output voltage setpoint
+ *
+ * Read VOUT_COMMAND (21h), decoded like READ_VOUT through the chip's
+ * pmbus_driver_info and VOUT_MODE. regulator_get_value() returns
+ * READ_VOUT, the output as measured, which on a regulator with a load
+ * line (droop) sits below the setpoint under load; this returns the
+ * setpoint itself, which is what regulator_set_value() writes.
+ *
+ * Returns 0 on success, or a negative errno (-ENODEV if reg is not a
+ * probed pmbus regulator, -EIO on bus error).
+ */
+int pmbus_regulator_read_vout_command(struct udevice *reg_dev, int *uV);
+
 /*
  * Look up the pmbus_driver_info of a probed UCLASS_REGULATOR device at
  * (bus_seq, addr) that is driven by a pmbus_helper based chip driver
-- 
2.43.0

