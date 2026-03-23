Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E86CF483CC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 16:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B6F8421D;
	Mon, 23 Mar 2026 17:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="obtayQXE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C28F88419E; Mon, 23 Mar 2026 17:49:21 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 724318410D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 17:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40f0e14b9f9so257202fac.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774284558; x=1774889358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qTZkJSWekRvOBX3p9/CSRGxoIok/3Zp+GZf/KEu2BQ=;
 b=obtayQXE/J5JJCec4Xb9Wc/ZMGdo0G4fdRSr6CPKTQZtk7SJn0kMLUI1OV8inmc/2N
 KX7vQ5Ovc/CHu0YrPp+gy3VfmLp48s7s/dkuneYMmknAJSrxT7Z6iQhSGOX3w1nXal/U
 91NBRVRGnCIWhzpITZrrgneCExoOogzjaSx0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284558; x=1774889358;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5qTZkJSWekRvOBX3p9/CSRGxoIok/3Zp+GZf/KEu2BQ=;
 b=hFpcgPahD7/PgKgjsTyikySzsORxSVVW4YRJsRkrU2fmyUvfDiND+2hTDWkV/Z2+ly
 /eeNx7G8bTbmnt7aDfYLHUZwOFfToDuqm+/uhwlNR4P9l4UOXMJgTLrbl67xED2TjZVR
 FIkOkXuywKOcsUOuNG62iaW3pc/vMSFEMlsqvn02XE/FWNwPXxSD7DVnT5hR93GhXftQ
 ptuUsLWzqiwiK0ikqHAKPbsw4xRym/NKJey7+4VHYMPnsrcpjslwqfispm1h5x5zZMDB
 0kRMpe+0Li6CwQmHGCtz8G+MX4ClfLaJhPPkO5IMQjD+fbfL42vfyg6i4dQhFK7uJDnL
 5eKA==
X-Gm-Message-State: AOJu0YyQp521S2SSYofhNdX7on4DC0itcdW5wbbN2gyiO7befF0NRy4L
 5fm1URGjbDYk6nGtWa+xT5xFeEOMmKjdzZblg+I3cRQYwEKZAJxsPFpsJQv8l9H/xdP2SKB77MM
 o+uFRo5w=
X-Gm-Gg: ATEYQzzcS8EFn4ZjtD9tusVZcvg2fHzB3c1H8t0DiBAnUGNAvdtyfs9/jkPKbdm0Tbz
 uakFLZaERb9jEu0rPm6gC4TJfdophEdkVCMElemznbZFEwnP1vJDszmFSXHH2OAlka2S2XnEZBg
 JO+6ETMH5C1/RZWuBZV7JlTuqaJwpdEJIhaP7a3f6fpn/hcKdXXK4uhZ20SDn2rIH5e8OM8DiH0
 Oa1wRcEsgohP4mrOAL5Hl1Ka4vG50sJj9tDWSfzFSL8PFOb5dFOtLS4FoDBFczwxv3hToiaUSkd
 nXnCNPxwssBW0Pbz2M83/ZgcWSdd5KFzN1nYmrQbC6GhcBZcHedF9i8OLhI77Oaw19yazPpH5lG
 yrq2793RAWeC6wt/v7C0KH1x+gYOTCtLgmN1KRuTDSx0Dz3MvA6UbnqeEYl6EIP3KJqll3ejwsG
 GCR8uW3RH7JQ0y7+HUoyG/QaOtACrjrqFjW89z7nQL15OFUT+uVsaiBMn+6kGbsbaGqSOmZSvTW
 MNWSeNNPbfM9TwV2cjYUU7vjT6eE3xbLfVRRIpCKwk/edk=
X-Received: by 2002:a05:6871:7384:b0:41c:f16:f74c with SMTP id
 586e51a60fabf-41c1113b25bmr8407511fac.32.1774284558123; 
 Mon, 23 Mar 2026 09:49:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d73a19sm10016158fac.11.2026.03.23.09.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 09:49:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
In-Reply-To: <20260309151307.831537-1-sjg@chromium.org>
References: <20260309151307.831537-1-sjg@chromium.org>
Subject: Re: [PATCH v4 0/5] Provide a class for building filesystem images
Message-Id: <177428455734.2303875.8946982499603486871.b4-ty@konsulko.com>
Date: Mon, 23 Mar 2026 10:49:17 -0600
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

On Mon, 09 Mar 2026 09:12:59 -0600, Simon Glass wrote:

> Create a class around mk_fs() to handle the common tasks of image
> creation, such as managing scratch directories and cleaning up.
> 
> Start with a few small cleanups to mk_fs(), then convert the helper
> to use a class.
> 
> Changes in v4:
> - Use an explicit list for fs_type validation
> - Drop 'test: Add a helper class to create disk images'
> - Drop 'test: Convert test_efi_bootmgr to use FsHelper'
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] test: fs_helper: Allow passing the image filename
      commit: fade4112dad0fcb4c4c5610582ef1edec8d70ddc
[2/5] test: fs_helper: Add a quiet flag to mk_fs()
      commit: 23e9906192b86f3a0bddf02ef4ef6bfd2e6fa104
[3/5] test: Update comment for fs_helper.setup_image()
      commit: ffaa324c895fc37d73f7ea070e0a8feda9da4174
[4/5] test: fs_helper: Drop the size_gran argument
      commit: d030dc34d67acaa51742d549cb83a81256fefac2
[5/5] test: Convert fs_helper to use a class
      commit: 3691b1e4ce07425dfe3a32c10cfcaf989be57734
-- 
Tom


