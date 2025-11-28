Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFA5CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 10:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6AB2844D3;
	Fri, 28 Nov 2025 11:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aX4pUv6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF44844D8; Fri, 28 Nov 2025 11:47:06 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DE2844C4
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c704bdd57aso839594a34.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764326823; x=1764931623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AFm8s0qUcVdX38c/HAHfWP972hqmnd++r2fLD70tJnM=;
 b=aX4pUv6FHkRWKdkjXePVHR3HmSQLQNkETSXdOH7hnj7i9xu+PcPfI7mLSMr5j2VMWz
 XoPDo6PvFtjCv0dmKaaiaxYl4miVivtOYw5uzfxGGE9XaRwFdaB0vunFSl45OdWEVI6W
 VdGbZN76RvC+0oM290/+7DEmjdqgwisBlRPWxbksiSqDqvMvT+/JWWzRPN3yA4b9fcSg
 i0wVo+KEqve/B0Q9Qp6ct3MrmmSxXyydbNF5XZkw7XpCMzcT5jOjtcgdZQdW8xEPz09e
 ixjdZeQfkThEvwB7q+2k5Karn2984Rpw5S/AGT83oYjIxH/zFAeC/1q2ArY9z+4luWBx
 HDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764326823; x=1764931623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFm8s0qUcVdX38c/HAHfWP972hqmnd++r2fLD70tJnM=;
 b=mpYnkK301AS5+oYyd/6dRDHdkVxp6/vItFZUQo4uAKMWsHdlh3mNVixLyQ6doIJk4d
 ya/oVazfH4u6VR1bLThMIF6spFyXIkLaV2uY3XLdQ5JasWZGleirY7eC+3gC4fyHsXNN
 CaX1UEf1rdUTxDVm1q53aYKAgRKxPi0yF64LEAr+umYqZxGLptkibFRavLGQlkduHMOT
 /f51/6FiVxAS5N8NYxTtcEVw6bd/99SwAIgYnd6zaW13zp8v43LMFnRlug5edxEm/uqH
 41QrE0o2uZjPTgyKyMG2+QFbtgEhjfOXiohS4AkV/aXwDo9+pcvJXvG94p0Bqc9xZXNa
 lp8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQXo3ru7a6IVVGhO31KcAxo+Y2lDWubyZiDlD09TyfZ0xLG9RipnEaLR+iz4VndVc3mH+Y1FY=@lists.denx.de
X-Gm-Message-State: AOJu0YzQhYOem/POgpu6K64Z3oBHY7SBQ3yxdfZoHaD7KTgdm777G1fo
 RArlHJ5aeLwpN+Gekg6I7sC2h1zzctQAMdeIk1GD3F7wnAAv25snNTOx5tM9EyQcOm8ou1yqGR7
 l6HJ4XA2Nm4eMGLfiQe+sL1W1QwZZm/c=
X-Gm-Gg: ASbGncsqkqXAijz4g6LjDHDok3xTjer3W7wn0p6WckcAiHa27HbFlIJwvoRupsM2VSQ
 8Ih1mND7b/JcWVRZaDsGnw6bI3tl7AnYjz42QAUPKSTOJgZTPeXa3UOwFVmFfIhTIDkHkfRAU7J
 YiO0464cSHA0lKFRN8IuNryBBSuXa/cYc1oKm1A5+ASIiBxyVZ/yaD+0oMHOuDeW97RPE9SjS5Y
 ArdaF9N+JNZSqtMHO0dnZkS2b6q1Xrwq0WYtN9W29eaJAqu0KwtHxHEUknq+atvuc0Jvkw=
X-Google-Smtp-Source: AGHT+IEddheL88aIKnq70qoLoKzHFltMvqBgZH+OJ2yZjjUWDbgbwkvd/HD7ulslzzTCMG3VYZL/BQ+jCDvUw7IwYMg=
X-Received: by 2002:a05:6830:3786:b0:7bb:7a28:51ba with SMTP id
 46e09a7af769-7c7c44c81d7mr7556456a34.26.1764326822876; Fri, 28 Nov 2025
 02:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
In-Reply-To: <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 28 Nov 2025 18:46:51 +0800
X-Gm-Features: AWmQ_bkFQqn4bvYk8-cXDGImKUVzDqDjZQJ7LVkSKYhqMVJO7mqozT8VjJlOcWY
Message-ID: <CAN7C2SBaoHRj6sY-MgVu+-0q0vDcq6g==OcWts4W3uLKEwyweQ@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> Altera official U-Boot (SoCFPGA):
> https://github.com/altera-fpga/u-boot-socfpga - branch socfpga_v2025.07
>

Confirm downstream on default cyclone v socdk always works stable.
No settings are touch nor any file are modified.

What other confirmations are required?

Brian
