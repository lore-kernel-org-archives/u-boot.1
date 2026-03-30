Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6601061B18
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACE984082;
	Tue, 31 Mar 2026 01:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pKbTVeP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186CD8407B; Tue, 31 Mar 2026 01:00:22 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4579480433
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-464ba2bb3aeso2972911b6e.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911613; x=1775516413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1LdfTXpNC8JkrsFuOIAzgO1lP8d9TlFuXznzkk+eG5Q=;
 b=pKbTVeP8ahRPv5AKwtBtD3P4rmE4lAmBGsVRwKmLAkeKISHQ8qpIoSfkBTxzlt6UkG
 7U5SAjCZRDbT1tsmzcli+gUy8nvUsv3QdnuLgDkju8MeI+UGE1tw7r62vtk7u+mi4rdW
 NBl+F6VRXdsQYfbI13YblV2cncTSYlEsnVfiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911613; x=1775516413;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1LdfTXpNC8JkrsFuOIAzgO1lP8d9TlFuXznzkk+eG5Q=;
 b=ApQZO2IhsBmb93QU+mHpLCWRl5X4AIJc3j6vQc4/7+b9lm3NlKxUZIODdkSFLByzLR
 dhO6pq8n2+z8w0gp/0M0Ol1DvH4fc6TRHtwjITQF/wLDBgERRtNpJpr8Jjz+Au6QAlCl
 xLGGtZ7NP8MIPfV2CdtNbjBt/9PS9/RdWFsuq7VTlasIZ8Gx73o65kdDBB73WJUEWAVw
 rJolDQzkJho7JVjTQnY2VR+dPsY1eAQwVlyUH4TKvAVQIuDKPey26Jnwstp/UfkNbS8u
 qB7OxyHGVsb2sEovPppmNUMNC2XrYFca08u3Zj+auTH1/MXZR1DRnc8lQN/SOgFObWep
 AG5Q==
X-Gm-Message-State: AOJu0YxAflht0cXFeXrmZGHOH0Gx5/sbBm90s4Eud0QrTWyFyXw+kat8
 AxPLbKPEIBS0Aj53coIK5diXrnuu2/3acMKF5+yonl9lTwsTsihrOSw+VrgGAY5OOnRln4vtIdQ
 BFbrw4dU=
X-Gm-Gg: ATEYQzxq6pVKvwUAtoStQBKvE4qp2DDQfiVdY97ICi1sKR+UImXOC6BdXa6DBjN5F5z
 NvMla5QttoydkS2PVgy1HQHcmUnzSuFXiZRFhQsZOwnNUiWR9B/M540Tw+LiGMllEtMThffHbcJ
 qrA23/XwkgtYxrZpFxGjbTxXz/1aZf+lEKgQKZewxptTAfxnxhGqQUs4ueoEa3zuss1f9tHAIzs
 8KQ60L1A4w1ZlvxiB1rtKKfPBNiBRoX9X74rDgQGcJ3LIkia4xGv1xzcNw5mR+arvQRv+3XnDLE
 G6ljvQCJarJNSOL5MWD74W34mUKUoF5aFNqU4Xz7VPDx0xnzy2yj17cTXJ4el7+go4AxGAaGRsy
 P53j389cVPqCAPYvJtz/fOIPkJPWfTwxIu6uo9XnPGWpToqTeXvDEzQKHBchSPpQcPjqbcVSG5S
 7pnV7+yRfv115NVqtsP3oDBwcFpA2cafTBILsZgM/9tquHR1RuakzNYk0FyAntP90Qzm3/5fcYC
 bI3X7b+hEc0UCaCXR6IlaFBaKhlMovqwGlSA2tC0fkjGdI=
X-Received: by 2002:a05:6808:1a07:b0:450:d6fe:8991 with SMTP id
 5614622812f47-46acdc6e702mr836506b6e.21.1774911612944; 
 Mon, 30 Mar 2026 16:00:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012431.4162508-1-trini@konsulko.com>
References: <20260317012431.4162508-1-trini@konsulko.com>
Subject: Re: [PATCH] SPL: Rework logic around SPL_BLK_FS (and SPL_NVME)
Message-Id: <177491161238.1028292.15965458966244569018.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Mar 2026 19:24:31 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue around SPL_BLK_FS.
> This is functionally a library type symbol that should be selected when
> required and select what it needs. Have SPL_BLK_FS select SPL_FS_LOADER
> and then SPL_NVME will now correctly select SPL_FS_LOADER via
> SPL_BLK_FS.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] SPL: Rework logic around SPL_BLK_FS (and SPL_NVME)
      commit: c40e539c77fbd3b68168c995f3dda64548b033d6
-- 
Tom


