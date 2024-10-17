Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC310D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D411D892B1;
	Fri, 18 Oct 2024 01:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EeIXxXlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7F189265; Fri, 18 Oct 2024 01:25:17 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E0089281
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-83493f2dda4so87738339f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207514; x=1729812314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7OGmiItWRzSop22IlXPKtegmQNCWdSr3uQ8mSUL36M=;
 b=EeIXxXlzh6pHhrN0UpJVElLNtmEQ9tZao3iRhGuZNcpFosD2w433bIbJB6G0Pq2X8L
 5GqNwzPNdvj8tooQzZiCr3EcwDuCg4fypNkL8rVwY1ARfj+zrP3HC73GUaRZwDiRIjFT
 AQxziU93yljFdEojYAXv509uBuUXpDdWOmWTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207514; x=1729812314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7OGmiItWRzSop22IlXPKtegmQNCWdSr3uQ8mSUL36M=;
 b=S3KPcaIkp10ymY6exqEfjiNFim3j0USFhVLMVifrAO04Y2cA/6jSadnbz8C4NwhOjG
 JdoV/Z+knef4LlLve7OmjpNQ6JrkCA53PFn4gpnpda3HNngIQRynR7bwEMmIxrPWQ4kC
 6VIu1B24mhTWwgGpxRn66r+41AIgvNj1NdPprpnUvUw3yUW1/o+L+uDysS1yCk+Yv6jg
 t8OrU721OPdWZnv1V1Cdhfkrj1slesWejlyMwwPiiJW7jt9Y3jjRjcSRZ22WiKgfX4Ir
 KfqFltnSqOirz6Eft9w2CMzE2BmtPrqNkdZPnOVEPqQqBroanay8/g5yho1+MtrhBBXi
 Gykw==
X-Gm-Message-State: AOJu0YyT8i75ivSYRxkMGDSd9S5mI4GyvWgMtdERxIdJK5y6WkBwrN7c
 QrY73UQmYinWSnNBJ/XV99HEjVN40ij+bsttMINd6EKb7i8/dcR8lBuy4AughaPx959KkSUpoSg
 =
X-Google-Smtp-Source: AGHT+IHpqj/V/IYUgGucPkltrzlgJQ+eH0V9rO+q8bsP8NG4UX5tRYgmrtmeFMhf5HwpvcXNwjhAng==
X-Received: by 2002:a05:6e02:1886:b0:3a0:ce5a:1817 with SMTP id
 e9e14a558f8ab-3a3e51391femr38077185ab.0.1729207514322; 
 Thu, 17 Oct 2024 16:25:14 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 32/34] bootstd: Avoid showing an invalid buffer address
Date: Thu, 17 Oct 2024 17:24:11 -0600
Message-Id: <20241017232413.724808-33-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

When the buffer address is not set, say so, rather than showing an
address which looks very strange, on sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootflow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 3e9769e0d42..1c1146ce11e 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -393,7 +393,11 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("Partition: %d\n", bflow->part);
 	printf("Subdir:    %s\n", bflow->subdir ? bflow->subdir : "(none)");
 	printf("Filename:  %s\n", bflow->fname);
-	printf("Buffer:    %lx\n", (ulong)map_to_sysmem(bflow->buf));
+	printf("Buffer:    ");
+	if (bflow->buf)
+		printf("%lx\n", (ulong)map_to_sysmem(bflow->buf));
+	else
+		printf("(not loaded)\n");
 	printf("Size:      %x (%d bytes)\n", bflow->size, bflow->size);
 	printf("OS:        %s\n", bflow->os_name ? bflow->os_name : "(none)");
 	printf("Cmdline:   ");
-- 
2.34.1

