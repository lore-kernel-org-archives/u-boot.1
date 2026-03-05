Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7E0EEF31C
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FAC83FC1;
	Thu,  5 Mar 2026 09:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SylJRm/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7A383FB5; Thu,  5 Mar 2026 09:49:26 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D090B83FAA
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso543972f8f.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 00:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772700564; x=1773305364;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yU0IhtiE5SdT3b0e+WiUHkJgsHBG/DzDdu31HrhiRTQ=;
 b=SylJRm/Y+GWoaF10wcC8ObN5JJO0P5OUQgBQCKXGZXI9EWOz+XZNQmDjg0UTwu0MK1
 MWs3fgKSt2cG/g74MyNwpdg1Efv05E4YMrQto/sUf+/l9X/JYjfQ5wcFEMBMKnfPPyH9
 3o/NVTOUhJ3udPOM+27fu+iB9Z7fO0NAf3M3jAWpS8wx+TwPEofvdS9kpMasF+9kn6xY
 zXU15Eg+reCGdlp7N9e77YYnTvsmeodjq1t6IyPbb/YiNggTQdnLGT3HBzN1LdjcpUpA
 eiAphQTPAmED1H41NfIHyK+hiCquBowPZELJk7+UMsTxhtRZUyloXy8QU1eHL3v3qOL2
 chsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772700564; x=1773305364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yU0IhtiE5SdT3b0e+WiUHkJgsHBG/DzDdu31HrhiRTQ=;
 b=J100v1puPZ6kgASgubk4ne45Edkbx/pmKi9mvw5dgTt7oaFqIBNU3rl6I5SlsipAnp
 wOFcKS7fGfDNQhwW3eoIWL0FvCpnLnVVd/JdZari8eIR8gsGRNna1U7+rHkYvjfbL88q
 JcHEnuKu//PHMbmcl/0pPPvdcAQXruLLq2i2aK3veLNgJG1ZQcqVZyn1OISSCkwvvtab
 QK3ZRINwUezpY5kvCluNQi9g2vXLLrn2v44Acwm0w6RTK4XN1ikTqXgzP728qBWFQyes
 pA/2UOIQ1OxR0F1bWjhyVJQ9GZwvu423BmRgxqm8XCqk4tcXWYn4yxKLH4t0DPjRN+ti
 8esg==
X-Gm-Message-State: AOJu0Yw0zkvH3oyGO4ImJVexeoLvkKUkDwXYkO6xZ1eHiYI9k89qBKhc
 323ofQT5iHABFHil3FR1ob/jazKui+RKeu9Y9HUOxmlsBZ+T5VDoSQopI/YBy1UGNj8=
X-Gm-Gg: ATEYQzzFASe5kdVnTwrguLfx4OziOsOFlvlGH76+TJ3Lg9NQTQQ3YLLgkU8ib15Z7vv
 CzLe9143UfG2JibFLJBvGrAv7bLaiS6lu2j5pyUWhWLUM+rlKdZgu4Xy1mvqKlMm6/9le8vWRSb
 TDGUwUmJqHMrA8KxOcqL+QhdL+Zd8cRJFJg0iD7hq6a8be8pUKMEhnpPFCMZ39Gjuo9Hpc0N1B9
 DEn89Ebyvj0CAU/FY1TzpWZr6wmBRm8t+Lgc7+k/kgnUO/7S9Xb0P45gTW68hsJ1gZ0UvinHtGH
 Jstxxk/IrUVRNd5ML0EJxJFHnz7Utvw8dHI/PdAVdLUqW3hRobw2vJywvhrAV1V2rSJMCIIM6al
 zk65y0SQBkR2wSRfE1lOc64kFntEM9Hq+wSkHbNo3GrEHtZpwoAz9aASfDXAt7Dfe/EMTQQ6qJw
 RQ5UaUd9RY8pdCdlsiRlxijI38cHvhCmjL3e0TvkZr1lYdVxMZsR7wcY5qK72wFtAwMdxBQIuH9
 6bbBjFI7NhKr6X6wK7prg==
X-Received: by 2002:a5d:5c8a:0:b0:439:b1be:819f with SMTP id
 ffacd0b85a97d-439c7f650d2mr9498958f8f.2.1772700564242; 
 Thu, 05 Mar 2026 00:49:24 -0800 (PST)
Received: from [192.168.1.64]
 (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net.
 [2a02:8428:e55b:1101:1e41:304e:170b:482f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b03db76bsm33638231f8f.18.2026.03.05.00.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 00:49:24 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 05 Mar 2026 09:49:04 +0100
Subject: [PATCH v3 3/3] drivers: ufs: fix typo in struct ufs_dev_cmd kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ufs-ufs_hba_ops-cleanup-v3-3-e153ffab98f5@baylibre.com>
References: <20260305-ufs-ufs_hba_ops-cleanup-v3-0-e153ffab98f5@baylibre.com>
In-Reply-To: <20260305-ufs-ufs_hba_ops-cleanup-v3-0-e153ffab98f5@baylibre.com>
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

