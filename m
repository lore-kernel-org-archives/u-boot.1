Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A757EE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF458978E;
	Fri,  6 Dec 2024 03:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jkoNyjaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C2589788; Fri,  6 Dec 2024 03:38:33 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 795A8896BA
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8442ec2adc7so55091139f.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452709; x=1734057509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOn2u10S5kwmBvbMJ6aNx/m5KTqTAk6amUxoKRLpCG4=;
 b=jkoNyjaOB00J0xE1zTFN5H3ody4q6tK6AGs+vBoLNwbzQzLX0vni5yVRMEt3rwCw/C
 cWckoG7cfPZ9MoNSNW9wUNEzIMBNJjLsZ/Vz7ETAcczUx/6Q9fcqSxZHIyxP00FEGcBC
 demUZOmZnXcwDLFWloGFAWKyH2xHrI+xO/JDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452709; x=1734057509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOn2u10S5kwmBvbMJ6aNx/m5KTqTAk6amUxoKRLpCG4=;
 b=SfiaEfYLCZb3voeuAp1fz0U+4sKXbpKQltd9Oc45e9wmi5kYlnJuWiQDt56NKsL9qE
 CPULtl6CvFPwJDCY53uQtk++9Eqcy7eN7cleVeWU5XzEk1k0CrkSWsGdy+6EIYBT0yu2
 7wkYBra433behLQkh+dB8KrFqjWKkuF3zmUAHw0I055PMB24vLBjdFssviuEww09HMNe
 4UtqPhxcdLJfJXSnpGx5y9CM5bgwPVf6qaK0eJgNjGesYXu9UvIxhVpzLX1pdpRpbfpg
 OEMfV8VC5urHeuTu3CFW7LqhgEIiV0WDxICxsGL7YexerPD+p/bHs8kIQjw2yKZcBYBg
 iGmQ==
X-Gm-Message-State: AOJu0YzITfVR8tRWSGmDENBOPBCHf8xGDLkh0ANAgtkZ3qnx8TV4WsxO
 p1ZLt8S18e4BMRlqKx5sWYYxkLFuu0sS32A25ahUmOVlTV5dJl6eDxa61NHAwH4nZY8B9gHzkMw
 =
X-Gm-Gg: ASbGncuOZzcC+Tt5/N738e7T3nbfeeT88Db4QWGFWQ1/prDi9TIfyVeCs56fNoY15ka
 AraoPNd9FrMe5RqwWzlEqmlV9XjKhqXnKAB5hLB6tAcoJvlRSJ4CKJdrAhB8pAJKb2VMdtCwcqP
 huW23kFtrPm24XD8iIYpbzvxJ/qHz23h6dO6TmUEe8P6N1nJyJp5B7jpIguSrgDoJM++vHWjBOs
 bbi+exMhiM3gLpZymqqEonlYPks2rtgyp9jiZvJiCl1SVrpEgdN7VmEr3dTesvJr55cJprUt5gy
 VAk5qIsA/88=
X-Google-Smtp-Source: AGHT+IGdvpOa1ls93PFw6WWkTpnHmP4pPwrMl3QXlpPHv7OlS+WRMqY6+Uf0zJvcPmV5WCGtQlPYXA==
X-Received: by 2002:a05:6602:6c1c:b0:843:e9c1:930b with SMTP id
 ca18e2360f4ac-8447e2d9f29mr216065839f.14.1733452709686; 
 Thu, 05 Dec 2024 18:38:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 44/46] boot: Detect booti format properly in pxe_utils
Date: Thu,  5 Dec 2024 19:36:23 -0700
Message-Id: <20241206023626.2456858-45-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Rather than assuming that a file can be booted with bootm, check that
the format is correct first. Do the same for booti.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to detect booti format properly in pxe_utils

 boot/pxe_utils.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 1468a8e8498..71347b19119 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -591,6 +591,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	ulong kernel_addr_r;
 	int ret = 0;
 	void *buf;
+	enum image_fmt_t  fmt;
 
 	bootm_init(&bmi);
 
@@ -608,13 +609,18 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	/* Try bootm for legacy and FIT format image */
-	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
-	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
+	/*
+	 * Try bootm for legacy and FIT format image, assume booti if
+	 * compressed
+	 */
+	fmt = genimg_get_format_comp(buf);
+
+	if (IS_ENABLED(CONFIG_CMD_BOOTM) && (fmt == IMAGE_FORMAT_FIT ||
+	    fmt == IMAGE_FORMAT_LEGACY)) {
 		log_debug("using bootm\n");
 		ret = bootm_run(&bmi);
 	/* Try booting an AArch64 Linux kernel image */
-	} else if (IS_ENABLED(CONFIG_CMD_BOOTI)) {
+	} else if (IS_ENABLED(CONFIG_CMD_BOOTI) && fmt == IMAGE_FORMAT_BOOTI) {
 		log_debug("using booti\n");
 		ret = booti_run(&bmi);
 	/* Try booting a Image */
-- 
2.34.1

