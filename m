Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC25C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 22:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3029580EC0;
	Fri, 24 Jan 2025 23:28:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KVO99LzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1489B80C98; Fri, 24 Jan 2025 23:28:48 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE7880C98
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 23:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d8f75b31bfso26690216d6.3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737757725; x=1738362525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kj+E5xcJganCqSq9Zni8CoYp/9CBnRPdt/0YPxs0rfg=;
 b=KVO99LzY2ZA9/wkIdInGDZTXBCOgH6j9WfLHBe7vPjpabPnG+YIW5KGZoAluXW+nPx
 qeC0oKc/ils9KjC3b03G7DVyyP8PLhYVqzK7b+W+QVWWihlsVcCkGOsxiswHNVHE5+B+
 HQ7+59PyDvxOgzTMb4kVZj+E0jp/tEBK4c9bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737757725; x=1738362525;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kj+E5xcJganCqSq9Zni8CoYp/9CBnRPdt/0YPxs0rfg=;
 b=nH1pSdWJPgEsuNRF7bhc9dNVPeSTLlj2AS/D0oH8BrRXxIh1aFAMGm5WO+BRoFS0/O
 XUYhx0QWXqQxAw8FuF5rSevGS+gqYZgTfEIxyOFgIAHyqYb6ryFuRIMYWjpQToA0iAwJ
 mA3IyDSWBQCZMgCCgixdD8IpPzwsKisOleVahXFJ4COeZr2BfGJPrITYCm2gUuTdoPxk
 tsWtES0lzRgTuRHb8k9IP7NfR+7RbHYMkgy9TuvDHqfxrHdaK3kru6j3Wilj019G8ipb
 h3u7fYBva7pEIQQTVIeU0dQVfFfyXW8pQIU0QlD+Fr9W2iAyZzRLwZ2qGchkYEkydE01
 cCbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV25y+OhPrQE4EKn+CCo9bBSmttqNSag3kJ/I185yoePGnPWiO6wkgzaVSxecCivtb8Xudc3Cg=@lists.denx.de
X-Gm-Message-State: AOJu0YytKhSG7Czuuw44Bx8kqZaxM97tAIFzsP11TK1iP3MN2w2fS1+q
 sUglGcZk2QDvJ4OWcGT7Sdq4x2f7KyuzzBMgMdeNUarUsOEPAKrGTliUrlV/AEI=
X-Gm-Gg: ASbGnctF8uwG+m+/12vhUYlGv2n83iHN83rkm8y0gsomEZjBkoRnP9EyyQa4I0sPBCA
 8H+3vLfVIUNoUIUXDJcTRc7YrfwKXtKfaOduyk5nDbgNJfnXZfiItSNTyBP5tMSmhdWFdZsCkDJ
 PAmcsXlP68Hajv9TQPmOGgP58PFu6364ldkE6E0t/ViaGaN7zwcqiegWYXwOCGYfstpW9uqMOIT
 jvlh/hxRF6E/xdzqha2crfdflXURCOXCoKxzINzSr/NcB9d375SWuImbaq2jAVmQ5NkcolqdGNd
 558=
X-Google-Smtp-Source: AGHT+IEvIaxGCO9jF2tLyRQ63+dwC22/2oZWunREHWyda3XLg3/mzZr6Slbq7PNua64+ESTCC+Tdpg==
X-Received: by 2002:ad4:5c63:0:b0:6d8:7ed4:3367 with SMTP id
 6a1803df08f44-6e1b218f0b9mr571798306d6.19.1737757724979; 
 Fri, 24 Jan 2025 14:28:44 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2052498d6sm12787946d6.47.2025.01.24.14.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 14:28:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250120082932.20620-1-heinrich.schuchardt@canonical.com>
References: <20250120082932.20620-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] test: str_ut.c depends on CONFIG_STRTO
Message-Id: <173775772378.3136238.6082663348669064089.b4-ty@konsulko.com>
Date: Fri, 24 Jan 2025 16:28:43 -0600
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

On Mon, 20 Jan 2025 09:29:32 +0100, Heinrich Schuchardt wrote:

> The string conversion functions are implemented in lib/strto.c which is
> only compiled if CONFIG_STRTO=y.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


