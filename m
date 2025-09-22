Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1380ACAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 17:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DBB683443;
	Mon, 22 Sep 2025 19:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SU7qWp/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023A583447; Mon, 22 Sep 2025 19:08:15 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85968004F
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 19:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-746c0ee5d77so3723364a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758560891; x=1759165691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNIcj0lcCCTXhCRxseNl+xVXtszpojsXiNNZatdymbU=;
 b=SU7qWp/uxz+DxMWnlGu4my4mvJv8ObADJGOt3kv/7aVsF3eF+IEdYNCGp9uXnR7SPT
 pqX+VZh0EwOC9Pr8QAW/5zpdcVRqU6SGZqNXkvD/mRQOvZZLGunDjqXLS9GKSnjBazg/
 6PGtXua0ZlZBTXNgoHhfZcn6Ip35pXZATLDaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758560891; x=1759165691;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNIcj0lcCCTXhCRxseNl+xVXtszpojsXiNNZatdymbU=;
 b=Vvjzhpo1PXYgyX8JJwYyZRV2JQr1pui9lmaLnBCwhFdWjUDYZOPTR9NE5qikjkCnLS
 f5WRkGhK0cMRXoyb1Bc29TKlj9LNUQO/E8tFOEOqujCDWRar2xhZ2w1vUrZq7k5F9C5N
 B0T3yZqruzqoia30DcQGrCdFdLLX1NrEBMt+nB3/z4ei//POeDFcxAJtLaoak7wrHoO6
 wDWmRiK4eqK0/RFXzdTH4IjK1jJbZ+wG1rtpKvVBWU6rxvsngEl+Sr0ZPvDQZ1l/81Pd
 ThK7GNA5FNXUoMFCtk1uxyXHwvTDGRnZMFtmLV9eJRrP472L+uG0kUYncfMqqjlGGm+3
 jX9Q==
X-Gm-Message-State: AOJu0Yw0bNivgBfRnhKTVctZFG1SDmUY4DM0bj9te0KGY8138eE8nxXq
 tdaHL4G/h6yC0jeC9oAjt+tkJ96B0T76x4u+WNMR6OackKmmrPUDulHpSpRDjD5qCx0=
X-Gm-Gg: ASbGncue5JKyh5Gv7bq2DooJ1DihZc/tVoSRLQEzq/4xIrhy0xLIOR5CK60f41T2QLx
 ioct8pgHgcUgUDOmYTublh4aMNn+Gs4TzzHFhTCH5o8y9u20csRqirCg21F6MlB4RX/G8Aeo+DE
 S2zGAI049Z4hPEH/oGn6JSkXXngV74fw2qZ1SktTqln6ZJtDUE0W7QmqG2bYv5K1W3hHSpdh2vg
 hODDHadCL/o3pr9M8w66cHc4t5ytUTPRA3vjB7ryeLm7S9bwnpuUoH8Vki555IvpuYd1caT9tHH
 hk+4buUObvalPW0E3I6cbfW+EdQQvh+0sHMsjjn21yz0s8OK4GUOoQnDyZ8Jht3O0mHA7yJ3JOY
 KWlTA3fhU/U8Mk0FK+4AfORusa8BtFg2zk3FGqPs/UXIL/EiRdRnKTyI=
X-Google-Smtp-Source: AGHT+IFpVdj/MzIEdT3nZERQamGzuEWW7kCdprN/mYyp2arvYltIrEzxfZhAPe+fUMLhc6g7nqLvPg==
X-Received: by 2002:a05:6830:4188:b0:745:53ad:e25d with SMTP id
 46e09a7af769-76f7c1679f3mr5690292a34.21.1758560891631; 
 Mon, 22 Sep 2025 10:08:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7691b0244ccsm6034332a34.12.2025.09.22.10.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 10:08:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250922141335.207427-1-festevam@gmail.com>
References: <20250922141335.207427-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250922
Message-Id: <175856089087.3025236.3228432184499661179.b4-ty@konsulko.com>
Date: Mon, 22 Sep 2025 11:08:10 -0600
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

On Mon, 22 Sep 2025 11:13:35 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit d33b21b7e261691e8d6613a24cc9b0ececba3b01:
> 
>   ARM: Remove mistyped GICV3 definition from ARCH_SYNQUACER (2025-09-20 12:02:58 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


