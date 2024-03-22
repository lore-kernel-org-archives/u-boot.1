Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237CAC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 07:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52EED8812B;
	Fri, 22 Mar 2024 08:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R9WC5iVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D00C78816D; Fri, 22 Mar 2024 08:41:50 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB6E8785E
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 08:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-414783a9edcso6608385e9.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711093307; x=1711698107;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khprt74GVPjvor8YqhCtfzPtGKt5rVNGCMex01JSw78=;
 b=R9WC5iVt3ns6K+EiHyAuZz8KaD4Z391X9bzpTJQtPBQrq+WUkzTymmmORuW4l5QALE
 BT3wcKw+vOX8JkmfhKTxpSIDQLMnv/RcSVOLYWuCfEhRUmhwWawFAnkbMHBJhxchSu/c
 dUrfquwmUKAaT4YfxHJZglB7nTEl2/BYpC4RxDK7A5IFI/IpN2LVjNy10b35r1lCCFKg
 dpnplwmIUeTykgol9VhdoyboKyVSKoTYZDPHloLTvZrovI2kVTQ5TN98c2xfo/PkAzND
 OK775EScF3iOQia0UptvQEgF93G6+V1oWnGZNegc9VREtKGrbeOlhHClnrelSHPhPByb
 snhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711093307; x=1711698107;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khprt74GVPjvor8YqhCtfzPtGKt5rVNGCMex01JSw78=;
 b=CwixwfaYXNzbEQH5RrWEkcm1pwzkT0Qk+I20DJXN130ykWCqjDeLkUzGwFH5ZrMtLq
 eK61DhPlh1e9tlTBmp3r/TqahhzAsCP55Y55hMoZOpdTk8kRe6YrZvBm5BOda2tx0Zes
 KLkb2lI45p98LIuj/f1D9PS6yIj0eLGYhErVFenVRqLII1I7bC+H7RlQadqj98RlFCN8
 pL/ZIucK3xl16+HcR3H6TUY+PomS7V8ePJelqmy+/nYcAQXtMOXSQRF5Y7JHielThEmZ
 yvrD5NOWFMlKX0wCnmHnjnuHaT+c+pAH+hxx/PQW4dVFPIORjoHE2hlQU8WHyfuGXMh6
 WVoQ==
X-Gm-Message-State: AOJu0Ywqaej3ICTq4igTFlRBZrbJG5UP7019xM03LMAz6n09rY+H3Yjw
 SyzxCNklEEx1gCww+lZnJYYWizyHBiMoyKnUs2DBq01mI6IayU34/tFmhgTEmUE=
X-Google-Smtp-Source: AGHT+IFPzSkvhjUVYAs0mWFdTP8PjyJuR0Nmr8jRR+3VOQTzEgSyK/BozDpbH4a0eO/smBHzSp1ixA==
X-Received: by 2002:a05:600c:4808:b0:414:bfd:379d with SMTP id
 i8-20020a05600c480800b004140bfd379dmr947017wmo.22.1711093307306; 
 Fri, 22 Mar 2024 00:41:47 -0700 (PDT)
Received: from [192.168.2.43] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c1c0800b004146bcdde06sm2236027wms.6.2024.03.22.00.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 00:41:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Colin McAllister <colinmca242@gmail.com>
Cc: JPEWhacker@gmail.com, sjg@chromium.org, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
In-Reply-To: <20240312125729.82695-1-colinmca242@gmail.com>
References: <20240312125729.82695-1-colinmca242@gmail.com>
Subject: Re: [PATCH v4 0/2] Fix Android A/B backup
Message-Id: <171109330664.31490.12829512827307130001.b4-ty@baylibre.com>
Date: Fri, 22 Mar 2024 08:41:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
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

Hi,

On Tue, 12 Mar 2024 07:57:27 -0500, Colin McAllister wrote:
> - Addresses compiler error due to missing semicolon
> - Removes use of preprocessor macros with ANDROID_AB_BACKUP_OFFSET
> 
> Bug was found by noticing a semicolon was missing and not causing a
> compiler error when CONFIG_ANDROID_AB_BACKUP_OFFSET was set. I submitted
> a patch to fix the semicolon before fixing the #if's. Testing the latter
> patch without the former with ANDORID_AB_BACKUP_OFFSET set will cause a
> compiler error.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/2] android_ab: Add missing semicolon
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/c044f89bb0c2683bcb14006b697ee6db2240f00d
[2/2] android_ab: Fix ANDROID_AB_BACKUP_OFFSET
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/026e0cd31278bcafcfb35d21478a94fc5072f78c

--
Mattijs
