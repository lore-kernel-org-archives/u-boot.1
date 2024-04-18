Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FBAC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876B4885A0;
	Thu, 18 Apr 2024 05:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bWayJXMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C447884F1; Thu, 18 Apr 2024 05:40:22 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC978855E
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78f0440656eso24555585a.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411619; x=1714016419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzWAQiLPd91EZlRBkk07zgAWBQh5WC03WXNilRcAQwM=;
 b=bWayJXMCkYzppIjKVwf3Ia+nsX9OJMsYKFMfXY0B3FAJzu7u3HxGn6xzmHUshdKqQc
 Jst7ULs+6pFBquU8z795bDKblHrJv7KR4YkMKgeO1hX3HrUoAWiEKNf8IS+G6c4ahPcn
 83exmN097EtG9x8+Y3zaQnJ4LYEhpIW078hEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411619; x=1714016419;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzWAQiLPd91EZlRBkk07zgAWBQh5WC03WXNilRcAQwM=;
 b=EtYFlMe9IakFw3sPRNUwxjuvxyLA+yxMyRKKFWVdQolWo/H6ZY+1hw9f0zVGh4V07Y
 qCDMXbzHvwwkHj9CjTsdJJK/7vvcnVkDPaxRCD+1wwBk0zhxpa1z6hZ1qtIEaP8AfQ4I
 BH4olntpSGENrlXtlLVBRmlritVpVEKls+xN8Ti/xtBO+QBWrqkQiyXIlTOPM3588I0v
 C9/hSw91vwp1oPfKJT44M+/uYBR/IUMT4x1dAIWNTCUlQwO5ZvfJcAVmHaUzp5+UU6pN
 A0ADVHNI/0vMoguUrCuLqgP5d2LT86bxpwxmZMgwYdrMcUpFkAW8Qlec7MhMh3AvhsCT
 w6Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK1vdOahisOkGXj69hAhWvk6a46A8HSWo6wXSOZuLzYAakmO8ax5AuGXWtSaRnuLgGBl5bj51LnYeAlqyEQaVeLczg/w==
X-Gm-Message-State: AOJu0YyHJlju9u1pSIlBDN1aCbVliFnu1zkyFLwK6Gq+1LrXNSRiMvLO
 GAdNM6+nc4xQAdDiA+8224MdSn10/fuUQddSocjsWHLyGP3/HVbRTK6olt62JXQ=
X-Google-Smtp-Source: AGHT+IEKLgwvaYqqo+dqQc3pHIvQ867mxDQqEqUbtkv+m6xNUgZK6+54qgFEUJEclidoGV/kNuzMlQ==
X-Received: by 2002:a05:620a:1652:b0:78e:e6e6:9dc8 with SMTP id
 c18-20020a05620a165200b0078ee6e69dc8mr1530571qko.12.1713411619485; 
 Wed, 17 Apr 2024 20:40:19 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20240410215034.18806-1-heinrich.schuchardt@canonical.com>
References: <20240410215034.18806-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] sandbox: don't call os_close with invalid file
 descriptor
Message-Id: <171341161857.1250683.8060017271771083786.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:18 -0600
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

On Wed, 10 Apr 2024 23:50:34 +0200, Heinrich Schuchardt wrote:

> If open() fails it returns -1. Calling close() with this value
> makes no sense. Return -EIO instead.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


