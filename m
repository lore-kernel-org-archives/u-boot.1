Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2592C88E59
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DC2780E8B;
	Sat, 12 Sep 2026 13:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4CMqjGQtX3y3; Sat, 12 Sep 2026 13:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BC6B380E8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219608;
	b=eo/8yXPs3khrhB7PVTeJZ5jFCbOAXgBjg0Q9Pg8q/eeF4zuPmXzFn8LINNhE2RnQ6E9J
	 npQ6QdiT9p/yf+aEW8LUikCMMbdr6HVX8x1f6gMyplQXoRfkT5u7SDtK7OJPhORbL9DFq
	 tGBjNy7hHiDF/mq67VHGQSnoGMa9jSdT8sU5Bj4aisZT5qs7/6ry2AmTpiHbWv3IfGTF6
	 bCzpr4Yj7Qv/g4CktI4yRANjpJQSj0hCKQ93EuoKAvJc/dyRHjR6G+ooTD6Rbx8sxLHVe
	 +E0gck+rIz/xilzRFthqiLrWlLs02mvhP4tIVFwXG5kg2CHlU4nO5i3u1X4HULCYNiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CIVJr6vUDpFIib/VG5vn/bFx7ZJtOW+e+m3bGLCA2e8=;
	b=cGYntATOQQkW9U0GcVs20Jx0fvqOhasMeaSF/38Wnf0r4ONumHU72zso/kPBgR+KvJ6/
	 Tu2VvJ5yjyxPWSPVJJWcQQPUWlGoiPDk3qBd5quhjpZ2wtcE+oMFneJ92mCYIZKbIBWLg
	 ROK9dB17qgS/1ztJ4pU+0qJvGGdm28nylWki4rqOA5mck7nFsIPlf+776ZMxQiPh2ArH4
	 Hw3x+7tRGCoKLQfovNxRGbjopqYJUb6syKuQ1/MGGL9jAnLaNaB0mGKEW7oSXaNfKkx4T
	 7z8C+ZWx0j1qJvidiL46Hk5U/7VxalEPbrbBku5PafU7J9hxBPgk7iwkEOPbjyF6sUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Lt4dSm4a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219608;
	bh=CIVJr6vUDpFIib/VG5vn/bFx7ZJtOW+e+m3bGLCA2e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oe5BTLVCopUXyyfqA5592WxipvNZXGGsFF9kWcWpmgtrL4L3hzqP8dyinW9QSHyCV
	 1xqI8ezfCp4Zs+Pzac6HDqjVRMA4K1TS3Qf0ZpzqypCGvSTvsVX5F9Rx1almb15w1k
	 kWhSUMJYaHGSsYgjPNTgXxp82yJ65X9Sxt8bO883nu4LB/pdxr0I/SDOBDQMoxKjmV
	 yS1c83LVmLpAh/17pJlPuiAzjBKqvlcqzzYqHhe0H1I7cpCEZ2FVS3LmAV6hHyuO9e
	 Mh+cP9PngazsMFlKkX5s/BgJFVf7t9NMQZS7mjqVlyjWan5UWiHotiK9gcX6zzVCos
	 Qd0egI/NK0LSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC6B380E8C;
	Sat, 12 Sep 2026 13:26:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24001EB
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09FBF80D73
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vwxpUxk1w8k3 for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 089FD80D15
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789217119;
 b=QzXi/pLRASjW2ej/12uRqpwqDjn0/9MSoYEg0yLzytt7yZsbRaMIIqBqrXzqRyINRn0c
 Zuq5Iie1VXBOU3tYt9iC03AMRFglyM262TKyW5srRGZt87WSIXmrioh7rcU3zekdFog4I
 PjUY/rNuhBggAiOQY9SLZGhGXLYy24zeYQdW+Qs7xskLJcyfcEjGJF/yLC/mv+8DoLj0x
 7jt/UoIGFUPTCw3ufgm+Pdbtb4JVCwzWxdNfQosUdYkHu3Gcn5EIW275KIPQRdLV7jpCO
 I7E4Len3XDsa6Whe+QZ93MNN0JsWyiSJ2Rk8g8Nc7wNnN3VxFEpLbV4060jyJwmgz6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789217119;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=CIVJr6vUDpFIib/VG5vn/bFx7ZJtOW+e+m3bGLCA2e8=;
 b=Q6OWbokZ1O416gdO/UmM93XxbvsfnP2ulSjIGLMeRZ05KghzMwBtQx6as+QorFz0mR8Y
 JGFgK6TwcvzK8+OeLQGg7XgTpY2nfxQ4Tr/R0iOPVDoXhJCpOABRkvao6HAxoJG+jJqYE
 l0KrQy45ML4pwuM4i0e9ca/vZ9J4IzcZ7gUiNcx/Edl/prpi8tBtZz6rle/zUvXZdlsZ8
 Opp3nyWhd4HzKeczAsdM0Zx5Z7GttRp0whHp1cd2YyIy8x8xeYIULGG/ZN2wG/ipxfIky
 U61LKOpf//NS/F+f6zowmpHnw8fciESADVPjaoouGPjw7hkPBuYnpippkokNTnv2p5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Lt4dSm4a; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Lt4dSm4a
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 089FD80D15
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:18 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7CE8F3FE32
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789217117;
 bh=CIVJr6vUDpFIib/VG5vn/bFx7ZJtOW+e+m3bGLCA2e8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Lt4dSm4aP8SYaV3/F9MpMWFMg6wI+2i9bZ0JL24IaxHYb/DE1/aFwrUZnjnwWz+4p
 Boge2hDawkGL7EqIzeDC6dtQUXarqbgnx57Kc7/A3cKFviE3ynFX6R3AH66i0vyi1D
 NoNg+G5c/CKZaQIav4UKULrGj40Uhz5/tbuokMs1eDrQ3SW/ck+1QyoY/2ZAdxS3GV
 qptziUxZwhcP2KyIdE6PgqFf7jggqGho4oF06iW/SuVUXF5mFU/ypHG3zC9/sVSgJ9
 W4jhCC7VreYAiDmonRuPUAwDDjoIFwZaLp0Ro8rByTGjQdCyePzpSW3sumY/2PIsD4
 b5V7RcnyN64kV6CoOi7Op85u4p7/ny0QjIQeU6/x8q/IUoGv5OKl01LC9AY+8Tgwfy
 yy8nGESDOscU3rW7kmNHBgfv0IFXcY6nilkLqy8QjQnIuSo/n4vZupvmqJPprPpc9N
 IBDC/bMaMFV2mRnCSbibtoM0ThgaBqX9Z8J5l3pvA31vmCg/Q+U5JP2b/A+VCIzyO8
 27VIb4dHSP0+KekfoYSVyNM+j2yh8oS+sF34K66a8+5OZ/9BB02U7ebrjOzpz9DWNn
 z+ShZmr8pvUjLxKj/g2Tps7VW6/Z5Baqs874vtcJE/5vicxSGXHD/OUgRpP6s/BLiq
 eEHLyIc0FKAcNU8QZMMJuylk=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-86b80d42de5so1457485b3a.2
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217116; x=1789821916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CIVJr6vUDpFIib/VG5vn/bFx7ZJtOW+e+m3bGLCA2e8=;
 b=gTqQGF/W+X7ZBxZKvxG50UI7fVpzISk965gM8fPPzeWjQ+qjzC2CWbeiYY74BG//77
 Bm5wA8QY1mLFP/oWK+Bp/HIwmjR+jrzt5Y0YWkxYcaHNjqbVZjCnkmaXFZwq2pQlEr8r
 pKKRAbOsAlY74Se8F48xM3G2ykE96jemiHcr9ESp7B9kcuenmQlmrgBwnYcgDoGtpvZ7
 vOilR4a7YKB6rY8+3r17p3GKSrWrCsm3GPko2T+6fC6pP69f9y4W3EhHRys1Wt/UArEW
 7Dz0/m7+mZCkKwyWFM1On3MmLHqDEv2Rdo5ZNx7EMP9BqNeT8LxxVmKWjYFMVHMtMfCE
 8Glw==
X-Gm-Message-State: AFuF++ktf0KYiTZdgn2pdd9Oic/vbsGaCnCj2nNK2X0kxMUBQzvg0Pwq
 C0NdnorYPmT87O7OUjhbmJK105lsHAkgLzK6+qeHGxdAjglgZeGeI2SzapGtORbzgL/WiPAiRvV
 48LQNBXVJZQXcO9hG8Zp/1ztdDJC08ejtbrcmV6mpJb4KQXFV/bmeFOEihpOGQVgINvzRrylzXR
 VpLmLlNR/o1ArBn+W3YQ==
X-Gm-Gg: AYBFou3PZgXxQELBISqLQFnryZ2L8skCZQ7r6X/Dow157HKtEusAXdSq3xb6lhRI0GH
 HoEVm5uScl6ZJbYJ6JUQ/u4AWFO5y7Rzco1TZNUAU3OPWg5gvSfE3wwvHwJURwtbk1yNd2hlzbf
 iYnb49OudoWn2UhPp4xtZpwK7E33K09VphzmOpo15aStGw5YDAC/UpP3NkvWR8UOFW+6Wk9jitg
 2Cu420hKO3iP1p56l2ytu8dEY+dkGzEOn1wXHZu36ASKJlu0E5rAJcAAlX7L8xavCNxeBQtf7EG
 KiSXpATQ+YUQOVoaezQ2/eoVQAQFvpeYcFy7FVz1CdZPiLl6hiluToe+/usmBvsQl4HDponkkSU
 hfPetZZeP3KTeGUBBYQ13FBbZu6Lt55Feo3WgAjqAmsZfXdnj1U7xYbTHUYNLCXmdgw==
X-Received: by 2002:a05:6a00:988:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-86cca349c2amr3905630b3a.7.1789217115994; 
 Sat, 12 Sep 2026 05:45:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:988:b0:842:2419:6bfe with SMTP id
 d2e1a72fcca58-86cca349c2amr3905593b3a.7.1789217115627; 
 Sat, 12 Sep 2026 05:45:15 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm2272101b3a.32.2026.09.12.05.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:45:15 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 4/5] tools: mkimage: include image-data sharers in the load
 overlap check
Date: Sat, 12 Sep 2026 12:44:50 +0000
Message-ID: <20260912124454.13578-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912124454.13578-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:26:38 +0000
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

The overlap check at the end of fit_import_data() sizes each referenced
image from its data property and skips images without data, since such
images are never copied anywhere. That assumption no longer holds for
an image that shares another image's data through image-data: the
reference is resolved only after the import, so the image has no data
yet when the check runs and escaped it entirely, leaving its load
region unvalidated even though the resolved image is loaded like any
other.

Size such images from their target's data instead. References that do
not resolve are left alone here; fit_resolve_image_data() rejects them
right after the import.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/fit_image.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 03239fbf0f7..c9310155d19 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -951,6 +951,34 @@ err:
 	return ret;
 }
 
+/**
+ * fit_image_effective_data() - Get the data an image will carry once resolved
+ *
+ * Returns the image's own data or, for an image that shares another
+ * image's data through a not yet resolved image-data reference, the
+ * target's data. References that do not resolve are left alone here,
+ * since fit_resolve_image_data() rejects them right after the import.
+ */
+static const char *fit_image_effective_data(const void *fdt, int images,
+					    int img, int *sizep)
+{
+	const char *data, *ref;
+	int target;
+
+	data = fdt_getprop(fdt, img, FIT_DATA_PROP, sizep);
+	if (data)
+		return data;
+
+	ref = fdt_getprop(fdt, img, FIT_IMAGE_DATA_PROP, NULL);
+	if (!ref)
+		return NULL;
+	target = fdt_subnode_offset(fdt, images, ref);
+	if (target < 0)
+		return NULL;
+
+	return fdt_getprop(fdt, target, FIT_DATA_PROP, sizep);
+}
+
 static int fit_import_data(struct image_tool_params *params, const char *fname)
 {
 	void *fdt, *old_fdt;
@@ -1100,12 +1128,16 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
 				 * Collect the memory region the image is
 				 * loaded to. Images without a load address or
 				 * without data are never copied anywhere, so
-				 * they cannot conflict.
+				 * they cannot conflict. An image-data
+				 * reference is resolved only after the
+				 * import, but the image ends up with the
+				 * target's data, so size its region from the
+				 * target.
 				 */
 				if (fit_image_get_load(fdt, img, &img_load))
 					continue;
-				img_data = fdt_getprop(fdt, img, FIT_DATA_PROP,
-						       &img_size);
+				img_data = fit_image_effective_data(fdt,
+						images, img, &img_size);
 				if (!img_data || img_size <= 0)
 					continue;
 
-- 
2.43.0

