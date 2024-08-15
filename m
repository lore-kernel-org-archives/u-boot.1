Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A433C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D9988B6E;
	Thu, 15 Aug 2024 22:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DEBk3UDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3042588C2E; Thu, 15 Aug 2024 22:33:22 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFED88BFA
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5c661e75ff6so807928eaf.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753990; x=1724358790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fxMSZvl1y97WwQ1hfNRz9IjHLaxvhTsghFzgoyzvu4=;
 b=DEBk3UDeQrAe2R+vOzfdP5kV9txrB/UKW8ld+an1xrqo4Fn8OcdrIDSObtTGm7b/pY
 GSG9hc885C+i+Xmc0sQatBeQU64rmlwcjyfBSSRuTRe8TB0g4Sk7+zwepnu0nG5ldo6n
 dyLyNsGmFJqnmsvR3slOOZj40DSe16WgMyH+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753990; x=1724358790;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fxMSZvl1y97WwQ1hfNRz9IjHLaxvhTsghFzgoyzvu4=;
 b=DVu8dn7TbbVScYWoTerxNMIAze6pkc5UxPx48U+lulR5VHpHSZ+9yug34PpYWFK1XD
 wV9JlQ+N3VznjqCJsN/ieAypCuu64PBiPnvA7Zz5jfUf3qxocU/Bv0OhcS9w1IVpv5st
 5swBlnxfhXr6YTuVC/6Lbw2EnkngxZfQEvko06DsHjpQUIQUO952MdavztJ+VU3anDAa
 QpGss+MgWXg/L04ezYeGslV5et7qvR/KqcJdxZb59Q+PTcYTwIOvf9IxG9Pu86O6ipvH
 j5/ma10gUerf34CAvibvWzji3ArdFeOKOsTWlNcjdsu+6LOHOEvi83psTQICfaCGviKr
 E/OQ==
X-Gm-Message-State: AOJu0YxX6DHl1vTLs2sZiGUw0ltDJBcesgUN3jCJTDQvykrnjdlVf8T7
 9ycAlNvq7L4SZdDUAzFGwLRWD5y7BHmB6TXgvgEtGO9yWFdgQSnyqIf5WrV2mMU=
X-Google-Smtp-Source: AGHT+IE653n7X0dLR2mdQ/bZTrpvnc42PmS+X6yRFir8pTP6fPO3YO49ivohnJdMvoQswwMEP9nTPA==
X-Received: by 2002:a05:6820:810:b0:5d8:e69:846f with SMTP id
 006d021491bc7-5da98046b89mr1143784eaf.8.1723753990548; 
 Thu, 15 Aug 2024 13:33:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240807145651.52700-1-afd@ti.com>
References: <20240807145651.52700-1-afd@ti.com>
Subject: Re: [PATCH] arm: dts: keystone: Move to OF_UPSTREAM
Message-Id: <172375398985.3490037.15263153297283055106.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:09 -0600
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

On Wed, 07 Aug 2024 09:56:51 -0500, Andrew Davis wrote:

> Enable OF_UPSTREAM for Keystone boards. Remove DT files that
> are now available in dts/upstream.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


