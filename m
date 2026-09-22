Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435BFC98302
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 12:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF2F780E27;
	Tue, 22 Sep 2026 12:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qaqjyIarFsBl; Tue, 22 Sep 2026 12:47:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3590680E28
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790081262;
	b=WO+rpAHlWcTN9y02qttiD7E8B6FTp02JD0JRk0A0WM8R/sj2RGdnTcQ0Wx8IALz1ar1P
	 CtMGp2670EEtEgrP8faiB4jEnVF0HzZh+/QEancHoZd/TJk0Aquh/0lMpo04eBTJr5eKK
	 9fV1/XonwCJ7jkn6knXyADdIamvpW1dsPpv+VR1rYpSRF20lMq7eMP45KBBUTqduBlnPy
	 ruAw3h8ICmIzq+0dD1oqNgeHTzF5VkJHgJKAyveqCccXtR7RgLXIwYWibEb88xqZtDm/Q
	 56PeDfRlvClVvWSfk2tfIwQiywiT52zE4BjrEfic8MUwCsxw4GcnSoie8wzf5IAtd/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790081262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6cDcy8XuZW5ZnV6p+wALsQWSr33f8GefQ7q/vNSOgWs=;
	b=NHerRVPdvsrrBQsHewNC3TlMFafVZqTg7PvP6sTv0YSSVi4itBFI4Uzza93v3MLQrls0
	 pBrWywaYFMgN78wSY/1rWMcYXhiHPBUEkh+g6ZequdeOaAm1orjETHGA5BupgUUwdpCT/
	 t/3gM8KjpdRFiW3YVU6xDFZe6LmH92g5tlwzfZNTzRBFsg57ga2iBMtVEaEagrN9pXGhc
	 u8Z/RkOH/bsYeuSBzGKC+t9eZRW9t9siioerlGTMaSeDXdlPSaErVtvyqYFnht3kwdyAT
	 dVbRRci+KF00bKUihGFepfX9cyqt+Rn27iE0ZV2RalkWXHmKJdFBhuDmJ+x5g49cEPQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790081262;
	bh=6cDcy8XuZW5ZnV6p+wALsQWSr33f8GefQ7q/vNSOgWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LwhRgKy/hXtBQVlF/uOvhrTOdi8MwEDL8TKCs70UooHkFi+Mswo33ocju/AuSmJNB
	 FokTEZY5WicHkFfJcNKwqT1nXyBq/6Wq2BaffcVFKuYKqcQCUaCHBLG4yG/NF0vfzO
	 6KbHZ4II1LqpRwT1+z0WgwXUEYgruep9LM8WkJPU6xpwng0HyQ9B6S8brwIAwFSDC0
	 7uDPiqtThuUPeVsaIb9edNCxDeYv+feTp3iXw8ymB6/3S6dDB7R2800dRPciy8uKCY
	 zM05pRZxscpI0L2NAWHYqQLdVLzYGVntVTz2rjmXsCprdlXCiQOlxJReX3oqFDl+EY
	 3z4S65jucnlOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3590680E28;
	Tue, 22 Sep 2026 12:47:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03F393A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA0CA400F1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Y6LK9e0TrwQ for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 12:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DA782400B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790080628;
 b=GPGPT7ftkT2T7DhbagF9dvrq3d4dE8gF4kGJxIgUYKRd7WwhTeF5DTzLMwmGAmMwWpi4
 gDaWsLe/BPLU2IDHtvb73MBwOzU/EkteMlj0Gf2oOByeN4XzHsZrjBG62CIbmLbtsR6m1
 qczPXO4rERoMtEbYLHUOUYJcHeCO+X4N64yHKRKbji+sZIkThv3zpGNRUlgxrvH6UsZ81
 2nareBjz59RBJknVxJrQGXyoWwKxoNTDaKC4c3D0vx7nVKJQZnRau37V/826RVMuivNYF
 TTazc6BeuS6uw0Ta6f2vOTHBqh9zGi1egUTpr9Nm/fiH7uSwSRumhlzbzMOAtvZtQEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790080628;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=6cDcy8XuZW5ZnV6p+wALsQWSr33f8GefQ7q/vNSOgWs=;
 b=MTzizSD1RXW48ypqMnmnHso2TJRFym1sfXbz+48TSHrti+S2PVDKz9py5+ifXUlVWvmQ
 z69azB6OTJWD68ye/F9Qxvr0Qk2KWf3k9wVlemdDd4YZ5jnmlf3AVf9AO4cCatUFhGaT6
 xVZgaADmZ2bwdZ2eK58uCiPM730qVHmaPk6GV2LwfOz7m865w70s/ZL611iaCC2Mr5RxE
 O5L0XKkjVjFErATFLud5nk8vbweDd/F8L0G3+8vLL2rrVVk1EtlNeO12zNlJ24uCOPp+K
 wNNw/tfJeNSIdiGRHpugpVvTn91mhsP/kD4pQH01vBlfq6qdnFVE5+ndm6/tmj/7zuw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Ewu8fBHV; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Ewu8fBHV
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA782400B0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:07 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 79BB33F322
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790080625;
 bh=6cDcy8XuZW5ZnV6p+wALsQWSr33f8GefQ7q/vNSOgWs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Ewu8fBHVjacutMvgS2gRUHeDJWcHqw51UwJauIIILdEDwOFlzTjcJAblpTKVnmSzw
 sFpzk2VPlcw9PJAG4L2m0mNQX7WRvFhpUqSgpSy5VkBDlCCELw3LJD0rJT0oWhWb8U
 l0Ar9MCp0Rd1IxOagFU1gNoLahSevakjf1u5+yhzyy74JhyplCEIS22YezCM/DzDBH
 gu9/Sz+5J1bfjnk6wgHmiIKMObKGVKZ7UlCbdHiFLduuHtTtmiSlWAondtcsiBHl5F
 lZkY02XGgQHH77E2+USfUHabcB/4pUmVHSueMex5M8JRnDp6qo5viUXUv/kbqL/6pu
 /wvKRib+E0x2kRi2zrXbyPEI3ufo2ziL4585877IC+RlVMvCpFVDtEOlq4ZgQaRWGB
 4s/xHm9JBmgEWsYqfCcS4AttQjqRueSR5vDxDzXOB8M6ai6lI9WRG0r3Q8JgFeJtWB
 hkTssKG7/8RJ5k8Pd9D1yG++9LJ0OGEgSZsVEz5C4sC+bvqc/6K5cRJSnSxuPsOm2t
 G/YP3o9eCiiP41A4Y+PyIanbk3/VaV1CpfEgqjtgXq/xU6A2Y26n1KpcXhe//0NqsC
 SRf7/px/1deG1RxI+79o6jQlRajxui/9GU5fJq3QLyqhp4m7Vdb/yifIKn+85a0G9n
 B0FTX6ZYfK0CBWIFDVyI67Lg=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so57309385ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 05:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080624; x=1790685424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6cDcy8XuZW5ZnV6p+wALsQWSr33f8GefQ7q/vNSOgWs=;
 b=qv8hV1gjwY22HGqWzKDwkvNBqWsawg51f5yPuT3bu8OgpzyIMcxIVIxTNPWO7OOrsa
 Ekdb3LpfCpEc3aQIf0r8Z4vHT8OwCi4RyJUjPDoySmHPNhRUWTspzDYvJI46PWehuHNX
 JXukI/Cw9RvOBqxktIBN+MVBVixQJdsnQZ/3/HaxEJX8SOrSWTH5Xyz/CC6EGtxaqUj/
 KRNmVQVBfpetLdOkdbxshd4QRcWyCwse07/VBr6/gbtLKKVOKISORz5kOcjcYiucyA3r
 z+GWGYa/pUewM8XmZW0vFz3d2yd3cK3KNGDjOWs5yLCA13BLS5YAXr/csisUMJPDsZ/l
 hv8A==
X-Gm-Message-State: AFuF++lIUGREbydm5l8OLJ+QK7brMFM4FrFIlEdF8nwZ5BN0joVkoCRb
 XKyUs2fc5HtzFulUPKID7evcF16PC3bW8NFT2jrEuz48onHwFfD8SdqpJ+pdru/llrU5cKYwAKn
 +5a+pLSit+LfYuvctsoaxUYd43M8UKSYOFH+Mke2Bw3DwspG78BiBa0/ARpREvwNVHlbbIb30wW
 IFF47mjD13+vNoFOznLg==
X-Gm-Gg: AYBFou1E6fq1ksTBTwXvMI7kjhzxOQ1+8TY51ADpzlwGEnFFs3HIL9KpeHHGrzAuZDH
 8PSQaur3paSUTOqfwvnBMAMkciXgb2AP4gGIt8d/QdghpyGp9nFfKqEaEthejfZ69Ys0zS2o8oj
 WEXBpw9N5IMfn30RGQqGMt/v+lhlnameAUOYRwVUTIL0qsDj4wXssO3QSA1s+8D8972/yXtqMU0
 kHjoDyakXztDusak+DzIb66SLxsK8fyLdrqSSXnl2x+2ohLletZ7sRQoDdbxRNHClF812r0VIHS
 k511yBuatal6xo2zeZRXGw/rrDR4hZWURSe97AiECSCH5qPhNaA7atFjoyZ0jqxhoLv3xLgUpsq
 3xeViI5U9VJkgP5yxL6rDZXwvV+HYP0+PfPAn6fUrLNDiP0a7DkU=
X-Received: by 2002:a17:903:1aeb:b0:2df:35f1:8771 with SMTP id
 d9443c01a7336-2df60b76868mr12101015ad.54.1790080623643; 
 Tue, 22 Sep 2026 05:37:03 -0700 (PDT)
X-Received: by 2002:a17:903:1aeb:b0:2df:35f1:8771 with SMTP id
 d9443c01a7336-2df60b76868mr12100715ad.54.1790080623222; 
 Tue, 22 Sep 2026 05:37:03 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d058116sm9054105ad.77.2026.09.22.05.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 05:37:02 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 4/7] tools: mkimage: share the external-data region between
 image-data images
Date: Tue, 22 Sep 2026 12:36:24 +0000
Message-ID: <20260922123630.608961-5-aristo.chen@canonical.com>
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

When building with external data (-E or -p), an image sharing another
image's data through image-data still receives its own copy of the
payload in the external area. Skip such images while the data is moved
out of the FIT and point them at the referenced image's region
afterwards, through identical data-offset or data-position and
data-size values, so the payload is stored only once. This is the
resolved form the specification describes for external data: both
nodes reference the same region.

An image whose reference did not resolve cannot reach this point,
since fit_resolve_image_data() has already rejected the FIT.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
    v2: no changes

 tools/fit_image.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index f1c3ef3ee66..64e607ea55f 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -813,6 +813,14 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
 		if (!data)
 			continue;
+		if (fdt_getprop(fdt, node, FIT_IMAGE_DATA_PROP, NULL)) {
+			/*
+			 * This node shares another image's data, which gets
+			 * its own offset below; don't store a second copy
+			 */
+			len = 0;
+			continue;
+		}
 
 		ret = fit_copy_image_data(fdt, node, buf, buf_ptr, data, &len);
 		if (ret)
@@ -849,6 +857,44 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 	/* Increment 'buf_ptr' for the trailing image. */
 	buf_ptr += ALIGN(len, align_size);
 
+	/*
+	 * Images sharing another image's data (image-data) reference the
+	 * same region instead of storing a second copy
+	 */
+	fdt_for_each_subnode(node, fdt, images) {
+		const char *prop, *ref;
+		int target, offset, size;
+
+		ref = fdt_getprop(fdt, node, FIT_IMAGE_DATA_PROP, NULL);
+		if (!ref || !fdt_getprop(fdt, node, FIT_DATA_PROP, NULL))
+			continue;
+
+		prop = params->external_offset > 0 ? FIT_DATA_POSITION_PROP :
+			FIT_DATA_OFFSET_PROP;
+		target = fdt_subnode_offset(fdt, images, ref);
+		offset = target >= 0 ? fdtdec_get_int(fdt, target, prop, -1) : -1;
+		size = target >= 0 ?
+			fdtdec_get_int(fdt, target, FIT_DATA_SIZE_PROP, -1) : -1;
+		if (offset == -1 || size == -1) {
+			fprintf(stderr,
+				"Error: image '%s': no extracted data to share from image '%s'\n",
+				fdt_get_name(fdt, node, NULL), ref);
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+
+		ret = fdt_delprop(fdt, node, FIT_DATA_PROP);
+		if (!ret)
+			ret = fdt_setprop_u32(fdt, node, prop, offset);
+		if (!ret)
+			ret = fdt_setprop_u32(fdt, node, FIT_DATA_SIZE_PROP,
+					      size);
+		if (ret) {
+			ret = -EINVAL;
+			goto err_munmap;
+		}
+	}
+
 	/* Pack the FDT and place the data after it */
 	fdt_pack(fdt);
 
-- 
2.43.0

