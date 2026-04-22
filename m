Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFE8F94CB7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A852840D8;
	Wed, 22 Apr 2026 03:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QktUoV00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2A28412A; Wed, 22 Apr 2026 03:16:07 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0554805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2aaf43014d0so29941415ad.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820562; cv=none;
 d=google.com; s=arc-20240605;
 b=c8HFjarGOAZIsDwT8Yvwq9b5HUmd+X4/kj+SGIdPsilOwtYae2RdBpji5lA2g9567x
 tEDsIcHFUM28PVklmZ36vR7UfMXOvm98xeBf/DC0EDnJUHCvyT/mAX7RRZUSIUewsFz3
 4XI7VWYt1+cgSelFGXApqNcOoMJy3wE8G5fkJjUMOd0RoDPGQJX/HT2MxwKZk++PMiXD
 LXB+VJ7jXbLJ8is+u33NkrcApTLJOYbR6SWCjN42FUy/AT0iKqsVHHnnUtTCu5+h2DPK
 0e9VXQvWZAZa9QkE47EQwKw64IYrIcKlNlEijTnxKsXSFvvQwz5/SttUvr2om+AJLO4t
 CU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f380575tfjgH/MpP8yId6uNPN9ubVecTNmizm5ioL30=;
 fh=B286HwM6/Dv+o0K0VY9DuUJQtpHJO1IEYbBzrGusgA8=;
 b=jxUk6MRFC/830FKrQ1D8MZZOUFViN+l1VsrM3pM1VRftYlw1rBaIrrlLZNsbvfx6XR
 D1xtIlB7xbeOhwtVDKefbuRZK8vQLvIJWAtYs3VZrPDbv+NrXG8BY8S9Ruw7Q3zA3x0k
 Q7sVERBhrCzHPe+kBqvmxDxBtL9oyG7ayfdZW0mcNbSjdiDrxR6rE1uqQnTgdbJ5j8en
 VKy73QOeupDy6vxJY0OhDjmmTznJ6AVQRti7h4hVb91Ailgg+cm0lBCbmGqBrlLftCG4
 WDNJ5gpUJNz7iTLXSPBxi6+EN4Ew+XHhDNy2A7wmHGiyZt/eWxH9zUUlhuawY/8FgO/9
 3Neg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820562; x=1777425362; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f380575tfjgH/MpP8yId6uNPN9ubVecTNmizm5ioL30=;
 b=QktUoV00w3W+zKehl+ouz51jUrvc6fC8qsmgyTVL3rKbiI7/inWAcp/Oeb4nSPL/Uk
 7f+LIisAsbpeM72pN5mT6F1HWSUzF/1AiNoVHcnXgnl5Yn1DU4XKfhlst9ifS7cW5uSQ
 jsh2jQfi0RlwfgXd7kwarE+II9hf5DmLuKj+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820562; x=1777425362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f380575tfjgH/MpP8yId6uNPN9ubVecTNmizm5ioL30=;
 b=gVCGPubYR1F++c0TXAFpaPwaCJCGaJgNux/LEVs4u39Pm9kHTMaot0LYBHCMNNb3V7
 dzdqGlND/BVMGyEQaB69NWL8Mn1XEOFoynD/0b+OO9Tin5CO6O0Bs025kxdoFOtPTKt9
 l7WeG1NFRWuvq2vKDghcHuNRDbTkxFCSljnAZdVlcimEf8beOnT6gwmWYtHa6U5GGV8G
 wW9z7w5m5qZgtP/TJXDHKeEl8azXInRw0py6CVv2kez4be580OVBhTOLSjqjXqEJkouO
 /dPRfcv6zFIaVpjS5I01gKkXtLFrWdu0HeGtkCeBV3HpNrHrkIcFFwpDjlrJ6YDBGrrg
 fvRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BDe/vLQNaLRs58JwTa4AQ1TKz3NI8jjtG3pebQa96eJMgvj9yC4eXFLRXAS4BXzgDbzZTp18=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0Nj8n9LmkxX6FCOagM2BNyhWp1+m0ISFHlcRZYz2V6NEQiW0p
 nBBijrojehB2naoRN8woFv4sxzyLNoE6bimCIDPG0hQ/HcJAFG8Su5inZUyKsI8GRlbe90RSaEm
 GfV2QR7viMimvlfkce9X2VuUp/fvu3hIa1b1qm6xPzWleymVYVqmEcw==
X-Gm-Gg: AeBDievE+zDPWCevpslWOy6h+TSh2G18Gx0CF1qoh8cz7xElyVGPNIfAbLjgTBPFent
 xv/c5I3sWZ1/7T41IijI0OEH5mu4AmF69bJZAlyiWgtvNVq+rzRwiWv97lOPgXj2patzxVjOsId
 dJPlW6YbQ/PBb1WDFVxgQcHSW41KnQVEvdZT4+dJRYbA8jS9Lg4MhD0pVcUQnSYnvGpilt+AXvN
 UjhaTBLUnApfahyP1LDazfB5/tZYTjtd5M3OZLfpKyy3NsOqYD2obXer2swn3TT1JmIh/rUFJYc
 K08WdChlrakJRLXo4FiX
X-Received: by 2002:a17:903:1ac6:b0:2b2:5840:809c with SMTP id
 d9443c01a7336-2b5f9e77d75mr205753515ad.1.1776820561580; Tue, 21 Apr 2026
 18:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
 <20260420220321.71147-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220321.71147-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:15:34 +1200
X-Gm-Features: AQROBzBBxwk_NE5xUTovt753nHDQF1G0fxskF2i4Jk1nUjD3CnHk5XIUDCHo7PQ
Message-ID: <CAFLszTjFgs+igGXmmi8Ec9fjThBvWKnTgOBLSCiLJX0QzrgYpQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] efi_loader: centralize messaging for
 efi_init_obj_list
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>, 
 Ying-Chun Liu <paul.liu@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
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

Hi Heinrich,

On 2026-04-20T22:03:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: centralize messaging for efi_init_obj_list
>
> If efi_init_obj_list() fails we cannot use the UEFI sub-system.
>
> * Instead of having messages for this everywhere write an error message
>   in efi_init_obj_list().
> * Always use (ret != EFI_SUCCESS) when checking the return value of
>   efi_init_obj_list().
> * Remove the return code from the error message as it does not help
>   users to understand which initialization went wrong.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> boot/bootmeth_efi_mgr.c      |  4 ++--
>  cmd/bootefi.c                |  5 +----
>  cmd/bootmenu.c               |  6 +-----
>  cmd/eficonfig.c              |  6 +-----
>  cmd/efidebug.c               |  5 +----
>  cmd/nvedit_efi.c             | 10 ++--------
>  lib/efi_loader/efi_bootbin.c |  5 +----
>  lib/efi_loader/efi_bootmgr.c |  5 +----
>  lib/efi_loader/efi_setup.c   |  2 ++
>  9 files changed, 12 insertions(+), 36 deletions(-)

> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> @@ -58,8 +58,8 @@ static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *bflow)
> -     if (ret)
> -             return log_msg_ret('init', ret);
> +     if (ret != EFI_SUCCESS)
> +             return ret;

This function returns int but you are returning an efi_status_t directly.

Please can you keep using log_msg_ret() here, maybe with -EIO, or
convert to an appropriate negative errno value?

Regards,
Simon
