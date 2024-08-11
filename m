Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9F5C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 11:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A0188580;
	Sun, 11 Aug 2024 13:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gvdyKLvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5EB881A1; Sun, 11 Aug 2024 13:01:19 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2148A881A1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 13:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C906F44087
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723374077;
 bh=uXWRYhU2ecHXRKo5CqjYZC0eLrXVAS9bVy6Fwf/Ct3U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gvdyKLvUBMdUKxvDN8z44njaDrhm/LbZ7z3zTkL+gODugZderWKrM06ZfFls8R8PI
 xrNXJam1D1WZUvb+1KL3o8ALkte3WY9JyC/zuC9YNqSZIN/vDUpHs66xpoNb1l1Uln
 HtGmkhblWKF5jcz+w98S469jhhm3UXtnzqEsKdFF8rcagFzK8Yilyg7PHlbYyebEId
 TaS7AoW5+dJyOv7UkOnLqDQ/rbNqagSJOeNWHFoGV1bx0D8BWM+mU82Hly3MGTZ3xg
 xOhH1ejPkAM/9FW5czjgr/pLvH/HyY2ROhy4ixzO/rmNlWq7xCI72wB/VJZYPywoc8
 GrR95WefQR7/Q==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42820af1106so24877635e9.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 04:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723374077; x=1723978877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXWRYhU2ecHXRKo5CqjYZC0eLrXVAS9bVy6Fwf/Ct3U=;
 b=AbHpFfzaQ/uTm9skGoZA1nbDno22sTgvx+E0HJLTmFIGwiEXXkL/hFu4nkQvoEmSSZ
 lOWpZr/0S1uxvSifr2AC0dMOhTYtzBAoVW3oWRXN/oxQV3D6ZimsW7b4fs4iwOM+sLFk
 TYMtRfivdgIA6La64K6+uSKYbCnx5ZBExJV+BK3LnJIdx/FBAdJnQ+W9gQMggoXVbL44
 trW2x4fyEK65c1WjRS+Vdsrle3rNNmkT9wn2Cj7yt70RLDEagvLUaxy0q20dZcUYRV9w
 2fQhKsOrsNV352W8MXOpVW0C1LNd7YJ99My6NcEtFM8mjoSd2H7eIJFNuKad03jSeclE
 5t/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSElQHADauRpm1s/98zamTPHUrIPJ2qIzBIClehC2W1IeYPIw9SAVB9gr5DrW/vECPYpXlJZ8=@lists.denx.de
X-Gm-Message-State: AOJu0YyKr2uKEB7fL5YFrugmCeTBa/vAQB+ozPkCuMqkkSNu9NEa1emb
 jN/DKgt/ncU3S080iEX3v8qRyDbshpOhd65S7qK1l44MltIQ2MtFataYKaOX/IZTRTzX/VsINj1
 dEV9nUCDZQMfBa7kXWyBuySt5PVt5g5RoZFAWhGqvgzl+DlyaCYCd/HzYCFXLsuVT8P4=
X-Received: by 2002:a05:600c:1c15:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-429c3a23d99mr44078095e9.13.1723374077034; 
 Sun, 11 Aug 2024 04:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElSpjOtUygVYQ9Z+g5K5aEJuabr8lnlBwQpvzg64+GWxIHX2FxUGpZb+iPX4JYimMQ+SvSgQ==
X-Received: by 2002:a05:600c:1c15:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-429c3a23d99mr44077945e9.13.1723374076474; 
 Sun, 11 Aug 2024 04:01:16 -0700 (PDT)
Received: from localhost.localdomain
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee31fsm4604568f8f.47.2024.08.11.04.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 04:01:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] riscv: show registers in crash dumps by default
Date: Sun, 11 Aug 2024 13:01:04 +0200
Message-ID: <20240811110104.143714-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240811110104.143714-1-heinrich.schuchardt@canonical.com>
References: <20240811110104.143714-1-heinrich.schuchardt@canonical.com>
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

If an exception occurs in main U-Boot, show the registers. This makes
analyzing crashes especially in external applications easier.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 66cd512b23f..fc79d4902de 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -437,6 +437,7 @@ config AVAILABLE_HARTS
 	  If disable this, it will send IPI by CPUs node numbers of device tree.
 
 config SHOW_REGS
+	default y
 	bool "Show registers on unhandled exception"
 	help
 	  By default only the program counter and the return address register
-- 
2.45.2

