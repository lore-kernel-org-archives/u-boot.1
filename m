Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9F1C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 19:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02AA5839DF;
	Wed, 21 Jan 2026 20:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jI7ZXtpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 544B783AB7; Wed, 21 Jan 2026 20:19:06 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE33839DF
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 20:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45c819ca0f1so98873b6e.0
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769023142; x=1769627942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GeDY0QxL3+kjTOvdbGZcJFXQOgyGAf+4Bu4VROqk83U=;
 b=jI7ZXtplaT5VdgofF8GZyJJhU6Cfe0Cd+h3fOt248Q7IL/mqYXStRkD3vlgItv0wQw
 DooFlKUO6/4zK/M4ihKHBp/Bi5pOU8hE0JsTDyHYxGrBws5zj9szDASV9OuWQo/6w99I
 Rdly9AKKRlQaZJ7KIHxxraBd8GsmZeLNqgoYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769023142; x=1769627942;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GeDY0QxL3+kjTOvdbGZcJFXQOgyGAf+4Bu4VROqk83U=;
 b=doFFM9tWkmoK/R3WhJIFV9vnq+dsHQVfHTg3J6UZvLAc+m1zMRL43ojqudqdnBciY+
 T6hVK6c+/sfjN7sp/uySWWNDzvLggnYt0pAGbxRyfOPhYaZsh0zj7yytdw7ch6d2/6m3
 wDTgme7xDpULdcDfZNxRkEjLCQ08Dg9WDVsHM7po0nfMeCqvEcNidWIhWANSoEFeC6tU
 cRleWvFn+1pYOTHBqDCD6IpcRVFqwYo7nWo5ct8FjYCCdiYS3weZZKj29oTB09lX3xEC
 tl6wcjM05iogqixRZ6zfZP7SxR7DbzEkKO9tOQOFd34KRGhaUrcmpa4/7MmgSoOxXjkZ
 ta3A==
X-Gm-Message-State: AOJu0YxzVbcOzzMyCB4OaPcjEjchsQXQ5KEASfvDWXuSsKvTOoyVM/6j
 0aj1Vg7WIn3erk2OrwvJEEcnvrZprOn4FulbOqDnK3vyW1qDDTEKpcYl/QZ8SxrVwk2chNoHMKV
 QUfMY92E=
X-Gm-Gg: AZuq6aK8JPz013yxgIiLbIKvJCKa21rnPSVFYtZCg6KwQecI5EPdb4Xpn63IJsLVQ3T
 JtAHC6QwRIYqQdeld9IAn5u45UjWVKAeOyvGPxhZVxJtwALdE1OKFiORZFPWY1s7epqlCdxrKSF
 4CffrghwOmordOSQdPGYnY9+/pMuimgiQaUY/el/lR1RbScWo4s+kG/AZB3Vnpzd5Ue9UeT+wiP
 su702fA/wMOChJdat1mnpZAThWZV+nUWk9DgwiSdF+NIMRCF+c7dC7FxecN7n4oMLdZWdE6X5mW
 1FntoblnF1ywhZ5KGfrlGQlNLUqPXsxvrXXMH8WQDBNRssw5SY4cvDQjyPB7r/5SdcGHe53Qu2+
 aHNhpA4EcRQyPbsQMNh3RXJoPQtKXJ18MBuEj0EK5RZ7kzlGyvGrP7X+bFgLEyggOApESPhKIOI
 HYmapZBFIVd52T4Z5850XPEm+xs48To5BaCniIhXYwojBKtsA7MaYKySXARISgQp9RJveVWbUzo
 0K4WpuoDS4aA+igh6QpWttQQBs6kUbnva20oQ==
X-Received: by 2002:a05:6808:50a2:b0:44f:f5de:5519 with SMTP id
 5614622812f47-45ea3d784f9mr297669b6e.18.1769023142131; 
 Wed, 21 Jan 2026 11:19:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9defa8a8sm9181560b6e.6.2026.01.21.11.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 11:19:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260115212723.3926453-1-trini@konsulko.com>
References: <20260115212723.3926453-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: Remove remainder of ARCH_ORION5X
Message-Id: <176902314160.643148.80959976278995136.b4-ty@konsulko.com>
Date: Wed, 21 Jan 2026 13:19:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 15 Jan 2026 15:27:22 -0600, Tom Rini wrote:

> With commit 5663b137e682 ("arm: Remove edminiv2 board") the last
> ARCH_ORION5X platform was removed. Remove the rest of the architecture
> code which is now unused.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: Remove remainder of ARCH_ORION5X
      commit: b9d4a17b90fd3b98023da5cf3b45a1a5058fb0ad
-- 
Tom


