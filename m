Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CE4FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B13884653;
	Mon,  4 May 2026 14:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gqUCJVhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8344C84653; Mon,  4 May 2026 14:26:48 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98618460E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bc1f3a393c0so122625666b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897605; cv=none;
 d=google.com; s=arc-20240605;
 b=Eoi5F449YwkK2HBWFSdrVlwLP0WwENx7L8rHhfCCRcjvZMd89XB5WXdVB9B1REkJwn
 mzBBuJc4SC4f4Src6sfGANI+cqRsjggiaFJ4zjpRL9UN28zyIdnVAJWo1PDD2lQ30fn+
 aIFwZPkxWY8kukodctYLoNOVCoypdvI6ICv5IdqGX5XHfXsyvtMfRPB9bzhot9FNFLbx
 N9rHbrqJBbsmN+frPjMwz3sg2fVmd/xaoQBZVeBJMQByFC74GUYgdC2RwHRDrfN94TEU
 bsmYmeQg7tFLHJ5Ou+XW6r75QAXYjiwhbeEFZcHZAqThMly23VoqzdCBGxFDDvQyvu+h
 yGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1wry64X98SG9xBAVJxGV42uImgP+yFw1rM4aKsQC8jQ=;
 fh=q+RyNJz05f8xqSoXvECEUnU4L9LdvVSuO3nmPEsLaQ0=;
 b=PKt6ABI2WbzFw182kd5YP0nEbrY7dNj9xCU3o00H+UtU+bF3WiFHLHQ1PIkVuTtInb
 ze6yjB/289uYqztj+eOpHciBpilbhPPch9qDKHZNCjv5vx1rDvRjSV1Jm4FjE6RjTsfR
 Whtwt4KbLJYmwPuj4I0Uk2f1EYifutp2l7buaG9pGFhZRAzQv8y31fGTJgOtOZn+wkv1
 E/ItC/LEWehkx4wZXXLjFWPbvQLJAD//psSrQNNVJDvv4elHfEWkskVJxYsKv2Nie6/m
 Ltj2MxmWhja9vhuhhvD534DlOBdpQTzP8msa53+a84VQdfAvK40YnAt/YLzZfnSgSqJi
 ftCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897605; x=1778502405; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wry64X98SG9xBAVJxGV42uImgP+yFw1rM4aKsQC8jQ=;
 b=gqUCJVhsoYTWgpugp0Zjs0ZBlUWb595WBbsO7S/ANyN1RUPlCRFtJvEVx+Bd/d+8Vu
 roFhkKWT7vxbPVV0xdkdvrKUNPhljxcCESExPkDMfhw+azdnatMutgpKcqLF8nvh7IJL
 9gQG3o/zUOSaEDVDm5LPrVvhD6SFDpLPBKEF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897605; x=1778502405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1wry64X98SG9xBAVJxGV42uImgP+yFw1rM4aKsQC8jQ=;
 b=Kcfb+fE6WXvMNua11LwVVdy3VzBLsv806WcDFCXsUKFYKk+Fh7bXAiPVi3g/kTQYDA
 fFRV+EFSIITrhrxT9trpLrd9XWblSG2gdMR0aCgx4UhNORLCkJcjvHCi7zh9srym803W
 /s32IuCuKyAHYz18PVpH8OW1eXSBFQ6+A78ctkZJIK+yYaXymhMM55ApLK30iz6OIZcA
 Xs5UIduDvbJaxce6CJg+l6aF1x70Vzdj9Gm8/M48SKEm5i2Tt2fcL7IUUwUiIJ1DkFxO
 b2uld/NqmX/ONqTD4RW3C1o6co6eqWqqoAXuy9+bxW1/aNC/N1N5NR285MVvZHXwYJf/
 Wtaw==
X-Gm-Message-State: AOJu0YwYo97plnVvZjwVQMHw84fxWIwgEklP/4tzCzOpfUrYmYZ9kdk5
 7uo4rXSHHOe9YA7Of2J8OtWggUiHDll7cvcVp19/gjExirYjsxLJFwEvVd0ESGs7sZcgWwAhY9j
 A8p+dDuSoUtNiY4gPOt3Dph4ahCh44CcTAqJvs+qU
X-Gm-Gg: AeBDiesVWKeFf/rXTi9TNNi+qLDB2bPfTuPA40JCgaUy4Zxth24FMfgn8toKGu2okAm
 c6BbkbSu3ZtmG/222inTwY1Ceb9aFn2CfwIowE70P+1og5hpFrHEIygz7GcbFzcqOxAOG6zhpJf
 kjiM1Ajw8EnmaGdcFqehrkHeW361LRrRlgihP/IhcYFEia3Uqbk4AD651iYtOtrMoHoT22zvXHk
 ulVr0xqqSsHODQ9ax4fPlR3ag0cM3bl1sT7GqrukkN5ElUSDIQ5nT78ZKLAcAxXuncXNaefTKN3
 37x7vpYZwbEQhhLU
X-Received: by 2002:a17:907:198c:b0:b98:40a3:aa0c with SMTP id
 a640c23a62f3a-bbffb2403e8mr489332466b.24.1777897605373; Mon, 04 May 2026
 05:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
 <20260430142602.v2.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20260430142602.v2.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:26:31 -0600
X-Gm-Features: AVHnY4Kkm8wFpvSgMKgVVlORWVZzoQ-3nUztm28RY6Vjd1Pt6gFbJDJbMlqfB6s
Message-ID: <CAFLszThoExQG6KrP0oo9tZ2oC35zzbX9wL8=7PypqVPDKXFEnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mkimage: define log_err and log_info
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ludwig,

On 2026-04-30T12:25:59, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> mkimage: define log_err and log_info
>
> Define log_err an log_info centrally in mkimage.h so any file used
> in this context benefits from it.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/image-pre-load.c | 3 ---
>  tools/mkimage.h       | 2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)

> diff --git a/tools/mkimage.h b/tools/mkimage.h
> @@ -31,6 +31,8 @@
>  #endif /* MKIMAGE_DEBUG */
>
>  #define log_debug(fmt, args...)      debug(fmt, ##args)
> +#define log_info(fmt, args...)       printf(fmt, ##args)
> +#define log_err(fmt, args...)        fprintf(stderr, fmt, ##args)

This is not purely a refactor: the previous local log_err() in
image-pre-load.c went to stdout via printf(), and you are switching it
to stderr. Makes sense, but please mention it in the commit message.

For motivation, this is preparation for patch 3, which adds log_err()
calls in image-fit-sig.c that need to compile under USE_HOSTCC. Please
say so.

The commit message has a typo: "Define log_err an log_info" =E2=80=94 shoul=
d be "and".

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
