Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310CED3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FAE489345;
	Sat, 19 Oct 2024 17:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kUGPSQeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C0C089324; Sat, 19 Oct 2024 17:23:03 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40625892E0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83ac05206c9so43394339f.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351376; x=1729956176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RA0DfVt0eawaU8vESVNut8v8CGo7SpNF3+1xt9lFQyU=;
 b=kUGPSQehSo+rL4+odZ0ZJ3jTcYCZPnqpk0HBCsGPHQPH3NpkWt/xmGMy23fc7BdM9N
 DUc+//c0zMlTXsS0I9r3FTRjipPrRtFeBtZfxJ7Q9QH1GfskN8BZrJ2ln60R1GWikc5p
 Dm5smJos3Akj2l3hexSQR6G+SezNdboqcDVAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351376; x=1729956176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RA0DfVt0eawaU8vESVNut8v8CGo7SpNF3+1xt9lFQyU=;
 b=GOHNjda0l3bTdg+hK5+iPpR91slCP5rgYLZ54XJsKh07ErFHwvvcKy2WJck+B2x00e
 5icEYWkGc/+UrCOFLmLmB4pbG5JyziwJYtccpQ05A2+rjdRAyir2PVRtuXeXV8LwkCEl
 +cuk+zFDd35gwkVUGr5dCaQwt21JsDNaGRgY077KiLoyapIElOADDNFPVtI3y8EZ4zCb
 lVGEn39teXVYeRXSmHCTbfL+M7qtiNHnP8EqfTsLXNn1kNHI+WPtcLa+7+RKr35RTaGh
 VGDMKkyohBlpd0DTMdSD6kwud2zdBNUJbgMzGw3mdjdFsnM4ULxoy6xAXUMYyhqwCk66
 yHFQ==
X-Gm-Message-State: AOJu0Yydjyuzu5ffcrbE20CG5+OZmzg0d+VID6sQUQFUcgCc4qsI6aNd
 ptJqYcsx6PI47zJbEwwS2dkT8G04sVJZ+ckkcX2c+W2/m+XGV0cOHNHal4WFmVKQl9LUTLKjC2I
 =
X-Google-Smtp-Source: AGHT+IFMJl3JCJGdYnNmksul9Ecu7/dDlP/6fEcLE//4NMQwoqSEczGc2kMeXHrdNV9pffNXyPS+Ug==
X-Received: by 2002:a92:c546:0:b0:3a0:378a:884b with SMTP id
 e9e14a558f8ab-3a3f40474c5mr45396065ab.3.1729351375900; 
 Sat, 19 Oct 2024 08:22:55 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 23/31] bootmeth_efi: Simplify reading files by using the
 common function
Date: Sat, 19 Oct 2024 09:22:03 -0600
Message-Id: <20241019152211.1014896-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

The efiload_read_file() does similar things to a common function, so
update it to use that instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 2ad6d3b4ace..f3ddbe71405 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -110,19 +110,14 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
 static int efiload_read_file(struct bootflow *bflow, ulong addr)
 {
 	struct blk_desc *desc = NULL;
-	loff_t bytes_read;
+	ulong size;
 	int ret;
 
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
-	ret = bootmeth_setup_fs(bflow, desc);
-	if (ret)
-		return log_msg_ret("set", ret);
 
-	ret = fs_read(bflow->fname, addr, 0, bflow->size, &bytes_read);
-	if (ret)
-		return log_msg_ret("read", ret);
-	bflow->buf = map_sysmem(addr, bflow->size);
+	ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
+					addr, &size);
 
 	set_efi_bootdev(desc, bflow);
 
-- 
2.34.1

