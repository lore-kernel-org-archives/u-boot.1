Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3614CD98EC
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 00:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1CB8493A;
	Wed, 17 Jun 2026 02:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NG4mEdzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A2D848D1; Wed, 17 Jun 2026 02:49:51 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF11B848D1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 02:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69d7aa0ac14so3707302eaf.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 17:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781657388; x=1782262188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wYqMKn6Fw/sddKA42Gg0nEL71d3GK40mdhkoJ+hA4r4=;
 b=NG4mEdzq9BE4+0GxogICjMRyyAx+wopyGRUWtl+naVSJZWjpY3fzm/yoq2aYajhbuz
 TATJXkNq8xEmrrfT6tapOSnTD6cYrGLGcm/8k2ZiRvfNurQgC8i5MAPXQblz2fxaatgU
 wtOm+VdYPOI7Menigw9N6kDQIcM9/3Gnbv5lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781657388; x=1782262188;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wYqMKn6Fw/sddKA42Gg0nEL71d3GK40mdhkoJ+hA4r4=;
 b=GGiU9cygrfr98WfnYTzVy7UTQFPLosbvK0KuC0s19wAj0mqTjBjmF8sjwbdRyAlaMA
 9vz5BPZQOCKV0bO+Sz4r20nW0HI5W1QM+oh6B3u6HTKHD/VqkDACOwdnx50v/esq0LBL
 spKRyYMDMRudHMhds8Qaem1iquyBwa6EgPzGRJXKQEdFzCRT3ie5ru8vDyfxvp18mGGB
 SMCCNPUHr1TvMnDaZHLkEW2TclRJLyJrrilVtcYQ8aiPBwb5PFDMaDfWlvHTk40Z0A8/
 D3TBKvtM0N7R6JLE8faFjJ5QvZJFSjSnJCRhnhSKPJRIFlurgXpIINdcK1dvSZQnkCGG
 jLsA==
X-Gm-Message-State: AOJu0Yw3FGJcCFtY5ZddFz3yWeBlb4sMTJlVJ+UJ9577XkynywR4dC5Q
 TA0Q0i4zI6L3R8CkE+/FAGZMhqGoglGX3ypYY1ZCJQEO+FkqYb7FMaNpZQiJZDip3K8=
X-Gm-Gg: Acq92OFIUYPMgAZ7J0JPsunFym6Sh0TfoOLN950J1sCjAIPasWPTzYPwmO3VYJE0XxH
 5cqK4MsZ8G+bifikhTDSg8tEfOUP3JVeh4RA2u4tqye1fBR25CRnTtJ9Zc1ppIt151kj6Z33gNe
 35JGmdZRTBg3k6S+6+kNdimTAyBLMEB74UqG5qvQ8+sYpr/+h+fy3EDHvx6kDB5gkH+/9WYiAcT
 QId1quscIognFkStnu9DJmWkeHk9vklSMIxYUQQ3CX7/5B+3YWqDYO/nZqTbgQ5wr/gHd2gKqfs
 6nJahIsw1lufsqmEjI8Tp1Y9+aZwVJiNyhrUre05kZLBBSCemfyt0a6dP6t3D+1vtCDVZ7zwJjy
 Rv2YI+FnxhWY93QiSq55UPRZrl2073b9EcoUz7PIWEd4qiEeJZRm15d2RR53lByqT8W+ZjL0Kjc
 M7rf8F8gD+y9CLs4DWv7poU0PIGUGkvnPcMcGViYvAuzntwcKgmb8AubfRyioXhOMEYvK5psp+a
 y4yC5P8ixqoyqBT0MC8trpVJafQemnT9hO77R/L5TJZKUgNOw==
X-Received: by 2002:a05:6820:f00d:b0:69b:902d:d33b with SMTP id
 006d021491bc7-6a0b5e295dcmr1226410eaf.11.1781657388418; 
 Tue, 16 Jun 2026 17:49:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69f00d232e1sm6065348eaf.6.2026.06.16.17.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 17:49:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260616221459.42663-1-marek.vasut+renesas@mailbox.org>
References: <20260616221459.42663-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <178165738737.1775771.9798814698081564897.b4-ty@konsulko.com>
Date: Tue, 16 Jun 2026 18:49:47 -0600
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

On Wed, 17 Jun 2026 00:12:17 +0200, Marek Vasut wrote:

> This is a DRAM controller driver for the R-Car X5H and its enablement.
> This makes the U-Boot on RSIP usable beyond U-Boot shell running on
> Cortex-M33, as the U-Boot on RSIP can now load not only SCP firmware
> into the SCP core STCM, but also TFA BL31, OPTEE-OS and U-Boot into
> DRAM and start them on the Cortex-A720AE core. This is self-contained
> and affects only the R-Car X5H and a bit of R-Car V4H, besides it went
> through rounds of testing until now, therefore it is safe to include
> it this late in the release cycle. I know this will make rc5 massive,
> sorry about that.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


