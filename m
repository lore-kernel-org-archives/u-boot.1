Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35836CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C822183EEF;
	Tue, 12 May 2026 21:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K7qxs5du";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56ED1838BB; Tue, 12 May 2026 21:31:49 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21961838BB
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso5328835a34.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614306; x=1779219106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJwr//OCxrAukZd0UokwcyR6dTeuGKWyeF3ELoZMj+k=;
 b=K7qxs5du93rm/LVnhZtUTtOwXt+sgG+r/2t9lqGUO+UMWRzdyJk2XQdF+QLiRJRtSr
 jNolqi371JjGcmmZll/y/gidT/iqjnKE8zd4ILNJJHzBb9niuI7tPjlff6V8TLqYf7q3
 DNaYQQCHx37VXduJUNu4UJ0vEt+3+VMD+KGNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614306; x=1779219106;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XJwr//OCxrAukZd0UokwcyR6dTeuGKWyeF3ELoZMj+k=;
 b=sPEfj2FSKeFxQcvP8qO2Hf823G2DeoNnJEIyZwx1mtTooa9hXYfY6M2Ntmhqu+FryE
 JE4vvaNyEtt9gF84LhFEglhAWRIKRDkASpO7rXX0CS80H/SueKFOHwmAQ0E4NfZ8Qaeu
 965lyeh4P0NRXSXoXTbQfNJTAmGnI8fd6E5tGLnVEU19UGnxHOM7/6+hD4M9yQBW9xBb
 SkarJHGSkHOjEIGXIeDrjcdzZJCAP/tIMAIDtI5knkAj2BIdct4CNW8hbpAV4FJBvMLl
 ZnPGWoytpltBiSrwXGcqQGmnhNW09fdNxDY3NIMs9xyrUuJVD+AWxzfu0+oRz1do7tfY
 lxUg==
X-Gm-Message-State: AOJu0YzZpXi6uUE5HDos81DsaUaWrH/jOoR8q9Wdtx4xEIufiSye7Hmt
 CxIKFfcaxXZyNPrVpIe9k9RtaLwJkYGBkuiRaayrflbZsMaEy2h64d3UJQME3tjchEY=
X-Gm-Gg: Acq92OE77Nr49b32NtChekYj22a9M/wRxINVQ7X5qd6BzvQtrxKALLEr4MNcJQVwAB7
 DDEPWPZM2EDhKC8hht6xfkZInQ7IypFg+IyvtTNisNDpN9GEXG8bjtpVGJa6fnGhJQXQoR19AKP
 uBTGT+low6sWyStH1Fe7JHR9SJz/S6t2mHNRjerh2dtiH/p5VABUHaKqp/CRI2PIm/U+EJTiQXK
 b4X1rDI+Hd5J2/z/A8cQZGJDuA0Q55mDjlk6TAELuszZs4qZ38JBmh8SBUePP+q+GZ0396QYH3F
 PWf5cT6s9KV2JWiZfzHHRmkjX0cv5Q6HaJ8IdEJw9SYwGtG+QSd7kGZh/lVaCCakiqdhKHf22HB
 1Oo+BoM6sbzJ+DNUA4qgRZy8Ddb++ccqlC63R4jhXI1wIRDCI9hvc/4gul5eZvko1k1SaNDyGOu
 8K3uJCfTFUOU6lSChQqkhkPEDy9KQF0EQKGO7zd32rMqxFDgyZW1XNHK9LJVjJOxtEyCIs4RsqI
 8fI0QM0z/G1BI35VHAql0WJWqr+I7mlkA+4cbOZuUDZ2DVz6w==
X-Received: by 2002:a05:6830:6107:b0:7de:9b99:a8ee with SMTP id
 46e09a7af769-7e3bd2cf26dmr2648333a34.9.1778614305827; 
 Tue, 12 May 2026 12:31:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20260430-apple-compat-nvme-v1-1-52c1e6e93aa6@jannau.net>
References: <20260430-apple-compat-nvme-v1-1-52c1e6e93aa6@jannau.net>
Subject: Re: [PATCH] nvme: apple: add "apple,t8103-nvme-ans2" compatible
Message-Id: <177861430509.3279584.4403908225399284830.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:45 -0600
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

On Thu, 30 Apr 2026 23:28:36 +0200, Janne Grunau wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
> "apple,t8103-nvme-ans2" as fallback compatible as this is the SoC the
> driver and bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,t8103-nvme-ans2".
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] nvme: apple: add "apple,t8103-nvme-ans2" compatible
      commit: 29080b2a9968437da4f53e38010c48c038a22991
-- 
Tom


