Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F0BC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0A582C03;
	Fri,  2 May 2025 16:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WWqdChOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1CC82B39; Fri,  2 May 2025 16:49:06 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21ACA82BCD
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85e15dc8035so74997339f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197342; x=1746802142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z11xDSsw1cVCy7/ps+uNtVfXBziZ8gFDf8wRt5Cgd7I=;
 b=WWqdChOjLYpLQsonewz46D7YtduidxQOpgiQEVpRq669knGE4s35M0la79SbHUML8v
 xrhf6dYhFkVQej8SU5/G4zyNTJL0MDrqmjMlaU4LafwGroarAEH9JfPBbaGYk5Mm7SKP
 HzcLj8P6LPxrs05zCAxHhlG1cK7jTiZt8PkWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197342; x=1746802142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z11xDSsw1cVCy7/ps+uNtVfXBziZ8gFDf8wRt5Cgd7I=;
 b=u1Zrxf7S5PLRJxSp3eqkezlsgbMYNyEWGdJGNv/8QaYgHdzzwcFSxRs4HClPcWxhrc
 dtCn5JQzJGV2Q/aiv2jLAFZ5RpLJWbatot6IHH66KyynT3m+gbBj8TOZfRFBvhhuekb8
 +vSpMI+op0a+Vdj44kEt1kWU/4a+kcaxS/WOirFEDJyuWwQaTBSKAVQfAzPUc+R6E1uG
 d2hyRbl7LYus5TuYi1toW/RgKjk4XNr47XoZz2rAtKkja3raCLKDTSt7Ly7wxwVmPkmt
 g26CwbnyH1TW3a+miZaDXrpid6q8jUMPkIvQz75k8XelhfXuFhrko0BOQ5roI9iRZVTr
 aznA==
X-Gm-Message-State: AOJu0Ywlxm0jAIki02EFC0UZqWgJ5W7cbPmmjfaMtdZznhLPx/kTipSS
 0uPBxdqaGa0NND+oMsEOn8xrvpd7WOPFrBpY3q70c3xmEbdkpET8aRYfaLdvnTb6JuNMky0dqr0
 =
X-Gm-Gg: ASbGncv8smrWJW2AE/hXk8ldq5dnbIS71hqS+iLs1gh275WcMLtZfVH0Pe3KyiurnhO
 mwoVtdpATlaN6JMEVpQsYK1+LsSxFfzgHuTRAVHfPgDhDD1gkKK45r6cS882aMZVMDUduc6Ndlz
 FxC2x3UFRUfmRZkm+t7DCVq5xIew7IPUGoAdpLuQ2rOm2wBZv0v8VMIa7Cc+StQyYJ61BMjQOP9
 cD9GeV70BFqvB1KZXN1VHul01epq/b0HyyCRAkDVw5ZxO/aJEBB3hB3cwDbrhxggl/fZVfrGUxG
 lv8GuB+l1xc1/ImhgBrrPKGI/PLF568aA4eCTmok5EwNPn1ExBgyp+nDtcxcRJfim0lvTqyBzmp
 z1A==
X-Google-Smtp-Source: AGHT+IGMaaFj/BsJu31tp7WwSZOATTy1bL5QfqEpC6ZGQ+bhItV6YPm/1rT0kHVBFZt75XlbxR8NaQ==
X-Received: by 2002:a05:6602:b84:b0:861:7d41:1042 with SMTP id
 ca18e2360f4ac-8669f9ae468mr507171139f.4.1746197342378; 
 Fri, 02 May 2025 07:49:02 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 50/60] expo: Drop the gap between groups of menu items
Date: Fri,  2 May 2025 08:46:48 -0600
Message-ID: <20250502144718.313633-51-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

The gap is intended to separate options which are on different bootdevs,
but most of the time there is only one. So drop this gap.

Keep the code around in case it becomes useful to have it in the style,
or based on some other mechanism.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 7b44b6439b6..6e2d83406f2 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -117,6 +117,9 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 	}
 
 	add_gap = priv->last_bootdev != bflow->dev;
+
+	/* disable this gap for now, since it looks a little ugly */
+	add_gap = false;
 	priv->last_bootdev = bflow->dev;
 
 	ret = expo_str(exp, "prompt", STR_POINTER, ">");
-- 
2.43.0

