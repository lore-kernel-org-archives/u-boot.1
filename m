Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD8BCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3EFE808AF;
	Tue,  4 Nov 2025 19:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4IQYLAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96664808AF; Tue,  4 Nov 2025 15:54:52 +0100 (CET)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFD78003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 15:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63f97c4eccaso3856008d50.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762268089; x=1762872889; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utmfhcjK2FMnu5EWo10Kr5KxYaZyhBe1PRuI3F+lNnk=;
 b=B4IQYLASZAfavk/XX9CLIRo4QIEC30tBuRseXNQt2xrH8+/dIEfFZHA658uU4Rslos
 1ntHETbUgmsqFNKpeOAoFA4w5jqCShvxcN/uR7KAhvKYPSjgetzFeyGPwLsmfS1Gg6Dj
 Kk2X0z/rA0+ftD2MJUuR1oCFnMyt6Q28dtKneIV/5myPREcct7K+0c7kM4qWBxJyYqS5
 7U+5dJGoj8qgBjjGG57RAxuWwyvPgF4CJm1VW0GD+vI8ZJ9GKd7METytYxqUi1oXQoAv
 G6DkosDCkWE0+Ilj+CqDUT2tkhv2Ayghm6yhkRJDdNSCf/qbzJo30DkWFNG+WNnwjWno
 pteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268089; x=1762872889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utmfhcjK2FMnu5EWo10Kr5KxYaZyhBe1PRuI3F+lNnk=;
 b=Gii3ix9u3mJ9qqSZtKHvXEtpH+fsupOkokPQkGO3plqfmVY1KPV6yK+z4WWJgD9LDp
 JuYWW5gcK4xTcdacGl/XfWYepkitjDaw2jUcPJ8HdnZBwTiX9BRldBISFiCRPwrGxLFv
 wHrHDSZZgjX0UJV5cycjaVfvHOFWIfdXLX9tPOKWvFuVRtfN5/jS/53eWTzc5+KrzGCH
 6iY16DCEoR/0eTg+ljVTBioLVP4NC9gqpfnL/rvn936v71XGhilJAdZBH11Rx9izPj6h
 T271wOOFQTsBDq73KP8uIf4Uov+7bo/1k6tEY0Bo/IT5OfGJWryjj238ueDrevz9iqEQ
 l85w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjQYz+A9o6av08ZQAv09pdpQbIUWN0h3St86P6rkm6Ky/x2dMmMyyN9PHFYx4vzMroOqU34ug=@lists.denx.de
X-Gm-Message-State: AOJu0YxPmj931lNj4aXewUY10mSA80CKar1c8lLEXGAvGdluOSjcneXA
 oOzyRt1jygSFBgbgHoiqfJFzlKPYDqploURnDH1WWCwt3pf54KlOM09NPLt/8cPGQmyVTazPQ2t
 ONl782RGkZZvbKLw0YykPAWRqtjXf8qY=
X-Gm-Gg: ASbGncvjyZpEIdT+Io6tGo8kL/TfrZSRxJbsvL3ddPaBKijOiOswn3hH6orEseIYc0D
 9XLuFzyAlVKFw6fyFeY76fuaEv/kRCyHknuw0GD0B+OYqsnd0KXuWRSOhmNQ9rKrvOGaS2qFHgR
 WH14+Ppemesrl2euLJKHyP0GX7IpASiXi7c3bbTjtFMFjAXWzKvCMF3hXeSOb5C728G5QXE+05u
 l8F5v8H6yAZRNeGRC6mEf7YT/Ubjt3Et5REydJJJXngOTErWwCH6kHRZ/qA
X-Google-Smtp-Source: AGHT+IGgioxu92uQkwU8ICW7DqUE6YkvQck66dcZ5KXfOouF5CYzLXYQstaMljPRCQIoZsVGDoIXlynQIQdGCm3X3Is=
X-Received: by 2002:a53:d008:0:b0:63f:ae41:fbbd with SMTP id
 956f58d0204a3-63fae4207f3mr8114133d50.8.1762268089292; Tue, 04 Nov 2025
 06:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20251104110702.62877-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104110702.62877-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 4 Nov 2025 22:54:37 +0800
X-Gm-Features: AWmQ_bkdX9q5HS2fbYSVh90yXeRbm19WJJQmsPi35c_hFDPQPucZ0ai7Ejwr8sA
Message-ID: <CAEUhbmWwb5Jf43R9hwDnFEuy2tVauDvA6f3Gr9vdpY17A5Qq3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi: Use struct efi_gop_mode_info in struct
 efi_entry_gopmode
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, 
 Ying-Chun Liu <paul.liu@linaro.org>, Adriano Cordova <adrianox@gmail.com>, 
 Yang Gang <yanggang@byosoft.com.cn>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:31:58 +0100
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

On Tue, Nov 4, 2025 at 7:07=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since C99 flexible array members are allowed at the end of structures.
> We require C11.
>
> Use struct efi_gop_mode_info in the definition of struct efi_entry_gopmod=
e
> to avoid code duplication and unnecessary conversions.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi.h     | 36 +++++++++++++++++++++++-------------
>  include/efi_api.h |  9 ---------
>  2 files changed, 23 insertions(+), 22 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
