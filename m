Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD3DC3DA70
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B6388780;
	Fri, 26 Jul 2024 14:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z4YB8aQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C1687C7E; Fri, 26 Jul 2024 14:59:28 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3BC488791
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5c2ac3410so453798eaf.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998764; x=1722603564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e7gzg06gzUXb1qd7x3kHQC4LBJ/mle/nQrzylWPRvYI=;
 b=Z4YB8aQ9lsf9Z5VCC5r5KWjRgXLdgJBKMp/HMBbRUnzxArbutFWWDyWdXMpIOSWOBU
 wF3xAKHn+QjxeQMfFI9NnLj1vNUSGD2Np2YQ8IJWn7EQ1sdNuMvF4TvHoFXNibwdI4Ok
 +s4ngALxOUVnh7z2B0UEjSvJ6mSb1RgS3832g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998764; x=1722603564;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e7gzg06gzUXb1qd7x3kHQC4LBJ/mle/nQrzylWPRvYI=;
 b=D6H5A+ztHOxNfaNGHTpoUWjtMVHR+1N39UVD5gkdPVpxSUueQSSfjXJB9AwCuNfiH7
 IQxyAqRfvrgTgaWCa97G73FcssYDCG01Mvj9GUojg3uzHu99l3WmS8jYZR4LtGtBfQpO
 3vlXBqWS03Hq1mshxexkY5M6krG09G339inHTWf0sJzkCiNVDeYzqk7RyJH/hXxlFn5b
 s72Gx0u5yc8xIbqJWhAeOpkoQJ0XGWdxOAWxAo3CdYBwqfcNWxw3Z14BiIEt/nT/orGv
 k7pBdxgl6a3Qyt4chJM47e/VngF4B522Pe6eVCUiKK2c7YI0hpQY4EbLZeLpxKISYvk0
 JfeA==
X-Gm-Message-State: AOJu0YzWR/wEMSGzhi/MD8lhHrpnF41QpXDJHelH9FjzUhansvTbHctS
 up/UJsbM7nHF568jWlRzOg5AzrLAY2cxS7GLGQpHLeQa7CQP3GzRpn+N5kLg8wfy9lZGLPKUA/2
 fPgitiFOddTCkShnOnmTNOIdHvLkBbrKF0oz3
X-Google-Smtp-Source: AGHT+IGn/z5E8OzhUxSpa8n7E6dBLCi96LETay7HheucTI3rVR64m+NIe1qS9yVO2ok6LqgRWaxLgqh62/QkDBFlULs=
X-Received: by 2002:a05:6358:528d:b0:1ac:efb0:fb2d with SMTP id
 e5c5f4694b2df-1acfb894d37mr656381355d.4.1721998764499; Fri, 26 Jul 2024
 05:59:24 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:23 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240702174643.GP38804@bill-the-cat>
References: <20240702174643.GP38804@bill-the-cat>
 <20240702163729.2674096-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:23 -0700
X-Google-Sender-Auth: RqC6uvVsbLOtoAKxHwVc6Ow6qE0
Message-ID: <CAFLszTi4vfG4tBgiU+zTtzyON_TsBi7edAWjE36mj75JkP9YWw@mail.gmail.com>
Subject: Re: [PATCH v2] binman: Update cbfstool
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Simon Glass <sjg@chromium.org>
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

On Tue, Jul 02, 2024 at 05:37:28PM +0100, Simon Glass wrote:

> Update to a newer version of this tool, 4.22.01. This runs OK with the
> current binman tests and matches the one in CI.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm, thanks!
