Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C09C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFAC82C13;
	Wed, 30 Apr 2025 19:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B4S5Dk7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527D782C44; Wed, 30 Apr 2025 19:03:47 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF5282BB4
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so46524b6e.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032623; x=1746637423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3YGltD+S9I3ySn9G5yLLLtyVW0wNsdSyrWGsUEKOyY=;
 b=B4S5Dk7e/dnyricJ7nEppyuL5uQaE9DIUTw0ot0GnqEyTeKkx9eqgc8wa0At6PyXGn
 2+KX6Pw9ZJ51Y9LKGcMdrXU8xiypLk4sDgOHRDYwVumDCmL6kCf5bgns7Cisfo00w0QH
 +4vwH22ybClMhIi7fJE8Sx8uHT6oX/X7A7Z40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032623; x=1746637423;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3YGltD+S9I3ySn9G5yLLLtyVW0wNsdSyrWGsUEKOyY=;
 b=QOSki3Q7x/YvGGyFR56UPH1IKGcdwkieRi4flOKZnVNCbJsy7muqQQn0eVjsDnDYQi
 uJPiOnAe3WzmMtzcMFAnYRxCY4DvHSnGoMJ1I1PSFqot+gdHKpnCl0GN0Bm4t7P5FQDk
 bYsDh7q8x2QxkKj+dnZ9rDQ9Zv9VHyVLHRO9GEv209S029IN36+wHa6U6n9CEcCBax9q
 UHq6Z+gWtr4CVdZzTVk/xM1Fvb1cf/Q3SZ/oyKZl+2dx4S3VmafpEKXZTltJL6nNI2eV
 tCDBIho5QPZnz9DAQCC7J/Ij/qyxEwth7IQfRc3F5SqeVmJgj2l6pAAHZzZvVzykrYwv
 CrzQ==
X-Gm-Message-State: AOJu0Ywxompoo/uBq1EMPGS9k4Gyw+lO/dxGhIx2RMCZRwf1v91oc9jc
 bFsK4n00bq2qXGPQo3ObiI5ciaNiSn+edtz7RSjM9427U6gQ9r6+LJHWqd5+l2jjxtDqu4GwsoE
 o1s8=
X-Gm-Gg: ASbGncvBRWnkKgjTzJCjmxIlr82frz3WLyKLO7MNaAjG07G+RxS1jdyspSrAqUVUm7m
 4QC5TRTVOM7r32JLu8ehVNM1EczBJgeN+6LgKpPDc6ZMLasWwRM2RUbevn3ZozbqMVapXP8HpL5
 1l9arZCTLLZIVsbyXTAsBAE+jKuRbvi2Bp6KCz9eqMjqhoci8XGYyQSRFj6qkb9g8JvTEq9JF2k
 jZCJZiEyotl7aoVJ9tXPXYnmK3syZOQJzK9mviKFFOKOSuFtw1RAQuJp2X3+XRYMn3hMtxDWYLE
 6X/I4mOM7EjKCf3FonBvOPOABRyCB0q+uO2yr3FmOyOTDx7QDK87RtFtMGQ8vOktMv+d3f/zWtd
 s
X-Google-Smtp-Source: AGHT+IGzxhtyTcRl9+VJBVSFmmmHmO0GxHhJVcTfe6pbh7UXoxWg0aNqHcfrLr0ioK6HHfrwHwpB0A==
X-Received: by 2002:a05:6808:338b:b0:3f9:bc8f:8145 with SMTP id
 5614622812f47-402c1462423mr1887107b6e.0.1746032623467; 
 Wed, 30 Apr 2025 10:03:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402e1c102c8sm456111b6e.16.2025.04.30.10.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:03:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tkuw584924@gmail.com
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
In-Reply-To: <cover.1743575001.git.Takahiro.Kuwano@infineon.com>
References: <cover.1743575001.git.Takahiro.Kuwano@infineon.com>
Subject: Re: [2nd RESEND PATCH 0/2] Add support for Infineon S28HL256T and
 S28HL02GT
Message-Id: <174603262251.1760506.2617656011004627261.b4-ty@konsulko.com>
Date: Wed, 30 Apr 2025 11:03:42 -0600
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

On Wed, 02 Apr 2025 15:26:39 +0900, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Those are 3.0V, 256Mb/2Gb NOR Flash devices with Octal interface.
> Same fanctionalities with 1.8V version that are already supported.
> 
> Takahiro Kuwano (2):
>   mtd: spi-nor-ids: Add support for S28HL256T
>   mtd: spi-nor-ids: Add support for S28HL02GT
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] mtd: spi-nor-ids: Add support for S28HL256T
      commit: 2aee40a49bf65505f5802376614bdf60b233a221
[2/2] mtd: spi-nor-ids: Add support for S28HL02GT
      commit: 10285e550a7e1576a8796da04fbe402920015dfe
-- 
Tom


