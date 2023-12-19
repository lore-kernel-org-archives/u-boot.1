Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8A4C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 21:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86DB987561;
	Tue, 19 Dec 2023 22:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wjj50XE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CF785E44; Tue, 19 Dec 2023 22:11:46 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C837C875B6
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 22:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67ab16c38caso37246096d6.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 13:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703020299; x=1703625099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gwzmxqLYTfxF/11CrLGugA7XiXHBI4NeUV9Lakt6ZwI=;
 b=wjj50XE+pR1+UE3IxfWijwbRNLpyRPKGzGp3zgKC2TW+kNLbdUQrg9sNPtBsjXBWCB
 JWLae2xs9YizRVzo5/5EQnfsr+J1Hz9gBfwmYtO5beBe4yz5d0CB2yvCXCqzCxLBs1aJ
 gdpxBy/TuJgwHMQxrZF3FEIfIAWHcAkN+ftml9WvrmrPt5QhQNylRrYl7i4mtRcuJpLW
 Wurq7c2sC3rRp3658TjchFXPw3Dmw/gas+0WFaFeH3mSNUBZ2w6OyHrYSVsjL+1sSpE3
 aFmCWYmsD253QiLD7w26OwQTgtWYEc4UXL8d5geBw9CwbDaaaDgnIoitwe7F6OeCY6Wi
 3gKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703020299; x=1703625099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gwzmxqLYTfxF/11CrLGugA7XiXHBI4NeUV9Lakt6ZwI=;
 b=HzXjM1TFiyt/lDytmMQ0J5/NFnnaL/2ZM7qN0k2AsSPXDX2/x7Y3kx+V1q6OrLzGcd
 TWntyeovHcJElbfSXb/lD/PdtDPHHMo+0+SlW7iogm6yfUBiO0A923b1HguDXQnbxaeI
 /OrgaK4tBb/ZoKzf0sJK4CQrFUHxd3Lk17lski2cV/8vq8WD2QzzrCzqkDx9vEr83TpS
 awRAX63vGMdnK4T5HcKUyBBYPX4bZ9wq3ciyeOSHgylINiT5mQ+ueeB3dKo473Egpb6w
 ssYRdQb+WaahDXzG3GkuRdiU8u1Ld6hFLrrACZES59fp/7z8kkhUgzrtUezOFdlf0w2i
 cTSg==
X-Gm-Message-State: AOJu0Yya/Qush5hpeKcOhpejSSJHLkyxFdYVe/zWJkQsZIqF6w6Ua/lI
 wZOEApBJSMWoJLTtIhctt7cO3HGat8Gt1z4OBoo=
X-Google-Smtp-Source: AGHT+IGEnZU9qsaoKxe1Qkn2yQiJYsl0TQj56zK2zUQM2JCalVfpvbXpkg17RRMyf3P8FBHQ8tloSA==
X-Received: by 2002:a05:6214:c22:b0:67f:4c04:66f8 with SMTP id
 a2-20020a0562140c2200b0067f4c0466f8mr2994136qvd.103.1703020299659; 
 Tue, 19 Dec 2023 13:11:39 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0cf38e000000b0067a33133420sm10709493qvk.110.2023.12.19.13.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 13:11:38 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 1/5] bloblist: add API to check the register conventions
Date: Tue, 19 Dec 2023 13:11:08 -0800
Message-Id: <20231219211114.393193-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219211114.393193-1-raymond.mao@linaro.org>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
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

Add bloblist_check_reg_conv() to check whether the bloblist is compliant
to the register conventions defined in Firmware Handoff specification.
This API can be used for all Arm platforms.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 15 +++++++++++++++
 include/bloblist.h | 12 ++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/common/bloblist.c b/common/bloblist.c
index 625e480f6b..232ca4c6ce 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -542,3 +542,18 @@ int bloblist_maybe_init(void)
 
 	return 0;
 }
+
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
+{
+	ulong fdt;
+
+	if (!IS_ENABLED(CONFIG_OF_BOARD))
+		return 0;
+
+	fdt = (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+
+	if (rfdt != fdt || rzero != 0)
+		return -EIO;
+
+	return 0;
+}
diff --git a/include/bloblist.h b/include/bloblist.h
index 84fc943819..b5d0f147f6 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -461,4 +461,16 @@ static inline int bloblist_maybe_init(void)
 }
 #endif /* BLOBLIST */
 
+/**
+ * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
+ *			       the register conventions according to the
+ *			       Firmware Handoff spec.
+ *
+ * @rfdt:  Register that holds the FDT base address.
+ * @rzero: Register that must be zero.
+ * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
+ *	   conventions.
+ */
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero);
+
 #endif /* __BLOBLIST_H */
-- 
2.25.1

