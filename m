Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE01DCCD187
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F78844BA;
	Thu,  9 Oct 2025 11:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P4M1wlH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE0A844C0; Thu,  9 Oct 2025 11:30:30 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D45844BA
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-4259247208aso5473205ab.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760002226; x=1760607026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rg3XCPOuzGZGrhxAaGybzGEJeEqQYd0mgfaeyweCyr4=;
 b=P4M1wlH1VUqo+NeT8bX1fNoNlUg0BRAeEWBkrTHXbxZBSAQPOIbtfMb7I71/KAttBf
 A8N1I/xvGOrtiB1vZ/9s4r0IyJl7ybmCnDU3pY0BLoksuQYHlTxb13qu4tmBiWpPdB/x
 cHZXXV7hC2W0s/+dfU0a/NuHXiNxFPfVajVoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760002226; x=1760607026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rg3XCPOuzGZGrhxAaGybzGEJeEqQYd0mgfaeyweCyr4=;
 b=PGplNuciOGcDmCwVSorGxEge0q0ZFXJnBjljD0BkYi7yZXuxmaWAzZQjlNb3cjmuId
 NA/PHbtyBHbqe2qBwwzhn2WGugWfYCThsoKNcbogkvPfgOjrt9Hz9pSf5omYUs598d9w
 N/MOw0qnVPnWwaAcP36L/wcmMst2cTABTJ0P8gKbfQ+awAzGmZILSF1DtZvZ7VEZwiEv
 paWmKQDOMOJnb8jL8OfLUwbvCi4JNdxSknfiVsoba9oBLWcZD2btsl8VWX/8HoCSuFuv
 EOUYNmSpBUNkKb4uyVvOTwdwPaQbWsQS7lhviYdzh8fQLmQG18rgRBT5fcObwskYnJME
 Xm6A==
X-Gm-Message-State: AOJu0YzowUwlScLbmkO4UkRUb88eRva2XbyKIN0RNwlnXwAaa5ccDLWD
 AbsA4P5+JYC/IMJ/l/9RZgAZ9B/uwkC8ER/SRY58ZvFc3+QoLmCFonqmFJBoYWwumHM7hF2WfCU
 AdMww8W1k
X-Gm-Gg: ASbGncuVzb0voRteD5A5glzTrpVNH1vL0kTHW5a0mmWiSczkpAHrAgVb42R73iUeZp+
 eZ6L4ftJ6R09X1ZpFz8m1m129jOnm/BXKvhxwXnBxxUpWJdFKOsLUM+fKP/HWUTuRYdn2TBLTsD
 JhQxw71Y53+10WcS7BXXtDUF9ksnbxQHC3F2uDkVwGldPYgnDZZm9vq/iCBOWr2uZVpbQW2GKwA
 y+tadJARBAS0YyMi251rNf6QuDrSI94x49M75UGefipUjLOU7S83mCvlaheRw3v5SNfVQAxWK3Q
 OmRYaQO4NEOLwDB4Tu0RT52UQEgoYZ8Oi9Vn8xxdRFebnQVFmFiX18jNwafk0i93s3UUaZL8G1h
 75N1CWTZDeyKXL244Jcw77j5R5t+Zj0T1YLKzgygfRGwGL7APFEA=
X-Google-Smtp-Source: AGHT+IHXDjlFObZ9vFDGfteFbnftC3KlFO8YRcwaYEsqCcw8LZ5gDJa1AEF2S+ZuNG3Sd3fqq15/0A==
X-Received: by 2002:a05:6e02:378f:b0:42d:8c18:94d3 with SMTP id
 e9e14a558f8ab-42f87419d18mr70079265ab.29.1760002226015; 
 Thu, 09 Oct 2025 02:30:26 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea300f7sm7839341173.16.2025.10.09.02.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 02:30:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v4 4/4] boot: Move preparing bootdev into a function
Date: Thu,  9 Oct 2025 03:29:55 -0600
Message-ID: <20251009092959.260121-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009092959.260121-1-sjg@chromium.org>
References: <20251009092959.260121-1-sjg@chromium.org>
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

The code at the end of iter_inc() is already somewhat tortuous. Before
making it worse, move it into a function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index de69e27bec7..b1eae28b6fd 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -178,6 +178,32 @@ static void scan_next_in_uclass(struct udevice **devp)
 	*devp = dev;
 }
 
+/**
+ * prepare_bootdev() - Get ready to use a bootdev
+ *
+ * @iter: Bootflow iterator being used
+ * @dev: UCLASS_BOOTDEV device to use
+ * @method_flags: Method flag for the bootdev
+ * Return 0 if OK, -ve if the bootdev failed to probe
+ */
+static int prepare_bootdev(struct bootflow_iter *iter, struct udevice *dev,
+			   int method_flags)
+{
+	int ret;
+
+	/*
+	 * Probe the bootdev. This does not probe any attached block device,
+	 * since they are siblings
+	 */
+	ret = device_probe(dev);
+	log_debug("probe %s %d\n", dev->name, ret);
+	if (ret)
+		return log_msg_ret("probe", ret);
+	bootflow_iter_set_dev(iter, dev, method_flags);
+
+	return 0;
+}
+
 /**
  * iter_incr() - Move to the next item (method, part, bootdev)
  *
@@ -321,18 +347,10 @@ static int iter_incr(struct bootflow_iter *iter)
 		}
 		log_debug("ret=%d, dev=%p %s\n", ret, dev,
 			  dev ? dev->name : "none");
-		if (ret) {
+		if (ret)
 			bootflow_iter_set_dev(iter, NULL, 0);
-		} else {
-			/*
-			 * Probe the bootdev. This does not probe any attached
-			 * block device, since they are siblings
-			 */
-			ret = device_probe(dev);
-			log_debug("probe %s %d\n", dev->name, ret);
-			if (!log_msg_ret("probe", ret))
-				bootflow_iter_set_dev(iter, dev, method_flags);
-		}
+		else
+			ret = prepare_bootdev(iter, dev, method_flags);
 	}
 
 	/* if there are no more bootdevs, give up */
-- 
2.43.0

