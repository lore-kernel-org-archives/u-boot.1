Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBDCC5B555
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DB782B07;
	Mon,  2 Jun 2025 21:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NhTVe2hy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BF382B19; Mon,  2 Jun 2025 21:47:18 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA7D82AAA
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso4017268276.2
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893634; x=1749498434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uO6Lvq9Pyc4lNLysUg24+hLj4xhIT7FECVuoH1NID6A=;
 b=NhTVe2hyMlDR3v6+ekfg+5RoOeqK3JpSktKlWuZN0oX9b1jUMOvtYn/6hcWbFnNw41
 Or2p5Waw20Km2LiZ8/oTEFbKhXvYSNcDpX5WzlnKzFNY9qQRXTmN+nsBjyDqSmJP748i
 osHzAXFxeQQMiX9oDCnMda3hwX5KqdCFKpzTZ11IImHz6kFVGlI5Avsu7DRFmuZp8qd+
 ioYvaDbEoFGF34G0HdSjxYZkFH25iTOEPBYHn1OJ2pnlzWIQDrBddC9sAIW3qbarpMtI
 Oj2F5kQ2ukdRG9lVAKqQCnmKd24geOPp7QhGxCxmzYhAgnSOxIUhe9nal6rHMj62vkSH
 QfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893634; x=1749498434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uO6Lvq9Pyc4lNLysUg24+hLj4xhIT7FECVuoH1NID6A=;
 b=S4TTCdWO5kHwfJfadAXkL3vT401EVSFWpDVZ9DNkipdiQaHYLlta2jahjI5GULBJn6
 wdam/MrJM6gw7I8regqG1mUt7ggYP57tVSgzR0g0Rb8iKX/OZ9nS34g0TKu87U14cWdI
 c9Ru0D0AfG871rPZgNuh5p3nVhK4TUb4ElOezN5Np8SzlD28CTAzH+MJmUCmrJIuln3q
 /U8B/qzJNqAV7fIY+3HwWxdWvh0UbV+VneeG1TOuDQ/fvO590A+ra/Z11v/1D88Q4mvM
 unjy+PgpdEWxli8Ii3awz0mEEckbC9KcXAbiS9HuGCYiqKKNWF1ABfm2diGguzuDgBD5
 A3vQ==
X-Gm-Message-State: AOJu0Yz9C+X1G3YtQSF+bjgVwQ5o8GXwHlveccm1nGngd5gY42OI8K9Y
 8Du5SUm2LL5D6T62gGhQ1RzWieTg1P8j2NieYFt9/4ziNAeaF8yR2OiiWLTk
X-Gm-Gg: ASbGncsduRqGkeOxQyGco5V//qmtUxMAPki2B0V1kwSv9W1flv/1FEXZQGNP3cXqUuW
 5HGHQhQhEeQ/wAgxooNrbaisY7sF05BbMFEdhM6HTtXgiNMC/mRC9GZcTbg3yH2BMZ4EB8pv5dq
 eIxy4Wja+w7Y8A2u+ROUrQJz/YMLZ7zaxb1Xr2KrBeEUXgFR3/mLgbFPQOCsYNSKCJpzxWyOWtz
 Y3OfoRHymQJ05XPG8CoRb5nJsY/yk/5zT1hteStwiRBK+aQNmRJwzJsHhfpuEUIBdWOqvJ8sg/u
 +g4ddTRE9rKiZIIEvFPd47a+7WfwfrQrEG9N4L8pvuH7QSPFHtQNQNDh904PhjhMJu4=
X-Google-Smtp-Source: AGHT+IH2RRUcKjUOKiqhISb9qk+khJNX6mnldsnDTtEZntH4DOONuy3DVJfbygz2CfasBBgAyLGAFw==
X-Received: by 2002:a05:6902:1141:b0:e81:5197:4cda with SMTP id
 3f1490d57ef6-e8151974f47mr4307529276.0.1748893634582; 
 Mon, 02 Jun 2025 12:47:14 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:14 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] MAINTAINERS: Update ADI entries for new boards
Date: Mon,  2 Jun 2025 15:44:48 -0400
Message-ID: <20250602194507.15159-11-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250602194507.15159-1-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
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

This adds missing maintainers entries for the ADI SC5xx defconfigs.

Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..cee5f1a9271 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -631,6 +631,7 @@ F:	arch/arm/dts/sc5*
 F:	arch/arm/include/asm/arch-adi/
 F:	arch/arm/mach-sc5xx/
 F:	board/adi/
+F:	configs/sc5*
 F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
 F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
 F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml
-- 
2.45.2

