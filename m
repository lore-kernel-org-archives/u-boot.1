Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0C2C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6747E831BE;
	Tue, 29 Jul 2025 17:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HV9F6xLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A8E831C2; Tue, 29 Jul 2025 17:53:01 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6842831C8
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45629703011so40211285e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804379; x=1754409179; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O1cnVQXuFquuLL5bpTvy6+/d6gfzbcSnL8NYj+WP9nM=;
 b=HV9F6xLx4CowB3gFwpHXmT6YlC3SnAZBNnB+mU2eErbTqcP6gcJ0gtzpKUsqg5E+Xs
 lguXqVViBn/BhTliw99tD0p+YxUtj8yRaV7KWScXCOdElNed//PM4bJ43DaKVbK6nekk
 dSOjgCFNNBMrtDPPhJ7ojjRkGjq+bHA65X1TYmGo5GjaWZ8dgtnNliN+xA8B6Ou86Alh
 mxuLVBTTC3dMTU07XHXlWH/+slNN3fDwKunI7Isvpb3kvTTi7D9hfP49UYg6PYMsZ2WY
 LBy7j3uPxx7jSniPIFV8eZ5ye/J3OyfztpFrH8zSDBOFo6ZHq5jVjJdGUz3rGMZ7d5Ux
 FUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804379; x=1754409179;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1cnVQXuFquuLL5bpTvy6+/d6gfzbcSnL8NYj+WP9nM=;
 b=CUXzTBLNj4Ps093O2qJF02JeMsZ8/oE2oP2tsIEMjXr69i8W2OCM1l1XIGD9o/Qaz6
 Y5dGljPavospU0JzdQDMeEvG5PUbR67yL+XE3kiOKvPSnTA8oCJvrs9+ETZ5Nzqdt89Q
 h3FjMonzMCSOhaGdJqULLlS7LYKj4J+dlU7/iYo5L4xhoVunNP5aB+4/3UdL5JdYvz5r
 VsP1JaQxDP8ldcDQfyqnZGmoEI0Y4WVMM0H7p5jHXYtSMxinm04CaVn5XzfNf5lgyTzK
 JIFDBiI/5vSuS+DilUaOuQs2lFCOtO06bMsZCy4oABz5pD3HDMce013XCbKB+Q1523jq
 vGyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvVJdYvsYKoAYE9JgUA5OCMLpkw8YrYujBLYNp2JbajNfdSczxa2PDyFTatGk5fr7W9ZP5VQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YwTrFjZdUB9+WA1hUqfVSZtkDpLuhXMAbWrwGpiVZooatK9jbVn
 38sZ/fgY8KTXebRhJD340V/L40tJLiOFziPFYht5IHGsz4vUn8QcBYSrEPxq9FRM0Kv+5hBM/Lw
 iZj+P
X-Gm-Gg: ASbGncujUbMEEtYKZPQxrDlKqqejFxojHaBCPCA6E0GiJQbFF8K6mkP30N5nWNSdooc
 Wb/ZXwiRNlw34xZ5/J/fY9pkvY+JLJC9OohA84EkvJy4IUilBscy6TAR9MQmpIXViWCEpRCGp00
 rMxwhWMUA3qIAaUfsAsxvPf+IZaJ3U4TWjXXxgagQfdixsMiIouZ5PfIOZ4RuZ+mjo0un7FN52a
 QoN+DuVzt7NrxgYateJoGsIRnwOYpPQYEK3jD7BP+qlswBMU0xiGz/ChK63aWImi73Rt2ocwxSe
 /iFsrSc9EMety7t7Gu0DRYJ2tbuCI2C+Pme94PnHxJIaAIMOAT4wpzzACWhwIZ4uNVsrbL+/n2C
 SVZ6KNisPSWaBdoGI8MaAcu/2Hry0BgP6xFeqJqA9lxKuWAUP2n/XEpSwTSV3njnaYyKf9MP2Az
 g3xD83EYsIhA==
X-Google-Smtp-Source: AGHT+IFvcC4JAesIuZQTZzX67EoAOvyhBP8MwDIsDSSjFAuvH08h1UXQY+815KRR6xuTAgznZBLnJg==
X-Received: by 2002:a05:6000:178d:b0:3a5:8cdd:c174 with SMTP id
 ffacd0b85a97d-3b794ff797fmr124405f8f.26.1753804378925; 
 Tue, 29 Jul 2025 08:52:58 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:58 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:08 +0200
Subject: [PATCH v4 10/10] qcom_defconfig: enable framepointer for
 backtraces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-10-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=896;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=qbtQg8HJtEug/f6yeDjkin1KAD+HjGh206UQEHqDWKw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4kQFApSmR2rR2Xc9UD3PStw9Kxe9nTBxSlb
 yxuRI8/kJCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuJAAKCRAFgzErGV9k
 tk6gD/9dm5GMY8hGb9BDDtGPb0/U0i5hmnWojs2SWWNae52SMmfL9kGQ9BycrER/vAkl+6vf/HC
 s/6aNZviO7EYBiWX7ZDNKKD3SD+x2BXcVUkEeX/DC3TcBnJBND7JDZOMtg/g11h/vqyJNl1cyOk
 wC43mBnEku2rMeY+6z8LVvLZgXaWB2P9jBNGWe2n8L4B1lQp/bfpej7AnDlAGEQf+X+DXwVZNQB
 sIFa3pNsUrzt5nkJuuIyCLukagpny9m8oEKLAoeXlvHv9qbnNRt6Y7wPjZEf4ZSgjx/haFefg90
 OA1S3jo3mimSWe/3ar/yGeE4+JAKQqaYcBvchRFW5f1/IktV+2CTkL1wzX3jQqY9/x9Xbdk1OPi
 hEvIs+URnay6lPouD3pQkcvYwwigimcCTtQw8niXvmxI20kal0r/2k56yQLwOhwAE7+LjBau7hZ
 Eqvr8P8cXZ5D/jYrUDvBbBWqPadz2yoid9tPr6keW6m2K3wakbljLau9v786ryYEqvazoTu06BY
 o5Db/2wp9T2zInhp7loySdjnEbqG2A3zLEEGqYu81OEUJwlsRuURFBAcZzvb8wlZ4Zo7Y9D2tcm
 5H0GiinWuvG3VDEijjgpoqC5FBer/MVBBDn4mD4BETlYoSBm5n7A67m5ZkrdCf/lcXNeL8QrSEq
 nXw6nuBKpLdHVVw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Enable CONFIG_FRAMEPOINTER so that we can print backtraces when an
exception occurs (or manually with unwind_stack()).

This helps a lot with tracking down what caused the exception.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e7746e33f4385ca78c839b43319cd861..9036c39d637eb059e340b1b62675746a21cbb1a6 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -5,8 +5,9 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+CONFIG_FRAMEPOINTER=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y

-- 
2.50.0

