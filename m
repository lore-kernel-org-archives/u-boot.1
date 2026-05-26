Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B318DCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9BD847C4;
	Tue, 26 May 2026 14:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="V0IqD0VT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 723F38404D; Tue, 26 May 2026 12:48:04 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FB283EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 12:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50e5c7eb565so112344001cf.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779792481; x=1780397281; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOPACokKaxqeT1Z0aXVSf4w75LZfp6AaVZccQ/FXsJw=;
 b=V0IqD0VTe5cTpTbQm8eCCeOLa+MWprZX4pT9JjogDGvq3pqc3o2ognvKGZEW+91ZZ9
 IIpq5d3Fr3OxAwUTGqamy7eCldlntwD+6GrpP45FuBocFBR7OaFrHytCbOVAApha43f6
 zNGQURp4T+3TMZ9r2iQszFGWNRrqZ5IDsWFRui4b2AryNjK0SW+3CjaIBEZc4766ZQ7W
 g5kiF2CGZCDhsQlU7+FFa6SWWgxqfMIoEj8GRmJLwDzMWjNvqk8caabJA+wOAVhGMRnB
 +WriU+UuYJ2GNip91/YELo7WLrEyWgnEhHKmOhueGQcwlxwiUlZqVjaa9AwpkmxEz9yk
 eSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779792481; x=1780397281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bOPACokKaxqeT1Z0aXVSf4w75LZfp6AaVZccQ/FXsJw=;
 b=oMw8Ng5XC5I1+3I7ixGQg/1O4MdRJqf4eQcHkSOtQhqcvVCrzy4AUxOaiM2ffXPVuD
 i4F7psdjxDw39Brnmhu0LKzxA99gbE1rmKiUdN1VDK0pmYJz6C3L4a2BaEI5OS+XP+eH
 Oe+NIndyHkQ8HG6CgfHBfmgB0CndgihKSngW7w7rJrJLWC7BeI3BSjAyYeQE0ur8glA2
 P1e15HJaeV6v/eeO6P5TVlyNorLxSyOMMfbGI/f8FB3vb2e7M/OMP7Z01bHPaada/fTs
 nO5IB3IlxNP/c3UOsN3e7kQVdgJ2ATQvHat7rQ24qSszDCqE9IyyPO2+lhK6JeAKg2Q2
 jSoQ==
X-Gm-Message-State: AOJu0Yzo0QkNy3AB+p0MxyaIxcTVpx+V8bHL7jlGGjwamgkFHV0Mynyx
 6BZXSkzwgmFRwWVx+st7GpL4AG/NZDwnZS9np7QbaMN0EqsDSNtYkcZ40nIk50pB+zAaLwc2mu3
 bEWINeE8=
X-Gm-Gg: Acq92OEHyzb1WE2/0te3AeX6JU0SWxaCiBh/5DpVuE7yzlAI22DW/SyAVsKiqi7R38Q
 ycU7ohPf1giESBb+fI5Y0kAptSBxbiZsJasNssKA1cQk/H0QkaCWHWNr6uO/RVB4vpijavOPsZg
 L7mt8FELPMeOB2ADHQXV2aKoNRvWpZsXsPc+n0u+z4dhkVmsdCz5f1kGeZNyvdCwwPkoKh11OQJ
 MF5XPaEokW0uoliS9iZY+e2xYG2DXr50ZV07+WpzqP2vP9KjuIBQQ5Zomb8srq5+AqInBCoGRbS
 ok4p5hVLagaH8QvpVhXeK/e+WxAEt+7w4hcfL43Y0VEwBUEpRlP8YgtRb0Rlohf5qL/piax39+P
 tC+gsbbwdukBYklQadmDoolzcmgYQAjvh908pJPutTceE47DqGQeOz7PLR1j1UIK0/m+gBoOMa/
 b6Q15xy0/db8uYCgTyW/Uv8phzj2ZJ0UWIT4Os5f2+ISwqzw==
X-Received: by 2002:a05:622a:1a8c:b0:516:dc6d:acd0 with SMTP id
 d75a77b69052e-516dc6db837mr211822111cf.29.1779792480612; 
 Tue, 26 May 2026 03:48:00 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc355d25bsm477305866b.27.2026.05.26.03.47.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 03:47:59 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH v2] fdt: Check return value of fdt_get_name() calls
Date: Tue, 26 May 2026 11:47:44 +0100
Message-ID: <20260526104744.33248-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522183228.GZ1858239@bill-the-cat>
References: <20260522183228.GZ1858239@bill-the-cat>
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

fdt_get_name() can return NULL and set len to a negative error code.
fdt_find_regions() does not check for this, leading to a potential NULL
pointer dereference and a buffer out-of-bounds write. fdt_next_region(),
fdt_check_full(), and display_fdt_by_regions() also lack validation.

Add NULL checks and propagate the error code from fdt_get_name()
to the caller.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
Changes in v2:
- Rewrite commit message to be concise per maintainer feedback
- Don't mask fdt_get_name() returned error

 boot/fdt_region.c           | 5 +++++
 scripts/dtc/libfdt/fdt_ro.c | 3 +++
 tools/fdtgrep.c             | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/boot/fdt_region.c b/boot/fdt_region.c
index 295ea08ac91..f0f2568955c 100644
--- a/boot/fdt_region.c
+++ b/boot/fdt_region.c
@@ -86,6 +86,8 @@ int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
 			if (depth == FDT_MAX_DEPTH)
 				return -FDT_ERR_BADSTRUCTURE;
 			name = fdt_get_name(fdt, offset, &len);
+			if (!name)
+				return len;
 
 			/* The root node must have an empty name */
 			if (!depth && *name)
@@ -553,6 +555,9 @@ int fdt_next_region(const void *fdt,
 			if (p.depth == FDT_MAX_DEPTH)
 				return -FDT_ERR_BADSTRUCTURE;
 			name = fdt_get_name(fdt, offset, &len);
+			if (!name)
+				return len;
+
 			if (p.end - path + 2 + len >= path_len)
 				return -FDT_ERR_NOSPACE;
 
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 3e7e26b4398..d7b424c658f 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -940,6 +940,9 @@ int fdt_check_full(const void *fdt, size_t bufsize)
 				int len;
 
 				name = fdt_get_name(fdt, offset, &len);
+				if (!name)
+					return len;
+
 				if (*name || len)
 					return -FDT_ERR_BADLAYOUT;
 			}
diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index b4c041070f5..dba7240001f 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -355,6 +355,9 @@ static int display_fdt_by_regions(struct display_info *disp, const void *blob,
 
 		case FDT_BEGIN_NODE:
 			name = fdt_get_name(blob, offset, &len);
+			if (!name)
+				return len;
+
 			fprintf(f, "%*s%s {", depth++ * shift, "",
 				*name ? name : "/");
 			break;
-- 
2.53.0

