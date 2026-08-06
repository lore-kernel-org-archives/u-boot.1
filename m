Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41455C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1E654065D;
	Thu,  6 Aug 2026 13:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M1otW56bWHwH; Thu,  6 Aug 2026 13:05:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51EC5407C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021524;
	bh=DVqNhoLkW5K+Tfs+xwSwPb+RYAzYdFYqcLRU1csGWGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z+AByqiH2KJxfz2dUeDS+jWmt06Xh3UnUkNGnyfoTFUHNf5vEqH3Q3hPDLcBWMQS7
	 Zw7UtpUeSaVmUXfhUZqgX1T2n3W+dKj/BVG49MkpGr1wGCM8BsK8myAaxYQ5WKxow/
	 9U7KfzLS2mClYYrdn+JfnRikjBkvrqXlTvjNHxbNiln1jyjmGU9lNrUTWuES5ZoBTF
	 8b/zfH/BuAky8nGd49zOHZFbA9uqcB4Wfb9sUe6tudDbM+F2GzjtguJzJYE9OFvGmc
	 QqLszVFxXuDmbC3+kN7nuisBxLkHUiCfY9ccd29fb6B7/4q9kr51Op9YZQ14WXiCN5
	 apYxG7ryxh3Zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51EC5407C6;
	Thu,  6 Aug 2026 13:05:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 03ED4218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA1B840112
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9ALin48UGZT for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:05:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E940740279
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E940740279
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E940740279
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:21 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so11418975e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786021520; x=1786626320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DVqNhoLkW5K+Tfs+xwSwPb+RYAzYdFYqcLRU1csGWGY=;
 b=UF5/95zgH/p0a4Qskh0vbQBeNFX2IW13qwsaYtrjm9yr8kdByZ2+/8zaMT6rsCXPSX
 ZRdDKTHybH6k2qiiyDGL8+A5kJPzNWZfkjIwZCoViA+4BzxT4hNkHwz6fkn6Q/Ih+kDp
 dXmTNNbFenBn+EnpbpBBjK8BkTep+D3viTbGVMmpSA7hJvPwZ0saFy5WBbBxlv9ryRHK
 Ufcu/z2ReU5quTbPBmdMP0Twuaxy10LgqeSW+bxOx9ZRnQ4RgeDzMsHrqlJcOIUJpMzl
 p/C0gt4AepGIkAFURhzsXOsXTpZzjOcdl35hTikNVjcR72EIzRibcojP21bGODJZoX9P
 7Nyg==
X-Gm-Message-State: AOJu0YyFI9YSGreLaXyiGvdalAEqjAl6CrgQJnQ1NDgM283NUw7DJzLB
 +9l+3Vhzn2TI+S3bpvmFPx5EF3AfvID3KQmXe+MWBf29GIuOEaaASFq93Fn+4HMMtS0=
X-Gm-Gg: AR+sD13lTalEJI7vIrfahm1jXzAWSJtpSag0PotsMQZVcP76/g5LnyiUKOmLcNBwTHt
 qj08X7Q1hN5LOnpkcF2SYkpiMc14c352P+WtxFTgtCrXF5TeBzUADSXx3TKrzD4Z/uXRDdGDH9E
 D9Ytcg+454+ic25CNzC3JW9GVF2WztWaC0blENgvL0VlN2g9mlPXw6Gvy+TSP0n1C6j6rTe1T2Y
 qdG531gynkSWOriylxrg5Mo7ZbYRVCczhNxhdfOa5Mxk2Lo1BLyJPQ8qUEzXCtpbvgOOzcGeKgW
 x6xULQOUMkuoNPCPgcT3/9DfBXlzW/05sEQIZfN3ruDYXN0oMUqYtV3ivAqhCU3HEFea17lOwmO
 tszPrnvBkbo/Ubtu+abCj8UjGes0DTY0ueTId0Dn26FRCda9f+g+rUoT8CMyfFOSsECmQNIzP9Y
 enwV/cApaXsx85rWN1hsDqVkdtm5/D3MCifooixSza4Fb9GrFITbzwtomZIULAlFQ0IxRS7CuX6
 Ju1/V+kra6UJHrknmrYSv42RbDXjFBqhkrxlvfHItiuMEfpkLQCkCBkLYS9D2d4pKTKZBFxGBEL
 b/HLU8Qn3DJQfcgC/W9KSnckZO+owWZvHQweD4TKis9pbA==
X-Received: by 2002:a05:600c:310f:b0:499:520a:c79b with SMTP id
 5b1f17b1804b1-499520acdf5mr96627825e9.4.1786021519826; 
 Thu, 06 Aug 2026 06:05:19 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542241c4sm58739975e9.11.2026.08.06.06.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:05:19 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 15:05:19 +0200
Subject: [PATCH 1/2] dm: improve logging for missing uclass
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-improve-logging-on-missing-uclass-v1-1-d477f0054f48@baylibre.com>
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
In-Reply-To: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786021520; x=1786626320;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DVqNhoLkW5K+Tfs+xwSwPb+RYAzYdFYqcLRU1csGWGY=;
 b=a3XSy4fOlPlcp9ly4SEeGefdky/TXm4upHHSii/4soTS/lZhLUA9/UcaK8cU1XO3G8
 ptsW8p2DPqCmzWObMNWpZ2TWODYhDB1sqZD8FE85Wa0ZUJnI3hy7xZJSLgiH80Av55sK
 AhFaH6aahcpC2ghmOTCL7RLVzSvzC0XvDSGAh+8FInsQMvdZtkLmcrYkenwzfowEWL5d
 2AtPUZ4+xKbJqbSy8BPmap8qMehWdczl33k4zVL8143U3fkd1rQDMCL6HiKqyqfyngJm
 bOk/1m/2GPGHPzuTrzEospceixpFV74Vnvfd/tZpQLtHzLxcH0bb8hepZa0b//tv3QpG
 WOmw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=a3XSy4fO
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

When a uclass definition is missing for an enabled driver, the board
cannot boot, and without any extra debug option enabled the following
error is displayed:

  initcall_run_r(): initcall initr_dm() failed ### ERROR ### Please
  RESET the board ###

There is a debug message using dm_warn(), which is not displayed by
default.  Since this is a fatal error preventing the board from booting,
the log level should be at least ERROR.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/core/uclass.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index 5365ac68f9e..be0159155f0 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -60,8 +60,9 @@ static int uclass_add(enum uclass_id id, struct uclass **ucp)
 	*ucp = NULL;
 	uc_drv = lists_uclass_lookup(id);
 	if (!uc_drv) {
-		dm_warn("Cannot find uclass for id %d: please add the UCLASS_DRIVER() declaration for this UCLASS_... id\n",
-			id);
+		log(LOGC_DM, LOGL_ERR,
+		    "Cannot find uclass for id %d: please add the UCLASS_DRIVER() declaration for this UCLASS_... id\n",
+		    id);
 		/*
 		 * Use a strange error to make this case easier to find. When
 		 * a uclass is not available it can prevent driver model from

-- 
2.54.0

