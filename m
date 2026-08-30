Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42C7C61DE1
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 17:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA6AE605DF;
	Sun, 30 Aug 2026 17:20:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E7rcenclyk1R; Sun, 30 Aug 2026 17:20:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788110449;
	bh=KmaoY+ypdwax2JMUPmkv9uk9e24Jl9LvS5pkUrPb50o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1cl1Fq5dfzaetx8qdMHZcxxpU2H53AAbicoTQaZkjBuxsyIBjoQ1fskHN1ABKa0A
	 U0D99mUPtywcmS2m0La4jn5zmoBLCoArCZa4olKiaSBT/Vz7XeVKShUldBswhjTTom
	 FEXB2/GoTJDoOI38OfzWzL4cj4lLnzFJOYPD6aXTykRL7HnsvTgSdk4uRblxmwa+d3
	 UxEsIh3Dr2MihTaoTcNPG7eKJrEBKq5klVsRrZ7gjX5DmfWKXEM8QOpMq0kEP+kmNz
	 cHkoktT/R2MBFzfMYzbv9K+tUKtRJsRm34E7hcF9ZZj5kysWKyaBxfojxLkXoSsMjZ
	 dB033677plkPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52F0F605E5;
	Sun, 30 Aug 2026 17:20:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B99E5127
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 15:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F676405BD
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 15:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajMgQnMClr5l for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 15:30:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=kzWxt9JY
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF9E3405BB
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 15:30:03 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c25420fe973so423779866b.0
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788103801; x=1788708601;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KmaoY+ypdwax2JMUPmkv9uk9e24Jl9LvS5pkUrPb50o=;
 b=kzWxt9JY230yo2YAaODC0ZNdqMZNhOzOVyBVchxhYpEMyJfy2pGXo2TEMi+10wexxc
 Y5+BJ5c19UAd4SfmRCimTYLzrBRJbBRqjT97ecNiv4Scw5nQKLIw2KAV/otDhCWx99JT
 2dhHKH3WRS1thcuwz2uKlnSgY+ufB7LN425LpxxEjS401aJ1x+obtPg8Sir1CTOsrZ6I
 /kq42n6gEKbF7VaHsadf5ieRQH4/M6/IiMz4hES8SEKuYDcglO4M2EIdu7h71cAs8bza
 W7AWQdTKznIxNJw4JGcCll+HgaR7VShJ8xxqvgrKZQDLk84RjuI/wSmr1qhJxcn4IWUS
 Pzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788103801; x=1788708601;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KmaoY+ypdwax2JMUPmkv9uk9e24Jl9LvS5pkUrPb50o=;
 b=N01sEIaY3hof/VwXshRX9FdEkcNlEgNqFGcBCaDPXEFT7wh1gT9Ao0Bf5CxK2WIO+I
 etqepv0fDPAnBdQup5VUM3+4870+aLqiZGMgmxx29TtcstjWzAZ0LjWMm6KR9Fy1fEqo
 7ta67DT67sVaNrcvuncwcIbMy/k3jgdwGeClfNbTyL8bQT8dyrIb757RdugZPYHt0rBx
 wyUnLp1r3IEUwzP5Hm5HILCrqGpTmkgvYGYrEn2rfzQuRcs2sL9XjJdukPX9P63TtWWh
 nrDmvF9y23qKb6K44VramdXSZGJWLUY+VBz5z5rghwWWqcB2QOMaRsER+TTWqhwsLCg+
 evng==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1tFtZ8HmXvpeev6ARGTkE7a5p+3jDa3/TkBB73IRRo9ByDCXx6wlUcN157ig04KtStdyvwQA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kslDke2MA9Avd9TLQC2UWF3nviCaLAbnzbo1v64MVfnxbfIJd5
 gkOsfUp8o2vdlvIkvPRmYiRJcjZSAAP39P9yk5We4X5aa0MKhGLtb/y2p3KGSw==
X-Gm-Gg: AR+sD10XTw2UcO0grLmayhGr8lXuF8mo7eEp6RtiTpO7fywf/sT5f2kov09pLLe2vrR
 nNX6N82XzlPMt+Q0Y82l8bdXUdbhGYcflQoPUqqOt9I8Vy7BdDqkg0n55HcrB6/LERUWB1dfbSr
 YaJ4XyylMNOvdksGTe3021BO9MNJxVfWOwkCmwqGS9xwtCqMTtEpXFaHk0RRMELFHq02/plvIB2
 7up8plsSNgLsGTsuIK12jbylOw6hvkSWF6mQ0pgYTmXSInEE1YnJOMXw9fktwIXaX223u0O5kqo
 DNipmFGMfANh5WmK6ToZVcrRsONOnL4Tt51PhMuqOxraEMSImKrbN7ymvyj9Pcw+axVoYi6jINe
 piUrKbXU2pEkKygz+X6F0XTmzaDnr8GBbiB/S3tRiEeLPIliddFXzbswG4LW0ybmBN9+xNNpqgk
 BR3MwkvgmvzbkLcN0uO4/5OUct8Zjps42ISWueHpzz1uuUBpj80pVuK9eiXoKpWqAWnKU/6q/jD
 uhMTTuMBTC4Sx86rY0SLQg5HjHmWaWSpUt5dtpW/hVtpqClvOa4P4aR5wI96w4umuYq9MGBuaDb
 fkkXayipyuCTuKWLGX2yD4Ts+MbONEQumQFouNuA5no6x9Rm5sx7A9TKyu1yV79TWoLZ
X-Received: by 2002:a17:907:c02:b0:c25:4612:2efd with SMTP id
 a640c23a62f3a-c2557167f51mr1288678066b.9.1788103801088; 
 Sun, 30 Aug 2026 08:30:01 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:7498:3052:f6c2:7e67?
 (2a02-8388-e6ca-5780-7498-3052-f6c2-7e67.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:7498:3052:f6c2:7e67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1facbcsm314387366b.44.2026.08.30.08.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 08:30:00 -0700 (PDT)
Message-ID: <fc19ff71-06ec-4bae-8684-9c6f1e6be5a0@gmail.com>
Date: Sun, 30 Aug 2026 17:29:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
References: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
 <20260822091510.3253162-1-andrey.lalaev@gmail.com> <ao2Iqsq-Xp4dQK4c@hiagonb>
 <e3ac37d0-be2a-470a-aaa1-0cdcb3b7b45b@gmail.com> <apA3hSs_P_NYkOCM@hiagonb>
 <638029f8-37a7-46e9-aa3e-9defe840c639@gmail.com>
Content-Language: en-GB
In-Reply-To: <638029f8-37a7-46e9-aa3e-9defe840c639@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 30 Aug 2026 17:20:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Hiago,

So, I've dumped the registers using downstream U-Boot and yes, Claude was right.
By default, downstream driver configures the PHY, so the PHY registers
have the following values:

  # PHY_TX_RX_DLY
  milkv_duo_256m# md.l 0x04310240 1
  04310240: 01000100                             ....

  # PHY_CONFIG
  milkv_duo_256m# md.l 0x0431024c 1
  0431024c: 00000001                             ....


With upstream U-Boot, the same registers are always 0.

Simply setting `PHY_TX_RX_DLY` to `0x01000100` is enough to get
the SD card working.

The attached patch contains the backported PHY configuration from the downstream
driver & upstream kernel. Could you please take a look and check if it
resolves the issue on your side when increasing the clock?

Thank you!

---
 drivers/mmc/cv1800b_sdhci.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index b756649f90f3..5c129682daba 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -8,11 +8,17 @@
 #include <sdhci.h>
 #include <linux/delay.h>

+#define CV18XX_SDHCI_MSHC_CTRL  0x200
+#define CV18XX_SDHCI_PHY_CONFIG 0x24c
 #define SDHCI_PHY_TX_RX_DLY  0x240
 #define MMC_MAX_CLOCK        375000000
 #define TUNE_MAX_PHCODE      128

 #define PHY_TX_SRC_INVERT  BIT(8)
+#define PHY_RX_SRC_INVERT  BIT(24)
+
+#define CV18XX_LATANCY_1T BIT(1)
+#define CV18XX_PHY_TX_BPS BIT(0)

 struct cv1800b_sdhci_plat {
 	struct mmc_config cfg;
@@ -64,10 +70,29 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 }
 #endif

+static int cv1800b_deferred_probe(struct sdhci_host *host)
+{
+	u32 val;
+
+	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
+	val |= CV18XX_LATANCY_1T;
+	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
+
+	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
+	val |= CV18XX_PHY_TX_BPS;
+	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
+
+	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
+	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
+
+	return 0;
+}
+
 const struct sdhci_ops cv1800b_sdhci_sd_ops = {
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = cv1800b_execute_tuning,
 #endif
+	.deferred_probe = cv1800b_deferred_probe,
 };

 static int cv1800b_sdhci_bind(struct udevice *dev)
--
2.55.0


-- 
Best regards,
Andrei Lalaev
