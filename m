Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DD0C3ABBF
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25068820E8;
	Tue,  6 May 2025 01:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bxr31fcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9051782998; Tue,  6 May 2025 01:35:39 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D348294C
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-603f54a6cb5so2996659eaf.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488136; x=1747092936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y2eUgO/6Y1Q4tziXN7NeWR9iQq5JPSCgw8dbz8ZKx/c=;
 b=bxr31fcj1E1cfuBdYuh6SXWMe2LRSDx3XN3p5g+gZYO+PJ0Oyn1FYDa9sVmhEoHXIm
 J3vvvOj593WNELaU38u9tb776Wh90s0OXOSxWBtVR4RJcOIoi97EB5T0AZKhrDx73aJL
 tZLxv1tmxyKSJ1zYfjOgMJCL0x3RjtxgJSsOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488136; x=1747092936;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y2eUgO/6Y1Q4tziXN7NeWR9iQq5JPSCgw8dbz8ZKx/c=;
 b=qvxFXJu2lR1ykVoLi4oqwh09RJYsZs4c+1q3ARaeigzw16jE+A5Vm7mIPnAq38/57H
 l0GLhDV7EEYrkf9FqUKovzIVz1vKvw5dD3sKrKL4I30QtvBB/4a3gv/OUAq/cnmEDHtA
 4hTCYkNhy6xIMiSsP0E88/MPZzrg7CVCs2PiJKFo4E8na06Wgfs79ppdOS5s8IVfo7LQ
 Q9pdUlmmKd8NAqpdhhxV3YaTCKhmuAdtGb4cccHZLdsFwhUKA3+An4Qs+a6apCzzOVoW
 PTr4k0wv4VX+Hrj84AHzpfsBDxXxaWROjSL7P7RZHT8MvaxigumbJUn9pQPEqX/ZX02T
 8d+w==
X-Gm-Message-State: AOJu0YxPTD83GpCDR/Uik0Wl9m6pTuTpalH6ifq96Z0sxmyvTbuFZGxL
 1GPGxZowUrOCoyWpko7hC4LfazXUcKAgbddl1Z6Xrhq0ODPejUScpE/2hIbRWM6Hu9stFgUgIlz
 J
X-Gm-Gg: ASbGncsMPpHukZtxk2FBAeRRj9APaaz47DddiwSMcLGBqVb6NpkkUxCizSwgniCruGn
 0BBq+C7k+cxBbdQeeE5K90MlS0IExhgOahdT8xvw120BfRkTpucCJrrcWvOraSYciTXYnrdtoYc
 dNb+om0eY2tUiACoFJUuUmKJjZ7cV+V3xiIovxhKOKtmY8S5dYqm6HW0GyDyh1bbF014TzHtQ+M
 xxpjMep5QDpAZ7fWU9hhDdeO/cEEurYWrUBoHmJL1D8q+eU52P6WPEJ6lNMJkyf+AWawdr4vE2S
 o/BvTxGQpqF9XM9vOP3MPV3QYJevnJnh/XglSc8M0ODFbH4ZhX5LTKJ2e9L+Fh09eMmqiaLM5wI
 d
X-Google-Smtp-Source: AGHT+IFA6r7qygCGNziK7I0s9HpoBWDpZ7HjaPfDK/KQZ0VOLbUUmg/kMz8JrdsAD+w6gTbKMuYnDQ==
X-Received: by 2002:a05:6820:8cb:b0:606:361b:52ad with SMTP id
 006d021491bc7-607ee7f20c1mr8986797eaf.3.1746488136242; 
 Mon, 05 May 2025 16:35:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
In-Reply-To: <20250430164559.27095-1-marex@denx.de>
References: <20250430164559.27095-1-marex@denx.de>
Subject: Re: [PATCH 1/2] fs: exfat: Use strncpy() and bail on too long
 filenames
Message-Id: <174648813526.69658.5088493510482972231.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:35 -0600
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

On Wed, 30 Apr 2025 18:45:51 +0200, Marek Vasut wrote:

> In case the filename is too long, longer than PATH_MAX - 1, it
> would overflow dirs->dirname array. Add missing check and also
> use strncpy() to prevent the overflow in any case.
> 
> Fixes CID 550305:  Security best practices violations  (STRING_OVERFLOW)
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] fs: exfat: Use strncpy() and bail on too long filenames
      commit: 4ba2fe14f2cecf7b614220e8e19c1fcdda92b748
[2/2] fs: exfat: Inhibit unused exfat_humanize_bytes() and exfat_print_info()
      commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
-- 
Tom


