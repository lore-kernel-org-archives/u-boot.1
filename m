Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CE5EB363C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 22:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09CC83F63;
	Mon,  2 Mar 2026 23:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mXlYWkeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4609C83F4D; Mon,  2 Mar 2026 23:10:35 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175D883F59
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 23:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f194e9a98so1981504b6e.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 14:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772489432; x=1773094232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ2WU5tFBVhlmCmHYosGTPnElwIZHtJo3z3en6NQ7f8=;
 b=mXlYWkeutKJLNrSUwOEq8B4XkSt6AdI0L668CnRQ68BcBwnPoM22PKo2imN9NcrnqU
 zTKbyWsTihxCMXfirGCy/I9Y8NmIn6xL6ZbUaf5N2YBEpKlXRQox0CxO97MdhCVCSDyu
 j3wdqhUGhs0owGNoikitmJAYCA13cG9ompxxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772489432; x=1773094232;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQ2WU5tFBVhlmCmHYosGTPnElwIZHtJo3z3en6NQ7f8=;
 b=NXbrlP7Y8nlSDpeYvl1uqnzXsWqqBFnF/cIkDmlzDPCUk1VQN2ypjmC5Dz04eKe0SW
 754PwMVPvh2C433lwYVA2huwCjZ1okg4c4TVTGxXwlzPC5/9XNYinZLOCtWLiNzngjln
 BrX1EeOewwpLlKSMZpynKAujT8xmLh9LLy70mXYph9PFf5L3tvD13kKM4dAyBVFZnLu0
 LynW3vWCfaJVc1ixHg0md/Yuh8XHRvdeIhnPku4q7sgoJUjoDTXVL3CtET3tXK59oobu
 RhDGOtv41KEJHm7I+eZ2We+9z7a+jsRqBhz7V0/XYN7HmaJhbmzouA6YWUV0rhJAG2Bz
 6nxw==
X-Gm-Message-State: AOJu0YwekZosUmZ09RpE8c6YOssjQLWtkPF9HgJXgwQKgWX5qiu7limQ
 Csx5iBgm0dKHkS8GTecVqePQtnrEmYOmDWOJzeDojyVk5JEllUTXOHLXpA1apljMxZ4=
X-Gm-Gg: ATEYQzwJxZCeodxIhAplMCUK/Uvo+QO5jrHto0Qng8oZv6eZ9A9o52ynnhVOZ8CplwK
 LiCvh4mr/xD1fsQn5vGEKXyrIJKHlofUYq/NpcbUFY7FH9fY9loc+Sqqf6VAwqEC+K0sY/JLcPs
 tOokmDPjyuznVY0GIDVnwGsq0bj2pho+QuEE62XOfKdXkKWw1zCd42J8pQ+62QNv+s5dQOcghD7
 e+g7PE/KC4kPi3mIxXv1W501ajRD4aDNq9kA6mqBmEwiZ9Sv9VN5t5yq10h1CvS2cX9vtpEdn3f
 l3Jx0xgLJUxKTxZW+7cq9PlJmeslBsjy7ee44rfU82hqvjrNercY9XFp6KJBmsbCinTpoR5nhnV
 /50Nb9mBrU0D7de9nkO0RXwXB9rLOEoI8upIaGpFArxRrxlN0etgDN8EZug9aQSZLAXlv12l9tx
 e/EPcrqYsZH8HyDM9E6SOPBF4K7ksI+nDdbx5tHUABi2vU924L8fVlIfAcHovFVIMtHAZhio6Zf
 UOZeXkscKnY6XWF/BacwqaZ45hEIFnURgFG9lGI9kN84OFVVw==
X-Received: by 2002:a05:6808:6d83:b0:45e:e4c9:4915 with SMTP id
 5614622812f47-464bebe3f2bmr8029950b6e.35.1772489431805; 
 Mon, 02 Mar 2026 14:10:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb35290fsm8447013b6e.4.2026.03.02.14.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:10:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de, 
 n-francis@ti.com, emanuele.ghidoli@toradex.com, 
 francesco.dolcini@toradex.com, Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250314100734.23777-1-eichest@gmail.com>
References: <20250314100734.23777-1-eichest@gmail.com>
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-Id: <177248943073.3682557.9502261507089275302.b4-ty@konsulko.com>
Date: Mon, 02 Mar 2026 16:10:30 -0600
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

On Fri, 14 Mar 2025 11:06:49 +0100, Stefan Eichenberger wrote:

> The get_ram_size() function fails to restore the original RAM data when
> the data cache is enabled. This issue was observed on an AM625 R5 SPL
> with 512MB of RAM and is a regression that became visible with
> commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> location and Fixup DDR size when ECC is enabled").
> 
> Observed boot failure messages:
>   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>   Authentication passed
>   Starting ATF on ARM64 core...
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] common/memsize.c: Fix get_ram_size() original data restore
      commit: 8d24789abed0822fbe41a2f9d72cf19650159dc6
-- 
Tom


