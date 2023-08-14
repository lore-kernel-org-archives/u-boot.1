Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A30C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33764869C0;
	Mon, 14 Aug 2023 23:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n2Qvonmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EED68698D; Mon, 14 Aug 2023 23:56:01 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B1486989
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso29440115ad.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050157; x=1692654957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Zil+xbKaA3+/E6r1SpmN8Ezd/5bANdyX0ywHxSKlao=;
 b=n2QvonmircxlG/616rAIFomHcTW6geP+YsUK2VUZc0Z9RImgqhdnirUixkNsZtvhy/
 BaN4cIGD4szacTEIAGQzwTjTbfJ/z0Bavu0gJWR8kA2Cm/FO9ziBVrOdPu+RxqjiFg9h
 72B7p9YDS1Ki7zebBsWJBxkzqHHIo0B8oxVYiWxFMq/EKl/GiLyDmkML3mbVZGozIxjE
 iZ04SDKXENohE4Ee5ILjxDuCUEqUlAq0/zVK5cGHX2RIKvPBLatNiI71D8tG1/Dz/uQb
 GFKi2wV2Dwbzux9siH8z0Uk2EhJm40U6BuKc8MFejfKtJxzg3w6PyJVuKcxo4GSoo2I3
 ydkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050157; x=1692654957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Zil+xbKaA3+/E6r1SpmN8Ezd/5bANdyX0ywHxSKlao=;
 b=Iq5LU7EVFDyWzSHef6IxnFB5840w7MDaWIH+h4WJJS6s6JYESC4cU4rFBW+Fm8G2a0
 1UP/YXL/bP2OYVxn1fWbMSkeq/t98Yb561yPHO2zHlG24rrFDAmOsUIr9wQf0wXMc+iI
 1/X0h+ZSYCMleRqREsmPn+LzLiP5MFUxnmprG4/b9z+E9UbiZ3uxDG635Yx8qotAuAYx
 zEbox1MYe43r4aeagH90rDQ5AHKlK8jXm684sXRewURNX/DhJPD4yy4P+AcID7HTRC9K
 05VjjXG76FIRwWZ6nexI/u378Ynmw7vUnuKVKbFlHDZ8kUZ43S5XXeU5vH52peCNaea+
 NdhA==
X-Gm-Message-State: AOJu0YysFMCTI6ZN+8w0aU8ipBa3+LCT1uyA8UaZZKEdpSFPTFDp1okg
 DtyL+o0pKen5lcY4EQDPHNkdPVeMWgAgbZMnQlo=
X-Google-Smtp-Source: AGHT+IGM6KzYUQgs/bZXz09/dHMFH77PVvMBcLpB4lV0wsReRwzHKxiWGkMo5F2mEuSzcjh5xTTkpg==
X-Received: by 2002:a17:902:740c:b0:1bd:cd6e:dc7 with SMTP id
 g12-20020a170902740c00b001bdcd6e0dc7mr6450473pll.43.1692050157279; 
 Mon, 14 Aug 2023 14:55:57 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:56 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 11/17] ufs: Fix debug message in 'ufs_start'
Date: Tue, 15 Aug 2023 03:24:51 +0530
Message-Id: <20230814215457.4075025-12-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Minor typo fix and rewording of printf message
inside 'ufs_start' which announces the availability
of the UFS device.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index a97c45a530..8e507e8378 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1937,7 +1937,7 @@ int ufs_start(struct ufs_hba *hba)
 			return ret;
 		}
 
-		printf("Device at %s up at:", hba->dev->name);
+		printf("UFS Device %s is up!\n", hba->dev->name);
 		ufshcd_print_pwr_info(hba);
 	}
 
-- 
2.38.1

