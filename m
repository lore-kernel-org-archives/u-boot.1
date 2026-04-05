Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDFE63FE8
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 12:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B74283C5E;
	Sun,  5 Apr 2026 14:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NITwheqc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B4183CD3; Sun,  5 Apr 2026 14:03:02 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD9B8341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 14:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6634bb959a2so4177564a12.1
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 05:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775390580; cv=none;
 d=google.com; s=arc-20240605;
 b=Fl9nUOmHiXZyVmEoCRKeMHQA15431DEMMLq97Wc/rXdssn9jyQLP2hV1dMG4k1G25c
 39UvmgA+pixFrRQmlzRY87CawxXzyg2274+kZCyyTGihRkz0vUyXgkQCMlrPb3m3Aurd
 1kyJlY+3Cxq1kOBZ57YqKJUqMY7fHaZ1uVx/02hVcbX6A1loVBqf3KdPC/nDXak3kv+9
 HVc8cZi0s8x8Golef9ahunxnwf2SuC978IfBRhdOR47vG6CpCPPf3nptuMG4Y+DyEMlE
 Y/pQlF3ERIg25jVDyU+zdcgyGMBdxWbSj8496sn5b/hp4cFN297NyCdOxIA0SGqHS3hh
 tvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FIGWcGBRoHzWX6+lMB4i4zyOQLYeDODZS7KdxlUnKYQ=;
 fh=AWI3faAHHo6lP0H2cSbUS38UAQsKxdqj/96Ex97tx8M=;
 b=Yz0GiQCIdyqByy2BtvpHdJLlLgKcqPw3zW5MVFBfYU2gp2GhVlhUCKoliHF34jepJZ
 Bx7n9z35fpGByyIORzNGaMFeNo08zt7PMRlkLTxOJxA5Q2wumNppu9HCzUsF3WgQoDMK
 A+1lsHM5fij2xHHRjbOqYNgiGMa9w4sBnoVp8sdYi7lM+MnZzm3iKsgFfP1DZ2gT1T4a
 0XTpYWY0KR+rtjzf7IWblE8W/uczO/Zdrz4Mq8D2RuNElqhAs9ZEFMtVSoFmFlamDr+o
 uTuAaQK0R5FiKHFnBHb4qWjiqRaXJp/h5EKeAK4G2QK32XYVxjTAeEkY+Tp4/H584Jdl
 Krzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775390580; x=1775995380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FIGWcGBRoHzWX6+lMB4i4zyOQLYeDODZS7KdxlUnKYQ=;
 b=NITwheqc7usAJ2uNx+X49vORsl08tRhzLQxLwNxpZZiTXqP3S3qcNlxtwc3mTN9FQM
 A6ajJV94sisXcSeofrC/8MyCSRWUCMCi9BQTyLaanHRmGP6bdPgy7U07wDquYWiShUHi
 8zihcsTA1mvcGLeHDGvRzlPYz0KFdKwj/vEE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775390580; x=1775995380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIGWcGBRoHzWX6+lMB4i4zyOQLYeDODZS7KdxlUnKYQ=;
 b=IL7y3A9nlGegkyH/yjy1tQqYQaYFwQpVfj9IBouWGf6xxn/hxPO8TqGAgHIsmeMZT9
 gtcJ4waF10ftz3wtVFNK8z0493Ta5cUco2WjrUwOJiH4os79CRn6UgLGlU+5cO4oLweD
 fcTKZXasgtXWt0i12QuQ3ZYdG8Yb9kR3lFRrpcw4zsCk6/XX65sEdy3rkqkA8qwIffvS
 NWQ30aFUgr2RaLyqY1skAheqMKPvgQaFf72rEWzIURUQuDPAqTYbl+UNzsldakVDz3JN
 1F7nZfYSPHKIUd7WijQt+Ri5nTto2H2/TnK1Pa9hoNb9PhFhBdkxi6S/YF7USpnfWu1J
 n92w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNw/T5WJ7SMgytYC8SOJaVvIDbSyudBlUCp5ma+QBCEcWZ1LRQCSilmTFOKZjW7XUIEICJc3I=@lists.denx.de
X-Gm-Message-State: AOJu0YwWSERl0zWMfrLpzzvUHl1q9dcM4IwyeCp17Y+KN3BYLTcKaU2i
 fL/Nx3KfyiQmDHWQD5eXdU71QRb6ddtdvnmw65atp8eTZQ+lH59CQa0kUMoRb+tYKTJxm60QrLy
 HLpEpee716nzDN6DOQtTuFoYN8ISBoNetKl/oRIBg
X-Gm-Gg: AeBDietr1gNx+eeBBsqxjdj1OkARwIPgSsRA/02TaVQkrIZX7FVSWYrfxqVuWaNvB2I
 uEWSmdpoReJZswneWatwhFoZXHBMs2Hi5P3bhVptDxdJ0QrvEsRg6uQJwaNieYVi8ss3c5vgggD
 JogbI5DlH91hYFaI2AFm/u7lMtXskG99qc1guoWdoDpaoAwle862KNzrZYBQAqOXnupM/FZQrXt
 rZArLyQ9D551IxA+h62NoUCNPj0wjJj2EuX3NuY6svoelAg24gGvEUG8fwugoR+R7iSLCJX+9UA
 kxxiCA==
X-Received: by 2002:a17:907:1b07:b0:b9c:8618:a8b6 with SMTP id
 a640c23a62f3a-b9c8618afb1mr263932266b.3.1775390579815; Sun, 05 Apr 2026
 05:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
In-Reply-To: <20260403090109.3564638-3-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Apr 2026 06:02:48 -0600
X-Gm-Features: AQROBzApbNw2MyaMhB7qwbp1pWn2hEH0zg0EG9Z10c449PXz1BFeJVHHK5c0WIU
Message-ID: <CAFLszTga-MxOAVzYej7j85t8m_M4izegidfBqnQTZd+pvvJNpw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] common: move ram_base calculation to independent
 INITCALL()
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-04-03T09:01:02, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> common: move ram_base calculation to independent INITCALL()
>
> Currently, ram_base is calculated within setup_dest_addr().
> However, upcoming patches that enable U-Boot relocation to the highest
> DRAM bank require ram_base to be initialized earlier.
>
> The default dram_init_banksize() definition relies on ram_base
> to calculate the start of the first bank. But following patches
> will move that function to execute immediately before setup_dest_addr().
>
> So let's split the ram_base initialization in its own INITCALL.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> common/board_f.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
