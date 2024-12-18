Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F54FE77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 07:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B187680241;
	Wed, 18 Dec 2024 08:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wnpYIjFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A911580269; Wed, 18 Dec 2024 08:03:03 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64D280241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 08:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so2855702f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 23:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734505381; x=1735110181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6p+WKkDxcIxCTA8AyvnO/iqGzs5mT4zUYn8AC5G7hWc=;
 b=wnpYIjFMvNTNOl5Ouy7Wqan1hS9E4hbpLceO3KIG7Hgr7yJpmbEHU10GZlwAaXr0QG
 8LtMEoFi3HFCZLoGYm1R9SD4JFwIQHoDepvmgn1j2kH3bw2vvRQ6HvJ1dimXivOSEswB
 1gEvBAcwS2VrjmAxpDjWAMoSNxQ2cJM8LnnniMqxslIEXg+B3+7L5hrTZINZ3rGryVAE
 rGKUH/J6ccR8vNFOSrRLKZGovI38RT7sf6kfnPI18uvsJxitwHPWBlA1M7CnAYPCBVXv
 hCZErwxA3FGIC++OZJzvr4NiqeNwaZK/88ZlQnXp9/0f909LWMWh+LA+/LE69PHWDPR9
 CxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734505381; x=1735110181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6p+WKkDxcIxCTA8AyvnO/iqGzs5mT4zUYn8AC5G7hWc=;
 b=N0pX6e/jGF7B0zpaWguaNPMMS9mkB9aVMsF/9Zg7nIduugDdgp+OoXVnIiX2IvU3R/
 uSlf0yjgkHFO5o45CfJXfDnq3Un71oX/nUk+7GWEvDlcBT9vtdCU7Y//K7z6PbX5fzt8
 06f7mr5Ma5EWmc5JKgcPAcYY+Gn8pCxKdA0FfdwH566xE/ibZYZ23fQdN7vgqXFnvEJ4
 Se4+w3jbbVY62DXH1RHABLvOS+dijR4hdJ2R2mRfb3cLU+/s1lp+wAamFIIThwDgl9g4
 5nrVRwzG23LlHyubK8lYiHech5W5TuRJkQnY2/gKmSJ1hrcf4tP5X8ue1kJvgnq0Grmn
 L8FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM0a3+YNCOrdeK8+gEJw5wnqvokU0ZhaKmMXtYSRf+fzrcIUXKtoAYNRxu23+waP6ZIbI3jQw=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/3FAG8b1rithbNbFH1bkezb4EpfHbFuyeSMyD+70xn7m+5FAB
 m+FCekC7ZDNl2HxDoSWQgQMn2gdV/WYzXJNDkO40yBVc1zx4FhNN5dCotmMOoFU=
X-Gm-Gg: ASbGncvv668v7AXhXE+asigxyHAsS0bSdYQNo6747q1Mtvc5ISGM/xbmr5H4Ynk4krM
 scN/WcusjUUZXGwf0HwbR7v9c2ahCvsozHg0EbbM5e+hyJ4cJ227M8zYQUvDdNhJuMR/mTP6ABR
 SYbYw9NuGfaTd/8ax0JVL2wPCiTz5KOxLSjmRgVwn0D3XzTCa7ev17ACnTu+wlETNCu9Y5FUJ7n
 1cUtKB1ezIkgYxwwSl4eUQi3qJjKck0Xe96wve68fJBRALiluxd6apCJQ9EuUTYNIhUz+KHDSYC
 6qCSldSOaa1iJB7ao7daRbtiuKZsMKjDlw==
X-Google-Smtp-Source: AGHT+IGMELihLA8hryIDBJunXciCNEJ+7keiDJpO5gGfxaEMrqCGm7WAts5be/rdWpBzlXDfpCaVEw==
X-Received: by 2002:a5d:5f4d:0:b0:388:caf4:e909 with SMTP id
 ffacd0b85a97d-388e4d56a4amr1396488f8f.25.1734505380965; 
 Tue, 17 Dec 2024 23:03:00 -0800 (PST)
Received: from localhost.localdomain (ppp176092181030.access.hol.gr.
 [176.92.181.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060592sm12971612f8f.98.2024.12.17.23.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:03:00 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Peter Korsgaard <peter@korsgaard.com>,
 Michael Walle <mwalle@kernel.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Janne Grunau <j@jannau.net>, Prasad Kummari <prasad.kummari@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 1/8] lmb: Remove lmb_align_down()
Date: Wed, 18 Dec 2024 09:02:30 +0200
Message-ID: <20241218070251.686383-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
References: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
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

We already have a macro for this. Use it instead of adding yet another
variant for alignment.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Tested-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lmb.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index f9880a8dc62b..b9c26cb02e10 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -342,11 +342,6 @@ static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 	return (i < lmb_rgn_lst->count) ? i : -1;
 }
 
-static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
-{
-	return addr & ~(size - 1);
-}
-
 /*
  * IOVA LMB memory maps using lmb pointers instead of the global LMB memory map.
  */
@@ -400,7 +395,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
 
 		if (lmbsize < size)
 			continue;
-		base = lmb_align_down(lmbbase + lmbsize - size, align);
+		base = ALIGN_DOWN(lmbbase + lmbsize - size, align);
 
 		while (base && lmbbase <= base) {
 			rgn = lmb_overlaps_region(&io_lmb->used_mem, base, size);
@@ -416,7 +411,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
 			res_base = lmb_used[rgn].base;
 			if (res_base < size)
 				break;
-			base = lmb_align_down(res_base - size, align);
+			base = ALIGN_DOWN(res_base - size, align);
 		}
 	}
 	return 0;
@@ -709,13 +704,13 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 			continue;
 
 		if (max_addr == LMB_ALLOC_ANYWHERE) {
-			base = lmb_align_down(lmbbase + lmbsize - size, align);
+			base = ALIGN_DOWN(lmbbase + lmbsize - size, align);
 		} else if (lmbbase < max_addr) {
 			base = lmbbase + lmbsize;
 			if (base < lmbbase)
 				base = -1;
 			base = min(base, max_addr);
-			base = lmb_align_down(base - size, align);
+			base = ALIGN_DOWN(base - size, align);
 		} else {
 			continue;
 		}
@@ -740,7 +735,7 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 			res_base = lmb_used[rgn].base;
 			if (res_base < size)
 				break;
-			base = lmb_align_down(res_base - size, align);
+			base = ALIGN_DOWN(res_base - size, align);
 		}
 	}
 	return 0;
-- 
2.45.2

