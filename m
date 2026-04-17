Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A59F8E4BC
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE6683FC0;
	Fri, 17 Apr 2026 10:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xd2xoDsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C448421D; Fri, 17 Apr 2026 10:15:08 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A6D283B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488aa77a06eso6929525e9.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776413706; x=1777018506; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WqEKbwxbqtGB21Uu1wb7rSiQoCasfq4Ry2S3cwkU7IQ=;
 b=Xd2xoDszCmV2VFM3GGHIEST05nbXx6gLGd4dByoeb2Y7f1hGTdxMRnk7qlIZXpqOa5
 wqRPde1pn6iC0jLUJXkKn+7hWTAwEUM1sZvVH/WDf3jSb1PUsNHg7uL7JFraauvrGqht
 +/Qm9NSMcT5BlDRBbO3EenoK/Tj2QaR+i8q2xcrxQEeqDEcOrnTMS5YEHi6V6c+NhYZT
 8E/xa7eTK1VBaqz8dScahNNpnHeQAYoc2vnKeVUGNBm67+bi+cw5PyBVrwJdRzsLmDdn
 7pfMHQjrvsyj3l8JR+m0Uexxu5laHj5ixdbmEwTdjJt4SwejmUFnuKfj1UNUa1qb9gBN
 fohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413706; x=1777018506;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqEKbwxbqtGB21Uu1wb7rSiQoCasfq4Ry2S3cwkU7IQ=;
 b=QNN575FZpw5qXvgMLq3HU5qJqHazY/868M6F/0pIVfnfEC78Wd0iOVYhCwMyt+/CaX
 J0zo0FbCkmKS8RpxvzpvE1lBjbaRTDDScJpx2cjqt8yK9yOV7Vks6phlaAt+l0FLW5P/
 YvkCJ1Bs9vQ/BqLj2k4JuuFAAS343hGxh8Wdh4+Ockmhp8zqCx5EbPThs1gG7ZRM250L
 Gki7wwQUGZEdSG0333pRFVaQG6p63auhC0a80wYDpr4UhgHFbAVbzaITLSKJvTH1Vwte
 dTt8YDmC3byXbgyyVRNHKT24sYIAaFZh8TqanKQrSFt94gvtF6JfHoYuwGFs8zgJgtaw
 0bzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bBEGyCH79nkjuPWbWFNzhsE6ETiil6MBoruCY/RgRNbobXmj/KpztJEn/pSUWXkP4VglzV3M=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2ZTtSFLEqsvJz6LbPplGGE3fYY8SNCOVP9RxDXVE86tXbQfwS
 AXG7D9d+b8+uOlIj+1nU3NeGlkozw5g1W3eRruMSELzm4tHDHSIXnKH6
X-Gm-Gg: AeBDieske+BWO0CzMI+ZSpXAWksQdiMxi1ZDCH1qKAuqJJqKCNt9puRZNuhNZPJBUNs
 Kafq6WLHO3QkmMEfOFrME5lNoRyrj/0FyMlzeTUcb7uixGJX3vRwD5X/cJsHBw7cCeX75urBsvE
 V2oCANI0+Y1wwa34Diog2Lygs+xyhpBVkNy/fTqT7pWxxXAzW0VtD5ADSF1q6r4MznUjXTF9s22
 9ZtlFlVGYYdT/2TzGExByrMAh1XvNhdkhAh1WXTC9NrahPblXNUOG5s91ycyqwCNMB5lX7lPHFg
 1xJHGTaW9VocDk4QIYJaW5LaJ03s3wlr4xv++PhN8o6kE9ZFpN1oHGUa8XkpLwnKwoFRxCmzrft
 pd/jQyaDy6DRfuakgnVC5N35Ak+MkxctKFK3UzOHxYFvO/iV48LupNXzenVp9mYosBqr531Atpo
 jp/VwGCK5DxSIuv/bAhYjZNPs2vI+nKYbk/JtO6+lmYpMYgOTNegS0a9Cc75fc6vCP09ePH51af
 sRW16yi19DAyjYSus2R0xXsRxo=
X-Received: by 2002:a05:600c:8883:b0:488:def6:bb17 with SMTP id
 5b1f17b1804b1-488fb73a9admr18016865e9.4.1776413706242; 
 Fri, 17 Apr 2026 01:15:06 -0700 (PDT)
Received: from [192.168.1.3] (host-87-2-163-213.retail.telecomitalia.it.
 [87.2.163.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a0b60sm10840955e9.17.2026.04.17.01.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:15:05 -0700 (PDT)
Message-ID: <1f0c0b0f-c04c-477b-baf3-be22b94c597a@gmail.com>
Date: Fri, 17 Apr 2026 10:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] common: memsize: add RAM size probe based on alias
 detection
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
 <20260417071546.1610330-2-ghidoliemanuele@gmail.com>
Content-Language: en-US
In-Reply-To: <20260417071546.1610330-2-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 4/17/26 09:13, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Apologies, I accidentally omitted this Reviewed-by tag.

Reviewed-by: Simon Glass <sjg@chromium.org>

