Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD026606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QdFbDgec;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cuO2UH1F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EA476063F;
	Sat, 21 Nov 2026 13:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E3kwi8dVsTzg; Sat, 21 Nov 2026 13:14:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05260606BF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795266853;
	b=kVrB/HWqHCzJP+s86XG84I4pyCAU/jQMwZh0zf2VqzdO2azFEMYdAsRHaWnPXL63YYbj
	 NKTLaFPYHvumr19axkTx6hjY5cRl6OLk6IC2NX13ZezzdHiqG4pkUCsHnckReGh7lXptB
	 D2amxX8adYeCu9S9qfHfYOal7vO6g/tUr2kTpYecGQcZL2z4heXr/gTO55gIEbrrpwwzF
	 +NTPzTW1oBB0mF/5K+zgtpvPtcbf/8Nuo2tFK6vro9dTxxOcPEf9dIj/C842BNKCnCLB5
	 u76yhhJi4l86SLGe5VNJqwbGGNrN/ODHJK9At+yn7i8OlrkcjgDOPlENvsHLiApXhBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795266853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=o69HOQp2TmgvhWhgVf/dxNtrAO9ZPA0YBmWF2jgX0I4=;
	b=gt5rHur0PuY1MBzcqeGceX0uKNTTIpv3IJ+DJRikGQf5VUxcYz3xRLeWSok1Xz+8ZAzZ
	 o0APiHvQYDQlhoNtRtAe4fi3xJzc48GPQdNr+oqG/f8G6eeOHYZ/LSdmfAPTQKDBpnEqb
	 GyFVE9Wmv9pjdgktZ4A/1dh+fdbcmxCPPoE+1agUwbyi1+cY7avZMjjXF1ENE6rBlrp51
	 9fijQ7TbiMG+eQwdMWTlKzvCCOPpQuGqT82bn5hwLvg4O011OE/kO0QEH2vKH33OMkiEP
	 FuTrxPMidT0mb5t4qVVWFaVjn817qYrpkk0AgYtymgyv5HitNo+dzeq92+FvfB6Ijfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cuO2UH1F;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795266853;
	bh=o69HOQp2TmgvhWhgVf/dxNtrAO9ZPA0YBmWF2jgX0I4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QdFbDgec3JvAOyCI/ax744K8L+4Nvb1KkmvghB1/6f8t5dEEAZgRAEjWnjD1qjWSZ
	 7LK7QmE4VDRKMb6O9x+TYgXWnjYlbPTnFhIAc5pDizCHVjX00FngcDCgbY1/uedk3D
	 ok5VLYDyyEhQIfaAbGbBBP58sF4u9xIZuf9erzz29oniZEl1FoDwsXiIvmmJ2vT87D
	 6T/igIxwWmTugf5J4lQJjqPdFz7IUtfT0f9EAaJF6Yip7PAqht0IDdcOT0TsQy9Rkz
	 yxFMiIhtDcr3Qyf3qu1XBQvI57Z4uI2a2vwnO5oA/seM+TuwHsIAO1flTJNQ40GebE
	 FIEAeMp4h3Mvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05260606BF;
	Sat, 21 Nov 2026 13:14:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 60770465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4669E60623
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cf15KCvguGL8 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 11:53:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5629360642
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=cuO2UH1F
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5629360642
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:53:52 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c50686daf9cso43123766b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795262031; x=1795866831;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o69HOQp2TmgvhWhgVf/dxNtrAO9ZPA0YBmWF2jgX0I4=;
 b=cuO2UH1F7/PT71v31qt5cRXBSOZc15jfjPHjJG2tOOM/DLUbwlKemdScVW8+vezzbU
 q7gGgAMjxO9zQnFVOdA7YrIAby5O3TFSb+sduGe7BMYugPfq2Nlo3l+/aGSd07OUOvAs
 lN794YhpmnYR0YTSe0JNaW7XJXm9KQFojN2Yp+d0JiiNTa2/XfgYEBChfPOGw8uYk3ym
 F7MgrhpEohSAisZ6tkGIEb/aLPLiTjIY/o/s/YNiq2pugcxte5Y4FqwputMpVpLer15f
 S4SPVohM3zetRMOpglvXB6KgQsxVL5oUK0sk/9duUwIaIL6QeXffX0VepcuEgQK31sip
 etPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795262031; x=1795866831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o69HOQp2TmgvhWhgVf/dxNtrAO9ZPA0YBmWF2jgX0I4=;
 b=1Aly6wqmwkCEygnZdVmiKBA+jk6OvxCC3rpLb/pe/83m70Auty5qJNvrDmWEh4xPke
 JyPwoW+i08AOZGoiqcUZLRZ0waaA8yShbUm2dRcAiN0iXqG/jW65lOLS0rktFnShg4wG
 AwnBSLDJ+iqjWxHdHH+LSIvRsBvgkvefBczB6skrDcPoEP9K6oYpIMthNXc9l/ocJ1y9
 nkuNIUTHI7OnbUgqyGaeEyBn+HOUGYCk5qhj5ZTRVG2qYSu/M28zaSV2N2TNxi2aj99l
 puAtFG6RKTZJPz1P9OZRiCFQYYCkJ5d5A4LGSUthgjnmMNGbR+HraloYBB4jG84+xUl3
 Gkbg==
X-Gm-Message-State: APuU4Z9/CuPg4ItE/5sQncej7dKiY0O05l/sTl87CYbC+PaxS+VKHtGW
 OIXEO7wf0znuIkREHhvkJiaGsVM/6Gyb0gPDSmoL0huJJUheqVyC1vsUABnkZmSp7g7CBuP70K7
 5Niro
X-Gm-Gg: AZFdTZe2VRkxFV1/T19UZwvMBWJv/hXeZ98o+lKzRqq+wfXriw5kAMs7DFSnK6JL8bW
 YihXkZdZxjhNUgAOide2x8RaATKoRZYFvOnKuyRv7yi+0aHjouKL+bNwBJP5H7nVPfuLPK6q/5B
 U69LvIBlJu+Gzk9xfKKjIBssVPxk9JBY4bYHpeTLnMoCDaGPLTH7Bjza6t6uEPvWklD/BhEe7ME
 7iKvqzr/xhpbKKjtNerJrBFwusUMhXuDwJizzGQYj+AIkL7M0+mJtoQ2p96iXaEjc2t0mAcVHCb
 fnS93LVGwgecwFy+PouthYb+v2aa28R07E/AsnkCUNpodE65aq3OU+5HxuqDIg4SzitaOf6+/w/
 2QyKWqOw4U1QSNaf55ob88hir4zfZfl35sp46DkD7QuzXxpn75Msd+F4/1rycFM0gzUPMTyRF3O
 h9OvaXMjPuJ97i7iSyQQh8gU6mcL0Z29NZcDPh7nwlQmrTg7DKCBqFWKbgzksLPW+ViXc8PClOv
 eMdwePYAkKeRrYQRlkCkjYNHVeDRzUEz4zEw+E/TU4A4WbUMZ6wXD1U/hc+/SOSI9Wl9Lf2Auwr
 Y6MFnl+4uzLkpALrmXfitikSrcMnF0x7+XK8mmssYQC5JLlE45d+Wyg9ZYli/nPc1MMQrcVthul
 w8K8aMLBVlPtszDvBCoW2E7Xi6Tc7E6Q=
X-Received: by 2002:aa7:d592:0:b0:6b8:8146:a10f with SMTP id
 4fb4d7f45d1cf-6ba37cff067mr3529472a12.2.1795262030929; 
 Sat, 21 Nov 2026 03:53:50 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370cbeb0sm2366040a12.10.2026.11.21.03.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 03:53:50 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v12 02/31] dm: add helpers needed by the resynced DWC3 code
Date: Sat, 21 Nov 2026 12:53:06 +0100
Message-ID: <20261121115335.548142-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121115335.548142-1-anders.roxell@linaro.org>
References: <20261121115335.548142-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Nov 2026 13:14:06 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The resynced DWC3 code calls a few helpers that U-Boot did not have.
Add them first so the next commits can use them.

These are not copies of kernel files. They are small U-Boot versions of
the Linux v6.16 API that the DWC3 code expects:

- dev_err_probe() from include/linux/device.h. It prints the error and
  the message on one line, like Linux does.
- device_property_*() from include/linux/property.h, only the ones the
  DWC3 code calls. They are thin wrappers on the matching dev_read_*()
  calls. device_property_count_u32() returns the number of u32 cells,
  from dev_read_size().

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 include/dm/device_compat.h | 11 ++++++++
 include/dm/read.h          | 51 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/dm/device_compat.h b/include/dm/device_compat.h
index aa9a6fbb5e3f..2ef619949c53 100644
--- a/include/dm/device_compat.h
+++ b/include/dm/device_compat.h
@@ -119,4 +119,15 @@
 #define dev_vdbg(dev, fmt, ...) \
 	__dev_printk(LOGL_DEBUG_CONTENT, dev, fmt, ##__VA_ARGS__)
 
+#define dev_err_probe(dev, err, fmt, ...) \
+	({ \
+		int _err = (err); \
+		if (_err != -EPROBE_DEFER) { \
+			dev_err(dev, "error %d: " fmt, _err, ##__VA_ARGS__); \
+		} else { \
+			dev_dbg(dev, "error %d: " fmt, _err, ##__VA_ARGS__); \
+		} \
+		_err; \
+	 })
+
 #endif
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c7..309be6ece501 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1273,6 +1273,57 @@ static inline phy_interface_t dev_read_phy_mode(const struct udevice *dev)
 
 #endif /* CONFIG_DM_DEV_READ_INLINE */
 
+/**
+ * dev_count_u32() - count the u32 values in a property
+ *
+ * @dev: device to examine
+ * @name: name of the property
+ * Return:
+ *   number of u32 values in the property, or -ve error value if not found
+ */
+static inline int dev_count_u32(const struct udevice *dev,
+				const char *name)
+{
+	int size;
+
+	size = dev_read_size(dev, name);
+	if (size < 0)
+		return size;
+
+	return size / sizeof(u32);
+}
+
+/* Linux compatibility */
+
+#define device_property_count_u32 dev_count_u32
+#define device_property_read_u32_array dev_read_u32_array
+
+static inline bool device_property_present(const struct udevice *dev,
+					   const char *propname)
+{
+	return dev_read_size(dev, propname) > 0;
+}
+
+static inline int device_property_count_u8(const struct udevice *dev,
+					   const char *propname)
+{
+	return dev_read_size(dev, propname);
+}
+
+static inline int device_property_read_u8_array(const struct udevice *dev,
+						const char *propname,
+						u8 *out, size_t count)
+{
+	const u8 *ptr = dev_read_u8_array_ptr(dev, propname, count);
+
+	if (!ptr)
+		return -EINVAL;
+
+	memcpy(out, ptr, count);
+
+	return 0;
+}
+
 /**
  * dev_for_each_subnode() - Helper function to iterate through subnodes
  *
-- 
2.53.0

