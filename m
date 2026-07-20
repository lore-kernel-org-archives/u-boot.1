Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC6CC44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 002EE80CF1;
	Mon, 20 Jul 2026 18:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OPHgzGBcXW2Q; Mon, 20 Jul 2026 18:05:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6995680B83
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570725;
	bh=+WNS/iENbjl/ULFxFtctVbmNGX1q20Pn9LwmuNO0KJ4=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=AxpXMhiraKH979VmRHncce5NvECoLlsfIG6gwise2CkiQHmKA/52fHdpewf2q+n0w
	 A+Pu3x1W2M5bYHUV7MVSCR8mpbbZfSFsV1qRJNevyljDDLVE0x1iqG6u1qQeyRzphh
	 B/JrEHzdIjMIQlVLKVPXpw4QCLiXEK9HUAMs3hNRcVhI5y0IV48VdRgRK/ocbvNTK3
	 +pwX2SDIcIQF37P8OLMmP/EElB62SqMVyDE3IYlTLaMhpe6J2iVZWHsVSc77+LD0yK
	 x1dglRotqsE1nqqxsGGp91xE8z363fGlxho7lTrIlk01/P7CelTpPUTk4DcYmsJN5C
	 TWegoIDIe0MVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6995680B83;
	Mon, 20 Jul 2026 18:05:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DE9042A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FAFF405D0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tWXXj3GhkaUx for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:05:23 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EF38E4053C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF38E4053C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF38E4053C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACDA842FC; Mon, 20 Jul 2026 20:05:21 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4879F80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:05:19 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so16747685a12.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570719; cv=none;
 d=google.com; s=arc-20260327;
 b=GG4pC2oOH4KFudZMPX4bIcPNsQK1mMZ8G74S5eoE/K+G7b9bP2BYnWfDOp397Q+fOM
 UohU85uW0HNlsBfRbNQlAYnjP2iZV5tzzN/xz73YdBR79DxwVx9tqZuzYF7ZNFM74+lx
 twnqI71VsH0NY/fupAS2PsLKsmtIKllCw9Eshhx4wmxN/qyOCJwSJb9EqsaR49zvFDtx
 tBj8a1d1veBNbyCPWwq3cvoL8pRzXlky6/+4h7oz4DcAEylLpwhJ9Hqj9Ndfu0GHDhM9
 zDT9ftf5h3ACeHopUUyGXZP/RYhxgte6OZ2gULRM4PMlENr+A3XK/7Gh4yYJuuk0/c7t
 8rqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+WNS/iENbjl/ULFxFtctVbmNGX1q20Pn9LwmuNO0KJ4=;
 fh=S5IsS0p2q/mDhy6CofKU3XdI4SX18ALJnocWEeQR4Xw=;
 b=AHkfbdZ+wcUOTZIUVLjBc+AZPvnuqUt0BAPyCLrpZHFbPdaMRFIkR7nBh2UcDOnkA6
 6vEESpHa47gXYVv4FOshGOjKaLJpkP3Gj1SuGzuShrUbhqAQE3ILtP6pw8T+6ihGY6aE
 dkGKj0kEWiKANPa3pkKDbPTOnKJBPJZKesBZeKx8wg3o16w1K+RChFPpYMJ9lH3DhU3Z
 D8I7OJyJmIRiETSZEJlVFXXFuJq4M1Y2RonPUB+VUFZ35zUJg9m8FjsOfo2h3teyRy8/
 sCD/nUMtGOn09FJJzIiL0TKzQ/6CKsuNUOuUzgtHQSbhrs5gr5hG/gr5LaibIpqnkyKZ
 dxQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570719; x=1785175519;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+WNS/iENbjl/ULFxFtctVbmNGX1q20Pn9LwmuNO0KJ4=;
 b=Lz3WgOSQlajuoJ7wVtpoYOrGHSaqlMCPLj0TXCxme4jR1+brJvLA7ZE02sXLWkZfOt
 7ZHODiTirZM0RboZblOtFDGyyBNG5dzOcR4qrPpxwlgoM5VuHEu7a6Ega55q/H/+FoBD
 pVPk5cxN8w13UGE9uf8cFOn7bdptyB5SqjEXDIeQ29vecpeG3+NTXewgmXmVp9JPCjUD
 +WdGa+uXA9RI/9v3Oo88G54G5sYWLVLYUT4PamgF6RiPMP91spCTPva4SU2PrKeVGg9+
 +ktkDBePlg2DQLPhOei2/12QugNsB7lEcKIa7X7d6Qi3zd2Kx+HInN67DU9TyA5Nrb9p
 21ig==
X-Gm-Message-State: AOJu0Yx2qJBSr/sWxprQr0o1Dv3NvIxzxvQP8vMaRArDvuncwqvOL+wt
 18JUMdQ8uXMUwS8jrxCH4od7pTxr1ys4sJtyOR4lTMH4m9uA+GwyIq61TTjd0jrsY6To1wxMDs0
 pIy6uKnvkmDIXEVF0+7/ID9BmDPERNCWXiTGvXb3t
X-Gm-Gg: AR+sD131IyPr5TcSvbcbTXztYilXHJnkuPjQfdFMaaWNHMwVEyeNa2gTuXITTai6/v9
 kL9sCak9VNe12P5Cr8dBbPzVHyuIvm/jl4xXqmXRu2+UepspRJd68JaHloacA8xfapn5wssc1+M
 vEv7WHx0m3kkuKixwIITlxAISVRIh4bFxBn8eJO/7js/oC77tmRDrqVxLQdjiKUV2s4j7VyftKy
 3ZwojaXSezn/oXisuepi/ffvXghuF4n/Rh4x26zujKLUDgPipSBW5MzdtdCHVWayNZOQGs=
X-Received: by 2002:a05:6402:388f:b0:69c:6ead:7d67 with SMTP id
 4fb4d7f45d1cf-69e652b0464mr5246581a12.22.1784570718613; Mon, 20 Jul 2026
 11:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-3-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-3-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:05:01 -0600
X-Gm-Features: AUfX_mz-GAtt6QdCeuMW-TW2ugGkqoDsyD7iP8YWvILKkF1lUURqXdiRSzesg2Y
Message-ID: <CAFLszTgMY58+DCW0OAzvxMa0NvccgWOFFLrZwVoEG+qynAFtLw@mail.gmail.com>
Subject: Re: [PATCH 3/7] rockchip: mkimage: Print boot0 and boot1 parameters
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784570719; x=1785175519; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+WNS/iENbjl/ULFxFtctVbmNGX1q20Pn9LwmuNO0KJ4=;
 b=AUF6QkUKIxHmGwFAL38iugdJBdv4cZahgVEt2NlLzI9bMx+H+Tdcd83e26iRiIv0Yl
 zCjeRTBwapNdiI13NgDJ6bId4KiNVJZ2MZcsfRFQqdDN9TgKyOjFTyOJwFk2ViLFFmVa
 w/YF+S4sKRQ2XFFxAY2g4BCgqTeHBzWEeQlXo=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AUF6QkUK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="AUF6QkUK";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 2026-07-13T10:02:41, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: mkimage: Print boot0 and boot1 parameters
>
> The v2 image format embeds boot0 and boot1 parameters, the vendor tool
> boot_merger may write these parameters based on the rkboot miniall.ini
> files.
>
> E.g. a RK3576 boot image may contain a boot1 parameter that signals
> BootROM or vendor blobs to use 1 GHz instead of the regular 24 MHz rate
> for the high precision timer.
>
> Add support for printing boot0 and boot1 parameters, e.g.:
>
>   > tools/mkimage -l rk3576_idblock_v1.09.107.img
>   Rockchip Boot Image (v2)
>   Boot1 2: 0x100
>   Image 1: 4096 @ 0x1000
>   - Load address: 0x3ffc0000
>   Image 2: 77824 @ 0x2000
>   - Load address: 0x3ff81000
>   Image 3: 262144 @ 0x15000
> [...]
>
> tools/rkcommon.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -62,6 +62,8 @@ struct image_entry {
>   * @boot_flag:       [3:0] hash type (0:none, 1:sha256, 2:sha512)
>   * @images:  images
>   * @hash:    hash or signature for header info
> + *
> + * Other fields are not used by U-Boot

This patch makes U-Boot read boot0_param and boot1_param, so they are
no longer covered by the 'Other fields' note. Please can you add
@boot0_param and @boot1_param lines to the comment, at least noting
that their meaning is defined by the vendor boot_merger tool?

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -510,6 +514,18 @@ static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
> +     for (i = 0; i < ARRAY_SIZE(hdr->boot0_param); i++) {
> +             val = le32_to_cpu(hdr->boot0_param[i]);
> +             if (val)
> +                     printf("Boot0 %d: 0x%x\n", i, val);
> +     }

Just to check, the image lines added in patch 2 use the 1-based counter
value, while these use the 0-based array index, so 'Boot1 2' in the
example output is actually the third parameter word. Is that
intentional? Using the same base for both would avoid confusion when
comparing against the vendor ini files, which number things from 1.

Regards,
Simon
