Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C68CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C7083E42;
	Fri,  7 Nov 2025 22:35:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PE7NIERY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA1183DCA; Fri,  7 Nov 2025 22:34:59 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2352583DF3
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3c9789ea2efso402547fac.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551296; x=1763156096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8scbCt5gOkVtlkr53Bdj+PHFigNpUH1IWxNL54c98AI=;
 b=PE7NIERYgAuc8WU5hH9uH9gkm/IPam3N2uhwhci6A+RK/nxuLxgYhTGbaJgx4N6PAj
 VSEflfsyGMu/L95zaRXkXQi9cX6+gs5MYBOx1khDYKyyu+Gst1priiCnPcEORNuFifwZ
 87eRX/9PLfV8AjvC2xksG6Q/2QxY/AS0oov4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551296; x=1763156096;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8scbCt5gOkVtlkr53Bdj+PHFigNpUH1IWxNL54c98AI=;
 b=ESbQKRLKzdblEEHXZxx2GGtNBoh5k9CmdApYDdj+u564xMXusf5MAtyd/Yd/qOGK4w
 1NRhRmU8SaevQVPIKXUQ6QC+hPa0mrMzS1+Sa3WHmKmmyFrrVocd1I+O28OQHn3K3Aqb
 uwo/dDkmGnN91roSI6hxBslWpkI75rCYdTVmQhHpogf+O8mbGaS1SxtQq6sgowgcFZ3v
 qehGgQGQoLm/bilFtuwtqMoOemeudbOKFidBBWPkCxyBXstgLq6duGme9O1uI7ZyIYBl
 XySAHA8kVAcX3qauPmVfO8XksNYBWM983JP0S/chNafN6UQdAlqsg2vWUhk5Hn0bp93V
 zZsg==
X-Gm-Message-State: AOJu0YyDv5Chdjz4fZUkknbAvQ38vZl8+z8e0TGxUBRnAOAJt1C1zhhL
 hw04iOGBidgoifaJC3xVPuW1jz8/YfyHnTYTy/Mi72/wnwERzHjzwub6Sf5S51iTWEtQCI8VZqv
 4sQTI0gv5Zw==
X-Gm-Gg: ASbGnct+B7OdXRzqynNVSlluJ87bKkU6mn6c3pyBjBqIuo4UeqanNGsmvgtF39NfGgz
 S1+xeDgraBYZJwoaCqNw+ixmLLOZGqpxJHNVASUgTNRRM8sNyJkEL0rHVb9NEA5uldHILtbe8P+
 eTQZ8rY1JYacFrh61bd6JrYcpkjTtPvt/DSgWs/xWDTsEjN4E5H3b4QiOZd9TVkLZPVh61Ht6DX
 Y9seklxY87eWS3iXOCPblxZjv9Z6+wVpfOIBOL88qghRo3cqp4mFq9y56fliBPJzLEC1YuGYeu4
 Co6bdVLwf9fK1n8AaQjWG6fxhTXH59ww1J7fdOEL7HH/aday5bsjQZQg+C6gzJ5cv8GE2ib8nzx
 /o5fwg4VbdhM7ij8p68Z+GgpV7yLD7quRMI6Y+2S0+CkowA01szjeKnkWBTTuVznd5WlWCl2uqv
 0ft3I8lN1prFfGf3f0lgzgJWNFyLnLfU9FK7qo2g==
X-Google-Smtp-Source: AGHT+IHsJhdBMhBbFM3AtiBXgdZ4NhWnwE3XXipk1q5juJCo3V7X7KPEW1pYEx787tN6B2wUHA+6HA==
X-Received: by 2002:a05:6870:289b:b0:3e0:dc3a:334a with SMTP id
 586e51a60fabf-3e7c2bdda29mr598195fac.45.1762551295772; 
 Fri, 07 Nov 2025 13:34:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:34:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251024172642.2419507-1-trini@konsulko.com>
References: <20251024172642.2419507-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py: multiplexed_log.py: Clean up and correct
 RunAndLog()
Message-Id: <176255129518.3424353.3632932606091044189.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:34:55 -0600
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

On Fri, 24 Oct 2025 11:26:42 -0600, Tom Rini wrote:

> The general python documentation for the subprocess class recommends
> that run() be used in all cases that it can handle. What we do in
> RunAndLog is simple enough that run() is easy to switch to. In fact,
> looking at this exposed a problem we have today, which is that we had
> combined stdout and stderr but then looked at both stdout and stderr as
> if they were separate. Stop combining them.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] test/py: multiplexed_log.py: Clean up and correct RunAndLog()
      commit: 20b822dd4f01a7489f888460f70d7830e0513965
-- 
Tom


