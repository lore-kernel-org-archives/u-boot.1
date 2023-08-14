Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A1BC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC05F869AD;
	Mon, 14 Aug 2023 23:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j15p+2W6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB09A869A5; Mon, 14 Aug 2023 23:55:38 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AEA8869A7
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc6535027aso41257665ad.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050134; x=1692654934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CwB3KKkxG2cP3MaJ2Uw81b1ztFAUx3ncI6Bi3pklok=;
 b=j15p+2W6rX0jMvNaiPs8WQGmCpEizjwOfBBB11PjxA4arWs7rCZPUCWkZcMn2sU45N
 6VKdKmZrJnyT0jhGpOu2QzKtuYBc9zwVbiT15bQHVkIsgMejAwAu2TDhqjgn2ekx7Jld
 J7TVIFiZFFKQOgD/6i8CVumm4wanCNxu4JByZj8wfuQhPSmKaEbL8iQ674gBhgQb69OJ
 4MVp9wJNJudMRkgJgF6JmGO1pxKwBxpOKJmgWZ5hfbJtMX5jSwrbtV8Nb7PCji8CcXrn
 Q8IG/ksKG28AcmJfKPzkUNmvIP5ZHrI/rZwhOcSaMmanGMHORE++tyF0TLF7rHT1c3i7
 SttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050134; x=1692654934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CwB3KKkxG2cP3MaJ2Uw81b1ztFAUx3ncI6Bi3pklok=;
 b=dEmgyrYNDj0dTdHVpkt4TXEG4upLPUT1YVuB7zWHFjlcF6R3A3fG5QtRJi5o6iVU6W
 eXt5l1/o/M59gYBykeoH9fL10XSLwmkCxoBVLKJ5L20QPUr8tw0MCKxAUCSPajeDa5gN
 0Il0ghq/jo793d7tpUHC4tTljZBJZa3d8JpaLPZL7QwVAECERcFkEBMLK6n9ExdUB/FI
 sGJWZUOs0LR8emChtAw/kDdwtzPWlijcH36v99H3Lv/yGlOiewdPQPwxY0E9qjzS+fE4
 lujI5tNSn7Qh1JfkyoTN7ym1q7vYwbxxHapsPCdv0pgW7tWBKbr1Otmz5JI7N+vrmSOF
 c//g==
X-Gm-Message-State: AOJu0Yyocr3MGZdF4RUl41AuhbrVBw5Y1XTvcwK+lYrDRETeIfTtaEiJ
 m2ZPDzO/0lqX7+wqniN/is6GjqPq41TOg7qxu1E=
X-Google-Smtp-Source: AGHT+IEQ1CnJHjFnDVAabKw7rSV3r+whXNHJQxCg5D01cegRsGpDKVywgruHHDEX0e3MBYTeeTy8wA==
X-Received: by 2002:a17:903:22c9:b0:1b8:a65f:b49d with SMTP id
 y9-20020a17090322c900b001b8a65fb49dmr15130209plg.12.1692050134642; 
 Mon, 14 Aug 2023 14:55:34 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:34 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 06/17] ufs: Clear UECPA once due to LINERESET has happened
 during LINK_STARTUP
Date: Tue, 15 Aug 2023 03:24:46 +0530
Message-Id: <20230814215457.4075025-7-bhupesh.sharma@linaro.org>
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

Clear UECPA once in u-boot UFS driver due to LINERESET has happened
during LINK_STARTUP. This makes the u-boot ufs driver behavior related
to UECPA similar to Linux UFS driver.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 3bf1a95e7f..25639a6d24 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -504,6 +504,8 @@ link_startup:
 	if (ret)
 		goto out;
 
+	/* Clear UECPA once due to LINERESET has happened during LINK_STARTUP */
+	ufshcd_readl(hba, REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER);
 	ret = ufshcd_make_hba_operational(hba);
 out:
 	if (ret)
-- 
2.38.1

