Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EC0C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C954480812;
	Fri,  7 Feb 2025 19:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kvvLtIfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EE38083C; Fri,  7 Feb 2025 19:31:34 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A0880141
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-852050432a8so71308839f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953090; x=1739557890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAaNkHa0Vlo1nBAvqre3APEmTbO5RCUt3y8gWHtIqKk=;
 b=kvvLtIfwbcO8tSQNovmbcJlJZpBCYd0ouHZviPt3QFIKUnGOiNbUmKCVO/3doXsDs2
 XF6I8zzx6pEtWNVJ4ySP14uKF4GFGOhkpzuaXmfrU1BpdCqFzabUPpi3GwFZXBVmcugE
 IEDNgSmPJWGe4wjQ1p8dldoIMhkk/IRITzAMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953090; x=1739557890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAaNkHa0Vlo1nBAvqre3APEmTbO5RCUt3y8gWHtIqKk=;
 b=vbPpiqPViqvHuP3YqdgPZFhDjawTPcmpatFYYrJZ/4Es8X5QqXcRMxmxUsYLgx/utj
 G2XbEbjHDvsBmZ34XpI7ut+VTOB91f3S5E4fEf5NiGNRpI1vGl247Xy5KAxGLucASU5v
 4H7pHCj8TISi4y6DEKCg02Q+HWOy7HOixXzxIH9Dl48ARIz96/VJGW0ADDUr7SysE0o5
 Pvh2opXGK8upKXFyMZkIOb/boTr7F+cvoUdzjrgqJ0JmMNFxfWBPHnc8e9t7kyikQJUI
 XF6ic1IJpo5ssP8S0ZYtyi3QVcFgy1DT4Pm/Qm9UWRAl5A9kr2eWiOnXjYBPRe+Ztmlg
 vkAg==
X-Gm-Message-State: AOJu0YwdBXJgp0VVW9tbmepNEWqkjVSk/am7XPs6a+ScvnDqCyxO6bFH
 lvWVapHEiczYpIOZ91LWlkedksYXi/2AkeohpofULpieIlL68vjEk0bWIgdzRGbDbnQXTjL2HWM
 =
X-Gm-Gg: ASbGncvfCbevyJfW3OzoaUMW3zaQrEzncojhklRCwVMIGG1JCopgWGaSKik3PFsYoJx
 lplAl45C40+93ESn15GscmovVcNkdl95xTrv4KL77xnoDAwEkeOXrSeKRrf/5GES6mlRbQcnpIu
 EOD2qSLL55Zp3DVkZASNKp3DeEajrXriGWV2ytU68mtA5mT5/votHgifULD+5JwL3zXnAQ5J3x8
 QMWa2ZSbE3IaiZkBr/MLPeOoCIVrP4aSyd5yX4aS3BWQb2tn+va3/A/Vx3b569jbecEP0h9QaYm
 E0zs8MA5yOJXRzI7u9xJBmgeG6OFcirlzjx43sLlAz3Gl5j4Q4c8
X-Google-Smtp-Source: AGHT+IHXLYe6Rmv5QCKuO1aCY3o2iroKraua2LnzgjUZAFENlXGk/9uXjlI5Vy3RcddK/2FZzvw1Hg==
X-Received: by 2002:a05:6602:6e0b:b0:83a:943d:a280 with SMTP id
 ca18e2360f4ac-854f39a7567mr615214039f.1.1738953090464; 
 Fri, 07 Feb 2025 10:31:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/29] test: Fix a stray asterisk in ut_run_list()
Date: Fri,  7 Feb 2025 11:30:33 -0700
Message-ID: <20250207183121.117663-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Drop the unwanted asterisk in the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/test-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-main.c b/test/test-main.c
index 22b9b46d9cd..815f54bebd5 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -701,7 +701,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 		has_dm_tests = true;
 		/*
 		 * If we have no device tree, or it only has a root node, then
-		 * these * tests clearly aren't going to work...
+		 * these tests clearly aren't going to work...
 		 */
 		if (!gd->fdt_blob || fdt_next_node(gd->fdt_blob, 0, NULL) < 0) {
 			puts("Please run with test device tree:\n"
-- 
2.43.0

