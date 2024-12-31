Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C570EE7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 21:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B72803DF;
	Tue, 31 Dec 2024 22:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ky+pqAmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F372803DF; Tue, 31 Dec 2024 22:17:42 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1C580391
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 22:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-467a1ee7ff2so84338861cf.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 13:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735679859; x=1736284659; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdndAQfjoenIhY879T2YSr91OTK2Auk8jGMtFWaPqR8=;
 b=ky+pqAmOaLzCi+4e0mZfAMO8PD+zg4yqH2dnvaVbJOsdAI4wCCsCcfpaD1NvA7XyDE
 4x0IrDMxCdw2MoSElmGoMMgjURlbsJaihHL9gbrDqxhEsz5mRP+vdU76Y2lpPUo/b3AD
 5GZ1FY5jNBHidHJt0mDKU2vCs4kIQZAnXEndI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735679859; x=1736284659;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdndAQfjoenIhY879T2YSr91OTK2Auk8jGMtFWaPqR8=;
 b=sB1iQyuQ6tFOfmndWT8nDsHs32utocuhsIGfQsihe+LGUDRyC5aV6yXN53OlvqX2aQ
 OWznarlkZlqE4r7jIbezsdr5rjXywFZd+MnM6Tqob0Pb+zvqhJ7lw7yNAL2I5LxPUX4g
 iTWCXgYj2abppD31Bl0pkBTgg30IsOs/0u2KsKH/ydHC4vBOA46HWhpJb23FJJjW/aC3
 oYl5kuLhw8n4Ntk6+USY8M4TdS1HEwhtVmSXlVVw3qvnqdlFeL+mM7ITly5rToIMu0cO
 RixZbfA1micxSKph7VSwk3+KeNJkNro41YyBVPi9WWQoWgVUGh0osMzihFxSJr8Ajzid
 QrAg==
X-Gm-Message-State: AOJu0YxejZOjEqejsbX9i0o6FBEvTvRaUlHlqXKGqfhf3zeeO4EYv6wB
 xPC62v6qba6TlSLAjMmufYI95XkWMBv91KDreGbIzAMrVXkr+R45SumYbYClHHo32vuN+kSesIq
 xzPQ=
X-Gm-Gg: ASbGncszE7DLvmKV/8lnBc6ojBWQBhUhn13Jg3m+HbbcuaLh/nrT9yycjiep397SEdf
 4hHHzZFnQwLOkQ4ihE6oT9KNayrYh8lBeg8fuGO3sfhOJAdbbYdzwZ6+Qg81Li0JtnLOy9FpP52
 t35T2whJi+bz+Q2tQrfLYvctZkRNAhOhySxuQwYew6EjJsv4NjWm3uihc3Bi5/JXKmRdP9YFPwh
 sY3yfqK3ltja5eBGofEaqEPynfpmm17YT2d86pnjmTRn15ojWP/rHUZ
X-Google-Smtp-Source: AGHT+IGpBzRSpINuMBkor2gx8yG6lCFpEWZ38kE3PsR/bohMQUkoavQ7c0bLtcKM8VttGFsEUoVVTw==
X-Received: by 2002:a05:622a:34b:b0:467:525b:e53e with SMTP id
 d75a77b69052e-46a4a8e2922mr627183591cf.15.1735679858993; 
 Tue, 31 Dec 2024 13:17:38 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e67e280sm118864031cf.30.2024.12.31.13.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 13:17:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <cover.1734406967.git.weijie.gao@mediatek.com>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH 00/10] Cumulative fixes and updates for MediaTek
 ethernet driver
Message-Id: <173567985723.373695.5866900369463002673.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 15:17:37 -0600
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

On Tue, 17 Dec 2024 16:38:53 +0800, Weijie Gao wrote:

> This patch series contains fixes and updates for mtk_eth driver.
> 
> Weijie Gao (10):
>   clk: mediatek: mt7629: fix parent clock of some top clock muxes
>   arm: dts: mt7629: fix sgmii clock selection for ethernet
>   net: mediatek: use correct register field for SGMII speed selection
>   net: mediatek: correct register name of ethsys syscfg1
>   net: mediatek: fix sgmii selection for mt7622
>   net: mediatek: fix gmac2 usability for mt7629
>   net: mediatek: add support for 10GBASE-R
>   net: mediatek: make sgmii/usxgmii optional
>   net: mediatek: don't enable GDMA cpu bridge unconditionally for
>     NETSYSv3
>   net: mediatek: fix usability with wget command
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


