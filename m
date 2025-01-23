Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2109C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 23:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D2580780;
	Fri, 24 Jan 2025 00:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mOtIPRRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58DE8076E; Fri, 24 Jan 2025 00:14:06 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5AAD803B5
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 00:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46e28597955so14142971cf.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737674043; x=1738278843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nVTJ92/L2ETtgRoalxa67ZHtZkPrfv2/HOM3XSD04P4=;
 b=mOtIPRRPo55bByof3UyXl6VNKDKqvJPAC/ht3eS7qh8plnb6uLphVfr4tb/SF0iQZs
 lmkM5mtmvjc9ZJ+EqiYkSUnwbDVoRr8UNnZdCfo/wpJ8170U9eVGmwmXtGu9NlzxorJW
 J9RYHRnAJoYLuvgmxkseN9fMNVC+poxLC2K1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737674043; x=1738278843;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVTJ92/L2ETtgRoalxa67ZHtZkPrfv2/HOM3XSD04P4=;
 b=mYDiIofqDiMock2BGAplEigdDDmtTpFlWbhLHQUliyYBzX5hSmkXFZNpce+lcTSWrL
 hrq+gTfo6AXm1JC5XDVY9WoivaoViPl3v+q6nM3Z4X72/1uMAGnNSZNeAUqD6T9LebtT
 l2k7izb+JUL6nORcX/l3+LoITYGgh2lfwlhG5h5C41hlnwuH20VV+Wv8UslpeMFJ2yWS
 Da4MWGF1aRPTCYXBrV8CCO0dj/kPNyk5poofhx/3vH28ir3IGgNAxmC+salSwZhaceQS
 4zw/ustwxVhiIsFmXAO4PcWqfupoacNCC/cgmO1YJvUvGS7nMGwJqPdrlEpX9q0SRjGo
 PZ5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZgjCre1ecTwfwGjIibdjlgzgQwoyZuKJk6qVHDMJDf7qy3Vcqnj7tdLbFwrgTUEJCzr20Z/s=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9emDUzzElY+V8sRkgS/3Mn1yoEFrthVtadsgRlh4cwrXG4nnf
 eGCWThyUhxkiCQ5qwJMrnCsfmS6Lt/Z/W37y7GiO+dY/sL/A+AwRGJmtJnTCTAo=
X-Gm-Gg: ASbGncsTgzoB3zuer8zh2cpCKLvGwKytfWFuMguFfIBidsT4LXMhgh9zncApy5AKKbN
 2If48WP5qUSjzfX8xZgOuX/aPfog/Lcr+SGtvWmcQY7ApBiRUpzmeg05FuG9iYGegOGJw6F0tp6
 AP6OcaX5gmqmwwRliKDEffQ74sc3Cky5bifIG2vyOlHLN5AKN86Ceg8me/wg/7jX81TDVPeXnVK
 0uEceS2Fjl9uqWzeACrgiSu7vP+Z4e5JilMFHfKMvWitZFyLr3gGjcXdiIg6xj9f47QBg+bWEzP
 JnU=
X-Google-Smtp-Source: AGHT+IGbFq+BCixh/CgGMt+3GazPSMwhKc0B57MJibbtNX4K9H5MxPwUABTAThqUKqad/Z1Y46gg9g==
X-Received: by 2002:a05:622a:1446:b0:46d:d2b7:4bb5 with SMTP id
 d75a77b69052e-46e12a96f34mr438184881cf.28.1737674043594; 
 Thu, 23 Jan 2025 15:14:03 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e66b89811sm3753441cf.77.2025.01.23.15.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 15:14:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20250123013620.23914-1-andre.przywara@arm.com>
References: <20250123013620.23914-1-andre.przywara@arm.com>
Subject: Re: Pull request: u-boot-sunxi/master for 2025.04
Message-Id: <173767404231.3025404.12787101956021701262.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 17:14:02 -0600
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

On Thu, 23 Jan 2025 01:36:20 +0000, Andre Przywara wrote:

> please pull sunxi changes for this cycle:
> 
> Following the move of the H616 family to OF_UPSTREAM in the last cycle,
> now some older SoCs with identical DTs follow the lead: the F1C100s, A10,
> A10s, A13. The remaining SoCs suffer from that IRQ cells incompatiblity,
> breaking support for Linux < v5.13, so I am holding their move back still.
> 
> Otherwise we get proper support for the PinePhone v1.2, and PSTORE support
> for all revisions of that device.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


