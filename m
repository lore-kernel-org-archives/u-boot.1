Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C755CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F9D82C7F;
	Sun, 26 Oct 2025 02:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kaXgi4v9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49FCB83826; Sun, 26 Oct 2025 02:07:06 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC0EB83623
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-44588e94decso1749062b6e.0
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761440821; x=1762045621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iGQJL7gv2BvCrANXlEdK1eCe+aDtdcOELULvMaF/fk=;
 b=kaXgi4v94SpdcAAWAfyPM964uVOKZ8r7+My1ybXm0TaSb23gO97YZmCfs4TmTkrPCH
 kkVFFEZazK630fXaY4Z6EOALuD8tcV2zldhn2u4IK5x8ft4YyynlbMmZv2/QiEBQULpD
 XYE8JLvVw8dpH79xLlU5vyQZ10j+re9BSinxZNVUKde0GyQ4Hf0si08+meQwW36furFb
 2E3Fg0/7gG9r3Z4bkt27donh2sSIxQO+ieb6l9CU8WGFAoizE2xQZ2Vih4S2pC8Vkt/p
 PVqvohGtFYCXd8Or7JwIu8ic3rlLfkoGjg4Oo8bJA9Pi/zweWSXA/554XkfN/ci6Gnsh
 AnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761440821; x=1762045621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iGQJL7gv2BvCrANXlEdK1eCe+aDtdcOELULvMaF/fk=;
 b=cOZlKCZk2Q58EE2RTPCSrf6cbHqzC3vOCWDcTlWvfrr58I6cCtdLSjj54bb5zHMhGQ
 Iqos//mKbntVNg9YbbgwiZ/yOhEaWAE8NakPfQqhWojZctyFBG/XIRMJ1XGNIbN2Qo3k
 imZuJ+nBLaYZMABefp864nQoL7w4BdhsywQayMgNYBKEZ68miTNZy0VePSZGnP2kw1ve
 sjLVpjy3DDeNS1OwC+RgEYGym3fcDO0z6o35gk1k6wLc01f2zagU8OMcl2ewRUNo/irn
 fPzkOwGZ0DLNwMtPDqEJKOLGMmBzkMHlcTEz8/KFY2ylFVM0E/pTjZyrE4tyqg1OGBQ6
 kDug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8c7hpdZwXPcRZ6+ba4Vv9rumvupUvQOrInmAxCRn8Q79Fzsyy3umPpXBtTQxeCv6GN0Iavuc=@lists.denx.de
X-Gm-Message-State: AOJu0YxyhYHyorUQi14loUH3ZvZ2oYNx1ckexLM39Xbk1bANN7OvR7U/
 xb5jqeAhynGBcBOtfei/ein9uVfVwYjEgdqIvJM99TfQ+++FuKclnTQQ8QhdNxUKI7o=
X-Gm-Gg: ASbGncsj8JlDHTzfZzbgiLc5wr8nyeYnBV60N7gki1sRU/dLWs7Tltk/Ia9/Ry+TMJX
 XguHRzc5dGs5az+3DLfGqXsvyMylrAmm2sn0rd0IVBygEcfxomBMJASyTZxl0sOGUX1blxGAc1a
 2ZOtPUcablz/0SywYGS4KHVM8Cr+o45/8iJLDBR7vvxQv7TTIEkGk6sddyoHr2cPfNmyoEeGD/8
 Pb7tuYes5QZyhaqdpuZMJ3kMQk5YAXja/M/WfbTPg6CCDMgUgfXDrmjNppP+nK/j7UrTBFLLCmJ
 PcZMijDyuP5gOw5Wcf7Aip1hIxGqFGosH3Hl+08w+JA0ZnZxzEGPQKZrGPmNWJxGyl+vfiiB7hy
 ulYeWFzSuu1YRcWzW1DgctD34eMkxTi7uR4xCXCPlGv5tTmPZ5xhWsP1A4M7JDDrYHIh//ab2Ap
 klM4gPjOcvhA==
X-Google-Smtp-Source: AGHT+IGiTcw+DpAMN3hUhhbOS3GpZ/IJtXYkRBdCfQW/lqmcYFkJk7hcr4/yitdFBpDklzjbW7696g==
X-Received: by 2002:a05:6808:c389:b0:44d:b1e4:2259 with SMTP id
 5614622812f47-44db1e42a4amr308090b6e.14.1761440821455; 
 Sat, 25 Oct 2025 18:07:01 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e59a15sm852685b6e.8.2025.10.25.18.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 18:07:01 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Subject: [PATCH 2/6] mmc: dw_mmc: Do not export dwmci_send_cmd() and
 dwmci_set_ios()
Date: Sat, 25 Oct 2025 20:06:54 -0500
Message-Id: <20251026010658.19271-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251026010658.19271-1-semen.protsenko@linaro.org>
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
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

Do not over-expose the private dw_mmc API. The glue layer drivers at
this point shouldn't be aware and shouldn't use the generic
dwmci_send_cmd() and dwmci_set_ios() functions. Making those functions
public causes a "leaky abstraction" issue. It clutters the public
interface of generic dw_mmc driver and possibly leads to improper usage
of those functions, so it's a bad design.

If struct dm_dwmci_ops has to be extended, do so by copying it first
(like it's done for example in snps_dw_mmc driver). That also makes sure
the future changes to struct dm_dwmci_ops in dw_mmc driver will be
automatically reflected in all extended copies, and avoid code
duplication.

This effectively reverts commit ef3b16bb8e73 ("mmc: dw_mmc: export
dwmci_send_cmd() and dwmci_set_ios()").

No functional change.

Fixes: ef3b16bb8e73 ("mmc: dw_mmc: export dwmci_send_cmd() and dwmci_set_ios()")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/dw_mmc.c | 6 +++---
 include/dwmmc.h      | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index f3c0cc5cd8e5..d9c05b223d5f 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -490,8 +490,8 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 }
 
 #ifdef CONFIG_DM_MMC
-int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
-		   struct mmc_data *data)
+static int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
+			  struct mmc_data *data)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
 #else
@@ -597,7 +597,7 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
 }
 
 #ifdef CONFIG_DM_MMC
-int dwmci_set_ios(struct udevice *dev)
+static int dwmci_set_ios(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
 #else
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 47e3220985e9..7e1a66465181 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -338,9 +338,6 @@ int add_dwmci(struct dwmci_host *host, u32 max_clk, u32 min_clk);
 #ifdef CONFIG_DM_MMC
 /* Export the operations to drivers */
 int dwmci_probe(struct udevice *dev);
-int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
-		   struct mmc_data *data);
-int dwmci_set_ios(struct udevice *dev);
 extern const struct dm_mmc_ops dm_dwmci_ops;
 #endif
 
-- 
2.39.5

