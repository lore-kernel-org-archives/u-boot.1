Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4599C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1AFD8295C;
	Thu,  1 May 2025 15:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CRI9FIsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E0B82905; Thu,  1 May 2025 15:38:05 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3C3C826AD
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d7f4cb7636so3215385ab.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106681; x=1746711481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ub/aVwQFfAro6UHw0XlVYhyaipXlsOsTvYpib8oR5HY=;
 b=CRI9FIswSWzsvrnEEJlDupEuYtxcL/e5nNRaSHXxhh1KZ62F70XS4s7FycDzOYDRJi
 oD/eGdU3S2hsmvqkzhg8r0gW8wvG9eQ7bgvRuB3RiLkMSDwE/QW1kzpbXIB2ByyGrap7
 klBR8aXo/1ez/Olp+6bxJQewKjg1Mo63Zyvls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106681; x=1746711481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ub/aVwQFfAro6UHw0XlVYhyaipXlsOsTvYpib8oR5HY=;
 b=ZSsnoEat/vkJYsDh3iCnQXmJaKhFuWF/8EfGohmtTrHVPgLnp0oYohGT8ugVcPGg9P
 HZoV1KWmdg/eQyWwrR7ENuIhlThB1SsX/4GWQIKLLyaVY2BVOVw01Die9Igj8Xpac+u5
 FTDGIg3VdtA60PXBQ/nHnpoHopuGFjXaMA4NgsWV+a/S/e+S0mm0PNn1FgFo5hnaCgrB
 WvVAnKESY6lHQW64/dmgvYE1x5pRl/jQpjjH5zjxaNCkfWMEj/nasJqe2XugruV8vl5+
 VKGZzOOXzrji9CUOz1NYMK8vrKJDftGQQck0qP1QSRCd+yihH2Q01i7T7PcJdzBr4Q2+
 0Hhg==
X-Gm-Message-State: AOJu0Yyme+u3s1/047Y6q2VcZ4cHhNxoA+gcLAZsm42VQsRqh8XBytST
 hpe291BkKxYyHmN4G0vQ8K+lLfidxBcH9WIKlz2/1LhOBlBNhlNiiWa8yDaJKDOioP0VXTZvH8E
 =
X-Gm-Gg: ASbGncsFSTBxHZ+ktCsLSEt/W0u+P8GTyfv4VfynWEQHK8UaMdtBpXKYvol/G/5aPVm
 3lH32qujR39btHa4GCqpNaoYhlU38udMFD636pLZSAb+kGpPrrUq1prPcdDN2cR5AoSfXzYyNrE
 bBZusXZZJJxsxbSY/krYk9LXWhSoFzNkvLHgWvf2hbVAml4lE2JaflDMreZkMsFJtI+I23GrYmI
 GUa8LD7JXL4ZP2eanGVIL+ri7o7M8gmyXohqM+/Lw8b/hQ3QVHcJLXP3475HBk4oB7PJZ7T1Obm
 K/Qns5PK+FWgaFVSn/f20hlQ3B04eW3xShscWE9aqf3HhksON8RPPByRadoxxzjlfXVGr0j6733
 roQ==
X-Google-Smtp-Source: AGHT+IEmqNZPE90bRE72LKhSNQ7te/1A7wee8NndURNO4f+zOy3GKUZ7A9eVLoeZPs9GcZGndwmKnQ==
X-Received: by 2002:a05:6e02:b2d:b0:3d6:d18b:868c with SMTP id
 e9e14a558f8ab-3d96f1b2c0dmr34987025ab.10.1746106681075; 
 Thu, 01 May 2025 06:38:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:38:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/18] bootstd: Mention FS state in bootmeth_read_bootflow()
Date: Thu,  1 May 2025 07:37:18 -0600
Message-ID: <20250501133726.2627373-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

Add a comment to help implementers deal with the need for calling
fs_set_blk_dev_with_part()

Signed-off-by: Simon Glass <sjg@chromium.org>

---

Changes in v2:
- Rebase on top of recent FS changes

 include/bootmeth.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/bootmeth.h b/include/bootmeth.h
index 8f4706c555c..d25718d9a14 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -213,6 +213,9 @@ int bootmeth_check(struct udevice *dev, struct bootflow_iter *iter);
 /**
  * bootmeth_read_bootflow() - set up a bootflow for a device
  *
+ * On entry fs_set_blk_dev_with_part() has been called so it should be possible
+ * to read the file without calling that again.
+ *
  * @dev:	Bootmethod device to check
  * @bflow:	On entry, provides dev, hwpart, part and method.
  *	Returns updated bootflow if found
-- 
2.43.0

