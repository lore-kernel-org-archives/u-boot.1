Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B8EF4BB7A
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 19:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BE783DEB;
	Tue, 24 Feb 2026 20:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KAJnGECU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB22A83DEA; Tue, 24 Feb 2026 20:32:10 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DB882BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 20:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65c20dc9577so10912815a12.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771961528; cv=none;
 d=google.com; s=arc-20240605;
 b=E+TH5dEdzzX4TgJ0QW7/3l1euPJk/SY/c1MxlW61Zfw6CEcsvobkdjwG/eK1mDoDSA
 faT5phmfHT+uOOJpuJKR2cio56kHk7SW1J9XbQYnb3eWUjt9Gspw6qQ9ofJR83AWmsOA
 d/O68lVBeiwwQua0New34mvB2ViKB3iNLKmEu3dT/08uCh796mA1oUJHNTmjNkvZ+85y
 wg7Hv+BZLE42KwnJqh7C867VgzhslSZ16NFmBe4ii8p8PpW56rbH0uMfq3JRGsY7kGc1
 1OA3UQMf4asLOLhrlOxe3yNdZqdjz4VsWvfDIyp7zCiD+SfjpN4m01HtHfrokbze1B8K
 c0VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wOP6h8LAq4QtKGJzTrcgBJ1E8C2fTj2kf8+Oz4EKELI=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=b8HPYurXR8vnUzffg03qTWDmhKOgZ6GRVs+EFsa8EmvjPkgrWBnTtPxDPHad4iExpi
 d+k1Uw9AWxhWeqEQ13fwCSeZoahOzNzQm0zzP6B07Er3Gb2wcQX/x8DEwmzeKR0BLPaG
 k/AZGfrR1iCu07/Y/slg9pjka8LIMho4tGCBxIp9IqW8uyxyDhDWBkk53c9Z6pQAylx5
 ZAHXbQIZOKCjRZ0MjhveFLouqSGb0CIuJQuA15DpbaPPF7lH4bkWD1rzVANOULKWT6e4
 +HJ2+yjaANXzuV3FI9l4XHJn3YKh8toI8bg81bUWGlbZnhVuxMGOq0i6+C1BlfK315k7
 Behw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771961528; x=1772566328; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wOP6h8LAq4QtKGJzTrcgBJ1E8C2fTj2kf8+Oz4EKELI=;
 b=KAJnGECUxzh4uJyRr6vCYG7gi9CvgEUdRkty16GMxeB57pLE0V5DC2u91PqmDyyCXb
 gP9gZsNVdoMXIJUUozm31WGrdqVusY8kyUHRF3nxh4eO6oJ2CDPoF9GAGzLlyR5wegB8
 1s9g0UooX35th7pr6rkSogE9kQNPAPsDNL1y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961528; x=1772566328;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOP6h8LAq4QtKGJzTrcgBJ1E8C2fTj2kf8+Oz4EKELI=;
 b=MKcHiMCQEvf50owB2NO5AyrJiRywT2LFo3bCbt3ZI2PhestPoFJs6lAu+vHKM6dn15
 47Zw+7xBETJjCBCLFt//442epBeWsAkBKJO8P2TxpIhggQVrEimwAxmJEneI714RPdhx
 VB4VHynZFueethctDa7G4VlpIIAJWl60VTdrS6wS2HiT29qyfnsCAdySFGkrJdQ8u0oS
 Wsw2xkRc2K5EEIofB4niwgb7rVyW36VTripjm108uhXUNygyT66p3mnBFFiHvMfBUTvy
 U1TzjILNtOJB5Ut9Ily68C6uhr1LpCFsxFv47fuWA+xhGyxCYijwgHI84cjjyBD6cD4P
 /8Hw==
X-Gm-Message-State: AOJu0YywQQ0Qbj/79M/JbRlvm/6oW7MPzk7y7eUn5ngvlhAmR+3wGIB8
 /iNbPr9f6tB0CzVQQ+1Fu3RBZ6QSb8PodiZvCmc3bYpvVbkvjzkJaibTvgCH/HWOd17TXHRkWBH
 ydN3AxCeoU3ACZNb5QcDGltHe5H1H20w/55lEFwMDjo4e/DoJjjE=
X-Gm-Gg: ATEYQzzwuiGoLs84LvEBo53ReAxnb9jjjgwmiVv9ImLqisNOKxaOhqqy+haKIne2C/Y
 Ql16vCRDcfpfED+BpXsAJ7y5jarHWl/TxTdY0yKFeLVFnw7nw2G1XLGNHK09HTsWtFDWK0JsD0F
 Q18jYPwQYrzEWTpO1qCCEdNJS714csvzonGaY6I8e5SSIXA/kOrBg4w3dB82WCAu/gqEM72dfHh
 Bwm150ArN+aK6xx+sKR4llteklPT4ko1cwi7VNb1vdWBSz7w3DWpW2yUQS4nW1gp5AO1s4TDHyQ
 rnjsjw==
X-Received: by 2002:a05:6402:34d5:b0:65c:64a:2164 with SMTP id
 4fb4d7f45d1cf-65ea4ee7b62mr8874871a12.12.1771961528284; Tue, 24 Feb 2026
 11:32:08 -0800 (PST)
MIME-Version: 1.0
References: <20260224183107.124914-1-trini@konsulko.com>
In-Reply-To: <20260224183107.124914-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 24 Feb 2026 12:31:55 -0700
X-Gm-Features: AaiRm52IhWPZOX_D3IRJXdkEZCIQ_qjJcMgWi7Bx-VnESo7DpPenDRFCjHwCPd4
Message-ID: <CAFLszTjL3ot9nHwg5eeOJXJ3ymanQRAaEXcT2oRD6XyW_YE=+Q@mail.gmail.com>
Subject: Re: [PATCH] Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Tue, 24 Feb 2026 at 11:31, Tom Rini <trini@konsulko.com> wrote:
>
> With the change to regularize the usage of TEST_PY_TEST_SPEC in the
> sjg-lab stanza with commit c7f360f20d84 ("Gitlab: Rework sjg-lab calling
> test.py to be closer to test.py stage") the leading "and " part of the
> usage under qemu-x86_64 wasn't removed when it should have been. Do so
> now.
>
> Fixes: c7f360f20d84 ("Gitlab: Rework sjg-lab calling test.py to be closer to test.py stage")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 08d01c41f358..245e422d72fa 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -795,5 +795,5 @@ vf2:
>  qemu-x86_64:
>    variables:
>      ROLE: qemu-x86_64
> -    TEST_PY_TEST_SPEC: "and not sleep"
> +    TEST_PY_TEST_SPEC: "not sleep"
>    <<: *sjg_lab_dfn
> --
> 2.43.0
>
