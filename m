Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18472CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 21:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA0387FF2;
	Sun, 31 Mar 2024 23:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g3fDSdnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0989087F74; Sun, 31 Mar 2024 22:03:42 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 307DC87C82
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugeneuriev@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-515c198e835so3845826e87.3
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711915419; x=1712520219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gi/NBORItLLjd1uawMUB02FO6QSi/DEwP+jrSTxEsqI=;
 b=g3fDSdnfK5gsquAdOJGLaI4R4JvN5NCqcuegB+mqSCOEIH/WBjXgjcNSaFeZxyKyhi
 5fQUZBhVzTwp+vSj64zMUCtSOmgfrNlMbgqX24W/voxzbeXHnO4D1w5876ZUENpwiWui
 fFjq3VMFF15atMvFPqQDlYaLDySPu9ww4NAkPOdOtdDn8mlNanvWpPATHaZ8hWjDS9oi
 W1qYHaiPdiCGXyzhDm9Vp24k0K9/cR+isg3m/JSXW+eaGjOvprKgw9yUdDpnsUlDE8Fl
 2x901lrUd0W64wwH7KM8rwsRuugBZg1dbJ4/rxwKC2qJq70VVuvq6XnBoQiGPgMc3Moq
 UWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711915419; x=1712520219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gi/NBORItLLjd1uawMUB02FO6QSi/DEwP+jrSTxEsqI=;
 b=QA1HbDpiRgZHrIF+hLKoC7NqgrCLluBQmBLMSSyCkZ8NZwO28Vxn5h5Gl40nbibhXY
 Me4F5jPekJON8PHVIQ0r+EwmbuwmPGci0b11PKG1r0R+b7siLfn3z/InkigwM5V+IBen
 iXCo368AcdvB5ucP7WedZLrFDdYZmPZVrFnDjpYXNu11gggOMnssgOTJNkGOb6DYzNqX
 N3XgtZbjSvddhBD+We+aKlpspu8jpTgOX7NWXIh6Ylr6AHJ4iA0sCjMJYNANsCQRmyDi
 RtvJdijeG5cvh2Ja5IjDM9Jgx+xbmQO5E+gSQNGnt8Fa0ersI8FmhXEIohcVDOJ4CGZy
 ncdQ==
X-Gm-Message-State: AOJu0Yyoy3y756jB7+ERXJvdR/kedOE9iKOmXtjo69JK53r65qWGlLPf
 i8aRzFKcGJlb8H5MLjIFPtD8zVMxIEz3pKRBVgXFGSkGLVQIJilI
X-Google-Smtp-Source: AGHT+IEiNARPz25puFTFbMkiTFyohVyZ32SvJwNZPj0WnwILsEu4g6/JfaCgENv19px0QyAt2dVaUA==
X-Received: by 2002:a05:6512:475:b0:515:cf44:904e with SMTP id
 x21-20020a056512047500b00515cf44904emr5123338lfd.46.1711915419498; 
 Sun, 31 Mar 2024 13:03:39 -0700 (PDT)
Received: from BlackProtonRN.clients.gtk.su ([185.16.100.35])
 by smtp.gmail.com with ESMTPSA id
 l5-20020ac25545000000b00516a08ce8f8sm425000lfk.269.2024.03.31.13.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 13:03:38 -0700 (PDT)
From: Eugene Uriev <eugeneuriev@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Eugene Uriev <eugeneuriev@gmail.com>
Subject: [PATCH 7/9] mcheck: introduce mcheck_on_ramrelocation(.)
Date: Sun, 31 Mar 2024 23:03:25 +0300
Message-Id: <20240331200327.29141-8-eugeneuriev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240331200327.29141-1-eugeneuriev@gmail.com>
References: <20240331200327.29141-1-eugeneuriev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 Mar 2024 23:00:15 +0200
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

The using of pre-reloc/malloc_simple heap is
too hard to follow after the relocation.

So lets drop it from the pedantic registry
and switch to dlmalloc, when moved.

The offset is ignored, but kept in the API
for the probable case, when that early
heap is relocated too.

Signed-off-by: Eugene Uriev <eugeneuriev@gmail.com>
---

 common/board_f.c         |  4 ++++
 common/mcheck_core.inc.h | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/common/board_f.c b/common/board_f.c
index 442b8349d0..ca4d5291a9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -719,6 +719,7 @@ static int reloc_bloblist(void)
 	return 0;
 }
 
+void mcheck_on_ramrelocation(size_t offset);
 static int setup_reloc(void)
 {
 	if (!(gd->flags & GD_FLG_SKIP_RELOC)) {
@@ -744,6 +745,9 @@ static int setup_reloc(void)
 	if (gd->flags & GD_FLG_SKIP_RELOC) {
 		debug("Skipping relocation due to flag\n");
 	} else {
+#ifdef MCHECK_HEAP_PROTECTION
+		mcheck_on_ramrelocation(gd->reloc_off);
+#endif
 		debug("Relocation Offset is: %08lx\n", gd->reloc_off);
 		debug("Relocating to %08lx, new gd at %08lx, sp at %08lx\n",
 		      gd->relocaddr, (ulong)map_to_sysmem(gd->new_gd),
diff --git a/common/mcheck_core.inc.h b/common/mcheck_core.inc.h
index 85a34de295..bade03598f 100644
--- a/common/mcheck_core.inc.h
+++ b/common/mcheck_core.inc.h
@@ -273,5 +273,16 @@ static void mcheck_initialize(mcheck_abortfunc_t new_func, char pedantic_flag)
 	mcheck_pedantic_flag = pedantic_flag;
 }
 
+void mcheck_on_ramrelocation(size_t offset)
+{
+	char *p;
+	int i;
+	// Simple, but inaccurate strategy: drop the pre-reloc heap
+	for (i = 0; i < REGISTRY_SZ; ++i)
+		if ((p = mcheck_registry[i]) != NULL ) {
+			printf("mcheck, WRN: forgetting %p chunk\n", p);
+			mcheck_registry[i] = 0;
+		}
+}
 #endif
 #endif
-- 
2.25.1

