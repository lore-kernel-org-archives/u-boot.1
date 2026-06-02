Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4BBCD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB3F84837;
	Wed,  3 Jun 2026 02:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="hlKkhzqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7E778485F; Tue,  2 Jun 2026 20:28:32 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7675784852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 20:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-516de78c4dcso108871101cf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780424909; x=1781029709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9OQz41NSltluYuS4Ljz0TpAJYDJTRLfda2b1t6DkqA=;
 b=hlKkhzqxKFTPd4MnYu0LFzAPlDcV+8QzX3Ev1C4dNjSzYxmhcn3MNseqFnv+W7Opmv
 AQ8uf2Eumi1om8ce6W05g30yyK1X5DlIm92CMqFIOweL3dF9CAZ1C6ymcjTykjH/lyAx
 hw0mAlnQa5XZhVl7dePf7KcGsoNK4kGUeZdJyEird/CsME5Zx9lnEfg0ObB5zcdJMzJz
 BQvBr8XtkNkGvrouXnCypVX9r+Q9qJXns+GO2+ZB8yKBBTyu8S0+vN+FAL9cuSIUF3cz
 Fb8VKWSMesjKNVcb8YjF9HPcRYT13UGWDM4XSwPjqcOBsCX4I4Egab9YzPfJG0XPX5Lh
 aAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780424909; x=1781029709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y9OQz41NSltluYuS4Ljz0TpAJYDJTRLfda2b1t6DkqA=;
 b=mUni4cwlWbJCnSEJ0mXicaf/jFXYr95FoM/+lS88jr7n/uvhj5f//BQ7ibks+Qkt37
 jYaQh3354+7HQilMbSd4wNGiwakoYdwOqPg5GLX1m/5rKjeeqZgABDZbgTlLjFlRmp0U
 KAgsLtiHztJ1M1yXryKRZl3FYZitMDCe6ilmxi1K9f3lglQNbqJfdGOpA/nUk06tTepp
 n17HbQMVFysyy+sh0A8AikMMjuvwaFOSfdSGfsUeb+KKRjXyF2h/BCJ+4kt8c9J/7+EW
 sekwwug4qRNwR3+rA4dirhyIkHGBSHKh5KAMO7KDVWrVVh+OVC5SS0YEZYQgvMW4hrEw
 rfDw==
X-Gm-Message-State: AOJu0YzUpDYsu76YRlVUhhl08CiFefqqAzDaJGrZVy8AtIlIuJWcowiH
 Qnt0C41jMHNeh/z0/ksavnBCEO3rMkBBcLjCNiGqYCG6wGRBzSX8mT56CMdevLjdQeVsH3WrmR+
 2R5ZNp7kxhA==
X-Gm-Gg: Acq92OGBeVR9ZzlniTWmvf2Rh3UXJLjPVcA7anaPKrHkU4mcuT5kSNtgae9hLnB29nK
 MOowrH2I3Vhp7pNouOmAdcY/Nl4Oy6AWEVTXnVDdmSMc1YbR8c4LtaulfTP0Es+PW3NOrgRx55V
 /ADk71UN201jt6aJal+VoQS4la1c9wjpPdwo1cg2+1xnGkcpGfVLrE0BggKQR07Y5aJFKXZmsu3
 EjtciLgebam+mPJU1JwGnmdl7xa9iL6Re55f0MhmkEGliVrTxOp8h9pg7n7PSMFqu9W8nVRyJrf
 wdnHRuheiVy6WfOXk29ib8RBulRit7DAxY9yAw1+xbNl2o3IybftLQEzXUNHEpszbRL+RSZNGZP
 aFcONCjaafyebxMc7fF9joMP8dFgjTHkwoBws2afwU3GMTaK4MZwNaoOcXWa+P0ZAjNV3SLa+FM
 fbAxNemqGEk8VmD4KMCnRL26aQD7xYNUSBBe/3ixglpYTBwSfG8q5oP9n/
X-Received: by 2002:a05:622a:618c:b0:516:d943:175f with SMTP id
 d75a77b69052e-5177878697bmr2950461cf.52.1780424909157; 
 Tue, 02 Jun 2026 11:28:29 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05176fd07sm27029566b.1.2026.06.02.11.28.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jun 2026 11:28:28 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v4] fdt: Check return value of fdt_get_name() calls
Date: Tue,  2 Jun 2026 19:27:52 +0100
Message-ID: <20260602182752.59282-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260527111553.82161-1-anton@binarly.io>
References: <20260527111553.82161-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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

fdt_get_name() can return NULL and set len to a negative error code.
fdt_find_regions() does not check for this, leading to a potential NULL
pointer dereference and a buffer out-of-bounds write during signature
verification of an untrusted FIT. fdt_next_region(), fdt_check_full(),
and display_fdt_by_regions() also lack validation.

Add NULL checks and propagate the error code from fdt_get_name()
to the caller.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v4:
- Clarify vulnerability reachability in the commit message

Changes in v3:
- Update From and Signed-off-by to personal email

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

