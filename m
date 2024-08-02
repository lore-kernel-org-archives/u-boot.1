Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DDEC3DA64
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 00:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAC488B8F;
	Fri,  2 Aug 2024 02:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GItx4i57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C14588B80; Fri,  2 Aug 2024 02:24:17 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 153C388B70
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 02:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-704466b19c4so4572084a34.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722558254; x=1723163054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkbOR5pGhp8giDgAEY7pt8KveQVkW+qz+rrs/ekK/UQ=;
 b=GItx4i57aWhv1qIjvRhtGE9eYiAujcukSkXtTBtxC2oF8ZZxGV8jJY8KBkGEzf/wXN
 n56e6NkSW5Zp5ZiybO7NKtjLXQS+Zglw/7FjkpeI7PZfjgBC8Sk39ItEaBhOTH0vnl2B
 xvCbJh2HXLCzETsYKnQ32MChyMldNEgC/ZkDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722558254; x=1723163054;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkbOR5pGhp8giDgAEY7pt8KveQVkW+qz+rrs/ekK/UQ=;
 b=CyLMYTOuuxeJSY+OXbodeYZhvAkJWS1+dqQ4sAJVod/UTZskoLwsbeF3c9uQCXA1Dr
 KiURM4x6O+m0E/adDeKg7pWZIdh5NtuWcosZPjZ5e7XMqIsmti++djrQCFP9eAVhqWm9
 32IbqE8m7rDKE8kzjkDZTON4v9dCWYGN6OJWHf+vNC/MlF23SglnK+xvqLSUXHWH3YK9
 Dxsrc8RR1xeEVk8tItLjtA5DpCwcVpGCdtRu8z8G3xBB2Oc6FmcLKqhMDdek1WYMc9Hi
 lDxp1mY7ygX09dBu6im7EeNV6C8uglo4vkhGHi96LrLcbbChCPayKcvWrwfLpcLw1cul
 kd+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWlmy+TJ4X1zRucnrlSgZliCFWzs9HLm3GKi+enaoYGT7oNiuUtMCH1kEaiTWZ+69itF2mQ80iix5bGQCELrscxQnd1g==
X-Gm-Message-State: AOJu0YyoANgmVlJkfNWybIDluBbayzaPszucK3amKIGZatZq6AfZ6ho6
 5RwahLnwBoNm1KP2DMf0H09sHdglDOV5VSyyWgj7BexZqoIzfRLorAlRiVIbKMs=
X-Google-Smtp-Source: AGHT+IEBc9yAA5sE3GTeWwJBucjxiLYhcym0zCv+y6dbXXhswPvhsxurdcdT/XsCdkTDgvuwUTUBxA==
X-Received: by 2002:a05:6830:661b:b0:704:470d:638a with SMTP id
 46e09a7af769-709b05258dfmr2645737a34.3.1722558253770; 
 Thu, 01 Aug 2024 17:24:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9dcaesm232611a34.7.2024.08.01.17.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 17:24:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: linux-amarula@amarulasolutions.com, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240709062813.112698-1-michael@amarulasolutions.com>
References: <20240709062813.112698-1-michael@amarulasolutions.com>
Subject: Re: [PATCH] clk: clk-uclass: Print clk name in clk_enable/clk_disable
Message-Id: <172255825277.13067.153605108314581517.b4-ty@konsulko.com>
Date: Thu, 01 Aug 2024 18:24:12 -0600
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

On Tue, 09 Jul 2024 08:28:13 +0200, Michael Trimarchi wrote:

> Print clk name in clk_enable and clk_disable. Make sense to know
> what clock get disabled/enabled before a system crash or system
> hang.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


