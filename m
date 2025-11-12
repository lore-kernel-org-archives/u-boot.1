Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0846CD37BB
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 20:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4591983D0D;
	Wed, 12 Nov 2025 21:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Yjq7UKUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E36C83CEA; Wed, 12 Nov 2025 21:03:26 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6BC83CF2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 21:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3e7e57450ceso466651fac.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762977803; x=1763582603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ncDq1zuh8SMUed2zuk/vAvuj/BDqKKgDdAYSEGfEr0k=;
 b=Yjq7UKUv8MU3n0dhn5RFCfx3Q9HMogZH/7cw1r6zIeHm67u708llO4HQYekate8oot
 JLzJCMmj42qQJmNTLUfm5Gr2CA2D0CrRumopnDkpqvjqlK7ijjYrSW4AFR36S5B8a1qN
 a5p3R7ClY6YvQogaDji3fLNiFfkQPPmfIfFuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762977803; x=1763582603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncDq1zuh8SMUed2zuk/vAvuj/BDqKKgDdAYSEGfEr0k=;
 b=DOfOMShu6HE0PUKN45mzMe+rBu2JJqi4TBu5d8pHSQ360pHeSkwbqDmawOrnE644pI
 11nc5g2lhRYZNlMUV7W9Y8Wx9I3OQq2AIKrT6v7smdbM9SYK6vHvczArIjl3NEiQGcX5
 h5cvpNvs+zKxkYfxEz1jskcokFaVkMM8dzzk4WuzN6MBHwMbqgxMzgvGvHVluNxDcwrj
 bGQKe22nW1x7jdaulJZ5hgAEr7V1RxYR+61HR0GWz+b4auCWOm11OZrAhyd/DV73Y/Gb
 QBUn/f1zXI4uGB8SENgrbwDQmKkcvWfv2XHwgqIx6h54any2KJ8cTT202o10Ghkfvodz
 2/sA==
X-Gm-Message-State: AOJu0YzmIyp6WVR7VtcEGHlXXgek/Ggn2z3tjLNTr+QLtDYgV8CVWegs
 VsjRu0J4QcU5QdVUCNCErR0ejKDGw+vXRov+GMlu8BOy7cybd9VkNHgEAOueSI/nNw0Zja6vnAe
 PoMWD6S5cKA==
X-Gm-Gg: ASbGncs6WNcbQ34CJMlq+uaPyDFGKdKK1+dZT/LC57/1uy1rDIvZS8FOKR2atfnKJKD
 CxgtrJcbfTmfRpyngZRvR4EBhC6cmlqfbQ073COGQKjL/pBSlUQawtGXXnwuGtOicVaOKJp+BLn
 ZqR1FD7GbHQHF3WTif9vq9KmfruWDoA0097J+EDhTYGPGUB2VW5Kj/KUjGWv71ENCYx065/a03J
 8+UKH53tFiNfXgCjkwzsStzpg8oftytARnGRVoI0/BfxltcnUepwozlXsqCW+JISCeUOGINTiJA
 R/C00igva4m3u2RClyujxP6g25OIEzTR+ksj0mxKvSdr6OPYRVst+3nOfYJlecBUJfqZiRTzcJK
 cpVxaG1HDZ2nMrAansFNZG4yhAHCV3zutBQPCbxGnQo5w0BRj0mDNOHrl32ugRUx7ALVP8jqaSW
 MyyuOsnQIlWGUoPK1JCtaE5c+Eepg5AUZT1a9Z+TL5xes2Ti767+rh
X-Google-Smtp-Source: AGHT+IGpEJLCQfx3l34mrpADmpXb1bs9mnPdZYcRjmlShB70iOHBLUy8c0flhGBx6D26guTbfjPI9w==
X-Received: by 2002:a05:687c:260f:b0:3d2:cf03:54f3 with SMTP id
 586e51a60fabf-3e833f180e2mr1695753fac.3.1762977800848; 
 Wed, 12 Nov 2025 12:03:20 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e83281c9bbsm2169596fac.18.2025.11.12.12.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 12:03:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: [PATCHv2 0/7] video: Remove unused drivers, clean up dependencies
Date: Wed, 12 Nov 2025 14:00:01 -0600
Message-ID: <20251112200315.1111980-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

This is v2 of the series I originally posted back in August[1]. The
changes here are that I've dropped the first patch as TI has recently
posted their rework of the driver in question, and I added Svyatoslav's
Reviewed-by tag. The end goal here is that "allyesconfig" will be able
to build (on sandbox).

[1]: https://patchwork.ozlabs.org/project/uboot/list/?series=468123&state=*

-- 
Tom


