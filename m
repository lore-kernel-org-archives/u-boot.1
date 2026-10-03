Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC9CCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B02C403A7;
	Sat,  3 Oct 2026 13:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rUi_WoyXRuXE; Sat,  3 Oct 2026 13:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72D3C414C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034940;
	b=RT8NBVyoWPYwOnRbb8ErMI2pzReBa49FI565m5ACkK9vTUdxTra13LQQ8fZerD95S3bT
	 x52so3whd2CK+zkFuOTDpUvZ3wDmAii2JLy0qjp4dK3aZEQtTS/tP38cXIn6wuOpJFfva
	 6jjMwKRNynZOLILSRJvUZpmEhlQCvNBx/i+bkLHptcvGw2vwaAH+SbIGfSEt8053GmwHx
	 O+tP528oJefPWeH7Eknb5wcLC0IgbfeHfKPvUqYKY5HVOVk6a26mAEW+PoIUHxQsTnJS8
	 U+WNOdRMUpE826SRSnwr+9H2dVmFWrxzgLFvvkjymAZW9U4OMuLFQr465zpCMaoC/RQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034940;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v033LIrAb7Q/NVRdVsJxycGbLH4E2aHt8Q+JgBPmFqI=;
	b=IUcQ/qgwDzoP+Kqr/FENj4b2ZnQR8SwxomadNw0EFPCeWlkhdUMIgKZKHl9iYHSIPo17
	 eydXP0JLBKMg+j3EPT4KBpy1iHrwnPT3Zy9u2CMlIoWBpRZOPN2AiTdnvyj3CidzPOhQT
	 5rqdII4FgLTyPUlpcHH0qyVgSZWmQ5ZZFI7AfQJb+YssicEgkeFr9VuJ6eqTYz+JNuwbK
	 zSnCr/dZ5wV8gtFwPFHikf9rdvWhbaQPJcccbVKLwxT9KqgMTmQ5B18U5vXFyRHATvEj1
	 a2YlRh6NPCk81KH7ZHV9iQHjfa3p2E5IYA5IePalA3tszDnjwsRoXXxy3eIN2wP1DVw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034940;
	bh=v033LIrAb7Q/NVRdVsJxycGbLH4E2aHt8Q+JgBPmFqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H59p/enbZSFvLlNqShapSPY74NC5MwTjXPykOnCuUE6ckhxM4KoD/Sm8TuRVrNhDg
	 wH5pwATzo0dO027u1wfkQVoPh3GQN8uelAREH42sxtbA3/u+lBFIT+LJbHGysegDkN
	 13vpKLosLzJo+UHUNLWYQKGxy89GApmDO9PuiCyoV2T4I6XtKv4P6vYNMbOtcgmvPw
	 OdLlsmNQ8okh6jU1qsQ2NDternaH15VOsiOAKEWs2T8zxjcao1PU2M9FaaMd//ES/7
	 0j4UF6K9mgy56J1RhwVahPKshfQEJUJkbiDlnVTuN94mYtVkfY9S/DjZjj3JgFwqnP
	 694WqZ4B5qrmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72D3C414C0;
	Sat,  3 Oct 2026 13:42:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7CDF282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E82360675
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:42:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FC7tKwTo-0k0 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:42:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A53786069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034935;
 b=l4qxiP6tUy8087W+n5OIxFXu4VBTKe/wfdZnDailgQsJu8B4ol4WjlbKe1WfqDWsnb1Y
 FkjgbxeW9YZOT8qKwbbNixrmTHDVBKAjB1R9/MqTR0u5qcynpmflvueHRsUaLquTgdZo9
 7H7kevwzoL32FbEpKWXXjNpa/cWRfx8JQ2O/43A9s/9m7A6QVHHUayDepVifmiGck4OAL
 +eIzw2DO1mHJvPBy1FEe/ROf4OQ1UEMv1+VXlOiKa+wqP8L9akk4D9zxzZzifwJMJt03q
 5U1tFWUia57S61t95/VKfkMjgfm3zmhLKUHlIUDTJrU3TQWW4+bIpTKR2nF8AZU7W7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034935;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=v033LIrAb7Q/NVRdVsJxycGbLH4E2aHt8Q+JgBPmFqI=;
 b=Tv0Mq+LghDF+gnJCS/CykIwgbAZ8bY750TMXOTfJhGavw6GoYwHFUM1mLtPH23rSMDql
 dXhPBwnuCvkMCQohISH5DO/V/XZOIijVZhDHAnZ8qpVGC5srU2sjdaZXmIXc/x9atF+po
 vV3R/yr6R4o+E4AiST+0Tki0f3NKesH5MyE+glonGEwo49K5KmJ+eF0n79X1Iws5UpbpU
 dWHzYP5TCX/MdSf5qtrFVzmzOcnMxfaBkrBKuEdTLHB3/d4CguJidMgf2qoDH9nPH4Xln
 /WgeV9cAyjiTLnMcG0gZX33UGwarGDcphcssTfuyxyaBrErZstTNX2PCHOXZBAdo6Nw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LJPANTiO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LJPANTiO
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A53786069B
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:42:14 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb91ecaccso665285a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034932; cv=none;
 d=google.com; s=arc-20260327;
 b=IG1KDejAUE7N1rdkLdfJtETAwyye3oOzuIr+GFDrX4aRXnB9Vpr4XUkBhmJI0I8Lmx
 ZXE9qaniGka6KbM8MquR8Y2NzfFfM/+O1QuPijSZ11OEtCrEJ0dzjFaIbfsFezApMYBd
 bXZz0z6nEUgrzs4Sqb3uYrfwO2FBQuZFjzvxq6BfO7Uz40MCZZu/M02Ej9Jzr4WFJUhd
 HPaxLsczWgFESVqduFgxMnAJHAxuByyJO2lmy4ogkusxFrtfYCDGzApidHb0AUVLnER4
 sW422n4MUdrn0eOpLvh/2FPEp/HCkG1il4odrlJz0XZAWTQAvkNHsxx5kJcKo99QBeZo
 FHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v033LIrAb7Q/NVRdVsJxycGbLH4E2aHt8Q+JgBPmFqI=;
 fh=DRMAGgHoPax3R1r6Pn28XA3dtWVqztZPwpEzfTF4Rao=;
 b=EKgcDbzWP8kt77aBX/l6pPcQKcJEhiMTINGkuBZWTW/5wjagxoOa6OM64RI7guSTw5
 FgQCc0gdmqQYLlcKzFu9aMUeVnMdEXE2A1G0+VFRBIKfUySXVZ9N8ixRXObcxEnGgodT
 rvcJZQ2g9hJeUYrF3ZEpnCItrzioK/zZFvBpFNPJ4gmFT1GF7d/rcKkXbJU6WiGUeQMw
 Bv/0kiF/jhglu/NPU1TgXL3evn3XzDLbZjdiIX2oeUQ/ktmRYtnm59XgQGscxZfbN2hh
 kQj/8BpogTxhMluYyi0m0p/HX3l2MiaZWLDTJKLm4k+pP6L+Vb1ck7QwrQH4ZlXltrvu
 hoJg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034932; x=1791639732;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v033LIrAb7Q/NVRdVsJxycGbLH4E2aHt8Q+JgBPmFqI=;
 b=LJPANTiOMCOJvact+HTiu093CLsYKWrJ44SuErwseTbHVO0icZpgubToKZ5NuAvEAy
 wyNbu2p9pbSVVnNuzKJPH9nvR8w9HvjAVBENaxS0RHW2h6hOA+VENRfrPEc19yBAoPvV
 0JmdlHjiwpdzUwDnYf1ZyPksGw5Y7zs/tw+YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034932; x=1791639732;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v033LIrAb7Q/NVRdVsJxycGbLH4E2aHt8Q+JgBPmFqI=;
 b=oGzySpLAVDJefvY0Jr8hBfu33fYn+/s107jmlv+vWSTzd0tOSOMLZUCkWb2xWjZS3Y
 LJ8QXulzbzifvp85gjwmzuAIP2O328r3W2o6oVoIlCKFqbWv1u77vMmo1NTqsV3iz3Ik
 ScYIJFAGX9yIpVZm05zwZyez1g7jGjAVaFhq8pZKX/QxJ9DL8GvAkFpfLJgogGM+B7vb
 86+aZok2sYkGWeyID+PuiOQKblREsJj8aDBr5VMGvMHUP9geBwXYH23q6uqqfMhQMta2
 peZfAz2nkM3036LSPOcXiIYfS5cdTk7bGNfxjCAANz3i7IxZuRwfuh5qyh0/EyVtnv/6
 CGYg==
X-Gm-Message-State: AFq9FYIlJTs7cN2Jw2l6RtHCaoOgycabMPBXXaBBrI0X+BnTF7NZ6O9v
 oES95Q2v91FCy+NAaoskaQSRtI4qB48fbhQNTqaVYbPWm9DG6n58uY92uBgmMk5CX3zzht8DKLH
 wO0uKtXsneMtskuB2yokJWm3Y9gQJbYkJkpHn9m4N
X-Gm-Gg: AYBFou11ZpUte52Himx3En+9WNobRbT8b9JflNfHwxnw0CDxTE1OkGA3ZHo91D76/gI
 j7Im0idcuMbo+7zMeoR/juUSFPt4aYReIOL97eIK11deD7qN3nsxMUW/vD4Qqi5jRI4xmO9p/EQ
 hA0xgDVx0aiuKF60xJHCWeY9SFKmocodWQ3INqcNp2nMt/Rm/J94gm4sUt/oqbF/ZU4xSvBbuze
 k6OL1eWKwVZaF+l/b9gDexfIGu++do8/rDM+TcKJj0QiuB7l9hblsoFFrJLPFVnui4zOg48Y26B
 OCy04+Y+PL+RVJMG/FblPN6+HViS1aw7pygTrGA6YphJGXZhzFtM2hTDR/FFaZLSMg==
X-Received: by 2002:a05:6402:3253:b0:6aa:9866:551f with SMTP id
 4fb4d7f45d1cf-6af9e3821e3mr3599070a12.45.1791034932288; Sat, 03 Oct 2026
 06:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:41:59 +0100
X-Gm-Features: AclHuK_BkfmmWMsAiYG3a6XaMLAW_7294IzU_MbD96jXCnBdqAhGujRHJTJIbUY
Message-ID: <CAFLszTh0J3-hKCAKgAzKp80wptwHGx2Gd9f6omFJ_er-uaetBA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] spl: fit: Decompress any supported algorithm
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
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

Hi Alexey,

On 2026-09-18T10:52:27, Alexey Charkov <alchark@flipper.net> wrote:
> spl: fit: Decompress any supported algorithm
>
> load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
> with any of the other five algorithms image_decomp() implements is

I count four others (bzip2, lzo, lz4 and zstd), and bzip2 is still not
reachable here since SPL_BZIP2 does not select SPL_DECOMPRESSION

> silently copied to its load address without decompression and jumped into,
> causing a hang with nothing on the console to aid debugging.
>
> Call image_decomp() instead, which can handle all compression algorigthms
> enabled in the config, and will abort on an unknown one instead of trying
> to silently jump into it.

'algorithms'

This only holds when the phase has at least one decompressor enabled.
Without CONFIG_IS_ENABLED(DECOMPRESSION) the 'compression' property is
never read, so image_comp stays at IH_COMP_NONE and a compressed image
is still copied and jumped into with nothing on the console. Please
can you mention that limitation here? Another option would be to check
the property in that case and fail if it is anything other than
'none', although that costs a little code size. What do you think?

>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> common/spl/spl_fit.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -429,25 +427,18 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> +             load_ptr = map_sysmem(load_addr, max_size);
> +             if (image_decomp(image_comp, load_addr, (ulong)src, type,
> +                              load_ptr, src, length, max_size, &load_end)) {

The old code passed CONFIG_SYS_BOOTM_LEN as the output limit for both
gzip and lzma, regardless of the caller. With max_size, a compressed
overlay is now limited to CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
rather than being able to run off the end of the heap buffer. That is
a good fix, but it is a behaviour change which the commit message does
not mention. Please can you add a sentence about it?

The image_start parameter is an address, not a pointer, and src is a
host pointer on sandbox. It is only used to decide whether to print
'XIP' for the uncompressed case, so it has no effect here. Please can
you use map_to_sysmem(src), or just pass 0 as the old code did?

Regards,
Simon
