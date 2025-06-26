Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DE4C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 963F582CEB;
	Fri, 27 Jun 2025 00:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a8he9155";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B2982E67; Fri, 27 Jun 2025 00:15:53 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FAD80E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40a7322f081so406256b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750976147; x=1751580947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C9bqXm9cDyliJSvOPF5A/ef8jwc6EESo7wsxKoZctC0=;
 b=a8he9155xIQJ2fiLIcw4LpVn03b6OM3AYKNX94dDPKnv1QCWjDVoZ28TPcidepjZpI
 iPqGLsOeAMaQdv3P9cbc1MywUPc2eY3XBPW6cd40XBGtCFGDia3m2P6t6OOskBWtqDwB
 S0OqKNQZQpXRBP/60T1fNb5xDi5SmwU2854lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976147; x=1751580947;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C9bqXm9cDyliJSvOPF5A/ef8jwc6EESo7wsxKoZctC0=;
 b=ttAKOQalcXdYnsclO0ggTbAwgGj6A7EUVfa3rL5ZZERjIXgTJq5wuiDaXR99w7kqTs
 Kp7I43qICFYOKDqjJmCtF53fcu/nJ7nPbleZsVNadQ+9Z0lSf7jh7yGUlgdyUcxOux5h
 wiTSdD2nFrzcQPcv+oADnTu8tCqc1NQPktXlYTa8hBTh5TcO/qtGmV4wv10wnbF9tzKi
 31JrJHzgd3T98fGyG87zVeaF+aY0YDUPhJZZqBqKYMTC6DX9U6bdVisnzNVvxIiWY/v3
 5622NS15WF6kflSnPNCSErPTCLWK7Lnze1jdH4StwJslwB365vWGvGdRFHeXJ2b2vv2B
 /WBQ==
X-Gm-Message-State: AOJu0YzmMKXmLBQIvHAiK3+KsCj4iFAovaSSXZ/7I7hYBVTn9ZsNyI/Q
 9t0w+xqQQgZCuvVJTnHt4ky9WBJl6Nl7UbLzoLay53xQI2sfQxsU56Ku2ThZx3vixFoIuQM+q5w
 i7Dv6zX8=
X-Gm-Gg: ASbGncsunmHWwaeDT4yB+Pol6pi9UHwecchjW8a9Y0QKcLKE0GPS3bcruTcF11n03y8
 3kRKy1mAcql+HCsx3lt63HOwGZ2ayYTR57QLmYFjLeXW0FRqgpX1wyHj7Xwmu3yxn2jypMcinMx
 hrAshc2z7YL0LMPV2EenSZvTCoZJhacS4gECcsoKSeuIploSITZLj7Z8LmhpaHlhRnzl7VXiKMa
 jDtYyQB0+TvCj5LipGaDra0ZXS3t+SQZmBoJsUnTtXTXPq4CpYIO3yu4Vj+CGsJ48Y0CnTZc1JV
 /Lsf1KiRiE+1THFuM+5aZzdlMNvUo69Bgn63jh/kuYzcVlPiDjgO78zIfmn7IbZxRbshoS2GsDV
 W8LCDXS5YU1FdlnpahgWAiA==
X-Google-Smtp-Source: AGHT+IF2qB7/brg8YwIWtQDu/xEtQaQH/C9611UadlxKAqhgR8cEtTn1nKTD6bQ+Pnb2IGmu80bwjw==
X-Received: by 2002:a05:6808:152c:b0:407:a47e:6e43 with SMTP id
 5614622812f47-40b33c2a0f6mr688455b6e.1.1750976146899; 
 Thu, 26 Jun 2025 15:15:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32289ce3sm129676b6e.6.2025.06.26.15.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:15:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, danishanwar@ti.com, s-vadapalli@ti.com
In-Reply-To: <20250613062121.222980-1-h-salunke@ti.com>
References: <20250613062121.222980-1-h-salunke@ti.com>
Subject: Re: [PATCH] phy: cadence: torrent: add support for three or more
 links using 2 protocols
Message-Id: <175097614576.1909185.14332587034259408665.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 16:15:45 -0600
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

On Fri, 13 Jun 2025 11:51:21 +0530, Hrushikesh Salunke wrote:

> This is a port of the corresponding commit in the Linux kernel which
> adds the same support for the Cadence Torrent driver[0]. The commit
> message below is taken as-is from the Linux kernel commit being ported.
> 
> The Torrent SERDES can support at most two different protocols (PHY types).
> This only mandates that the device-tree sub-nodes used to represent the
> configuration should describe links with at-most two different protocols.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] phy: cadence: torrent: add support for three or more links using 2 protocols
      commit: f05ba765a17ea43bb5dca39ced348b4b10b8c6b2
-- 
Tom


