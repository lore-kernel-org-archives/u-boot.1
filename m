Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67275CF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AC2893E5;
	Fri, 20 Sep 2024 10:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R+VhYfrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9C989430; Fri, 20 Sep 2024 10:00:47 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC9489420
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3780c8d689aso1122141f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819243; x=1727424043; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P7Qr1NvpSFK4CMfmW1KI1czUdn/vUv6eeDSFFf91Vf0=;
 b=R+VhYfrXT6JGKwI3mRFkYPJIQq2cDkWAaM9OmbKcxNjBA/ZRV/i1KC7uJcsowIz00F
 VQmNzL7cZVS1n8eoGw0Wh/Sf8InR8IgqvPbGxsUnN1n49mof812fhEJwwGzYdKK8KC0S
 Rbf115bQMpD8AZb0zYeRkcUiVyxKgoXEY3gBw1O277HlW+Mz9JL5CX4J9tKfIEnV/s7E
 m9kjFxFMpZrcwohA+ofU/JAp6Chu39kRuypC1I/CZKhyVxYmH1rTXBpGYh+gOUPecQZN
 1V7fW6gZcMxL6eMbaSkzTeWvUc7b94dsmtuu/kP/mCHhtQpVcrhOtKewfT7zS3EZUaft
 P1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819243; x=1727424043;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7Qr1NvpSFK4CMfmW1KI1czUdn/vUv6eeDSFFf91Vf0=;
 b=te4H585VDy4Ky8rxL9NaLikPE+J6J8BI/7V46mmFeO+Qv+rZHBiGsUyVR8RrkJiG/5
 BOQcxUPJVpq9QDEz+W0IVNQafLLYhQjsLoh3dlX+0dlXCnb+GUUZ/a6y1pWpmz308S+/
 VMWH/Vsm/6/IsEfRZjbqg7Qn393H6cCJqLR5TnBbbMwsDFGrOZ6SeyuhEe9+zfW0qkqb
 ZeyZNESEsKR86QBD8jA3ibx833+2yJt+8+u9opbAYXuHrSxiRi80iseiEGhjz9KKeEMf
 lsN4KTelIvceItlZnAXehox1djsfQr8p3CibPuNXcWQErPREOfwoG59JZ4EmFg6dJjob
 iGaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLYHnuemOIunqMSsy83qpys0lsykqKKrH+h5N8zB0TbgW9HNHtq6QrZVbnb/y5Gflb0mQOuMc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh/XG2j2cY/ZURdZnokbRxRVB+OwNNiMFmyEjcPocg08XaP7di
 h+m/scP/aL+DGT8K1BCTEr/2AEUt66fjqngdjdP3MUVqtQD0ywTw3BF/0UuV6Vw=
X-Google-Smtp-Source: AGHT+IEbn095IUoy7FBN+M3hyUp0A7Aj8LhzJqD5tQ91rLa1xN5kjWBPw1suVzTbJwWFbPD4uBD2HQ==
X-Received: by 2002:a5d:4f11:0:b0:37a:33d5:91a8 with SMTP id
 ffacd0b85a97d-37a4318a40emr915144f8f.40.1726819242780; 
 Fri, 20 Sep 2024 01:00:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:42 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 20 Sep 2024 10:00:32 +0200
Subject: [PATCH v2 11/13] ufs: Fix debug message in 'ufs_start'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-11-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SudEiqDuF+S2LZ91DOYzQEt7bet9jL7d3eRKYwx
 JS0HH0CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rnQAKCRB33NvayMhJ0RHAD/
 0Q0j8vdohh1UthjnYGZS0eVQig4ei3+FCpJ3pUvYUIG59eA9fEPu5XyA+lJx8cEev0WoMU4bqWhfdJ
 AGTbFcK+3hAhgXbCVhxTCX41wMu+9WYlPA4Apz4fz1GjG6eKahechpfvGvq5eF4+1M5ticvOkmE5zt
 X76gYmdzOLkQ7VvR2YZ26/B7nvxloB/F2QMBairZFkiuES3/jExVOzKDi4zQvl60qTUWY/C6Nz5quN
 B/pOYGMPVEBJ7AV7ExBT3iRQ8gv4l0RVwAR4WqxDM8SHeC5PctEHC+LOKbm2tmS7t7yxKOGnHZvpTl
 WoYd4jqRquksMp/JSmjB5ffqPo6mSUf7tsBMuI9S/3F2mxZXmlPbCixkQiGanieUqplTuAOVjolnaA
 6q7ZUM9+U/6G/7hYkOwk91JrQHTy2XlkyVAEhaLD01Lb8oepoodO28Jo95+hp6bZLj6e2uLz0pI6MD
 4kTbJxYXde/2J40JZGkDGlVjMxEzN8z3xrqxP8qb6/7Ca0GS3fr9kPBZWV11rhklHxBxiJ1ipTtIQu
 fQojmuLzZ4moORJg8z0abpqzeQ60MMnB9oQy5kmmYFOFcnRVDPbWnrVAn0A3JFuHs+Qv4Cqz/IVhar
 ElUEO/Aay22yyms5C7+9ozJabfx6TBGgB/aWS7xaxP3ePLsY5RHOHRvCGkyw==
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

