Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8D3CCD1A2
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 21:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A8B82E34;
	Mon, 20 Oct 2025 23:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SlHjG8mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D308383642; Mon, 20 Oct 2025 23:38:45 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B491282E34
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 23:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-651ca0146deso1841321eaf.2
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760996322; x=1761601122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VNQUGu9rvGN586hdiSY9IksX3fZLyEEKM7iSG/u3Qw=;
 b=SlHjG8mhhBaa95sFPQm5JDw2wT1seeIQW1D2OkTajLdN9g6lr+kfm1mgfvsBDr/8Za
 IJC9hW1j47/IBhj3ytwKWiSAMuwZevW7yHK/Gokg9GYA7p/Dj5U8bQqhprfUMzkGVwu9
 J6G35gEV2jd6IH5qeMX7TvxjF9uglzRMD049I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760996322; x=1761601122;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VNQUGu9rvGN586hdiSY9IksX3fZLyEEKM7iSG/u3Qw=;
 b=CH0CgIsEmB14hJxgOZ0qZ58WsJCpJJ+g8QhKJhQY6Q8fUT8DuHouNzyeABsv//qAxO
 bgD3QXmPlzPe2SWyGaEKBRB+m/ibH4/5XTWDyZR0dUiYBuSj/+OuRY5oeE2z9tWUUZIK
 elpkQlK/ZrgRL/rJvUQeTJIqpw35ejBAA9V3oYXTE+AF8J+SKg0176eLaLSdEZYNjabF
 ICsqXo3kWB84ix81aAQE0Wd6akF1jVIDmyEs74PyRvYX8yjdAZ4eG9j3yVqNNS7xTeap
 W/Op02gnBS4pRLQaO+wApw7fMIWiDCdL7TcQbLyOIMtdAc/+I6gmYsE6moeWA4z0Euvg
 UNJQ==
X-Gm-Message-State: AOJu0YwjrnbUimABLRt/xp/XnqK8B/JLvTTyJ+b97MN27YhYEhNz+0Zi
 ToJU07oKm2rsOa38IAKiGMHwHVXtSG9fXZkDE+Lu2Bp/R0p1BIWIf7/EE9HYQ+9NbH0=
X-Gm-Gg: ASbGncto9074d3T30Bpo3lHNNtWzFRbt48QGdVgiLoEzBTM2NzENiaqCpQ8ipdmppaw
 MitSs+81VLIgQrWtEGEvU83DZ+fQgBYS2QDFc/GZu8n05z3d56j4dxIm0p4Doo48DnMo7d5YSdq
 Xjhqqns/BI5kX+Sbigzl5n57FGmmikFQm0QU0FkaffjMbxlbdbbj0dXieZD/nMD2dAAi07T//vx
 MwOGrGP0HXAa2HzJML/p7p6N3ZCADvke2EY/WYepAGCgSnAcH72ilN7egCy4acpdMrYQqf7tXx1
 zHNZnyGonMC3Qi1vaF+b5jWcUYjIUWtLMRXNecNpBVYBS1KPNXwSg8C51pegRdn9RJboA0tKOiu
 em/8l7sY0a74WsEEYds852ntwu54lvD+2UcICXKOqhTlSfCXs+koHEJx/9hw6DHyYqHUI2pvd2e
 O5pXsArgdJ8s7Va9O2BBJHVzCCZaNHgiS7YyoAiw==
X-Google-Smtp-Source: AGHT+IEOseQeBJVtVdUa2HqWtfkryeP8QLZR/Wgggn6GlHEyQyI/hPtbCOPBIg7574qI7pCf35AuSw==
X-Received: by 2002:a05:6808:4fe7:b0:43f:7f5:4981 with SMTP id
 5614622812f47-443a2ee205bmr6900291b6e.5.1760996322430; 
 Mon, 20 Oct 2025 14:38:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28892cdb5sm2992268a34.27.2025.10.20.14.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 14:38:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com, n-francis@ti.com, 
 b-liu@ti.com, nm@ti.com, bb@ti.com, kever.yang@rock-chips.com, 
 hl@rock-chips.com, tim@feathertop.org, marek.vasut+renesas@mailbox.org
In-Reply-To: <20251009115846.897186-1-anshuld@ti.com>
References: <20251009115846.897186-1-anshuld@ti.com>
Subject: Re: [PATCH v2 0/3] Add support for secure falcon mode: disable
 args file
Message-Id: <176099632076.3958778.13316268414959754314.b4-ty@konsulko.com>
Date: Mon, 20 Oct 2025 15:38:40 -0600
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

On Thu, 09 Oct 2025 17:28:42 +0530, Anshul Dalal wrote:

> Continuing from the last series[1], this patch series addresses the requirement
> to disable the args file in falcon mode.
> 
> The args file is used in falcon mode for loading the device-tree for the kernel.
> However in secure falcon mode, the expected payload is a FIT containing a signed
> device-tree and kernel image. Thus removing the need to load the extra args
> file in the first place. Also, loading the extra file without any authentication
> mechanism exposes an attack vector and should therefore be disabled to keep the
> boot secure.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] spl: make args file optional in falcon mode
      commit: b1a3ed068869d7289747dddd6dc13ecb9f9840a6
[2/3] spl: prevent loading args file in secure falcon mode
      commit: 82e04e768fc21c1ac43df5d5a68ec8aaf008c0a8
[3/3] spl: set fdt address as spl_image arg in falcon mode
      commit: f851171e14ac1b1910c549879a9b82060cc4cdba
-- 
Tom


