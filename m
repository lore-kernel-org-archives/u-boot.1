Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDD5C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D25A480BA9;
	Sun,  9 Feb 2025 03:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XU3mFsm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1984807D7; Sun,  9 Feb 2025 03:02:32 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FE080A35
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844ee166150so83872139f.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066541; x=1739671341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cfnl4x9ZQu7LnoT3iQSqV04RWnOIGHU6v9wf600TAKo=;
 b=XU3mFsm2FNxNLPLxRvLuaioxaQQvMJYCi4/A68qL9oQc0t22Ytw5pmDW+n5N+8yNJ+
 gP2yNip/cHMPrYjgcJYpFEvpFcTjszxUtTPH35LYatvuyaUuzSfebr9jIIANEI/h9giS
 eMbB8bQ1eeUnxDEOB4Cc7DFqNOL4NVFfpZhhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066541; x=1739671341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cfnl4x9ZQu7LnoT3iQSqV04RWnOIGHU6v9wf600TAKo=;
 b=jInXE1YBmSSwe1Xu3MU5V47jCuH+El9tNSV2SVmDBLTczxUZ90sfQCUlVZ4jEBsd0U
 VFxbacbSG2lDl8dNkWsxheju8XvuzjSb9Av98e0j0nYWrsyYAsrIxLqxZCXTlOVOkr/o
 azv/DsqGfg15T09kVP0/ZSQPt/29JUh/cVOqKzurvg/CfzMowzD0xFgJQvWXROo1T8D0
 8WiBdh+FxCLXW7P+FYo5+3IQSCLE0j7RGSlosL2nRg1/ewaT7SbYho6MhG1ndS64aEPB
 lxc5wjO26gS3zfhs33bRGrOOKyD8TIk+fq+XNV+cwXCeTvpLFW/dxHh2jG/yeXD5IWNB
 bviw==
X-Gm-Message-State: AOJu0YwVE5H5UY+Gx1e2k4VsddlM/e9ZYIkydwukCbiinzdVyelCO8tD
 /IVlk9EKpvCM00DHsC81JSfpsCi/Wzy2tFmbc6Mcu0wpQdvypYb4nCTjbAVbCe06sIHUYc8jWZ4
 =
X-Gm-Gg: ASbGncu4rgrvPTRcGzOCg3RWyk94tAcRIlt3JdGjP/iOFcqmxO8mMirR750xB4Xgd8O
 /o7EE43gNGVr6ql5WjnE2x+IJ5OuzvWhAddaZsIawQ2jiETzQeHaLeNrF3t0l8cPRX51PUfzjux
 CxH7J7n6IuhKixciBGkoiNKttVWI6X045pvbmP15JUutghtzmFTiCBn5h7/3iOBBfi3eOpNOE3B
 vbDdbclnj5bmBUxphH1MuwbtSPvqHs1OCCbiSVXSYIQPygjSXBMTg2Zw5h6c57NMpAfP6Glo5UD
 hsWqeznVtnkFpFM7CvaIXloqNnBDsAegiAW3/imLR9hXtyB+6Htj
X-Google-Smtp-Source: AGHT+IF2hpaB5KN/zHZpq7bWKyI5vNttJY7gG7gmsNf7rZsAwxGYscPliNTOrSZJgO35hSmuHyixSQ==
X-Received: by 2002:a05:6602:6cc8:b0:843:e908:db0b with SMTP id
 ca18e2360f4ac-854fd8f3f76mr668252939f.10.1739066541576; 
 Sat, 08 Feb 2025 18:02:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/29] efi: arm: Don't do the EL2 switch when running under
 EFI
Date: Sat,  8 Feb 2025 19:01:13 -0700
Message-ID: <20250209020136.4108987-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The previous bootloader has likely done this already, so avoid trying to
do it again. This fixes a crash in QEMU when booting from EDK2

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/bootm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 974cbfe8400..688c2f3f29b 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -16,6 +16,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <init.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <dm/root.h>
@@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params) {}
 #ifdef CONFIG_ARM64
 static void do_nonsec_virt_switch(void)
 {
-	smp_kick_all_cpus();
-	dcache_disable();	/* flush cache before swtiching to EL2 */
+	if (ll_boot_init()) {
+		smp_kick_all_cpus();
+		dcache_disable();	/* flush cache before swtiching to EL2 */
+	}
 }
 #endif
 
-- 
2.43.0

