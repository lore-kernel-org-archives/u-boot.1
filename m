Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4458DC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 22:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6701280FE1;
	Fri, 31 Jan 2025 23:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D5I2OcqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A712C80FDA; Fri, 31 Jan 2025 23:07:08 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5896780FA4
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 23:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6ed9ed5b9so403833985a.2
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 14:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738361225; x=1738966025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1VvG2udGvpLkm45Dpp3xoDkBqdXPV3ZS7NmS/j3KfLI=;
 b=D5I2OcqPrHgx+Z9thte0fYhymE8CJYCflAZ+tOtpApYPAD7ki0TUpnFNhYbX8bX/px
 /6P8VHQfV/y21S8KP59u5PI1fcaR+0m4OBAmsrt5XXyq/qhP2/6CuADR4yBtmZXTcslZ
 RtlSaglv2WVVSOsV/47IExLNe89lvRgil25FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738361225; x=1738966025;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VvG2udGvpLkm45Dpp3xoDkBqdXPV3ZS7NmS/j3KfLI=;
 b=KkaCk2OqiUraPkMRUjdWvPeItmVpy9T1hhmnLaY+z9GJvqw3t3+copnqBu/u7dzrnA
 UyVbzaZi08sqfawKS+n/iDkpY2jG141j2reDdUrajxRogf7ZEL8hUq2DuzbYGIzklPGt
 vA7ojPpeslBFm01XDgFDg6fSs4w6jj4hCYhu7Kh1+CORb172lbejteFKo5vlpTjvgPtr
 XoERhu0aarr+3sfhpM9HVewpwLJujA5YEyZQGCUBrM75SQ2Y0qsysaJU4cVGnQJ684V8
 YEnrkaP6OyCaiA/NQlgKSyz3jlRZrXZfNQNsoom0eCFzAdYKdmXfI22I6AINefC1C+L1
 j3mw==
X-Gm-Message-State: AOJu0Yx9ik/Fa16oLiijAojFiFvkPOLJDA1W/3oYNkjhCvPYP1HkdsUJ
 nZLUQaObp7vIWLNQ0HVi43gnCJwWYjEa7lczpezS4zW3b/6YbeJlaHxtU9MwFRY=
X-Gm-Gg: ASbGncsWRfn9uMptqPYM/YN0pNAUGcfRpqfK2NcC445Y7uVJGN36Al4OS5KPAPT2G/F
 R3vuXFdwn/6Vk+rF8phO3w5hxx6x187LACC+qZysu7NE3cZUIFe/Q5WCqWavXieq3TSonkNx40L
 ahDfQ8HUWAUmWbFQFcVRSFN8GXk0SfVdfzHyDvHf426EL9JEC+Wtsf+cXt0dZxatvKPE9u1571Z
 Fdm8tLz0sX7r+nxy6bg1yazM3gNE99dLRCkmWwUp9xFRQ5RnMZ4EkvIrQ8ONGOi7pYv5bvP/jfE
 LQ5fUv2dPWJo5A==
X-Google-Smtp-Source: AGHT+IHawdined7fRhb+EgshYVN+DXOq+7XagStnBOS38QM+QP9D3/4HnBl6eDPI5GM4SZJco6jakQ==
X-Received: by 2002:a05:620a:608a:b0:7b1:4a48:56bb with SMTP id
 af79cd13be357-7bffcd9b597mr2200619185a.56.1738361225310; 
 Fri, 31 Jan 2025 14:07:05 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254819a57sm22141986d6.45.2025.01.31.14.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 14:07:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sam Shih <sam.shih@mediatek.com>
In-Reply-To: <20250124033902.187796-1-weijie.gao@mediatek.com>
References: <20250124033902.187796-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] pinctrl: mediatek: update mt7981 pinctrl driver based
 on upstream kernel
Message-Id: <173836122338.3060818.14569385105843577079.b4-ty@konsulko.com>
Date: Fri, 31 Jan 2025 16:07:03 -0600
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

On Fri, 24 Jan 2025 11:39:02 +0800, Weijie Gao wrote:

> Update mt7981 pinctrl driver based on upstream kernel
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


