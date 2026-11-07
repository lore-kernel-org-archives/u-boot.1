Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A374606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k2Qe3zzR;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YUhmNG99
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D57E98132E;
	Sat,  7 Nov 2026 12:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxNaHjhrkFmg; Sat,  7 Nov 2026 12:49:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0974812E8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055794;
	b=Nw8k4bCDCgPjrrxgz+gcouOI8DKtZoFkxTM6PeH3RvgN1FNuslixpvA/j/LqhzdimmO7
	 PmgAuXfBZZ2NbWZ49yFxg2efEJyFfq7PeI0L9qj8y9C5p90yF9Az8GQHh3ZbhRP7Fr3lk
	 yDRndYyGZFL9g+i829KQXP2uFIHeW+dZxQN5WZ+28i06fYfsiVrgjE+CdN4nKF2NTInJQ
	 7XX9+a7oG5rI9pRtxD86XT0T8yMamzhOHJkEDkx5eXVXbB/Sn06PVXYU/c81RAUTZtd+e
	 e4jkvkKumdeVWTTD5Ro+1g6W9OjeJjwmiNf7mlHFkjLJcLpTKntol3yVvCc9PAOs2Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MOVbeTppnUi9s3MW/roj0LQj0J2EuoHnwNvIVsD75z8=;
	b=QM8KkY/oSbxr3ukSZpaLfE6Bgd0Gs0rG9QseAhbYd3ge6KeFX+ABGfDbs4RqAR9BhmKW
	 uIft8ESiM7/z5sfIH/SxbBR1Hz3lsq5m6iLkDLfw59L0r7q635QMe2FhArRdM8fQOyJbn
	 XlJPEctFl5dLrxDHNuq9qpW8fVpxRjFd5f1rqzS/SkTjIvsYo0K3GrttRZhL7/AGW9FOZ
	 OaL1npqZRK8byq26f3D678YX9xTxTk9Ig7ZnKQ11uV4LMgCcTgRZ7FBdLpovU3zrbQYNu
	 /rL/FHS2g6o7a57KM3PVrOpuEWyPYCfNlGmWnBKBx/T9SHkqfOBODPCA86owZqrYLYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055794;
	bh=MOVbeTppnUi9s3MW/roj0LQj0J2EuoHnwNvIVsD75z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k2Qe3zzR2rvlsCo3Uzudlgr8Lfu9hvCRmCS+KCbN15Ne494NCxUAeKms1tBDMBUbU
	 uhhxqtCuLU4wAByXNQ7B2EDW7cJZW11jnwpxKAbPsPxpfkaIjjA0I2BzBSQmjy8zh7
	 bVkp/kDVeCC4mGPDnWGYAwYjK20te0EGQFd3bFSG1cqIpwtYSRDA4pH6REkDnqesFJ
	 FthfwzBWNxuEk5NqTMNBqAK62yFqFA9PbWV6y/snb03XnxVpp1dnNK5OvUDVIWxuCl
	 n5YBraQk/q0Dr040nT2qpRxxXH5E4mhunPrFp0Px4Io+MqJwA9SZvECAZSVp30/qGf
	 iLr11auWHZYVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0974812E8;
	Sat,  7 Nov 2026 12:49:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D081B32A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2243407EE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Bs8WCuPrQxL for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:22:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8CB2040762
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YUhmNG99
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8CB2040762
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:22:35 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b565211890so218136a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 23:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794036153; x=1794640953;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOVbeTppnUi9s3MW/roj0LQj0J2EuoHnwNvIVsD75z8=;
 b=YUhmNG99gJXP8CMyYDLZYUOkh4KGZjaPURMQUVKR70osNeaKaWMOS2vyMqeqZh7GTG
 oMoJ9r7zLTE9CGFl/SSFMyjfI1kKEob4txPSzWnk17mM4XMTzuLAjddAFTBennZORlCN
 tP6/aKacw7sP+v/PSRCALHTZLt5JiR4LjQ9PJ1zUfjPVbnOBJaVfUtGObwWJrtSU3rQl
 HHT3pP0HL1T76qpREXK0puuBdcGr2cfYhbPJqDJQPA2mkzDg3o/U3tRZF3zcpcNKfsIX
 ns7Z0ofQOn5I9xWzGXkTSxHIZnRbu/3rH/fGWR9VXs/OsqvhJblZF6+r1Z6QlMaIkW03
 QUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794036153; x=1794640953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MOVbeTppnUi9s3MW/roj0LQj0J2EuoHnwNvIVsD75z8=;
 b=PfpNsgiI3sKUe3aAMDdAbRx5LR8zwspXNlYj7bkqH7h17HxSTJcjZThOWHOpEZTrMX
 MZhWC2MWCulULQx2+6A8PRNh41q+IYLk6y8LDGcDF/DhNd6mogQDQ6vdRqttaGjd/sm4
 h2ZZ64AcQrOOfuwAp7ER9grorqyPrcCfJCCnA+8cfRmTcviY+4HDSMsKvcV+/7Lb6+6/
 yZnIq5xwX8G6MkXlFy1GcTsVNi7Ly0VkEIKuIUChsL9j8IqdMY5efVK0djM7M+f+fjaz
 pdzWQD+Fy0lNzRymRUecPRXjW4vLEUnRjyKcj1QvwlLQjmFudFVyuAoLPlXAD6EHr9gU
 wBIA==
X-Gm-Message-State: APuU4Z/EdRLUtgQ1reJx/CvIiGCteOEFpSzfTupy50t142mIG110Hsa2
 1qqGUa6QnMl9mo+VwYAGn+hlCd4NlbLkDyblBUzU/944a9r9vWTQemdHl9Kb8xDKIIAGTJ/PYKp
 MoyfF
X-Gm-Gg: AYBFou1XQ2JDRrF2sJrtivL3iR6AnX50+KGY+1wlQEej3zoL2zHq3s/gbRYoH89Nq/W
 dIiP3tVcgdjkJKR1vDrRAY8afna+ZOgFH3zQN3AIafus8oA8JZyt1ZBTuE04EtyiUtM3k0eJzPd
 uVnlQycWVmzTzS7XPYQ0g3rTZxBssiMLQtPlYg+hgPXHnBiuWpTCxAkxzPev/uMk2xhWh4AXlPp
 s4fbCCOe18KiId8Rc9pKum/SoXlqV61QsaD1BSjMzAmFmzVjUVrOe/HP+C4xbjExDhRCVzwdUma
 EDC3g/aOrry1Z1mWKwTSldttNrk0rE1uj0Jc7OxaggnIMGZwaItNjQ4r3f6Hq6hwQsIIh8wB8tA
 fzCdBXWohcAYBC0RrCKybAnd+qyml8X++W3+LKsUa62JDKYXOExkE5j60z5ZqQJSR+npA47ryy2
 fbwVCNVZr9VAd2qOzli6p5jy1AWtFslTD04SqHbTY4u0njIw4FAYoOqukYH1m1A8+5DWTz2UV+c
 LvEOHQMes1rGNYMnWNc0LcSXczEecktP0Gp+ji0YoPOWVGpOJK1bl0l8Q7FAfsN3ae2j+z+Fjpt
 oQfuZuOxkFSCMfiOkCrtobMOxESE0NeP+9hnUCD06PlBX3pizxDFqxTOuhWLiVhyXWEcgWze55+
 vv5tXxpJ++g==
X-Received: by 2002:a17:907:1258:b0:c4d:1501:ac3a with SMTP id
 a640c23a62f3a-c4d352df5a2mr397994266b.2.1794036152633; 
 Fri, 06 Nov 2026 23:22:32 -0800 (PST)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356eae34sm132640566b.85.2026.11.06.23.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 23:22:32 -0800 (PST)
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
Subject: [PATCH v11 02/30] dm: add helpers needed by the resynced DWC3 code
Date: Sat,  7 Nov 2026 08:21:56 +0100
Message-ID: <20261107072224.3492260-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107072224.3492260-1-anders.roxell@linaro.org>
References: <20261107072224.3492260-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:48 +0000
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
- reset_control_assert() and reset_control_deassert() from
  include/linux/reset.h. They go in include/reset.h and call
  reset_assert() and reset_deassert(). They return 0 for a NULL reset,
  like Linux does, since reset_assert() would dereference it. The DWC3 core
  only calls reset_control_assert() in dwc3_core_exit(), and dwc->reset
  is NULL there, since the glue driver handles the reset.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 include/dm/device_compat.h | 11 ++++++++++
 include/dm/read.h          | 43 ++++++++++++++++++++++++++++++++++++++
 include/reset.h            | 16 ++++++++++++++
 3 files changed, 70 insertions(+)

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
index 12dcde6645c7..5219c956733f 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1273,6 +1273,49 @@ static inline phy_interface_t dev_read_phy_mode(const struct udevice *dev)
 
 #endif /* CONFIG_DM_DEV_READ_INLINE */
 
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
+	return (dev_read_size(dev, propname) > 0);
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
diff --git a/include/reset.h b/include/reset.h
index 58574b983f66..e8358beb6ece 100644
--- a/include/reset.h
+++ b/include/reset.h
@@ -519,4 +519,20 @@ static inline bool reset_valid(struct reset_ctl *reset_ctl)
 	return !!reset_ctl->dev;
 }
 
+static inline int reset_control_assert(struct reset_ctl *rstc)
+{
+	if (!rstc)
+		return 0;
+
+	return reset_assert(rstc);
+}
+
+static inline int reset_control_deassert(struct reset_ctl *rstc)
+{
+	if (!rstc)
+		return 0;
+
+	return reset_deassert(rstc);
+}
+
 #endif
-- 
2.53.0

