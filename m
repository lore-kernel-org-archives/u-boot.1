Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27052CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB45384717;
	Fri, 12 Jun 2026 22:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AAhLoXaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA9A848A6; Fri, 12 Jun 2026 22:28:27 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 941DF8063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6d991991dso1271717a34.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781296104; x=1781900904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agcJ3aDYnjy5yo3lqqJsRk2DPgahNOYI9jN5gol0xKA=;
 b=AAhLoXaQB5Bgbgb5epgrWCRZcERym3nYNhvWAh2VlK8cPs6rZ7OBmNhTFbWvBmkn59
 Q1MXxsBwHCmQ2SEcftRnl9LyWbmci5sIcRRyG6OqTIhyHRU4ahuemuRpsWUqtebq2/G5
 5nxa4cEjFaHeRwIO7AVWL4zk3bBB0XaU30QX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781296104; x=1781900904;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=agcJ3aDYnjy5yo3lqqJsRk2DPgahNOYI9jN5gol0xKA=;
 b=sV87FyFtpqhpGdtkxNPmnHS8CMiFtpZimqBVNAY9C/lqzsNyLJ3jomknO8UlqT3sG3
 9/WgHoVvx6guye1tfYlG9PGcBdxQtNKdnp74Tgv0Pn0KnLZtYKrTf6ILiCJiss1QurhM
 v8cHIgCrHhwxUo1B5GrqVnpBfxZZpM6GaWDH/EOScSOuyfI5CuqfB8HGB2tlSQAxpSwi
 ctE07yt5ApwstQnT+xdOrl2IWutfPTxQpSMlx7OlI5ByhdPwUzxqlAVC4oCj/uaE/pr4
 mBk02Ho+VCJo2sTmWG9Iuanhwnj3p1+B2Gbtk1kpybVcTVoxhREB81lzd8wSJyUSuE1M
 /HyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9I6Sl4HFZanNXKF9rmMt3raUV0OW6BPlcG8mSSwBjd4tWbDXqhe7EOU40lO+AS5qoLXHiHCHE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+nq8ViKSL7rxk48kRroN9zCIYlM5HKwcro872eh75SfWmm6QC
 kq10UH58yXOCVsIBdQwsKUwX/3k1f4XNFKHmt60C6j7wNugQrxFLKFM53Y5fVrzlRzAnGZNTBoo
 92DWEBhQ=
X-Gm-Gg: Acq92OHe4eNZl/NcJ4JpuaB4EDQN7eQ4M743MGDE9L2itouZWEOB39aqpA3wWP0V0op
 sN+QOoF8T0l1IWCKPHIy10Yaj79oEFdjgCLJ7qT5lBz8ZsPa4IV9jtE2iPnY2LEAoWba0id15h6
 hWosdnOFfMZ85cxWjyjkT3XJZwDaKP28AlkHUqKwqBXPinW8tOWJ3uYvyBnyecS9zHMKgpDV9h5
 htncXlszOCSabW9KKXBBpxEHItULX+SULDWnrAmMzjQt1keRPz08Bib5JvApWmqet9eYPUPVgnS
 Mo1TWhZBlIsM+ng6iQu8yGIepKR1yhyuklJCx4HfcTJ1pG9aZvaxmHMRVKgowSGrdnENIdQt5F4
 foPO/Aofe7zya29NSYLqeYUoSARCq8JHCFQgOG5gkrko3Sn0NHPxDQNCe8U51ZLZUxJbGIskE/5
 Pdi7OSEdPHbBfUbr0RmpZG2ek329qp8C2Ls5HrArTBeWky5Fbb3JIB+vVV2C58XO+L4l6tcrrTe
 ChLr5mzEmbDleoS55KeQw1IGqyaMxPD5NmxrSibBSbv3t0=
X-Received: by 2002:a05:6820:4b8a:b0:696:2b09:5988 with SMTP id
 006d021491bc7-69edc796ecamr2658142eaf.40.1781296104316; 
 Fri, 12 Jun 2026 13:28:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69ed83694afsm2202853eaf.2.2026.06.12.13.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:28:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Franz Schnyder <fra.schnyder@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
In-Reply-To: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
References: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
Subject: Re: [PATCH 0/2] configs: imx95: enable PCI_INIT_R for Toradex modules
Message-Id: <178129610338.868499.17216849896765991316.b4-ty@konsulko.com>
Date: Fri, 12 Jun 2026 14:28:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 12 Jun 2026 10:58:59 +0200, Franz Schnyder wrote:

> Currently, on the Toradex SMARC iMX95 and the Verdin iMX95 the ENETC
> device is not enumerated before network initialization because
> pci_init() is not called. As a result, no Ethernet device is registered.
> 
> Enable CONFIG_PCI_INIT_R so the PCI buses are enumerated early enough
> for the Ethernet Controller to be detected and used.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] configs: toradex-smarc-imx95: enable PCI_INIT_R
      commit: da8d438ae7aa9189b25abe49741aa64b244fe128
[2/2] configs: verdin-imx95: enable PCI_INIT_R
      commit: 4228d584ce6f7c54edf765b9231806314dae48ad
-- 
Tom


