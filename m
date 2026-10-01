Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27829CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9BE760BF1;
	Thu,  1 Oct 2026 16:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PerDcOqAfa-U; Thu,  1 Oct 2026 16:00:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1380460A41
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870424;
	b=O6ZO2A/LKFacYQiPsK1tn5J5ywat5ftfniSAJPeqVIwjKbgVsAbcb4NNXt0fZmunAvQx
	 vfdtflaWVlhHG8iFWvG3mX+hiwGN+9fbtQaOsN8evfN2MCDNFBi1KPTYqLo6BnwZYwubg
	 r5s+/90tn1FVBROrxfU+36u4qTfW7jiJuYWbOBk31vRbW3FSew/kHL/zw3kGcKu640FcR
	 F+8KJS7xPQ16oUpJ6ZRPKxO40DnotLTZlLSEDmOfNQLCbmNV2BgvmG+SfxTWmF4BwvrzP
	 2tFajQTC02BWAT+HbWCmCVYXsoaQFBPkBliEgU5v3gEk/rVuYbZeStPo88opYwq+aYg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cjOV3OScu6rhqX0Pd6YC5G2q0OLt1qou6718TqHgpG4=;
	b=VR0kXObRhYENuGQhoKvAQbRWJ0EvtvgKb0B4qOp3Jf8K/vLb2FrI1J6r41k5EVI49YSr
	 VSNh8S1nqlB9TEnEgLng6Lig7bQfbYsCqExuQYMQfX5DAXTADwKBOlaOlLSk4txR409xZ
	 CZqJvLxesYC5o+9VtALsnqsrZtGpr+RXSm3CgEkB88Sxr45ue+jviiP7/RP4SxJ5f8SHM
	 m4QE7baRH4WZB2hfU/hA3IQBHtxI2B8Dznf8MxWTjRNbm5LOCa4rRciySNvN474zpp7/7
	 jRTtGs6WfgsrXr9c04S6FtmY14rjivgigbI4FFism4Rme1ddPUYV2IyTePigYzCwC/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=nCob7NHg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870424;
	bh=cjOV3OScu6rhqX0Pd6YC5G2q0OLt1qou6718TqHgpG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tnOmYBOO3ezlbfVaftv9uHWdUfkkPAalWOCWQQ1VyyMk//iG5jZdple6jwOieP0I5
	 En6ili/ykEE8keP8qKvOUPxZCkaBsVKFHOAXzLsEdpPLqWxi0mb73jFHZk6t80Quzg
	 SYkdZL/FLnxrzfLh3xk9RJlHgB3w0gKk2m9NayNlxEbZC1HjdFplyeWSjZ95mQKCgX
	 M5m1a1nJA3Pm4hFG1nfAGeRwX1R6mMGh1g5Hur/VNMhQw+WiIZ4UWfpEqBHLCkmK0G
	 dyTrImmapzX6b+oSnxgqMhNaW2P36rwFi3N+fZYmh6rkYGLHy8HORpVIlomEHnJz8L
	 0jg/6/RtZ1iyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1380460A41;
	Thu,  1 Oct 2026 16:00:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 73F281A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59F6660A41
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YpXn3vsL6kPV for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:00:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9447060873
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870421;
 b=jAYJbEiqttU1bT+pLXCtY0XnzpVSsVKe5cDm58qIJTmWlhgGx7JsjicCJfJG8DvoRv40
 m2SmL8TLBk2upGSPC6Sb09VyMYdQXy8bGSUC4Xq9rRLLG5LX2or1ltqU4c6Z5RmnkwaeF
 pNhHawhsZAfVXD9jqAUfzwDNClMM0pthoM78197L5vlN+Y+dGxb9YKzX4WnUbL88MvxO1
 F3wfC5VRg/NAm4SAhfL8/hmFpDzE1iy/anozBD44WTJSseOXEbql8R6md8ZoEcbqytSp4
 22J11yGYLNbsNgD1HqXh6JZjxCvc6+VgXfNopZV0rQ/6Sop+FJ/DS7NBrUHAQUqfUoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870421;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=cjOV3OScu6rhqX0Pd6YC5G2q0OLt1qou6718TqHgpG4=;
 b=PLFB1LGK51y/hW1ciuv0XjzuhJmIxEv5ijGvfxEYnIYphwF9Mp6HhRRYnKxiwx9RrN8y
 YHbPXUseduNUF/zJm9dBnkQIcF+zBX7OBhhDfyexx5YLJiePz+cXKhxR/zTBLYJFqE6Vw
 0sbJH4eqLMQqtX0xGDIcEiudRgUw1ghXZter2dsfIZRGAbuV1zrbqPLp8CIghsP031P2u
 bDHiN6pzIV4GjWpz1/NF2s6l9/yLbesxQcnlhPhU5fuA6OTA/yArJ+Y1RjTY4q40Tmjpb
 KOclQZj5gKGvodS3pUizX9P33MXR8ZD1fCOZBzlK9UtzV7vnTKIyBOoTIIUQp5mbrOQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nCob7NHg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::2a; helo=mail-pj2-x2a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nCob7NHg
Received: from mail-pj2-x2a.google.com (mail-pj2-x2a.google.com
 [IPv6:2607:f8b0:4864:39::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9447060873
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:21 +0000 (UTC)
Received: by mail-pj2-x2a.google.com with SMTP id
 98e67ed59e1d1-3a4bb1ed012so1960088a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870420; cv=none;
 d=google.com; s=arc-20260327;
 b=bibpSCjgPz2kvyNekG5EQN6W6omCRUTBjPSVl8GZD3b9TAG5hMgOdouhQ3D+PGpXFN
 VaHek964wm9x7PBHiZ3C1EyIoGUUJfJ0SIjk1hNj15443RqK4ZeluYd++WJoXnVX0pES
 h+s+/6q85eLkWtUtOUeaE7DpbdZBwgjOTTcM2n8BovI7DXNWlMUX9sMlB404NKb98OG4
 bxboftOo9UHXNwViBh+RhZ3NxgkV5L7Mg+cZvAqOWIaFH+M9MjjDVBBjGJTfcp/TsHWO
 e2GBBq28kHEEizzGhqxAa9rAFa4/e7SgTBreyGesmfiBLVx5jJVg7+WXQZUu4yT6crYm
 ezTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cjOV3OScu6rhqX0Pd6YC5G2q0OLt1qou6718TqHgpG4=;
 fh=z0mxqfpCf0NaKuRcT0YcSdF7H8Df4a/qRswxQ082Mjo=;
 b=FgxrPwfYhsXcm/B5QpSI8jmBDT3oaVZwPuk6VoIc97gn628RROLCqCmeae9fQuV7Mq
 0R8oc1ZeTEQAKBKigtxi3lYUWjfZE2n+WDbhRq9nc25EeXGb6DecKFw2F2p5Elw/Hyk1
 45dURhp3Pt4YO3XdSTTnceC2Mm5iZYstXF8dabQ3ky79AW84s0WUO5Yt6x+UDpFzS26W
 63Itf6Ho3oX5Xs+kIECDFwbsbNaS97UY1N3bPJEcIqeKKzFUtlc4AFiHSmEjrZW838dl
 qnPITjIS8Q+zmrqlFkU0Bs2b00dr/VZW/PkSCf0Zvjrq/avjMINQuTmWWbo+IoFDELUh
 vb/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870420; x=1791475220;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cjOV3OScu6rhqX0Pd6YC5G2q0OLt1qou6718TqHgpG4=;
 b=nCob7NHgZ+xVFdkroAVaejgDFjn1OD4OOLn1Lp5EKCauwZeEwg2wM4kTBgLGtC8aFN
 g7+P8+FI5NcB+3HkIXbaeQrUGjY2TcdIN7iOH/EhDDQtK/wSK6Oht8EsJzccxjKdYLWx
 4bRGnpOnd4uY1XMZokVqPzuDICawuesAPI8dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870420; x=1791475220;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cjOV3OScu6rhqX0Pd6YC5G2q0OLt1qou6718TqHgpG4=;
 b=jW9SCZDwTpnIvxVmC7J96iegDRH88CTm5hJg2dwKiMM0ABt2dUAtXp4BL0dSZddbL4
 Ua/VPPTvTIO+pqSwlbppLgj/M9lvBGIXRGi5j1LCZpEbyKL+LU0+kvEQ24UpBg9AnOAo
 efRDwtfatHL0N+bksp03Smpva5+E08kQONLcHvj/FIg7GtiVeuagGkMBaLvQEJZir1Cg
 UT923mG36PnwDuV9mMV6HxaM4JPlEDhUGTJLMUetJBmr6tKsDtyLV+rK55nUUEy5pAMK
 PHleysfAhc7O4pptS4vjTsRM/rkZktF7e5ANZ8cV58l06G+X2Zk7/4gOm/HztTvws1ps
 SOnA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBVzMbUJUg6pS66EsMQOpp8ewahGelVy8o5SzfzW9D9RfBVUpNzjSwrPz+79JWx0U12XDJ2+0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKs82ADWPFL6E1R4g9TY4A3z/MtIt+5J7oDS7AmFvNlh4xsjp03
 OwHEhdu5lqjcOUMX/9waQGwOP8sLtJjjKwTv3E3DIJPUsJ4zV81ZC9BFtpwgkx9WuKEGhFdP3tN
 vAOwEr3EqmLGc7yIxQi4adrXVGzV90RKlFlU8UTWk/0xWMSuk2FEQpQ==
X-Gm-Gg: AYBFou38R+whRh1zyEkGTglISgpaACuD4Avd3M2vu6cFsY/dWOpPkbtZXYkM9KMXRky
 S3SwTV1q6DnZMN3VMeZfN22Ul6FIfqWUWwFc37y74uwEgmi4uWe3nTlknIJ9CMEO95NDhwKzd3j
 9kWkWZ+F2cEgSQDOkMjYg0qpvYLAmskief5IqIz4XuffDDKzFWMfwpJuSsYE/n8cedfrjOi+AwH
 57VshMiJE/cKnzifMI1rpWHBy+p5dDI5tikKlGKvVqyze0nxFTmvdoOZJ4+RrDolvAXL2Dk0QQP
 O0Qz0rmCMrQlGW33Prp/tYluPH0OqVRafWlAOsL2IwcFxYJnFPX9/636
X-Received: by 2002:a17:90b:2dcd:b0:3a4:dc2c:be70 with SMTP id
 98e67ed59e1d1-3a6ced4f86fmr5692a91.65.1790870420417; Thu, 01 Oct 2026
 09:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <d37b9238c4e19f4b96f44c7d9a0f3beeddfdb9fc.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <d37b9238c4e19f4b96f44c7d9a0f3beeddfdb9fc.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 16:59:52 +0100
X-Gm-Features: AclHuK-mCw7mdaUQK-W4qH5hDspRFD264x0qPj45bcdAn86JGuwRn-MvCM1mVfU
Message-ID: <CAFLszTjb=ppyVLy6QLJfCmfjErbf0x7YaJevqgXJM0ZkfG6m_A@mail.gmail.com>
Subject: Re: [PATCH 04/11] boot: imagemap: free the reservation a replaced
 record owned
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: imagemap: free the reservation a replaced record owned
>
> imagemap_record() overwrites an entry that already covers the same image
> offset, including its lmb_reserved flag. When imagemap_map_to() replaces
> a region that imagemap_map() had allocated from LMB, the reservation is
> forgotten with the address that owned it, so imagemap_cleanup() walks a
> table that no longer mentions it and the memory stays reserved for the
> rest of the boot.
>
> Release the reservation before the entry is pointed at different memory.
>
> Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/imagemap.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -114,12 +114,22 @@ imagemap_record(struct udevice *dev, loff_t img_offset, ulong size,
> +             /*
> +              * The entry is about to describe different memory, so give up
> +              * the reservation it owns while its address is still known.
> +              */
> +             if (r->lmb_reserved && r->ram != ram)
> +                     lmb_free(map_to_sysmem(r->ram),
> +                              ALIGN(r->size, ARCH_DMA_MINALIGN), LMB_NONE);

This fixes the leak but adds a lifetime problem. imagemap_map() has
already given its caller a pointer into the old buffer, which used to
stay valid until imagemap_cleanup(). Now the memory goes back to LMB
while the caller may still hold the pointer, and a later lmb_alloc()
can hand it out again, e.g. for the FDT or ramdisk relocation in
bootm. One way to hit this is two FIT images sharing the same external
data position, where only one has a load address. The first gets an
imagemap buffer, which fit_image_get_data() returns via
imagemap_lookup(). The second then calls imagemap_map_to() at the same
offset and frees that buffer under the first.

My suggestion is to stop imagemap_map_to() overwriting an LMB-owned
entry. If the existing entry is lmb_reserved and the memory differs,
append a new entry instead. imagemap_cleanup() still frees the
reservation, so nothing leaks, and earlier pointers stay valid until
then. What do you think?

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -114,12 +114,22 @@ imagemap_record(struct udevice *dev, loff_t img_offset, ulong size,
> +             r->size = size;
> +             r->ram = ram;
> +             r->lmb_reserved = lmb_reserved;

Just to check: if r->ram == ram, r->lmb_reserved is true and the new
lmb_reserved is false, the flag is cleared and the reservation still
leaks. That happens if a caller passes an imagemap-owned pointer as
dst to imagemap_map_to(). Unlikely, but the fix is simple: keep the
flag when the memory doesn't change. Also, r->size can shrink here,
and the lmb_free() in imagemap_cleanup() then uses the smaller size.

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -114,12 +114,22 @@ imagemap_record(struct udevice *dev, loff_t img_offset, ulong size,
>       /* Check for an existing entry at the same base that we can extend */

This comment no longer fits, since the loop now replaces the entry
rather than extending it. The function comment also says the entry is
updated only 'if the new size is larger', which the code has never
done. Please can you update both?

Please can you also add a test to test/boot/imagemap.c?
imagemap_test_lmb_reserve() is a good model: call imagemap_map() then
imagemap_map_to() at the same block-aligned offset, then check that
the first buffer is no longer reserved after cleanup.

Regards,
Simon
