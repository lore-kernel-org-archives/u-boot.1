Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091D0C79FB6
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B804B4077F;
	Sat, 12 Sep 2026 13:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RyfpjVUfmP0k; Sat, 12 Sep 2026 13:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AE6C640760
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219606;
	b=T/xNFyJh2oPuQPlC0vfoNRRF6q1fCeRkGKYqj2/qaahPniUVox+BSJaE8E4TF8Xn2GT+
	 WUOqaX/61I/77jd2oGzIr3Ey6B9QOj2rFTltmQTxXjay0/3KjS4lhpIl1mKxzCzOqGYxA
	 CTHhedQ9reb9GK921WfnglR9dszDf7CShCnRe31kdP/mtoiNXmJfcCiyshtwCrVbFQjBR
	 RZy+WtpofueW9kzw+9+m8J8weQ2wSlL/BCwVgua3mQnO7uuz58meX/YumE/yquy+0GMH4
	 a4i4FkbVENVUWF5wCmgivVYduOMQIhYSOdBGOzLPHAG0/r2WkqHy2rHaLt6f1LJ0rfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219606;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ca7VlH8b4F3M2adRiN56R7HusxuhI9TRaiK/3w3VRvY=;
	b=HPZaGECQEkLyK8Th8bWEInxRqjbOioAxN5Hh9dTt+3Q2/v8iJkw36W3P0Qv7oWCQjhGu
	 UChWkgD2B33RWICbynSAVzBARG8HEWLOnEGAuo0hec9SJ9Ix8x2vAJOsm8aB/ZGjG12Pi
	 vE44PpJu5rd1gREkSEexwX8hWQslVqLkntIrF+T7Zw5ZyTzuU7uI4Q5eWrhMSKB43Jrwq
	 OIszdjeFnjMWIeKIfYVUtJKa+ZDaePDsHPAs+on2k62PdajqRbwMXLjJLki7qV54bHl++
	 VVrY5Uh3W9GxAZuiCfw8VAD8kSzqzu5ZcjfUnLVIc1uIZLIA13gCn3u1Uzsn8KzovCw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219606;
	bh=Ca7VlH8b4F3M2adRiN56R7HusxuhI9TRaiK/3w3VRvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=skTFAi0njgCzGp19caRjiYjoTiEQD90vt12EULnzEYWkXVfhlz2fMM2VqiVCT9mqE
	 OqbgUzX3uA6sSXKXFyUyMZSWvi33pS6vD8B3dwF6JT3ubEOp4Q1sXPAqDJiZDaXNRt
	 fbGQRVXx3Dz8tw5EsrXKb7ykB1UO8fK1U1s9oyqyVmwSlJRRO8HPD/Be/PpnFeRBhb
	 Cw8Nfi5tYxyPBO/ZbrzTJ7+1lRkXH/ot1Ez/48ejbUVWu16E5sz9bS4J0JMaF9csOL
	 VSal0uUxP2rwxn9dOGAh8NAU11CZcMa/ukhAYetc54ZRN/cV1X7NQGX6x4UwQScMVf
	 F7+XfP3gU2fJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE6C640760;
	Sat, 12 Sep 2026 13:26:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 704E02D0
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6232680D15
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r6t7wDSuZGZL for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 12:45:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5746980D73
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789217117;
 b=TDit0xPYLfiXpnRDi9bV9CFhV96pvVrvbjI51m25i+/RV7qy8CJYSYfUQNMTehzbZ9mp
 EPD7UXcz4Y0C5JACPlsNU7ihaBi/49WTmWReNA9vMWbWvHtUma7PhU7FanjHFU3wcCFL2
 AKeIL2M482GWepjwfrCsXqeR4r/iWFZ9XzAt4NCC//KA83mxbx8wDjBPy6eq9D0aCYhqC
 WYtGCl1CpV2xRmoIN4ebE3p4xJgqR06QbbxfycBdU1rXHEwvPM0JXFaxdkWyiXHGNlhGV
 nx92NEQWcK1JjIs7M52bbiUVwe3TbAG3am4IEAvkvgRX6hlCeN5EHYMO76iWRlZ6IyA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789217117;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=Ca7VlH8b4F3M2adRiN56R7HusxuhI9TRaiK/3w3VRvY=;
 b=LOGQPSBeVe50FI+okYlSpHn0LCK57/CliLCL6CJ6o/7GFXe7oJn+pny669hZC2w0wwpV
 Vn89kHGKuUBJq4Eu96vLZKgM6C9wNSFAUFnhkZ/+a5+Zk93ymBcWQurfsNBwNAYbicJmL
 hNpbIzu89Un2ACf+TljdY9g3jZtEPM3pMcsHwgZkjTLM/yQuaPFKv9zT7MivvNQdYHe8R
 2g4+bHrZ5Q8ahsPJnWkRDG2Vcf/iLXqTSnVN7ynYDrkIFJ7mrdNMZ5h0YWvYxgTQ5iUkd
 JLnxXjRqXDZaLgR0mAMJg4TW6wHV/y49VYNY95pQrXE48MUw+MN/xanqRjYjmX4J+EA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="d/UWg1tp"; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=d/UWg1tp
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5746980D73
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:17 +0000 (UTC)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 649773FE3C
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1789217115;
 bh=Ca7VlH8b4F3M2adRiN56R7HusxuhI9TRaiK/3w3VRvY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=d/UWg1tpSgnsbMM/D5cmmwjn72yFdMv6t1KyCfGmNJmxL+PubLZY/7GVg3GnPUMYl
 D0R5ZPP5Ux0Cs6IgiCt0EocNu2VEqYD8ichXMF255l5FzQnMfSVXcPoFg47uUsmMCb
 4Myv2v+p1sBhs0YISxVKm5Q4MwOnnpT0cc/X3A6Dv2uY4LGXisuI+dhLevhs9OuFUX
 fGbvtahDN9LmrZSMH1Khc11REzjsO/4k7X/TC/uhq08GbDWkN7MWBtXZKGSg5/LPHG
 Nq42uKplcttyh/H037XsocmNXfGwypHILkLC4s3I0p41ZKXOnU8JG6PwcZGkHSR+Kh
 cZKatWVM5kwSvCpCKZVFitWju2c5IXaJDqxcKtxgSZw+iWpl3fE7mpJeCajvZn8QmV
 wZ64LGmMay4AUxilUNhnnY3GHWroRhAqVm5DFZzxumwHnoQ8kl0jhVygsxrl/znqhH
 zOwA3dPKBxCO8BZSehIc99iPKDDKUqyqgkxFFsRRJRbcnpM8gyr3vgFXd2aEDXR7hJ
 3tbwkx4S8nKv8yVuVLvbt4ws5HiyM4TlWp4HRGXZx1ut1KqrSrfm5yAQCdE6kN/Enq
 kqgJQuLYHyl0NzyVnEv0mVMafGV4EfaeVZ7FbsLls401AwtTnltC+RFY0uSWt9vl8n
 mkst0Nfgb92lAdr8N5Ocv+rg=
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso1667408a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 05:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789217114; x=1789821914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ca7VlH8b4F3M2adRiN56R7HusxuhI9TRaiK/3w3VRvY=;
 b=ie/IMamPjwfUYUz7cA4yhq83Xt3Ral2m3ckfeHeDJB3QclgG7jo8WgLm6rA6r2BFpA
 zSqbnzslva9wCjkCAR2QXb8BVaVHNSdSwcRYOjSlN5rWeuFZ+adNMSNJgL8XguY9piMc
 3A2mMB5O2h6CXXOYTx6YNQtBINLn25JuGcSyDlg1OdgdihQk24BoQUeD6sUigX9cfn82
 n6cdZkGo1ZFtVXDbj5aqB/PANe/+Zt2L2ilKWnWef40KrUtSGsVWjzBm9yzK9jZLDWIs
 kitpC3G4F+gb2J9HnGJYAAf/YYj/NGKZS7LBwqYuaw2anwOY/Frofkz4wAVu71S74e1C
 Vpbw==
X-Gm-Message-State: AFuF++mSlOAVykHxXIRqCQVlUq0tA5/lL0VEZCNkBCETsk3wtvot/ptJ
 igLBu64dZpBmFyOnpBa2Hwkew5eIYFhnnxhbLmQadJx35FHhXQR1ZRVKaBi/ep5ZwRtpcNvPZfb
 7wEbzXLfT5HjAt19GH2vrhzQbfjTLJZkMqvQ44Xk0oW054JBR0mgtefNczloWSY1oOn9fbM83FC
 0ymVqsC4bVmq/8WMVvTg==
X-Gm-Gg: AYBFou2rwiEgnhwf+IB4dtPqolEFBBWApxJa4xUnkexJSN+XEquA2yEfFBnhxAs1j7z
 tRF1Vfl3aoX8dtRWyrlNp1jB3kan9Xj+49TZtTaCCpHaaW5ye4yb33N+fkXOLlaXHkG2546ztfK
 NtEmL/CD9NCARx8dcyDpJcLGNhwE0RoI4TaF5+xLZ9dLrU1Lrd7ERG+tLWfMG02laJ22wIGyQzo
 tvAjxYqCDMWemIXNUoSbGL9URmmZzO6tzIXTU2qRpDGBptf14NN79RN1by9TNBwJoY5rWpYtiAY
 wVmIBXr6+cCMr5dtytz7ESe86mGgJF4Nba/htkzRgJn4goc5uoQFtSGsqxl4FzQ+KxocMO0AvqL
 38Lp5Yvi5gl6wd7H5gj9Vl4Q63Vg48XZ/mF/yp257JU/HyzfTZc2Qx6o7ZzGRyci3pQ==
X-Received: by 2002:a05:6a00:12e5:b0:857:73e2:9105 with SMTP id
 d2e1a72fcca58-86ccc83d3camr4078149b3a.21.1789217113729; 
 Sat, 12 Sep 2026 05:45:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e5:b0:857:73e2:9105 with SMTP id
 d2e1a72fcca58-86ccc83d3camr4078077b3a.21.1789217113203; 
 Sat, 12 Sep 2026 05:45:13 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86b291c5e8dsm2272101b3a.32.2026.09.12.05.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:45:12 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 3/5] tools: mkimage: share the external-data region between
 image-data images
Date: Sat, 12 Sep 2026 12:44:49 +0000
Message-ID: <20260912124454.13578-4-aristo.chen@canonical.com>
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
---
 tools/fit_image.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index de9f73ace3f..03239fbf0f7 100644
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

