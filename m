Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FE2CDB466
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 08:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A658493A;
	Thu, 25 Jun 2026 10:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EP2GEnEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A5384949; Thu, 25 Jun 2026 10:52:31 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800C88460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c7ee0d7f1fso8233405ad.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782377548; cv=none;
 d=google.com; s=arc-20260327;
 b=lMh0vQb5KD4e46RcO0JvOEJ65yprvBMeJIBQwIpTf2VOcuQzIRaLJjkoJ58Dt4ly36
 ZWTIfduyc5QnLq+iyohIMwykPk+2a+fAb7A8R7zquMZtGXwj6CduB4ctNJ2e8Ot2UXuA
 YOeV8auu6fZXAhI9Nj85yJFOBfab75aF0QShVssGMFFqDM1ZzteI40pw78oqzn7x7PIa
 DJ/3iAVMalXjrRbqeMBoG9/fNc1e/xh6oTW9+vquhHMa314s+Hr87ge/iQM3NYyl3z2y
 1lN0HC4zXYm/9S7Sx67OLowOA3/ZJ+hsa2NZERJM7+Vcm0pmaO8hL4eQVbBPA6JOTbZA
 wOYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5LEsNxKHuu6KSDUrPKrGAK17mSEQYVzibX5s/guwPZs=;
 fh=rcTD4NFwOFfgIMGUbmyr/sdIQ5dk3ucN5wiXQFCq+vw=;
 b=rbFFiVSMYKEHMGZbhPHgKQe2P631ZwbV0RXIA73bUsTo4KflgVqD8tVjdWkWoLSOrJ
 BupgkD+MiUCHBToHwD0xAw+pznJyfWcP3OLf91yi/zWYSlPkJGyHX/onzLHF7AC+pplY
 2fqZFWjZ/X9GWyC58GQhdNqSbMQ9UNVmhtZr3/f7uwfXDwagE7N51nkksMi+6gs4oBOL
 htRXI0Q01hWd+B2Hm1CTxX9FYor/Ux88QrwLNOsEK4lJp3yCrpnQ2d5lqrc6/pQJ7v4t
 1FMJx+iksp6F6aesZm3lYJWZA20DkWazij6RH6NMyKlesFhU8rMG7FpWBiWwwUWHuRxD
 vvrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782377548; x=1782982348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5LEsNxKHuu6KSDUrPKrGAK17mSEQYVzibX5s/guwPZs=;
 b=EP2GEnEfDZIuBPDajsEm6CQq/l2Z7V3KxMmoOQ/0qHEGMh6NjkgfPGmpyrUPyE5r7B
 CSWxyr+8lxuXgv1IGTZ8iZopHnDHDqg5K8W+AxLdY8bi009sTMUWQcpap2GiiTiAM2eg
 r7Yx/LlgAnoCu2/g6pwPmPWt8gNgRGhgnpve4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782377548; x=1782982348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LEsNxKHuu6KSDUrPKrGAK17mSEQYVzibX5s/guwPZs=;
 b=EtcTkZgB/j3ZsKAwQhmv5jN4SBC5HYbnLmi91KJADn/sSGm50JEXkvPkKJicQ15lNF
 RS9SEqVjc2ZQ8D/1BnK11mubtFE/m3QpNhHjC20gD7VWMRXv3feuCdDSa2ID6KvDUzL3
 Q0qJxPRzGgWVyEBHUa5FpKfo3gprjqZyLNILBjAoNpt0NqCtt3+G55/GdjNQZzu1099q
 U7RAmkXRRtOTSzSG21RCXuXJesApEu1y7mtcdUynvR33iV1T9zyDjXOYwcx5X/rGE/MM
 i8pzuibKKGq5y4a+kLI2l2jEHrTKbtF2PNEM60wy1iarhULBtSFxPuSIV1vaQ36IL2vu
 6acw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr56n+KPZEneiao4F/q/xtCxJMdyRaLxPuAk1KG7UkUsc4nmFQHQ2O2bjHdD10iu2RbrkR2y+Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyVoF12EI46NBCYzlOK62H2sUwYJ0LxQ9b2VNWWv6SnF3Pn3m3S
 aGVMkbiYvsEbA/IeB5KVBIYxuqAT6zHSEHRQkqhvwPUN+4XejGjzVbrAlqhpOHlSYcDAvM8eJgV
 cH5QyIwaLLEHUalQH+J0prQEUdp79MX8KikJ5gnrx
X-Gm-Gg: AfdE7cl1g15lScDE7MtSmwY0OFBlVKv1a6UDEyvZutUHytiNq1Wo3ZWa9RLrfqVnRNF
 JW0XNEPXznm5zyMQ/NesnVODUhmeFqglKBUprduT3oBhm6q1msmj1nVjl4CJZlMnnVxMk606Ivc
 O8mxoqcVeDRbuDwpvMvzTe3OTwqPoYtmlTYu4lCMhp6wbO89+Cru8Rs9D4f2e9ugAKls1xDZE8n
 B09HMzNwVcw7HhUgnQ75yCaepSUQPa30fE4JZXg4odQDkahpagOZy8nQE/rWIzYdzKe6jRXnw==
X-Received: by 2002:a17:903:98b:b0:2c6:bb39:fed2 with SMTP id
 d9443c01a7336-2c7fc75bcb5mr18503425ad.25.1782377547982; Thu, 25 Jun 2026
 01:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
 <20260621081915.19154-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260621081915.19154-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 09:52:05 +0100
X-Gm-Features: AVVi8CcGpDxGa1JyKwsfYHEn9_t1SoQS37RG7J1GiYQHVYuJD9FtAmNWAEemFsw
Message-ID: <CAFLszTjomqFY=jG325Yzmd4nO1iEvyrKROCaNQsbG9FrCpaChw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] efi_loader: smbiosdump: fix starts_with()
 returning NULL
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On 2026-06-21T08:19:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: smbiosdump: fix starts_with() returning NULL
>
> starts_with() is declared as returning bool, but the null-argument
> guard returned NULL (a pointer cast to bool) instead of false.
> While harmless on most platforms where NULL and false both have
> value zero, it is technically incorrect.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> lib/efi_loader/smbiosdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
