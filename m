Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9326E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729A3806F8;
	Thu,  9 Jan 2025 13:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HIAqcUB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D14805EA; Thu,  9 Jan 2025 13:31:08 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D79A806FC
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3ad272538e8so6675345ab.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425861; x=1737030661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdPrKN7KNxCZAgaMA6bSXd3DNcIfi/WIN1gERJmIykY=;
 b=HIAqcUB20noMdpiISdVkInyRsORDlHzAEI2ZGSFe+dIvqPF2YlJylY+AZOCe7nqVoV
 omXWDVOdcMhwn/Aoge1nwWVm41BfXTBImgKjGKSeZX4/4LmoIaYOxVy/NnKhWfm4IQD/
 LVgHkUR/Fevqeyrh26GQQvLpUzuxI46i3L92U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425861; x=1737030661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdPrKN7KNxCZAgaMA6bSXd3DNcIfi/WIN1gERJmIykY=;
 b=MKqBzPCDLq1EnmIyFxZvQwsVaExr/ppN+LGp/t2Vg4KEsCwxW+0BIvkFfw6C3WE2NL
 zucMCZ+YBVreBe9FXbOdIGO3Kq38U/g/+lSmexpxmU71gTWJxJ7uzlUKGiehyePO/9eR
 ldYl54o2+LW7Q7yMRDpxlNmX/Ews7BYTkAs81vqVx950a+20mVXpFrnjuD9m21kz4+zj
 JzUw4iyUo0jT8HscXDURPHM+sApuuXlYQwyboPwWN4lbGnWEHZeH0KVD1LJimsmyNUTS
 RcFNNtIjXT0ahTpQYAeGC+8viBb7Dn0o6xTBD+/9Ahh7utTuO6tGbXN4ZuI7YjZTu31U
 20bg==
X-Gm-Message-State: AOJu0YyIrs9qZp5TpkeZVQTAyYwxZpljSUHEiYzdZz4lpSIWFsAkKpxD
 bKyPqap9cE8rv6NRXBLKsMR3gQJfjer9iZnFvBtByuDOAlVLyS+vH2dGscZyTpqzIvMUtTIXYLM
 =
X-Gm-Gg: ASbGncuNtxBfEFeUXJl8JvoJZ9V0o9hxTd9VFJAd/b8zz7tHVGGm44+XCi7Nv7Y6GXF
 Bo8L1aGfZgeVOCdaKhlo163l8m7HkTdz0WE1KdDbSF9IVfu1Lw2K/rE2f07X3NRQ/wXQMNj1jpH
 GmjIc3KnqoUu6yfAZrVkKchYtP2SfW0b35ypHTaJQnXO/oG2fy7C94yvEVy9E6t1eSyCNIARvP2
 zENbrvvsWZ/jNSVdKGj5RdIR7oPYSdUQ3DqhnA4PlhzBsGvj4T2lKOrqHice04LK1LR6TLWJoVd
 RyNORXX1Vi7srhGOug==
X-Google-Smtp-Source: AGHT+IGWaJJxZNtSw+a/Rn9B82JsXWb6lEVyoHa0IKdFG8d38GdhdPZiJiALkq0SX7r3nlU+QPqIGg==
X-Received: by 2002:a05:6e02:148a:b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3ce4757643cmr21435735ab.6.1736425861394; 
 Thu, 09 Jan 2025 04:31:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:31:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 12/15] spl: Plumb in the relocating loader
Date: Thu,  9 Jan 2025 05:30:07 -0700
Message-Id: <20250109123010.4005298-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
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

This is fairly easy to use. The SPL loader sets up some fields in the
spl_image_info struct and calls spl_reloc_prepare(). When SPL is ready
to do the jump it must call spl_reloc_jump() instead of jump_to_image().

Add this logic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 12 ++++++++++++
 include/spl.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 09e6dc26f5e..7cfbab06419 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -826,6 +826,18 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	spl_board_prepare_for_boot();
+
+	if (CONFIG_IS_ENABLED(RELOC_LOADER)) {
+		int ret;
+
+		ret = spl_reloc_jump(&spl_image, jump_to_image);
+		if (ret) {
+			if (xpl_phase() == PHASE_VPL)
+				printf("jump failed %d\n", ret);
+			hang();
+		}
+	}
+
 	jump_to_image(&spl_image);
 }
 
diff --git a/include/spl.h b/include/spl.h
index 9cfba98db55..7155e9c67aa 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -414,6 +414,7 @@ static inline void spl_load_init(struct spl_load_info *load,
 	load->read = h_read;
 	load->priv = priv;
 	spl_set_bl_len(load, bl_len);
+	xpl_set_phase(load, IH_PHASE_NONE);
 }
 
 /*
-- 
2.34.1

