Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5FFC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA78388119;
	Mon, 24 Jun 2024 23:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ci/TNg/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B9D86E40; Mon, 24 Jun 2024 23:00:43 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECAA0883AD
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 23:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6f96f8489feso2539037a34.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719262839; x=1719867639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PHOfCHqpJUKof13nE580sgxsHCtKmZmM3+dKZg6dSY=;
 b=Ci/TNg/sy75RHR57cLDQd9OcacAe4wdcHFtNbZupYHjCeQkQ5ETQ4lLNl2nolFi/jJ
 FbyeEen2ZRcQoQNh7UzpGiUEtYFronV88vIjWP2wKzvaEor6fwSJWacsla9LmBnfU9dA
 CyIpSJ1zlPpUbvD5npJGjTWwkrVHonXQSxHYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719262839; x=1719867639;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PHOfCHqpJUKof13nE580sgxsHCtKmZmM3+dKZg6dSY=;
 b=hYq3f1mVJol6PNQauiaswcz8g5dyEBFMA2F7ICV4i5UC3BHg3Ow6hCh4/Fj2ZYi0rM
 l2uvrdFwgEMJs2gJQLQpgZc0ZImjvCLTz8d8lNQTFibFpaMrTV+q5pAbm4D71Jpx65L6
 EyWZwUEWwkr9RZll+yDTvzEVDSW5kT6HFOSTorN9Ufy08FuTva/69oxu0UPxxFXHrSR7
 MGmUbrgGJgbkaE4xN+b9k1RG0yigLKlBpXcvguYmGoAKzfi2KvDXzJfnFpfAmcLFy/vE
 RZP8ohnepJCJx2fdR5TQRGgzPJKMX2fVgMxCXpVvFEjxLYdCSAFSjImNf1jwySW5fwm1
 crDw==
X-Gm-Message-State: AOJu0Yzt7DQagNj+KsJwddaq2PmGKAcXXe5u4xpO5s+GBlIBc51r8YN7
 KTBPTIdTgDaAv8GcDCkst9gjrR7FwCSNuDDls+SzPbJoui1WQQpFIcKUrEBYKRIsdVU8PJSVwmM
 WTlQ=
X-Google-Smtp-Source: AGHT+IExesE1nEEJeUvgNUEvoBHF3kCmIQ/fVIIIBaBnvmY4Tu2euTfIgG9hcqeRtNWNvsCVviwNUA==
X-Received: by 2002:a9d:6746:0:b0:6f9:64f1:5b14 with SMTP id
 46e09a7af769-700b1293b61mr5201738a34.27.1719262839669; 
 Mon, 24 Jun 2024 14:00:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c607a93sm1328518a34.34.2024.06.24.14.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 14:00:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240623105815.62434-1-heinrich.schuchardt@canonical.com>
References: <20240623105815.62434-1-heinrich.schuchardt@canonical.com>
Subject: Re: [U-BOOT-TEST][PATCH 1/1] travis-ci: SiFive Unleashed: avoid
 format warning
Message-Id: <171926283891.1896821.16348933174208785340.b4-ty@konsulko.com>
Date: Mon, 24 Jun 2024 15:00:38 -0600
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

On Sun, 23 Jun 2024 12:58:15 +0200, Heinrich Schuchardt wrote:

> QEMU expects the file format to be specified even for raw files.
> Currently this change only suppresses a warning.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


