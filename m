Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A4FCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:41:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E07F78484F;
	Tue, 26 May 2026 14:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="Y65oY4Si";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7721D83EF9; Tue, 26 May 2026 12:54:59 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC7080433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 12:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-9144163319fso1082227685a.2
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779792896; x=1780397696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOwNLtZTEtTJx3/uoyiUFwq0SaZlHOUgSZeA9hsiiCE=;
 b=Y65oY4Si3lyd+Ii7H6DTL+JNOHd9XI/7JBV2/bakMf8lJdeJSivAyFV//efLDwa2mB
 7BS/xAT8qTXqKWNxhspL+UDIQDovE41heNX7nyN3Zrk6Hg3qD+BNNxFIJuM+qpQMNycT
 5JHlxelP6e9MjLzlue1MxXIjWHqbaDRi8Pfx/thRcoMTahqOBevx0ndG5XGvWJGQnDec
 HmdDL1M/jqm77WZOt4bGf0Szm7qQyCs7InlWn8MrCAUhP0eWN0ZcjPzs63JbSLHp5btl
 74RePbO9nB8DkBrVTg10FoeGw7/MDKpMgQWOKl0tLtpA7zbZI6qNCLp+R+xZFA9yqTpd
 STzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792896; x=1780397696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dOwNLtZTEtTJx3/uoyiUFwq0SaZlHOUgSZeA9hsiiCE=;
 b=kbzBXqE7IC92DixcVXbAILeYJKa8S5DnZx/H0u+UwT8QunAtl1LDG7KMLRPffzg+xF
 Xqojku2SfbhFfyjJkpuVeIgd9bdkG29lQafxGsRlHFdNR9Wpp+Z51+Z2ZhXFGt+/O/QG
 4bWQ8G2olko5ooe30d0D3lf19+InsHm7xL9YlHTCs2QDa1mVPp5D7ees9TeyCeIR9Nsy
 72xudtW66Hq8Jqap5WhO//LMl2a6RXBmbJUSzx7jByMj0oWkGBNATs8di0WHrDTabCY7
 uZ2UvzHfwOGLtCuZMDUY2W0wWxw+w1FQP510IAPNQewYwSO5wptJKCKJJd+1IsI9GCPw
 f9oQ==
X-Gm-Message-State: AOJu0Yy2sm8NFwS9CA6ZIPzeXyvtdOah+8NMrWl5weH/kKMeMNPMChyN
 fW8dvczjNuDl9To2J0Vi1ClfBwWeIvjRUp80DA9DRgFPrbO5uGWBFgnnFM0JxslAARECPs1Aar4
 7SytRIMU=
X-Gm-Gg: Acq92OGIP9kcWy7LqAOmUu1x/x3BN/Ajw/4KSDIdyfDEStMt88ZmOGd55mc1D/cRmsm
 AHdFxNv9lVzY4rn20gYQqqQzhHHkAZLrYmWv7atmNFvRgHosDGA5+i+E6R7uHKIyRNyXhqxqgqN
 UrUCpqVwlDn6gB40aEz3lS2LUg/D7CPInRSWfdh42oNbu12cZp9EDQ+Jm2hlWwQ8Nz5BqtDCwCG
 rfWebrD/ruqjVcMwtbiGQCXbvWgEy4vwkDPjM6VAwgyW7t+duH105ZmslGR0j5l9cKQqhZdCz0m
 HdNCg4xFm3Yx1rrpzbn9Tdz7R+SU2X2sOOtVJgz8/IJQgMa9Tw1aGp3xB4P3gZLvv+Xy8ZUQ+PK
 NjkF2EipKn29q2e5n3VJo2UMOLfphUr5I8Yp/ARzsrEf8hQgNPS37wp8IKQ29iorJYyaOXoIvRB
 dAecpQ7LtF/g2vNYMXyQYK6I7aZVQHyWq7cRNwzXo471TzELLn9Ud8FnPP
X-Received: by 2002:a05:622a:5c91:b0:516:f4ef:5c8 with SMTP id
 d75a77b69052e-516f4ef08d9mr102876251cf.21.1779792896043; 
 Tue, 26 May 2026 03:54:56 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc355d4fesm477492166b.26.2026.05.26.03.54.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 03:54:54 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH v2] fdt_region: Check return value of
 fdt_get_property_by_offset() calls
Date: Tue, 26 May 2026 11:54:49 +0100
Message-ID: <20260526105449.48631-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-3-anton@binarly.io>
References: <20260522123024.6292-3-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 14:40:44 +0200
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

fdt_get_property_by_offset() returns NULL for FDT with version
less than 0x10. Callers in fdt_find_regions(),
fdt_add_alias_regions(), and fdt_next_region() dereference the
result without checking, leading to a NULL pointer dereference.

Add NULL checks before accessing the returned property pointer.
Also add a missing NULL check for fdt_string() in
fdt_add_alias_regions() and fdt_next_region().

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

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

