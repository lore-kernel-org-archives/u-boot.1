Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8EAE9A04B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 19:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EF083D5D;
	Wed, 18 Feb 2026 20:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k4P8UPvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE4583DC9; Wed, 18 Feb 2026 20:26:50 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87A583A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 20:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-662f5c5507cso122636eaf.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771442807; x=1772047607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XaJy+AUbODfvNhSZGcXGNHaq0WGmRlvGzrRfyyEzWA=;
 b=k4P8UPvQ1AYkTGTNl7o4jEGU549LdVyTEditsM2bTr2YDkaFTX1q/OQhfydzpaNbtw
 YTuRy7j81lCRpzBzdS+WhgmQFX+25eYK98kMw3EGjWOvy/eoV3BLakQugt4SZL5t6ovK
 RVKPlmVLs3WX09hZn/+vnqjh5hTYWvYxyBpSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771442807; x=1772047607;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8XaJy+AUbODfvNhSZGcXGNHaq0WGmRlvGzrRfyyEzWA=;
 b=b5JpplY0T0qC7l3KGWbb506l+hekQPV5n1ZmEfRTe6qFwJMny03Qq9jGLCjwRfeHJz
 /l8PfvYNFH9RdWEgcJWrXbBfDxjM+MFeyd0ubL2rPBNFBGGg1k5Z+wy7N64eGiRsWN3i
 egEERCdb7dObfjTKXq6Tbkl21xU6/fm4J8YO9iYO58AljvCc47umVfTAfrqskifaQqn0
 IAn3Ea9mAAwARCM255gzXnRq6CIGe+lnGMkVgrW3BjHg2SKWD09P46FHgU6Ft90Dj0y2
 fYU/N0HFiiBWTo6dOUQBYxp844IdU1cjxz7g6+ZA8zWxYObBN5GXGRzhxysCe4UgB+TC
 iP/g==
X-Gm-Message-State: AOJu0YzL4kxVKxd8AxCz2pctgeav5XPVU1Y7m/PbAfeUoCvdhbs4LBIx
 vH/u3apnJrM2yOuIFvpchFzL0MWPWqALKihTS7CSMHGZbHaYkN2+wBSNZTUUnN033N4=
X-Gm-Gg: AZuq6aIZm03Cnf7uYU+ZoQK7RbFyRpv2B6pU9rQqz1/31BA05dUyaUytafw/OImggHZ
 SRTOcHxOy0kcNOTPy6Ij3wxSwNiwmgQrSsdhjm6QpyZQCMp3W1q5pdHmdq7AZ4ezN/+hsI4IdYY
 /ijTtRVAIhbJz00GmuFnAoboNWxGhtBMQmQwPUvAgCwbv1B2VUwQocpwieiCO1OiQHqyOmiwdvi
 ggA39Eb5P8uYhahzGZU830l25jSaBSudwnPahMgpt8nHm89J2I77Amot8Ejo8E4Zeyo2suoxIlC
 +IIdgAhQgiFvP3iWnUeKzw/alwXipIrZWySudvRb+w6WJVuLLT49Nr9PrgjfcVYTMEZYoYfm8Gh
 ugQUjRdix4OmDQUaZPIlrWcJ8PkG5HSLWHI0BcTk817Zu0ZvUg+l3nhsuisM1vLAmW0wF5ZIynr
 /tm2p5mRkYorEuAyX48py2f8ck/Zi4b5+UNemYQaAV04hWZFwXabMYoKPSi7i/OzheR3TKX+Oh4
 3YjgT8Y6dhgtp/KX6uVrv1KyZMbFIQRmyg1Q20nEOADQCzKow==
X-Received: by 2002:a05:6820:2011:b0:674:2eda:cbe7 with SMTP id
 006d021491bc7-679aef1a40emr151227eaf.52.1771442807434; 
 Wed, 18 Feb 2026 11:26:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm21568269fac.19.2026.02.18.11.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 11:26:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Shiji Yang <yangshiji66@outlook.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 developer <developer@mediatek.com>
In-Reply-To: <OS7PR01MB136029C80ECF5AE153DD40706BC9CA@OS7PR01MB13602.jpnprd01.prod.outlook.com>
References: <OS7PR01MB136029C80ECF5AE153DD40706BC9CA@OS7PR01MB13602.jpnprd01.prod.outlook.com>
Subject: Re: [PATCH] pinctrl: mediatek: set MT798x rev as MTK_PINCTRL_V1
Message-Id: <177144280643.3629982.1782251475652101044.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 13:26:46 -0600
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

On Sat, 31 Jan 2026 10:33:50 +0800, Shiji Yang wrote:

> The MT798x series SoCs have IES regiter definitions. They should
> belong to the pinctrl v1 revision.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: mediatek: set MT798x rev as MTK_PINCTRL_V1
      commit: b681f2be8cc81de83fdd4c56cdb35755ca0409eb
-- 
Tom


