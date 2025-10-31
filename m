Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DEBCCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B3983A94;
	Fri, 31 Oct 2025 18:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V3r8T3Yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C713983A9A; Fri, 31 Oct 2025 18:51:41 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D63983A92
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:51:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c284d4867eso785988a34.3
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761933098; x=1762537898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaur+7soxwws5+Vhzxc0XEPkhVaLcb4JjH2HMuX43z8=;
 b=V3r8T3YbPvyujpMrt4/tErrfYdrvfSDobPX2dpQX9EJ4U1iqcHwmyxYNuZqLreQJMZ
 VFfL5EWbFyRsByjni+OI7GxVWpOsRAwCEXew7Nm+/uWRQGzOKdn6Vj5XA9wQXjenY92P
 pX4ACIGpQgASGA92VemmKLha5B0nrCKGUVwQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761933098; x=1762537898;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaur+7soxwws5+Vhzxc0XEPkhVaLcb4JjH2HMuX43z8=;
 b=Vh61XkULB7F8zHzNXT8eO1orciW6JaP7sV5mK2VKYn4xo6S1jW8qz6Co9SrX+TJRwS
 12APh6Rs8TTvpNwV+vmcmUDY8fsNA9n6DrFzYXVf+W1gMBgSZsqXigPvRm4/amxgfdUK
 AtRNTTtqpI/zCV3/49Y/W0EKgGrJHUrC9MPos4DVI3DoFfGzg56ktRWnrUOn3PBFZah5
 b0qN52E1Or+CPsjUup80cW9cWrDENHJ8qGFykhpNjr5KNnCYMZ/Mszj1jUXjwK891UCt
 V/dDFJ2Fdb4r8gPZQR/g+gwbAg/tgdBO4gnfyc/uupjxCOf9hnl0h1/IJpBudruEDfhz
 fxVQ==
X-Gm-Message-State: AOJu0YxEFJAmRF0J2J3HKVAnBdl4tmGdpxLXzmDYwgp6v/at4BLaPqLW
 354hCgbZQV2QM37zzhseyBgQDux0OBNFsxT9c45Rh0K+LS9xWuQcjnUIoiNRI4ljTLxM/bB/kDV
 35ukrbAqfjg==
X-Gm-Gg: ASbGncvXh9ITTW6Zfq7yWBMgybanI/3WCyIkXBk2CZCFgoT5sEcRzpL/GWoy8KXVTcY
 8neR2VoSodEkMxq1PfdMu8o7cG+NRB05je61Yr0lKUymwBm+CRr3aCEOhqi61kk7VeOQtgY7meG
 dnTTGxR2/Nax/ywElhMYz+Lm5qLBRO7lMKxQqDueuVF1e65zNmnIfsosH1Q3QJSY6WEeCibSTqs
 n6HHVlbvxyOqrSgfjsSjzeEAC5cFOxDAawWLXGa/S7ePXkzp/UQ+Vo7gq+k61G84qnDTerzlQQS
 zYyemabLOoUx+pvecPLjDypkbcXXXXKLX4B/1xdcDO01NtsxlOofoy7W7lk2cyv/S+qUoXLdi+3
 rjKm+ujobSODCBtv5l71Llxum7WJZiK0eSQmaFdliy7gu/d/G2o2YY9iN5I3fTwJZtEq9k78Kuk
 YgM0l/aqcSBciXy+Xy5J+4+yXtisMBDxrgutBhHSzAJcDUB1/8
X-Google-Smtp-Source: AGHT+IEuBhAk+ranlJOVQg2r9FEWeUZAioDNcVyXRB164P32bMo6+SVPMx0ZTlQBnkj84I9iqFMLjA==
X-Received: by 2002:a05:6830:719f:b0:749:566e:316 with SMTP id
 46e09a7af769-7c696717cafmr2466352a34.15.1761933098187; 
 Fri, 31 Oct 2025 10:51:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c699c40d68sm704626a34.15.2025.10.31.10.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 10:51:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251031014742.516268-1-festevam@gmail.com>
References: <20251031014742.516268-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20251030
Message-Id: <176193309742.3953260.16736260835270960245.b4-ty@konsulko.com>
Date: Fri, 31 Oct 2025 11:51:37 -0600
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

On Thu, 30 Oct 2025 22:47:42 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit e34d01d23e45e007368685ffa6dfd674b6dd7b17:
> 
>   Merge tag 'u-boot-ufs-20251029' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2025-10-29 07:41:43 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


