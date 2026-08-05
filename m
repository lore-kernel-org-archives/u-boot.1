Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1D8C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 21:48:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29AC7607F0;
	Wed,  5 Aug 2026 21:48:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC5Hf3KkjJ0k; Wed,  5 Aug 2026 21:48:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51592607E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785966508;
	bh=nnIcoO7o9kUAxHVZEwsPKaXG92J/LF+Pf6/M3oiiDJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZupbNam+JsxG15Zb8W0WEiL8g9ln5J+NU/Fw2NyJr6R09gLcdVT2AhNsjcEwzBc3z
	 qoLNacTrcDztXFi+SLCBh+hlQ15JcTRreWiUZ44VNq4pMm4UDc38KETMMMAwJCoMvl
	 ShpRoBzca2dnTr2ZDfXKlU9Fc3/cnsModLIVGuFDTfA7/AjpLD4tdVsbXiql4SE70W
	 cRZdtrYuZ9wExQU0Xbw4Y7AeYDhrmSsIj3pvy/+jG4vNu9x2hk7Cv1eLqjw1NU3Y1e
	 P/nGhm5TqRa2LJlRPXbiK47ZrY/7NcnVu4kMDZUodAW/RRXQIpB2PbCSaPV02+8n8f
	 uRYQ8tHirpfLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51592607E8;
	Wed,  5 Aug 2026 21:48:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6155210E
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52DF780DF3
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:48:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xEcuLBw-JOst for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 21:48:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5528D80DE8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5528D80DE8
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5528D80DE8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 21:48:26 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a10b20634fso2652357a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 14:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785966504; cv=none;
 d=google.com; s=arc-20260327;
 b=WB9m216Un2UkSiITgi7ia/KfxYBw1QvB2RHshU8GYPx8glrBDNqn1vazFBgMoiLGtE
 G2EV6AGItJ5ahzjWO+fDh4CAZbgPox+avdf/l0lKIliYv5VWJY25VRHxXt8z0GP8MnC9
 Ya6QcWxP7eTbLFcTMuFNWwgn7z/rJOPZkswjBcwkGPvWrKWvhNQY9Q4y4s46HJ/zCaP7
 TrkeDuCjcU/f/xGDWUT+kmV8nx3x+ff3qVKCVZeSnPTjBCHogojSVtcYfdAOM76qq0Ul
 WoIx6QxoWdfZRnJVAOViDJI5UVX97YZKw9EgzbZYwZNXlgcmco33/k8NXAak5zjohMv4
 1e7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nnIcoO7o9kUAxHVZEwsPKaXG92J/LF+Pf6/M3oiiDJY=;
 fh=eybldZBXeZ25kcSUWgn0EFj7euTPyUYAWUYWgJkJ5MY=;
 b=XrZaWVHRa9yyHnbOovI9YxsnTBIK7OlSqqpukvD6aYhG7Ce4gY9+l9mDUS9Tf+DVvI
 BC6OuuXMIFKWXBYVc2c9StQWzo+hYEcEy9ZuAUQnSMmITApqBR9tZr0rWF0+U3lRMLMW
 tfHtrGU1MoKDgzOV6uW/LFE8v/+ZG98bZ3tJiw3ow/LLyHFo+Z41zH1b5bqHu2LCO/Ml
 TILio7oDbhx82mI08D8b+b3rJBnpwpKU1p+w3hB7EbqEelxDNrV6rY5Vp1fDk0e0n8JO
 NY/qyN925SfRy4v3jUi+645qXSRljQk3IRS3Kfme0upCEMjsYEucw7LZRykpVEwtS2Vi
 6W0w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785966504; x=1786571304;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nnIcoO7o9kUAxHVZEwsPKaXG92J/LF+Pf6/M3oiiDJY=;
 b=F1qtUX9h9CEOWt36LCwj3bYTR78rP8R421m7gf3x0TVAuICcQOHFGg81tVPaQSnSCD
 o8fLt7kPffUm5HB708WXK5bxazwjlYfD6ntDKNMgD6MmCUE3ysAvUw/UYGHipU/xCLMg
 9LQTSHJy4OMujBbNNrTEvnrACEOz4mWkop0DcJOMBqPLh1DE3aUPuvtdOKFIBt9oN6xu
 9BigRZVNgALTqAU24lgtRZlO4QlctsGOwRcl+v5A45xiISjHIuGsOtKqTHHV9VI4U1bX
 gsvT60t6Uq4/w8bNqrU05fVIRF/BJkNxbGBK2w1rr8yaKZY1DMRzFE9MnnIYNwU1VwCR
 aHYQ==
X-Gm-Message-State: AOJu0YwNL2t/10IA6R1Z9T5LmH5vIXa6WPQXLT9A7en1zTu39aeHSmNc
 LGkTUgRm+TfsdwpYnwOy4e5/V9k2B4tNES1SQ1Gj3otqIMcNb/SoLrr8hmIXyLyqKuYCNdsFEKV
 p7k0J0Ykusxnq0dXYcflKKkduAE5cb3ucua1BLVN2r3QqjKx40BE=
X-Gm-Gg: AR+sD10G4+PJpqOXmf7lWxuyjvkfRzXeTz7lX4f/2RD9R2C82M6lBTpwyzqMR5jbRsa
 Jf1CHqmPto7nnQ083pPM0Nq7gK1XGIc/6KsyqL/1wqCpa3BeV9hT+roj1m0ezVNMeyk6HMsDrpc
 QD+N3FlO6NxQP1v7eZaazjjiEAYm1UCv7GIFdFrW1BZ1ivW0lrBrh4Sfx+McjZgZKo8ztYclEJ1
 grkhVrimoHbh1kQmObVhp77JuPGCkAMlPknK34UDaY1HoaTh+I2oC1w5gYm65h//TvRkEpPRAl5
 S3UeREm68b9a3rtvnp0mKeUJLPdX2H6ozUsE706TnXs=
X-Received: by 2002:a05:6402:3908:b0:698:ac8a:9a21 with SMTP id
 4fb4d7f45d1cf-6a14f0db241mr5405900a12.8.1785966504390; Wed, 05 Aug 2026
 14:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-b4-fit-ext-data-hardening-v1-0-4a6b91e37b51@binarly.io>
 <20260730-b4-fit-ext-data-hardening-v1-1-4a6b91e37b51@binarly.io>
In-Reply-To: <20260730-b4-fit-ext-data-hardening-v1-1-4a6b91e37b51@binarly.io>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 15:48:11 -0600
X-Gm-Features: AUfX_mxOBr05pF6_nzS4ATAlbTsGsEkafHpb9hRYUKr8KKXHtonNr2L4awIFcrQ
Message-ID: <CAFLszTgGaZXByhcy-SYEYZ7=aPv9iZhGJ0c+rfr-54GpzUNuHg@mail.gmail.com>
Subject: Re: [PATCH 1/4] image-fit: Use unsigned types for external data
 properties
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Francesco Valla <francesco@valla.it>, 
 Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 Binarly Research <vr@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785966504; x=1786571304;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nnIcoO7o9kUAxHVZEwsPKaXG92J/LF+Pf6/M3oiiDJY=;
 b=ZIElPWQ6WH4AlrC2kTTaZeugYbqIfFMchelfixmoxda/zH7rxkI7+CMqe3h2EC/3m4
 R5pYHRm5zmnbswaFqcHVr+xBa69xxDKWfGCLhsjqk6Zg+3K67j/Pei0SF4tXMXZT5fzI
 0AZKT4yeY07Wx+nYjCM3MzZbbsp1yZ3Z6ubpo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZIElPWQ6
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-30T15:03:40, Anton Ivanov <anton@binarly.io> wrote:
> image-fit: Use unsigned types for external data properties
>
> The data-offset, data-position and data-size FIT properties are
> stored as 32-bit unsigned values (fdt32_t), but the accessors
> fit_image_get_data_offset(), fit_image_get_data_position() and
> fit_image_get_data_size() return them through a signed int.
>
> Switch the accessors and their callers to u32. This removes the
> special-processing of "negative" values in fit_image_get_data().
>
> Signed-off-by: Anton Ivanov <anton@binarly.io>
>
> boot/image-fit.c               | 29 ++++++++++-------------------
>  common/spl/spl_fit.c           |  4 ++--
>  common/splash_source.c         |  2 +-
>  drivers/fpga/socfpga_arria10.c |  3 ++-
>  include/image.h                |  6 +++---
>  test/py/tests/test_vboot.py    |  6 +-----
>  6 files changed, 19 insertions(+), 31 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
