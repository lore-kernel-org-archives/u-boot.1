Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF42C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3910A820F6;
	Fri, 25 Apr 2025 15:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GpzJ8rSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07058210D; Fri, 25 Apr 2025 15:42:49 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFAA481F4D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so1454705a34.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745588566; x=1746193366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j/gh0mYURWaprv9bdQ9D1yps2h+5cr7XEg1HqFZdQjc=;
 b=GpzJ8rSKN8W9YgBg5GpFfxAAIoE+mjR+RStxJr/X+Ti+JeUSEjXlS0RKzd96AvCl1W
 1m6RVNU0wvOZPR2uXOpZArRuo+BEvPohReZ6bh6GRsQ7vmIAYfgRxfrCbDzwpDTxcZVk
 G742dIA8CX2oVfhp08cCuofd4gB/jKyMIYBsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745588566; x=1746193366;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/gh0mYURWaprv9bdQ9D1yps2h+5cr7XEg1HqFZdQjc=;
 b=kwKQlm22+Xcso8YLLo5bBPXEFel5PI9yeHHPL8QW/wWgMorWVxL5uxBTFra4FWxxzz
 KgoFyP5Z0XoirWncKt910QVM3XTJA2jrV4mJESDP1TYAaBUKg0Fb/RmWdTh85ErLpI8o
 Yk7/6Fc5jku5y2r6Nvs5HlhAwwvnlXt36Jad705G51Ii25hSuXjs1zx4qXLsoqA88DF+
 W43qJ4IulD998hTN4A3B4x8Tz15sIsUHmcmdO8MAXeBCIDn6kNmG2U80EKu3Hy/+fcJW
 TnneLm9Avfr0avkcmfw9I0mnPqVJt97ebTazUrQyYIRBRVEvSXWSmLSzxZMmSrw19ggS
 sumQ==
X-Gm-Message-State: AOJu0YzLeyM/kdMQR8HB2DnDW71gGWf0bqz0KdLNTsqpwTMtQWKJqFSh
 670KLIX0ZLaLZXGZUvdueC/jPdpSnNykpwCd7GToWZKTowd4gwtOp+Xro4w5O1aORmPKSeyoGoN
 m
X-Gm-Gg: ASbGncvCi95CTTA7V94bK+DrkQ9riCJJbVorDRSPN9pRBBoXJsWfN79mQ72voNSgOK6
 NcNiOgo8JoWEjhBftNIk2lUsjgeIrGS01HbZkBGqkuS3JOzNcmi85089tiGASQHNEi0DeW2upTa
 o7V01NMB5J+tH5TX41V/9A/V1ixpUqm29wjlfuoaugtKcY7rjtsgSXBoPZxDixV/IeiWWwNt4Gk
 ZBc2GF/CsM+TVBwrpXHGR5SCpJRd/ZjEE/8dNT2hr2E/NAbKGfsyJly55y0cQAcvGMv7nrsN8XB
 osajo6Pz3BIEVQJOMSrGnk+kSRtgrD8E18s9Rm+/zOOuOxNckJhk00Ckra4UijU9XagXwnPdPab
 g
X-Google-Smtp-Source: AGHT+IHh4yay/D0VLnN0qsQmtlq7112kn2zPmbodFsnY7SQuXwO+8AFjyvM5u/gc6MTfpnpoV8wX+g==
X-Received: by 2002:a05:6830:6812:b0:72b:9422:aec with SMTP id
 46e09a7af769-7305d02badbmr1262963a34.8.1745588566535; 
 Fri, 25 Apr 2025 06:42:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f1a3267sm680272a34.22.2025.04.25.06.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 06:42:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250415181026.652393-1-trini@konsulko.com>
References: <20250415181026.652393-1-trini@konsulko.com>
Subject: Re: [PATCH] python: Use and refer to the venv module rather than
 virtualenv
Message-Id: <174558856583.695028.6071025459834109535.b4-ty@konsulko.com>
Date: Fri, 25 Apr 2025 07:42:45 -0600
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

On Tue, 15 Apr 2025 12:10:26 -0600, Tom Rini wrote:

> Using some form of sandbox with Python modules is a long standing best
> practice with the language. There are a number of ways to have a Python
> sandbox be created. At this point in time, it seems the Python community
> is moving towards using the "venv" module provided with Python rather
> than a separate tool. To match that we make the following changes:
> 
> - Refer to a "Python sandbox" rather than virtualenv in comments, etc.
> - Install the python3-venv module in our container and not virtualenv.
> - In our CI files, invoke "python -m venv" rather than "virtualenv".
> - In documentation, tell users to install python3-venv and not
>   virtualenv.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] python: Use and refer to the venv module rather than virtualenv
      commit: efd00b03455644b18eaf2b6dcd07f6d55b95b39e
-- 
Tom


