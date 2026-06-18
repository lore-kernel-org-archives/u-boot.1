Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1D4CD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFC184995;
	Thu, 18 Jun 2026 17:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gpM47csg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E324F849C5; Thu, 18 Jun 2026 17:54:25 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2B384874
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so2025528a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798063; cv=none;
 d=google.com; s=arc-20240605;
 b=jsiW2UQDlJYL8wUBcB8WMDLPHdBJm7oVjJjoUioM9WyrGeFqkytQP1rOIe/Y8VPWH2
 XCVpKjVP7dCC5yZ5iTvehjnVN2cGgLtiHHLAnwigASUkvyYrSASa8iFfhWLIY/+H6mpe
 xNTT1tRqauDY9e03Qaj1NfZaMEGPKci7TiH5agm0MRri5b4Cjxc4luPqavhWxzJlh/9f
 WRUrqLP58KTopVCgs6Of5w2hgHf8sA+vZGhUNbHhY0mxTZAgJCQkT3WGkvwlfqqC3iSy
 3ZtNYaLzOePvPjRU8EDSj2/vHoqfQ8AwiSRspwwEs7rGPMTWI12od1WinVYV4VjiTJup
 csew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lUBUHwSkYvsouhdf6M6zj2mbyM9upfGHoq3dW/ZI+X4=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=avxNWv63bdeEFwjysz0qeupTbqX/GOAGgT5NcYmVYc53Jy5KylQDdW2EvgjKQ/8vpU
 woTi4xssB2kFxNtJAxI5oVyMhhh9ShkOduhXTyT0dndcNpCQyZ7IjPcZwydC/n4b191h
 dV/mQpuaCk1hF52uwvQFoT+3sSbUY4sKORTySvF9rcPMfXX3Q/VQP5KsQxprzowf7A9I
 Iw3S+evwQmuwhhTbK50DWOeDrNIxxhc7e551wgbqyH2QXuBQ4/+SjDviSDuo93jnjYPE
 5v4nfZCsxBc10URvVUljsqjQ2gpEVii1szo1vPcszXx9bKmMRukcZBETr6mkt5JZ+sXh
 Amgw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781798063; x=1782402863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lUBUHwSkYvsouhdf6M6zj2mbyM9upfGHoq3dW/ZI+X4=;
 b=gpM47csg9S5/zruhoy3ISlT9xDf6ykCqvFhlxZfE7NO+6Zg3qv6OvAMQeOR6rCRFxE
 t5OrFIwBseMH6oB8wfKBl5PBPcJRxCbLcAY3Azyg/yipBWtXghncPgul1r9MSrhclR/O
 N1mYSbliASZbqMn6SlBDpesUURasF+m5JIVQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798063; x=1782402863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lUBUHwSkYvsouhdf6M6zj2mbyM9upfGHoq3dW/ZI+X4=;
 b=Q/t81V4KfUhAVW0wH49Oqo1jQRPVPLPaoSkrmTPZUAH9Hy9u5A0Zp2ohG2Bm8r4uGT
 id0x0dKXnn2BOtGVqi+wOMGiIACpc7UGCJ5UvQ82hp0doRvboNZZz4dMHlIbojWfR/S3
 PUcDMUcQI/sLoxjyNSgOBWh7e77UwvPYCdaPpTqmtX27EORkYF0GXdyQ2EkdwY2sQ/xr
 hW+eOwSVzKH1sm3Z/LZ//t7w+N9lU4cluz4hHcYqdbtDHoQ6oI6xvqFUIrRSBRSavx4F
 wCWtJo2yYw+GPKaDbrPunw1E9TRI1L9ObRUSOTVkWozl4V22G93KbEH2CBUoIQL3zUFI
 NTQQ==
X-Gm-Message-State: AOJu0YzOudS2Tcaw0pmrMj8Ur6h07u6tnQMSLqK3ogQpkxbXiDacqtl9
 eskqJhsxhUoDB+nkmmTuHuSDVmG1JpvT150LBHqTwak+vtxhVjm7dwspfQRCMyAe34GlWSoqzKB
 wRfgX6afUdXdcUxfJrUDxPYMs/dDUK2prnUGZg5weX2xef1ETXgBw/w==
X-Gm-Gg: AfdE7cngD8epgqrgDoGla+y+bdT2/oQZbmVubEo9H3kApyKIcYB3JQ+iTvfU4QyeKF+
 EsK6H7k9rVdCyPCIsf0611ZfzGgcNdf1rPcBPAsb0JyZC0DGaEgm4EWMwgzw2s/M0XZ4FS2nbsf
 u6A/ZFUt6MEcro0dqCCeve2VVOdAOqvRGsjOjUETcMHIgtviJsBV2PP3y4tBI857HIAtpl+Haxo
 w4j4f3d8oedcHGjOX3Dpd6yH+OLBsJKu1HVs3EXfdsomN6v1WmfxAVPFlJpSLXxTr2Nir1wfk/I
 YCTaKM+z
X-Received: by 2002:a05:6402:3583:b0:67f:e9d0:d819 with SMTP id
 4fb4d7f45d1cf-695bb20f8c5mr2297470a12.22.1781798062654; Thu, 18 Jun 2026
 08:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-9-dmukhin@ford.com>
In-Reply-To: <20260605033907.1909319-9-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:54:10 +0100
X-Gm-Features: AVVi8CeAwp9rcXVUjt1gsmER_rB8rv_r65DNDQxiCos_U4Ckp1MTG8F6pVFhJsQ
Message-ID: <CAFLszTjwQc5B7GFhX3CadSA9Vwqoo1h7h0UAq1n6hcYTobaMTg@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] bootcount: gate bootcount_{inc,
 error}() behind !CONFIG_DM_BOOTCOUNT_GPT
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-05T03:38:59, None <dmukhin@ford.com> wrote:
> bootcount: gate bootcount_{inc, error}() behind !CONFIG_DM_BOOTCOUNT_GPT
>
> Autoboot calls into bootcount_inc()/bootcount_error() which rely on
> environment variable.
>
> Specifically, it may corrupt the state of a GPT-backed counter.
>
> Gate bootcount_inc()/bootcount_error() by !CONFIG_DM_BOOTCOUNT_GPT to
> compile out bootcount_store() calls on autoboot path.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> include/bootcount.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/include/bootcount.h b/include/bootcount.h
> @@ -74,7 +74,8 @@ void bootcount_store(ulong);
>   */
>  ulong bootcount_load(void);
>
> -#if defined(CONFIG_SPL_BOOTCOUNT_LIMIT) || defined(CONFIG_TPL_BOOTCOUNT_LIMIT) || defined(CONFIG_BOOTCOUNT_LIMIT)
> +#if (defined(CONFIG_SPL_BOOTCOUNT_LIMIT) || defined(CONFIG_TPL_BOOTCOUNT_LIMIT) || defined(CONFIG_BOOTCOUNT_LIMIT)) && \
> +     !defined(CONFIG_DM_BOOTCOUNT_GPT)

Hmm this needs a Kconfig solution...I don't like baking a specific
driver's symbol into the generic bootcount header - it inverts the
usual layering (the uclass header should not know about its drivers)
and it does not scale: the next backend that wants the same behaviour
has to add another '&& !defined(...)' here.

This also gates the inline helpers everywhere, not just on the
autoboot path. The SPL increment at common/spl/spl.c:792 becomes a
no-op too, as does any board code calling
bootcount_inc()/bootcount_error(). That is a much bigger behavioural
change than the subject suggests, and should be called out in the
commit message.

Instead, how about you introduce a generic Kconfig
(BOOTCOUNT_NO_INCREMENT, selected by DM_BOOTCOUNT_GPT) so the gate
stays driver-agnostic, or handle it inside bootcount_store()/the
uclass so the increment is silently dropped when the backend
implements its own semantics. What do you think?

> diff --git a/include/bootcount.h b/include/bootcount.h
> @@ -74,7 +74,8 @@ void bootcount_store(ulong);
>   */
>  ulong bootcount_load(void);
>
> -#if defined(CONFIG_SPL_BOOTCOUNT_LIMIT) || defined(CONFIG_TPL_BOOTCOUNT_LIMIT) || defined(CONFIG_BOOTCOUNT_LIMIT)
> +#if (defined(CONFIG_SPL_BOOTCOUNT_LIMIT) || defined(CONFIG_TPL_BOOTCOUNT_LIMIT) || defined(CONFIG_BOOTCOUNT_LIMIT)) && \
> +     !defined(CONFIG_DM_BOOTCOUNT_GPT)

The commit message says "may corrupt the state of a GPT-backed
counter" but does not explain why - please spell out that the top 16
bits encode structured ChromiumOS flags (priority/tries/successful),
so a plain ++ on the loaded value scrambles those fields rather than
producing a meaningful count.

Subject also has a stray space inside the brace expansion:
'bootcount_{inc, error}()' - please make it 'bootcount_{inc,error}()'
to match the body.

Regards,
Simon
