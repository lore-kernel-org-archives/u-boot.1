Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9FACCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5C08006D;
	Thu, 23 Oct 2025 23:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hITwIL99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0F8835FD; Thu, 23 Oct 2025 23:55:59 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 428218003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 23:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7817c2d909cso15582427b3.1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 14:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761256556; x=1761861356; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MK8oAQb0IS2LPj9f33fffkgTcW3EfeGo4OXWSO7jlOM=;
 b=hITwIL993EcQIiql+kM5gpg8c2LJq2POmAM7RmkquRUvjcmRT/hIGXJqfWus2F0vYQ
 Jr2akgkH6loQevhg+AuyVmoCrg1UvisrXMtIZOheyA8Hhkot+bPu4YU2vnkh3RPzG57h
 0+IZ7lwMoPxegXWM+hu+b2t98xwRK4d0jxBb+8XUPPBWGxGTfIi+GX8/grIw5qFCodDv
 gZ9XTSlSKvu2UCpO4E0fHK9MwQltufCuG/Z6F9aJP5pvDfaj26XyVcRsT1EgvoDRC2xh
 JCI7t0umtU7d0cyvwfXvlk9c/VbbORLbWYOFYUCZcaUsKYnDgzmpgH3NCTX3iKBbwc78
 68Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761256556; x=1761861356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MK8oAQb0IS2LPj9f33fffkgTcW3EfeGo4OXWSO7jlOM=;
 b=lLuTt3WQ9jS5jzRd0Zx4gc9k8D5QRmmM/2FJTZOo6vG/aK2vsy/6/372OgwTxwUvyf
 KuY5d+SIRLWKfe3GXerwUKKyr/qVOcmt/bpWze9auyGKTX3hPANy1DD33wBM4zX/NUvn
 zLj11rdBZ9Nlufx/16wzGLJ1lx6wNox9oDeYgcWeEK81zIKUCkiDaXZHNQjwAchT8UAM
 Uswg29bcDuZbA2BfYK1x8aq/ckYJYyk7Q5Ymd28b3x0xkGjye+fM9IbvDDWxZe4hsGKa
 PHP9Q1zQK9zfYd6g7wGxEwfPjR/O0nayy4ql4FhrCOiqy0EupWYYIJp4DreF2NTZ4PXr
 +Drg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8eDC+EoovxkCj5+1Mutc5X/REaxW2s/OYeCVDpnx3cDVeNa7r/On2L/Jyh+u4JhaliE3LpdY=@lists.denx.de
X-Gm-Message-State: AOJu0YyMqjqlhSY6E87R6jvJuGbMyCa9MBqx2XVflySyESFWI5y67Ioy
 9k9h6ALgnoSe+1QasffveAU/NxXagES7v4XW4jjst2rY8pGcXpKs0DMdDrCz0tx1svUuqYFRfVh
 AIzkjlDQcKlU//S3qx78m/Y8fHhfKAMb/ELxEEE5Z2g==
X-Gm-Gg: ASbGnctPOG0HtkOhBeWednBn3S2LKIxsQGrGTy3ts5E0ZvocucdiUNPA6cuGFVV4w6S
 Ft3gpFmCvsgKU4zmHE5wqkn23NDK6dnL+Vr0fKhknvVaAhGm9Oc17V0sgSLoENgquwoG28+ot8H
 vRA//H6cRrw91A4l+rRNU3i8FugGI99gYukE++h9cAus53Xr0ioQb9qAkxVO6kjqhw9wkwSj/0Z
 FhzYF1gihUEM67GYMiITXAjjyIc6Kj8ctFb2e05NrtOxDdnMZI1j9HO0N3JJdRDDVVRt9aBvPjf
 fQ0mhEqIjR7PNxglF9btNUkrZny3zg==
X-Google-Smtp-Source: AGHT+IHrLyxFTg2QqarGxmA/S63es3zSeGurTstVRYEbyioNbdzTzrlXduqhwRE7f9pVgPRklZ3UtIg9MOvIE3pzs5U=
X-Received: by 2002:a05:690c:610e:b0:785:aedf:4ac6 with SMTP id
 00721157ae682-785aedf6aa2mr179710067b3.6.1761256556062; Thu, 23 Oct 2025
 14:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251006232538.5109-1-semen.protsenko@linaro.org>
In-Reply-To: <20251006232538.5109-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 23 Oct 2025 16:55:45 -0500
X-Gm-Features: AS18NWBo_bN_40FtZh9Wfw2iVmZxLfH2JN33MArJhACQxb8E1RbZ8pLA1aaxRGo
Message-ID: <CAPLW+4nSaDC02AfatZdMtsrp_7amF=wxB0XofioB+400heXKoQ@mail.gmail.com>
Subject: Re: [PATCH v3] doc: samsung: Extend E850-96 documentation to be
 comprehensive
To: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
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

Hi Minkyu,

If you don't have any comments on this patch, can you please take it?

On Mon, Oct 6, 2025 at 6:25=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>
> Add more bootloading details for E850-96 board. New sections cover next
> topics:
>
>   - Hardware configuration of the boot device
>   - Flashing and updating the software (multiple methods)
>   - Booting with Standard Boot (multiple methods)
>   - EFI System Partition structure for E850-96
>   - Loadable firmware (LDFW) note
>   - Ethernet and USB Host Support
>
> That documents all recently enabled U-Boot features for E850-96, which
> can hopefully make U-Boot more useful for the users and developers of
> this platform.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
