Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19830CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC47847EF;
	Fri, 22 May 2026 15:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="aHM953Wn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0480C846A7; Fri, 22 May 2026 14:31:53 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4955841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 14:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e363c6141dso6097179a34.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779453109; x=1780057909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+SLoEs9M0nPBReIid2Nfuwy9e1D2iYxkrEJ7hdqd0c=;
 b=aHM953WnRiwXCf5LId9HQXrmoo6vxuUCbl0G6dIVwHjwjy8mv+17WbWZhygkQUyyUv
 YxZ28XuVPFBBDyJ7mf+jyaJrfZlKn5hBAoM4+A+Qv5sdM6yaXoNPaF5mXcakP2ucB69P
 cyhzBFeLxTnfnUO0GRp1KW6SvDEP3FCmu/CrdQhaeyX4ClfBzkkDukmQXltVSZnwOAun
 75xf9K80/HqjjKNQ67ZNlQfqbXH06yRKxy5B4b9M/epW9wFoMGaWJpDmsARuc4GJ7pVV
 905UFoxWa21Uw6iZ5kbXWUxZLC+EUM/fJoq8yO+cwMtDALo2Qbk7PSg3+KkWKRmr0bA+
 jV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779453109; x=1780057909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P+SLoEs9M0nPBReIid2Nfuwy9e1D2iYxkrEJ7hdqd0c=;
 b=LoE6799S6yl6mX2/TgKcPab4J7Xp+c8h84XWxPeDpBGdTwj8R6t1Bf3NSMkWhHk6RH
 gbSxY4aWy2zSv2/glocfMzpGvZizK+I4vzX5ISA27GFC3Uo7xm3RHqzy4TUgjQmAAZVd
 4r9Sxg+yB2d66+00fpjWtkBuW2eDIbqmP7ZH1sADFCge//rNMMMehU1M26/KBbacwvEP
 Aqs7VmyVT88F3xCeO59nVSi4Fgn4w6WkgauiyLrrvOcO2tBgZoHYhDoLv0WGTVj1IFIh
 Dqg5gNKPpDAR0KUyjgObP4arxyUiWtgKvxCbIf+Ql5XUhHHvsUWWmpDltsvl+urt7ec3
 ECVw==
X-Gm-Message-State: AOJu0YwuNg0mePJxIax1XaCfJmG3AeVUjf1yFIE/1kMY7hR8l+tmSqgo
 fQRTNtQxLLuerQuXBKHxjbNvT9WXb6NhbIQfU8cBnkHXSM2f4yhyPBVBfdzH5/DB40owIoIad2i
 QX5im
X-Gm-Gg: Acq92OGo+ylNfNsVDcOO522FO1LiwYAvV6xlJQ9igRrYAy5mJWH76fAb2fVvkvcjxVX
 Y/UcyrcSPZUkjNofWgG2av218G2GZ/bCnqyqmSpbkeHxk92jPkV7m2CvFfuA/IvcvFVUpvh5ack
 aqlHK2+5xjl30Yegm5pw/hy6luFuHLQi2QDuLPYUaDB5G7sKrCtQjGB16cPqNsRzxbN2+Ljtnus
 NDK5Uo9i1La2eLZtP/V8DCpvHoWQISOVqH4XlqAia2jisa2B/ILB0ASsen+0jVxSPBqA9+Es6p4
 rld3uZ8vAJfq9FKlRC5i3rClEoh6Q+U64wjrdWthwtfRGo8X24NpCLp6KzVRBLTkDSRzPICeGXa
 PLACbo2BNNz7T3iFs8Sw9lu32xwOBPVbTKHXWdmZT/NSCZNItX7gKRRrME/ME5d5jrP3pLM4AzM
 TFoUecfOwaEX79rT0dNrUIj9+qHz/tN9Hw/OViDf05TnzJJA==
X-Received: by 2002:a05:6830:4705:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7e5feec29damr2036718a34.21.1779453109583; 
 Fri, 22 May 2026 05:31:49 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm4016553f8f.36.2026.05.22.05.31.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 05:31:49 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH] fdt_region: Check the return value of
 fdt_get_property_by_offset() calls
Date: Fri, 22 May 2026 13:30:22 +0100
Message-ID: <20260522123024.6292-3-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-1-anton@binarly.io>
References: <20260522123024.6292-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Binarly Vulnerability Research <vr@binarly.io>

The fdt_find_regions() function in boot/fdt_region.c walks the FDT
structure block one tag at a time, building the list of regions to
feed into the signature hash. When it sees an FDT_PROP tag it reads
the property header to retrieve the property name:

	case FDT_PROP:
		include = want >= 2;
		stop_at = offset;
		prop = fdt_get_property_by_offset(fdt, offset, NULL);
		str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));

fdt_get_property_by_offset() in scripts/dtc/libfdt/fdt_ro.c
explicitly returns NULL for any FDT with 'fdt_version < 0x10':

const struct fdt_property *fdt_get_property_by_offset(const void *fdt,
						      int offset,
						      int *lenp)
	{
		/* Prior to version 16, properties may need realignment
		* and this API does not work. fdt_getprop_*() will, however. */

		if (!can_assume(LATEST) && fdt_version(fdt) < 0x10) {
			if (lenp)
				*lenp = -FDT_ERR_BADVERSION;
			return NULL;
		}

		return fdt_get_property_by_offset_(fdt, offset, lenp);
	}

A FIT image with a version less than 0x10 causes 'prop' to be null
on the very first FDT_PROP tag the iterator reaches. The next line
dereferences prop->nameoff, which leads to a null pointer
dereference on platforms where the zero page is not mapped.

The same lack of validation exists in fdt_add_alias_regions() and
in fdt_next_region() in boot/fdt_region.c.

Fix: Validate the returned pointer before use.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
 boot/fdt_region.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/boot/fdt_region.c b/boot/fdt_region.c
index 295ea08ac91..0a9d47bb2bd 100644
--- a/boot/fdt_region.c
+++ b/boot/fdt_region.c
@@ -69,6 +69,8 @@ int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
 			include = want >= 2;
 			stop_at = offset;
 			prop = fdt_get_property_by_offset(fdt, offset, NULL);
+			if (!prop)
+				return -FDT_ERR_BADSTRUCTURE;
 			str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
 			if (!str)
 				return -FDT_ERR_BADSTRUCTURE;
@@ -271,7 +273,11 @@ int fdt_add_alias_regions(const void *fdt, struct fdt_region *region, int count,
 		int target, next;
 
 		prop = fdt_get_property_by_offset(fdt, offset, NULL);
+		if (!prop)
+			return -FDT_ERR_BADSTRUCTURE;
 		name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+		if (!name)
+			return -FDT_ERR_BADSTRUCTURE;
 		target = fdt_path_offset(fdt, name);
 		if (!region_list_contains_offset(info, fdt, target))
 			continue;
@@ -520,7 +526,11 @@ int fdt_next_region(const void *fdt,
 		case FDT_PROP:
 			stop_at = offset;
 			prop = fdt_get_property_by_offset(fdt, offset, NULL);
+			if (!prop)
+				return -FDT_ERR_BADSTRUCTURE;
 			str = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
+			if (!str)
+				return -FDT_ERR_BADSTRUCTURE;
 			val = h_include(priv, fdt, last_node, FDT_IS_PROP, str,
 					    strlen(str) + 1);
 			if (val == -1) {
-- 
2.53.0

