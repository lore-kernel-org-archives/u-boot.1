Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDFBCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 13:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A2F760B5E;
	Fri,  2 Oct 2026 13:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f64-lPcMSJkX; Fri,  2 Oct 2026 13:23:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B5CC060BF3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947393;
	b=sVY9p2JI6urh4OI61Y9xXg9xorxa8qVc47vgDab8DER0eCQFk2Y1Pd5cZbM4fmdipf1p
	 trICdmS/pAOdUZl4Fgo5/NI1olItouVfRy9dA3WKUDxWD1Mhu6xl1Nff5CQ0kcZyrfl1I
	 8lLfShRHI10f7extTJ8XH0mY9oqWUcbQfcnSfpyFU62DiX4X8W4Ew30GUVNvMtFAF6wNj
	 D5CbxgxIfcVsukpH+0jHfqD7KOCJ6dj8LX7DZbW39b89V8O//DLzicN16CliLf3OSxf9W
	 Fbklf8WzU+mNsN3nCZWSX5/ScJr2W43aSCcmExFeiIVgYh26cKyxao9NuLoVUO8kGWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947393;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
	b=PGwhUOxXF/NDiZi9G1k0wAcVPH81G7qvmGEI82ZsausDqd5oqWWz4RUoYiTk/RBCQ0tm
	 tmZBQZna94+XniqWLj5d6W5TP8EwAwvWszBgyAMglyv5dAePO/+DmDt/Csl6oXGDf3o2x
	 OTat919D29avaw3SHP9BDG7f9rxZTg2HMLVxgxlmDEtQoOc1C7qsBFzJZ2IW/lfA+Eols
	 ZJuwjcUWXPWUIahGYxtTinxhOmyitHnVca2iaxxs8qH/KCxCQ4pfe9zzEIKGdefrTsv0x
	 PsxCl0lY6ISvI8yXiqKIgB59NAMt01tWw9xbIzXeYVv8jOLeyvivwvYSUo3fixAdZFg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790947393;
	bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKomwW7HdNiRNHTBPs7biqtQLO4PzNBdbgE1kQMq1kx4jfUoa0pkzLvUiihFkUkDK
	 1dqKZaTDDlmOFskvnBr2D6iTvRDwI0WV9hSL/+hVzbLhHcK4CWpPqrvzt7QkMJCS2X
	 9FyTIbW+AD+K2vViFvbL7mbpY7Mh8my2hAF4BQx3H5Hqe8g464TiDaHk5+ElAKFjD8
	 YIllpM2Ep1vdQtQUulcnFtgnXKnnzk57iZ4HDpAkpB3+uQgAqC1vg8QTb+RmjLugf4
	 KSZsQ/CdpomgY9BSN/ausAWGoLr0gsATEMiNAXGc2oLwaa2G+TpROzWizr4uNMpJZ1
	 S8jfr0W8JXM2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5CC060BF3;
	Fri,  2 Oct 2026 13:23:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A577832F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B9C440DB5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teNB4qtOt-0N for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:23:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 99D5240DBC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947387;
 b=nJ3GXe/C8x0mNndvDQK4TbLiVZgNeyZ9Ane2j0HGL6r48eTXt2Fxhc9AILQCszgBEt+4
 P5O7hsT3CnvrjY+J+BCNN+r09nxy8iKorgnNI5hgqBKJHlfISpipRO6bk+5BARpHjqmDu
 hrLoRgjAeFPeBxua1I7iMkuuh9gJK8dtcgR/DQkoyxl56mSJMUDe8MSXSKt/EmOcvNqz7
 psw6tHWVcXhyVihTj3v+B6X7YvWhqYvCw3YUH/oruBuVihlmmjrH1nmAvDGEVLuze6dqt
 lCvlPtDRxWbN9xmeMnFtABfr4WpUhCEnGt98MXonO8v8OYtFKov9rEd4K3cq1Py5ETw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947387;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=ky25hYUbqH5lVkWxK8n2JJ1mBZTnqzm5vDD5BGjUEUS9sWNtAq0QdICKW0vBopfxL9PD
 QKDwuAjKk5T3E2AC43mP86yj315c+HHLCMTJDH6EVmTQigvzMK/s1loX9XlZcSdhcbNKH
 6vI2jghtLkc9qiVUdO9fcF0JjcD5aENmABr83j0v/QA4rSvSlUZXTj1sjAqkWjFMhMFhX
 QVpASWP7hwwGUHwf2G459Egh1mlmBrMajZTq8MU8QNyNCt8jV6DnZjMVC8MBJa18LhgtR
 1MKGWd4JJuxLTDL1OMnEa5yxY3mCcTF13lrrnMVL5ysPd35+edXuUeYZHChdYkfc1uA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=kt9qpn6V; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kt9qpn6V
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99D5240DBC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:23:06 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso463545e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790947384; x=1791552184;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=kt9qpn6VKpgZ/ly+f80z8rKMbxIx+Lgt8FByAbOIq2qAFwZeNZ2pSMequ3TF5d/wcX
 5gt3xrV1fReOeZtM9SHpJiDf0ridVYj0SIVa8phRKMo3XTY+QylUnDB07i6qVGsJxIW6
 AhCmOYQ+hKbkYPuw7gXuxLRILT1d6030jT7TL6GMozKDxiVv88G7axI6JLJyvIGgrPcX
 dHX2HPmzRFxDolPeEiYyROVaAyVFo/qA6ZKZU9REuBX4ob9yHkDCNtKtSndk1wuK+GW4
 UMKWSGzLGz0dH3mgqO4DXqvxAfDkCIRcfo/2wC1UiMBM0LlR5ds/uPURSZa/gyYGTUBi
 rcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790947384; x=1791552184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=llsc/LoieVVaXpWmuIFSfW0Pw8T3z97BU8VF7vdnbV43TJESTmdQLWXUQzoQCsVao8
 RrRSja13aNrKWddQMqm6/3L9uOHhXidxzTk9CGyvx8PKZ2ZSwcGyjcVVSqoSs84tHYUg
 aYqnIGpAsfHm324eEba+FE8P8EtIKiUgFn7HL4df2d3UBMbcIPp9Yrj69Q9GRNqkdlr8
 YcNuNlVM/CTY7UuJuyq1Lfovt9jo/wPEaNZG3l4u+BNVa+DAJvC0c4AepVr47Rdg/vOf
 0zmLgu0LIptTwwC95Su3SZ11566uQNKKkwYiL1cOYbfkc20vn4u+OxKkt7jA/cRENyTE
 EIdA==
X-Gm-Message-State: AFuF++msz4Mt/6wZiWXEbWhu3zH4BkSTJyzTuipn43sndfOj+1YSd2kv
 jbZL2Qaq3Fbazq4bxwKeMxopBiu+Ms2EqQYow+IbZpmM/MQk6uLsFwW7ekhtVHYcD+0=
X-Gm-Gg: AYBFou30JYqangh9RARBaeajKxW5OlhAVRe2hABxR/AetufkgLOO3lZdumq5MWr3Sov
 uIZVP6q5fTPNgBCJReUAZ2IMxndcDTpnP63MsvIFZSVxodRsVdWnapSdMlvIUwUPTofw3l8PGuZ
 TXJPlZsgBeelXdGrTxDcGieHnVne2Md7GgbZrHpT8jAdsZBsVmlrR11paeon5VeHrejdFHO4E51
 EwNzsJ1yTF02laQJgKP+zUnUldNeChnb8IX7VZKg61HN0UlsLNbCykLRYnDwj3iujdxj57uayXA
 94t4hSLQpHYqu8QjMqX4tDVBcFKGhuBsrh1Xg1C1eoIVLApvAhSTZd9lRBdzsTulwBsoxP3WGhL
 StGjEti59beU4pT0sZt1WeJlDLU+k2wST0c4HQSb5lS0ey7iAlA3cD87VnTnJvtNwtbyZsEllkb
 xkMo6wdEfW3b/Dq/G3uGnxMmBqlLOWBQPJrySXcTCr4NjaLjg1DsIBVZ1PzjDt6m/u7cR8w9BnJ
 1ltp/GEUWs1+PMirf+8fTtleHAh8ipAyiuBZZy8ctpm105VxIkXnFgIKm+2/E1DrD2T+5zrXgNb
 ak4SD/xywojcokjvCNu1hOGmKav35bhEKaeJ3o4TAog5eCK9feIj0io=
X-Received: by 2002:a05:600c:3b01:b0:49f:dd9f:6038 with SMTP id
 5b1f17b1804b1-4a027573634mr41160835e9.25.1790947384171; 
 Fri, 02 Oct 2026 06:23:04 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm6264125f8f.30.2026.10.02.06.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:23:03 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 15:25:46 +0200
Subject: [PATCH v8 12/12] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-add-genio-510-and-genio-700-hdmi-v8-12-2a6de7cf2a88@baylibre.com>
References: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
In-Reply-To: <20261002-add-genio-510-and-genio-700-hdmi-v8-0-2a6de7cf2a88@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790947536; l=1166;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=vKAaH0LgO7AFj+R8ZBrKny+V38jf3BdSNRjTxDvw4P0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEg99I6Dvzp7I3rydhqhpCI2zGbZKesp99Myk9gmejnoixsCBZxUWYHvaC7QNGk1CG2x3nrJflm
 OW3dHpUFVbgE=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

Enable the configuration required for the HDMI pipeline on MT8188
based boards such as the Genio 510 EVK (MT8370) and Genio 700 EVK
(MT8390): video, the MediaTek HDMI driver, DM I2C for the DDC bus and
the PHY uclass.

Everything else the driver needs is selected by
CONFIG_VIDEO_MEDIATEK_HDMI. The U-Boot logo is not enabled by a symbol
of its own: CONFIG_VIDEO_LOGO is "default y if !SPLASH_SCREEN", so
CONFIG_VIDEO=y already brings it in.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 configs/mt8188.config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index c6785476d9a..8073354273d 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -15,13 +15,17 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
+CONFIG_DM_I2C=y
 CONFIG_MMC_MTK=y
+CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_MT8188_POWER_DOMAIN=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_MEDIATEK_HDMI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y

-- 
2.55.0

