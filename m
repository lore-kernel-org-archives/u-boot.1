Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7F606A33D
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UWrnkozH;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=G/QnnN0i
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD983810C1;
	Mon, 16 Nov 2026 21:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjwFk-0MOMor; Mon, 16 Nov 2026 21:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5D8E810B5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794864934;
	b=Y85dff5RQIRK2KwShseizanSw541tkgCcL7gZNsZRYnQxpBrOl/wjLV8L1qfdju3rjvU
	 Bk7OdUtfIUQY2nwmqT/gnQs80jWN+kWNtd8eBGESH5VJ3Y+3AUbVT/Qy4qXBa4KeoE6Mx
	 XzoghnZEC7arWQEz95wdssrb87mGKofWy0ncGg4lUl82DoeLLezFMmhZfCwlukaC1BgPp
	 BXHRBOqFRKQT4aEBJj18yy+PWJZ9w0yZBwbyrx7B6hseOeTY7wpzE2zNVfiPKt1lZICJT
	 uEb0X5kgHaQFY0wqbOWJQqy57TReL9YIQl0mHxtb/B38Rdnl2BJRRGMbEyTnWZM4Lng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794864934;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
	b=aToZ0g74/TuNKFyHZbO0c5PU0gVuieJCxYxRpzVN9kX8OTsxwD1rM5pyYN8jjYiDIOLt
	 jxTxUQ+jP7wt03WOnyFhppcmyNV8WqxJu3twY41XH+XaJr8eJzSF2WpPbC13stxfL7xoE
	 ThIGzngSbZ2jqZtQBp+Ubx17xQV78OfnbhIUfTqZYCKl7ct+UA0ZI4x8Ps5CRUFeuOJqF
	 jRyL7Gm1sEAwdVDnHh8z6HeKb+xoAwf7HsSgek7VJ4AHmNof1O97fK+HKhlwkIBjX+wCX
	 OJlw9+hPJZruT2dj6EQUD3oywQ5McIjcozd1LBA4z9ytUvRzreP9Ru0t3/ZwnumZKFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="G/QnnN0i";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794864934;
	bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UWrnkozHbvFRBDBBnfJJbfpBMUS9lP1bt7C8kP1Jzs4lni7+BPqgQhwRmPDwfO5Dy
	 iEMLR9+S6Tm59CxvS6KnjCB7F9AghMW/CyX4p081LxyaHRCkQjQpUsdR2+XGyPcY12
	 6LecaSCGp7fdCuDI5uHbT0sFEop2iiqAWrOJrAkPHOyx7/QyX6pFdgQC+D4vpNl3bV
	 8Pzis4lfcmWNAeeE+GFs4B3mrOn9oelbeamwH9Pnb3ghwi+jq47UN5+54Fu3TCl+CW
	 gJHn2o6XGO+1o8WJryLb9is33w4kr+wTo8V9tUi+YC2nmy3HTWo3luVxxQhJ1QVfNN
	 EsUV3IfK5s07A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5D8E810B5;
	Mon, 16 Nov 2026 21:35:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9457E109
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88FB481067
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TfiEtKWGHtip for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 767B680F6B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=G/QnnN0i
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 767B680F6B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:35:26 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so2208292f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794864924; x=1795469724;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
 b=G/QnnN0iO8K8X8ttJ7y+RGb/UzA22DBF1nRtTdgS0C+shlFtZn124mvz+XBzNRCciY
 JjxwrOGm9OKpKvm3/bvL2kk0+6UW/IHOtJ5QGZOwwJ4mg8dOEgSF2EqZD9zW9UjqxsWB
 vK4ntdOrtHy+wop+7xSstq8WvL+d+GGA7/yBsrJJX5vQY4jilVAccd5Ic8KhHt86DCeC
 qZ+JcK0C9nm5NDmptVtE2rHrn2ifmSyNRrRq9esXnJJoFGC6GP8ONA5VebZLjVKqCuWB
 mtoR6AW78WEhw1t8qru9C0OFkKEHSDeczEc1/SsmfrjjV6OPyrELydtNCt0dIFcqbjue
 0pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864924; x=1795469724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=29s80oPd+cqWqEmz1NN1Megwgv5PvEDTvObjepvvfhc=;
 b=TByuUX9jjT9OddI1dcePRW11c97Br1sMNSiG8y4C/gUPfE+DLD7NsP33XIn93hrJD8
 xwekRsUOzfxcQgVF3FjC07Yn0rx5VFVzygPWQIzSvN42R8IK+ZIOSqkJtixCqt35iXVo
 loyv/iv1cLr9r1LRkliLjLJ8voABvhct0LENNtJzvjBNt3TWHGpbG/CoJi07dAgDkQ6S
 LbSzp1d9amuVN1o2jDcKa5OKkR209NyYAM0Mspev4dcKzMtBaz/U0ngyHxFsH3sElRX/
 38Buh2sb164riBH8qbKagIGF4u/XeVgADMbiOwDLYsrzFpPKxmgxCAOvUegEgg9P3cb+
 2v0A==
X-Forwarded-Encrypted: i=1;
 AL+hErEImjgLFlTNCJ6eRI4HHZyiXsxFbiKTHDDRZInl2cueBdndAuVXEfNrfpmll5u/KAOKv9dOH34=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8bY1Mbvz639dWXcHXHlQJfBhQGnvRb7DFfDfvhuC4GP3fkY94n
 hpBuzMN5XCOs96jS3ovgtQLXasv1SVv5NN/o4k78EX5Qoq1e/IiushVw2QlD2SxlTSM=
X-Gm-Gg: AZFdTZfc2f9+l6TE3K9f8bKcBSqFNUunxapyxRgk8XaDA9T159ApSLBZJtWj5C3kuDF
 03du65wR3xAFXN8D/sX630Dm2kAE0lpS3IC4O5zkhCyMIaFXGHN6leIEKFE0PCbCQRW/uS154io
 9qPJHvrrVoeDRrvVhcJnSFfYLbADGW9XuSbiDYbiFtNdsIWX45SirOtGYWUjP6cLlvGPx4DGBHB
 3PnIWTAVuLKN7zeulSbMFN6WHScKRyczmtqAdkVuXOTCsnHdXYglXz8swsMDvFiX8hJIWTaXuGa
 Qm6IZFHBSx2HqxrUq/UCxiozpIMlZc9CqKqbW72bS+1z7w3zsc6bQuc0psKDN98oFLgf0MEtWqU
 vxTBJ08GAGofnJHKUCsuTq08UB3qVJ5xTKEBZmdEifm6PCOw88WSWox9IguEmXIzLmAfWJ2JRD8
 nJJSgvgKIQ/2blPwgIosSxjgJbmIj79CTqrNyr2tcI5/5JatVE+8xUE48+vHv3sPRAsEeTC2d3N
 XJvZQhg7dgfs8H6vqRJzLmSMCL5IeqBCHOmJ2ei68Wd2+UOd2V5b1CXvBX7Q60fq3eLyKrWHtl3
 1qGzGVQq+yv9nx0z8sE8WXgDmzdLKMa0IGvu1+1UXZpL7o/VRbN75q4bXN/3v/tsaBhOnPEFRSU
 lRko+u1kPKRhDfRqidw==
X-Received: by 2002:a5d:5e85:0:b0:48d:f391:5c45 with SMTP id
 ffacd0b85a97d-49c740bcf7amr22918622f8f.42.1794864924255; 
 Mon, 16 Nov 2026 13:35:24 -0800 (PST)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm26314066f8f.0.2026.11.16.13.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:35:23 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 16 Nov 2026 22:35:03 +0100
Subject: [PATCH v4 4/4] configs: mt8188: enable USB host support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-ccaione-upstream-mtk-g700-usb-v4-4-2de4cf90365b@baylibre.com>
References: <20261116-ccaione-upstream-mtk-g700-usb-v4-0-2de4cf90365b@baylibre.com>
In-Reply-To: <20261116-ccaione-upstream-mtk-g700-usb-v4-0-2de4cf90365b@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Genio 510 and 700 EVKs use the same USB host controller, PHY, PMIC
and onboard hub. Enable the required drivers in their shared MT8188
configuration fragment so both boards can use the USB-C PD host port.

Enable the MediaTek xHCI/MTU3 host and T-PHY drivers together with the
PMIC, regulator and onboard-hub support. Enable the USB command and
mass-storage driver to discover and read removable media using the
existing USB stack.

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index cd5e68dbca3..f59bd86cb8a 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -13,16 +13,29 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
+CONFIG_DM_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_MMC_MTK=y
 CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_MT6359=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_MEDIATEK_HDMI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set

-- 
2.56.0

