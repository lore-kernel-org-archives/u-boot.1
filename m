Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A4CF94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB5F84307;
	Wed, 22 Apr 2026 00:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MN5w4ySG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD23684307; Wed, 22 Apr 2026 00:49:03 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE311842FD
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba5b107eaa2so185975966b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811738; cv=none;
 d=google.com; s=arc-20240605;
 b=bf5s7x+LEXm1ivsEKhKMgY7OqodcLw4IMIttuk1KGTouFNlyzoCK4Y2npb77El1FW6
 yPfK1KMnDik0Aqix9JJBDCGy4PsBchwOyYU6CyMZoRPSObIkjP5njrLwRg94P1bYvtel
 dSY/myhv166iPuPFcJPCcx1rtAkEAsKXivXs8zyBmVPIqRV4MsSboPqKu3tiwi2w7bix
 H3QrISq61gEiG5uQWnnJgWK97ZIfs81sbWdj8bxh3Sxyg1s+d1OrZgKKwzBg0hJPPayk
 3HavM5mSwzAYTX+9WD7oZPjbUJ18NR6kMjFcmj3IZPh1ExWgiW3RjklDSd+pVPGgw3De
 Q8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FJhfHzo9ISsqhxLa/8KexMDsXkz54+A6a8My7UqBOKE=;
 fh=LrXM2QBjOv+SYZI9Lo3tXlCIcaAX0M7c7QDhx9ga1yc=;
 b=ELUCoQtAolqNEaKUuSGu1pCo2gVSR56vlhBsDNCTTgmJIRTD82wiWaDxh5S0kf3obD
 6SOOtIAHY4Zwr4NJJoNERPRu0OIvQlNVBkmXkaOFm3TBaqHUiQOKD+zBqtdogdc1WTIS
 fDJUjYp9mtpAI7p34B6FA6lrhFPpaGetSzwZG0XYKa7rmkneXPC25A12X6+7uhYMUDvB
 WSyDqds11YbKToc6TYftuWyk7V3vdAeX8sexS/Xwn1AgZ9Vkdn+fZ/k4bt69+SNXUPvR
 XFofejvbSfNxEXrwMW4EsH0hDBqLZvIhk6QPuI7HM9y3ILCYo2sMoAjjGGzsULlnGVE0
 zgQA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811738; x=1777416538; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FJhfHzo9ISsqhxLa/8KexMDsXkz54+A6a8My7UqBOKE=;
 b=MN5w4ySGJEDZNdps0wBaovqu0KSMhl/8y1NrR0IbiTPW2bjhlAh4kwt/K++S5KzYWH
 s0zSXPchi6DRRfj5O3uZ5Dg2mL8ZVEKlu4+vWlk0lLlfVaM0yyhTPuLNihQ43SMXwe6c
 s9EKXgBQDI0jDRW9JrzOzuCMeec6ve8uL3Tsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811738; x=1777416538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJhfHzo9ISsqhxLa/8KexMDsXkz54+A6a8My7UqBOKE=;
 b=JkA7CUEILEyQZd5NzP0oggu+wk4a6yNMtcqY6RmjsHD52+vnmUIWwdUh6xyU1SoreE
 pPqtgLyr/SaWY2INckJumqEcEEzaBvjicXmZfe+E4wOwWiIYb4q+ZMTxuTEwI/tGGkzc
 EOP6IfzYrtKw1Meuo4Nl7d3h5EY2t/otVzQXB4VjOWNsd0wDuZjMlougj7GtUL5cWIUN
 89Ftq4B2zZrT9JfJtEVLHXJrqZM+gQlpkrQVFd93HA+DrxRuLba7UrjtLs28rlI2FrCX
 pHBaa9e1m0bG7ZfW1+PBkxnvbz/iZD0C9zE7xKnRVLGTEJh2PNF3pyEg9FHiQkFBmYZS
 VtVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ89Z1Qfz2Fc/Fc0DK2FFO7OBY0qDa8nwPpCbwdjFkRqqmMYvXZ/y5wO6xoXCa6rs/6cHMxBXdE=@lists.denx.de
X-Gm-Message-State: AOJu0YxuK8BrCXhN6/H5rCXuFaW2Dmly70l6MHQePK3ZhM/swG8f+6Gi
 uf037I9fCsJwiD0OltWNgdAwXlFljjjj10KrUPc0H/pnW+8x0QZySRyDIZM0KiY/GQPlm4CZZ93
 PwNZixO3K+F4/VnzALX0DE6Jmp2H27Sae5VoquOoP
X-Gm-Gg: AeBDieszjQ31ZwHLG8PNKpv4ZlEhozeiF5t7+S7UvjVREb9mr6Wszt8S/Om0hQklaQA
 hpmTNCmXKnhSxQcDKdrukN7A5tWYHVkzYtUXiFkdAHc9puq2Aiubl9Tsw+lquAk3xrY05lY3crR
 1l2xTCYHTfNbUAGCIgt7X+Gq9WNuNwWZQh3YLZYuF+IzPgjmHeKkGhsm7glevN0hrsP1iKqkQ2Y
 4/VxuMpUmiyo7N5Dh+Vtuoe5tHFa0WEXpiq1z8vtBkfBvyldXvOJZfxwvLht7IDjX2OtWe2fn3O
 AV6JapJlxYJtdQ2Mzkmd
X-Received: by 2002:a17:907:3d8e:b0:ba7:4cd9:ca27 with SMTP id
 a640c23a62f3a-ba74cd9ef49mr586284866b.41.1776811738381; Tue, 21 Apr 2026
 15:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260420164725.359539-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420164725.359539-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:48:39 +1200
X-Gm-Features: AQROBzBVlMcPGi2JIatxJraIC3thl0K6gJSBFSVnOCvN_sohLt1yGQFvtuBTKdo
Message-ID: <CAFLszTjAqjEtnLb1Ns7fLp7jt90XSfOwJ9iyG55aYA9EWv4fWQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi: fix initial RSDT and XSDT size
To: heinrich.schuchardt@canonical.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Stefan Roese <sr@denx.de>, Saket Sinha <saket.sinha89@gmail.com>,
 u-boot@lists.denx.de
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

On 2026-04-20T16:47:25, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> acpi: fix initial RSDT and XSDT size
>
> When creating the RSDT and the XSDT table they contain no entries.
> The table size therefore must equal the header size.
>
> Without this change a NULL deference has been observed in
> acpi_find_table() when running ut dm on sandbox64_defconfig
> executed via sudo ./u-boot -D.
>
> Fixes: 94ba15a3f13f ("x86: Move base tables to a writer function")
> Fixes: 7e586f69070d ("acpi: Put table-setup code in its own function")
> Fixes: ab5efd576c4e ("x86: acpi: Adjust order in acpi_table.c")
> Fixes: 867bcb63e79f ("x86: Generate a valid ACPI table")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/acpi/base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
