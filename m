Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28543C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9863607AA;
	Tue, 22 Sep 2026 12:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qm5EXC0BwfSK; Tue, 22 Sep 2026 12:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3DBA607AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081264;
	b=mZBhvSDUVIVDsh9XeuopINq7HuPLeV8kKC4ehUKgk13cXSF/C/+6Y7Ku9AcywZlXnjSd
	 5smuRvPCCAZIJV5UGPKMnDUOdsj+xmFgNKA1Eq792y1vckAcL0Lqz2pM9CS3XVb0dDhUS
	 By81sVP1H/1+rbkcRVFxlnEGF1PWmqUkX6gD9uStk94DPoshylYtx1rb0vNk4V6lPuSKX
	 zh1jEZrZwDKf46c7CUupY2Ce33hBieKyKwaf+lxm+qlM4/ESx2Ijq5oi7lpgYydFxisg1
	 JhTIOEAwNvMiV9aaPMB8WCyB1fbzGOLKPoCzPYvtXArZumZKI9UILdNTAOZFeWtKpqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081264;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xJ+qqdjFHMLtgyVXDrg11QLOqsVeSSKipj5lSr7rQbM=;
	b=UujLP1tE6P7M2f5X22VBI5do8aW6HP6KdflwZixrtQ8k1Qb3xMwfVCCMuCHA0SZ01XbI
	 Xl7X51YQJ0jcHe95ErOo7SD/QnBHBP+zOURmbb2FjYWgwzKyfckIC59LrDNgNjWGky2hg
	 gjn/Pm5pPCvipHkF1s8Weo65Hxo0mM3a87U8RUuEckXafcTYRt/qYejn5eP0KSjbeHhUg
	 EwDMXyWvqo88QCrFKY+qUWj/K/ajXc+HG9WSqbzGJ1jYYaKl5hv6pLp3K/7NcciM7caP9
	 ZMbNMCqVNcjBfuftC+RHBLEHupxYsIkCOV6jH0WS77fP5CJY8HG4C6uj9xooprige7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=OvQpqkWQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081264;
	bh=xJ+qqdjFHMLtgyVXDrg11QLOqsVeSSKipj5lSr7rQbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYIqj97Zr30RgnBTGwOFLncQ+v3dQMp9GEZwKFH7vR/NGMlkMXwUhC2uag05lJHgP
	 G2RA1ZWHoBuMSOboGoRPv1dP5Y/8CYJNoeW7ht26tU3MFMlm0WLhsaVG1eiHyn3MQ7
	 /5EzQ0aXwnRUF1YZmEoJkrq1Sh+TiK7RPKBzhqjg2b+V4scHtKVgqW54XQ0ZQNdtQY
	 ulmWD5NNn2H0MCX0KyS/POjCY7OjeFe+XHI0zC0WCoovpbyIUgRVtxznNR6dmYB6HX
	 QEbHZXnPsqbAbCy2UefCJX8OGdfRqnVoPmBSnwl8UjTU+aVjUzOgPoamKGpqXBX7+F
	 ein3PX6RJjOIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3DBA607AE;
	Tue, 22 Sep 2026 12:47:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F10213B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 512C060737
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yr0jx748r5wa for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6ADE36061D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080629;
 b=JtIKMZESHZ9D56c8XZa1gVJI3IwB3Gcwf05gRktUbV/d5/DVr/nq7ZKeotqpICW1VVT5
 YeOofKmZ0Ka+6rG3BWn9uF0Xh6QebICZczlOIyYMu9aMmrlRpRJtaQ00FpMQ6NWjjZ/cV
 aL+Gf0KeTjPQMzh2tQ3kIT/TgxuG1gRoiLXbZBjajBb/GXqkohJqpQEvevuthSk8/2hIe
 4sFscndgl0/IDfeBdgBM3/ukORuATgA5NOMd6gx+nBUZuWGuPQF36THacfh4XoIO3D/rs
 zFM619fgfxJx/d5m7k8zkd5PBCgjyYIP83BtUN8V47wGCeyHVE1bgqSif274eqW/6vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080629;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=xJ+qqdjFHMLtgyVXDrg11QLOqsVeSSKipj5lSr7rQbM=;
 b=gmo6CMtR7m7d3kCOUj1VG6VbTATYreoFJemXXdOmy24xbOFQKidlAhpfBh/jYSXGjiEH
 KsNbfV/ADPEd4NGKSmnrylygqECamD5M3f0iciFqQRWTyI6EgiU14rdY3lzFMKDxvzxnv
 57sBQqa+f841JglKa9ijTr7o4x+eINNCmbCDCBXEbWqKb6wY0xFPsHwsQ6OZoxj+Rt2ks
 sA1AUNS+XpwvUqor/fWfOffn9bQl5Cpy7fUNk/mzzmYRheMImvaercqwX7ld+KU2Ioa1Z
 DrObhtnhB8yiLK5+z6qkwWq60JOgU4qCdf9PozNy/0Emz4RdowTLoo3HeY4eslA4tbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=OvQpqkWQ; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=OvQpqkWQ
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6ADE36061D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:08 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 679803F5B7
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080627;
 bh=xJ+qqdjFHMLtgyVXDrg11QLOqsVeSSKipj5lSr7rQbM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=OvQpqkWQlPpMX9R80ZajhsZP/MoLhw9njDYqByvXu3nl/KNj2pTFvLPNqEe88Njtw
 lBvvcm65OTSg7lP9QuDgyi29kk8bxe+3yFtnQkNV7le4+Q4z0uCIwHqMD05cjBhjqS
 5GE+UgQ2RpfdP149iKUO9AZSkrjF8Umrhn4k5t8ZmwQBN+A9Hv6P2diTsLIMfhabiq
 +lK8PYwjIRuz95lGCSgYXQD6sSeEsUtfAUQmQyCiS9KAAXo0cpButw0A4KKGCthN41
 3EqR0+Hhy3zzESjHEACgQ6Ue531VMFlChp9+f8tnddsRy8MpIrriDJIUKrCUT3mQyd
 80PgKIiqtar5lzWPXXGTclEm+yXCCIVKBVzAhTPQz0ftrCNix+swgn8mSLPrvpWM/S
 jtHvSHy8wnUlSxd5ro3l1fYav0yrUSV4cmXeCEkDN2DrvX56NkgD3HAfh8GqcENQws
 XsJxDsz8eQocGErQ1tFG9ew8mXJSOp8rwdihIIa+AvcduHdn9/f8Dw1oaS6yVQ8ufl
 JO3umkYoKUt8XuXgTjPdqiXtixtycz+4pbzA1dO0pzdczL/x3ioMlNOMOd1W1giYXO
 tg2SMwRksrcy3ab5BdJ1DfYATl1X8JzBedNE/37Gl/Pz5T+ixzNLyOqQ6Xog+7dTVj
 2LrHGZa6eS5bxfzGmXLZPwdE=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so9017195ad.1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080626; x=1790685426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xJ+qqdjFHMLtgyVXDrg11QLOqsVeSSKipj5lSr7rQbM=;
 b=pz6YazgLAu3g901pwbc1egUTD1/OXWEi3iOgOngb4Dv+Ii7CweICcl/Gph8oFyCAEY
 lvPF8SHGeYa+nnSvkQy/PPYVwhMfDEWUgeOxb21eXx4j9uqk/SUxnvRHD4h80t72K7qe
 YAZzGB6ZqljtB/jELZqzcFNrBDjA6NPhOZAEcM5uvt7DJDDgHufCRl06x5KEz6SjP6Od
 C4w/8wQyTh4F6dyiFSR04G80BwNZil3eRukGw2fiqHDjn6wQRKnl1lM0kVrdW5f3bUay
 g23rCJfAGYignGT/tlMhCQj6v1r5g8t/jwiCiAXyQoao+hFNCopFXEWYfeZRfa3x/Ifp
 X2Lw==
X-Gm-Message-State: AFuF++kBDfFWjYg6FD5ygNFGo8Mff+iDoKZpEXa/LRLKTiqDzg4hxQ3Q
 7W3DhwDm6l/P3ktfip8xY2E5vK8MkbfxDblA1+3MlG8nj1sCXhU6PVsHG6Vg69O30O2QHwpAd3c
 ZguOx0v4XFfDYDRiW3dTpJrbMQOC/E0AjEkgTuDPA1NW/5C6yYE/uQ7KzAu7l/qvu0Zcc+3md+A
 S0BoivOMMpBx+Neal2/A==
X-Gm-Gg: AYBFou1kmmYQQo/yjVsix+0HF6fkokUPZdUkH+bPJV4AfUTgnRFTjv/7R5s48ePA73E
 qZZIR0wCWfuHvvyCV5BMmFc7GWPJnF1aJWqYyXqR0TgkEAgZQ0z80wvCF+YL7M4WmDcehTMTK20
 dFhn7+wyTcMyLpfzcN+9b0RZDlarETeHC5wrWnpxZbJTP6mnJGXZfJURo6oBbceLVi3kccqD3zH
 6Z8HNQ31VLRfWt11U2Qw/ln5QxQ5xOe9imnFtAQzUJlsjBgGNHMiIuJ+ZRD0nvJRi/wPEcJ8BKs
 xG1Z0hbQlYkfOv26jHmguWwc0KSrnpg6ImpTDMt2CsXawlMpC06GT9Vp+1GWIFBBFthIjmBeLIa
 PeGiHzlQuofeU9iebupb/DEXihx48VIBKYVTPVg6e53xOT4LhldQ=
X-Received: by 2002:a17:903:2443:b0:2dd:c053:b9c5 with SMTP id
 d9443c01a7336-2df60ee16ebmr8761115ad.22.1790080625762; 
 Tue, 22 Sep 2026 05:37:05 -0700 (PDT)
X-Received: by 2002:a17:903:2443:b0:2dd:c053:b9c5 with SMTP id
 d9443c01a7336-2df60ee16ebmr8760875ad.22.1790080625400; 
 Tue, 22 Sep 2026 05:37:05 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:37:04 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 5/7] tools: mkimage: include image-data sharers in the load
 overlap check
Date: Tue, 22 Sep 2026 12:36:25 +0000
Message-ID: <20260922123630.608961-6-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922123630.608961-1-aristo.chen@canonical.com>
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260922123630.608961-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 22 Sep 2026 12:47:32 +0000
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
images are never copied anywhere. The previous patch introduces the
first images for which that assumption does not hold: an image sharing
another image's data has no data of its own until the reference is
resolved after the import, so it escaped the check and its load region
went unvalidated even though the resolved image is loaded like any
other. This completes the validation for the new property rather than
fixing a pre-existing problem, since a configuration could not
reference a data-less image in a meaningful way before.

Size such images from their target's data instead. References that do
not resolve are left alone here; fit_resolve_image_data() rejects them
right after the import.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
    v2: commit message states that this completes the validation for the
    new property; complete the kernel-doc of fit_image_effective_data();
    comment-only change, Reviewed-by kept

 tools/fit_image.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index 64e607ea55f..b4a97656ea4 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -951,6 +951,41 @@ err:
 	return ret;
 }
 
+/**
+ * fit_image_effective_data() - Get the data an image will carry once resolved
+ *
+ * Returns the image's own data or, for an image that shares another
+ * image's data through a not yet resolved image-data reference, the
+ * target's data. References that do not resolve are left alone here,
+ * since fit_resolve_image_data() rejects them right after the import.
+ *
+ * @fdt: FIT blob containing the image nodes
+ * @images: offset of the /images node
+ * @img: offset of the image node to look at
+ * @sizep: returns the length of the data on success
+ * Return: pointer to the data, or NULL if neither the image nor its
+ * image-data target carries any
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
@@ -1118,12 +1153,16 @@ static int fit_import_data(struct image_tool_params *params, const char *fname)
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

