Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2E6C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 19:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FEF82DA1;
	Thu, 26 Jun 2025 21:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hd3lc6XB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22BD82977; Thu, 26 Jun 2025 21:32:53 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B2282DA1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 21:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2e95ab2704fso976605fac.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750966363; x=1751571163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHKjarR+C48m6Ddr8R60XcAMluK6OHwRMkVZRkB3w8Y=;
 b=Hd3lc6XBXBNylvAb4OhVqdUrdi88NxO9x+5d5Xh8/dGW5xWiKMSP3pJFauREBigNZ6
 CxEwiihw3iE3JR6dJCeIbJnWkIT4JAsfscmpKlGELowBdScKI9BynmMr7q4kGvtIB5xn
 d/wEUSKF5A2HT8zElf0r2PuzbnSC2nBbRm9Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750966363; x=1751571163;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHKjarR+C48m6Ddr8R60XcAMluK6OHwRMkVZRkB3w8Y=;
 b=j+PAG7RArD5LCFNoecvCGXKoLNj41MHvrNe8zib8VF9W6vmNuV4n7BIhoNI4lCVgxK
 KJt4j/gENCPom9GG5TwNVj5EPGnVwJBLh2DreV9dXG+NmdJEgsUj6XnRs5KuFywyTmru
 jFzrigMdNPNMx37JAzcIJJ8/O2O2ALCImkvRbG3AjytgxHan3NRbdRoIOgXmq0kuzJ+p
 U452xvYzToJ73Byn/I49IwM6eVieo11XnXNG3MSxvSPSS5UnWKIT5rHp8cGAiFcLjSsP
 jtkJofMBobks04WU6lLbE7ZopQY7vrTKagwdEk8ArjjmFKgBeYw39MyD3dsq+0dBpqzB
 GVhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCJrMDAqwYwre1QdYAxVZlk4uq2fmfH+0rT1IGb/Q85LTweTYzfC9yab+/f9lhhH3v6y9uYEk=@lists.denx.de
X-Gm-Message-State: AOJu0YzguEcwcDsGXoQ30iV0D6T5J15zqLDZEz5tTBf4cojugezwt9mq
 1MYlGIaIAWYX8FjswI8qh/++qIpaDNf9zcA73TH12Vs7QI1TzSx6Rs/BBMJM32u+0J8=
X-Gm-Gg: ASbGncsz1E9dEV2P15Fv1GM4IwxigP6hjfBvtGizPLEK5JgoXjMTEe1cQzV5ZOn8Pzh
 mG4y0rgn7rZb2/haOis0Q7Q/XghN43B92Gua+IFW4SfcwBpK948ppAPyrnwzBL0bsRwByCr/79l
 6dKauKJ0wqjERx7Z1uYRh+4TWevNYui1nnU4US4nf9u8tY1/wkocQCnZzu9TyShQrtXg3f1v5Y8
 RamIVInVdf82unO/be79qIAfJ3W0ze22+FWD8csP1I6Wp5IlPSGkweFOrNijhx1PXNbw6tZF+En
 c+52npUa3dIUJ+HpxVxZmwd9CO085TP9QrFC1xoYUqThTjoCndhbE/UtzoY118uD3qjEseYZEBE
 cFTQokcPTag3yZ6AEzwLDvg==
X-Google-Smtp-Source: AGHT+IFQB10hHx9jg43ePTtV6DTlXc9SHW8Grehpp6qTFS9iNUjwRfKzTkkizkOVyWG9a+Bpb4YLHw==
X-Received: by 2002:a05:6870:8813:b0:29e:74a0:e03f with SMTP id
 586e51a60fabf-2efed7ceee5mr184513fac.24.1750966363507; 
 Thu, 26 Jun 2025 12:32:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eab4e3sm511958fac.4.2025.06.26.12.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:32:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 0/2] spl: fix error handling in
 spl_fit_get_image_name()
Message-Id: <175096636244.1890320.15875355435926458975.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 13:32:42 -0600
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

On Tue, 24 Jun 2025 17:34:29 +0200, Heinrich Schuchardt wrote:

> spl_fit_get_image_name() used to lack a detection of malformed image name
> properties in FIT images. The change in commit 3704b888a4ca ("common/spl:
> fix potential out of buffer access in spl_fit_get_image_name function")
> tried to fix this  but led to function spl_fit_get_image_name() no longer
> detecting if a property at index > 1 does not exist.
> 
> This patch is reverted.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] common/spl: Revert fix potential out of buffer access in spl_fit_get_image_name function
      commit: 6ef9a89c1da433108ac89deab58954c6e2b798ba
[2/2] common/spl: guard against buffer overflow in spl_fit_get_image_name()
      commit: 79f8f31d58dfcd2b3563c32f1cf1097cee4d7f76
-- 
Tom


