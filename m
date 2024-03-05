Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BF7C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 17:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF33188099;
	Tue,  5 Mar 2024 18:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bI6GR+B6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71205880AA; Tue,  5 Mar 2024 18:38:18 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7639287FA0
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 18:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412e8c63f23so13234685e9.0
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709660296; x=1710265096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMzX1qCC7CA7Yhdicp3jQ6NrSIOTgeZwF4cVF66MSEg=;
 b=bI6GR+B6BNbNrodlg7pbs9rjlM9UKunVZnO8YELibXFBNe2BRNt03a+i648EGJ9QlY
 YTxfumysBV0MvMueNzvbNNBXWjojyVlH787DLvindZAEWUh1+/YfT8CERWDnnaTeJMuI
 05w+agnO8NXHjRrLXiP2sd2yYx0wlqqp4SvbHCsDACXSz2X91P4wFQHA6au4Vkarwz6L
 0m8cc0Nnm3qWh/kRz9hsSPHCJOvIUC543c/Heh+Ptes6hVnLMBLuSAaGIPtPPtkV62We
 CZ88Wu5ZKq/rm7sRP1nyM6daoKZlPT2f9CxIh7JRjD3jQCJ/9pHU3XLi8Frw3CVupXNh
 N7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709660296; x=1710265096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMzX1qCC7CA7Yhdicp3jQ6NrSIOTgeZwF4cVF66MSEg=;
 b=e2Q+UX955uMpo9QzrmN4wg8DsfR6F3XBJ0oqfAsNPI6MMvUuOHhmXlxrcDiTCwhQ9T
 crdVosCwU+AipDDEnH4gQ82l4NyXuW/H2BT1pM+GF1vQ0sFdtueBtsGBY44s5n1q51Md
 aZHnwmRJ8cYT/7Lngxee+vhw/mi2LCdMCtuOISJSWIycv36V4xCAJplAIl8FPirg/NaX
 V61I+Q53Lp2JmpmWCMH8pT8XhoSRFMwHiW+CfvlW72F5DF8siw1vs+mZUgXcxwhXhlJ+
 0fQvC4Rt6wK/kwTcQNUKIU5TWazC3EDdxx0fPHMOFKtMflwHD9pZk2y55OFSVJvj0bxr
 1KPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO3f+iAbcBgvbcoa6ba/WHm386qPsuZq9Ojr1j1Z4I9r1UqyLswMa+teEEjb6v1tpapPbqm/96m5X2jRxs/GUv315GUQ==
X-Gm-Message-State: AOJu0YyujfNUpOJPtAJvbkLoGl61uw1L1zIG7Gut8l8KIGMX47JuzDWb
 EfsarjWI4JeQ8vYdGUnY2k4RJhDasvC0f2mLqjI+8Z8Qx2GsuLDEw+MHnSiyV2M=
X-Google-Smtp-Source: AGHT+IGnCeV6A+l1nyamWX4+nJbmZ/E03yaXB9kgH69fxRoHSPgKkFeYxq//SOE8lcR+I/9c9wKEIw==
X-Received: by 2002:a05:600c:1d03:b0:412:c7b2:5636 with SMTP id
 l3-20020a05600c1d0300b00412c7b25636mr9883489wms.23.1709660295933; 
 Tue, 05 Mar 2024 09:38:15 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm12234094wru.26.2024.03.05.09.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 09:38:15 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: neil.armstrong@linaro.org,
	Sumit Garg <sumit.garg@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com
Subject: Re: [PATCH] qcom_defconfig: Enable ethernet and I2C support
Date: Tue,  5 Mar 2024 17:38:08 +0000
Message-ID: <170966028233.1772862.7304177146581558737.b4-ty@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240219084144.2881155-1-sumit.garg@linaro.org>
References: <20240219084144.2881155-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Mon, 19 Feb 2024 14:11:44 +0530, Sumit Garg wrote:
> QCS404 supports Synopsys Designware Ethernet QOS IP and we already have
> the corresponding glue layer present upstream as:
> drivers/net/dwc_eth_qos_qcom.c. So enable corresponding support.
> 
> Along with that it is possible for Qualcomm platforms to retrieve MAC
> address from I2C eeprom present on board. So enable corresponding
> support as well.
> 
> [...]

Applied, thanks!

[1/1] qcom_defconfig: Enable ethernet and I2C support
      commit: b307c5d45dcd1e086a3b28affd1a1006f35334b4

Best regards,
-- 
// Caleb (they/them)

