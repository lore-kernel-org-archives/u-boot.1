Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AF6CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0069D84834;
	Fri, 15 May 2026 20:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="erus9bBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AE7E84836; Fri, 15 May 2026 20:14:23 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258C58482F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so48366fac.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778868860; x=1779473660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LV+zRuVm8lYwy0AVHSm2Xx2zc/jCsZ9uttPggP1MRhs=;
 b=erus9bBwavWjH3O10BykJgxmIkmYpx++Ehjp1NC2fO729s/8cFzRyNH104xHu85S9v
 TXAdvJKmsgg1rOSOOecpeVg1VKheSHGzL+VTFJUQ69JYTEjuXNyMtiI9QGuXmOF/8fkr
 cSCeCUiS0Kq3DFflsbron5rFNI6K1y1/dg49Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868860; x=1779473660;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LV+zRuVm8lYwy0AVHSm2Xx2zc/jCsZ9uttPggP1MRhs=;
 b=Jkxuec4hAjkgvZlc4MDpUcs7eYYf6aHZOoUyDK9OUyO9PpcXnvZVlvQjMRWz6Z7DAt
 U5CQyU9K+WtMiCrIxApIKSHkFLmAxN04chaGb+UlhRm3t5v4FzAMf35LezMYW+RRjILa
 0QeO2LGG2hWLPD1V5b6bRmyB1cgiJANcaOJCac+x/oBPpqK15QWa0bFAvb5GSX0HqWXT
 u2F0P9/U2cfXXr17C2oWKmRRZehTMLiHNQbjhMFWWicZgSAaT3E3HvNqoabjU6BDinwa
 QOa09r2lbOUbVKLqYEYANYbEJ97qtkmqpFM2uCduBNPD68tA6Z/bs9fO6VR3Lx2R8hwN
 achg==
X-Gm-Message-State: AOJu0YzS9w6tLwPF9jRIMpXMwvliaYiWQdeeecjYZtC4tdxc4BQb2ZZM
 xCKcB7Tv6C1O+LZtNRtYOoQ+zRx1pzCBwwKgeYS7pePan78euDUYUOwxmRovRfs0DSuzGxlGD73
 JLRyGMZCRKYE8
X-Gm-Gg: Acq92OE4+MWe2O0+JXKHKVQpesLqI39pN0O9WrFgbatmFikVVHmpMhOlPEaXyDbH8bb
 sAxO96NC8BRJFXOmTTF5OGMG+fcMty8AxTNklUeiuNivOYxeG89fV27sw6pdkmX4zuzUfgfX5qj
 10Sbpd/iZLtQlgGpdhJ4xkoJmE0xc+1ZOqizO4MBs1uq/EPrYy0lGq3sz0vv8MF/Lejsrh34iJn
 FvMgtzMlzA1673BfZdHjSeAlLNJoslFnX1MfAuOlaWUKXtoag5P3Y3gta9zfyMgSREW4C4XyEkY
 DulHuYI8o4iHPo/78r1FXwPkFOIUKSDFWiDfAP8RZHl5ohQiIasI8Sd1j3PY3tJnknKboB/rUSW
 bdwLq6QCIsBkN7D2AThSLQeQVuhIpL+hu6DB4dTUtsUY8KiIIS55UVXciCMhXBMpLwVEjZhZDpa
 pFfojFEPMYyWfyCuCE3MmTxaRtW4txE+3urWHBOGmXUvLb+iENIf7qRyQhfwttlDC8Wt3zHN5wq
 WYbO03tJEaEAuSy2Q0uM+zaOBjCIQFgA3QMLBDdpRyCHktrEUnhRGBBIvDP
X-Received: by 2002:a05:6820:16a6:b0:69b:8c0d:4ae6 with SMTP id
 006d021491bc7-69c9437a3c5mr3020808eaf.28.1778868859753; 
 Fri, 15 May 2026 11:14:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc1fc14csm4678982fac.6.2026.05.15.11.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:14:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, vjardin@free.fr, 
 Michael Walle <mwalle@kernel.org>, fberder@outlook.fr
In-Reply-To: <agcoswygQdy5YKu6@nxa18884-linux.ap.freescale.net>
References: <agcoswygQdy5YKu6@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2026.07-rc3
Message-Id: <177886885883.657307.16685503482239178657.b4-ty@konsulko.com>
Date: Fri, 15 May 2026 12:14:18 -0600
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

On Fri, 15 May 2026 22:07:47 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2026.07-rc3 for master
> 
> ---------------------------------------------------------
> Various fix/improvments for powerpc
> Correct usage of number of memory banks for nxp and ten64
> Staticize and constify scmi sandbox driver ops
> ---------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


