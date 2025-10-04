Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1757FCAC5BB
	for <u-boot@archiver.kernel.org>; Sat,  4 Oct 2025 20:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFD0835FE;
	Sat,  4 Oct 2025 22:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sR0lfTn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF28835D0; Sat,  4 Oct 2025 22:48:26 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F07E80107
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 22:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-912d4135379so134855039f.1
 for <u-boot@lists.denx.de>; Sat, 04 Oct 2025 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759610903; x=1760215703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LONgDxp51LGH44gECjssyRh1/Oa33Y+jhF7O7RJB1oA=;
 b=sR0lfTn6SBtcS3LHnLAoCbk3DsJZQeX0PUPTX6GMartn27GX8q89qPYCCOoMh8VFs9
 49U15NP2osyLHh+EYMs9FXuNmVoPkh8tSB3w/Vv73oynEfrRJOpMfXhDypC1e5ptj+V1
 zLByC7n1Kj7KcIjp+z9HuJIrgilrPGTqGIe/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759610903; x=1760215703;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LONgDxp51LGH44gECjssyRh1/Oa33Y+jhF7O7RJB1oA=;
 b=NnNe0pOHgtgzeKFuR5yOfEhTCIf4H4vzXw0D7j94VQPTj6sJQUB/ySy6IS/VD3IelR
 sNKucBjDyAk9dQ728xz1tP5VGaA57lV9RZeWwDAWsovipj/NiWzNVqjHMvzR7a3x6YnU
 7embkK8t4PuEmzyC3CE0bvXLhDLvn5NmYjYF6CHzG3KDUfKqHci84EhCW8u+iGMK+WJh
 jEcPkbXQkEFl9DLlf0iTw2bI0C5IdkVnYddirZ4C8/TIfyIKJ6QDZuUduMMU7jE4mUvc
 d9ouzMz/OFkhO0Io91LNJlvSWWqaC/yhfF3/IZCxqwrv54Hp+V7trFv47VnCUfgSddr+
 T2yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEpoflMGAzdm2Awu98+K/hLkAlAmHzaXObg3bOoUrUFsZzwG/GNol6xmUQ0RTnBXKqwZ2gcrw=@lists.denx.de
X-Gm-Message-State: AOJu0Ywft5MhhgWV4g29wThaiPt5vdyQolXhIMc+pd3+Hx5/VL5DCABn
 kTvnFSWRlFBQrMr4ooQdABzZgWNSADLYyX9QRQ8V0u1bLicUW03VgRGhjc3POw5WwhAwhSiF017
 ih+qLUE4=
X-Gm-Gg: ASbGncsJydu7+UGlpyALTxA8jdKRxQnOd74Fy6UeEopRFino1xRMDZsE6hLOfe8/PyF
 sHTXQ0kIiXX/WqA+M++ehvO7kYCuslcwvjYcXBTfJu7mryNptjASrOth9PyJj0cDAgM72VBPs10
 UZMbR8vbC5qx17wYEIuI1BTlGk7MpY+B1ET05/E2g47MsqAij785RKWkE4dCzkdzE0pEuAoNHEL
 GWj8L6iLNGWVTh3bUd2D3YYDbbJOtPwMRcGyUyEqbZOwHeJwuPGcRi5d3qf1WeV9tOTzQos6DBc
 0Sr06AAca57iZSejE9GDseqcYH3cteUGPZ0fJLKAIULc7ps9zQiJNNUpvD/42HnKdV1xIXxJgNT
 gxqT59jWNkJRpId7njHvEUb/O+to86zFQL1QqUUzVm0OkoD+uZ1zm7RoXXPUw+g6ECmbxXpntv/
 fCkz4kJ5FVAvDXSIdjkAM=
X-Google-Smtp-Source: AGHT+IEjC6k9Er+SErL4clqazxk7Anm1LZRW3gIVXSF0c0361DX9BmvB03FNuqgtzMtzSGI1sp6svw==
X-Received: by 2002:a05:6602:340a:b0:92f:575a:6df0 with SMTP id
 ca18e2360f4ac-93b96acbaa2mr1017602239f.19.1759610902730; 
 Sat, 04 Oct 2025 13:48:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a88961d74sm321145039f.22.2025.10.04.13.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 13:48:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250924-fix_typo-v1-1-5e3441aae632@bootlin.com>
References: <20250924-fix_typo-v1-1-5e3441aae632@bootlin.com>
Subject: Re: [PATCH] env: fix typo in multiple Kconfig descriptions
Message-Id: <175961090115.3677446.477295423833118037.b4-ty@konsulko.com>
Date: Sat, 04 Oct 2025 14:48:21 -0600
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

On Wed, 24 Sep 2025 21:21:51 +0200, Thomas Bonnefille wrote:

> %s/environemt/environment
> 
> 

Applied to u-boot/master, thanks!

[1/1] env: fix typo in multiple Kconfig descriptions
      commit: 3bbaa9dca65f7133ed54102126861ff4037d88cd
-- 
Tom


