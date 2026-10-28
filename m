Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U9sfBeG8;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RTv9jn2q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D980581670;
	Wed, 28 Oct 2026 14:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7B5OIyEXUMVB; Wed, 28 Oct 2026 14:49:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4183A81004
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198877;
	b=LXfuLKBnlFmfCYl/6oZqpsyZuSKblN6sX55yayLZcPXpGBl+pYqycCYFhHMd1Xj7Bwg1
	 cni8Pk/MtiMtBM8Yajwfm3tLvyWrbzTWYr4YtZWac3NoK14P/pXOx/YoXrSo1SluaCOZi
	 KbErq/ds/XeXarRF4QKxcAUBa9pmTiIlxCpZC/edJLhLYwcMgnXdISz33+ITxroYDLSYD
	 GchxaTl1JcoyQcOfpU7J76dHAok3eF9lFDtRZ6LdexWu8SHFrDpqLUVQcJSPGE2uILLzx
	 Stk14aAl8U+4os0Gh0wCu0PJhE7Sm1oItTvbE5y3x0ZD8uxUJbHOawVjOUAk8cPGn7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AF3PHAXOiX1mBThS6+NKp844JlpwR8BaRt6cGcQ824w=;
	b=ZIVpJMi/p4kWWXiwAldWv6hhIen5EJ+aOz6wBRtibdI/1OS2FdYiiRpIrC9mIROH2Qmw
	 SkruhsjjyTTmpvr0Spr0n5u/LZ6oPwVo83wUmzA19zRj/VcC0gVZ90BIxt0HGAvfu6d+o
	 IMEOz1oHX29Nb2Y8VjBwDQem1zRba7WIQSc0tPHRSeAmKGp295khhDaOnzXaZ2ugh00iN
	 Ro07TOAgmLI0Ti/RGMeh58pP9wYtW0jZgQZgnorRiUV4u2WQgZoCvp89MCClPMreL9lE1
	 d65BK9F32CJAqFOAHcTY8+t4Rhrvg6sikfSVvNsl2ZAYG1NejU+jCUohuc2x+EIh7Cg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198877;
	bh=AF3PHAXOiX1mBThS6+NKp844JlpwR8BaRt6cGcQ824w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U9sfBeG8okSuHTUJfHreVdi8ieGpwoK9SElrUZwYM9IFsP+lRPwsn13hIRm7k2oOC
	 eE6vDoYxqN2gKIhyWYkU7CMLa1Q93rKiN5kiXS721Z+d6WpMhNIQD9SSmJtJCuWhfu
	 0lr32HI7rH67mKUT1Sd6rSyHiVFVclNAmjIMoYOWmgLrTrbcFlkJPzOnNH7G7mDC04
	 flLdwuFefeDs12AIL5XB3kikYnA9uXRQKsnTWZqlCAForfFnwL0jS/IjxK7ZCa5UNj
	 +DjngW/7LeiIzRo3tBA6g/k15yiUcjsJmGrP05jvurwP/TMyanGk6lq+fYgWoz9aN/
	 pXuXn2AN3CnOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4183A81004;
	Wed, 28 Oct 2026 14:47:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 634079F8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 516F740557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hou6_m7bFeb2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 403A040550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196963;
 b=lEkWckiJnKHOejSkVydBWV3A+/rnftHPPNa87SXXWpYOOzyYwTYw2ccpk01T/7ckMWlf
 Ox3K7VpUXZXYXc2ecpJ6wGWLV1T9FaefA+hJNtWFN2VWHleRpDWkHsOdo2ZRIUraB8Ix+
 XBmcsMqhrRTOem7cYHKHR66dfmneSquiFXEj5GJN1dKsiVUBynb0w5nVSeptX3DLOki38
 A1/Fucgcm80DhiR4EdYwU0xt/ZQRvcJUmz2dKZWR6NZ3Oh984TbBeK0bbpxZdCGv8MHTU
 zqY4W/AweIBWU4ITVuZETtVOib6LnMPKGXI0hBUU+QaEqwK0GBJRaNRr5AIcQSayn1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AF3PHAXOiX1mBThS6+NKp844JlpwR8BaRt6cGcQ824w=;
 b=A5HG0KVvs6TlOrXy8KL0/mABJRtCgcmunB5nXWggNZlNWY1Yb9+HZ6Qpq4DERguOABv4
 boXst4/CzcDIOhDRD+GDZ5TVOk4S9WC6rtpaC2buh+1Hyu6EDcKv2kL4prVsBs/huRwNr
 tD8hja7ifmkw8ZRAPMWFjo9yAn7ONksirexte88B7OJk0GfccnqEgEpx5kEnkmnSC4cWo
 wlnUg+/ewIgEdC0hUbvaFYsp3e37FPvhZyXYwwqZ4Z/S1SK0o79KDYZNN36iLqqLi87f1
 myFRMbL1/y1WLnT46xAMvzyO9ZrlsU65Q24fUnsDrNLjrA9WvF4UNF3G42PSJfzgBnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RTv9jn2q; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RTv9jn2q
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 403A040550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:03 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c38ac078440so11849766b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196961; x=1793801761;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AF3PHAXOiX1mBThS6+NKp844JlpwR8BaRt6cGcQ824w=;
 b=RTv9jn2qZopDnZE8vdWTj0mnkUJYkhZGHrnFONeUJ2OtAIcHC9gNoe9vI6RIhgFK1o
 lp8ARWugHE9xOJbdiuREeOBML6hf9bYJY8U246siwQV2w+EjYrWAz5ZYhMaaS4U8ah9w
 dkZcST4bXzVzhx6uMRJlg4O2hRyo4yDoUuNwQl/o2Xnv3yzkhpf0pbcCL5/VjiurpIAF
 nNxV7eC3VBAIS6Oyx8/f+YNXJgoVSET97DSqHMW00mGmb05p7K8PH1o5Dz9+4QW5u3r/
 dFy9cs1VnaH9nuk+28N/GwGLmX9+GrIftv8groPy7zV0wMeruaRX8G6akj2APWaBXKb8
 pmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196961; x=1793801761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AF3PHAXOiX1mBThS6+NKp844JlpwR8BaRt6cGcQ824w=;
 b=Is/ewR/0XOnPd9H1jyfB9TkXfRBt4AtoQREynQ5RoE1Q64cQq/i1Bfi/Xy/JQWZb4n
 w2CAKePg4FWJaFfdCTbs3q6e+pS5PQberAwLsM9Xpn5VEF5wsZfEP1Xo/dYfKVwCvqAR
 J/QGhvHdjfjlCFgjVQ68i4JzA40NguqgkEWIDPvYAhlFZi2moTAeE0ua61/IPx2i0BmR
 WH/Kj2PUV+ZA4mAqZVyugcxiM4uAHswgymWTkRrJyQ79XakLjnFD4nChBQSTXAnKs6L4
 nZ3ZcOQ+msEHA521U/NxdMawvNrvzgstr5Tr26Kgrd+gs4YUHPpVN6SeoupQFRm+Ktvn
 LUjw==
X-Gm-Message-State: AFq9FYIveov8BrssWJQ9scXi3G7EcxJWRkD5r1MAK4lhJsCFtmukju6m
 FexKCmFUq5DHrZKbtlBnwOiEP53uBn/INtphwuJAbeaWzkpM2/7Mp5KsmyUbvP1bnZWSzOqH6Xj
 h6czD
X-Gm-Gg: AYBFou2XPQ7eU3dzdwIM6kEEMnwy5tsA0l7RituM4WTtkIComK8yaRSLmz5mSBsJnIo
 i+LUchrMtFryDhkxlFTWGR+rm5Sy8iAAXdj3wY9YSXIWGDcLkWyMhUJHtV6S0Akf3qOicKSQ28w
 cwEOP/fsIiPVhderFhO0v/SO9tNbkzyd6eI7iSgpp4k19hg+dpzee6eDjQY1qxC3ZQEbwYaKyQK
 Lvx3KXSJAUFlc7micLbb/Q0gxgyYaohqkrpDBzq+YVeor2nmKCtYZwAu9cLCf0JlEvX2VvQr8WV
 2Pk8Dly9fCOhYMZOWFGeHg7Jw1e6M7ZuaHJtc5cNsPWyuKzcsMyd1t2fyK51QLseIZkzn8z3oBy
 UQiDSK94D/zqUWh0/PDQN1Yf60yczaC4TdczC/Q95vsgh1rDjG3WFI540HZZCx9C4ixQet3sZn8
 6JLjQmOFtNfVLG+FCUV9dlYr8Jcokoqa/7s1FUAh0Se+USK8EtYEsyKWBCzkoIBhcoTqAhV42kl
 9KXI1rWLT3gV2pO5z6USEzCyzTZ3IAM2RskGQa97ZGLGL38xYgQ7Q5ogRU3mEyw8QjAzfClRnAq
 BCZbD24unGzUxlXTIAlgzozp51Kcg7kohQaub6lWWmxRF8LR4KXriB+9BrqHll9gVulPTs4iVcB
 uPPXEr+++4A==
X-Received: by 2002:a17:906:c006:b0:c2e:3698:dbba with SMTP id
 a640c23a62f3a-c49bdf3daf6mr228120766b.4.1793196961112; 
 Wed, 28 Oct 2026 07:16:01 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:00 -0700 (PDT)
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
Subject: [PATCH v10 02/30] dm: add helpers needed by the resynced DWC3 code
Date: Wed, 28 Oct 2026 15:15:26 +0100
Message-ID: <20261028141554.3073545-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

- dev_err_probe() from include/linux/device.h.
- device_property_*() from include/linux/property.h. They are thin
  wrappers on the matching dev_read_*() calls.
- struct device gets an of_node member, so the kernel code that carries
  it around still compiles.
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
 include/dm/device_compat.h | 13 ++++++++++
 include/dm/read.h          | 51 ++++++++++++++++++++++++++++++++++++++
 include/linux/compat.h     |  2 ++
 include/reset.h            | 16 ++++++++++++
 4 files changed, 82 insertions(+)

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
index d4ba4d0088a0..a14fa8c1fcd1 100644
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

