Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949C606A31E
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VspIiwdJ;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=awtNGDpe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7671640718;
	Tue, 27 Oct 2026 09:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1z1Rhi-oiTLG; Tue, 27 Oct 2026 09:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3C1E04071F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094029;
	b=sgYze/bgn2lciwBvArajRtKxvw+t0KPWaJ5OgYOweHrXr+JbiSmj7jhhxDXqCsHt0QqM
	 nOWGio40MNOqXYTB224q7lpy07LtQFvpDj2kSxqlZoaUFr++jIwOs8snhkr5O+ZCvf8pu
	 EbLWxv/MGR2zM4kP08qEAhd7r0B/8/cLuKAJ6A/Axvl84ZV45N8e5BTGOcWE+FornLVVy
	 1Jktp/KGcvRLnefz54LqxM0fLPBgrPkE30UQO5Q4DX9hybQQVHI20Yj+iRO70BfkwkmGQ
	 HwDyyoSE6bgGZbLaaWsMx5ZDKF2WvvZv5C8uKLi8JtWDmC0DRahUD4ySegsaUdxwGJA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ldsPH+oCTvZB8ilQ1OWKDqQYmDjOHAHgObH/YioUpYw=;
	b=Wnjf75B9yn9JJlM5pkFLZhduN1NwN/GszqTTv2fC4Eq3NMxnlIZocYBb9Nth8RbW7fve
	 xPKtfYQSfMTDpvmspqbFeHpKUUeQVD4BG08pFSxHoRdk2bnx/WXvU/9iU/V7CyxD7bCYz
	 +ZETHH/32F48hRZ8k25bQNHQCLLy1nLWbJo0IbDDqGcTiejrIjiaXE8hyQ2sYgeDGdQtF
	 E16yasek9Adi0AqZDifUqbJibXd6lLuJtDWGUQbAaCqk4uj62Obdwie4ZL72+thSzO4uS
	 KzPSGb2TKQPpv+9DZuiv2sk/wYaKk1JdvZqSHosBfJ/Nzh70jiINuKLxnE7+OziZDWQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094029;
	bh=ldsPH+oCTvZB8ilQ1OWKDqQYmDjOHAHgObH/YioUpYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VspIiwdJxmXAcukeFTQluW/1Fx+o51ql7SlFxBC6bzyEXjBLu2sLIL2ZOsPhgeJWn
	 LDF8zB16FID15YAfVh5n+ZXiqKenJOuKNJ9PMx6l/xKoSXihj08C8V6Xi/SZcCwmGv
	 imBfc2JTSJs02LLIgcdJXlmo35xQooQZ0khKEUFrNh1V3zCkrhz0Z+7SZjVFqjxBGq
	 rdAwPFsSMTqqW97//dMuUiggjWR+BQwDXogIM/V6FJWTqCJRd7tbk6+LkU045VbUyk
	 Fij8pNQRi7UMt4EuwCD6SPoHRXiYNfybTyK6GTzoPWhFR2Db8tyvKxwV/pqqCmriwz
	 OWQkBfXpbRHXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C1E04071F;
	Tue, 27 Oct 2026 09:40:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D09F279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F30F606FA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXrRe_RlZ6Wx for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D20EF60711
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094019;
 b=NYTpf0ygrA6t58hAOw8eXCWJNdFQ8WxXwljiEyJArjeph34mUOwLeNF0MpGZo5pP0eW5
 nX2wJaBztTYf2/eIuASXjkVK9TDKsrUul8hezrKA1xk01ULyZuUwsKqU6EH5DURzUABaF
 tD9P5wfAeALjcOALhUvDcWARkpO6Wthi32hQL/IkhrAdxLH5Iaqkqa+BSCYSo+qk5sjEC
 th3gS5WANRkNXcnlx/Vn33uVSN+yuXPHBBR0bvJCijBTuO7viKW1nVOg1AEio3aZMd1yl
 lyXxumBgp25WDVBXDiKoldBypt/5xg+D6tk7yekEx7JT+FkdC65zjw9/g6Z/Mzh4Wdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094019;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=ldsPH+oCTvZB8ilQ1OWKDqQYmDjOHAHgObH/YioUpYw=;
 b=dMdf9IezR8Gf0WDxf7ZrZw3bxHJJBs0WXu7fsfnpA8qe6XaAwyrZWh1JTa4n3YS3HfU+
 RFSdzOD4MKtkCTk29AT9743oc3aEZBAiBYEXoDUxMjavdOrqerhxt4lqqKcMtrDjsEeHP
 tcW9KBvencwUxxltcTzrE8IJHYNcgn2TgpjqnRbPHGb1djf+48lyhOp1Nqcfz4N6TGFnU
 n9pgwx6V5gpU7M4zEJQHlH2Uft+PrgA9pnJdOSYq2n8xIW8w0l/44sk0MZsY2HxA+D545
 yRspoqH/CDB0lW5d5e6KyzVFXUxFu/rBZmb8SAVSZ4x3AqM9W/ccWxGTVCmVAdhTPYA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=awtNGDpe; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=awtNGDpe
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D20EF60711
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ldsPH+oCTvZB8ilQ1OWKDqQYmDjOHAHgObH/YioUpYw=; b=awtNGDpeoPbtNeExWOlP5ZPouf
 5eQPJPrup2neBaG+zp6Cj5u+Ym+J3+uSRj8/5MnEFQ0l9C8VChZQB+XhvxSQ2/wU4dZD8Plrtx2bA
 PqvXr3005ihewM0EyixRfkNqDvPWEurqYbZvc9xiafFt3/2zS+LxVDQO8lihPVoGIbTCScz3svuqi
 L+6Esv+jAUzUB+IvWVFa4W4k0PJ6+KNdcit/q2VDa/lO9EeJcRFrQi7XebRHMrtzbZGXqFv8y0vvY
 j2s6AIYnIBjqBogGcw1ycRAo2TeCMewyLepB7ChP/PJvEm0RJUNr0y3HKrJGL4laiTeiSLHbx3+bO
 tbCj+OUg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfD-0007U7-2R; Tue, 27 Oct 2026 10:40:15 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfD-00022y-2T; Tue, 27 Oct 2026 10:40:15 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 03/16] regulator: anatop: add support for anatop-enable-bit
Date: Tue, 27 Oct 2026 10:39:00 +0100
Message-ID: <1c7c7058ce8026f16ade403fea184523b31b9390.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some variants of the anatop like the one found on the i.MX7D need to be
enabled. Add support for the anatop-enable-bit property that is used for
this purpose.

Instances without this property are considered to be always enabled, and
attempting to disable them will fail.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/regulator/anatop_regulator.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/power/regulator/anatop_regulator.c b/drivers/power/regulator/anatop_regulator.c
index 68a320bd0f8..a64b35b7363 100644
--- a/drivers/power/regulator/anatop_regulator.c
+++ b/drivers/power/regulator/anatop_regulator.c
@@ -42,6 +42,7 @@ struct anatop_regulator {
 	u32 delay_reg;
 	u32 delay_bit_shift;
 	u32 delay_bit_width;
+	u32 enable_mask;
 };
 
 static u32 anatop_get_bits(struct udevice *dev, u32 addr, int bit_shift,
@@ -154,9 +155,42 @@ static int anatop_set_voltage(struct udevice *dev, int uV)
 	return ret;
 }
 
+static int anatop_set_enable(struct udevice *dev, bool enable)
+{
+	const struct anatop_regulator *anatop_reg = dev_get_plat(dev);
+
+	dev_dbg(dev, "enable = %d\n", enable);
+
+	if (!anatop_reg->enable_mask)
+		return enable ? 0 : -ENOSYS;
+	return regmap_update_bits(anatop_reg->regmap, anatop_reg->control_reg,
+				  anatop_reg->enable_mask,
+				  enable ? anatop_reg->enable_mask : 0);
+}
+
+static int anatop_get_enable(struct udevice *dev)
+{
+	const struct anatop_regulator *anatop_reg = dev_get_plat(dev);
+	u32 val;
+	int err;
+
+	if (!anatop_reg->enable_mask)
+		return 1;
+
+	err = regmap_read(anatop_reg->regmap, anatop_reg->control_reg, &val);
+	if (err) {
+		dev_dbg(dev, "cannot read reg (%d)\n", err);
+		return err;
+	}
+
+	return !!(val & anatop_reg->enable_mask);
+}
+
 static const struct dm_regulator_ops anatop_regulator_ops = {
 	.set_value = anatop_set_voltage,
 	.get_value = anatop_get_voltage,
+	.get_enable = anatop_get_enable,
+	.set_enable = anatop_set_enable,
 };
 
 static int anatop_regulator_probe(struct udevice *dev)
@@ -229,6 +263,12 @@ static int anatop_regulator_probe(struct udevice *dev)
 	dev_read_u32(dev, "anatop-delay-bit-shift",
 		     &anatop_reg->delay_bit_shift);
 
+	ret = dev_read_u32(dev,
+			   "anatop-enable-bit",
+			   &val);
+	if (!ret)
+		anatop_reg->enable_mask = BIT(val);
+
 	syscon = dev_get_parent(dev);
 	if (!syscon) {
 		dev_dbg(dev, "unable to find syscon device\n");
-- 
2.55.0

