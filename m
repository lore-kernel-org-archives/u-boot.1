Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A061ACCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 18:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D7183DCA;
	Fri,  7 Nov 2025 19:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KWdKYGDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B1783E0E; Fri,  7 Nov 2025 19:39:19 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C646F83DF2
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 19:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-44fba97bfa0so380025b6e.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 10:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762540755; x=1763145555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvV5cv3sqpJtwjNysVj+gqi4NZna1frV8fDkLcAlVJs=;
 b=KWdKYGDFfiHHiarH/Q6YtFP+4k7X5xhUEDYEy9yWBf0rjQ6L3n2t5bHNFpAlKOmtfk
 Y/CpODhWvOmc4SUnLR7qfDmIvt5HCLxqasEp3WZMohrzWobwGoNMvdY1jmoFZBAwzztW
 SHjJMC7n1emINyiwmXkO5E6WXhGzj8MMfP5fQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762540755; x=1763145555;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XvV5cv3sqpJtwjNysVj+gqi4NZna1frV8fDkLcAlVJs=;
 b=tAe0BxIvaDjEJ3nV2YDqki79hpRVXiRzqWUIncXb4HXQ30S7hStWX7NSyQ8ljNKqjX
 lQ87LirFuSlfBJTp/SZz2yYIvQy4FWkkTrGxBrtf5Lj3LbA4ccKF0C2/aGwxnff8eNR3
 Sh46wa5cD/RaqnK19+DqIu192QkfqgX66v/ArvKkoMayU5/V07dnMJet6Au8YPsU6obb
 uTrwh0HIAIH56yPqyoUf+0WyyhYuDH5xaStrdOgDbO90mKQjrfwkEA7xGqGn17gBJGdD
 y/KN7vGZ2VJuTgS0AXrpI9Th5suN7mGwXEpBtxY1CzauAJQkDsNFnISFXdMK0kOJ3P3u
 Dhkw==
X-Gm-Message-State: AOJu0YzTjyERGpcBDMhVplrY1qnemoDs7ePRcnFrIecxmMvFql6/jHQ2
 q0NdwxsROcikPfSuCWq5z3awghLnEc/576jVTxJntwBLB2TaJoBA9HNpJ2RkTevbzrc=
X-Gm-Gg: ASbGncufKpAOv8Y7X7kzMXL09uFhir5+gyy/FSLv06qdROqoHEyR1rQciNEDgWxVlMW
 9HEV47jwPm8+8MsL8erqRP3JOldxcL+PmGLcWxsRZSsRkECbjFmd8pbQ1w9mS7OVV/cR+x5uvD1
 7INbdkIWRLEGpuYlo1Lb+R6gxFUCZzK96DFvX0VkAWw4Oh7RWkNLlmshH9BOO+1unjf2LL64zXw
 351+qeiz3gdAaowRs7zoh56LYTxcZRxL0FGGXE4rDSCyOmdyOvHdf0S42fJFZ0gIKkfOFUl/tcU
 j+3KyyQliWKP87/PJr0Gdbd9ckoaVvqK1nlGD61XKajGMskQMDG14XLFa5HJK0NV4TIWxQOKwqE
 7US45mpmP9FfDMugSasslXRDlo9/QGUuwDrAX5BGntqEbEGOydyeEIG0w0Q6FEV6DJrQRzmKYty
 yAPFYKV7B1iAcCZYbyW+XbbuAcmDrrYghjN4sPBycOGGkpShkF
X-Google-Smtp-Source: AGHT+IEaWJsmcu00dmZQUfTHGieNoI/Dsv7hh6F3+fAYSzClt8FEvEe88Q+E3DGgHnBDu2d8uWKEpw==
X-Received: by 2002:a05:6808:1786:b0:44d:c21c:cef4 with SMTP id
 5614622812f47-4502a1e9bd9mr146940b6e.18.1762540755449; 
 Fri, 07 Nov 2025 10:39:15 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450027e19e6sm2587642b6e.21.2025.11.07.10.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 10:39:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
In-Reply-To: <66686bf7-f7a0-45f0-8fc0-ef3693039b7e@gmx.de>
References: <66686bf7-f7a0-45f0-8fc0-ef3693039b7e@gmx.de>
Subject: Re: Pull request efi-2026-01-rc2
Message-Id: <176254075462.1989038.16196135001023796800.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 12:39:14 -0600
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

On Fri, 07 Nov 2025 07:39:32 +0100, Heinrich Schuchardt wrote:

> The following changes since commit ddc916334a7a7e180b532dbb2cf1b778466d2b9b:
> 
>    Gitlab CI: Rework our tag usage again (2025-11-06 15:16:51 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-01-rc2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


