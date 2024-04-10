Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03176CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72016881AF;
	Wed, 10 Apr 2024 19:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fuAAIDYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F72A881EB; Wed, 10 Apr 2024 19:43:33 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CCF881F3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78d6021e2e3so263970585a.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771009; x=1713375809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRk3DRcy004DEk2F2vhAPahlmf+jQTH1VMO4J3W7NzY=;
 b=fuAAIDYe3yOysQM/J7WE/9Ow+6pMj6ag4VPrPg24kh06q6IPARZn6DLZXXkQniYiD5
 xqyxOwttkVEITVW043SLNvhiHSNFEYtsRQ2kApK3XBv3HCCt/5JGhVJVu6S9BUUr8vze
 OfLeWA0OvniS2T/DEsyQMiGBgmOJyL7PA2H1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771009; x=1713375809;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRk3DRcy004DEk2F2vhAPahlmf+jQTH1VMO4J3W7NzY=;
 b=G7P7zskU/pT4tDK0grXv0nNHAnHyI+0UixAx1oqoV+dc6omr92DmjPJ1DZGgWBg1An
 aIZhAGujxRCvTtgSXN0ue2L0PahcBshPJgcDqWNZCDFJEgDmMcM3O3CShZE1j/WV/AGZ
 REXKN4bqt0x7mOZrxoUG317PFfs3UIUYD0MTU1ZrPKqBlh8u0ca4QlB7rRQ8mhc/0wpq
 M9JkyzUYjzTMwHZkmMYVTxs52V677WfTILGD0Nll0CnBS9EZG/gRqW0YTy9xnQnIyVQA
 vdArZIPUUpS41zOztC+alzUBRgsBVT6MVmDE/q65yo50U0hR+yz4xzy2hjBWRmF40v2U
 GOZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUCm30C6vSy9869npdKOvcyMg4djTWP5CC0dBlp5TKmkpUwyVs98E3n3cw322vlbkXBuZlaxyFKS8lWD3sZTtnJlXsFA==
X-Gm-Message-State: AOJu0YxBfhtS9BGOZ9VxtJ/StWRnYsPmGbGaLK3WUMTRI+bYyiWXRqnz
 COgM3suuBYUSaRGk+HoNEXeOuRPtZSx4tz2tOTWfPLZH0o5abZDfH/UKzrrzJQRVA9KRFSzVwzF
 NFSLBVw==
X-Google-Smtp-Source: AGHT+IFRP/K6i1/SqvzU3YXedEW5mX6+7yHztrtgdetl9vnMc5CmdUvBENL3KQoFo1hX+ZmeuxdlIA==
X-Received: by 2002:a05:620a:2987:b0:78e:be1a:a80e with SMTP id
 r7-20020a05620a298700b0078ebe1aa80emr895705qkp.0.1712771009515; 
 Wed, 10 Apr 2024 10:43:29 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, Marek Vasut <marex@denx.de>, 
 Elmar Psilog <epsi@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20240402083934.42733-1-heinrich.schuchardt@canonical.com>
References: <20240402083934.42733-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] net: dw_eth_qos: Add missing \n in error messages.
Message-Id: <171277100781.98421.9356177978054398088.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:27 -0600
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

On Tue, 02 Apr 2024 10:39:34 +0200, Heinrich Schuchardt wrote:

> Missing line-feeds in error messages lead to output like:
> 
>     phy_startup() failed: -110FAILED: -110=>
> 
> Output like the following is much easier to read:
> 
>     phy_startup() failed: -110
>     FAILED: -110
>     =>
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


