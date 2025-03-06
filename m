Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAD9C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:04:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159B180E94;
	Thu,  6 Mar 2025 17:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nPF/f+GQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69FC81335; Thu,  6 Mar 2025 17:04:46 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F20E3805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85afcb0c18fso25790139f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277080; x=1741881880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPUm4wbs0iJjEsjNda6eK7pZcRyPvWAY134ccEB95kk=;
 b=nPF/f+GQ2tkBgJhn0bF8AEXF631dj05sTB8SUQRR716ad4rZsav98uzPJmB0hIh0z2
 tzTJfFt6PADR2NJJQrULNXrxAO5uwT/MCyiJIdq287qwN/xCYbBBVoNrXHz0+L1wQ7H/
 G9ToL8/S0VHjkzdDkN7Bxxa49qTqpC/+fw/Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277080; x=1741881880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPUm4wbs0iJjEsjNda6eK7pZcRyPvWAY134ccEB95kk=;
 b=KKLJWVbEdxIKJAh9xAsZ29S64z5J81wbXtRMNrAqBvh9hviDtH5oafqf7Ca2VgLOGJ
 RmfawYMsCadFew3Lmo/2hcA3vqBw+Sw6v11LwXxFJD5fICQwvzT3J63aBjN5D67n9ZZS
 nKRiS2qxLwfu69HFiw6ah58ixRtQfLSginKPAOEHQ3ST8xcaGjL+qD6NBwoe7h7mvP4+
 MZKvD8odU0qrZ2XDk897UaN0qUEeLmSw1R8ryiFPxotuZYXdPVvhejIzElGhqmQvej4X
 C8y1OVZCNsv++vW9pT2ktdVm4xZffR9FLH0kzsGWmmzvNv0YR91QPfSB7hXPKLSjuKji
 MrYw==
X-Gm-Message-State: AOJu0Ywr6xbI25/RzXf81b6dXRLO8brjuj+VZYjaN4qwVrrxRHcPdmVm
 UeAFfLA44Tuh9choj+Qjr0UYCmjWV8NM0e5xelyGtw6lvvQoq8jmUYoN2KtujKLcwbrfV8KzRAE
 =
X-Gm-Gg: ASbGncuuPUNSll8zdlmSfb0tkYcxUfmnpQU+gojQ7j8OsfvT1CfIHzRB+ijAqM+XQOz
 SzKhDG/WGKnurOVhT2+Ksupj/a7q7t/81Y78sEFVSuNh1Qmly6WMhXCTmPYy/13LQ4SPiQAFr35
 w3Gnjko0kaqIg2D0yjMYn1rX4pSmPPv2tYHtm+26I/IUqifxDVTRcThI0f0mcGGoRvqJXkUdcY/
 WS5+oqWIaiyumSeOj4PM27bUpsb9y11YnQZF1d1g9yFBE0Dlro7kSATKpVYIN3xawHXVOA5uWow
 MnLL2Y4Yeam9VubI9loGFLmUspQUJ3DCUa+B3fb2QnC2jHNcsdsUI0GRTEKYz9twHzCFgbyj25v
 KfXIG4w==
X-Google-Smtp-Source: AGHT+IHfIc/yXpV+yXiutCxC3oVwjVoxQhv/Ls8MdoOOU/hB/iZDroxxPt/BEHJGKLO13gUoBR6xnQ==
X-Received: by 2002:a05:6e02:2146:b0:3d4:3d8c:d5b4 with SMTP id
 e9e14a558f8ab-3d4419e696dmr30885ab.11.1741277080408; 
 Thu, 06 Mar 2025 08:04:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 01/47] boot: Correct ramdisk address
Date: Thu,  6 Mar 2025 09:03:28 -0700
Message-ID: <20250306160428.3041057-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

We must use the ramdisk address for the initrd_addr field, not the kernel
address. Fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: e05cda3004f ("boot: pxe: Refactor label_run_boot() to avoid")
---

(no changes since v1)

 boot/pxe_utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 16608c6ebc8..d827b1135bb 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -601,7 +601,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 
 	if (initrd_addr_str) {
 		bmi.conf_ramdisk = initrd_str;
-		bootm_x86_set(&bmi, initrd_addr, hextoul(kernel_addr, NULL));
+		bootm_x86_set(&bmi, initrd_addr,
+			      hextoul(initrd_addr_str, NULL));
 		bootm_x86_set(&bmi, initrd_size,
 			      hextoul(initrd_filesize, NULL));
 	}
-- 
2.43.0

