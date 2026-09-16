Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6605EC982C3
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A36880E3A;
	Wed, 16 Sep 2026 13:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0i0z1IuGmUn4; Wed, 16 Sep 2026 13:08:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4D24980E3D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564119;
	b=Tbs6yfNYs6GmneTPDxYu/zyC6x3jkbS58TeRT2xjf6GqwP/+W+lhUcasnsDUPaVClwTq
	 j6uaYFILXZ9d1udt+s5NEwtAhg/0REkuvVBisnRv/M0RU49rX+DHduOTa5GvopbGLmLam
	 4XHxJ1UNmK/x1FbiF7bLirL5izKdDAQkhGXH8nU3GkT4r8+y9htro601OOE2feOO90AB5
	 P+VZ2ACFSaKuQKBrHC56uRZKJf+tUl8cOfjEFffhSo+BbT2SPuVPFPxAIKqSvZnZWCMMF
	 Ao+2gVTi2mDAAleH4X334CQGmHEDMDjez26EVeBk24+13VMXYizg7QApNp28jNZ+c1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564119;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KPvzLju0sfXfBPKK7sqvVLTiUe4rsfpPzGwSZHjH/RE=;
	b=bc5Z7eGn/U860PwktZ6K+b8iOTt/O6jEQSQ3csOlcS1vI7lx0jJQcL9S5QQhNherixfb
	 wIpf8tmCjWB4VIr+u1hvldSEGmM6r2aQ52kV7CevVPqSvNOd5AIDRP0ez3UE9i/nL1Qyp
	 jcccp84Z0vmEOzHxINyV9FvKb7x8qWMjplkjIKCkxCDkgOyNvCbhuzwgEUUldsv30hvSf
	 AAnEyC3Ef2WJYK2rgWomTP+FXlu7F2JxF9vFeeM2tQ9AXS52Mik8PKgJg3hEtlnenUzl5
	 y9QRUI1oIUG9eAlGvlG3NEmLXFwb6ZXpVJhBhKj7g9m/8LNFfU2+u4z2aqd0lK5+q0Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564119;
	bh=KPvzLju0sfXfBPKK7sqvVLTiUe4rsfpPzGwSZHjH/RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Og1k9nOQw2NRicFB8lBFyoUkuqF3ycIdD+TRbn6z5jnD1gR25TAsIi7LC0sOumeYk
	 7KPd89k9FnopF1AqinTlyVKurpkcm+nC8b9lKJS6MhvQWwAGFMXMIYjYQi5D6KDaXr
	 E9Muvwe8IiFMOoKudP8DpXdUxpzDH6egsNhKTrzQiMjYznY7YAoDx1AsxK0MlSFdCb
	 0wb5MXMGRLXBhl3lMcdS6hIJK/SOT/37ML/4mCOB+V6iwG2TzHuFSLxq/a4RGDuAc4
	 rPtIT6P7pJtledE9TZZa6sLYgLUTBnTtsJrI4BQKcMpPrwxOCNMpWMCPWvJ0hU2BQb
	 s5dbMGPKPCTuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D24980E3D;
	Wed, 16 Sep 2026 13:08:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B934BDD7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F048607EB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXVj8oXoX4s7 for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:39:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8E141607D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562357;
 b=BHZrXkfWh58WeQxjajkE/vRk3z4OQF7mKP1GAwYUpGAMNByX5NyoDMKX/FxFeCBtk0lO
 A8YcfKDqpPQt77JLx2ZcuLPSupadflrBMYCa0OsXBJBj/+t2nGi0JEMeS6422n3esI65x
 a6QbqucYUEf6hRkgyK5b+Y3t2eg3qs+K12imJ4vNv22bwZ9KMm8V8XexScOycOOF9NBWB
 FFkOj1lsiwil5vuN9Sd0xjhGz45Nzj9UxyNE8f9mYx+tvxbO64HjkNdYQjVSyZtQ9lLo5
 5sUUb7Zr5edea//hmiBhskVBjNzwYcTNDxWqr7360xglb3MtW0SZQZgGkp6i2j+hc2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562357;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=KPvzLju0sfXfBPKK7sqvVLTiUe4rsfpPzGwSZHjH/RE=;
 b=eUfhWZT7ElsuCrm5DmLGnCQkfdPVYnZPwtHAelb8c+TIZK91kVpX1mPIjOZ4Ztrsbp70
 fDvMp7vP2EjiNvrmFURSwXO0n+ENAsLhBN6Ye6zoUZVCjf1IJ9/OQj/J2Pm8sxuHag780
 dnVYxLZz2poLfSNKd4e+yWIG9zSBmXi+dYdKEO9L0SylXJ4OeRRj7b1LThZfE8Yw85iJC
 5QVkb6HIRZfrSfWPwYyF00Qeg7abIAatwvWIv+0KA9BOjrtekFxNp3jj8kxrKvuF25XNp
 jH7F1sCP0Ym24jO/MXLR7SOHnXtYPexkEbmr6VfpPvRagpXItobVi6uq9iPhTJa+tag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fZE6S9Zf; 
 arc=none smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fZE6S9Zf
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E141607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:39:16 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c293d3da33bso12421866b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789562354; x=1790167154;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KPvzLju0sfXfBPKK7sqvVLTiUe4rsfpPzGwSZHjH/RE=;
 b=fZE6S9ZfryvO2dyDPZmMQIeQEh/lzPce7PkUqG2nwm3+OL8y1GDA1T/72R7odDIjt6
 tMm5oruMy7CphOq/WRUyoyYsDUrhysAsNaEgGpxgm3VUTxwkXH572u1cIIx4JlvV/4Jy
 VFsKu0f5sc19a2ciDfHo64FS3F2JH5JetFf50w6lXKHypITvVkwQB3NmTMW3Disrz3dE
 4ep8U/WkLOAPlbnZXsfncLDBj28qk3Ujg5Uc181piTP+48dUVUIqHQYVOCgzOhZRX6vt
 4Vrvftm96sLwabZYIMgQS+S3l7pfVCu5/aQ0tsTOy/w7aNDb607bahTOBu9YE8ESTbFo
 d0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562354; x=1790167154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KPvzLju0sfXfBPKK7sqvVLTiUe4rsfpPzGwSZHjH/RE=;
 b=msoq5THMYnJHi64bLSbFnGvEIRMcJTrBS3cz9Fz3RL3AlTtPSQwKvC+i/s8ha9vQQj
 oRDbqOCFPRTyWr7sIStIIDNaQlzGsaEj6yEqMuNc4v4+fhrSLbDXR+YMg/YTfFVJ+l6B
 L32AvH9ZYoevFQgtSKlDLBf/c8XjmKBPaQ31TuASaXBsD6VEtkI9SSOVCUKxDv2EpXiY
 wr24ERVPKOYhQYTIqeLUDsJzLa7AHfAcRJswIYINifIPZwgexy8Q+WLTNRevM+sCpszT
 IFcBJfA4hgVb819uAdba0txpmkTybMBAQTatwnUH3yt1+g40+Qah47Ghi0NkGtgC+LOS
 iilw==
X-Gm-Message-State: AFuF++nVUbHqCsFvWx0bXWSXOU9KCOjYkxXRe5fqtTequ/0G6rhNep0t
 VGNc66GR29MPD+Jdm0VS16cfj7Eub5UoGScY9tbZC2u5zrFoXRT78EvWMC8KZ2Jp1awHVvkYyV0
 ZSIsB
X-Gm-Gg: AYBFou2w8xkwiUnjsLgM9hJRCPyJVrq7zHwr+qXwgBiucYbPghqK4J3LOQiwXtgsnXw
 aB1DhG+oBFYL8jl4kUcnn02bz9v5N3ok+Y3lvd3xFB2P8Iyj4/DKVLqtx0Wh7VSCaT9FNzjolvp
 /NnZVBLDGE4bohTatyA3h9+z5z1Gyq+QeqUB9fqHP0glYa+xFX58huEqgDXlzLg1OroSxCsmMx0
 F6lRD5s+9YUu5XvpVCzHH7p8WPz7LdQmanc8Ed5iwjn5FJdLJHrT1SDTNTS8ZTj/WVX1XgsOTF9
 yI/KefTqQdQP74vz4VKPs4kBbSif+8L+fH/3tdzPe8ZBc66Hj/NbbQeuoFldaBVbXhyC/GDZFpg
 VxlBtFPtkGfQljWPJVUEu5Jgga9aleTSNVkc69MWyWXPPNpUPVZztOl4kszonNFmXAuIjOgbuAf
 n+TzwsOGMOtEh1SFh1HFwGnjlxOIa2v0twFCu5r2PjlO4biRabKyca3xTobzg80lLz7bWt2Jtmc
 vreNKUelR0sH7wzGdV5ncn8peA7Uc1/7k7YL9xyojYX0qopkuiZCirW
X-Received: by 2002:a17:907:da6:b0:c29:4634:5c8f with SMTP id
 a640c23a62f3a-c29e4ea2965mr174035266b.0.1789562353883; 
 Wed, 16 Sep 2026 05:39:13 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de086aa3sm136889166b.6.2026.09.16.05.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:39:13 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v9 02/26] dm: add helpers needed by the resynced DWC3 code
Date: Wed, 16 Sep 2026 14:38:02 +0200
Message-ID: <20260916123826.517181-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123826.517181-1-anders.roxell@linaro.org>
References: <20260916123826.517181-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:33 +0000
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
  include/linux/reset.h, as empty stubs. U-Boot has no reset_control of
  that shape. The DWC3 core only calls reset_control_assert() in
  dwc3_core_exit(), and dwc->reset is never set, because the glue driver
  handles the reset through the DM reset framework. So doing nothing is
  correct here.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

