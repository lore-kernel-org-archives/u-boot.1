Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86854E668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B602E899C9;
	Sun, 24 Nov 2024 20:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L7fq+orU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5EFB89920; Sun, 24 Nov 2024 20:18:05 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5056F899B5
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa5325af6a0so189247666b.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475882; x=1733080682; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RjeBhaqIirQRAw5XkNFw7+PXaJs9j/MkAcv8cgNDNtY=;
 b=L7fq+orUGOEFkdVzKGy6ILfS7Afo9BSxvyXMUY8JhOwnT+bfhIQC3nDCS2Rl7Tn66j
 mVAnB/X3Jhn92ecfqRGG9ynZ/42/2DWVdfxUEC7osHbCOvYrWQ0wQc4ume6DN53JOnkH
 171M0XUl5Ca14nVfuysUxJAJzqbfuBvaZu1YCLU6ktY3oU8UIUVvSDaYnQjrbkuaRlHk
 qD3Z9SQBJoTbRapGHflhhrhkN/bSvc+oUckRzLxbVWI6M2ZjV8Ise2aQEXrneTjRuHVA
 ySAi39sAIcEwbx+rFkXJcba8D3x+gOiVar0xjJs19oX0UyH35KZsrcZcGtkK8ZKqBv+R
 1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475882; x=1733080682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjeBhaqIirQRAw5XkNFw7+PXaJs9j/MkAcv8cgNDNtY=;
 b=T+YvzwJmzN2epJZeAvpFXQjCWdGHClKcmnwyhtxA3tXm4MPPvWn4ahBue0ocmJk6S7
 fryT79OXjV4bzHu6TFunQhQNZfj/jvrGDGrKwwMknU4AfOmjCTMqnAV+UXtMo1c6M7Hv
 b/HHYVZZUNIg9ugoHHihx70ly8ZqeODRMKlz96C4HY/o9ovQ3KzbppweboZ5czBzb0g3
 y2SdqxH3VKVE5BQf0h1ZScjPhvAG0nWCiblQwkxGZ6fWkFZWibRK6M9EguuwjLm11TIo
 iZL9EUcwog3U5vpbRg9V4tRDym/F1f5i72PwqMt8yH8bZFvHGiP8eSmcC38J9CHdwEkW
 PJKg==
X-Gm-Message-State: AOJu0YzTahmQcC3R6TlNMPAZLCzch7ypvCm5pext1yJOVB4TsQrN84g5
 7wUOi2Nfphfl4ZGMK2+yJWkzmBqE4V7JWg00mR9FtgL8MN59ObxNDgFYSdv6eKQ=
X-Gm-Gg: ASbGncvIioM/f5nUeXaG5IyVjH7qwFL/2pxPbrj7iKKmSTW49hEKqDdMcQbxModb+A+
 qEu+x8jHS02pE9jl8Mziwq6OO8taOt3GwpIX8bpEZw3GVIfEkkYHnTYy6r9FCclW+GFbPdRWtT5
 hjM4aQZ4oLlF6KX+ccVLMIeuMZzB4VzPiq+IFkAgBz1bL5JeT8qjX78tpHuVNR247qXyse5g646
 xXeCCfI5hXxtP9aEHqOW4ghMjJ+hUINnXB82HCEc3Fq+zuI+mERgOW4t7Ul2DsDp6wB
X-Google-Smtp-Source: AGHT+IECwkTUGiTS6s0jdkO+hVaDYtjVDDfzjvianh/jhmA6SxpUi4zHYnUxPBXsNon7hoh9mJVRrA==
X-Received: by 2002:a17:906:599c:b0:a9a:eeb:b263 with SMTP id
 a640c23a62f3a-aa509c0d7femr831025866b.58.1732475882512; 
 Sun, 24 Nov 2024 11:18:02 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:18:02 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:57 +0100
Subject: [PATCH 15/15] qcom_defconfig: enable QCOM_SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-15-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=596;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=rjav2a8/SG5oSCZLcwsNWj1/xZr8bVLlTaBGS/39Uj4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6ptbfwtmbD9r4pzxbVbO1FSN+ysSm/p9Z62JuPaq9
 uj/nDXbO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEJnUy/LNo4X+9/+3K7vmL
 iyOD+e09rydNvMVctG3vIn737C9c8Y8ZGeZnWj85n6EfyPJgk2j6XFU5mz8TxErrXhVbP24sV5g
 dJgYA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Used to parse memory layout in some situations.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 30f7b1c773fa..b49d897123c1 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -109,8 +109,9 @@ CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_SMEM=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y

-- 
2.47.0

