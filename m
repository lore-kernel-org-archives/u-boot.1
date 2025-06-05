Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC32C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 20:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED798091A;
	Thu,  5 Jun 2025 22:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="su2PGwDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9FD182977; Thu,  5 Jun 2025 22:05:36 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE9880050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 22:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so1220903a34.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749153933; x=1749758733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XlY1fQeuWey6qv4s5PThlpdIGLCW+NRPRuDUKvIFcVU=;
 b=su2PGwDa1Xuo3iO3UjLreldYCXCsrFlH1u7AT+J1cnrzyZc4e9Mhoo62IXzm2fcr9C
 eTDdJ1hQFK+69jiZsp6HESuuV3efcTWPd8r8AQj1OXWWgbt4cZOs+1OjOLwsgx6DQxmv
 +MOZtESyvWlU8ymUSIOvGQSF76MlcSHVBTQi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749153933; x=1749758733;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XlY1fQeuWey6qv4s5PThlpdIGLCW+NRPRuDUKvIFcVU=;
 b=PB+bQNsjqYoLPDuJ3Yy8A8JZGCmed7tCbzDBZ68Rol+2RQxZJjjgmc8pQ08WQLRT8L
 XtdR1M2KzrS6xwCn808Ay5D9nW4MgXHcSJKW6LgVrFAPP6kv+RB9vV/bkD2XgMhigdKm
 eaAfhUahKHqLBNXGxt0fKmJ2dCC/oMfcuhLeyUSaM7OfJZRBqFDI9rs2979/L0m16S4b
 zqAJA0o5eq59kAiUQ4Uhz0lEyrrZXieiBd6WeZaGib0rTTaQ/Q9PYhmdDTUgV/ITVTy4
 YrUYbYgMdBLrmBTLNk82XzU3fJypuO86f0mE78Xi3Y2Zrh9RkNW1RrSZPzlywtMDPyhL
 Pyng==
X-Gm-Message-State: AOJu0YzB3UcPsNefMkc1RoITPe2tCFDoQ1MFEHSiCxmnkAqMuPNvDyiN
 0mFAC/5q+kj1L4zDrrzciWwLaInf9hL3Tjs5/jDtiNWPqyry4DiuBm38zjru7YCCdj8=
X-Gm-Gg: ASbGncvyJNrEjuaP2GFv8BjqjolYZtB+k+KtMX9XWK2fyN/tlGElHom4mSIoW3YHNzn
 5joW/y6MUJCV1UN53Uneb8qgV+jKn6p9MDVOUjDwqeMJcqZ6VU+6KSBZOvs7dhLNGCVFmYkz6oR
 kKjN/A8ycQcEEjDW1JTY5Zc82QvD9kuldk2zbPMRAMpC6wbA1ueonOLEsaMyFgl48ZdiMJqPrty
 Z07/Kr6zYmf1qMUnvfgoQO7aVu16IVNV6L8NWf+d2IfxhHiP0vomMDRD7B0sO7s833pMnt3wQL0
 UjznYT6iKLRnqK8vMSUYgD1A9Yb89MJ40gP8mq0PFRG1U+87llp9+EKyVfoOZfYqPLxXHKBO5JF
 gd0fZlZJXSJQz/gPGw9U8tw==
X-Google-Smtp-Source: AGHT+IHVf/+FieSGOrPmw5W/FjZnLq/0el6Mhr7BO71C24v252C5YoSP7BqhxnghjFXniPQdKcm3pg==
X-Received: by 2002:a05:6830:6218:b0:735:b0a3:e485 with SMTP id
 46e09a7af769-73888efd658mr599996a34.25.1749153933500; 
 Thu, 05 Jun 2025 13:05:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f59e4dsm37103a34.22.2025.06.05.13.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 13:05:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <8ab256b6-7469-4d14-878c-ec379943fa3e@monstr.eu>
References: <8ab256b6-7469-4d14-878c-ec379943fa3e@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.07-rc4
Message-Id: <174915393278.2077960.3932148894218055917.b4-ty@konsulko.com>
Date: Thu, 05 Jun 2025 14:05:32 -0600
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

On Thu, 05 Jun 2025 16:29:35 +0200, Michal Simek wrote:

> please pull these fixes to your tree. CI is not showing me any issue with them.
> 
> Thanks,
> Michal
> 
> 
> The following changes since commit b22a276f039f818d5564bec6637071cfc8a7e432:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


