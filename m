Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4B5CF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4218893E9;
	Fri, 20 Sep 2024 10:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m+lskhUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E6089415; Fri, 20 Sep 2024 10:00:41 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0502893E5
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-374bd0da617so1149872f8f.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819238; x=1727424038; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ITsepdkflPSwXBnKePx11i3APLsx3e7/kiaw75Qv7/0=;
 b=m+lskhUHqvZXw6ILvNEEskoXxzQOWLa1oNJI7MzeQHMEBS0jvaIPA+WgYB9NXaStVO
 6dD1kPqxwe8tShmdaDXZBfR0lOY0jQ/Ns6wvEt67sh04uLgfFIOLC0Ee7H9AI/t6twIJ
 JUZGiJE5R3N/iyqHi+gAkNb0eiS0VHBIkhctSf6vQSxrCo7QH3r7PMPJpt+jwMKosamK
 Rg8fxlcGzgWZAWZQTNFa4/FUMDPOip9rG7XNGQA9S/qXDNVxZmjnNTeu6IiuZRALbN5d
 Q18HEzGjH6MhEIrm0B5bJPFFYWHM0qNfcx9DzfY7gUUlvpazW8QrY1ufzu9OE8X7+XJU
 fHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819238; x=1727424038;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITsepdkflPSwXBnKePx11i3APLsx3e7/kiaw75Qv7/0=;
 b=E85KGYsRvMshoD1iQk2+pU13D7tqkEJ83tuCCGuU15oasFYZL1EM8fgXFFQuUxyuFH
 GlU9wRnerx9+uZcazfExz1XExf5oNMizFuf/4D4BmxvQoHSCNgOiY1FFWe21TuKA2kRQ
 0aNE144TjM8rPPX0hsExr3RlCPyUTTcPibVpelPTQTqkxCyoe9ZFNATpeDBXPXCNHpAX
 B0MNM9nb9plnbeE1GrwpvZ0x1g//LWz2hubwLr949347RDrm8/+LMpiimJmqZmdTLTtC
 K/Fgo8vT7ZqxSfXfejbG+T0EGhuuXiErX9EFY4AMdO/Q5Qcl07terUvDLO298u0UyEv7
 6/2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv0hodW0Gc0yifK3YAEk48Y++JNb3kNJUBkFryAzR0CQJrNrOBSLY/+BdVPiGBQspgncTHbAY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8N2PHSSb6snfwxk0dE8Ts3hLfvSDsxdtexVtl2g/HZCysHXf2
 0v2HIt/wwsPbSBA+Ruaq7xeLMzSARGWnKlASk2UV9O9BDqka06PcDXZIKTyOtNw=
X-Google-Smtp-Source: AGHT+IEvV1BhAGFWFd49EvcO4qfG7fpipAIZZga+y5tGzPusjl+XjaDrsZ7Ty4CLRdvsigzgZzkuBA==
X-Received: by 2002:a05:6000:151:b0:374:b71f:72c0 with SMTP id
 ffacd0b85a97d-37a4227805bmr1122397f8f.21.1726819238151; 
 Fri, 20 Sep 2024 01:00:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:37 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 20 Sep 2024 10:00:27 +0200
Subject: [PATCH v2 06/13] ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-6-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=979;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=U5rWDVmk+KTojaFG4mSUB4p+9RPDWzL77dGyGCosTrE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SubcCG070qhp8vQGZTAAUTcEfUGJCtmpn2j7sTa
 Cez5C/GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rmwAKCRB33NvayMhJ0Xl7EA
 CtutMS+8cwbyPQsXuzXSHMM6CQyttMKtoEi2iFs8klNy417WyaT25bCVZjR8/TVPaIigD+0wFm1ARv
 HkcoI1y1MJLsoZ4IsrQ4JCQtwS9/MAuH0E0B39yXehHgPl1/9V5yEIy3sVnzMnKWk/4F0AeLEoOUHp
 lLF5RqbtcU3NfkFPH+gfoDXOYJJkTv6qYO1CTln4iZBxIZEtUjciMLh8hwqkrkv+5qUp9BPoqnfDjJ
 sLkQnJtaGy5x+we4rMip/DwFYD4cuf6p+M8G2n25lAiNWEaNvV8zaR7Npe2Otbgc2OH1yRMwUSmS6U
 iMdwKsQxx974dqfqA5lGOOQg3DX9OCVJxT+oeUnAPggjRU4EgJdxwmgAmz7MymO/MVl85S3MHNBlbF
 hlqX28lMZ9Ppf3M7gGLYHs2+gbLyUky/+EHyMEPsfCVdM+t6+ueFxysDl4qRVTSEPLwVcj2/QUb4mC
 TFg0JdOHt+ow9O8m6jc5yBFSKyY3uwxgPwyOSMmyKP0AoatatheWI5t/W+xD+6nUalGJ7/PFVI4kZw
 GIa4faLhzGe0eBMesaqptkEdWfOo1ZU8LChhKIIYap5nZ3uiRnrIG2ODkXqW/WU11fbRETfuRgXgpA
 WLF//MKq/ub6N2Zq6TzSsyc2uyTSJYEG9l1m8+CLjVWnOHkHFQrHXkldFFcw==
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Add UFSHCD_QUIRK_HIBERN_FASTAUTO quirk for host controllers which supports
auto-hibernate the capability but only FASTAUTO mode.

Ported from Linux kernel commit
2f11bbc2c7f3 ("scsi: ufs: core: Add UFSHCD_QUIRK_HIBERN_FASTAUTO")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index c92f47d82b5..b55c4a9e996 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -738,6 +738,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * auto-hibernate capability but it's FASTAUTO only.
+ */
+#define UFSHCD_QUIRK_HIBERN_FASTAUTO			0x4
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;

-- 
2.34.1

