Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75476C25B79
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 00:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A898E885DA;
	Sat, 18 May 2024 02:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q3hnuNKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 639C8885A0; Sat, 18 May 2024 02:08:25 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ABF58856C
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 02:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-69b6c2e9ed9so5383726d6.1
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715990902; x=1716595702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9wc3O+9Ox8csZ2jR9gF2mJisgAOBpuKmdYD2MgEFd4=;
 b=q3hnuNKwydtHjvknQkDjJobfGsCBmYwJ4hWtvK/jmz4PJ3rGK1booQr6nKwbMnJmlU
 m4Us8bEuKfsH1zjwusG33mGOSeTPa8QAti29jJj0pFiWnBxDTlXaY2+Vd+ObSUR0jhIA
 85gjaZ6Zu2EgVcY0uJMwbB534PkVGVv3p6KqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715990902; x=1716595702;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9wc3O+9Ox8csZ2jR9gF2mJisgAOBpuKmdYD2MgEFd4=;
 b=NjWazAqVxpPJ72hVQptYi+RusA3Lr+B98HkuQD0zCNvDGCTSLX9mbLTbdI+Zu84Rip
 Yo6X5DTWES3NoRxNFphVSGiCfyGRIBtZu0J+cNs5UeKKdtzsFSYYbMxowAVWj5Txe3VY
 fX1GSu61u+V/8a5VAC4MBx+i1pxCk/WLaZmjjw00N7t1wRNMed09Yn/t6uYDrNwldfv+
 sL1yX8UuHHhguKSuhkYaLq6A12bxPbhDGcq7PhfMD9DtozOgYXyg8W82Xkk7v9GbD3Oq
 fckOmObpLE6tmI2XXTy2KFXTHWPSZaD/Yna3Bm0kKxpz4Xabu72BhYda2ouP++8kAbgi
 xQYw==
X-Gm-Message-State: AOJu0YxIoJ7PAPuy2L4Wwf3jFHFthjAAelQMvKfiREsDEcajK7PEO3X9
 EfSgfvsjlXnOYPYMkRC3WDfX5Cfhj6dxlo9tiOAwJ8nyAmqeoLN5ig2y6HJwSo3yl3NX9YWm/xG
 R/uM=
X-Google-Smtp-Source: AGHT+IGRHqfU/XURRKYNO7HQdb4tVxdaszYJq6gtNGBwZw3Ty5Lej2L8pC/6paVqhsN6wqG0G/rUxw==
X-Received: by 2002:a05:6214:3101:b0:6a0:a98a:4881 with SMTP id
 6a1803df08f44-6a16815e375mr240654636d6.21.1715990902097; 
 Fri, 17 May 2024 17:08:22 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a872aca0ddsm756746d6.29.2024.05.17.17.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 17:08:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240513072532.1592391-1-JJLIU0@nuvoton.com>
References: <20240513072532.1592391-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH] phy: Use dt-bindig definations for npcm usb phy
Message-Id: <171599090103.1049746.12115499583106501687.b4-ty@konsulko.com>
Date: Fri, 17 May 2024 18:08:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 13 May 2024 15:25:32 +0800, Jim Liu wrote:

> Use dt-binding definations for the phy switch connection.
> It declares the target usb controller it is connected to.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


