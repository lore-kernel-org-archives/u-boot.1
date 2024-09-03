Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5ECCD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8C888D42;
	Tue,  3 Sep 2024 10:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Do6we/yA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CA188D2A; Tue,  3 Sep 2024 10:39:06 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1752488D20
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bac9469e8so41573585e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352743; x=1725957543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pQJ/U35Kq9qHhWWud44CyWS+0/ZT8DvHOfQHL+FlLc=;
 b=Do6we/yApPkji1K36YcO2MxbCM7o5bDcy2VzppW46an2uxMiTwBNLZS698UpYgBOFh
 7nCDrIHvE9CjjVIpCLvYhLX/lMmBQILuwaaOkYjt11vWDLQzB6Fe12+I67pfyY5/sHha
 7Tn+8xnBQvqJD+0D2ljT67jO0qiaj/K6aAnjsj68he8O91pn2oO/lOXRfmn73YjNO6LY
 TUIyE0omoc+t8JuyK2bxGpQ871Blt2gUruP6TAN/0dEnvKf1q2z5+ZJv1lT4K+zfvcU0
 66Zk6pGmn6heTgxpl/dDdSpnVvrs4blgQR8LMOqQ/bwBWJ3t46NBUVZr34tpwwF/OjsZ
 +bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352743; x=1725957543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7pQJ/U35Kq9qHhWWud44CyWS+0/ZT8DvHOfQHL+FlLc=;
 b=ZC1OMLATBOHXPOnQypH86bh01+SdZWN/v76jc8gjlS+DEe8BCP28MdwDnzQAK479EQ
 IRb+5b9gdvrQeRfdzDYsopHihqj8IbCU0ZiIuPcTFYlvhjCfXzqtGKGAuvn7Fr/UaB3a
 VmFrCbQwW/ETxmg0J5+bBYYa6Ihck+FOa7ungnLZLdr+arlZERmAnmZxMynhx2Li0vms
 foM43UHCOLUn9mNQJ61Uo1y2Y+S9tm6V/oiZvK7xDK1vbgcYldzpKYoqqoST4RaFjDNO
 OEaiB1OZoGx9h/NLxMVZeQMI5GH/J+7esyzRjMypwo6R1wlH7HVEDloSObHLXYAzu1ar
 cCEQ==
X-Gm-Message-State: AOJu0YxxNFAQA8DwDeTLmyA8nc6WzvF5MOCS1fcgmf4LSIHnugTJuGYd
 wNTVkHgCE1sPsK1sNEWgOOGOFYoN0kFcgykumH5+1E5e3+zUmPcsZzvZ2AFnBQkQwgH+VJpntPo
 bB8tshA==
X-Google-Smtp-Source: AGHT+IHFy2RZMRW9F1PvVyx9iyFC3UNWhwA0IoSeqIQTpgZYzgMlLSeT9Fcw4azNyhSEB6DfFtjyTQ==
X-Received: by 2002:a05:600c:3c98:b0:427:dac4:d36 with SMTP id
 5b1f17b1804b1-42c82f47ed6mr48284425e9.7.1725352743131; 
 Tue, 03 Sep 2024 01:39:03 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:39:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 15/16] common: update: UPDATE_COMMON implies CMD_TFTPBOOT
Date: Tue,  3 Sep 2024 10:38:12 +0200
Message-Id: <8d57cb45bfe353fbe8006d9c083898522613ba0d.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

common/update.c (UPDATE_COMMON) depends on tftp_timeout_ms which is
defined in cmd/tftp.c (CMD_TFTPBOOT). Therefore add the appropriate
imply statement to Kconfig.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/Kconfig b/common/Kconfig
index 83c81edac20..968d4fb66a8 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -934,6 +934,7 @@ menu "Update support"
 config UPDATE_COMMON
 	bool
 	select DFU_WRITE_ALT
+	imply CMD_TFTPBOOT
 
 config UPDATE_TFTP
 	bool "Auto-update using fitImage via TFTP"
-- 
2.40.1

