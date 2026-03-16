Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3763FF53D70
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 16:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5178410C;
	Mon, 16 Mar 2026 17:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mc2huh5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 234B7840E0; Mon, 16 Mar 2026 17:34:50 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD35784101
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:34:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-67bd4e63606so1587908eaf.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773678886; x=1774283686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LYabPOjqJ9YL5LJoz9FihHOxOzEMRKGguyCmagSoPo=;
 b=Mc2huh5H6K3JzzfUrxRXSg5/Bg5G4b17dr/rYHtQRnnXWD3wVRVq7kw90WVZcX7vgD
 pH43qSLSXQxw/HXwHRV/Pkzd4JHS2vOKub59sBGg4EHVRGxDFBUbaJlsMy66BLno2rJ4
 Q1eYWJ2pJdPW6LQLJ7Lgh3gOd+fTf8B3YREww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678886; x=1774283686;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9LYabPOjqJ9YL5LJoz9FihHOxOzEMRKGguyCmagSoPo=;
 b=lqtKClHabO+RlpaZpJGCBJtIT7zPFIhLFzPsY/nxa6BMhlEfNtlC1XUiKyjbPXDhHF
 KjPvC6iNPw0EjEbxllxwcsVHADdUTbSgW9N+1sGZ+IKjcqZnmLp19pTKLt0ANBhBDFQh
 LsFFJqh05zENw3i/1gowV0PUYk/oH0fnGS2Ibj8EowQJHbj0ltKvsXkTpIiZEsvhS0Ia
 c8rcXm2KRjCOrcujT1Iv9moEk8v3db3F6jWVem9fpR7lKNTyOP64GKbBViLfERLBQegJ
 rTKkPhKPDiKw+GD43nQ6QAEDEMvvjL3X8ijSxXyZvdQqZiqIXaSh+NxxGDjM0epV5OJs
 oGbQ==
X-Gm-Message-State: AOJu0YwCADJtLhTuvS0g9x3NmxHfU19xr68cfomvZOIxqOOS0pm2uTjC
 sN1Tamf08EUzqAl3L3sHmxp1wJUaTQq1zhAf4WwklPGHxHOnyxedfYhpc9BYIkmSmA8=
X-Gm-Gg: ATEYQzzBTXI24HhdLXKlo2MK8tNsT4jVeeN1iWa3/05rUDAFdTnmXigMcArUwqa/pyX
 QtHOQGT930w4jEUG/RchlFEmCHpiKUPkz5keLXHocIoDFI/BQ8Ed5gj2QxuDPNDq8qCzJAn4V1W
 uKRVXZ/rdkoJEy6pHaXSMoRs/plJ50v/K3oG+a22Wg3/litd04SnGIXcJZVkw29Eswb3LPGRdS3
 kxVcmJ5KnNVakgFxkV1ZAd9cEhqgxBif9nQzEcyUGw7enRXH3+MRBfBQAXI4k/vviT8zxmoqoB4
 nxpiA0uGqI896G9e2KQ8DpSYsuEue/r69JeSkOXw4zdj+CBk7DsUF1N+EnUboDYK0tlXKnCD5Ue
 0SYK2ba8uxjmTib/f2SNYv/3awF0tFdv8UbPnitxLySgkqfV2FniEsoY5935Wid4FArgQZo6bqV
 231etyMDOmLXFA4jMvDzFy72vFz6QRklVgE33jJzl9c4clKHjsFmlgSzkr5H0VDLUu/mfQCVZOf
 c4Ds/umuMi1zwFc6JTF+MbEwSsji82CXgB09GxxhbV64eU=
X-Received: by 2002:a05:6820:80c1:b0:67b:c90f:cea3 with SMTP id
 006d021491bc7-67bda9df02amr8515719eaf.31.1773678886480; 
 Mon, 16 Mar 2026 09:34:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc91174fbsm9660143eaf.4.2026.03.16.09.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:34:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Shantur Rathore <i@shantur.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <6a7870e8-bd72-4a6c-a513-0ed819db67b4@gmx.de>
References: <6a7870e8-bd72-4a6c-a513-0ed819db67b4@gmx.de>
Subject: Re: [NEXT] Pull request efi-2026-03-14
Message-Id: <177367888562.2244648.17427277584478887364.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 10:34:45 -0600
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

On Sat, 14 Mar 2026 10:27:55 +0100, Heinrich Schuchardt wrote:

> The following changes since commit fab3b667b4128fae2d94752bb03088f84dafcf89:
> 
>    rockchip: rk3568: Include all addressable DRAM in memory map
> (2026-03-13 16:17:15 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-03-14
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


