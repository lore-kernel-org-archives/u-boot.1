Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E418CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F51883A32;
	Thu, 14 Aug 2025 20:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PyL+diGg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F1583A45; Thu, 14 Aug 2025 20:48:36 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC3883A31
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3e575ff1b5eso4925465ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197313; x=1755802113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5E06zTHJvyhPd4NFPlhqV188hRwI8YBNOLnRDgjlZmM=;
 b=PyL+diGg1enxKO9gCvNvvkuA9Erd5HHq6mBavEj5vcJv4PrblvJYNjKLw8e0vRKrcw
 nHnrseKLEbpc9CZh8RIaaZy72cd12SNub+Rd3ANfE6oWNmu4oG9Pc5oG+JC15wpXMU5s
 xTF7euxwar8ioDAO/9mx2w2valuHU0vlAEbQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197313; x=1755802113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E06zTHJvyhPd4NFPlhqV188hRwI8YBNOLnRDgjlZmM=;
 b=mQiXIMnAgMLKSDFa0v6zkXfyF44ezp9XxvMoeDKDp1q+7yUj6U2TusR42Xp/KDfCl9
 aDz50IfCOZyV8RjrU3nG+0Uc12j4UBp4ESS4yq/QgW3iZKSEBGRp55HEd1Acx4ldjs5J
 aqJYteEQMAZs0+3tqPMQLO+eeRVH7vn+1kE8jgP9heZwEvNsfQmQO/EvLqo+l3hWgbl5
 QHFqIeU1gvvDpBcdTpXz0CLH/fmZSWPIqDGcOuZvEnXdQAK8gK6FF6XifKxHwJt/dC5B
 CoZbCGDSdgQNsUBNpIdQUuxND1ZgD3bUp5+BFa93wffVW8Of6LOlwDSUaw8StBg/LVgh
 cE0Q==
X-Gm-Message-State: AOJu0YwOynvBnWW0qIwK0GPUBSDuIQooXh7L/5BJwb9Y0QwVlz4cyvZN
 JS3ADteUkiXmCQFIlirSkQbUgQXoZNpFZAe44aTNLvK5P9ecEYldhtsbpnH4pnwjOVM=
X-Gm-Gg: ASbGncsD7/eu1r96Gm9rb90S2NE2I2YNU0V8rqB1WZK8IyBO9ns9XjbwBPsj7IcR4ZM
 SSJ4YzznO1knX2p6k6XpXcr8fA77Osl7tM8vTZDa4I6chhlpOdjV/g5GNuPdU5GToh3TNylqAqa
 2gCerGnlwzxzUVoU6LmmNXbn2uG2IlOf843TW/wpLkAyiBjdnzqhDRImt42sUejDQxjINjE1hBT
 3HcWxuTSfRvwsFBDBzuNk22tm8/A5gPO6u2Hr/PutitbIA/ftabI7Ejom7m5AP6e184eFLjgBUz
 WA7IrSgzG2FIyVb73EYrohe/ekYrf+vN16gTq3wc7AT76cU3MxUKSr27n0fHNdZzYVwwFf53elw
 k52Rel5hjUvtgRoavYw1HFojr5alntpd/KCVyHN+W7QQbvGjpOEVB1sw=
X-Google-Smtp-Source: AGHT+IFXoQJsdaSEkPYhsVpjorl7S0xvz4Tjo1BO6X8q0nvuYmjykesUwiOaieswdwUcWAKWmVpZog==
X-Received: by 2002:a05:6e02:184e:b0:3e5:67a6:d417 with SMTP id
 e9e14a558f8ab-3e57080c4e6mr80114845ab.8.1755197313034; 
 Thu, 14 Aug 2025 11:48:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215111.1412197-1-trini@konsulko.com>
References: <20250804215111.1412197-1-trini@konsulko.com>
Subject: Re: [PATCH] sm: Rework the Kconfig logic here
Message-Id: <175519731194.3600102.12493069061359450279.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:31 -0600
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

On Mon, 04 Aug 2025 15:51:11 -0600, Tom Rini wrote:

> The symbol "SM" is a library symbol and should not be prompted for. It
> should be selected by the drivers that use it. In this case we need to
> add a SANDBOX_SM symbol for the sandbox driver. The meson SM driver
> cannot build on other platforms, so add the appropriate dependency.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sm: Rework the Kconfig logic here
      commit: e2837ecddc244198e3ebeac9ddb18fd439b0131f
-- 
Tom


