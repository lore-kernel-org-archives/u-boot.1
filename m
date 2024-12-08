Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171C0E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 06:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735A988DF4;
	Sun,  8 Dec 2024 07:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EIq4skHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77FC188D7E; Sun,  8 Dec 2024 07:51:02 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B0188DF4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 07:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ef7f8d4f30so25652417b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 22:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733640659; x=1734245459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wn0luRwaa7kumINkhnK/iLB7gduDw4AT5vAZfnjO9/s=;
 b=EIq4skHhtuWkyJjRO16IV4fPXGxZRgg39H4dyeNMXJlpcoVI6aI6/Tkt7E1uK2P3Bf
 G4fUlv0T+E22M5j/beurNso5OFsGQbpeB1Hgs441CF6haDd7sDG4E3s3IrYwuL8Q0KrA
 7wRAyTfS6bjb/45nvRO5mFqEysisIbEvhk92sEnEi48Ns5f/U2CFM13ZXhR2eBy9/R06
 OrpNTc6IjNeTlAo48KPEIlz4ukEmTwurmR0sPR+4ccVXEdaENZEa/GqS1inQ/m/3Y/XU
 fepRhFyg5UI6yxpNxr06fRSxlONLoPuOl32adxgncpiAA6AXKM1cqvHosayjMrKub4uD
 kbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733640659; x=1734245459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wn0luRwaa7kumINkhnK/iLB7gduDw4AT5vAZfnjO9/s=;
 b=Nq0YZF4Kpth/7NxK8Zfe3xkMsRFRIx+Wb2V2UvnkavJuLx/nzqIICTRjKetwVD3eNi
 AhPOnzw+plRUIgxyov9AezY1jqPOdk/L4Ry7ZrZX+t3N3JsZ5pQkYnlIIXGkFRh8ENJo
 7eXsSwA52nENgq7WSNqDfq6T374+GOIGONUdZafjuC9Z6uZ3rEId/aiOutznbV8eiMHJ
 iETEnepgyUM2pWAQZq/zVi6i2RN33RR3uZi5TrMZ4RNN7PFI/3F+s/YvE5hspbSIub7M
 028rL7Yoxcp17+mW5suliEBH6QobTAppzBkA0QjsYZJFzw8btvqoBHioE0KS+8NmbxDA
 9VDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFtLUBS3gcaRxDHnEx0t/kHzbWBVahUAgt5Hz1I9O9EhOIpfbWnxPWE05nuL1sUV19tZITjbA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywp+HpMER2dH+ZZgtDe4UTfqVTS5KFSj2sky8K+XyKO6RKoeRaP
 OdT2TeCbMC8fodqAtBG2Pz84/xKDqqpGJMVw8+L7KO57pMfQDcMnUfHmXJ9g3aBtupfnHsfaVdu
 Oh2cBQk14gspxBCCjw1lJ/rAsI+nHKTl1zbag9w==
X-Gm-Gg: ASbGnctLVOFvOAvHbEtzPPyqqLqIJgPqPgjUIpvDdhzaCuAZxj3I0XkHH8lp9PSj1s9
 aepTskF6iQk7yaUFj+mrPgEmRh597uD0=
X-Google-Smtp-Source: AGHT+IGPwLuQpe/xBnAD5bztsNlnJPM8zDX3yaLRcNXDIjLEvma/Mp96u7cKxnvrfq1uwVUrOoGp0MKkBv6bPoV/LPg=
X-Received: by 2002:a05:690c:4588:b0:6ef:69b2:eac with SMTP id
 00721157ae682-6efe3bf54c1mr71115837b3.4.1733640659151; Sat, 07 Dec 2024
 22:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-2-semen.protsenko@linaro.org>
In-Reply-To: <20241208002121.31887-2-semen.protsenko@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 8 Dec 2024 08:50:23 +0200
Message-ID: <CAC_iWjJjm-vYnvn3_nW5Jeaae_Ep_fAi9QsjGVC4hRb2QKMCLQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] lmb: Fix flags data type in lmb_add_region_flags()
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> rgnflags variable in lmb_add_region_flags() has incorrect type: it's
> declared as phys_size_t when it should be enum lmb_flags. That
> copy-paste mistake was firstly introduced in commit 59c0ea5df33f ("lmb:
> Add support of flags for no-map properties"), and then copied further
> into commit ed17a33fed29 ("lmb: make LMB memory map persistent and
> global"). Fix it by using the correct type to match struct lmb_region
> field.
>
> No functional change.
>
> Fixes: ed17a33fed29 ("lmb: make LMB memory map persistent and global")
> Fixes: 59c0ea5df33f ("lmb: Add support of flags for no-map properties")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  lib/lmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index b03237bc06cb..713f072f75ee 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -200,7 +200,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
>         for (i = 0; i < lmb_rgn_lst->count; i++) {
>                 phys_addr_t rgnbase = rgn[i].base;
>                 phys_size_t rgnsize = rgn[i].size;
> -               phys_size_t rgnflags = rgn[i].flags;
> +               enum lmb_flags rgnflags = rgn[i].flags;
>
>                 ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
>                 if (ret > 0) {
> --
> 2.39.5
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
