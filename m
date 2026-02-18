Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05375E9A04B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 19:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4FE83AA9;
	Wed, 18 Feb 2026 20:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qZF3eQn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A997383DC9; Wed, 18 Feb 2026 20:26:49 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9971783B99
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 20:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4043b909ed4so104427fac.3
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771442806; x=1772047606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J0PtHY4bv11L5oNDPQGI7Oi8V1TB0JwBoB6BQCt2+8=;
 b=qZF3eQn0SE+m+6D7/rmcn79heljtCSu06xCUzSfhHQ5HGHrJurREvbLosfGPYztHoX
 CYU48J/bXSZRaWdxjkg57jElylRryo/WXgqdrdmI22bppNbqsZ+15E1mwtdSmMMPJCVr
 S/ve9+w3bQQaNTC2cVWqrzZuu1KcmVK9oMr1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771442806; x=1772047606;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6J0PtHY4bv11L5oNDPQGI7Oi8V1TB0JwBoB6BQCt2+8=;
 b=ogaeRLh72HknREtJkZPn/HotiaULUxwq26eYMIJMfJ6wE7vuaP31q55DF2twCLJzwd
 RO1FLCAKUdf+hOhDqsr2X6HJM1BzUr3a4A5XSIub+DFTcTFFvJjUMdJM1oe3RhEB0O81
 bZRrx2JOIPztrvZ5drPQIuv3UxwFzd0vRP9XMDWQkGk97vBPYKxWQMRPMYGZkJPFyssd
 00NsLUxZEfTocIibEtBBWrZGpJrr/8S3AtvaEF95FhSotNpUNDDED5jlAPzlyvFAeZwc
 5ud7S9EuLmDpgD7rDILGDWE2PeptrKZajpx0Rq+HALzfqDXNr9gAypEiGuyMo6LDvHlT
 WwrQ==
X-Gm-Message-State: AOJu0YwNAcMi4ORn9GSOTELnUrVvQ3KWHChI+MxzKOl1t65ZXrbAg20d
 NwkjkG2uynjwAz9SUTf59L+0PBu7MMZYXd956fuA1dPwijMxJSg4eNTKw9w/VNm9Nsk=
X-Gm-Gg: AZuq6aJRyhVLogEW600WZvdWjASrMcgDDYz3sROBq50BLxy4ieXp/q5k9ZKAOKoBude
 pSuDrtQRX+cxsmMq9SdHkb+6zAlHH3DhtBFk3vt4SwgeOpGw5grhh76G+f95/h4WmwEwBhf8LtD
 wy9CvqwOfvGwHb64Y2NgwIl8adComIDyYBo3eu9y6Ko8N9BS5a1zX7mYIn1kxfAy94QiF2XDnXS
 Uq7X+ZJWnnnd4CwNVVPpa6oHd1bOREOZzoEWMEInDoNl5htfNOf+cT5o/g6Yu/tYQ9YSr+Ul4kX
 E2mRvsInZmIUorv7IrA5YVJGCmWHARUyQvzFyVu2c2VqHK5bbJpQCMDyPXHKdpnPTsM8Cg7auss
 mdVdjOzwmHmGPA4VCWKPgdsbturuw33sot/swzpKVh6YWofaWGjfVosKM0liewqZbD/o8rUDW4i
 rw/yneX9QBv9nXCkJOR5tnh4EtZqv2Aa/+9vz+D0E0A9lP2YqiVLR5lTkH8wARLIyOxJPI8o6Cr
 c12Cble6hNLPO0afUTgRa6Z/KUlxem9oK/CIwyGu+onFwjLTg==
X-Received: by 2002:a05:6871:10d:b0:409:77d1:f91d with SMTP id
 586e51a60fabf-40eeed3ab04mr10446256fac.47.1771442806214; 
 Wed, 18 Feb 2026 11:26:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf1e858bsm21568269fac.19.2026.02.18.11.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 11:26:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>, Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
References: <20260202-add-mt8195-clock-support-v1-0-5d03495246b9@baylibre.com>
Subject: Re: [PATCH 0/3] Add MT8195 support
Message-Id: <177144280500.3629982.7785134837514895249.b4-ty@konsulko.com>
Date: Wed, 18 Feb 2026 13:26:45 -0600
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

On Mon, 02 Feb 2026 13:08:10 +0100, Julien Stephan wrote:

> This series adds basic support for Mediatek soc MT8195:
> - clock driver
> - watchdog
> - add a new macro helper to define gate clock. Other driver can be
>   cleaned later to use the new macro
> 
> Other driver will be added later.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] arm: mediatek: add support for MediaTek MT8195 SoC
      commit: 2517e2b524e8af3d7ac7285c55c3867603429155
[2/3] clk: mediatek: implement GATE_FLAGS macro
      commit: 5f2111e9ff79c85ec389c2a2bb75eae9118fe897
[3/3] clk: mediatek: add MT8195 clock driver
      commit: a0c5403283f1b506119bbbb0c72fd2db6a346196
-- 
Tom


