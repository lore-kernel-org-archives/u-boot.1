Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013A3C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 17:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7AC34085B;
	Thu,  6 Aug 2026 17:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8H2antQ1Yrc; Thu,  6 Aug 2026 17:01:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81A9F4047C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786035707;
	bh=Fat5Woy5aOHMAFOx8yIdjSZ6pGWFCFb0GcoZuVtHmpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OYRjZDdW8Pp7Kp1wNN/PGYXLRy1S5xTSioTAV24QGzD/f84rNfZaANCNRvlE79lOh
	 BlH9E19PmJYE2QeifZKIed70cQu1qMFn/dqe73H0auEBocj+yiWa15SnkFzNEIH7b9
	 /R8gduc50LqndnEz4rx58lIMkfuiCVwVHcJiqMJ/+X7QOJ3P7WGUrPKCRufz9vI9jn
	 oCFRn9mERQNePgz9OZR1zm5tVBEWogBVcFcPyRV7p2x1R1TTD834kCbn/kOuzMSDbu
	 hcrnwPUCQhYEqKD/SCt0BgbHE577pD+L/qa7a9uXAsSO9TU04rvyZJQ7WYyza62WpL
	 2stLWnfIBnxPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81A9F4047C;
	Thu,  6 Aug 2026 17:01:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 101102B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA02180EE6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1__ilFhzJFV for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 17:01:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DEAE380EBF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DEAE380EBF
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DEAE380EBF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:01:45 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a8d251so3336787a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 10:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786035704; cv=none;
 d=google.com; s=arc-20260327;
 b=VveRTZ0dq6hM7FuhDONvYWEgV3R1xBUI6qzHqfkUgpfGzyUUFvAufSp47/7g9SUNV7
 1oh2dhrlxL+zSNuQkEpYFzWhDy1Hw1yQw5TrORbRrFtnAQ7WPozhbm/OgMincHm9DZzb
 TjRIcFm+SL6zkEuAerPFjHCbBosSKnuyNQUhPDZsa6RMugO6FXc5fQHWvASYv8yRmFGB
 X00juHdyCFh2KUC+bV1cR0zsJ73tx7xTFlSS57RIQc4d9yH2aLfQ72NYwEfIOt4ypFv+
 Kbs8HTwHpUZ1KP/UkEyG/0727XMBdAr3t873Y0MrWzXKXER93k6WD48NtMBQTjXDuvGx
 Fv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fat5Woy5aOHMAFOx8yIdjSZ6pGWFCFb0GcoZuVtHmpQ=;
 fh=nYjmZNcNBXjFNBQa2yYx09l5MGyiI3+DRBipPcPatTY=;
 b=QTsVupjgijOORmMnAL12Tpjt6DIgGGjOWDGupl23Pdc4Dsay73IGviPLdIyN/eE/VD
 9EOzs4G0Ry8/IAKvY3ZOeZh5AEo++0OEwZ5dAfSaTGMLcA7tYC87uZ+nkJefjSidd9X3
 Is87xxR84TkmwhkQWVLgojReV4MC/1IT/7/Ztn8ydvTYHDyGPCuQzUV53dO5GM8AYZRk
 NXBfScOvkv8/XVlrsYCLKm4mxqbP+V3Bhieh5e1HP86nKPsGOkMuH58g4vdfyjcX69vY
 XCZv8l2KEFa+RINJwt2+5okfz/vmY2AWR0Qm3P4pMXdUKHYx0lWpn65kOgDfLyNSoZ7l
 06OA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035704; x=1786640504;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fat5Woy5aOHMAFOx8yIdjSZ6pGWFCFb0GcoZuVtHmpQ=;
 b=rJOR7tLa2UEs+llE0WWz/yG4wO1uFYGjgZnZufu5w9+8SDvfqj30V0ifkk/7Pnufsl
 CiHEDVRacp7J+QswrH1mmGY1qJ5lfC6M6YzQVxBgImVrvOkCxAkHqqZhjXcxKlaMeFy8
 yrKOk2qjak0HRkZoy5lnGSIt+2lHbXoYUm42BhdIQWD4FDcmm65P4W3abUIhOluwOgOW
 3r7vqMlzjx/qqrS0dYbm2XAZ5CUE5MkT+QCIea2suL4JUHTMXbcQ5MOvLX2403yiOsF+
 +CJRLwjvFl9a5QcIQaDFqmVV8hUa9b6MFrZgX8jiG53W1i5Qdmuq0QvNQncRXXU3r42U
 VZWA==
X-Gm-Message-State: AOJu0Yxzohls40h7ABs3ZOGQRrXDn2lW6AKy14b0XBaInWAV12HSkwcc
 M4cg3/vnXKKNz91MPN/KhgZDbH69QrlrwIv1pbCcon8abXnaKPGU2dycTARpIfLEzt35wrJ6ygf
 mOQwdAbb5iL/aI2GsWm1QArVDQwrNVGbaHBHovBzm
X-Gm-Gg: AR+sD11z4Bh88MnxB/V9SGs2k/JCf0Ln6yvWOEPu9zq/KJwuJtFMYUXfFZgvp3zP/G8
 UgWQiiS/yp6UtigJmXfm/slyCr3rMe0AJfwVAcUcQs3STGmydHrfjk4jwrkpaejzQqqtAactRuK
 J47jOUP76YTAk5XVrLBz3/221zIe9g+LlKR/YYUKi4QrdOD0hNb43eXhsbXs69hLII3BzVvPcwh
 8zzReQTc6J5Jmj6QIVzmw3FXXCel0Z0cP475VRznLRytvt+AE/6hsuD/Cc8ru/9oPlrTFmjHYj0
 idQFyX2ledkcHF6HApsCMvK/AXrvRd6TpkwrVOX15Vk=
X-Received: by 2002:a05:6402:52cb:b0:6a1:b4ff:b755 with SMTP id
 4fb4d7f45d1cf-6a1b4ffc544mr1511363a12.5.1786035703810; Thu, 06 Aug 2026
 10:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
 <20260806-improve-logging-on-missing-uclass-v1-1-d477f0054f48@baylibre.com>
In-Reply-To: <20260806-improve-logging-on-missing-uclass-v1-1-d477f0054f48@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 11:01:32 -0600
X-Gm-Features: AUfX_mxvdxmd99a9JCuSluEASoMH2FQOs-uSenBkWoQYH5LIfws-baT6CuWqm8s
Message-ID: <CAFLszTiW7wZf_TUf-1hjkMGLaEd8GJ1QjUSe4dQugW2aDdOY4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: improve logging for missing uclass
To: jstephan@baylibre.com
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786035704; x=1786640504;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fat5Woy5aOHMAFOx8yIdjSZ6pGWFCFb0GcoZuVtHmpQ=;
 b=TPkfmyEgFbLQAd1zwVO0RetCsOAd0X6F9fMErNZUSrjyTPxcHGWOXy3yP/+HbabauU
 pgFtz9BkVh1anF3XQ06CfjYuSaVMwh4FDClS5FvirBUhWxDWswA9tUMC/9a+lws2PS2U
 Kr/ytAde8d+fXC4F49iu7aYWiK5JoPT4n6gUI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TPkfmyEg
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

Hi Julien,

On 2026-08-06T13:05:19, Julien Stephan <jstephan@baylibre.com> wrote:
> dm: improve logging for missing uclass
>
> When a uclass definition is missing for an enabled driver, the board
> cannot boot, and without any extra debug option enabled the following
> error is displayed:
>
>   initcall_run_r(): initcall initr_dm() failed ### ERROR ### Please
>   RESET the board ###
>
> There is a debug message using dm_warn(), which is not displayed by
> default.  Since this is a fatal error preventing the board from booting,
> the log level should be at least ERROR.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> drivers/core/uclass.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
> @@ -60,8 +60,9 @@ static int uclass_add(enum uclass_id id, struct uclass **ucp)
>       *ucp = NULL;
>       uc_drv = lists_uclass_lookup(id);
>       if (!uc_drv) {
> -             dm_warn("Cannot find uclass for id %d: please add the UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> -                     id);
> +             log(LOGC_DM, LOGL_ERR,
> +                 "Cannot find uclass for id %d: please add the UCLASS_DRIVER() declaration for this UCLASS_... id\n",
> +                 id);

This file sets LOG_CATEGORY to LOGC_DM at the top, so log_err() would
be cleaner:

    log_err("Cannot find uclass for id %d: please add the
UCLASS_DRIVER() declaration for this UCLASS_... id\n",
            id);

The idea with this was that by returning -EPFNOSUPPORT (unused
elsewhere in U-Boot (he says...)) it would indicate this problem,
without bloating the code with a large message. This code is used in
SPL where code size is at a premium. I don't see the error number
though, which I added here:

13123276806 initcall: Adjust the failure message and return value

Hmm yes it was dropped in the initcall move back to the header file.

We already have DM_WARN to help people with debugging, so perhaps
instead we should just enable that by default in U-Boot proper?

Regards,
Simon
