Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2411CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1E1848B0;
	Thu, 28 May 2026 19:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y0eTZPRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF79E8488D; Thu, 28 May 2026 19:11:34 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D738341A
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4854166e1efso7009230b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988291; x=1780593091; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F76mrup00qB6mupSLQKK1CUfXremrVJF8hyT8x0wIMw=;
 b=Y0eTZPRfKNz+7fOx8Cr+/aa1dBt5kgE5BWEdwHMZMnh8vxoJdjiwG7GI3erHqZ6Q9L
 vu5Oy0btLUCY1h3Go3UYrC50z6s/wpcT5T/Mq9sYo9Y9CzktObCGy7wO29jsK5tPtgwd
 hYN/RFtPYGyOpDa6mf+qKuBtOVYuNyTFwZCDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988291; x=1780593091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F76mrup00qB6mupSLQKK1CUfXremrVJF8hyT8x0wIMw=;
 b=qpehlPCPkYgAkNLqz0C2BwMMKnGPagCCU5V6TjVSFBOTqj0hVnd2a1xqqIMwaJWFSo
 pgsrjvp3exe75AfuJ7lFNihKonMrwPa79mDUgFs1696Lsuahb+vTO5/AY+qpyrPDbaAh
 amEYeKUFaDrLTHoRN5NPUHL0HA/vtALA3436d04h7B2fry5Hp1rfW98cFM5bfo/Oy3QC
 X7CUDWUgmk+w6Tik8CPwenot9N0FrUgzuKTioF9RBcIt/JsDNvzNajvMCDCbHxVMRLC9
 E4FSRq5BUftUspe2PEFhtZtBn5Ikm4jHQZDaZnqc3uwC/UeqfHkelINx0DIuGKYN1h2G
 2U7Q==
X-Gm-Message-State: AOJu0YwwNt9BRfumpJjPqBGZkQ7wEJMkL7Qjx11wGZDEZLXfxT5GxMtp
 8cAHZQWbuMosW6lQAN57NNILcsiG8tyiIpn2rAyJPlLgg37a1LpgLtysGHI6kQmgz3uPu8oB59T
 iJ3PW4k6iyYM=
X-Gm-Gg: Acq92OENqvK8tJqZm4czvUsneL19hEJo2T/2SCikX5hJCAH/0OW53FayvoFGpqgDmf2
 bpqRaqoGZLzMLUq+tmRX23u6r5p5KdzkiSueZUMxU4c6F9FTa58TJvXbWwfmkkKoquFK5aiilE+
 ck3+8mQrjwOkZe/TnDtnI1uzKgLfc1+4GzNu4tXSAvbLZMvDq8nvl7ffvzZGRkwDg72RSiZrdUg
 B25NwodDGKs2ykg83Zv5YoyqwMlotDHHdM1BZUpZ0gKJFLW///c/Hi2ee4v+cIeZUGysG+VhdWe
 BwW3STJt60bl0heAUFzpkudSdCRgQEIbq1ZNLfe19rn92vsg1dhmajALzEPVHfbIp42fAGlbR5g
 i1YQVJoBPiFdMTpeJf/OSk6nKS4wptkHuiNjnwey0cpOGDma68LiQGomM6ziVQZUbxuNAeyO66r
 1Zl2vFdR2ptC28TxNZcZe1jqcqfo5i
X-Received: by 2002:a05:6808:c2a2:b0:46a:869c:b576 with SMTP id
 5614622812f47-485e3ca67a5mr65840b6e.2.1779988291380; 
 Thu, 28 May 2026 10:11:31 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 15/22] rockchip: rk3399: Adjust TPL stack to allow for
 bloblist
Date: Thu, 28 May 2026 11:10:22 -0600
Message-ID: <20260528171043.910264-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

Reduce the TPL value a little to allow for a 256-byte bloblist to be
safely located above the stack in all phases.

Note that for most boards, SDRAM init happens in TPL so the SPL stack
ends up in DRAM, at address CONFIG_SPL_STACK_R_ADDR.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v5)

Changes in v5:
- Reword first paragraph to mention bloblist instead of other stacks

Changes in v2:
- Reword commit to mention comments from Jonas

 arch/arm/mach-rockchip/rk3399/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index e2f235066e4..fcf87ca0e28 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -145,7 +145,7 @@ config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
 config TPL_STACK
-        default 0xff8effff
+	default 0xff8eff00
 
 config TPL_TEXT_BASE
         default 0xff8c2000
-- 
2.43.0

