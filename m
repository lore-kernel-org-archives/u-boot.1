Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62ABC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 14:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055D98329B;
	Fri, 23 May 2025 16:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mRs3rIxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1600832C0; Fri, 23 May 2025 16:01:51 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C572D83285
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6064d4c14ebso2661227eaf.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748008908; x=1748613708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iavZRw6nQ3R+EfAx2leQ2IzD5kk048ugmCfjz1oQG/o=;
 b=mRs3rIxN3J+XL3vmjvUUjTJuDOYffyLBgBCpqKLyd9Vko+Oow1aA++ZVanQ7x5s8qM
 Tc5p9oekfUCTOt/3kL3vhlfNRhFkzo5aTMMfPBjAFxUukI82wrB0KLqyrUXzbaa15vEr
 QK3UUXuSXMD/2LnK1HKTBqmtCrvKfzuUIxYS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748008908; x=1748613708;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iavZRw6nQ3R+EfAx2leQ2IzD5kk048ugmCfjz1oQG/o=;
 b=wCbpWSuMnpYahvDMNF+bkbbaG9hCcVDZAPE0o9DdHgP+IVhKR2RYqeo49lQ7NxLQGk
 1kd2BXkeGh7sXcyeicKqgvxuEfgOACDi5096Mb/H+2rk55MnoOW0Ee9WelwRCqHMgn1e
 FDoDFbb10x0qaOplO99oG/Bpuv50OoAFT2apsEiJeY9Dus9mfoFQgS/Nkp4pQtGdd/gX
 NBqMLCoWHaBoPhmTJQYLxMZYlJkM/gABnN+krnXrJgLksP8BxA/NiNm5y745BlIus7l5
 +6LI4ncbabJhSV3IJx+ObohKrdV/ZQEyF3QUuYkuwigfZU1uULyWhkBn2RlUrejpm0Gl
 kRwg==
X-Gm-Message-State: AOJu0YwOdWkzEwFNa6wAmCL/cNAyNXMTRT1VcVvrdumvBLEFaTOkCzuT
 CKtS+/JHsS05OWYmuiSfUPhIuqCImu7JwF+dbaAqQzrdJMzUY+w60F0ToWvXkuhhcco=
X-Gm-Gg: ASbGnct6B5DyOrR5UilXuCw3HCqHfwMKinuxbq0UN6gsvq1yLh+6dmSxkcoNZw71mtz
 KKXhM0gWiWrDoK2cm+kXZkekDIxX5d29V8rO5V4Snbzu2u/sOIkfygjq39bebra8KWt+6aWRIVD
 gV6ZAaQnhGFKNiAXVn7TC0VeRUfVy1T9AZKy7h4j6ovDl8qZsImg/3cQjJNAKHWVHpd/3eS6lsx
 stCfLhBwe28yGVEtciJxJv0pGk0zS1u6RoFmjzdSiyv/ZKiFvO0YGem3wZKcAgOCLbXHvMbZM+E
 muArD+c3bpO2J6RqdMtZef+P8rnTG8eQwHWgYx5dKfTDpaYnb66hrG4aKiLeO+d/PjTusOLRklN
 QJV4EQr9vY9I=
X-Google-Smtp-Source: AGHT+IFyOPwoUmGu4t0kVkW0lxF51iSnL1j9KfmkgFRqeQ8vdRsHj1M1XoLmzQJNSbynpnWT1UQlUw==
X-Received: by 2002:a05:6820:998:b0:60a:6b3:3b4a with SMTP id
 006d021491bc7-60a06b33c1fmr14554704eaf.3.1748008907704; 
 Fri, 23 May 2025 07:01:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f303156esm3167610eaf.38.2025.05.23.07.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:01:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250506071501.28253-1-weijie.gao@mediatek.com>
References: <20250506071501.28253-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] env: mtd: fix usability with NAND flashes
Message-Id: <174800890630.2288012.14924840386444989878.b4-ty@konsulko.com>
Date: Fri, 23 May 2025 08:01:46 -0600
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

On Tue, 06 May 2025 15:15:01 +0800, Weijie Gao wrote:

> 1. As this is for MTD-based devices, the Kconfig dependency should be MTD
>    instead of only spi-nor flashes
> 2. Initialize saved_buf to avoid crash on free()
> 3. Remaining size shoule be set correctly to write_size
> 
> 

Applied to u-boot/master, thanks!

[1/1] env: mtd: fix usability with NAND flashes
      commit: 7c52bca8121fdd967edf24402590b8aacf4fd23a
-- 
Tom


