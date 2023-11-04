Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E018C4167B
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F1B86F97;
	Sat,  4 Nov 2023 21:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aM7upb/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5818704D; Sat,  4 Nov 2023 21:38:08 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC948701C
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 21:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778a108ae49so346675385a.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699130281; x=1699735081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBkT22D95T+d0QN77dhXpJpLEzKcUA24ygj4yY8Vugc=;
 b=aM7upb/1S8xtKpYtq5T/S525A3Szg+U0xAKHBwUf7w35aIfGWzONleyWvoLCFrlUFP
 OMpTKa48hpSjRNUpF6HkzCNfmi99K2fXl44TH/xwVDtzjL+ShIWvFBYCujKd+W3A3W/4
 iQzpb+abEL70tnsuU8mPpW887thBU9iKc9I0WPej/MGh5/1zxuPsyCkEOQ0HieYfTFGX
 XOuEmwexql9PZir1mu11oqhOePW+1qCpqMrCO8d82M6Fa2GBulLLJ9CqJyOg1aHGADER
 akWE0zDcdhMDS/U1tpKHYFvAq4LcealFj8PEeR7k9cH5Aftq+sJqbPfUBzcKImrPELvy
 dvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699130281; x=1699735081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBkT22D95T+d0QN77dhXpJpLEzKcUA24ygj4yY8Vugc=;
 b=oVFt9+aFJhSZVRH6gtcE1nD6c1Mdpug0eypFIUjWKcBw2sFbGa0FTm+2f9XAbeQc7P
 vTnFRhynnXVQPqxHo6hr5OHDPv+sS6qBi770heKqIercjEjMshYR2v3e2Lf1BhdKjolZ
 LzNlbkHW+dqndN/WWWCz7E9X6dpZnbq9FVp8Ztv3R9R6gkk8WADh4SjuQR2kDsHj7dCt
 uZX9h5atYntx+002liU0btO1WalQpGWJa55poBN94gNAAwnYSulsRDJAJ+8qeSk4xngi
 s/F3FG36n48BZeZ3xI72VdVW4kz7O2cSM8Owc+pIlt+kJM5FoTPO/guWBznr8oAukoWe
 wJ0Q==
X-Gm-Message-State: AOJu0YxX1XmXIKoKr1brg8/ljw9tRFjIyeIeMaapidQWpdDfJJyzdL3P
 JFSM2ACwIVgPSQPu6+hr+kpKrr+eiAW42w==
X-Google-Smtp-Source: AGHT+IHIYkNdlz1l8HqfRfoUeqj2lU8TBsblmYCWuPa1neflQxUzQZ/ivhEAgft+h8Y/UgFzXiNEoQ==
X-Received: by 2002:a05:620a:1790:b0:775:92ac:a3d6 with SMTP id
 ay16-20020a05620a179000b0077592aca3d6mr9856497qkb.14.1699130281087; 
 Sat, 04 Nov 2023 13:38:01 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 x3-20020ae9e643000000b00767d8e12ce3sm1834177qkl.49.2023.11.04.13.38.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 13:38:00 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 04/15] nand: spl_loaders: Only read enough pages to load
 the image
Date: Sat,  4 Nov 2023 16:37:42 -0400
Message-Id: <20231104203753.1579217-5-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
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

All other implementations of nand_spl_load_image only read as many pages as
are necessary to load the image. However, nand_spl_loaders.c loads the full
block. Align it with other load functions so that it is easier to
determine how large of a load buffer we need.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
---

(no changes since v1)

 drivers/mtd/nand/raw/nand_spl_loaders.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_spl_loaders.c b/drivers/mtd/nand/raw/nand_spl_loaders.c
index 35d6b1d6c0c..db4213ea3dc 100644
--- a/drivers/mtd/nand/raw/nand_spl_loaders.c
+++ b/drivers/mtd/nand/raw/nand_spl_loaders.c
@@ -12,8 +12,11 @@ int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst)
 	while (block <= lastblock) {
 		if (!nand_is_bad_block(block)) {
 			/* Skip bad blocks */
-			while (page < SYS_NAND_BLOCK_PAGES) {
+			while (size && page < SYS_NAND_BLOCK_PAGES) {
 				nand_read_page(block, page, dst);
+
+				size -= min(size, CONFIG_SYS_NAND_PAGE_SIZE -
+						  page_offset);
 				/*
 				 * When offs is not aligned to page address the
 				 * extra offset is copied to dst as well. Copy
-- 
2.37.1

