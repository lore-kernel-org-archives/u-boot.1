Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39B4CD5BD1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8E384928;
	Tue, 26 May 2026 00:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kao6XEwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190A18490D; Tue, 26 May 2026 00:43:24 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0142B848C5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de4be15125so9921247a34.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779749000; x=1780353800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5UEkwCsqWov2XJrNfM6jBroMRw+HKCOACGs90Jhl3Q=;
 b=kao6XEwCmSMYC39Ujqr3mT6y+sCWPfDOdNPP7B94Y9haJR77274iDqGBCKkGEX61LG
 r3owvWCwak16HepiEmjdWQYOs+FneuLnDcsZcGn3R0C21W8pkq7d2KUug4qy8aja9tZG
 GmZfkvtMnsALy+TIf++mWpkOPMvMQc0m3+JIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779749000; x=1780353800;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n5UEkwCsqWov2XJrNfM6jBroMRw+HKCOACGs90Jhl3Q=;
 b=Yy3HzbGuksOTAw7O1cwIEueNIHvGPxbegJz0D2UrJlHbNh8d3coG+w0uPXqm4ooxuH
 FZgb2tUIel7y00Ne0Xw9mEEMKbuQ44xOxCRxj75bTei12AwDEKFd8ErvUvxvjvS88JE+
 NYFEldS0Dnm3vtNp07pHIc/hCOqAe7rt5UGV1bcf4OHgk++BHuVkUhKGamBNSixKIivg
 +N0EKDTuKFTMwvSrsVMwJp1b7quLQXKk0dU3TT0PKaFvQ4NGtL5s+CvEwtHRhtaMjQzL
 AFf4Nazo5f4ceDXlnBBPp705u+unVlGj09EunduPptGldbaRVIsgMUTOd4am9H98E7+0
 zIng==
X-Gm-Message-State: AOJu0Yz87mWKSsQn1NvjAO7dw+cioX+LabBbih4VIX9I5cKn6QWBshit
 ftCyqI2amiHVSXDizxu9FUj/3IFP4I4JNCwZJU0SuawJqPYwxTf0sv0aXbHaoBONdGFnJSJf0pW
 7W0updnA=
X-Gm-Gg: Acq92OGUKSzwp4fGyHSPIeeekmRQRZvzL+X5kw2YxrSidz8W3LxHmwGS5xtibWIISbV
 Ez0ohGy+p2mN6rhR+4L7z0PyhNSxyyG4eNBTIbZDBaseJXykdjngUVXy3qOY5IlLLbiorVxosck
 wqSeOs3yv9ADL4907aJ/C9Nbb44L/40/9y93K4X9mlke9yQtAnbxAaqsoG1rbICg7rdj8Z1LwvU
 mPlf7K4IT2ya0+sJC8ml7GvTwo2Ru5IAJ+YemJE4fqkh+aROVe11VL2akj3rbr6roM2KlN468/b
 EpzhRmyh9X2bSR/2OnePo2ap8xy+8DzkaF0rfAU8qwQsJJOou6V3O23l7cd34L/N1gK5WQUqoiF
 S1jiSph6c4yvX+shYZ7gmruY3E6rswU4R+mPHiw6NiACZuvOU0/KfW+OZ9u4dMdz+DKfK1peLVY
 QnpmAgwQIpnCqrtQFlIHg+DOp9+FlbrBFnC4DWP2gIv90YrylA1ZucToUnzmM54puD9oRRjydbr
 cCoyG9/hlrni77uhfFOaboloRKrweQC5SyyAwlWr6WucCUa6DwX69c=
X-Received: by 2002:a05:6830:719e:b0:7de:4ebe:e44 with SMTP id
 46e09a7af769-7e5fec7fb51mr11420551a34.2.1779749000718; 
 Mon, 25 May 2026 15:43:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606667796sm8076073a34.23.2026.05.25.15.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:43:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Vincent Jardin <vjardin@free.fr>
Cc: Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
In-Reply-To: <20260510212838.543179-1-vjardin@free.fr>
References: <20260510212838.543179-1-vjardin@free.fr>
Subject: Re: [PATCH v1] gpio: uclass: show DT gpio-line-names
Message-Id: <177974899978.3696278.17733396547080506888.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 16:43:19 -0600
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

On Sun, 10 May 2026 23:28:18 +0200, Vincent Jardin wrote:

> gpio status -a does not have labels: the existing path walks
> the per-bank requested label table.
> Issue: The boards that populate the standard gpio-line-names
> property in their device tree end up with anonymous entries,
> which is not logic with the purpose of having those names in the DT.
> 
> No impact with boards that does not set gpio-line-names.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] gpio: uclass: show DT gpio-line-names
      commit: ed5d719bc25b3cc9121992d1ffa845ba8cd6a548
-- 
Tom


