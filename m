Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A15C79FB7
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 20:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9C48810CE;
	Wed,  9 Sep 2026 20:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzKEoU93uxfN; Wed,  9 Sep 2026 20:18:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E2CA780E28
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788985127;
	b=sRJCmhH1mL+MfqZMc5t5MbF/NmqxyB/Rs5t7ZWB+66pfuEFj6gLIx6ofKCmSga+IPMH1
	 aEjRjOoFXCMMNhJsbA0DzJfOGWTJEbB91i/aXo9ZX5vDgO9TM2S94Kk3wgvNyqd83ldzt
	 EzRLAeuGp+V1jFTF1MdgRw7pZJlUkM6t6tSfueJhN4D3uKgRAOz7MpQe29DF1QFbfC255
	 U7hZj7hBmCJRZ769ZzcDSkPCR1BBfN++oZLijhXs+GHIgGtrK0PsRkSTxc4pkrv8TDlHY
	 +JqIYfyT5Rkglt3K+C1FcN8orXuzDHQMo0FF+EkUK9vuQEEQTuOgjX9GTpNN+aWdFKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788985127;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HPGqff1XcgC990GQ57I2GKHna8lZm0VhChHd34p8opU=;
	b=LU0YBBB8pwxNgxdKV/ONpXYa8n3TVyFfpfB7g9uuLoYYCFteQmsRo6IkLx8OolAhS+ZF
	 9LGa20uKMWDL1XPd3Le5caGdFXA3YFMNz/8/WxXFnEl21WBQz8oVHzRZKyb6Zp13ySkLG
	 8kYl1iCc8Bz/uL+IcNu4c9EfOoB8ed3TxK4kXhPm+2K/6v0oECkP87FtZwIssOf5nhY/x
	 HLoLCNeVpxa6vJfu8OJQ++qnEfzSipkmSZuo5S90ujEpr840PbsQlEvWJ9eIL5Nn6RKgr
	 xgQMpCPaJhhaW4q0s0A8tT2geycW/yFOdcF42Ii7LF/Nd//iixSLy7eXLYLutbEbpnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788985127;
	bh=HPGqff1XcgC990GQ57I2GKHna8lZm0VhChHd34p8opU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iEAcrQCiHPG4iBTBvbDOaW2U6G0WZ7z3i02AxzDAPqpGuL+2X5eZNV9eIgaIQbwnj
	 4FANfaVe4sFf9BG0mDtbirfO00HjpDukFut/LChHs3NwqpT8JuYgOAl7DlSYeM5ZGP
	 rntifL3dY/7DSD4oLX4ul796urWaLvk0fMLsQZBMNKv5BS4l6qxtWc66K1z4662JZK
	 VneDjNZpIWn1kfAEENnfbWHuaa/1D+53/Qb5TDrqgI5ihMcVT/NU8Wk4odYXu4YgTC
	 8U2YreUmvOCQwvWj/1pOPl6UHKoM/zHLk3q4dskm2G1KUt/ivXyvcxVc7r3VRVBIBR
	 EBr37mBBlIZ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2CA780E28;
	Wed,  9 Sep 2026 20:18:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 990E0E2C
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9602160B0D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bUllTWCdFTKy for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 20:18:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B3A160809
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788985125;
 b=Ps07KTwkw0kMo4xAEaWi3knY1gSXFnBEweE30pMF86yi9TE8n8UQ1r8zMUTPiwEIrP49
 ThJGjqErUW7sEWZvoxxlHseNi5bHe4euAy0QVeEP3sdl2t+sZH9axJoYeFVaCTYpjK/w2
 vMGIsy1MoeB1Ud9/arWhUck4uLv13h/ZAGu45x/ScwFR1uc1dhJWGAJnEZG+ahNCerDHc
 6jFcU0aqUyvg2M8IhC1vbHk81Aqr+z5oadz8dbYPDXG1yO7KyHIbg9CQ4ltDL7d1Hd4O1
 xc4X7P/U4tM3RvnmjXiGGNiz5sT36xY5J8e5DQnO3MhY71AxJ8zYZ2VHcRr2l6wDwoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788985125;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=HPGqff1XcgC990GQ57I2GKHna8lZm0VhChHd34p8opU=;
 b=FmHWGq6PoQp2Jy+V04gtAN2gK40O5cOlQM6R+BPxbFOEKAm8f05ZBqKUAGnlKy/nqasA
 6TNlOyx7qwPg/xQqzRYSohD0lZ8Hf646ScjdioAGTc6STNsd/R+o88tFyscNz+jv9BW1C
 jdXHERlSex34z5F/awlq91Pb6TjUy83XGMQaZn0WTT7yFmPPZGOEJ3jrHLQoP7f1wP0MY
 Gzd6X4xNipljroeBQ0FI35EEgAsXGT4lW9BNIieGDtKx/7U3z2tVj6EZSjJTTjlFWpqt4
 AtFFc49AH4mIwjjjLR1T/HPa9Mz3yvGJIt7BejpQuqaynMbDjpd+VBWxVab0VQ62Ucg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AQCdjmXF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e33; helo=mail-vs1-xe33.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AQCdjmXF
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B3A160809
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 20:18:42 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-783d429d0cfso4448317137.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788985121; x=1789589921;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HPGqff1XcgC990GQ57I2GKHna8lZm0VhChHd34p8opU=;
 b=AQCdjmXFlOQBSBT/V+h0/OT4mqOiP4WW8dbN4Oc/qFvmvUcqq/Wh+Q4HuEuVR0RNU1
 7YatI+WwzYsyt6+kG9kw5o+hq3GaGhsT0jREuA9dAowGao+OCcVML9ImoyWvTrZNNd/X
 BwVQtrpIxRcWZKiboNVZ4hG0onmTBzCQsHr9PGkopsNoUYSZh/hYjOAV8ZLkKfvqUV3l
 M848QmUAB3cGZ/V5qsLKsXfBgPnKwJy9+x54oJgIa638RA9bFmW8+ob6mQ1ZW+H08iyH
 wz4+5J/wSKjtv46MgHZGnZJeUgKpCIDQNk5PHaAFLZ0divqKbXghZS3q0JaAMyUupzbR
 MjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788985121; x=1789589921;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HPGqff1XcgC990GQ57I2GKHna8lZm0VhChHd34p8opU=;
 b=LhFufhNUaYZr53Yd3nCOyrNogFB2iPksB2LAHNSupuIxWSsffZNymP7DCf3G/ojZ7b
 dPMprJkp8ZAceWIEaJQEkXljaiQeUavPvhbbAdpT3WFzXW/GxwJgj9MgPHmyBjEPGszg
 w4DgpDJc1C192TSY8YZwvv64qWG7GTgk0lWeUbqbXC/VOjzlhD8R9XTeW3AHo7etyIES
 88ySJ5wxiSAPhu9rBslODZnKEnaRtdakM5K1GCQsbBeY6ZYNYrSynXXMerXi0IdHhawD
 2bSXFupZjIV01B4afy2Fh9BbzhggzALlARx+1FmEFlseYjavgYURxuUb0v8l022W/2OV
 TEsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjt8ZYLsAyFM8NfT7QsZY6s+dBUGtS64LGBaScdPfJNMeNHnClWg0Rh9PGmKDgVhiIc1fDUD8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mb2VNf+/4aLawnNoC8pKygTfHWeq+P1TOUwTrPVyCdnsnSpW2e
 Kxcblfy5pkPWgWs6psCAE1tFExH5qjTBKm08zQoRiXhhcGU3uD0Xiit+Aas+ZA1ZpYc=
X-Gm-Gg: AYBFou0nhZ0FaqDAeZ7oSix9pfZHRYnR8ucu1h0eBITFbOAkyTmnxdNyx/TwYEARbzl
 mXkh4whW1SW/jpWxlqWrvGMnBZ2lRcWk1Nb+eRwXH99U3XINnTczQPl8eKvpTWFulCIdMhzxea5
 t4jSeAU1iUW3UC7CMtztCUqlAPnbjUf4hXKM9oRppTg0yu++yT0QoqitSdIUWMutmj2M5MdWEo5
 5uMsVpKF47B8saPsHM80i2X9BgJM7ok/C+rF8kPtz9IMJ10HYaS6B6XLa5o21zgiiM1H2ZgOgcm
 iFlFA47+5kSjVO80+wTGmg72WUbbXBVgDGbLPN6e9rdY6BOeLG0FI/f8iEd1DSbiDMrCnKYAfXF
 nSYQm0XBr/tJZtBpvqBuS7QKmvBYDjwY8tK0LERaxGg94U2cJ7YmEAIsxQhkgTLnh2d6PG9ohKk
 PSIbmg8B48U5sBCJVBxG1oWINRSycM0mFUFRs2bez6mbxtL/wy7bw4n7Z96JPfKpmyWT/Qay1uo
 viSmEkEGlGIRTRNfwJPGdHQOCt8ebh6vMY=
X-Received: by 2002:a05:6102:3a06:b0:77c:6bdc:824f with SMTP id
 ada2fe7eead31-78a4a90fc19mr17612610137.1.1788985121606; 
 Wed, 09 Sep 2026 13:18:41 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:9534::7f1c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78a47ae301fsm11765391137.7.2026.09.09.13.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:18:40 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:18:36 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Andrei Lalaev <andrey.lalaev@gmail.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v2] mmc: cv1800b_sdhci: configure SDHCI PHY
Message-ID: <aqG8pz6wExm1Yjma@hiagonb>
References: <20260909-milkv-duo-sdhci-configure-v2-1-be146dd85187@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-milkv-duo-sdhci-configure-v2-1-be146dd85187@gmail.com>
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

Hi Andrei,

On Wed, Sep 09, 2026 at 05:21:12PM +0200, Andrei Lalaev wrote:
> Some samples of the Milk-V Duo and Duo 256M have issues with SD card
> communication. As a result, the SD card is not detected, or the correct
> mode is not selected.
> 
> Configure SDHCI PHY in the same way as in downstream, to ensure
> that the PHY is initialized properly.

Thanks for the v2 patch.

I tested this locally with my Milk-V Duo 256MB, same tests as before, and
it works without issues. So:

Tested-by: Hiago De Franco <hfranco@baylibre.com> # Milk-V Duo 256M

My only minor comment would be related to the 'CV18XX_*' defines, the
others do not see to have this prefix, so I would drop them and keep it
like 'SDHCI_MSHC_CTRL'.

However, as usual, I also asked and AI agent (Claude Sonnet 5 - high, in
this case) to review this patch and looks like it found something
useful:

```
This always sets PHY_TX_BPS and writes TX_SRC_INVERT | RX_SRC_INVERT,
and it only runs once, from probe(). Sophgo's own driver treats this
as mode-dependent, not a fixed value - cvi_general_reset() in their
tree branches on the live SDHCI_HOST_CONTROL2 UHS bits:

    if SDR104:
        PHY_CONFIG    &= ~BIT(0)                 /* TX_BPS off */
        PHY_TX_RX_DLY  = 0x00000100              /* TX_SRC_INVERT only, tap=0 */
    else:
        PHY_CONFIG    |= BIT(0)                  /* TX_BPS on */
        PHY_TX_RX_DLY  = 0x01000100              /* TX_SRC_INVERT | RX_SRC_INVERT */

and it does this on every reset, not once. With this patch, a board
that actually negotiates SDR104 (LicheeRV Nano, or any cv1800b board
without no-1-8-v in the DT) would go into the tuning sweep with
TX_BPS stuck on - cv1800b_execute_tuning() never touches offset 0x24c.

I don't think this affects Duo or Duo 256M today - both set no-1-8-v,
so they stay in HS and only ever want the else-branch values, which is
exactly what's tested above. But since cv1800b_sdhci.c is shared with
LicheeRV Nano, it seemed worth flagging rather than silently baking in
a value that's only correct for one mode."
```

I can't test this since I do not have other boards apart from Milk-V duo
with me, maybe you can take a look at this review to check if it is
valid or not?

According to the agent, a possible fix would be:

```
diff --git i/drivers/mmc/cv1800b_sdhci.c w/drivers/mmc/cv1800b_sdhci.c
index 440421813e3..27203613e5f 100644
--- i/drivers/mmc/cv1800b_sdhci.c
+++ w/drivers/mmc/cv1800b_sdhci.c
@@ -70,25 +70,30 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 }
 #endif
 
-static int cv1800b_configure_phy(struct sdhci_host *host)
+static int cv1800b_sdhci_set_ios_post(struct sdhci_host *host)
 {
-	u32 val;
+	u32 mshc_ctrl = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
+	u32 phy_config = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
 
-	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
-	val |= CV18XX_LATANCY_1T;
-	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
+	if (host->mmc->selected_mode == UHS_SDR104) {
+		mshc_ctrl &= ~CV18XX_LATANCY_1T;
+		phy_config &= ~CV18XX_PHY_TX_BPS;
+		/* tap delay is set by cv1800b_execute_tuning() right after this */
+		sdhci_writel(host, PHY_TX_SRC_INVERT, SDHCI_PHY_TX_RX_DLY);
+	} else {
+		mshc_ctrl |= CV18XX_LATANCY_1T;
+		phy_config |= CV18XX_PHY_TX_BPS;
+		sdhci_writel(host, PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT, SDHCI_PHY_TX_RX_DLY);
+	}
 
-	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
-	val |= CV18XX_PHY_TX_BPS;
-	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
-
-	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
-	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
+	sdhci_writel(host, mshc_ctrl, CV18XX_SDHCI_MSHC_CTRL);
+	sdhci_writel(host, phy_config, CV18XX_SDHCI_PHY_CONFIG);
 
 	return 0;
 }
 
 const struct sdhci_ops cv1800b_sdhci_sd_ops = {
+	.set_ios_post = cv1800b_sdhci_set_ios_post,
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = cv1800b_execute_tuning,
 #endif
@@ -129,11 +134,7 @@ static int cv1800b_sdhci_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_probe(dev);
-	if (ret)
-		return ret;
-
-	return cv1800b_configure_phy(host);
+	return sdhci_probe(dev);
 }
 
 static const struct udevice_id cv1800b_sdhci_match[] = {
```

Regards,
-- 
Hiago
