Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B61CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B4184D7B;
	Fri,  8 May 2026 18:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nkePUJhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3010F84D42; Fri,  8 May 2026 18:33:39 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB4984D78
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so594249066b.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:33:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778258017; cv=none;
 d=google.com; s=arc-20240605;
 b=bRBOSSXQZNuvWhVIiCgs7W91L+SX4OCcHXjMsK0UmQsfSxnT2169S3WY5cV1UFLViQ
 OGIlZ2xoJVwtf7WLxWx6vn1pNmfHbM5/PJ5usYjZOj6s9kLQ/ddTnZhteL+rD0+MWz1l
 5z4FIqfTTQ3okD7XR4vEBatWbMLKtjXzzcrDm8Gpam89xNifedLgfRqvRpw+hdz9ugtR
 xyuLHGtonesi8QKNz87NA5iD+SHvs28k8x5kFllApf/2cuqZcdPwj+UmZY56a9C7VmV6
 kEM+DDtSRxB1tsZlmav2N7okjsjMkGhX4Fhhf0nkrUsAy3tvdz0wKZLcc6CgBhE1HPPE
 mV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0PkGsawUUGXHiY6Phb/qozsCQwmHS3zLiUHFak+L+qc=;
 fh=GETRS1CKTSz/04fIYgf0Ua1FO2AxjHyW2hfTpOuNdVA=;
 b=RI6nTTmNZKt+JAXBtWRQlkHNLgKcxHu1Y1JtV7JGMzr0nZKxbz3Xa172MpW4kjKGBm
 9CVjwbgcYymH4d78mC7aimIE/wiRkD1I/PSboXqCPxqCTH5LqD1kxRrPsVPplRqTd6xY
 ZyJknaFmIS/5p3YCZuV9Kd7bvutM2eS6mSMz5Xc0LVeSdVitgSR4s4HxjQQdVHtQbnoL
 nmfCoSTIc6hPwCWs2rdpqdla/vX8MI/6LFFgYSu62JqVaA5hs3yGcwgWs5RuNQtU9GbD
 Ay9qidY3WRF4yRVCjJCIWersmvbhbUmefPj9h3t5/2muX5eb0kE53IWCT2tKNycq+Fyd
 l0CA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778258017; x=1778862817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0PkGsawUUGXHiY6Phb/qozsCQwmHS3zLiUHFak+L+qc=;
 b=nkePUJhfYgnun8CRL9/CA1k2HY6MsSKUmECjWzMMEYZPBQ04jj1BHfZujO9pLsB8DU
 iYCQe63SxRGvk7iumgsUfU8kxrdCy3aAdLrPTPK3pHIcvM0aJYny4ABsDmLfv6uCVPgJ
 bhRr+qwDncVl+73GErjsDOXo6wA9F68GYmVTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778258017; x=1778862817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PkGsawUUGXHiY6Phb/qozsCQwmHS3zLiUHFak+L+qc=;
 b=KU9Mb2fvPoGTO2EvOIJ3lv8o89IznGJQWeWANmpH1NDzoVWnltJsBlo8W4hGmH38Mi
 2E1phY2xQXbu9ZaeU9IbaETiqbLCn/5/kBglsx6KFxEVZ1sqIFELdN7xd9ON/2FJ7Qyv
 xqxgnZxK9S1mBET60CfDJVVTjKxqJAGdBDeHqwZiMbJNdNzjPN7icj22eInNpDJQ9U9t
 0zE2zPLbbquZV95I/E7TnDyN8284vcIgqIh/kTTDGKVXEEFAjSafpuByfOF3yjDR1wn6
 IGxWV3YalufCsAowBGU5KzRuBCBIDAhle7hmFVTreSGh0gu9fijTGocShDpdG8DKjB+g
 buxA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8glAYIL0uULMPpakRb3DFVHnFvaZw414eSPgBrxB6HVPFnolZXowi2OLv8jM3Mh9czFXQs4LU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7M+XVBHgxIJ3VbrFDTDJHzCJsKTAkZ+6EoGGgub+eHk/U/4sI
 eqkUubQyTj8RtbCvt7rLb1Ym/FI42bB63MxMCKeLugScRY+GgYZ3y00gK9iEYQJuwvdW5McLPeL
 Fx4aAWr+KJ0pFmTyq94Gh/JO0DCn2W4NKyKQzKYSj
X-Gm-Gg: Acq92OEGf44aT2cfynzp48UmSV97Gn4FROJ0XdmUsa6dUZtjnifV98rd7zHRiDxSx6Y
 Noit5QgrJnezv2o78iDTUrGx0DDrt7B7JTMO2D/3Vzhdryh1qaNlnWKHmRMoPpUEyIYjwN/pPvq
 sO19fCY1XtluDuzKjscZqIB4nbTFk+15pm5vowrtGS3X03mtlnDRciqBEVDvA4Wsq0T0/zqrhvC
 54pYLmBBw6deKlaGWcJzUhd+ZhoktB9V44qy40WEWb1gU3fhV18QajmSby+pW+H5of6tFRADEDz
 cU765+/8eKgrmp0Z
X-Received: by 2002:a17:906:39a:b0:bcb:b15f:14a1 with SMTP id
 a640c23a62f3a-bcbb15f2430mr19177266b.7.1778258016679; Fri, 08 May 2026
 09:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260507-doc-sysreset-qcom-v2-0-37fef7a9cf92@cherry.de>
 <20260507-doc-sysreset-qcom-v2-2-37fef7a9cf92@cherry.de>
In-Reply-To: <20260507-doc-sysreset-qcom-v2-2-37fef7a9cf92@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:33:19 -0600
X-Gm-Features: AVHnY4I6yjdPlnlf6dnjvIqX9R2b0LANqOaNPnmc--Kca9zy-7CtVsdWgeQlGlM
Message-ID: <CAFLszTjMQdT5ou5P3RirwXdFmLAiY9T++XokNSx26C7pYY5w=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] doc: usage: cmd: reset: fix typo
To: foss+uboot@0leil.net
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-07T15:04:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
> doc: usage: cmd: reset: fix typo
>
> "Do warm WARM" doesn't mean anything, I'm assuming the intent was to say
> "Do WARM reset" so reword.
>
> Fixes: 34e452dd0252 ("doc: usage: Group all shell command docs into cmd/ sub-directory")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> doc/usage/cmd/reset.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
