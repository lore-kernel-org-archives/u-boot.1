Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84263C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC098806DC;
	Tue,  4 Feb 2025 20:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="McNjA9e3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F589806DC; Tue,  4 Feb 2025 20:43:23 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131A880540
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ebc678b5c9so3296939b6e.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698200; x=1739303000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blhQBsb6igWTP0caxfzyKq63n8zTqvXIsUAS0cUj0ok=;
 b=McNjA9e3W6Z7WNZZj0dazJ+NLoe0j33E2+D8Jdd548LZYnWWPEKLSgW39rxh1gAdeo
 bfAFGUXysaahoNy8QtCfhqt0VZF8LUgbSIIFhfCNWv6mSYVG+Pb0uiGojMhYesVQ/Jaf
 i7D7k1j5KY0j+708ps5zjoDTIK0z1/cr9+fUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698200; x=1739303000;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blhQBsb6igWTP0caxfzyKq63n8zTqvXIsUAS0cUj0ok=;
 b=b9cAV53ERUTorhwH9Rnofh//KwfMyKBoLIUFewKtSwA41NTiKEiSIcA/Z7QMJMDoXv
 WThZASr37dXZrN0qL+RnQHJqROnNIphThHD5B+LZ6dWHWrQAIuGM33gxKcwHMz56ho/Z
 ItDmbyKUQ5iAxqWWADrL8KIRaaoNXfTYFJgp1Vaw4rIHLivbhKrp302837tJd2oaJZ4X
 zpC8hSeCn6LSoIGTPy9oY6EkuyiKulYXEllTPWmg0xXzAPnhzgUkCSUCKLvwNjrXb6Va
 XbVPKDuYb4AlMilMk0VBe/CZhnnfrdQiPQjoZYCoFJzJLMUaGzdccTId3fJCDapBW2ao
 /2vA==
X-Gm-Message-State: AOJu0YzQmzjwe9Jpm5+GVmXtQu074nT6StMVFzIvHJdaG2gWXrQcUTmJ
 ymMs9iRK98oNhHovrTQv36caoTveGKAPpRtl0PoDtmNL47R9ZUncI5LXSGln3VUOqkShJIRK3GG
 Cx2Q=
X-Gm-Gg: ASbGncvABtzjzBlYnyufys27chxAGXcDlQ9e0VHgWN5AtiXpW8xLQVD2sIcA03Q6Xl9
 zpd6Dsx5ufVIEo7c4huYvP8FMX/A6aQNmabmVMInIIoREz5Ejigx+21RWmDKmw6BYipGoa/wvzL
 4ezfVZtt0EEsZYDvlMn6v+gLsx4bwUPuaASfpcWUDkT3uwK4LNsblOYowFfihTRTvVhAk+SPgpf
 HlHbtOSbWs6UYb+tokCPsBGSoSGLasLfFNb+Xs8dIx5fYqsApjC6ebxxT/PWTk3wkDnnK4pqE7K
 moBB+xUMhSskeQ==
X-Google-Smtp-Source: AGHT+IF4+gn4H8YDjb7YDxD0uKcrdCefYFst4Lv/VtRiJTtCZFUS/sAnQa5t+w+b1byzFXAVZq6E6Q==
X-Received: by 2002:a05:6808:2e4a:b0:3ea:3db5:ffe6 with SMTP id
 5614622812f47-3f323b674f0mr17595783b6e.31.1738698199821; 
 Tue, 04 Feb 2025 11:43:19 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@denx.de>, Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20250122-extlinux-relocate-dtb-when-dtbo-v4-1-573d6d568309@cherry.de>
References: <20250122-extlinux-relocate-dtb-when-dtbo-v4-1-573d6d568309@cherry.de>
Subject: Re: [PATCH v4] image: apply FDTOs on FDT image node without a load
 property
Message-Id: <173869819851.637016.526823883203031515.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:18 -0600
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

On Wed, 22 Jan 2025 16:53:15 +0100, Quentin Schulz wrote:

> A FIT image which is NOT using -E when created by mkimage - that is with
> image data within the FIT - will fail to apply FDTO if the base FDT
> image node does not specify a load property (which points to an address
> in DRAM). This is because we check that the FDT address we want to apply
> overlay to (i.e. modify and likely increase in size) is not inside the
> FIT and give up otherwise. This is assumed necessary because we may then
> overwrite other data when applying in-place.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


