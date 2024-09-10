Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82568ECE58B
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 22:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D044C89155;
	Wed, 11 Sep 2024 00:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EB9jsDCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA09C89143; Wed, 11 Sep 2024 00:38:45 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E478E89140
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-45812fdcd0aso2885071cf.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726007923; x=1726612723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt8XWnk9WEykKwuMHtRqMt5iPvEVIdR0JXDWJUWXm3k=;
 b=EB9jsDCgqM4jxBDjPIuAI48KApfL9hDavUNtTZ+GlQ9buyiOymbDq3lNmBWre3gMQU
 XcqudmUkfeFuRbf4C4Pbb1NHHYmrQM0etOWeQ8eXN2wWpB/NdpddB8h42QdCZWI8YpBo
 jn6Y0s0VZdGnZQBjmnpmx7SMDHSlCjT0kj7A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726007923; x=1726612723;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bt8XWnk9WEykKwuMHtRqMt5iPvEVIdR0JXDWJUWXm3k=;
 b=EfUxyQjOP0U/DWmJpLgrQEnt2dFsQ+qR5P4a6y8tACmorik/31npcwb0pmnp4NgKAz
 t2NsJv4x/DxiGN/b42M+MZ+BBIFwnY0WwklENIxgDxctahrU0jBOIM6Lm5Id0Lz6+dCm
 S3J0B5UGb6mdwo/QysRuWmdi+GE+QoUp5qKUdwnp7tpjKtHYRYV/UE+Vy2G6wlnTSQR/
 wiAzM73Y2cAzSJ0pceDExPDYnAqem45LKZpyfsZE2g5gfGirEo0tP0KWSfnWZY1JAsGW
 8TwvWRcNS4+AJ0dNRE+kwxvIJTt/hMtdzD7mEJhWqlRbKQJInl/hTj36uXqIOxBZDj9W
 zBRQ==
X-Gm-Message-State: AOJu0YyVpKRg/6BJguDvi/qgM6u0bD6qqRNC0IXCBXqYO+zCHVI8rh2r
 sODLGpO49bHe4ylKvB7d3FBFf3lebFsVzJjDx82LMXgi092bqnx58TM7DDgYqfU=
X-Google-Smtp-Source: AGHT+IEZgSRKd892ufEuvKPJapBKchPgz5Sq18rB/ZHG9sEYEBeMTzzBBDmRWPgTm4YvW6GeSai0RQ==
X-Received: by 2002:ac8:5a49:0:b0:458:29ea:b3ba with SMTP id
 d75a77b69052e-4583c74a0d7mr87346391cf.15.1726007922751; 
 Tue, 10 Sep 2024 15:38:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e63873sm34009611cf.7.2024.09.10.15.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:38:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Daniel Palmer <daniel@0x0f.com>
Cc: sjg@chromium.org
In-Reply-To: <20240831031706.2654697-1-daniel@0x0f.com>
References: <20240831031706.2654697-1-daniel@0x0f.com>
Subject: Re: [PATCH] spl: spl_load: fix comparison between negative error
 code and unsigned size
Message-Id: <172600792174.367866.17571688175691835944.b4-ty@konsulko.com>
Date: Tue, 10 Sep 2024 16:38:41 -0600
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

On Sat, 31 Aug 2024 12:17:06 +0900, Daniel Palmer wrote:

> read could be a negative error value but size in spl_image is unsigned
> so when they are compared read is used as if it's a unsigned value
> and if it's negative it'll most likely be bigger than size and the
> result will be true and _spl_load() will return 0 to the caller.
> 
> This results in the caller to _spl_load() not seeing that an error happened
> as it should and continuing as if the load was completed when it might
> not have been.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


