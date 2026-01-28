Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7265D46C06
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 21:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C22A83C6E;
	Wed, 28 Jan 2026 22:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RX2ySEDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E5683DF3; Wed, 28 Jan 2026 22:54:21 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69E783BFE
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 22:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40438380b88so168685fac.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769637257; x=1770242057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnEEKUJDBszjBBlq1Vay7QiKbubiXi2MrhqGb2+sF80=;
 b=RX2ySEDhobl4/14+zPl/hwmVaFj5ls0UqzdAHD0jERXcbMq/WyxTZDY49+z2slmiIR
 M+jeHTmsWBsjRHA3IhwqopyqczwoZ/eQfs7VhvO7/TL4dxqMqPhBRz/JVnQ8zqy70R88
 3epf3MN9e+uHDlrsEFVq67PEorfKC3mdmR74A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769637257; x=1770242057;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vnEEKUJDBszjBBlq1Vay7QiKbubiXi2MrhqGb2+sF80=;
 b=gf7L0hGKT1yOcszkVR8fAc3CXvCf+8FNIIxutomsiHtwMNW4jb6jgylP/zBfvYxpED
 GIIptAVgGtltlh1zoZfcZDtuHQNFW/1qCEDO5PAHumGz1fOhtDD9O9CdqkOE+1AQJDzU
 Jp//oaRvvo75yvJS0png7P0MZgT/eWYIc6isdbIMvHcUs6qJFs+ayS+lmzBPXupnc3Ff
 JM6DdMgd5YfPvNjmfZTixKQoqEfcyO7k9zWOyeADFla7sPlDzGYUyflDCygvrjVHRxU4
 r+17K3YyxHCfitglFYCJWyAbrLyTNqykg5WIKP1vh6QHTATjOsK/XOQtkcw+7j2eb/g0
 KhCQ==
X-Gm-Message-State: AOJu0Yxfxb0P82S352q1g8NtnWleEeZRhOBX+JFfGTNGqkmee8UzpMTf
 JJwPP19zpl6W5j/ZbmzgFynM8Uo6Q7nVaUNBcoC9OFjbd6keKXbnfNkTx2QsegdWH5I=
X-Gm-Gg: AZuq6aKVtTGTX/HvFejzkHAcuKgoY7w0xPHrEUtkWn8ste7Jw6oP5tWHthw3l0jbZvG
 l6R4moCkPbhJ7XNJG6cjtPL2MWmcbnytuQA1X8vI2yfNjJiv7cle6e8li9yj70dO3wUsXE18IIF
 tikpgBH1ZFlPL5GpGbwQ+g+R5BQC7Y555jHw8375UDFApVJ5LXZT1QnWb/lcBhb/9jm6IRBsIDd
 g/geAluhyeSNq7gKSHBl66s1phJAdaPtf3KJgEuK/WUBtgvbXAB0CbCjuBj1aHbl+pgXY+xRx/D
 OFrOsNYesZthxTY9hrTTktX84J69jNpYKyw0avP1/e1RoCTPNIo+HCdXTt1CDy1sPxijmJhaGnV
 lRUzJQ3bfIyQYr78QNSMJ1I5vyD6JRUDOp07beNi+osNeg2WX8K84b7fo+H9W3z3QlYzu5xj2qR
 eou5xMH2w7fxbPimL7TZ8QY2FHfCTa14oHB4Balg2BrXMSGwWwJYvxm2+eM6tuCA7XyY0DQ9xDO
 SCj7yL15XxhkyEhjsIoQir9zVOE9Vy1ApHZnA==
X-Received: by 2002:a05:6871:8a98:b0:409:62ce:83f8 with SMTP id
 586e51a60fabf-40962ce89fcmr1449282fac.13.1769637257417; 
 Wed, 28 Jan 2026 13:54:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409571ae8f5sm2570113fac.9.2026.01.28.13.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:54:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>, "Jill.Wu" <shu-yun.wu@mediatek.com>
In-Reply-To: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
References: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
Subject: Re: [PATCH v2 0/2] Add pinctrl driver for mt8188
Message-Id: <176963725598.1779019.6630756447147831259.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 15:54:15 -0600
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

On Thu, 22 Jan 2026 17:38:21 +0100, Julien Stephan wrote:

> The driver is based on the kernel driver for mt8188.
> 
> While at it, also add pinmux_property_set ops for mediatek pinctrl framework.
> 
> 

Applied to u-boot/master, thanks!

[1/2] pinctrl: mediatek: Add pinctrl driver for MT8188 SoC
      commit: aa6eb2a5895bb9f0f311522b7d4dd3b86629f8b2
[2/2] pinctrl: mediatek: add pinmux_property_set ops support
      commit: 15999c22f5df791364f0eb6d646c36d735c74f16
-- 
Tom


