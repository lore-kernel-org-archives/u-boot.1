Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E336CD98F0
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 22:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D66484671;
	Fri, 19 Jun 2026 00:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MQBmKYvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84FBF8499C; Fri, 19 Jun 2026 00:37:09 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643508005D
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 00:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-69e1eae4eb4so1321525eaf.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781822226; x=1782427026; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeKeQgjBGE4JR7gD6JHvs/CpjgJvj/ECeKBmLQQ7T8U=;
 b=MQBmKYvcWPtUgpoUrfU6t4B2PtrJGrol3qaQ5iKGbLa9vCNfbk0m8BLPFDwguV1ESn
 Xk+dgZyksGhMe1/l2zqIShG3Rn0SAc5nGVAc6YcoCQ8T8o1nrKh1mlco7tykrn11iM/p
 D/lyCbRiX/EzSyv1uduSid1ODuZNSPe1hmF2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781822226; x=1782427026;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GeKeQgjBGE4JR7gD6JHvs/CpjgJvj/ECeKBmLQQ7T8U=;
 b=gdAiRBk7Fe3NZQHEhZDndgW5VZKYtONKa4VebaU9VUq55amtt6SE/LNjVZy51LOIo9
 wmaAfPOD4nRH/vRg+CcgqRa3ujO4w84NnrA6FZPPdt9eUqFAB9Ah2btlwQQGVej3METm
 j+nCVc0WCdJkdJTAX15hUlJao4SvHOv5xhdAM5879PBqVTBjONLSvcZIamKgeOEAe17J
 DhgaUql5sdp1oJqOhhCMo7pc2K7MQtwbCJHTSoDq/cZJ1E80nahGilDxn1Kx6dwmIaOq
 MyzbroS78QYm4nNU9p7tJMt2dmh17/cVn5RGqMjJEREw34dL3tmbObmdPhS11iqK6P6X
 Mplw==
X-Gm-Message-State: AOJu0Yxy3hvC8Kj0TbaPmPKPUb+SL/wNNzNyNDbEb6fXvH8AgI5q30iT
 31x/vrT96JJZ7R6I6fwEYUKxbMnlOFNHRngRm6CTe0XbLbKLxzv1PzoKmqDNDULLseI=
X-Gm-Gg: AfdE7cmbZ2bILE4POAIXXitQibt5P46UXDDD+bI/sbQIDyJQBLY62xyuExRMmM2dLhN
 xp5eQ6fo4h3fRPiGd0mMRpwi0paBZsrn//LtjWJzX1noWy0/K+zAJL5y/Q062KC7FfQSSz5tLDf
 HE9TuA/7+aDt+rlMlf2Wy0kCsXpsqX/saUucEg2CDxcQHk9kLDNHLytb8g2rG9kaCpLLuYwUqxw
 9C/AlpqjEZs/s804PdYSHKPeDaa2norot7AcVOQKSrz5xS272jho2RoUtI1njZ/WB8aO+BE71q6
 ZhYQOudzOmipK0ZwPCLzuwUlHFNcM5HRiqSH1i48HJo8m5EffggYD8e26nzxcSmwnVjOZBAdWb+
 MxPXGyRg03O44nhEmOYTD5LOXkM2RNX5O74RXi5j/RSsgsWRQVpYj5F4JfLxKtRQvkFd4LZpE/D
 eQ9B2O8kjIs0jk59I3TsRJZDhBLdQ30+v+/yRvtrRPu9pdjPGZrkspkUNENngi2namrtgI/sl8o
 c5kUn2Keaxuakps7Ay3mSAYNNFL/5SkBoayjz0=
X-Received: by 2002:a05:6820:f029:b0:69e:4345:ce4 with SMTP id
 006d021491bc7-6a0dde8c338mr139512eaf.2.1781822226157; 
 Thu, 18 Jun 2026 15:37:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-189-154-245.totalplay.net.
 [187.189.154.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44709d2ee07sm700520fac.7.2026.06.18.15.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 15:37:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: marek.vasut+renesas@mailbox.org, u-kumar1@ti.com, peng.fan@nxp.com
In-Reply-To: <20260603061946.3078750-1-w.egorov@phytec.de>
References: <20260603061946.3078750-1-w.egorov@phytec.de>
Subject: Re: [PATCH] configs: phycore_am62x_a53_defconfig: Enable fastboot
Message-Id: <178182222498.2736082.15646057013444703738.b4-ty@konsulko.com>
Date: Thu, 18 Jun 2026 16:37:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Wed, 03 Jun 2026 08:19:46 +0200, Wadim Egorov wrote:

> Enable USB fastboot support for downloading and flashing images via
> the fastboot protocol.
> 
> 

Applied to u-boot/master, thanks!

[1/1] configs: phycore_am62x_a53_defconfig: Enable fastboot
      commit: fae363f2cff9ffc258afee3801184879899c5767
-- 
Tom


