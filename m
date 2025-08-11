Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D255CA0ECD
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDC9E831BB;
	Mon, 11 Aug 2025 17:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zkq+AnIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C6F783192; Mon, 11 Aug 2025 17:56:45 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AD483106
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-af9842df867so801457566b.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754927803; x=1755532603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgPNu3H+29SAyWgY/YZzfZW93wrDvVAiDsdAUrW2rl0=;
 b=Zkq+AnIV4jEiyX4s/IWmQPIPSqKlhE62Hxy4054HHVd5MdSOTIIZ9VrzV2BnCFVU7u
 sg+au6bAOGzRJxMYyjNaoULHSIStnJ0zIYbZ4Qu58tSCcgGb3lMrdhR5YqEZkyPG4Wgh
 JuEv7ML8U/kRVudTQYXYo/bGklo4u+WV/kwN4mVhGS2lwAieBI7nSJanQ+5KzIMvNVmE
 h5ZnSheuXa9N25zbp/ML1bSPB4/UOVgKy8R2uKUB4ywa9LaUSPa9QyybKHttwnTTinYt
 c8bZ6Zf4z5XQ88jlIlPzOCvM+cVuZt3dRJH2OciDSzkF8OaWeMffHRViHwpMm+Qr0s3q
 TZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927803; x=1755532603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgPNu3H+29SAyWgY/YZzfZW93wrDvVAiDsdAUrW2rl0=;
 b=xIcFBPEepDVLOKLhZEDxfZZSqV3mfBf5W7A/4XF86iKnyuJZEOWT4IfMIM754p+FHo
 T6i0eyfdyh1Nkdb7/o8iTZBPkvow7v6J32C1uMqG+Sjnau/XTO4GqN+QESYhkmdkkgd8
 TQJInmLe4X2i3/CkS3CcngMaOarK0FiB+R6vnMX4RmROUJ/A+g/WdUbwxwrhmfA7G6q4
 S39SW+FRSO5PbiYjfCQt1YRYaXdAycHxkPKheX2eYqXRj524TABX/m7RdM5tZ6WGRLbB
 SJABXnw1uiebVMhP8Skc5jfZ3VkYAQD9xvuDV4v6FecJwxJtabhCXVh3aEizfuNwMKau
 b3hg==
X-Gm-Message-State: AOJu0Ywbz7emPCrReAFFWDYjssftwhqv9gJVTyWIEl6F2HGfoNtIpYj/
 AGmOee1B9Kl2Oop/xaw/saR9rWtyFq6hcKS70NXolVjBiQ5320jAaV6Xx5iQPfll9F2BVi9DWhP
 m1GnolzA1otgSxCBNe/xPToSgHRrymSA=
X-Gm-Gg: ASbGncvJirIx5zxv+ivmdjAIkTXXKJ01HSJBbqsqcxt947KYocfxSjA/FVEpQwQGxeS
 9tvIegcsuvzhhyLlaDXQyNkTR0fHtMh9AVEluopGSJecQRXhezZ38RDqYCj8ocyq8yUa8BI8KVn
 HjfXIZ9rvbK7vkt6emkA/GUWxV5MiwNDx4NyPTrVx+TLmxP4He0eefHbed+0Ixx07eIetRT2msG
 8aWx/3T
X-Google-Smtp-Source: AGHT+IEMFVYb7NkgBQ83m1ioQRpWhFZhNq7v2DayDDyS8OqELCRanPAW0kbMSrMIsHYbUjSlm9l7aYRNFKx4sayEjyo=
X-Received: by 2002:a17:907:97d0:b0:af9:7b49:c0 with SMTP id
 a640c23a62f3a-af9c64bee9dmr1314973166b.29.1754927802547; Mon, 11 Aug 2025
 08:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250806085959.2130339-1-jerome.forissier@linaro.org>
In-Reply-To: <20250806085959.2130339-1-jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 11 Aug 2025 16:56:31 +0100
X-Gm-Features: Ac12FXxA2a2-JqrIjWk1UNdqlZFPdA3yaaE8SoJTKzs7DD9egXjp7WKZwjRFAnM
Message-ID: <CALeDE9NsfBRyfOdxr8S0iRSj5kdSwyKVr-pfroJCdjqT0hbmvA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] lwip: add Kconfig to decode and print ICMP
 unreachable messages
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Jerome,

> When using commands based on UDP such as tftp or sntp, if the server is
> not reachable or the service is not started on the expected port then
> the command ultimately times out. However it often happens that the server
> or a router sends back an ICMP Destination Unreachable message. That can
> help troubleshooting. Therefore, add support to the lwIP stack and to

Has the patch for adding support to the lwIP stack been sent upstream
for review? Please reference the upstream patch for this.

Also related, what is the status of other out of tree patches to upstream LWIP?

Peter

> U-Boot to handle those packets and print a diagnostic message on the
> console.
>
>
> Jerome Forissier (2):
>   lwip: icmp: allow reporting ICMP detination unreachable
>   net: lwip: add Kconfig option to show ICMP unreachable errors
>
>  lib/lwip/lwip/src/core/ipv4/icmp.c | 17 +++++++++----
>  lib/lwip/u-boot/arch/cc.h          |  7 ++++++
>  lib/lwip/u-boot/lwipopts.h         |  4 ++++
>  net/lwip/Kconfig                   | 13 ++++++++++
>  net/lwip/Makefile                  |  1 +
>  net/lwip/icmp_unreach.c            | 38 ++++++++++++++++++++++++++++++
>  6 files changed, 76 insertions(+), 4 deletions(-)
>  create mode 100644 net/lwip/icmp_unreach.c
>
> --
> 2.43.0
>
> base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
> branch: lwip-icmp-unreach
