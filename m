Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B484CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 21:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A9282998;
	Thu, 21 Aug 2025 23:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cb+H6DIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E28D81D5D; Thu, 21 Aug 2025 23:00:34 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADFB82AC4
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 23:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-74382015df5so338949a34.3
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755810030; x=1756414830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOLVw6C2w05OsWjIcGSEgdJfoAIu6rcMEpXYfYI9bFI=;
 b=Cb+H6DIjmXIIz2GnNYOhRbPcWB4VDVXStc/e0cRFvJ9TziPbyxnYIc+CWvGIQ56Eag
 ZvD+Hx3T5zw3gWyE/ntnekQjbPf9tcJ5avJPHxdYIJm78VPPkBlX8/a6Wv4P34Ow/ABd
 21/3mCNYGrEOfiVmdrC0hnnf7SoYJFGkop9XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755810030; x=1756414830;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOLVw6C2w05OsWjIcGSEgdJfoAIu6rcMEpXYfYI9bFI=;
 b=O+m0m+fjhW9I3B5W9b5ISsfXevIRK0Qb0XeOhJX9l+2fD1MH7n4Qvj9Z9vWzVITEh9
 puFqYO1G5NDY8Cy+xXhAgYMTZ0pTBy6ukT9ZkjAdct11QhFAYXNdfRHfyuImXOX7q756
 n6F5pLz9r99p0IMkIMoD9t/E6Fx4n2zVXyXAvnD967Ee8KbdIlMYtuxbuJ4NF9Vx7rhV
 bWWDX8uYiBwQL8pHcidpx36kcgbK3u60j8j5+3zBBhla335zxtDEbAesolcfmKRcrxxo
 BRkWolLaoqI6NqSAtLYdGN6/Z2NOCfg8hL7xOWDjGk9ZUjHnooq/ViBZ5jPd1DIRTejP
 ge0g==
X-Gm-Message-State: AOJu0YwjcHa904EiVymV5aLYzUEtz0V+f7t74Wljpa7zNQp8H4/S04I1
 MCrlczHgZsbIZuQFtnntzFM6mg71InRJxpgH0MX4mwBTDmJsF+wfUvuzPM5Mlfz0DzV0tcNGvIx
 ocNgMi9E=
X-Gm-Gg: ASbGncvIkAQvoEgEXhF9GtXLirkf0ZGu+cqk4vxLT7IUFnZ9wRAy96JiNKRtZbOcJ10
 dL1i3hi0YQLcCggnGGSc/oxmLzrCIbWyxY3mufCbS5B9r9ahN2HS3nhr1cHFgyqeMQH0CEahD+z
 MYjalLor5snAp4jNUxCo4+IQymvKdHWdu/DbcfGz9H1Egqg6dr74ie2NFmyWZ1nqaU4v8hZexAL
 M27ywY7iCn0tLKnt3cZCEENi8htBFrziTvtnAuuHsJu3oVTnUnKCG3Eja2CZLmq/4JwjZ15pQf4
 pOMAZ2AuAsE4jxVMjWhoqgO154iyOcoMDLUp7UQiNc4VGIp0TCFHe7R1QD++YBMR6WyDP2tC5Jx
 KtCWRiJHuzhfVNq9ex7+MVv2ak2YcpeRQYZe9zp117ozEdU9ocamqd0s=
X-Google-Smtp-Source: AGHT+IGVOpO6zcI7vbmsMchLnG5vGUM1DMtVGwGI+aOqbbR0q+S8z9/4ZNiF+mr4kQzAsW4mitsxXQ==
X-Received: by 2002:a05:6830:4890:b0:741:c0a9:9494 with SMTP id
 46e09a7af769-74500a5b6bemr507433a34.17.1755810030044; 
 Thu, 21 Aug 2025 14:00:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-744e06a845esm1631957a34.20.2025.08.21.14.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 14:00:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, praneeth@ti.com
In-Reply-To: <20250814152145.2853307-1-anshuld@ti.com>
References: <20250814152145.2853307-1-anshuld@ti.com>
Subject: Re: [PATCH v1] remoteproc: k3: update compatible for am654 syscon
Message-Id: <175581002909.928164.4782059063073591013.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 15:00:29 -0600
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

On Thu, 14 Aug 2025 20:51:43 +0530, Anshul Dalal wrote:

> The existing compatible name for U-Boot's k3 system controller driver
> i.e "ti,am625-system-controller" has been added to linux[1] device-tree.
> This compatible in kernel is meant for configuring the Control Module
> registers (CTRL_MMR0).
> 
> However in U-Boot, the matching driver was being used to load the system
> firmware on the secure M-cores by the R5 SPL and therefore must be
> updated to a different compatible to avoid conflicts.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] remoteproc: k3: update compatible for am654 syscon
      commit: 2792cbf5d281b519692c546849638b2141046a4e
-- 
Tom


