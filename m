Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC2F8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C3288420C;
	Thu, 16 Apr 2026 11:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="HVvZ7r4Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0BC84222; Thu, 16 Apr 2026 11:40:05 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08602841F2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so3113385a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332401; x=1776937201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEmWssM6LxuwXJOYTSij/mrP+oyQDGN1Lria0cbDQhU=;
 b=HVvZ7r4ZghAT5o8pdJnusWa+ChWXv9/I5hR1XLg0v1+kKEF4kZ4j8HUdn6UKJzfhHJ
 n2f0Y0aCJkLGw3IRTdbm9fGBDc1rVnYzX64R5tBznRP9yDDo4p/+Rfsx/Rf+Di16l1TX
 gWDYSeAl9arSmcfkazolr/R+ohKU8Wqj5p0TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332401; x=1776937201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dEmWssM6LxuwXJOYTSij/mrP+oyQDGN1Lria0cbDQhU=;
 b=UXpq+VPMupuUGjzcXSIv7NGU+OKYX9gMccFs8klw+X5Z/s8pDWi8bLHFGAyQqawsWj
 q2ElvxAvq5WYlm/aErxWi/EemJPkhWdiKC2LAQxU1tJ0QNqArJbR9BUBvUqLO3AfiGDZ
 REaDHIu72DFWoJN/tCJ+KTGrFECN+IMX/R/13MuH08UaelYXJ8G6bS2kNuiKgjy/PanO
 +NwP/ABSkmPegGjEXKvR45S3cPF7EhQyRn9FE7f2+zt4JS1cfaEyd8yN1ks7quiPJ85u
 ow8zS4NGUFqZ3nHdPcu8ZgMXlWwqefpB4hPmokrFbpFBabNEhHZzeNGRiHK7ECzSBRqx
 7Qpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fLLpnqnPr0lsq9KYyxLxWS8rlQObqbWpOkqFptEftnK0IdwPyCcOo+NbVTcoPsps2tSmeMMU=@lists.denx.de
X-Gm-Message-State: AOJu0YxwHQAnnJPhofkKTUt3+4DpuBBo/ArNfmhVXelB//jWiyVklE45
 sVMGpdojjt7txFz+K62rbrAiYDZNS5r1Evp4qRMydlM51RmEp7yZEHgjUytioda29NM=
X-Gm-Gg: AeBDietjjLHrIYLrij6QV1w/YORBkcH0YGDnoQpD3xmyYuZ/6tzfjmXed5ngQfbDtnV
 il0hLFtv5UY6oCdXG0lLls9wtqQjm/+CPTcjspbN17rjwMw/yBRqS5wWOR9XWweSnYj+zBTSWko
 KHHnfhIYOjMMHAbKnvHNKuF7A06ij11xNpF/uLmW9gBOBZi9gH0vyZuvOgeUUz86zK5ArYjISf1
 pPEjtoXJIALUEAYuLf0+VDhmwjgR5B2JDPU/1lxRpVRRVdYd0HGsu7K52E2B8mtnw5k6hlyrMuR
 uKg+Auv1dnKr+4OYIZ9fc/52l7ooxr6rJCokSFJJkt0jpKjBUzDNk/UxkJVbV/yIuKw/BjV8DZL
 f/WZVcDZLBeu/dL0OYzE3qq7SiXnvE/GtZPKko6xnWpTa40xATcuXDaD9fajDUkrGymvQqxfInd
 XbnVpqboQASGsWUMbQHnH0YYRe4aC3w/1V/SEKCy6UlSmhDiUe/sJB1mLencN8TAA+IIWIJ8zVP
 PmQB6DEhHsZwg==
X-Received: by 2002:a05:6a20:3954:b0:394:3001:8b59 with SMTP id
 adf61e73a8af0-39fe409d626mr28161393637.53.1776332401156; 
 Thu, 16 Apr 2026 02:40:01 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:00 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 1/8] sysreset: qemu virt: Use __raw_writel()
Date: Thu, 16 Apr 2026 18:39:20 +0900
Message-ID: <20260416093927.602613-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
References: <20260416093927.602613-1-daniel@thingy.jp>
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

The virt ctrl register seems to be native endian, currently this driver
uses writel(), which works by luck because its currently broken on m68k.

Use __raw_writel() instead to avoid breaking this driver when the
endianness of writel() is fixed.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_qemu_virt_ctrl.c b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
index e7cacc9b6e98..5ab16001922b 100644
--- a/drivers/sysreset/sysreset_qemu_virt_ctrl.c
+++ b/drivers/sysreset/sysreset_qemu_virt_ctrl.c
@@ -38,7 +38,7 @@ static int qemu_virt_ctrl_request(struct udevice *dev, enum sysreset_t type)
 		return -EPROTONOSUPPORT;
 	}
 
-	writel(val, plat->reg + VIRT_CTRL_REG_CMD);
+	__raw_writel(val, plat->reg + VIRT_CTRL_REG_CMD);
 
 	return -EINPROGRESS;
 }
-- 
2.51.0

