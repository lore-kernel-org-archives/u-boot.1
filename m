Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC40CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 11:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5261D810DE;
	Thu,  8 Oct 2026 11:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dPUx78YxsUj9; Thu,  8 Oct 2026 11:00:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 623A3811E1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791457259;
	b=UdmSpRNcNxUtrOaktFoD+Do4GQMBLujJ+X7J0SL34pi2xGIelI6DLy83GAKkbXscpucF
	 t9lBZ9inoCQfjpPl9qji+6ic/d8zkxsh1pJYzbkkGZNttXLt9Z92KoDnQAN8sFevTrSXL
	 MUDGQcZltTrDZPhYCGPQrrKUSi6HaK+p48cJWtbpTFdWV9Tx2zf3+tCP7kkdwOMSHxSMY
	 P2qTLvcbmq4Y0a5vc1K+Xxh9XF6KKDHzQ1xsMR0w9wAxr0YysajiTKn+roBTuEUMOTlf1
	 KXBjHtfprOSdAb++rBbSs/4fmT+vpY5qOe9kBMOwB84dl71IRfNva+vbsMRnFTtlbnw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791457259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SY4wrxeBcvRJrc+JYWx4VHywU7231WSPT5vXUBPYkFY=;
	b=EikCZt7n8gA6GbL2mKh8rmC5HhK4mE1Y4BWw9g9VENt42x02hXIGSToeyCYvLIUohALh
	 OlXkXuI/UKbWqbT5cmYZEJOgBgw/Flk6xhrJeu9s8o9tzJ4Q1zb24nOC/6UpncrvBYwPF
	 9GR2tVWuxQTvuvrbIX4ALSMC6RkoZc6orKSLtJYgXkZNJ/JtXhKU7+V81GnpMC88oKIrY
	 1xSHh7erN4kIexFBgeqVRq0BnrOf0mNJCsSevdVhNia14CX74DUKguYOrlUT08EbXz5ky
	 xOfqGExR/F2VzCn4WH8UKYkORPFXM/khZrWaiPjgBbbd5a1bfTT21VQLDFElH2xJrWw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791457259;
	bh=SY4wrxeBcvRJrc+JYWx4VHywU7231WSPT5vXUBPYkFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fwG6UELhUmh8PaWLTOaQiEhBcBc/u3f3CeJbpAmjEV82Asx2XWHhJyoyfLnuUpwI7
	 RAOMpCRbZ5O0+LcxngDSSZnRJBXPLIDK7/XEDxpmBMms5+y0Oyx1egroGKr15Oc7cs
	 SROmQuupqvknUB7rxRC8eiCWDwguOrOcgvgSMIANZPGsfXG+PqFFBZ0qNnC1AAa5zY
	 9bvEmrjxckU840IVdE9c9Jzg6Q273KJnYQ0LlfNBSpQDcyMd0dNqTEEtYIM7w16btV
	 YbgpDXUj8UdrP/yCKfmSVdr6gWTQE3naf6bgO7yeKVdHf7eK6rVtdgISfPs2q/zEqv
	 ShyknMmmvP6qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 623A3811E1;
	Thu,  8 Oct 2026 11:00:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D21F51D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3F6240A61
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJMW3trhwYbk for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 11:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8257D408EA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1135"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791457257;
 b=Rqq3cozUflut0M4neXzoZWTTf3NjubGYT14M4DV+BKrDZCbGw1X3C6xhgDrzBP3yslX0
 Hly12XncukSabbjvresqFIG8RqOQo3i9pShS9fvQ45dv8fkJUs1YciwTulGm75DaAHDfv
 jqGxofIZB2YQQGScTC5GkPhH8u3e4uu/oGYkwiUJOJUo0Sv4IVfuMZbKnjfFKy/AiwqB0
 7+iNVekFDmghZynPcdvAzl3s/ITvO96bXGiTwzWGofqTHQanBy3vkotgbLI99z7YMsAPq
 tMjSBSc1UtCDTB23P6PAB6iwe+gdqsHGf41c5ZTejhqhd/pxL9/gf4k28/wR5l8kVEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791457257;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=SY4wrxeBcvRJrc+JYWx4VHywU7231WSPT5vXUBPYkFY=;
 b=UU2h4YeAT47VPzrqg18kcss439c5792GFXLWMN4MxOogMsCdWFAESJ5+beBqfJ1X9poX
 od08DzNIDu6sq530BG1hh7IMEpb9VN+/xcSSijC6mpy6GrX3mO1ZfQtNjixN9Plo0MyAb
 8E+iuE2/2l4bJdmYIOyZsoap8ZEOVG3Pj0JQVBwRU1nb+sA5+uYm/9Ck4u47AlBphBZH+
 v3EIC7hyIi6o3vea3SRWMHGE5P7WqpFR9ErKTjryB1S4TYAr8xOjpN7nskvJ+jSFROWEU
 ufzooKayk/sERLhEKLUDp1SuclNjiGiH8NNTwAXRAEg26kAb1j/OHID/rYpTo0SFSaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xXE0w0t8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xXE0w0t8
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8257D408EA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:00:55 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8aca54b75d4so4192667b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 04:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791457254; cv=none;
 d=google.com; s=arc-20260327;
 b=VAx9nsJKfz3e5tdHR4H/FzGMbnEC+MaUe3CRtM/Aa5P0ro94SpjAAkbtWzLdkY/+l+
 N2S/1dTmgfvuH1jTnR/R+QeeiQdNuX2gqiNiOKab51A6ClGrucfqExzARBHD/ViqJbx9
 lrfwAiAhEKHncExwGZCc0G+t2jTymEaIKRcpj371hDRES5hOTSdx6tYn+aR02IU5V5Le
 VPluUnRtra9mJ3mHOpjv4oGRoPb9o2uDQYNpQzLP/gn34F8YEXm4oEKIVO0ECuj8NFW5
 QaOEwxfA/wQ7vatTtbqxSel85jnMxUDoP+ncWQROPcfOm+tRZjv3J7l7he76Zu+yqqbj
 I6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SY4wrxeBcvRJrc+JYWx4VHywU7231WSPT5vXUBPYkFY=;
 fh=Nl3bbvOgZV73eF8AUoQ3XjVZAuus1Gp61f1rpZS8/eI=;
 b=ILfravHeh54Km3sYUzeLMYExyIrZXiNdES9rg3BT8zO/diVHYsrBqzUGebJQ3QPKk9
 CXTqGfQInfy5/tpp05UQ+DMWBu2czf+WpuzklIexv3dnLldz1JjzOqsMus2IrcNizY8i
 lQx7GuJoNxEg7sFmM4tmdVws3l+awky4Sp8YwcKXmZN5nje3IwTBr9tzMcU8ehNr3rik
 U4AXmJcbegr1K6IDNlLelfSLTZ2nmXTay92allPZX15Kqv6sJOUbB/0hF5B54itXxaPc
 jQ1GjXjdaELXo4THpNcmS3gIjw4uEbm8pYX7xocPoZstzcEimGRW0bcNeRYd8YY/JBeM
 IBVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791457254; x=1792062054;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SY4wrxeBcvRJrc+JYWx4VHywU7231WSPT5vXUBPYkFY=;
 b=xXE0w0t85psdYIMtT70DhEpeP6pF/YI2SyzKokjpb1FHjqVLqe6DimSH1taDXEvYVw
 ExhoKRxV3aelmbf2AGEaeImBnapfQgWCyfy0OL2Glha6CION6xZMByFlcbxjPYj1EAVv
 w3tHKCtQf4eOiXjkA8TAIAGkaqjh37aIIu9TT8YkIVzZXvGL5rYpDj0DFXvmRJdCdA7m
 6dth1bqmGI8FSYeZqjPxHwNK2QRrBTXAJRHfUewVyyHF+ow9C5V8fqxcUfwsh6U6jKsr
 JcSb2GEJmVBjyUnEYnC7jnhxFTG1wyVqOeCC1QpQL7nOqKEN4EEhkhH8kJcDKdmz8kJM
 Zp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791457254; x=1792062054;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SY4wrxeBcvRJrc+JYWx4VHywU7231WSPT5vXUBPYkFY=;
 b=oWqCbVHeJZZKyy/vmR474KtPZNd2r2j61D2Qeb1OnBVo7fzHHAnBgLcn8K2ZOhWaGe
 59UDzBDVklZd1a4BvMW4fBEyIrIsFsLCAolH1DhOgskYn+azmDK3ePs/9McyfZ4DQw0R
 +7aeLJtDDQ8Na826/2iJZOFnCALTdkcscw2eOIdQ80K57+kY/ue34nWsnXU30bALbajk
 DkU7ziQokk0KNitqZRiVwpb+S9yfVsfX6XWOpqaY1iUtKNcUGPQnZIY+28Zn1ffTRRPd
 8sc99y1IhtMrlYOIp41z/dGhX5orq97qCxVqnOwi/ZRFXb7S7+WUIUeQ1JdAdFFfMe7f
 MMHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGb4c60GyAJnrSZALZu9dFYU2uo+d2LV3crCLhmO/7RsORzrFyYOxGRBW8PJTVwyVcjbbbbn0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLS7jQoBXau6hMlmtyXtKWyF+uIeF+DQ8ucsH9GNpEzRYLoi/tU
 ZpU+hN24BvXN+QVJALPwHQE2jYNTCfvHUh/9u03EDBFrME/w3ZqRjgaNFlxpgWzbcNujIKiDmWO
 2sHK7A0udng6nZpJQabJQow6RvbJc8ylQUtFjBkpgUA==
X-Gm-Gg: AYBFou1XOZBk8aGytzZSZTibKLBUKORfPeOFSkw9rgT2+z7dvIYDWtBk/3zd256Wjxn
 F25eZaAJcFx6J/E4BkQbs9cZCmaRNq66j9F2YlHhWtAlO+fhtotnY+vlrsL1IBpyqBPc7T+aMVG
 KJOZZb3MGdxrcH1jz5QMIswWVCjE54DPK3CqcuxeNQbsUmUnCq3utPxLyhps3eLfCXFUCEXUcVf
 pwu/0oYdZbRFTAGGDLQIfUgQF7ZNGmSTZNe9ivJMIOBM6Nx+yAG86pTN7RkKE7QVnqMSO3V4rYf
 KN7vQTJsaALyLpJn2Tlm/CYfX96WsA4iOyR1925uc1KfnB1gfBYt+oO55LwdiBRLHZSYOsf34TU
 fqrJFLqHgoxIIFi1sAZvVKAyqo/MyuEWF/vBegiqw+F/YwAzPpLgcxgTDSSnSBxWQYYt3gwT4oM
 Z7OqbQZR5cZQwJ07c//pXt8KEmryvyGwLAzAvzh/BvlwmRbbkhQ+j/ICQaqQ16o4lm9r0zSojWr
 qJ94YQ0GOG88Jo2oNXqZuPnShDbTMBQYcenLXxcKgtjSr0w2CuCoXVpE/Ebyd9Ii6cZwcIPwLeO
 YGw/C35LUUHtboy2qpgpWPKONMV/qwT1IbP0N3zpQLiGqsopyloNtDEUWvhULoIYkfyJn9c+uPP
 bltOzyTdamCB89h6ICD/YHcmuibyKqmVQD8qrR+bUyBmbCXJfDZEwdA==
X-Received: by 2002:a05:690c:c50d:b0:8ac:c329:682d with SMTP id
 00721157ae682-8b06e425246mr10253337b3.11.1791457253509; Thu, 08 Oct 2026
 04:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260926092635.2712021-1-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260926092635.2712021-1-aswin.murugan@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Oct 2026 14:00:17 +0300
X-Gm-Features: AclHuK8T3YGTyHUhzRev3yHyVazZ2Zf9306HQeiErM0d_ick008VUETddPruaes
Message-ID: <CAC_iWjLP6PTPO-MpAsQGMVrZKRy6o==0D8iq9vp+36bmiU9hTg@mail.gmail.com>
Subject: Re: [PATCH v1] armv8: mmu: sync emergency page table attribute updates
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Ashwin,


On Sat, 26 Sept 2026 at 12:26, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> mmu_change_region_attr_nobreak() updates only the primary page
> table, leaving the emergency page table with stale attributes.
> The emergency table is used temporarily while the primary page
> table is being updated.
>
> As a result, speculative accesses can reach regions that were
> intended to be blocked in the primary table, leading to XPU
> violations.
>
> Update both primary and emergency page tables when modifying
> region attributes to keep mappings consistent regardless of the
> active translation table.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index ad232435eb2..f351f11007d 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -173,7 +173,7 @@ static int level2shift(int level)
>         return (12 + 9 * (3 - level));
>  }
>
> -static u64 *find_pte(u64 addr, int level)
> +static u64 *find_pte_tbl(u64 *root, u64 addr, int level)
>  {
>         int start_level = 0;
>         u64 *pte;
> @@ -191,7 +191,7 @@ static u64 *find_pte(u64 addr, int level)
>                 return NULL;
>
>         /* Walk through all page table levels to find our PTE */
> -       pte = (u64*)gd->arch.tlb_addr;
> +       pte = root;
>         for (i = start_level; i < 4; i++) {
>                 idx = (addr >> level2shift(i)) & 0x1FF;
>                 pte += idx;
> @@ -211,6 +211,11 @@ static u64 *find_pte(u64 addr, int level)
>         return NULL;
>  }
>
> +static u64 *find_pte(u64 addr, int level)
> +{
> +       return find_pte_tbl((u64 *)gd->arch.tlb_addr, addr, level);
> +}
> +
>  #ifdef CONFIG_CMO_BY_VA_ONLY
>  static void __cmo_on_leaves(void (*cmo_fn)(unsigned long, unsigned long),
>                             u64 pte, int level, u64 base)
> @@ -998,11 +1003,11 @@ static bool is_aligned(u64 addr, u64 size, u64 align)
>  }
>
>  /* Use flag to indicate if attrs has more than d-cache attributes */
> -static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
> +static u64 set_one_region_tbl(u64 *root, u64 start, u64 size, u64 attrs, bool flag, int level)
>  {
>         int levelshift = level2shift(level);
>         u64 levelsize = 1ULL << levelshift;
> -       u64 *pte = find_pte(start, level);
> +       u64 *pte = find_pte_tbl(root, start, level);
>
>         /* Can we can just modify the current level block/page? */
>         if (is_aligned(start, size, levelsize)) {
> @@ -1039,7 +1044,7 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         return 0;
>  }
>
> -static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> +static void set_regions_tbl(u64 *root, u64 start, u64 size, u64 attrs, bool flag)
>  {
>         int level;
>         u64 r;
> @@ -1050,7 +1055,7 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
>          */
>         while (size > 0) {
>                 for (level = 1; level < 4; level++) {
> -                       r = set_one_region(start, size, attrs, flag, level);
> +                       r = set_one_region_tbl(root, start, size, attrs, flag, level);
>                         if (r) {
>                                 /* PTE successfully replaced */
>                                 size -= r;
> @@ -1061,6 +1066,11 @@ static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
>         }
>  }
>
> +static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> +{
> +       set_regions_tbl((u64 *)gd->arch.tlb_addr, start, size, attrs, flag);
> +}
> +
>  void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>                                      enum dcache_option option)
>  {
> @@ -1095,6 +1105,13 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
>  void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs)
>  {
>         set_regions(addr, size, attrs, true);
> +
> +       /* Apply the same change to the emergency table, keeping it in sync
> +        * with the primary table.
> +        */
> +       if (gd->arch.tlb_emerg)
> +               set_regions_tbl((u64 *)gd->arch.tlb_emerg, addr, size, attrs, true);

So the problem I see here is that emergency page table is a snapshot
of the original mem_map, that we only used to update in
mmu_map_region(). We now update it on every change and I think this is
the right approach. But are we sure get_page_table_size() will be
enough? The 4 used to reserve to accommodate dcache settings is a
random pick. What I fear is that some architectures, for example the
ones that enable PGPROT and create even more tables, will require more
space now. I think we should also increase the get_page_table_size
size calculation.

Thanks
/Ilias

> +
>         flush_dcache_range(gd->arch.tlb_addr,
>                            gd->arch.tlb_addr + gd->arch.tlb_size);
>         __asm_invalidate_tlb_all();
> --
> 2.34.1
>
