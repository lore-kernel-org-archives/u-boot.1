Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A265EF0704
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 16:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B9BE83D17;
	Tue, 10 Feb 2026 17:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w2vqrCR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 100EE83DE4; Tue, 10 Feb 2026 17:22:55 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B21383CE3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 17:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-436e8758b91so1587628f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770740572; x=1771345372;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yU0IhtiE5SdT3b0e+WiUHkJgsHBG/DzDdu31HrhiRTQ=;
 b=w2vqrCR5NyFM8bEsZf9QUJrtTYiDEbXSsv0vmc1pzEldoBbrjhh/OXGitOImg/+/oK
 XuHwH/T6cBWT5isstBqMtC+NuRJUQX6n5lGu6LsfAl6nQ8v9dNZm6pTKa89gjLiYU8vG
 yhAxh6dkEbjPAx60HlBgT/dlf/8pzvxl5reRwCDd4uo4tqt5exveP63KectHuVRigl0F
 oZNoY2rmKvneolm2lAn2w7RrVBX2zD8aEmorm35xSMeKU0xP3C39fIiKCO6SZgguQXMm
 B3tJKM9smUMuM1GiM3R0mBifRfQamMaalPK8A6LZzz2xwF8PRhV4qdY/9hWRkVV7GNgD
 sIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770740572; x=1771345372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yU0IhtiE5SdT3b0e+WiUHkJgsHBG/DzDdu31HrhiRTQ=;
 b=DFApPeLcZPCUmtTTvvO7jcNYzdapU3fw6QhHkuJZ6aFoGEoOzkqvq60O/hxz+p0MJ6
 3w/yfwXYhFgV4065uLUTWsy6TrRgD7IFau4tkI8cQI/0o87AQUCqLfUnVdkfGEu4FsBG
 l1n9ZgKVbVZnUsUCsT398wQXHB++tNkUGR/o6IeYsC3tOCMZeMSMYwFTlRWbMS4vGdFm
 dKd3ldJIX049z5nSRjazmGY92sWvV2krs3ufIIgWTNFuH4XwLKbuimRZNQYxyXF+ONPv
 56haoJzk22agJUdn4O/aCcMaRAveh86likdBPMxT4QsBWO7RIEioIjkfJvsajkZzK+aN
 TivA==
X-Gm-Message-State: AOJu0YxGiGuX9X9mSRar5anLrMCRNogBkhiCRidFIw+1Kr4nZo6uYCCQ
 DdANI6UCbZsfk93rMgRTrI32gWlvK66OxzPPr34SVjpvfsJ0GEk0kPusyCOVsfFGerE=
X-Gm-Gg: AZuq6aJ8zA7QtPqNk41dey87dxHtZmhJaldKOdIGDmO+1ViTt+vWiK7bJzBMnM5bIAg
 wZadwni2Zmtyl8l22xlkcKRujHFrGHr6CzWStjwGXmbeGa7dvwyXgmRJhXYR6EXI9FAm2TgpeR/
 jiNvQe6pE+ZU8WfPrj8ASzXqw4oic3frVNdAC4p6l0GHusMoxLP3u9A2lQRVYsEbTObqwtkPIVe
 YijYw0qSwMKApJlj/jVFj0BJwlfTA30B2JETQKZcybeThwlMZb5iiBJacyL3EKK8Cxi7xtc0u5I
 8oihn9krL/5SzRH9Mz4C34fBVTai3vm1qgdEP7CmncE33WB+hRPp4rt2pKEEVa0tFLELovjQXHx
 5FhRN2iNbDh9Zls/c6qUZuqsSqC3S4crM0dLmanG9HDhf7Jy/rzLVU+ilxMEhxImdSe7bsqu9eF
 UjSOnGBXk+XmaDzrFj0WUAeK6j/hDs/kJPq1r8E7GqcTkZtUBoKcbnPVj6iL74qzOmqcJmkUMdD
 a0sCfG8Pwlaf2eh+iDojg==
X-Received: by 2002:a05:6000:2386:b0:435:8aa1:ff4d with SMTP id
 ffacd0b85a97d-43629378587mr26588059f8f.22.1770740572624; 
 Tue, 10 Feb 2026 08:22:52 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-43a2-d2f0-c793-0a1b.rev.sfr.net.
 [2a02:842a:d52e:6101:43a2:d2f0:c793:a1b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd4a1sm35185402f8f.17.2026.02.10.08.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 08:22:52 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 10 Feb 2026 17:22:45 +0100
Subject: [PATCH v2 3/3] drivers: ufs: fix typo in struct ufs_dev_cmd kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ufs-ufs_hba_ops-cleanup-v2-3-dd73da21aa92@baylibre.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Fix "associated" typo in struct ufs_dev_cmd kernel-doc.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/ufs/ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 74125b1ab31..0f6c93fbce7 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -509,7 +509,7 @@ struct ufs_query {
 };
 
 /**
- * struct ufs_dev_cmd - all assosiated fields with device management commands
+ * struct ufs_dev_cmd - all associated fields with device management commands
  * @type: device management command type - Query, NOP OUT
  * @tag_wq: wait queue until free command slot is available
  */

-- 
2.52.0

