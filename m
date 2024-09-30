Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DC4CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D8F88E2D;
	Mon, 30 Sep 2024 14:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HWGxyRrg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B4288E5A; Mon, 30 Sep 2024 14:44:46 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF5088F30
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso25910345e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700283; x=1728305083; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P7Qr1NvpSFK4CMfmW1KI1czUdn/vUv6eeDSFFf91Vf0=;
 b=HWGxyRrgcTF9C5fxYddXAH6GBFPfFkDYrj4sGcZ1f2f4950z71pDUaSHNy+H8E1UrD
 alK7oESOwEgbEi4gyd/NLPQZAjs+WOpUB9Zg6r/9Ki/W8Q8hVpkrhj2BYK3DBiyAi4w2
 MNF0z7JoLby4lIaMXvBc80Ons/s8XNOthfSDb0gWzHTAGuC66cofrDbundsgpZNdqpLh
 AC8KhYkgCsDJQtyTgf7lPFbfbvtNUcjzBmYg/7BF3RgRYfGmrKGbCdnxN3V/bbxWVYkg
 Zp1E5hf5xh1JoC33VZ2eN0ZSdzPlZO++MqrZpGGbYTabu0YH9xL0g8AxguvMAkqpQh6H
 0gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700283; x=1728305083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7Qr1NvpSFK4CMfmW1KI1czUdn/vUv6eeDSFFf91Vf0=;
 b=LevnGx/p1wrZXQqbMLcp5DuPtU1bgluCnOGBrv01D5EfiJvf+O9UE+8nwLXwZNAo9j
 yExWH/Uxju7pOdoR/qVCByzad2vJt1rxii3MnGqMiNLayC5NBD1O56Ac/2CvNV4NCBwI
 whUqsyuaBVpTogAeovTMyDnxaEydf13YkjU6WqF0BYcazM/OpFLT5zxN6dcpi1CDLoU5
 YrMBy5CA+m2LJt4pNiqFuTP4EWg7s7ffFM0UMxgUdH7K+jgpVVoSlLtbNPGKKMhCfFUn
 h+OpXgDtVNKBgVyY5WmFGyfYApNJRuuDd915RNBTRuHli7tJYDw7Fzx0H7lUpoG3/h/g
 x4nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/PXFvwl/JCXI7XjnItfQasWaZikdT4AVBHUiijp+WsUZDUNuABDjYqVBn1V0IqDaS6WesElk=@lists.denx.de
X-Gm-Message-State: AOJu0YzmIFVuzZwEaix/7GV46H3fnpqzxqZR+ziZFMNJJ3NeHq43GwyB
 VENuv2gyHYfTJP1TopAD4mukXyhORoRjvKWXuUssGedzeiMHPNscq+M3VSf9hak=
X-Google-Smtp-Source: AGHT+IHrOm0yPSNHzr94KDto6uK7S8heURn9fV74EpAgcYLEZLHH/bxbGErEbgZEn09koedFhZlYjQ==
X-Received: by 2002:a05:600c:3b87:b0:42c:ae4e:a96c with SMTP id
 5b1f17b1804b1-42f57fd275bmr72153005e9.16.1727700283493; 
 Mon, 30 Sep 2024 05:44:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:43 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Mon, 30 Sep 2024 14:44:33 +0200
Subject: [PATCH v3 11/13] ufs: Fix debug message in 'ufs_start'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-11-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=714;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/e+BvndSe0yhkT9enKL8SNJ/+EUFBp5cMPXLsBJleUc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0srZNmpJg8Vyc5K+5r1yyhisseIRqlu90hq1L2
 Ah1uXr6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdLAAKCRB33NvayMhJ0XTfD/
 0QgV11YWu6f0A+r5bJgXwXrBqAM1Wyhe+JphUYf3qFM6N3NjffRLg/ZX2scrOZJuuph0LLXMckQqZc
 jBb/piMYQpzI8b6GdaSizfkPdRHrKaUOXnlWoLg+uiRLQ4Smx79H4/uWPQj23wb7nFIlpMaFT9SsZ1
 yCbw6kBUjtz8zI06lLj/VvhZE0jwO4qJnwZj5TNgUPTQ+VodiBBNlonFlqIn90tlp0ZGomcaE37hWx
 FwPp6MypGbwdkdwqX/QFUCUBG36o6eyJpBxpgwa3+afT3N2+DQYE7DRGO/0XOqbrJWXTNJAtLT/SSc
 WHQi8+XEcdODj+CVrBREEzHNBt7WtZLVPA+S1i8Qg7qz4ncGTBDmF5GfeJTF3E7LiR+s5J/CLzDCN/
 uhw5g7ekOPd5fOIr1ZnY763PxPnXGZ/MbbJULg8a9HADyjebOuEZSrbfAvJ3wKz8LwVNA2sinoMX8a
 utu8rsOnBYKpa2JEAnSxGNgBJkb4crnCnjx4QmKOM8jCPlle0dNTufZ0D4MIjyWIGxgKRjUaTvVW0L
 VNOdzxJG+rHmO5FoI7UIbHbOsw6B90CqMB28ALldkOin5qbWVKKHw395igeihFTbEU1XN9myqQDYEU
 APEUvvIEaSNT5bIFCH516mVturqsu8lJE+fF2TM0LHXsi3P5ndFrn+zoZC2A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Minor typo fix and rewording of printf message
inside 'ufs_start' which announces the availability
of the UFS device.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 5d4e5424358..d2df5c26f76 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1925,7 +1925,7 @@ int ufs_start(struct ufs_hba *hba)
 			return ret;
 		}
 
-		printf("Device at %s up at:", hba->dev->name);
+		debug("UFS Device %s is up!\n", hba->dev->name);
 		ufshcd_print_pwr_info(hba);
 	}
 

-- 
2.34.1

