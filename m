Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6EEC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC85A80FF1;
	Fri, 21 Feb 2025 18:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t+1eqoeb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA75180F88; Fri, 21 Feb 2025 18:38:24 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7749C80FAA
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220d398bea9so37379375ad.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159501; x=1740764301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xVFcKf6v74ZbWI5acE5M2KtuBZsk4Aq+QZjVMm2lDZo=;
 b=t+1eqoeb2Fc2cIShfiji8ZoBNmoi8fKdV3oFWJOrAsT5PiEwsqyYzdM6KJnQICCsT/
 3hthpTv01+xmvQigEGU9PXFVdgh1ebxfUDmo1C62XdBQZP9g/e+Pmt3vcbLNGjcnzz4k
 eKW5FpASV7dD60KNi9E19Hbg0W2plnxT+Pcdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159501; x=1740764301;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xVFcKf6v74ZbWI5acE5M2KtuBZsk4Aq+QZjVMm2lDZo=;
 b=GhYmblAEvg1zeu7LN4fRK5AFja9p2CQr/pPnq2vwiKQZsNJU4DzCPQP3bdR66pTOk3
 iGZn+Oip8ESAw85V85/gR7ok933oAR78i9n6Ky0ZVkagumLar7wYgb0QreslwouTil89
 E4jzfzLlZSqtL9fc/W8WsImsgTLfLaaBqe8FCLSe3nHf+LmDrKcav0PGiIUO103n2DLa
 +OVA1H04/pK9Aa4Wy7M4DfZ2Ir61FMmmNOACHV1eKnAMQx1hl8HfNbSW/KlTewXgmAT/
 zAbt8rLwRobavwCwMbEZXcJGEIQMWCbu5jZt8+DjR5lYOr4j6TkRc0nc9UGOjQaDjRKJ
 lWug==
X-Gm-Message-State: AOJu0YzzGKfad2GTClMnv0JseMdzxmBXa4QQmjNKJpnzCgzJuIS+SqLN
 7KvZLbaHT7jguX0DoXU6rLlorOb7B0ZG9kir1tIr7qxgk+dol7mYXkJX81cLpQC+GLWDuyt+oaW
 io3g=
X-Gm-Gg: ASbGncsUyrBUJRgg14c165+T1FSPhyYI7dhhfvXIORErUHKX0IW6WS/lL7a3G8RpcOS
 Jc/CBqRGBThgKJrFNtj+Odl+hSQbKVZetq7LtrU3kYziFbPUgbnemlCsJ8jC2Zk9QBtXHp7XIE3
 FXEQmVh3ysdqzTLzs1xarIPtG3G+qROiVqLTW0d+WYNJe/1cumi97Nm+PXyqVVQrI069sdQ68hY
 0uLS8fhkV18P9dFLG9SYiKW8jXPhtKdAMhk6BTtvrV5FtYDvttq9clOc8849o69gfG/rm+nPaP0
 v8Aw5zRMxaCuxwiITtiZ//A=
X-Google-Smtp-Source: AGHT+IEWtSybp4ZkWskwbiL9Zjr92bk2ucplsDbkigCuRyj8Cmavci6Y+r1aAOsx6DOuA4dWUD7Y4w==
X-Received: by 2002:a05:6a20:918b:b0:1ee:c7c8:ca3 with SMTP id
 adf61e73a8af0-1eef52c9372mr5544576637.5.1740159501095; 
 Fri, 21 Feb 2025 09:38:21 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
In-Reply-To: <20250213091118.84284-1-weijie.gao@mediatek.com>
References: <20250213091118.84284-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] arm: mediatek: remove CONFIG_MT8512
Message-Id: <174015950024.3526942.10665081125009976312.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:20 -0600
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

On Thu, 13 Feb 2025 17:11:18 +0800, Weijie Gao wrote:

> Defining CONFIG_MT8512 is unnecessary as now board for mediatek
> target can be changed in config.
> Use CONFIG_TARGET_MT8512 to replace CONFIG_MT8512.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


