Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4341FCCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDCF460789;
	Mon, 19 Oct 2026 09:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XY_AZzafVYY; Mon, 19 Oct 2026 09:14:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 41B6660743
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401269;
	b=WJK8giuVr9vFd0EzbZoKLsHJghYKT0zlw7KdlZxanZ/dFOmP1eqvYHp0pIyz6LH6l9Vd
	 S6+KhnzA5BkMinzNQX0cGPqqGSn5BCR5BSES5ssFUnN5JJGxgAEukpDGnyNOQCir7CFRn
	 KHGRdesnylI8bFi76RvghqQLk/agb6jSXJJoShodGyqz5CZLpAXANrYMJ/EnY7IFMfk97
	 JRG/OvEywiovqGP8Rkxsjsz2SnDaMeJPbm5gpBWDuNgY8ZAkKnGIVLkuaVFtdui2b7K7L
	 po9PkFJpgsnFSIN/GlhD271J1SRUjEaZCvWFpeRIdC5sapzy10siOzoCAwz/+izPJ7A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rHzC9NIxS3BrCZwgpFpuIz2nf3LvCZTRyj165EhCXrY=;
	b=l5ZZ55DufEeMq/c8hAw3mbA1UANEIXEM5AE4Ncwq7RG1/GtEqNV99YKKCUojyTaRFFsc
	 vlJ5w6UwV8ZqSEsHZ7aueTCQ1EQ81i5LHV7fYnqfS+P5Eu1YJWrOBBmdoyj6RraQjS/Fp
	 Iyhe0LJ/mVJnwBkY733CiLlVpVCM6NPOX+XXUIKVj9fRdj2BoX6GNT0QQ6m8w6PolNGKH
	 goVu/RY5ckUZQl5MLp51/TxSFot/nwvSm5eTClrriso5lfL0o5BTE+kgqXyIBrZaKBndd
	 q7mZpGFPo0zpebtyIB+WgE+ZRAdKamuaQ03Gt+bdoyVN6ajXPxBiOGCXqLEoZpQsoMA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401269;
	bh=rHzC9NIxS3BrCZwgpFpuIz2nf3LvCZTRyj165EhCXrY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZVuY04UXovRRuNvY7TOlCxhn75Ek0TxIaVqeWBf7ZvfGMIsP9R3pdATrs9CfUHUnv
	 jxy+iT+63gT3JExQzj06Uddb9m1H7Jc7ZO2f8QYswTw2GMBcIjh37OAWrOCbIoIpY8
	 9l8ftah/iywS6EglEeA5ulbeiJQ9NL2iVFm2pc3cEv15YTbHehnqSfq1KbFnt15axk
	 ilgKaxXGTBO+uicAkwdIVSOkqooq0faMcuOmAY0ftildJmkBIIDryKub2g2o+4k1Bd
	 uIc6CVZ04A93wF5LnULRvdgCvR5/KdLIkMX3gcn/8+zuUL9BWlRKDYTQb+kih7tu6Q
	 SM/Qqc4XvEAcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41B6660743;
	Mon, 19 Oct 2026 09:14:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E4FD31DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA9414018B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rPfKfwuWsvhP for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:14:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 39E0240062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401265;
 b=aXWjHI68+1bfJxlDwTO5/HpnEnbhhznku1HZogOyDymUIxn1dn8V4LxzWGAd5Wl3YsSm
 q49qCuplQ1EvdA75F8AF4ASRyH5sJl9T6m5VPTmydp6PwuBct5P6EGi7ltjkw1y5yRSji
 X+qEF4nRaX1dvcudZFLgvQZ1STgAnk+zbWpvhFfaLYq6MObexqN0ScyleI+K4aznbvLwN
 sBe8uTmE0Rd58aTmc+npcUl7P2mwIwafx1PGRO8ZF6MXSqIftYb1dC5LoJYUa1rBnstdI
 hqPI5bEO/cDCh0ivDikq+AHoffL1+8zZXPfqlHJLNpC8U1VhTv5vlI2JB54ldlRF1gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401265;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=rHzC9NIxS3BrCZwgpFpuIz2nf3LvCZTRyj165EhCXrY=;
 b=kofoCy9BdhodDkNSdOXVkUL56eybiW0CeA9n/VxSLYDB7m1m2PyjOzbOrmdhCMHELWxt
 GUeqTOrU+t88IeNI8tOa49YZt6plFd1Hcne5XRkz1Rwr7s8hAKTpAmbF0HWj850mlMj5a
 S/BjOVmo3hITzfFVwch2PFnsZAIZbxGAXcG0M8jizfHG21X8HccifZmr5UukOc7npU7Ls
 QFrP0zRBl6RiVZbxjJfKCCdhq1NUEPUUrj/Q6FshvPPpXfmmyDK60m3MMLn5+IC3PZmWd
 ezhlAj/mJvKcbNa/9cW1LsoHZVsHjE0/uibjh9sEqOsahncfoA3YU9CAmtTlQYrSIOg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=BmLt6Zsb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=BmLt6Zsb
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39E0240062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:24 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3acd21ba21aso1409835a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401264; cv=none;
 d=google.com; s=arc-20260327;
 b=hTrW9gLIQrqHt5WBvRTGBPxBuaRnW9WRFc1jalrYF8YUrb+kyVuUq+xTfmO8kGLF0a
 KL4ospz7dleJ7oQXMx64Yh0sGeEGMNHbM5i/A0RldsOHUY4AWrRhL2KvL8kFCN/hngNK
 IPtD2zJXiFAwpoxjZhferfjQJrkux2qHL3V854JD2QXSiERjw1LhWzsG7nA4zINUa50j
 myhEHl2/HlB0sT7vysKZ3mDGZheFJzSBpgmJtMY7/6kr8ARQS2/NK0FHlsF+O7E9qvcL
 KVcgH5sUEtou2fxnmlpmp6vDCMHejYN+9JqPykT7/tEBEOl6jds8B2l1g5Cmyyma5BRU
 cbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=rHzC9NIxS3BrCZwgpFpuIz2nf3LvCZTRyj165EhCXrY=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=dbk/SRci4bQNmsHkbP0FUlquuu7VwUPh32RU/qHtkR5OyHCbcmEB0AQrvTE/rZDXHW
 EkHOdKejIkloNHimPgVLcf90F3F8zx1OiahBbaQ6+1590aY7Rt/UvBHP8ycaWFe5pqlV
 rnTsxLEZ9chghvGsRlZS4R42LUdw1BLXkTTuT0hw4nplm3uNvsljSPWXyd5QrfHDi8+R
 AgRsoL4iYeuXgJ+dDzEw1FAziH/sHwRBJSdUsjCgMOxpIn6xa9WCBH1MiqGGMS7zKHAe
 R1UOh4GrDaflOoWl5J8ZKGO6mhtVaMLyxJK5LiSj+qMw8qLrpXpXsEJDMKlivxIygJZN
 1D8Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401264; x=1793006064;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rHzC9NIxS3BrCZwgpFpuIz2nf3LvCZTRyj165EhCXrY=;
 b=BmLt6ZsbUzh++aOadEvBOBb4xOANJrhF90PXAGwb3vpfrIJWvMfakv8qC7vcqh2okL
 q3P7FdX+tTii3Sbi6dP7+dMimfkS6TcZm5n0fm0k/pOmzkBCMK/Nv5UMAOpb2lsBly7W
 xJBU95TRbTdbequq7FjjLpgRlXvbg+labfLtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401264; x=1793006064;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rHzC9NIxS3BrCZwgpFpuIz2nf3LvCZTRyj165EhCXrY=;
 b=hP/aeLSGkqeJCzEg1UyO+hltpApkK5ORZeL5mnzQN0of5ewZXYDPjMN0c5F3w3nOn1
 QzLaBEvDP9L7w26JewrLGWlh/vvj4/gQi2YUgy16sQwIoJisbXKhhMVsn7BVCVxGwymK
 SEbsE3unZpEz773oladpTEMgGzFS/TRgGjbQplhIqtItz8xJo1/fNDGYd0NVfLqKW1PC
 ByP1txFRrve47aNrfjkkh3QiXexXhJ89LL+S4vce06Ri2DztvMfb4zbkSANCqtQ0YBK5
 dl/PUtqDLrJJuUEgPdx8dvIcrUyJNIOQIioWyFSyrsE3znAUFecewGMZii1T8bOeArTv
 OHlg==
X-Gm-Message-State: AFq9FYLhsrajjqKlCTquNZ+eH7ZM86sf8nYSOCfLkIewgDmB9b1OnzND
 CVYZ01LQpN8NJAOjshPaBJ5XQJjzsgLE/4GwuKD3NvLQ8eCKMzGLiVlFWgdUtpZJgIxSWJRtOv9
 Ld3dF2U74GCnQnRfBcg374ppDmB3TBpB4WuIe05gM
X-Gm-Gg: AYBFou1n25HLnwXt6+U77fRlFarA9wbHJ+rebPIqYAE7Lt8GAECLXcdyz0ALh8yqUsY
 4L1pmqmzXqzPLppKjSNluGR7SSweVuCUfGpCekQ6WIG+/0gIO3HuXmgIBCBCVeERcneBVfkWTQ/
 zXZBqUvMCb9BpA5ZndhA1tyIII3Obu36AYr+QRhNd92Eq27dzMmPBCDkRx7fivaLZ6R3PFvJTK+
 Jpi4xRSnlXnAFPdkO9sCrGkAwdyDkIJF1mLlcNhfOgdNXbhCeI2IitPPYoWA0/uHkuuQ5hySN5a
 Hc2rGBoEDezHlhtwBZNg0gONekvSX+4cTOwgV9VCk5ImgpxhbmJFFA==
X-Received: by 2002:a17:90a:da87:b0:3ab:36c4:b502 with SMTP id
 98e67ed59e1d1-3acef19656fmr6376428a91.30.1792401264037; Mon, 19 Oct 2026
 02:14:24 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:14:07 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:06:25 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-6-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-6-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:14:07 +0200
X-Gm-Features: AclHuK_qxTSlIxUMx4uXjeV3cSFHllMpiqfrJcs_8tuiAWPzRY1ud_k9rmhaOBc
Message-ID: <CAFLszTjM=OdFnSpgUb3VX-psVaHTuS=kq7+quR4tLuzmXzsFkQ@mail.gmail.com>
Subject: Re: [PATCH 06/14] video: Add video_rgb_to_colour()
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
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

Hi Petr,

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> video: Add video_rgb_to_colour()
>
> video_index_to_colour() can only produce the sixteen console colours.
>
> Split its pixel format conversion out into video_rgb_to_colour() so that
> code which wants an arbitrary colour can get a value matching the
> framebuffer format.
>
> Make video_index_to_colour() call it.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> drivers/video/video-uclass.c | 27 +++++++++++++--------------
>  include/video.h              | 13 +++++++++++++
>  2 files changed, 26 insertions(+), 14 deletions(-)

> diff --git a/include/video.h b/include/video.h
> @@ -209,8 +209,21 @@ enum colour_idx {
>   * @idx		color index (e.g. VID_YELLOW)
>   * Return:	color value
>   */
> +
>  u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx);

Stray blank line between the kernel-doc comment and the declaration;
please drop it.

Normally I try to avoid non-natural types like u8 for function
arguments, since it generally forces the compiler to do a mask on each
arg, even if the caller does the right thing: this can increase code
size.

> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> @@ -369,12 +362,18 @@ u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
>  	 * For unknown bit arrangements just support
>  	 * black and white.
>  	 */
> -	if (idx)
> +	if (r || g || b)
>  		return 0xffffff; /* white */
>
>  	return 0x000000; /* black */

Just to flag - this subtly changes the fallback: any non-zero RGB
(even (1,0,0)) now maps to white, where previously only VID_BLACK
mapped to black. It happens to still work for the existing enum
callers since colours[VID_BLACK] is all-zero, but worth a mention in
the commit message, or thresholding on brightness, so it is not a
surprise for RGB callers on unknown formats.

Regards,
Simon
