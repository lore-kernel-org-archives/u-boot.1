Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF68D75E5D
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC498954C;
	Sun, 24 Nov 2024 21:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VLC60njb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CFB895A0; Sun, 24 Nov 2024 21:27:36 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C4389559
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382423f4082so2676585f8f.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480054; x=1733084854; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wGD1GhtXJ8F866zgykZp3dszLanF5/yeU0imZRiMy5o=;
 b=VLC60njbyB2SLCK50ibFSCiovPVeTBegcULJi2hagx20MVJCT6dKmXnEmBtleYmpoL
 5x7AzN9eygaI8GtOK4OgNLdtVJ6b85jy8K5NIAIUPjbw/OByTLh1CMdtFjuQSkMJjftr
 ZZ+zUHbg89l0xCUE+Pzj1WSyMKXneKNMQn0xm8Q6La3fq1XQP6E07kvb6jDPXgKErsdD
 qhQ3NKkzw2c+acblq9DJZ8o5CGlRndvVmEC2a5+9YlmNbbvyotj/4qu/Q+nCT1+w0IjK
 aDg4UEfNxeTIdZICfb52o8tHy9OwTaJDHbl81TXHSwjoe1+onI2yYR6ZrHEl9N9NzmXB
 ICPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480054; x=1733084854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGD1GhtXJ8F866zgykZp3dszLanF5/yeU0imZRiMy5o=;
 b=PfTrdncWVXqHFJuS4JPfLvDnjRNe5Y624B5lDIEEX5ENUYEF1lgs+MNwcxO0Ejtxzn
 Wl1NNXWe0TCT355RD2bmkRFRN4hdV9ESqR+rvCfYKxvxpa+2ZCbqaYnjJ+IBxzZh9Wn/
 Wco3FDcfPXvd7KpBpjeE5dIsHEz15AdUEt09IrJBNPcVrODdjguk6B7aZCf1uFZGf8Af
 ggmm03eX5YCtEBf+dCWxa2iBj0GybrOnpUJtUkyFUncHSRuva4qVi8dnT8EtO6NpDFPY
 Bic8FDk1qYtSHisDt7qAU9vhebcGNfjwO8mDkqoT9Vl8EsTHnWq8r+yW2A7JTbwHS0al
 Vsig==
X-Gm-Message-State: AOJu0YxAzJ62w29jK6pefo1OuKh7beTEiDyfHQZXEAGyqwOuWg3vilzv
 LNqMlVkdKr7vvOdZ1crNuD6/d/dpJaOpO47A6rH0Mk/KeLr4kZrA5gY/Y78JZes=
X-Gm-Gg: ASbGncvOKzgAv3vsy3Tv3HmVB3Y6gUCXagLwY5dtll8Ff8Wqv9R7kogDeLdDx12xQGC
 a6DWgqiHrAkvprbT7l90FL6jAo8mvw8KVxobhrgaT0EOvMZc+O/OFMa/9Dc34syMMTvB9AZCih4
 qJXuTx4xK7mpw9k/7ZqBMSpYBXRKcxpkS8ngLpn3jsdFX3lg0Zh0NXuXE7Cst741y7u5r3L054n
 AZ9ZNmgwncYnA1qijnpwjt+cDI+T/0tE9T63/3iE4jFmnPNOZPcMUxooCqdgYyz8AIG
X-Google-Smtp-Source: AGHT+IFt2/I8yS5OyvvYJ2lMjGCep9bcA6lgsevTCS+UL5YeMtve9qSsS5azmvp+sAiUaQzbiGTD3w==
X-Received: by 2002:a5d:5f53:0:b0:381:c5ee:9c00 with SMTP id
 ffacd0b85a97d-38260bcfc1fmr7891222f8f.47.1732480053822; 
 Sun, 24 Nov 2024 12:27:33 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:32 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:26:57 +0100
Subject: [PATCH RFC 01/14] cmd: efi: avoid unitialized read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-1-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=704;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Nl+qdbCV4NoH9Kp6TULnfzVf2H4fibQxu7HWLZvEIG8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHsPZgunblgnGVHC3tn46ffaLgdaDydViZ6VUSsImH
 N9S/mZ3RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIYnaGfxrTnnuw9LH6ttmX
 Tn68ee+idKlttr4pEwT0ZnLOXuOyXJPhv/fvFeZPlvNf2xt1R2GtAndn/f75/s7RnItPSD11lJ1
 tOhEA
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

The key variable might be unitialised when accessed for the printf().
Zero initialise it to avoid this.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 cmd/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/efi.c b/cmd/efi.c
index 687ccb520428..1fb67a83aae5 100644
--- a/cmd/efi.c
+++ b/cmd/efi.c
@@ -220,9 +220,9 @@ static void efi_print_mem_table(struct efi_mem_desc *desc, int desc_size,
 static int do_efi_mem(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
 	struct efi_mem_desc *orig, *desc;
-	uint version, key;
+	uint version, key = 0;
 	int desc_size;
 	int size, ret;
 	bool skip_bs;
 

-- 
2.47.0

