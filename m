Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A853CCD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25D5846E2;
	Wed, 27 May 2026 14:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="NvcpfPxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14F258341A; Wed, 27 May 2026 13:23:47 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A02803C6
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-50faeb8317bso105311051cf.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779881024; x=1780485824; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MIOpOWxCDbbpHpOC3/h9I8ip2913LmgcY6CDLZPoSw=;
 b=NvcpfPxqXRy7T6B0CoXgCpiE8TQN2vrPSo/7iVm3pxNUid32P0gAHaIyw3RVSMD9Vl
 bYoFxrdmYQJBTKOltaj93jn6XGyTMLEnHvGSXhSehiQiOz8xuURKrsnGIH2jU4zvU8sz
 +58PmaHuDFVT94pp/jtmmXy5Sx9gJYBFCzQex8qS9tA8EOdZpA8myVIfx8+m8S+10m1j
 DGTx/xcxTdxzUv34AFdyAxfx61pMI7nDDOXdXngv8aiKIZR6YASsxt0M7wro8T8/B2Y1
 CCsjRSfcVxyU+JTmbmvIFHdMFglLfG71M8L/vOUzKW+sbJief6hQ0hQH9SQCrM8zso7D
 +cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779881024; x=1780485824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MIOpOWxCDbbpHpOC3/h9I8ip2913LmgcY6CDLZPoSw=;
 b=osx4c860wMq+3vPMpNeVYltffac57OGyLQgpns59Fq2Xm9kAbTVGIFtqV7KCBxUGbt
 nQN7BfB1Cr2iYjTL5QFY910dLkuig70iXCZGYIl5KGYvyBZUiLBL0R55QE8BF6AzG1P+
 L1vZSA/07BjXDt4Y5cJ2wR0rBYqAfEC+kCow0lNo7gSXq7nSG/FOWJUpJ3uestkPapnS
 tCy4cjo97Y+JgKNrbTTBG48s6KhE7ptFwT7Pk/TO7DxEjzYhob0W5Xl3G64uPppkX0dO
 RRgT0menZtP++fXgpmhSmJ+r6VXUXGjLD8JhCAIt9733erLe6gUUaTJeQpdwkWD1jwQb
 d+VA==
X-Gm-Message-State: AOJu0YxyIFUBSgAGGFrzeDNVwb44RnSb+1UHKz6tzlMtFfTZiGE6mLyq
 GIIfxVOCtExW5W8GpYY/vtquuzNzUOabBlC91tJXfspIHTJXk9PwfqpaosL+/WVkn0LVK5nypCB
 ggZIFo96zDA==
X-Gm-Gg: Acq92OGWaUQ01zWBas88dsKF0Flqq4Om+gMQoIj17VeqvlU9iJJ1R7hEJyQuS1e2UUD
 JK/pvgom3uS8TTqHG0RPN78vecJ8cT8VFIXB0LriE6ReGxgbs+AUKChijTDsExNdd1mcGHyjF7E
 OtkwX4jMOJpNpBl+ZIMXt5IVB6teV+62Ihud3Uy9+fN/1h0GyHTd3FC0O3ZB6KSur+ij2nBK9+9
 XdVTs4kIKrTkjS7NugRqd8aKGhe2YG/BKsNsVQnK8VFIh4eCh71S2xoLrYpnp1jMByXst4L2H8z
 s0nRKfRnnHw3iPfs5qAovFJJaV9dl8MlhWyH8CaPivY07Hw/P4kIfNcYNpcHJ92b4PiEEb7j4B/
 rURMUqOQ9XihwEMOBbhYnqlOpwPIyFi3PgVOE+PICMaUHsXfF5mamhOFrk63SzLMeqsTEJplmyQ
 OupUfsR33Hh9yoOczg+BBnk+kBmdTGIfKpGruoUu1J8Xi8UeLJqfVUYRwb
X-Received: by 2002:a05:622a:2508:b0:516:ddc3:622e with SMTP id
 d75a77b69052e-516ddc36797mr301126931cf.33.1779881023600; 
 Wed, 27 May 2026 04:23:43 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6faae4ddsm628363a12.1.2026.05.27.04.23.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 04:23:42 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v3] image-fit-sig: Validate hashed-strings region size
Date: Wed, 27 May 2026 12:23:38 +0100
Message-ID: <20260527112338.9811-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526105300.44523-1-anton@binarly.io>
References: <20260526105300.44523-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:27 +0200
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

fit_config_check_sig() reads the hashed-strings property and uses
its size value without validation when building the region list for
signature verification. A crafted FIT image can specify an arbitrary
size, causing the hash calculation to read beyond the end of the FIT
image.

Validate that the declared strings region fits within the FIT
before adding it to the region list.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit-sig.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index 433df20281f..bdfb5e3eb7c 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -512,8 +512,18 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 		 * The strings region offset must be a static 0x0.
 		 * This is set in tool/image-host.c
 		 */
-		fdt_regions[count].offset = fdt_off_dt_strings(fit);
-		fdt_regions[count].size = fdt32_to_cpu(strings[1]);
+		int offset = fdt_off_dt_strings(fit);
+		int size = fdt32_to_cpu(strings[1]);
+		/*
+		 * The offset should be already validated by fdt_check_header();
+		 * validate the size here.
+		 */
+		if (size < 0 || size > fdt_totalsize(fit) - offset) {
+			*err_msgp = "Strings region is out of bounds";
+			return -1;
+		}
+		fdt_regions[count].offset = offset;
+		fdt_regions[count].size = size;
 		count++;
 	}
 
-- 
2.53.0

