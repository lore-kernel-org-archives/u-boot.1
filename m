Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35239606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sYOH0GlH;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JsPwj3IY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 070F6405A6;
	Wed, 28 Oct 2026 07:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZpBBoOR7QnD; Wed, 28 Oct 2026 07:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C4FE4050E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793172932;
	b=iIyNJP4x08uxyMJ63XUYGQk5P8JX086XZZRjoTG6x3ELxLmA2kMYGDx2vXYv+AMjR9I4
	 J0ZrFVBhuaEMdc4i9H7f4xrnuZhiX5EUzq2m/mOmk/MgU2QMIv83wh8YoOYLJa1XY8oTl
	 miFGSTn/gtnbXEUC/eOoKz8vWGpQWZd8nfiwnQkXhR9LNxLKqiZd+o8jZ+veRe54Nq0Rb
	 qP8BQjKMVuphYcf0kTDew/vHP84rkqkBOXlHNTywGgkoVovUTheMZVjT37OVSB2bxTIMa
	 WMXNzQeE8FbycN2pCTjVuHCxR+4LqlmBolY7SFSo+BvcFE6DJR1K1Mmz/P1Gr0KqA2w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793172932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6EPCQhS50BwkH2ZYFlVIlulQ2kl1WFl+4uAAt1Wy9Vg=;
	b=SIMguVddjnNPz1ldpmOzpDSNbQ8ZAZohGwnuLwhyooDyuwAYZlFh6nTPNAud0lGqlRXp
	 5hS9GVpIlqpcPa9KDlESnAb/aRBkydDx785hp4YgBuD03kblLuGDNYh9wvw2WtQO9/+DJ
	 Vk9wfJDDM0gC2KOkQoxZ7IW0w3dDIxPOxhZViN0YqiM2AVk73H/LuZLTxRQU54airb7AY
	 Vre58l7QIWSoj/5zn+TjSvmc9ynP5mogUo6uhZCQo0seqsYaETMtvq+YsIcnm2S1LRoNJ
	 7FDPeQbjI1XraHY7iuhHVkuCMcxCNF61VlDp4c6LZRPt74SdVwHNtfQSeEcRrBc8SRw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793172932;
	bh=6EPCQhS50BwkH2ZYFlVIlulQ2kl1WFl+4uAAt1Wy9Vg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sYOH0GlHspYCHbMLxoqpOSI/D/bphm7T+Si1lOKtCPNb5RxahmBhgPcJUoQa0dhiu
	 bWx0YBhytQ94GN9eFwPyH9A06mqV/0uqcPgkMn/KU4egD5VMD6hDUo03wNj7QeIFxH
	 egQlh2nz/fRI48wn9UGbKbN/9PRn1Ho6m/iGQCQPK7uxjgWAerCcGhTKst1SJDEALE
	 MMji+cRq/MGahrQ9SjFcxMM04wxER7Vnq3cVklkqZKBNajqhuRcxXHUXjsKpaXr9d2
	 oVu8krLwpBDNFWcKTlLa/mhCNHjUOgxXePnWzt7/hWSsZAM431bS7r814mwU1Yll9u
	 fWyU1iVdbvtVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C4FE4050E;
	Wed, 28 Oct 2026 07:35:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D994BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BB09400BB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:35:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DN2cJAfR7cbU for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 037374009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793172930;
 b=kNY79KqTvT+lxbQjWvG8APpLC0uWbJassQ00XXLTB5ZPaTR9ifSZcvLYnaGOWiJThSs1
 rtNzelA1W8S4/aH3d1Ios62ndEByhwpPINAQx+p8LpP1FZmaapnd8ODP/XpdaOGsKkug0
 JT5B8b+lYsOVRttAD1DUB1Ri/ldFVDyIWtCtW3mOThhz2BmBAILiiaSixyTzcU1T9dxoI
 wrxXH03TkG013qY7EDobYTqd0ZOojORGYQebD7oc2Kl+Kv9vDNWWuevzZefbdEGhH8UYA
 TKferQAdopcHFzfNWeThXsShT1+fL43IgNHHfFFirfl23MK7vrXDGnHPS13TYw/LAqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793172930;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=6EPCQhS50BwkH2ZYFlVIlulQ2kl1WFl+4uAAt1Wy9Vg=;
 b=EwVkKjzRa3QD+PuROi6KLhfDfhs9U1SsRXhX4Ap83JquiL+69i5g0pcWeFMA3iG3CY+g
 U4cytmpQxvCe6J8jAVyqa7CRa4uTcNzUPstZ40b059d/CRwtgiIMu5JpTaQtVlw7A2MV1
 GZjyEAQXP6BuxjeCpwZBwR8qKJ6gOF9qbrD4HQdFVE8dM3O1WGHg9laNMYsWd1DogeZH5
 HciZProleEC+16qx1B5B6ypBDsnUOEgDQw1xrP+Ran1HAoJa3LO6/bg/bROTA/ZcmgiiW
 lewMXNJpydMaremLj3A+iykBlPUbhCBaNIoX+tzix/z3KckmAUvVk1yzaaTiLV11NgQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JsPwj3IY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JsPwj3IY
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 037374009D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:35:28 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so1345296a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:35:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793172926; cv=none;
 d=google.com; s=arc-20260327;
 b=jfnWwlf9uzBXmAh97JJP5PZTBicRZcKvknRYwnm7OE5bGeIRQMs7IcWM92VT+gMcMc
 Zi5qafsGjX3ULaXTnwSjUom+ViXVJBHFFQT6JfZYxg54NFb/WGBLzVXO3NrxEEO+FU9R
 t0zDT6n5RM+X06iSqRA3WWxNd15CMJEGwEkmu0scSSlpNzUhYWO5fNyFAW/O5aKgWyB+
 McS+20da1Hix/fFGZGo8q6S0KqQMLaW/jCv7wb2KWrBV2qfl7GlE0mX+de+J8LtQipfw
 vdE32Ah07PLQpDa7QiwNtTtctENwB5GXzGrJKnUiIy010SEkmjAp/yKZUxn+5PRl3Ig8
 1Jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6EPCQhS50BwkH2ZYFlVIlulQ2kl1WFl+4uAAt1Wy9Vg=;
 fh=dVMR6IDxkWEApxAxo2AIdeWCyeXoM4BYi8+eN0Q7DXc=;
 b=QC4/Owe1drTnbpu15Ovagvy9kP+sls4/4gsQiosfjlLCItd13L6Sph/Y8CT7fGgL0a
 jkBq13JEzWcJUqaNpPvKCoxemzARPHDUQWZ4ENVITKmdRYVrBfgYCvatXb93xm49yPYI
 +Q2S9FyQuarkoGcJ9aUGMtUps9KEPz8nMhXxnt5DHCK3CSE004XkiSRMa3WNfJfrsDAN
 rYJ8VEmsUnnR0wXEjnIxWwLLDLdZe2nLRo0hQVNowUKGv9bsUatTY0CyD8wvJOdBo38Q
 rsdxDxgcb4mR9RkWKrh2VLpoVWUFjw5Gipij/BcRAPn65LlvVWkNfRJRciqzL3VBSADm
 qDMA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793172926; x=1793777726;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6EPCQhS50BwkH2ZYFlVIlulQ2kl1WFl+4uAAt1Wy9Vg=;
 b=JsPwj3IYrqhBUGU2iDuLkrdZj+oFG0hT3HcuNxqEQ4hbAbGSf9F/r/1AvDpU3JcaJb
 M/VqF/O9FMs6Y55HHVnJdZ/IxFHSyCpkHI6dwr60ClVkB/7hsMPIjavB0OhcYAlHBpFv
 5U40sRPBl5WdKbr/xgqJzGWi5kcF8VsSUbUKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172926; x=1793777726;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6EPCQhS50BwkH2ZYFlVIlulQ2kl1WFl+4uAAt1Wy9Vg=;
 b=w7mPOLX2nROnk1TVY6ROUHJ2CWlYT5x9q8eyOWgFBAbsZ75R+fsobH8FlSiyh2CF36
 lPrB+ogsfBZPYehw/dxqlMysOSItZVamKX4YUiO2rR+UfDoi2TJ3xV2YWg9ga8bE/poX
 DeSPzVsz2kSyh7gPQ5UGxvnh58wqkxTALo/luAUj8W62jufkepVlnM0VtJm3NxbnpfbB
 0TYNuRfstEyQz8V+KYcmlIs8SzuW8EqSnUGay1LqTXLlR8QVU4ZMlsjW2kjhm7BM0cZ2
 ySGOL7wuytasVG7FK39+HxEfHKfSQ+ASLjW1X/EJcdptZrdfObbdnDCimXdIXoSiel5T
 YcyQ==
X-Gm-Message-State: AFq9FYJMwNuIJg5QCbE+UhX7XRSIyDSCeQsdaYe/fVDnZb8rpZ2eYqJF
 AkN2S1Kk4H4Q2NmZ5NAJkYFt62Ijm/J5eTMkiWhGMj0l6R0eZwhzOrRMs3+/PJ58vNwiSR6HNtY
 Uj8DgjqA+fWZXTqd4bD8VahQhFAlFPI29SqyTOavMM3ZnSw2k5lgkkg==
X-Gm-Gg: AYBFou0XHmMt3Fzj69BHTnGcxENNCT3CMraP9uKb4xQOsI8XGnYBTaaCcu+iPJEV/tl
 Yyx3Zz0XBHge7etvB7nSOPbWWLqmUTth9d5qPAKEV1CY91ZtxtzSlQlZsrrJIgMXRo+RoRDUe06
 RP/amtG35YohJsBwoaKJgECixp0PhjbBn9ljqnW6uDW+sIPAYiFJ+Y3mml5mReyrFbrECmlQ0cT
 Gbk8Va35qSHI3J6oYDcjW4HyOKs0CaEufOf2c+Ss4mL2nth3DJ4H3LZK+8EoebNQNE0GVwqyvaU
 LTCtT5gwDmXajQl4EW8dYukljj3Qh4rw/jSZBjCAShnnq0gv3oYmyxt4Z0DU2+FgQlAAGsd9jhY
 gjiYS22oy0aH0IseTX1Za3ym8s9Zc4G8QsQk=
X-Received: by 2002:a05:6402:1e8c:b0:6aa:a33a:2762 with SMTP id
 4fb4d7f45d1cf-6b49caee1famr900070a12.2.1793172926547; Wed, 28 Oct 2026
 00:35:26 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:35:25 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:33:00 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027131837.177854-1-odeschamps.mail@gmail.com>
References: <20261027131837.177854-1-odeschamps.mail@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 00:35:25 -0700
X-Gm-Features: AclHuK93lXk-D4ypvSi9yieoD1_nC2w2Pvd-QNvnpcVcRV753fkOmi4fSGYENvI
Message-ID: <CAFLszTjw=Z9oX=bdBNqK5YR_8VZy1ObF6ivgjZfni918nT4kOg@mail.gmail.com>
Subject: Re: [PATCH] lib: date: reject out-of-range month in rtc_calc_weekday()
To: odeschamps.mail@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Oscar,

On 2026-10-27T13:18:37, Oscar Deschamps <odeschamps.mail@gmail.com> wrote:
> lib: date: reject out-of-range month in rtc_calc_weekday()
>
> rtc_calc_weekday() indexes the 12-entry month_offset[] array with
> tm->tm_mon - 1 but never checks that tm_mon is in 1..12. A caller that
> derives the month from untrusted data can pass a larger value, causing an
> out-of-bounds read of month_offset[].
>
> fs/fat reaches this with on-disk data: fat_readdir() calls fat2rtc() on
> each directory entry's cdate/date/adate fields, and fat2rtc() does
>
>     tm->tm_mon = (date & 0x1e0) >> 5;
>
> The month is a 4-bit field, so it can be 0..15. A directory-entry date
> word with a month of 13..15 (which a compliant filesystem never writes,
> but a crafted or corrupted image can contain) makes rtc_calc_weekday()
> read past month_offset[]. This happens while merely listing a FAT volume
> (fatls / ls), i.e. on attacker-controlled media before it is validated.

Month 0 is more common and needs no crafted image. The creation and
access dates are optional in FAT and many implementations leave them
as zero, so a zero date word gives tm_mon = 0 and reads
month_offset[-1] on an ordinary volume. Please can you mention this,
since the patch fixes it too. Also, fat_readdir() only calls fat2rtc()
when EFI_LOADER is enabled, so it would be worth saying that.

> Found with a libFuzzer harness over the FAT parser (test/fuzz/fat.c).

There is no test/fuzz/fat.c in the tree - are you planning to send the
harness too? A small unit test for rtc_calc_weekday() with months 0
and 13 would be good, perhaps as a follow-up.

>
> The impact is limited to an out-of-bounds read (a wrong weekday, or on a
> sanitizer build an abort); there is no write. Reject an out-of-range
> [...]
>
>  lib/date.c | 2 ++
>  1 file changed, 2 insertions(+)

In any case:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
