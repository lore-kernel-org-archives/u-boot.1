Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D89FC021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 03:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A45780F70;
	Fri, 21 Feb 2025 04:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Evl9jhJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A84758007D; Fri, 21 Feb 2025 04:28:36 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09048004F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 04:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fc291f7ddbso2671483a91.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740108512; x=1740713312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcjCkvSPlAJrPjdR533J0qQgThS829Z3gMWewYFROJs=;
 b=Evl9jhJN0e9oPx5J+L2qlZG0NqZLx+CSyhzixC/dJ9khGSRYdm/Ro8P7WaNYpvSEmW
 MWQuyCeeJdAlgYS6Tp6v8ZXiQNoALVtwIlwDUdK34usnd+6b+ZoCFVVFrlGpQEwMTCWt
 xZShDRgwDh2O1ZceufVFYx9jkB/OBPLc3trtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740108512; x=1740713312;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcjCkvSPlAJrPjdR533J0qQgThS829Z3gMWewYFROJs=;
 b=HVoheR/vjQFuBGSshYomLdLcWFgvSGVe5GNcJZyWfRmv5EtdSPHHMn935gBQ0VdP9E
 PMXfkuX9g4YRwz0H1TPkJQXQEzRpQL7FlfQiMbKVh5D7Zo67hhRG6lpNN2r1wfLIdTEF
 sdESEZTGOEtGI9HtxWnMIV2N9g130cjpydEdvI3u5guo4qQxA0glJqks2HLVvXA6/Uuh
 xoS0ZiK2nXxaWe6PZLww9L1D0MnFmCd2LAhz3tfRTVVp24Ws/VxpBWB1UdfZIU/nNes1
 lrsC5chF2tj9BMAskhAELebk6YV/8QZRhi531s4QMcyHyL6Hcg+rY7h31iL3E0fvi/iH
 Awwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1dvHT8z/vE86fw9cYuLHsDDbcIRVjaFmCRNPP84GM61tm1Lsk3+0RFvkp9oEmKmexx5R4ORA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4z7a6R4PCH4tzddjGU2eZ7v744RGJFanjqWcjnzw5PEcrqBeI
 wK6U6j0YDeuJQg5DuhLurTXA1iCMJ4YH3xfMeXuvrXteEB9S7qDyZbvweJmFdfKwwSKIjZipjYi
 lkxQ=
X-Gm-Gg: ASbGncs1IN2f58BOcTMJL79ns8w5Eonl+1ylHt76PSaolfuNwj3gPaHLh2OH2xR0iIt
 3TF5UieibpZ/swf7can5umvC99Ly0pfA1udfLCEurheWjGxGFvlBbGSoXXm0makkMK9SQfsJ8pv
 4WZ5BVz1EMOx9194khQczKmsjH5qMAnByWLHcBay+Ww4qMmS8zUkjr4k7aI5ppB49HVlNeQTegk
 IcjXcgX6GqxLbXJ2RYAryhTKuqw82NtuH+BzlXTQk+6txSTDwIGCMwXT2LVzMl7a90GjbZbtMkt
 TGB+vgdFQplSMYiqWG3yteY=
X-Google-Smtp-Source: AGHT+IE9qRhYFD4wP8fHchdQnEIJDaN+9uCKejnRw3OZFP68otj0cIUW2jDQ8H4sLP8YOMMLABqBeQ==
X-Received: by 2002:a17:90b:37c7:b0:2ee:ab29:1a57 with SMTP id
 98e67ed59e1d1-2fce77a6f28mr2845894a91.2.1740108512244; 
 Thu, 20 Feb 2025 19:28:32 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb06539csm197351a91.28.2025.02.20.19.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 19:28:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: mkorpershoek@baylibre.com, ddrokosov@salutedevices.com, 
 u-boot@lists.denx.de, u-kumar1@ti.com, a-chavda@ti.com
In-Reply-To: <20250211094931.20817-1-a-dutta@ti.com>
References: <20250211094931.20817-1-a-dutta@ti.com>
Subject: Re: [RESEND PATCH 0/3] FIT Image Boot Fixes for am57xx_hs_evm
Message-Id: <174010851086.2983272.10455835190274042773.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 21:28:30 -0600
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

On Tue, 11 Feb 2025 15:19:28 +0530, Anurag Dutta wrote:

> The u-boot is unable to load the FIT image due to incorrect
> boot arguments in case of am57_hs evm as can be seen in [1].
> This series introduces multiple changes pertaining to several
> environment variables and overlays that are responsible for
> successful [2] loading of kernel image.
> 
> Test links:
> [1] https://gist.github.com/anuragdutta731/7bbf0df73dd1e3327765f1807d337445
> [2] https://gist.github.com/anuragdutta731/5244174c9b9556fd89132c8d72ae2d8b
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


