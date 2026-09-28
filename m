Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B8CCA5FA3
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D57F40750;
	Mon, 28 Sep 2026 09:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Td44P1OZKRHa; Mon, 28 Sep 2026 09:18:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6A88F40783
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587080;
	b=WqSLNidu4PRZQxsq4LkSIFpOGjKpm6JvrU2sm7qO+2zCwDXsHYBPQGEq2Ai8CQy0dT8x
	 0wQ3bEnQwogQ3rAIh3Qt3v7apzZdB7PoWzit4bMg7GT4Ty9t3YC3SiMkurTp/wnReL9xy
	 fuHophFcoWIV68H+Z1G8CRqOtl6Rpyb7uoj8Xib/Z8Yo9m5TbU55FJ7CkMvud1QJTNsKA
	 dE0NHiDTvOd4fpr7iS8yccV97EJFFtrTEAhA5PVwIt+cLW3792sU+s1p/mSKkNplhrJLS
	 3JPRr3KthC1AI29yvLX3SI4xKaMnJ68Q5IBJ6wvCGEFCRP/7deR77XvOc9JavaxlimQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587080;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
	b=VzmQEwrjmiyLghRSq8tOKfh9Mbf3IbpVromxX3BKrJVK6jylPo94maU8/junC8F5eSxv
	 VFqT3oyGQAnCYjfWZk6uXHg+hMa3NaS9QXy8jA5Q4c0Ge/XJQ1EmSbiyUmp3JEVDWP7yO
	 314tj3/C8bZ86ZkXFfNvtQ7+Lo5vzjC+cCc1JfFFUwVEGPISygHwtzcTar6jlvJm6p6Td
	 IeybDStLKqa7t7LBpV9/7vILauQIreYYjdQtcjVf+ujRhPONc7OYTJk1qpp5OnIPhdGT5
	 sg157L3FKH/zL0czq/d7iB/s5jeRAdYPhWE8HUeYoMyxDdwZEJLwsEAth7KNoQNdg1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587080;
	bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZdN/fOnyn2qqPoyYKtxVStv/p6JuLM9CxMYFKF5gg5fzSS2bOOxZ3sNG5iULPgHgd
	 a3A1Uv8wFdDmYLVwmOI+fG8L++wJOD1dW6NsqScA8wBsalPWthViC9aaAFKELzr9mF
	 lO/+Hrw6XRr6GS4JB6Lzo93GFoIFt142A3sI2lEa/mmJjo3czMlaUJv4vHua6deeMW
	 66lClkDJqOWBjDhK2zJtBhJG+cJ46MPUSHHagYLv374zxmS+w9NxKETWdSfYfFCG+t
	 Iuk9pso+NgI5868262/IWClO6u8LbFXP6VFtquwBMSukFmZQSe0b3yhPTu3h8wCI+Y
	 1oaZzmtiETafA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A88F40783;
	Mon, 28 Sep 2026 09:18:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E757524E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDBA7606BA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MeiW6sAayHVw for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DCF196067D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::17"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587070;
 b=l5OkaZ9xub8eIpFtaO0M9VV/Mt4LRfBYOQ/BAt6fqEKsWBholDYpLPx3gYj89fRURglg
 Le2x678Wohmun+nBMs1j+BYHqN9t4Su7VYjk8onVyMs4jJZz6W0B3fWBmF13ZikUxWBvj
 Nlizxm9qBPpvy0FRn73TMa/RP4v/btOPFt7MspQi7Cgp/k8fpLmNAPlKcdmv4Tm4RI/cF
 55M2rbUdnMxYYWJtFe4vgqrdawlK96z3velLAe8ZAtpY9/K3x6LKLOaC33IEVI81mOl9S
 eX15UUamXI31GsoEUq8gqco982N6kXxOxrCt4JDgKEDAfwcws5W7H09C4jYNrUKyaFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587070;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=Y/PkXDLvDl90zmbe8qUw9kb++QfuhWBVR6MvHBrGUYv8jsALF5l9r5XHao0Hs+BOS9Nu
 kK8/KNv7HnAaTODS4MaCgblMMF86wLt5A3Pze8IfBxu8stDRlM4AtgHe/smAlRh4k4kWx
 scmsQ1HMODJcsi+ry3rC44Tqp+LkQNuMhTzLwVuG3MQsZvVhKKP1+IVVwyqRNwfMCdfwK
 xWnD6dVFaPfT4xQ+frnLprh+Vp6IKsvs0YJsk3IcPwpXwfTdhWgsqbNYUyv64PJ43A8r0
 d3pWK6SRjxGAtBdrIxG5wiqWzLaYENuuXAmeqj78wNDdoA8N1Og43oyjskyyAxgEaJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mEvRqkQC; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::17"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::17; helo=mail-wr2-x17.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mEvRqkQC
Received: from mail-wr2-x17.google.com (mail-wr2-x17.google.com
 [IPv6:2a00:1450:4864:30::17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCF196067D
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:49 +0000 (UTC)
Received: by mail-wr2-x17.google.com with SMTP id
 ffacd0b85a97d-4888598e4f9so1564658f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587067; x=1791191867;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=mEvRqkQCVnSVQcFummLPQpN+orNd+lrV5gNz5Q2NOAiYGUSlYujMwXoeCzlzOx2gTa
 YzQQ3r7coildb/wPOBYWKpyZ9IfL54+BwAIgIUli0azDoeu4BFLZgicxvB1Rj7FnhltI
 QpLF1W3RnXFqbPPuYBcKuWs08B+5g9a5E86UE5lV5JCcJubk0UwQ8yO+sqsfJj9t2Dpt
 JkawW5HjgSaU7hMk9sOyURhTKT4p1cz/ZE3e4qthXBK9K7+5Y8Nqvraij0A5lJiBOlCL
 x7m8reaK75sct4Mjih0iIkCLbBL9CkIrUDHWp/6pOigYjf6HAIAMzEacwHd4mDozGI/C
 oTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587067; x=1791191867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=twMndfb2ysm1O8V+N3iUR79RZrQpEs6CCP0KI8JtDgw=;
 b=HjkOVeO9Xx3qFMIZNh7KyeVFb30BC7mSdnWLH+RlWz5kEbd7VgBxrE4DSTjzNO9Xuu
 tm9woVcy5d7asv6KU6v4l3eKzO5s76yBTwp5rpR6v80O9SsXw/ZCyktgmIxDsf3Dq7A+
 7wwpin18k7dAoONLg3slx1ABXwLlbfpXe4NvaYWM4rPOGZUyNoPCiOAJWMWluNMb98xx
 rPjnY/r8p8a8E2IUalOoGvVaji+ZRxoxf+esVZwkIrXQSJRBUurxD9qAH70xE+wQ5rhU
 DAaIWLKKS7RBdk77FjBTLDNzpYQt3SEpoHp+kL2mFlOMX8B9UDwrj81+BJg0eYY7VR8j
 ilKA==
X-Gm-Message-State: AFq9FYLx7yuNwK/22dq+kVTCVz6S+WevUmgKuZD3fM3jIO6rcOB2cZfk
 zgGzmEYLamijciuZKI/Tj5P11L4NvR+rrjOOUQhnUKmPxlDKgLLd3xJcUXlsysMQ07s=
X-Gm-Gg: AYBFou18cEduZIApxYoVOD2h94JiInzY5EvLVfKhiIASH4DREk3mXUTkQCqpZwQblFq
 Q/43938VkzNyNpD6v7Rl53X+lGmI58Gl8K4igyR4jI6Dl9JNZ78fKOmjE+IQkFtMd9j5qpnOmI7
 wGm8MDZeCurE3/z6vwShFwr3DjXZsffrhjMK+LTLedwPFZMD/04F6gyozZFZXZHSU9XWHfGgm+2
 u+lDmuYED864FU9khRNaAf/c7hFBuz6TxgqyF3HQqQ4/te/5BmqU0kbWgBwJP6VcKFYLvYij9cL
 3QyhFn1kHJgQipwGca+obLX01assk3Fi0NpQCW5PghwQSaL3tKQ2VG6fb+LP1Iof4u7Tf0nknDJ
 nVf1n+L8eRtb/SoJpyqFzHeceZ+ncFIAu/KOtesqYGeq//VgQCy874kVBVJvsbU14DwrpWoJMfh
 TAjgEiWODORi9AblIUxAY2bqyTbFlUhoIzU/24KWso6HGfZsxPRxBqfG7DkEVIhS8W58I7bmHUg
 5vxEe5DmskdJCH8VC3BPhLA4Oh/07d5GSOqtxpif9vOhzLFDuNWZT2GMZw6/sBSwMj2nBIKxSc/
 a2rA2t4Lf/dR1y5qB/quSO1saKfoYHZlottvBBwsKRFbZOnZlV+/p/cs1XH6xIlYjg==
X-Received: by 2002:a05:6000:4023:b0:487:27f9:82c with SMTP id
 ffacd0b85a97d-488716f74edmr25089490f8f.33.1790587067461; 
 Mon, 28 Sep 2026 02:17:47 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:47 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:47 +0200
Subject: [PATCH v7 12/12] configs: mediatek: mt8188: enable hdmi pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-12-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
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
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
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

