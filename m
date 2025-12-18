Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E215D711A1
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B41F98309A;
	Thu, 18 Dec 2025 20:52:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="upt9n1fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5291280433; Thu, 18 Dec 2025 20:52:00 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9583833C6
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3f0c93ecf42so1355773fac.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766087516; x=1766692316; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWyctP+AXcGnFrikNUpv32Bqwtjk/agnR3DpYENS5Lk=;
 b=upt9n1fye2LYeIjw/YAJNlCIJx4bawTsSKq1pOIrMxTAwyNt2w3TqozxAfuIH5hUoD
 KXLUEs73xRboCqaE23t7+3gKqrQk198O2nxJ2x6y3OsrzLDO68FlQRauMcilU4mjTM0J
 D8m56/WGVmVA/lowHQbs1QPIpGOAxMkZ3BmTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766087516; x=1766692316;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PWyctP+AXcGnFrikNUpv32Bqwtjk/agnR3DpYENS5Lk=;
 b=uSt8Ds+Qj11+9EkajVtfnUSht5AgZTx/+o0SPv6XOHPZ16HVjrnQ+5zbkcNtK8yRE2
 0ILWwub5sQueOX+sIB+DV4w1n5Gcbrg0z8hRkwVosKoo494v0gjPip+Yu5MW8lFsrztt
 cE0Ekj2KqGhq8Wdd8R+IIJxmSluQWWv8l5wGGxOYuQXUg5w+5eD/LsNyPeC+W/t++Fhi
 dKcrhXhVxQmLrPgWnNVR46Xk6k80owxclHKestQEjfmX7DItYPlENO/eljNtDuLretBN
 Uxv9SrXZpFDBlEnVLrxw1WICPMyzKi6XxrdfCvNRQq1IjPPFDu0kyHPG5trCCO1PTlw8
 iuXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy0ZQuU/TnPu0pnkJjBPYaIrZ3LDwQ6zWkeNKf7Y6UpAHMHAmrHV64PzTWxxxIMuXpHUdE6OI=@lists.denx.de
X-Gm-Message-State: AOJu0YxhsHCdHWulAUCxpDZ6kN/OfpnzsFES2r8VjE3Yi9dpTmuiyoM/
 NQJPvAKlPRCr1z7ZVECeKzrbtXLEpgFwNqPXVyK01lq4muydT9FtHYMs0XrvdDQKM17cOdRZf4r
 0JT1aEbI=
X-Gm-Gg: AY/fxX6Lkce+q/LBRzlexFLNE8dvoUzlbcB9C7Qpir5wcB3NfW7QY898oZ7X0MAVicl
 fXZIEenVozhDaJrtRyhqFCxhOwflR8myGdOSCz/12KVCoeG6gAqH7Weez8fRe+gJcJ7wPRw+3bJ
 oLrJs48eCzyDAKg6pt2ZuLnFWgf+3B5/u05Vwa6NEJbmeBFlvLK+ykcy37VnWKVTZhDX/U2YBiq
 yqYEw5LEQGCnFCHUL1s17Ktb0vbuCfMOzP/APYLxpPbF7SN+1flbEAkvZISC3/0g9tR+Dt0OLgK
 6q4VcIyqXBLYe5qgKMdoP0NAXAHxrm/D5doidkF3DAtirFQJZATV3VAFq4Y/lvGMnXMZS1+3egu
 qWsFLTd/9yoVTm+FZVMMvzU8NLB8CcBI8IWdVpRRlhIK+PTjRsEaGne65rKOVCSmYM/hZQP1nX+
 9Xs6Qp/Z4YN79NoBH527OqlgP7zjKlgRLpHzgPc8ePWT2sl9g2
X-Google-Smtp-Source: AGHT+IHIHjpWK1gbqbNZGYsL0SkGAZH0ZEOhMVcoXPizZqXfAq9GPLv2t21t6LI96yWbvFgH+wcZHQ==
X-Received: by 2002:a05:6820:f028:b0:659:9a49:8ee6 with SMTP id
 006d021491bc7-65d0e3856femr386562eaf.26.1766087516628; 
 Thu, 18 Dec 2025 11:51:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f710763sm181837eaf.16.2025.12.18.11.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:51:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Sjoerd Simons <sjoerd@collabora.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de, 
 Anshul Dalal <anshuld@ti.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251218-dfu_doc_fix-v1-1-d7a9eb033b92@ti.com>
References: <20251218-dfu_doc_fix-v1-1-d7a9eb033b92@ti.com>
Subject: Re: [PATCH master] doc: board: ti: fix alt name for tispl.bin in
 DFU mode
Message-Id: <176608751572.3734627.12666395825002530677.b4-ty@konsulko.com>
Date: Thu, 18 Dec 2025 13:51:55 -0600
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

On Thu, 18 Dec 2025 10:31:55 +0530, Anshul Dalal wrote:

> The alt name for tispl binary is "tispl.bin" and not "tispl", this patch
> fixes the documentation to the correct alt name.
> 
> Fixes: def64b493748 ("doc: board: Add document for DFU boot on am62x SoCs")
> Fixes: 3633fdbb6b90 ("ti: add support for AM6254atl SiP")
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] doc: board: ti: fix alt name for tispl.bin in DFU mode
      commit: d865f2f0162b1121f271bd3e6c1e3f171036aec9
-- 
Tom


