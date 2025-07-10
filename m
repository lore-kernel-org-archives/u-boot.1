Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED7EC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD408382F;
	Fri, 11 Jul 2025 00:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="toEZo+cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD1383700; Fri, 11 Jul 2025 00:42:12 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27FB8362C
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73b0efea175so892859a34.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187328; x=1752792128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9UvguwpHe2g7Lb5ChsdcoLuDGlP7FOySJiKIfSnPLcg=;
 b=toEZo+cr6BeG6ex3R8aTNp71JH24mNNFxgxPEbDgQWycI9PJHjwJ4vjclNKpXfKLcg
 2R9jYBo0r66Hivj/BsPcygyBwQx8EIO6cUfZfuzOLpFQV3gt3DdxuARXQcbOXuFby7SW
 0Y4akDVrdwI6D4fOTUFBX2Z2O1P0k6QSGYOmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187328; x=1752792128;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9UvguwpHe2g7Lb5ChsdcoLuDGlP7FOySJiKIfSnPLcg=;
 b=mXTKGjUpBULMBAm//JCy8xFfP4hR6e0EBptjejnV/7DYeHiZ3qT9owWsmsvJ/mizgB
 oPzLC7iiLiKGqTLHsW01Ceujks8Zm6CSPBRjXYkXxoqdVn6/VOgRQR6ZBJQkLkOZManb
 Ongy8Lt59LKl+XHd7eIntsJXX7QKna0/yvl6HO6nuvtuVLDVcdUXDA1CQhxpvXgGYGQo
 3PltbTCbHUemnuuk9lrNruOpJi+yKiLMG6TI6V69AuaXjWZ5KgFLR9do7mpt290+DvVJ
 Mc4qxJdVIPZLpv2fip1eiVDWEIyI+l2VKoRM1hMFPh98/ycj6pg1DJ2zCZAli0bZzKCM
 VZeA==
X-Gm-Message-State: AOJu0YwTz7KcgMQMZGILObTJtAwpbhrEPdvGGDkZGBvlirnW/nWoyGcj
 YsuriUJIhmrS5GWtI5JXheboQiMWHzBT/BXyrDaSE3p8FCJjODTV1i9C3oSULEQ6DV6fRaPZBV6
 6UytFfvY=
X-Gm-Gg: ASbGncv7BU0EFCLVUiM6UavBTf8eQtuhdEGkUjlIwt7Y3HCexwff2wZ9HcXCLjWdW9H
 ofK4BlQ58E+k1KdcqM93NvF38r96vMZjXpeTQQ0qHjSEfG0GVk5sL0xI6Y/D2xtsBeIhTMtWIO2
 QPm5j+DKEgt8/mrjPWjE/WaJWVyxz9GNrRsmE5S5/S8SOLAcdclZrb3HMrF21sRsiF5KRv74UK4
 VrajSjZ9W1/3N8VBIUVqvFQPzVarMQ/+5h1RLtjCvwh8f9V8zWByPtStrEfHcZI764NEsEVFgL7
 USp++JmOSm2TKPitzFogzZLWCwMoD2tk95SKS/HaJlOacjIFIAJAaWcX6N18EsyVXaw48ot5JCU
 hPjM8pPRsnAIKjG1Y5Rsv+fkBHYklEi9ZgVZECRHIAhHOsDUlbdeM5Rg=
X-Google-Smtp-Source: AGHT+IHb9ByhReJfGq4NWVWIcA69V+xlfqCwr8Z/xAvyiE/yIuzunC1t1KKNNbZLANNPSURTpmpeWg==
X-Received: by 2002:a05:6830:6805:b0:73c:9589:2799 with SMTP id
 46e09a7af769-73cfb0e6b37mr346804a34.2.1752187328450; 
 Thu, 10 Jul 2025 15:42:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, MD Danish Anwar <danishanwar@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>, 
 Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250702113545.367312-1-danishanwar@ti.com>
References: <20250702113545.367312-1-danishanwar@ti.com>
Subject: Re: [PATCH] net: ti: icssg: Read firmware name from device-tree
Message-Id: <175218732745.2073260.11002083079737824424.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:07 -0600
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

On Wed, 02 Jul 2025 17:05:45 +0530, MD Danish Anwar wrote:

> Update the ICSSG PRU Ethernet driver to read PRU/RTU/TXPRU firmware names
> from the Device Tree using the "firmware-name" property, instead of relying
> on the hard-coded firmware names. The firmware names are parsed during
> prueth_probe() and stored in the prueth->firmwares for each slice. The
> driver now uses these dynamically loaded names when starting the PRU cores.
> 
> This change improves flexibility and allows firmware selection to be
> controlled via the device tree, making the driver more adaptable to
> different platforms and firmware configurations.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] net: ti: icssg: Read firmware name from device-tree
      commit: c589dc0c244e3038522ca162410bf4d02b1c5641
-- 
Tom


