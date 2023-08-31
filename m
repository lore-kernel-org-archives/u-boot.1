Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335E0C88CB2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 21:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3A986146;
	Thu, 31 Aug 2023 23:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RTrbfl8H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075AD86523; Thu, 31 Aug 2023 23:42:14 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4612780750
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 23:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5735282d713so796227eaf.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693518129; x=1694122929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzUREg3/7tCf8awkXVJSdCxl/gpQrlj0WWGfaXBipCE=;
 b=RTrbfl8HzT5i36hKb7nS2bSBChp7EE4PyoIpDWpvbdoGV4pn74pmgi20kIvnzccpt/
 n/RIAvxnFtxAkeUrDza4ZX/R6/Yrjnb/Me5X9k+osW09dJkfFofV1YVjmRR2xlPqcYav
 qZCDLK/xQ+ra1n7LCs0A+yOsLutJtrPo886l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693518129; x=1694122929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzUREg3/7tCf8awkXVJSdCxl/gpQrlj0WWGfaXBipCE=;
 b=VXZEkPlMRBczh4WO7A/398m17SL7wkcKM1pe64HkcpTvYBV0uD+0cmqN3JeuWo8nYW
 sXbjLWp/rHx5GAC5XsSZl4sMyxYhwdTVENtNkNOEXe4bdIgVcYhmUC6szcm2ymEg7ZEm
 05dLmmLbLLmTdf68gW34tSh3jrlLMRUPEkyo36wi6EnkXHFvHlSc07NBbHjNYNGNBcoh
 PRJNZu+6NwNJZbyad72lsA3rJJVIKrbte/gI1oHsMGcukiFrExS1JlWt2/Nhfjb0aywP
 fpidRk56IIAI1Pf7pahpswsAiWpPme66wimlkE52d+2h6jvruxElHUlpbq+XJr0xnd32
 jEjw==
X-Gm-Message-State: AOJu0YyF72Q7tiRSne5OeXm7jpRgORroO44MdsULIZD/DmJeoN/F6tp0
 BFe68nZzzwYoszDp3HF4l/JHwrpk9bPOFkXjz0mCqA==
X-Google-Smtp-Source: AGHT+IEvzLw09R2fdk1+bwwS4VV29hjYyZXHd0Q3Ngx5jvPSLvMDqeDKp9BSClKRelC0c1wP0wjW5A==
X-Received: by 2002:a05:6358:787:b0:132:d333:4a5c with SMTP id
 n7-20020a056358078700b00132d3334a5cmr584038rwj.10.1693518129696; 
 Thu, 31 Aug 2023 14:42:09 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 d36-20020a25ade4000000b00d7465a90f0csm561343ybe.22.2023.08.31.14.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 14:42:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Alexander Graf <agraf@csgraf.de>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 00/14] event: Replace some more init hooks
Date: Thu, 31 Aug 2023 17:42:08 -0400
Message-Id: <169351345931.3337070.5793274540011439967.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822031705.1340941-1-sjg@chromium.org>
References: <20230822031705.1340941-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 21 Aug 2023 21:16:47 -0600, Simon Glass wrote:

> This series replaces some more of the init hooks in board_f.c and
> board_r.c with events. Notably it converts last_state_init() over.
> 
> It also provides a 'simple' event spy, which takes no arguments. It turns
> out that this is quite a common case, so it is worth optimising for this,
> to reduce code size, before events become too commonly used.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

