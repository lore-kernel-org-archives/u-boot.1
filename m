Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF215F5A8AA
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E70B843E8;
	Mon, 20 Apr 2026 21:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KmaGlCLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BCF843FB; Mon, 20 Apr 2026 21:33:18 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73C2C84376
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso542842166b.2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713596; cv=none;
 d=google.com; s=arc-20240605;
 b=LQbvJsWpFi0A74y0gq1Lgai8qi7N/tvz9GUjUB+Ps36tnUeXd2VsgMKFvcHE9S7dCK
 moahDtaVtA7qokXYAtzSFSxfH7CXWBfQFDo+W7V0BxQig0YXiy/5MLCqoNUzlxq5wTm7
 atuovvvYgKwN9KIPGFq2zUqr7pvin+Bx9OHdapYDj60WELdU5i9ejDIs2IHIhvl6HDZt
 /LsjsuxULA9/4gMI9mVV+LKSRESCXxG7hIHmmAuXN6Sjm2F+7IMbaD0cfw29FGpUXCTc
 rSvVVcwS+Y3/KYD055H48GvQKVuGOQwh4CFyPnGMeAO1mQK4ymSL2PjsOQLz/02b0xc6
 wFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F0qlHXO6unjbTTT5FxCzGFalT0ARGbjBVpZeEppNxSc=;
 fh=afIVLVOhbzX4mWNbJEdy2Mzjb/g1FacYg8eVZsuwhDM=;
 b=Qye9MD608yJ/6sCZvnzHegRsDz5279RK64TugMy6EFkGVEKihIcTBQ/YxdgNCzwUkc
 WKWXPHjPFYE2s79X4u1IGWTDOMRRpzjRRA2blDDB346sGswqyuLJCnjEIKIVlfGKzCiy
 EZ2EwogQAfSesrL9UHs2Xe9otEpBrWgrY9DoZp9CoXeArEmICOW7mfZ+0XQhBtJrLViq
 Ce22NJdimrtwKzuM1vrivCzpPoPkTeoUspP160fhNFrK4FfVfdDCK0J8Lmk/1Q1A+oAp
 gJm5rsxF6C3e2Cne5K3mhtE57/gsYaVtHy1alZtGZEBSNQgOkpZiJrvlPXPapvomEhJb
 OiZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713596; x=1777318396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F0qlHXO6unjbTTT5FxCzGFalT0ARGbjBVpZeEppNxSc=;
 b=KmaGlCLejfKYBnGX4na4HsP5s0REdZSdDzKiY7pHkXcCaVJjWvtv/3ngX9cUHqXF9Q
 beZ1X63NC0m7eX6xoZTnfiF1FmKLX9S25zW0rfI8T4EEL2Atdicn2256802vcGSUjYRN
 p12ivq82LDHFo+evcGjkbyMl96INu+H4J0ySE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713596; x=1777318396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0qlHXO6unjbTTT5FxCzGFalT0ARGbjBVpZeEppNxSc=;
 b=f7gstUI9YFlN0BMb+8NcOhkRcPsQ+VaoNz4qJNueQk87umZD1Kx86beketY4tkfzrT
 X9SAVSFdDO4JxSf7JBqvLwlfNARf9UK5mcvLVe0B9M4fo14gDfKJ6Hqfalt7gtCZocjd
 XKuq4eLaJvHhY9vhAiIgCJpnZBiob73r+/GJpC6MPyeqblN7Ge/zJeyrRMDaIIBeCF2G
 LFC4HEubn0NWRmVZVxP6xJwkfB1BbkaYbPfLz+VbsBtvGGFvt93OAKMQfoAyN00QLUrY
 cLWRAA6lrO2l/W2MvREh0+tn37tkdzrmrmxaWSqohln8/qGnQDHVJpJpQrdkS3Dtlo1N
 h7IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gExNIHa9fhJ0jr1OkdvSFKH2cakYxq+CNlCGABe47iogQdUQAq6Gu2dqUSRu6T4ecd7GHcWE=@lists.denx.de
X-Gm-Message-State: AOJu0YzLk9iSgsxxY5QoALq4m81ifdGFp13F7kBK2lbmL02Bwb/yEfwP
 sI6SHIf+GLASVkNSIKb7ExGo9PS7h2Rc06GOUVp2oibJsQlFsHFJE65uqO3YQf6CJ5ArFmpX8Qf
 xlfOZnudxG0P/HI+A5gIlSYDvUOI4glJqfXUngTGG
X-Gm-Gg: AeBDievn+60KLieW5T6+m09RnJuzxILBi0aosJJ9TOh2EBf6MQa2gEs4W+KnCojADub
 FYs62Gf5hlODbmgGQmGY5+Alb75AUqj/yJs51DSRrBNFnDOY9IxM/p+VBDr6DOe17pkS54dFSyB
 D3PIfuM9TyP5xCC5qMDomDbCxzEYx5NSmy4sRj+tSY7gMXMcL5Jrh4aLMnXyHBb6m5yOzw4So9e
 sJVo2lzTMp6u4Ee4rLsVaJRPUQYmQPrNRmVUVJreB/phpl9u5OwLS/YXjT5zBvHQ56nhQTuamG2
 1g+6X4f6rfcASaXYkMxb
X-Received: by 2002:a17:906:ba84:b0:ba4:8288:b464 with SMTP id
 a640c23a62f3a-ba48288b8demr690647866b.6.1776713595907; Mon, 20 Apr 2026
 12:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260418175814.5731-1-heinrich.schuchardt@canonical.com>
 <20260418175814.5731-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260418175814.5731-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:33:02 +1200
X-Gm-Features: AQROBzBEzyP0wkNgTdo4hbTKSJniQNT5wIKNH6WtyG-AW1C3tESbubqALMpsjS0
Message-ID: <CAFLszTh0CsEVE6uhaLgZTuG4U=a=k-OTDaG1rjMX7OwKc5Ozcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: centralize messaging for efi_init_obj_list
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>, Javier Tia <floss@jetm.me>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

On 2026-04-18T17:58:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: centralize messaging for efi_init_obj_list
>
> If efi_init_obj_list() fails we cannot use the UEFI sub-system.
>
> * Instead of having messages for this everywhere write an error message
>   in efi_init_obj_list().
> * Always use (ret =! EFI_SUCCESS) when checking the return value of

should be !=

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

> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> @@ -1310,11 +1310,8 @@ efi_status_t efi_bootmgr_run(void *fdt)
> +     if (ret != EFI_SUCCESS)
> +             return CMD_RET_FAILURE;

Pre-existing issue: efi_bootmgr_run() returns efi_status_t but
CMD_RET_FAILURE is 1 - since you are touching this code, please can
you fix it to return ret instead, if that is the intent?

> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> @@ -224,11 +224,8 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
> +     if (ret != EFI_SUCCESS)
> +             return -1;

Similarly, efi_binary_run_dp() should return ret rather than -1

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
