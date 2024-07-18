Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF60C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C648388A5F;
	Thu, 18 Jul 2024 15:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CNYWrQoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F8F886E2; Thu, 18 Jul 2024 15:41:37 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 804D988709
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c9cc681e4fso452228b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310094; x=1721914894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nsip7G4GFKJAHyvlKF76eV9EvQs6vDWTzrIrUchBiiU=;
 b=CNYWrQoGSOyh8br95d9u60t7HvSP+xZYxBq4LIhLEw8HkTHv4pzv7PGltzcVx6a05g
 qYQ7wA+rmgHSY3ws+n98d0EUraMx1ipK8/MwZeN1GrxMx28l8Y8tWy0HDYH5wdASHH7p
 oj7/OfLXUVOSimbFWTb7l4U8L832Ceb7V7NdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310094; x=1721914894;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nsip7G4GFKJAHyvlKF76eV9EvQs6vDWTzrIrUchBiiU=;
 b=OKwliysuS6sFhKxArhgIfAPU/PBuw2tfqE9zJbWvSGxZTMSbtElYJ7G2/HwLfmshJf
 ZOrNGWAPSvN/6nvkZBbaZHV+c/vf5pKa2Jjrcw7DlAV8DH2bAnmF8uR6yDSSST2msbNP
 NYYi6q3Mdo+DRaUgym33F4BycjLubKVtVuI/S2bBK4ZPADOYwOMoyE2NJ9ydNj5mm6DM
 33HpLcBR0/0yQV8j95SKU4+53UgelmrtixvPyq9r4iCbKI7vyMaIrUOSsD6MsmHUobO6
 dzKjBJ18J9B0S3JzBiyc19lzxDL1ZXyRE1sjIqs+HzM87zWvwKs2AycUX5yE1EmMWn+T
 O//A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbItHK+Hc+XvFjVVnSmutr3CRd73h4x0R0e14RBacml4EYmeLad8Evk6EjJ7uQj37GR3I03rk97OBM3vUTeqtkpmlFmw==
X-Gm-Message-State: AOJu0YxkJSRrGcwNyYUtW91h3/dhqS7YOt3IkxpD0TtkIi4A/LkxXdMS
 ljwQcHegOSZPm59gi3LTJ6kT/r8BAGCFcqpI4BQ/VTstQ3ttYH5jMWy+vz/+6T8=
X-Google-Smtp-Source: AGHT+IGNRnakBXZf1hA9NOp7DQPyVRQFlkD0iSj1A4/NOW1weV34hNuy6brk2QLJpb89onp8MBLbgw==
X-Received: by 2002:a05:6870:3d8e:b0:24c:ae57:b4b9 with SMTP id
 586e51a60fabf-260d91920d6mr4234524fac.14.1721310094374; 
 Thu, 18 Jul 2024 06:41:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee947f82sm355303fac.50.2024.07.18.06.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:41:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240706161303.9110-1-ansuelsmth@gmail.com>
References: <20240706161303.9110-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH] timer: mtk: skip setting parent with dummy fixed-clock
Message-Id: <172131009342.1834634.16950541414480829533.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 07:41:33 -0600
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

On Sat, 06 Jul 2024 18:13:02 +0200, Christian Marangi wrote:

> Skip setting parent with dummy fixed-clock. Upstream linux might declare
> an additional clock for the mtk timer and that additional clock might
> also be a fixed-clock defined in DT. Setting parent of a dummy fixed-clock
> resulta in error hence mtk timer fails to probe.
> 
> Skip setting parent to permit correct probe of the mtk timer.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


