Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F8BC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B45781FDE;
	Mon, 31 Mar 2025 15:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hsKnm8w8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4529881E60; Mon, 31 Mar 2025 15:46:21 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2491481E47
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so2408945a34.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428778; x=1744033578; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0vxiwIuUF1a7fPe5RPPR6W77QLvcdWTtk6ecdmXN9M=;
 b=hsKnm8w8sjTaUGLNhnwIkedbN0UCxA/ZtLRrKSF6EqTFaZpKXFHGCBmri9MmT4QQ/6
 tzTVdnoGf6H4JyPELArln8dqUBz4WLrkyS2jz299Y5+wstnQA+pYb44QQLXO2uMobqV7
 FCuZIq3EiH37/5i9aECqIboHCAVAT0VFr+eCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428778; x=1744033578;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0vxiwIuUF1a7fPe5RPPR6W77QLvcdWTtk6ecdmXN9M=;
 b=WsU/R7QiWmsJNg7X0Home0RZRVd5si91CrWvs8EbppwnbZjJeofS6t/zX1Au52360c
 4MBHK5HCtyu1dEWFpRgc+Gz2gW98PysUHkfvBId1mrgZalpIwiX4vzI1sSpuhq0xSM38
 wqyamxipVn+ebGOu0QIVmfcdZ8y7AQmc31IZMPppnQeCnkDTtpawVAeK4T00j8QRq93s
 /v7D/g0/EdeiBXFaxthwt30oEUKsskOT9EA+f38Pu5ga6sncxFK1z4CofiW4Ns8YsVvZ
 AJWHP+vHGf4Fjgspl7HbMiLfoIMlmnMCABlsr8CFJtDKxCHxZbk3uEFQorj76vCD4e5y
 GI0Q==
X-Gm-Message-State: AOJu0YwvXhPVcwaQuq0peRymFKE1HVo//G3Hx9k3A407ZVipqppvVhSA
 i+g/gM27+w9K4GEDp33eqkSWhjhYDSH2CBy8c3Oypq43ZmT4zxivjNCF/oyTa1QZ8vN8yf2l1Hz
 r
X-Gm-Gg: ASbGncur2c7nqbrv/ghv+pWssXWWqFQfXWdmPnOTCSTpN4qghpShCg+75yYBhSb/PBI
 BNk1mE9S2Iv6cNFsWhG87lC21NdusX98+brN1mEOKonSUVJH6zuQ0e4YL4QC962LMG9jZn2Gokb
 zYU2jNdp5uJpmz3f0J3ig4GmZrrz8tHly40ZufYKksQzptya2Cx2keApKxgKRIFbVB3fo4TkNZu
 E9JMcWNTyiLjPMCF7w4Fw97ZsojyQf1hrCU02IeXr2kE3znY4uuBMLXVUUYMH/LWdL/f2LLOHWI
 K5xPso5eCPCxP+Ex/q2c4i5M7Gh3QumsrfNsRcHN05+5nuzFIf8FI7gvREhBjaXKLfYdnfEXgn3
 fPE+J
X-Google-Smtp-Source: AGHT+IFtgn0RtWqTNxI8dHyGPN/0bWNmDa3Hr/t3JHMhKLbWzgZi8xHskCmxKnhtFuwNutmvCfZr+A==
X-Received: by 2002:a05:6830:699b:b0:72b:7be8:7ef7 with SMTP id
 46e09a7af769-72c59a46f1amr8980502a34.9.1743428777752; 
 Mon, 31 Mar 2025 06:46:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>
In-Reply-To: <8ca87e744999373b87ea7dab46b7724e1ae35b88.1741317191.git.weijie.gao@mediatek.com>
References: <8ca87e744999373b87ea7dab46b7724e1ae35b88.1741317191.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH 1/2] pwm: mediatek: add pwm support for MediaTek MT7987 SoC
Message-Id: <174342877640.1318045.10449564178734133090.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 07 Mar 2025 11:22:23 +0800, Weijie Gao wrote:

> This patch adds pwm support for MediaTek MT7987 SoC.
> 
> 

Applied to u-boot/next, thanks!

[1/2] pwm: mediatek: add pwm support for MediaTek MT7987 SoC
      commit: f87b959080d95528c93cc7fcae84768aafc75740
[2/2] arm: dts: mediatek: disable fan node for mt7987
      commit: bc09d20b51336ab61a5ea9c373275338752f9a9c
-- 
Tom


