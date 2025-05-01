Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6ADC3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4038E820EB;
	Thu,  1 May 2025 15:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P/ancVRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23B98272A; Thu,  1 May 2025 15:37:48 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89848809D4
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d7f111e9e1so11255525ab.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106665; x=1746711465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2YZ1YnVRJTZAdCt9gzuf5dknvWoMKJbUJgxYj1cJks=;
 b=P/ancVRbZd3GCY/qhI1WGztQONDxAKFTx4bRW2L2LYRNaE28vgYnVdE/hMcp9QTFQ3
 mMcjfG4kr4LGNvms/8EOcSjsJ1tv5PUlMd+WuoZAYn+yYUFB5qqaaQyc+gabr+h1+H7Z
 CU6lMfrVofoKTyMCp82SpArROyVuRFbGxEFYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106665; x=1746711465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2YZ1YnVRJTZAdCt9gzuf5dknvWoMKJbUJgxYj1cJks=;
 b=GgQYo3/1Loh7KCBlR2hVlmRd6ydGoNRkRULFwoo3hd197HYQA20vWtNkmKEWI3KO/M
 hsrSylOEG8UwVdn3xGdp4tJY1Kqbcm8TQhKEdKVusOVP6yDJfcXGhKlCEde+Dv4BaxIF
 bY1q9M9TNE8l1bye+xx0av8UwNKmwVmVt7kN3KXmGw7PMsuWT9uHdWm7U1UryfBHMCa7
 pGeSs/Pjk/W9QIyLZuP9rnzLgUdl5LpEbgwzqjWxmOvJATGLd61p6ddwrZKaepWybJKH
 Ud4ofB01cvkgIvRLgkARsh+40qvZSmtS7Yqm6BOP5p9X896s95duwU5/nmINiMtLL6Z3
 QALw==
X-Gm-Message-State: AOJu0YyNjLJUrnyKpi4Mu53zdaUXqHF4M2PLE6gWIQGpzS5RaWaU4Dx5
 GiRnkr1AGaz5IEHFqngwsxQ1U2+Qg/iNZsbrOKpFNgrypF1gCOwxdaruf+UempYn76pEzC5ah9c
 =
X-Gm-Gg: ASbGnctVhiyrVXQjys1v9N43yH9ufa4UledlzZoVTlYVFoo51PAVL+QMILVLH1M8YoY
 5tFY+kT+YcN91gcKRIfRMQUrU0cUaaEcNPXq3I+y2IaUoHfK6Q6DyHtujMlQ6fpA15XkN5SudZw
 +0HrZs4S/ibnJqXkI8oMDewR38mO2ZyQTpbrmQWUFkflMqDcy42tPMslGJOrFa6rxWkqvjkLCy0
 y3vQ/ccTUoxvOzATLU2MtSS7ySuD29CN3bWFHat9VBaMxD3dveJhLh61jLYENW1UkMem/CPwHUN
 icsWd7irtGihdwx5KrsN1aP2mW/Rs89mlqJMTU08GOLlzlbfwfm2mxx+Bf0DknOeHudER++b2vn
 7hg==
X-Google-Smtp-Source: AGHT+IHpPA0Vfv2CTuyUbxduzOzfMTNIRxcOyvNpCd+eCgVjRE37XUVEgMhyY1mmIsCaZx4vFMtTPg==
X-Received: by 2002:a05:6e02:184e:b0:3d4:6ff4:2608 with SMTP id
 e9e14a558f8ab-3d9701e46d0mr35260315ab.12.1746106664730; 
 Thu, 01 May 2025 06:37:44 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/18] bootstd: Fully complete iteration of a uclass
Date: Thu,  1 May 2025 07:37:08 -0600
Message-ID: <20250501133726.2627373-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

When trying all bootdevs in a uclass, the method flags are not preserved
in the iterator.

This has no impact on the first bootdev, since that is the one which
sets the flags. For the next one, iter_inc() is used and it finds the
next bootdev. However it sets the method_flags to 0

The result is that the third scan is conducted without the required
BOOTFLOW_METHF_SINGLE_UCLASS flag, so iteration procees to the next
label. This can miss bootdevs if there three or more USB-storage
devices, for example.

Fix this by keeping the method flags around in this case.

This patch is not quite a bug fix, but a further refinement on top of
this commit:

  7a790f018a8 ("bootstd: Scan all bootdevs in a boot_targets entry (take 2)")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 345dd993c14..76dadb93be1 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -288,7 +288,8 @@ static int iter_incr(struct bootflow_iter *iter)
 				 * bootdev_find_by_label() where this flag is
 				 * set up
 				 */
-				if (iter->method_flags &
+				method_flags = iter->method_flags;
+				if (method_flags &
 				    BOOTFLOW_METHF_SINGLE_UCLASS) {
 					scan_next_in_uclass(&dev);
 					log_debug("looking for next device %s: %s\n",
-- 
2.43.0

