Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68941C5320E
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 20:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6FD8897E;
	Sat, 24 Aug 2024 22:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GtgGSJZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B03F8877E; Sat, 24 Aug 2024 22:02:17 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1104D8885D
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 22:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a20b8fa6dcso201744085a.3
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724529734; x=1725134534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvAfao7K/Qg+KJAAzFEf/CoYurJFFqiHAJD+BaBn7tI=;
 b=GtgGSJZUEODLdccko5cNxA6Pc6rNOBfXK7QSRGmAtDma34KUC3DTzq7d/DT+YMBaME
 FzJ+SJ+1Hfb/aosbP1eHP1ivcXgmD2Z1ltRnsXbAAeFAeHL3efgK2FeNItOIIsvFENlH
 l4LgwCyis+N46KixvjARCw18sOemMFDtTkRsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724529734; x=1725134534;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UvAfao7K/Qg+KJAAzFEf/CoYurJFFqiHAJD+BaBn7tI=;
 b=MyIdnCrDYjkC1GrzyZIRCqu0uzdiGCjA6gCJYhmilGRTxz40mmpryQG8uxxrbdhVYo
 l7MwRvcv3geO23yJ/2GuHmejze2i5mf00ct6NwUFd4oaJewEhI+RqDoIdtPtrRodJ+Iv
 72PJPWiOP1Iv38YrrzD55bu8Oz0UbuNpy97AdSTiACwWtCx7QR9e4ilr0zRDkNeyN0nD
 3Vfe2O8Mvead6i7TmM5ZjHTmLqz8F4lOtGxldqpD5Em+LtKo3vU0b0cjxUP9NqfhBVRt
 5+PkL+dPIlV6y+MhYq8JaES1hIEvQCeIOvsO7zJCjAKMqYcMGizAGFU6Rqio2XRlFI6h
 h9qQ==
X-Gm-Message-State: AOJu0YymNcRX/wXvOOWy1s22ixsnK9stKAeOhfTDy02s03fX0EOSHdNX
 eecNO9Ixk1MyZEnZY5svmVQg7CIipEQ75xpjEsV/bteCttP7gipS2ZmgHaoH8D+vIHs7ni+WpMl
 k
X-Google-Smtp-Source: AGHT+IE9/lRpcawIEjBPekg37JfVfL9HXAGAbyzJxR4KY0Ic04uZMuUBpFAJnkTUcwe1aXRuBG12Ew==
X-Received: by 2002:a05:620a:c44:b0:7a1:dff1:57ab with SMTP id
 af79cd13be357-7a6897041edmr580648385a.23.1724529733760; 
 Sat, 24 Aug 2024 13:02:13 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f41f507sm300754485a.132.2024.08.24.13.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2024 13:02:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240816034905.3541020-1-trini@konsulko.com>
References: <20240816034905.3541020-1-trini@konsulko.com>
Subject: Re: [PATCH 1/3] test/overlay: Make this depend on SANDBOX
Message-Id: <172452973270.2581148.5934159294858834187.b4-ty@konsulko.com>
Date: Sat, 24 Aug 2024 14:02:12 -0600
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

On Thu, 15 Aug 2024 21:49:03 -0600, Tom Rini wrote:

> As the overlays are sandbox specific, mark the whole test as depending
> on sandbox.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


