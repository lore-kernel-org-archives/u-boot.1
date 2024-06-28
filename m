Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D046C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F82D885B3;
	Fri, 28 Jun 2024 21:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JhRuon+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9337188570; Fri, 28 Jun 2024 21:49:28 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70C2788168
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3d5611cdc52so492579b6e.0
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604165; x=1720208965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpIYI4tIqk3RW48uR5UjJXY/S21bwN6wYjF3pSs/GL4=;
 b=JhRuon+qaatlZOxSFvQHmZR1ewr/KcDq1ODYynA1xyKa9EgDEt0VO1udELz9dkLPBR
 5fGC4J/+QCloCh6LfjdqRUS/xeJm6k5drIuLiWCMhsE6Ic3LPqmbNOOQHdX+iC0AtiOl
 MsIQcUzZZLp11U7/wOucPVrXOwezzX5Hktlms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604165; x=1720208965;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpIYI4tIqk3RW48uR5UjJXY/S21bwN6wYjF3pSs/GL4=;
 b=uMPeBDrBBsXeUHArMhKLofssrYax+t9Ibya2WsppK1TmiftDdFpxwnw5PHSNu9yfOQ
 gp8J4yUP61XxAEaT4viQIQAf4o1fuetQpdKBXeV/6PYJrgLVjvACjFHe2d3i+seVhYEq
 0P6YxJkmiZfvl19QVpMd3DdoqJJHCVWYHHfPo8O+DN+anhNm2gMW5yLY9Fqc5/AIPXQW
 u2FMBd3UV9AIgwMJA1xahUKIbT9+Ig1jYcfUmIhOgx0Znuta31xiSwpBVvxgVDaZvfWK
 vyhibYdd5NGme+cHEfmBFDNpXu7DQUByfSCu41bl1z/LGF9yRpyQAinl7QgvVKszlTgr
 RbXQ==
X-Gm-Message-State: AOJu0Yxyt00v1r4NwX8iwH71k6FzIBE7O/EWaxQ5aga2IH1r7NcAO1yQ
 N6IdNdH0hqOHR6XRDObhMXucTzKtVY6xQGEaacI6C/1uVGTfUCpbFR16tZWh19E=
X-Google-Smtp-Source: AGHT+IGgvyTNYOLOReFPA6JqIy718SGetJQ4MDxnCmqGGTR+Qu0k7uwggfwhTAtOgSr3Xi6M4w1pcg==
X-Received: by 2002:a05:6808:1447:b0:3d2:1f5d:f992 with SMTP id
 5614622812f47-3d545986c6cmr21724951b6e.32.1719604165271; 
 Fri, 28 Jun 2024 12:49:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Nishant Menon <nm@ti.com>, c-shilwant@ti.com, m-chawdhry@ti.com, 
 vigneshr@ti.com, Robert Nelson <robertcnelson@gmail.com>
In-Reply-To: <20240618045318.271133-1-d-gole@ti.com>
References: <20240618045318.271133-1-d-gole@ti.com>
Subject: Re: [PATCH v2] board: beagleplay: Fix the bootpart to pick from
 root partition
Message-Id: <171960416429.3614069.7706755276403276165.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 18 Jun 2024 10:23:18 +0530, Dhruva Gole wrote:

> The Kernel Image and DTB files are supposed to be picked from the rootfs
> of the SD Card, this fails in legacy boot flow because bootpart is set
> to 1:1. Fix it.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


