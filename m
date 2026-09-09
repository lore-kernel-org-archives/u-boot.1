Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AC0C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 12:45:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2355560784;
	Wed,  9 Sep 2026 12:45:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAbsZMbqqyyC; Wed,  9 Sep 2026 12:45:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C9508606AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788957950;
	b=sd6Lr5dwsKYikrWjHd6S4gthsaG0AWj5zN9uGa5aiPMRKE5IPnk8Uqd+/9QcE61K9/Fj
	 BmdHmBFVawBjWZgQD003iIFEYvtHQFyG4R5eHHCIFhUUh860QI+nhq02bL/0eKIKAJMGn
	 JQNd5qOsu2uCi5oN00d/kAK7N+YhhOanx5tAYw1qpUv5FuWj8/xTzM5FdyvhqjzS76OQT
	 aPyIoA/9Y27JIAOj8FptLbEcVV0A1oykquR8+ob/LZeJOOaq1nKaQGIarvIkvEWJQDKm9
	 Rq5FpV6rtlnKuCzEGRPvjZFEnSvMXH700o5qWCCia5gtKF68MY57N+taiAJbjTScgSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788957950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
	b=p9m5E7hasolFQ4yhN7Jq0pHnnWvo6iTNRE9iZ3h9UA55T+bGYKt7kENWc+CPPaFeXdD4
	 uDeAyUl7ZHSJC6StxbuKTC6iUKy8Zvnm5GBvOT/HJM1q2QL8xfmr3U3Wpamdsk4CCiTOz
	 1Qc+MH3DlhWp2ahCfjTsFBkqkZ9wR3O0I4LSncNIVmT4TRwHlSDaApc+9MXAS6L5s1N50
	 TzcEbaLuaM7PkeApAvL3DVdMXabdf0LVhMcsT+SdJMnHKTEoi+vIvs5HCIFHVHH7noxQM
	 9N47fuzV+zm8GurE1rtV7yBVYldOwSC1HeZxnoFs1wIfNwDxeWoRwdLT4UeeMtVau4g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788957949;
	bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXl9lAsDauouAOZ47hmdUH2lJp7Gpc+XNJH5z/zrX7BrABBRt+6qsCslPHcMmvHad
	 Vr9t5k6JgfRJelwQUZ8GfsG2A96S1ELnWjLP9Um/Qg9crb8Nx2YgHT82xmKAsq4F/p
	 Oc5fqctvcw3XLmMrYPHj4QtdP17scuW+kCWiNyPmOtSYE+JZPGSRazQnSCYDSJCJ9l
	 lgRHiqYr6+zhDKcUI4gmTmJ8bi1RMDvqkE7jL3Y37FFB+UV+nSNZe2m6eWq0Tpc5Yc
	 ViEK85yotc3N1paq1agX0lVk8TaTjDhB7tYWtwPfcb5HBqGU0VoFhIv6GHOKYgC/P1
	 Q2E0SCwc5pYZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9508606AF;
	Wed,  9 Sep 2026 12:45:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE06B755
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7197400C2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ys-fFL2d1y0Q for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 08:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7F35A400AA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788943872;
 b=inDnMsM5CafikQvSPAx2QoUdvayEOx8tKGYFLot8IqPdF13gvxr+58UrLPUVB7VRbGNe
 A28C4Tcb+8Bc1aOSpPs4+C2TAPw4ut3LEm+SNacGH65DhsNXN+8XZFONTGjkRX1h3jl+r
 h0lwX2lzao5SG3IX8EgNhbaw7dQFZIwaqWHtYbVlRI62OxvSoRnFS3aOyMsb9nMnpq1VY
 NDLNGOGcwds1IYS051LX0UhIwOvZSammoZhr6eadHpTnYh59A/sbGIdBj1GdEMKExVQpA
 sG8HNTRM6OQvC4/Cp56BoRmMLhyW+qOjcejioHVjHljYj2KszbODO0fc/SZl3JuYV3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788943872;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
 b=fiBHteo7RvyFVPARg0xOBw9gbJd1T8rBBEgbt5tDoEsV7za29MGM6M2ZCruvBJUfKMbr
 x9+Z1/cEcI2SYxOne783614ib3FdDowMoL0EvqJAIRItkeAuaQ02n1q0kFIVeuf89pztT
 oI4OwWmOGzLTesc4vGmkGaaKn7+P6AsUf0n2Xv85JDFpxW0TfKzRQ+fbWoOsCRDopfoQt
 sYufZnwPWzqj6lOkcdiOL747Acd9MBL300zIdSfWlxVf3Ty6gZ87oCZI1R2n9e5gewx7O
 EIspOlyEjMod8pYx/ylsCHwJOHHyB5pB9DtNuUtPlk+Xm0sRJHUQzozMTJi5YN1C1VQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nAZxh3Jg; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nAZxh3Jg
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F35A400AA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 08:51:11 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c250848d11cso74794466b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788943869; x=1789548669;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
 b=nAZxh3Jgo0ZX6VNMLQ5qrZsfghKCQ4+Ny8+B7RFq/NQus99iUIkTO7LmxrBJGwoXx/
 QGWdwtxfwdSk4f4XoMPXLycA782z7mYY99Lz/sImb2CiYYJmwf4d5puV604E6uSkoa50
 +tAAB8Ib2FluR8Qwjeid5nSEq9wz6bbcknaw2PMLNI6EsyPUeAOEzicXypcFMqpPajJw
 +PKdJic8cfxEj0yqQg5hWewfqSKltU3etlfcyLWsBVcIPT7J4W4nvAv7O36i5NO06u4X
 b1b3Cov6WXCRV6cIJNvDkE39HFuq081B/8hMyYCKehskeio2qiA4WfEId4AXsC0zrFJs
 aXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788943869; x=1789548669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eXhLm+C6jLG0mgAjKvoFmk6kBGciM/p96LKBLnYgjPw=;
 b=To+M/iMydfdVnwEGbXt+NmIJ4HiNBrsNZcg3EkmbOQcEXIlWlnEC/7TqYmgYNO8Jhg
 TKTcasurg1JkSLF7qlwLFtBz1GTEprZjDA08Z+2OW5Tb7Zj8WsxV1sP8CnAHW1l51hts
 sEugqrMKPGpLQ1YKOYcXNcqxrHbC2M3Yc9rdqChkbhouTYlRlya0Cl0RMrs91+60UrCV
 lNP16AesFCJ5lkL/LmL7i4/bXkPfPMCSvswrSY4EEgKt6FNYvn/EmPXG7+Pyq0M+j/9/
 i76pM4iO03XzblfUQoehc/vIUZ5mTVjd94VU1AlDDH7XK6o1o9sdktL3SWpHiRDeg06b
 OHog==
X-Gm-Message-State: AFuF++lj0s/u4tIb+dx/2F36UfqTkRCYLMiiGert9C5HC1hxkuKoJdJ9
 E1jQ+dAPZtbagY0jZaiKTuUdEm9gPMfE+TsrF1pA7VMdyTHiewDnghuuItAoiSDBCn/leqjzHO2
 EpafJ
X-Gm-Gg: AYBFou3lashJkZ8nmQ+HAw4lQySkoq49IT1/NzXSoyXnHmwwrGYKDQtG1CDzEPem4rQ
 +ieDCy8opz4Eq1k3/sldHiiQK1qS9x7oeBI74ZAT77bicorNrCynW9wYHJLso3Dzu2mV2/gdi3S
 /kdCv9sr6wWwDfU+mW+ogBPIjwi0QaKwLM8FxTZIZQ41sDByt0GAw+eV/1hChBUxN2w2fvQunsH
 uVrrT5JnucITCy+xcndfVUm/RfQt05HnbIMbkneOSNmBlZ1wGdidNYX0r34ZZoSmbUH4Avk1M4e
 1nIWHwdCnQ7DtoB8KtHv2P/Sr5uGwNM6pf4ca3YOH8eKHPlw+3vvvn6L+hMiBSxi4ntklIoQiZ1
 ewhzSENSXr9iautVDGcpA3Id9VZLDczgNVjLDWsB3pZOD7h43scwFyobV8KgrEFy8M97Yh3InCs
 YCT7osIQmm/bdpiiJSQv+AvuX5wy1kFbCJl2BXyXBV6A5O3BvxzUscm9VhovXv9GdRndghMGXyJ
 Q6X/Egl9S7h1gpwiixu4/800F7nmi0n
X-Received: by 2002:a17:907:94d3:b0:c16:1290:11a7 with SMTP id
 a640c23a62f3a-c2624f0a534mr1117476666b.1.1788943869167; 
 Wed, 09 Sep 2026 01:51:09 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c292c14c6a8sm90988566b.47.2026.09.09.01.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:51:08 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 01/25] dm: add helpers needed by the resynced DWC3 code
Date: Wed,  9 Sep 2026 10:49:51 +0200
Message-ID: <20260909085015.2480097-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909085015.2480097-1-anders.roxell@linaro.org>
References: <20260909085015.2480097-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 12:45:47 +0000
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

The resynced DWC3 code calls a few helpers that u-boot did not have.
Add them first so the next commits can use them.

These are not copies of kernel files. They are small u-boot versions of
the Linux v6.16 API that the DWC3 code expects:

- dev_err_probe() from include/linux/device.h.
- device_property_*() from include/linux/property.h. They are thin
  wrappers on the matching dev_read_*() calls.
- struct device gets an of_node member, so the kernel code that carries
  it around still compiles.
- reset_control_assert() and reset_control_deassert() from
  include/linux/reset.h, as empty stubs. u-boot has no reset_control of
  that shape. The DWC3 core only calls reset_control_assert() in
  dwc3_core_exit(), and dwc->reset is never set, because the glue driver
  handles the reset through the DM reset framework. So doing nothing is
  correct here.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 include/dm/device_compat.h | 13 ++++++++++
 include/dm/read.h          | 51 ++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h     | 15 +++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/dm/device_compat.h b/include/dm/device_compat.h
index aa9a6fbb5e3f..6b31a72768fd 100644
--- a/include/dm/device_compat.h
+++ b/include/dm/device_compat.h
@@ -119,4 +119,17 @@
 #define dev_vdbg(dev, fmt, ...) \
 	__dev_printk(LOGL_DEBUG_CONTENT, dev, fmt, ##__VA_ARGS__)
 
+#define dev_err_probe(dev, err, fmt, ...) \
+	({ \
+		int _err = (err); \
+		if (_err != -EPROBE_DEFER) { \
+			dev_err(dev, fmt, ##__VA_ARGS__); \
+			dev_err(dev, "[err=%d]", _err); \
+		} else { \
+			dev_dbg(dev, fmt, ##__VA_ARGS__); \
+			dev_dbg(dev, "[err=%d]", _err); \
+		} \
+		_err; \
+	 })
+
 #endif
diff --git a/include/dm/read.h b/include/dm/read.h
index 12dcde6645c7..86c4933fd694 100644
--- a/include/dm/read.h
+++ b/include/dm/read.h
@@ -1273,6 +1273,57 @@ static inline phy_interface_t dev_read_phy_mode(const struct udevice *dev)
 
 #endif /* CONFIG_DM_DEV_READ_INLINE */
 
+static inline int dev_count_u32(const struct udevice *dev,
+				const char *name)
+{
+	return dev_read_u32_array(dev, name, NULL, 0);
+}
+
+/* Linux compatibility */
+
+#define device_property_count_u32 dev_count_u32
+#define device_property_read_bool dev_read_bool
+#define device_property_read_u16 dev_read_u16
+#define device_property_read_u32_array dev_read_u32_array
+#define device_property_read_u32 dev_read_u32
+#define device_property_read_u8 dev_read_u8
+
+static inline int device_property_read_string(const struct udevice *dev,
+					      const char *propname,
+					      const char **val)
+{
+	*val = dev_read_string(dev, propname);
+	if (!*val)
+		return -ENOENT;
+	return 0;
+}
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
diff --git a/include/linux/compat.h b/include/linux/compat.h
index d4ba4d0088a0..16c02260c111 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -297,6 +297,7 @@ struct rw_semaphore { int i; };
 #define up_write(...)			do { } while (0)
 #define down_read(...)			do { } while (0)
 #define up_read(...)			do { } while (0)
+struct device_node;
 struct device {
 	struct device		*parent;
 	struct class		*class;
@@ -305,6 +306,7 @@ struct device {
 	/* This is used from drivers/usb/musb-new subsystem only */
 	void		*driver_data;	/* data private to the driver */
 	void            *device_data;   /* data private to the device */
+	struct device_node	*of_node; /* associated device tree node */
 };
 struct mutex { int i; };
 struct kernel_param { int i; };
@@ -402,4 +404,17 @@ typedef unsigned long dmaaddr_t;
 #define free_irq(irq, data) do {} while (0)
 #define request_irq(nr, f, flags, nm, data) 0
 
+/* From include/linux/reset.h */
+
+struct reset_control;
+
+static inline int reset_control_assert(struct reset_control *rstc)
+{
+	return 0;
+}
+
+static inline int reset_control_deassert(struct reset_control *rstc)
+{
+	return 0;
+}
 #endif
-- 
2.53.0

