Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945D1E8304A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 04:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C8483F9A;
	Tue,  3 Feb 2026 05:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LL7EYw9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDCE83FA2; Tue,  3 Feb 2026 05:16:43 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E097C83F86
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 05:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b88455e6663so752346366b.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 20:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770092200; cv=none;
 d=google.com; s=arc-20240605;
 b=hXbFMN29xRI44GsnTzFhRRkyT6DdYmcWhGGwR3MsOOvbgdp/wmNJINr9Y7BHNjBZha
 fjPXSyY/dPuu2LTPpxalj0NivMvAAjihPWwny2gHNNb8C2TFYMO8alsRu4Uz3R60gUw+
 6N5T5Br7QjcoORJqoniNx2pAZJzm9Md2m3XexZ8Z6othOVocP+9u/JJRdp3mnF0o/hW+
 SI6btRlMRmE2XPR7teucfZBT3LtEuYGw/RP3fgw/TGlrZP+ZvdIRGa02HM6A3DGsgqqV
 iTJdnXqtknyzqTHkGOvLuHE26OFOeEF18ioA2jvlnSyKUDw8mmHVun3Gdx3rquZI1U7I
 rPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=71w1a/MC3pjPS+PPXo1EcCxwrfpoyPihvYG8yHEf/bw=;
 fh=2ZPYQRGT9oLO+iLLJws6j0JwZOTOvt1de+cWkllgftI=;
 b=QSQOQsbaMxa1jL1DM5JRerei0VamqgRnNyTvBy1SCh73nsyYSvPFpiY70EeNdJdN2v
 z0dOYR+5nGKan55U5cY5EfveeyTyDtoQ7vO0bfUG8+M8hxpgi0TP5IyCzU7uAgVKjrw2
 Zct2s2R/2/mc28cVPXsCEKKXYEDuS5ptAiw+kUuw3Jvy7BGdXm2nHZBLRGq9ELCVxzz6
 IiKNSDJxz/uKVf7yUakerVYpb2VPu0x+znjrTtXsgp02CH5MFTRtWvE+lq5+Alvws1QK
 5OxB0by3Cwf3hwhyDj9zdz/60xbbVsKNMNhr83YLxpp5oUtWz514CmZb1djEYf9sxmaP
 ufrA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770092200; x=1770697000; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=71w1a/MC3pjPS+PPXo1EcCxwrfpoyPihvYG8yHEf/bw=;
 b=LL7EYw9HiR9J8sOPl6iaL4/4vMkzEP2LiVRRUr7CfsSOsq+Wd+N1ndUgia2kGZc8Bo
 afgQ3X4aTdeY26to8sciIFhmNomfBeJjuslU18dVEuiSflJ9Xs8I7qeygnx/QPJIL1N7
 Ztvblgn51fvIVuEcXrSbe5zWgDp4sudcgsg9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770092200; x=1770697000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71w1a/MC3pjPS+PPXo1EcCxwrfpoyPihvYG8yHEf/bw=;
 b=ppcONdKcnvIjf7OXrorYakg2/pzTnn3O70Q6qPQkgy2HEnfVB1wXO4lWhKdEZojk+h
 makVe+LKGVf506fKUQjY40cr5CgC6SWw9fcbxUgtU8xnIVohziJB48YJrCDtdgmYKnHw
 qe8EP1B/jYStUgEKdeQDArGEY8XzvbKl7HZR9RwfGlq70fAfpiX0JFVKs4Qvo5luseFR
 qVsnSYXbxI092rlTScj/TG+tY1XNxSUuuoKpTm09fVokahu8rzXgt1FroMljA8PaXeKh
 BZVC409snMppmPFgUOxTlFvEhSTvkVVCB1Y1oemZLBCv6dPKStoJFwbF/VB56dlkapz1
 W23Q==
X-Gm-Message-State: AOJu0YxuzYxK096zCEwphsCiq4TPIAA30QUowHpEiCbAY5BQEyhHkYUf
 M49NkPxoB7C2OhO9lMOtcYjKZAKq9KdzBIKJfDgeKCTSylNp0FubpBJv6dZC4OiHSOdzm9d6+LM
 FrU4MS25FfQZRNI1AOH9a3/mUAz3SJdNIQKwRS/Vf
X-Gm-Gg: AZuq6aKCWWok3HOM28lqjci85qjwsLi4A7dRhL6rgK02wYYMNV5jhWd3lZaHFFQHgva
 BXDaiF7YSFBd9NKX64ygNvRfz0DKW8/9MKZPG4VCas40wYUYqEaXqEjTvad21Yk2BL9Bbzk8OsY
 E4FGKvkx+Wjp5NAX/8T/ofAr5HkR9qGfWcTx7hTk/RGSWlOREsAPp9hev7Umt69cnT/KB1YmH+t
 Bzg0O2im8HsyQalXk/LLs/XpVS0S8m+Zok+WHbPwrJl8ANDsAeAmkCINJBFu+S5EZJgIrQ=
X-Received: by 2002:a17:907:c07:b0:b8d:f859:d228 with SMTP id
 a640c23a62f3a-b8dff56f003mr818174766b.17.1770092200320; Mon, 02 Feb 2026
 20:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Feb 2026 17:16:43 +1300
X-Gm-Features: AZwV_QhzAgCcR1TUZTpIYabrkWsveZFsoSnqOqHxGhIa_pDfHUq0cEEWpIhO0yY
Message-ID: <CAFLszTi19xi0uD-Lfpgic-TE0xBnj2JgOe4x_jzZLfy_nD_uPw@mail.gmail.com>
Subject: Re: [PATCH] mkimage: fit: align DTs in external data to 8 Bytes by
 default
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Anshul Dalal <anshuld@ti.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Bryan Brattlof <bb@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yannic Moog <y.moog@phytec.de>
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

On Thu, 29 Jan 2026 at 16:55, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Unless specified otherwise using the mkimage -B n option, align
> DTs in fitImage external data to 8 Bytes, and retain alignment
> of everything else to 4 Bytes. This should fulfill the DTspec
> requirement, that DTs must be placed at 8 Byte aligned addresses,
> even for DTs that are part of fitImage with external data. For
> fitImage with embedded data, there is nothing we can do, as the
> embedded data are aligned to 4 Bytes, just like any other DT
> property.
>
> Replace fdtdec_get_child_count() counting of images with counting
> of padding using fdt_for_each_subnode(). This is much more useful,
> as the added up padding can be passed directly to calloc() when
> allocating the buffer which holds the external data. The image
> count is no longer needed.
>
> Adjust the image layouting such, that buf_ptr is incremented to
> place the next image at align_size aligned offset. This is done
> at the beginning of the loop, once the align_size for current
> image can be determined from the current image type.
>
> Update binman test to validate the new 8 Byte alignment.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Aristo Chen <jj251510319013@gmail.com>
> Cc: Beleswar Padhi <b-padhi@ti.com>
> Cc: Bryan Brattlof <bb@ti.com>
> Cc: Paul HENRYS <paul.henrys_ext@softathome.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <ravi@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
> Cc: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/ftest.py | 20 +++++++--------
>  tools/fit_image.c     | 58 ++++++++++++++++++++++++++++++++++---------
>  2 files changed, 56 insertions(+), 22 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>

This aligns binman with the new mkimage but I think that is OK.

Regards,
Simon
