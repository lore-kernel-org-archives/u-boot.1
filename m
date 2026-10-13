Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651DECA9EDE
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08EEB405A3;
	Tue, 13 Oct 2026 03:30:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lR8d4plg3iUQ; Tue, 13 Oct 2026 03:30:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F56340575
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862226;
	b=WLetobPx0m6zh7YnRtYrwAxi1XktYI8ll9IimfAgYoqt0tAOe9iMiHIDRi5XK7/LTYUT
	 ysztGrC7iIvS3ov56NwOPFZPHxaFMm5MwYOEsfMXjRYpUJ7aymrbtn0Y+xo0yc75tAke4
	 RInYAnnnRAjBF6yX7hoRvlaEavbuc7wgCs8f7PNESObfkm1fBGuQdf/7IIXh9uucqG+Qx
	 JjP/TH2Vh1iYBScJzErA4yiakecX6GVLcEvI3uVSjZmi6Q5OobSUfP9nnDhe2WBEcLBSH
	 9lbscOT929V+sBmnMXvCNWJOQBKxE6n5x8/9apAZBaI/oTraPNaQiLgoU4t6MAXrcGw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Tn/NdyK5BTxWcTyyBOq7oPcWK+gK9kRnlQtxau9NqJ0=;
	b=REG85+vccVaWkm6eUf5WUKHHgyDQ0H/rLGe5OyaYvn7xhBDH7nOb4KwRXha7GwJJQyg/
	 2ws14E0lf9Gv6V3E4+alh1x61trXv0AelVa73R5/mWcHaGu0+KZ40A8zo5uzhjtXdf9KQ
	 1xk/Zuk96v1BdTfrTt4eNueKAYvi+F2kZoVGL2uOO6/c2LFehk+2hTFW/eThpowUUmsVh
	 U6Ss1BLftDt9xBiEG8rbnA7XnlJiEkUu6TMEcrBj6NiuxuBDfwmCcApYtO5vGtn33Vly2
	 vDLBvE2p6y6HwHmHpCRCNFr8xdcebsjlhxf0kmqH7TXVrAGDsvglIyM7b1e/c90zepg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mDWPpIjM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862226;
	bh=Tn/NdyK5BTxWcTyyBOq7oPcWK+gK9kRnlQtxau9NqJ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B926WF0sEeUAlRnERRuWCKgHJpw5Qt75xNzOC2I5peKAIvsfhDnfgQcAQRKGIKtdc
	 bFuFOE3b58JcTiaFABNIVhJDsGkl7R9heNGUZ4fVPGkBCv46G29WO8nc/RaYFNIgGY
	 R6e1zHZXc6J0mYye7egRDYkNFtVlp5Crv8rbIGKFPowSn+ogOMj5KQpULc3zwnzH58
	 Kuz6rZSaDuQJ+dNr9lh+17yze5wzNcogLxRdKEmpQiyy4MF79+nfj3EMYfEok+tA0b
	 N1S6rajf91Dcj5NWtJA+9d74k0H/hRmqxiHr3kjBNxbexCm3zgkgZSXYT6zitRQ5Er
	 CSw0C6tG5pBsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F56340575;
	Tue, 13 Oct 2026 03:30:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D65D31E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7EAB40575
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:30:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVjbjLFC2e3P for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 037174051C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862223;
 b=dR+gNzzjUi9uPHYV71QoXfqTJpqkniXWGc2OISZY75vS8mS9uHsLxfXWNP6ucPps6nz5
 UcqC++9uivXbilXT6VhaUTlk3PLr97A7NNB9H02I7mLQIHWlqLn6GEsOFPXVyajMkoUgL
 9I9mJEiyCLhrVpPewpnzkvTUd02dK6UAKwwi6BX/+J7haNymNuq2zM7hGDpo2G5I0AoLK
 RBI4HimdhNhz2fya4jErluc+izbj576Y/33ody/HCEJqxpeWOoVarf9hqLGquQ32GgNP6
 g7oknsXMzu3Z9a3j27u3FcphRiuc/4mJqUdng6gJiCdzp00iYUlHiS4JYSprJfg86bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862223;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Tn/NdyK5BTxWcTyyBOq7oPcWK+gK9kRnlQtxau9NqJ0=;
 b=iUdb8R4C6tTiaTKdEmnn3bEGEH088Ik3ii/QfAtW4X4kgSUQiyM6rLqrFwWuf/+oWb5k
 HDgp/tnqH1V+jOhK8aYHa2XuARlfXZp4NlVbMtIH4bI8XbgTPGpjeKYXLB/tiqhcfU9kg
 QyqTjM76vS84WeC2EceB6AT5IRfAC/BiMxvPsRsU7CsiUN/AZuUZPF10+RHqo61sL2OHO
 RVZbr7DTdOHg47sQPzVGnA/j9mniHVNMKVBO4KLnXaTrB2J1fyE3LDE5Bw4GPd+yOwZdB
 fxa/5O/HVF1aMWySuJrUBOGTU1Q2FSVZMgtqXvezCWAG5TWkf10UFSejzJT25m6ZZIw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mDWPpIjM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mDWPpIjM
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 037174051C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:30:22 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6acbdbc1725so3118018a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862220; cv=none;
 d=google.com; s=arc-20260327;
 b=OSp4bwV6/sCaP5dgnrWPRUYQ45wiuMLSLa0vz0WNw5twa+qc/PnTE2nUEyYuIplZdY
 r5vinz7jn7ZHCzFqsbdMlX+r5zMA/J6HqsDMThOblSBdQyOfuZmJdkIN2NMK5+ATUode
 jrEi59bXl3N6dFosE6oI2Ngc6WwtlSm/k65AiWZ9MkvYBSTpPVn7cCs5ku7gQ2ym/Wpn
 +3Q1g61hfyRnpZBtPstFIO+beN4UDEQG+mtkXs0kue90xkUuGJTYP5rwfDqGZ5A/omP7
 D+esMZpj7eADKDgqVNKi1wRH9DiGZnnvebj5f97yFYXCj4zAz6orgiaD/+1KPBKcBbcQ
 lGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tn/NdyK5BTxWcTyyBOq7oPcWK+gK9kRnlQtxau9NqJ0=;
 fh=jGaU7NVrAUvqtg9j9D3aJG4y3+x7AoneJXvaA3STdZg=;
 b=JsqCPrEkHHVSkKjzdszCzVo0+1rbxtQsUDVnoPesoQKvHkMBTaBSIW4lMM7puOl9hW
 DpHxsye6vbXh3r8xHa4XejKrNMqDA7qpjqVAp+zshlCfEMo0SHhZoD0MPNdvknXGejRm
 R+q6S37FoBoshK7bkldTnt/0eZOlYJUzj2FV02NiBOzS0RAThUJUKLJWehbUGz1SHD8Z
 VCfGSG4a7gUSdUBv1wlkgSxpf6tt1esst5lGVOGWmsgxn+ql58+8KCAWokUpGatz+SIc
 hqJJ3suX3bJMTu5HxWQuY7hoVhvx9lRVmuK7Br+Ju4VC1deVV398olTWdSMN6ITcdYfB
 /1nw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862220; x=1792467020;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Tn/NdyK5BTxWcTyyBOq7oPcWK+gK9kRnlQtxau9NqJ0=;
 b=mDWPpIjMYAu50lB8y6Emx/fA8uKzyfvDlJkGJrkTjP0ujGu5u++tTG/QEl7I/WN+gq
 c/GUs/+js74bg8GdDhwa0GINgU6lOp4xwSYnFOG7ohY+Nup5g7JzWOsOHyX2szljTKjL
 ip/g9av5cqvNo7X5aXlzTpDBCmdoDbBdrk03I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862220; x=1792467020;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tn/NdyK5BTxWcTyyBOq7oPcWK+gK9kRnlQtxau9NqJ0=;
 b=amgvoFnnAdMK05e9SpFG5SDtxpmbOZTCqngkIOuApbx1ZlIDocHRIUoYA0RspnaMgP
 M5tX0YdBBUBN1iAF6auor6oEXxwoPkhCqv+TaECT/Cd/SXFKhb9PtpMVSZgdCAErwq50
 u6edKh0MfLruK0VSQSgvaY10UqzOeeKkBrhMuF/t4+ppXI+hZZJlILm9dKXPuuMUhkOV
 /GcGnzVkcod2fYuF32FmLsRHwTSmjvsh0XqS0lwGQiVGYf8ScRv3X3rUJhdhKPgzkY5Y
 3LW9Pro527A7/JGdCy6uELEQO63pWtEX8f3MEIiS6YsTOUsKGW3IwZ7R2PjFb192tJfw
 7TKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUAV4ZF07jV0CiMUM2F6aTl3eqFA8KcDIPrp+ftqr4YwSgkQE2DHTzJFwHIIvHaRAKHOtRBzo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI0BSRoORT9fYrXUbujxzGMCld0I5ChBhe+I1aZCexrGJTsjCGF
 HeY/bt2hLuWFJrwOQE67KIftIPajGz2/wMOhn7uJqy7KOKZ+hUP0DZOnW57KkEFeqax6YP6MFHU
 o0D1XLdpZaAOvKehpEdAwRlm7AAg9zK16NLvzGnag
X-Gm-Gg: AYBFou0vTKjaUP/j70nIhQ/F5tImUIWs4YQOY5k7Xq6TpXsDtf+URI15jbAx0OzLy7j
 AUptk/KJDbOD8Mk0+eOpIC3drGd18uOKgosuNy3+FT4sfFuzAi+a6qnMvR4uLc7BhtjlF1V505V
 81utZTCNp37SPR0pjWOoHyYmWlpIWUl9lhb78e0mf9qhfHMW3EjNcKGfQZJDFujY87kw230cOSr
 NQWnW0F+E9dPlC3Lk29n5gj2xf+rj0wx8Q6xR6iThjWzsq2AKCBGIxmDl2CSEDufIrKV0lOIKOO
 2T58/1qmp/xNBQtKAj3kQ+eZhgV3/QgWVVQ1j+OOX0Vsx+1JphnWV2CT+YKeDVqcfB4=
X-Received: by 2002:a05:6402:13c5:b0:6b1:e4a0:4848 with SMTP id
 4fb4d7f45d1cf-6b1e4a06a94mr1008303a12.43.1791862220634; Mon, 12 Oct 2026
 20:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:30:06 +0100
X-Gm-Features: AclHuK85XHHL4dOHcWd1gaOP4pRG5xpuiofJ4oHwnQdsAmqfZNjAWH-eNIHW3cI
Message-ID: <CAFLszTjObAiHP2ND54aW-AvgvPm3D8t3F_grguCBLJcssuBLsw@mail.gmail.com>
Subject: Re: [PATCH 2/9] fs: print change date in directory listing for FAT
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: print change date in directory listing for FAT
>
> fs_ls_generic() displays file sizes but no timestamps. The FAT
> filesystem stores a change date in every directory entry and already
> populates fs_dirent::change_time in fat_readdir(). Print the date
> alongside the file size for filesystems that provide it.
>
> Add a u32 capability bitmap (caps) to struct fstype_info. Each bit
> documents a property that the filesystem's readdir() implementation
> guarantees:
>
>   FS_CAP_DATE  BIT(0)  change_time in fs_dirent is valid
>
> fs_ls_generic() tests FS_CAP_DATE once before the loop to select a
> consistent output format for the entire listing:
>
>   12345678  2024-03-15 09:30  filename.txt    (FAT)
>   12345678   filename.txt                     (ext4, squashfs, ...)
>
> Set FS_CAP_DATE for FAT. fat2rtc() loses the __maybe_unused annotation
> [...]
>
> fs/fat/fat.c |  2 +-
>  fs/fs.c      | 38 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 4 deletions(-)

> Set FS_CAP_DATE for FAT. fat2rtc() loses the __maybe_unused annotation
> since it is now called unconditionally outside XPL builds.

This patch doesn't remove the annotation. fat2rtc() is still 'static
void __maybe_unused' in fat.c. Please can you either remove the
annotation or drop this sentence?

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -38,6 +38,11 @@ static int fs_dev_part;
> +/*/
> + * define FS_CAP_DATE - readdir() populates fs_dirent::change_time
> + */

The opener '/*/' looks like a typo for '/**'

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -50,6 +55,10 @@ struct fstype_info {
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +     /* Capability flags (FS_CAP_*) */
> +     u32 caps;
> +#endif

This #if leads to three #if blocks in this patch, plus one more for
each filesystem that gets the cap (patch 3 adds another). All of that
saves only 4 bytes per entry. I suggest always including caps and
doing this in fs_ls_generic():

   bool has_date = !IS_ENABLED(CONFIG_XPL_BUILD) &&
                   (fs_get_info(fs_type)->caps & FS_CAP_DATE);

The compiler still drops the date code in XPL builds, and fstypes[]
needs no #ifdefs. What do you think?

Even better IMO you could create an accessor in the header file as we
have done in global_data.h

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -112,15 +130,26 @@ static int fs_ls_generic(const char *dirname)
> -                     printf("            %s/\n", dent->name);
> +                     printf("          ");
>                       ndirs++;
>               } else if (dent->type == FS_DT_LNK) {
> -                     printf("    <SYM>   %s\n", dent->name);
> +                     printf("    <SYM> ");
>                       nfiles++;
>               } else {
> -                     printf(" %8lld   %s\n", dent->size, dent->name);
> +                     printf(" %8lld ", dent->size);

This also changes the output for every filesystem without FS_CAP_DATE:
the name column moves from 12 to 10 characters. That is why patch 9
has to change the erofs test, and user scripts that parse ls output
could break too. Please can you keep the existing three-space gap when
has_date is false, e.g. by printing the separator after the optional
date? Then only FAT and ext4 output changes.

Regards,
Simon
