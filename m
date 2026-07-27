Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A4AC5321C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ACF7606E5;
	Mon, 27 Jul 2026 11:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEChXQXb6S_2; Mon, 27 Jul 2026 11:08:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B925F606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785150522;
	bh=lvpmrojrE4PVjK1ooXn5kpjGFDAvYNvavhII13SZc3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qZFagceqgSTaAIvE/S9R5+aeWLBvlKAeDfTBqTN3L0i4hoyFmkvWMx8IR1CUOKySo
	 ZK/gBAWHBp34G4kasc6nuzOSypPScQP/yiRmf8IkMe8BqzLgp+BiV+uhrTgPO9pigG
	 GyrdWWD/NLkGdcOaPULJ1nSbz4/g1Tj62X8t0lP29RmEESldFGzs/vV+8XqhjRUbx7
	 sLDM6O5c4OYcRv+SPF3DClryPCtB+mbRLgdcVaQzmP2Smr5+FHDEsl6Xo75zbt7Ok/
	 +DIxorBXYr3ozdhg1ZgrXeB7LgJkLYiXz5EgcdesZueBRnwJSAZWcKqRYp17uO5vbP
	 DrAHyX/BJb0sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B925F606A7;
	Mon, 27 Jul 2026 11:08:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDC9D26C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B40FE40694
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swdbodq1IJ7v for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:08:40 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 890BB40675
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 890BB40675
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 890BB40675
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:08:39 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8C484671; Mon, 27 Jul 2026 13:08:37 +0200 (CEST)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CD182991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 13:08:33 +0200 (CEST)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso3952395d50.1
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 04:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785150512; cv=none;
 d=google.com; s=arc-20260327;
 b=VEWbDG8jReJknNyogR3kfiAOUghBsEkB8H3d2qnQi7WmGkCpEQsY0eUFSsfWvI7ht+
 Yevi1onF97MkJ6kWPfGDf8hs+JD8FCpyBQSVz5mazzP2RgkRQBFvG/sbNvLeKO0XKbhF
 lHFurXX8yaO/5EpnxdZjW/6Gz29aJrVffJBlKu8ulyWqMG8n6D/XdxCAMUUNfZShK104
 OwL/p9VaL/tF9heWL0Us8taIckrAevbFzs65VxyLS5o0m8yMdScxY+9f3I0/0nF6gWz5
 2NHn26hrE5kKbdXeVZwmaq7SmMVNHDjZmkHrVZNYmegA+jRbN4dDvGYYfb1FySd0m/U2
 PpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lvpmrojrE4PVjK1ooXn5kpjGFDAvYNvavhII13SZc3k=;
 fh=DG0vC9xYMfPMPCdWMOrewvIZ3JtemwQ6JIsQFuoxmZI=;
 b=XVeHTEMvLSYe4Z3YXhOxoppHNZqptvEWiwUWHOIMejKChxDnSpAbIqQlhf4CrQFNsy
 +knxVITYetcBDzNe3y7xbNdZce3jHGlfppLBju96lyGdxbCzPgQnPGMhmBkv2GyVpwU7
 JteFRTRmvY9EUMUyDNw4ig9XMda2xo/pisC2nzn9+cLzQnbx9DB9rNRzv1E1fw0WN3IQ
 G0LmOTYxAf5s9VsKWWRbMcmlAI0nBnBBItZZporbZMPzs6xQTiEslZhxHkpzuiF1b3Ai
 DkHmWQo3sdZ/3AuUvTb+8nBXl1yyrePVteZo0wNLPYkb5OX7VvZsBo9NdfBnQLWBRHR6
 2u2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785150512; x=1785755312;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lvpmrojrE4PVjK1ooXn5kpjGFDAvYNvavhII13SZc3k=;
 b=V+Tes5xcAuQAx8bDQZaIiXobMIhNq5mIdfUg0tFxBGktIbxSbFt8MZmbZIvXRq0Det
 DvSVzU9peigjlsBGpz4GPZjsnRHtya3dnDPNL3RMR5j8vqCicgm+9Dkv3TGJqf4P+8hG
 rCiSAjZVUodIyHYaQIq9UDem55De75XreQCP1SkOX7ZyGf8vu+r2Dlre4VZli5iW4TZv
 wTqitiyM8pIXssYHp9XdEtVlUvs4uwKW7hC+8zAFVgzrGvwm1GTJIQ9k0bRrdM+qRXcp
 g/eGmP5N4GhqqEG+/Hnc8Y9s2GCxHsIfSyl+NvThqKCOKV3rinVgpH0PCwvaHIYBjqFe
 SW2g==
X-Gm-Message-State: AOJu0YzGWIbnX/gvSkg/SGw1Tbt7nEQCl+4R4DrpZfLlUedrpuMGZaBL
 6uusvQ+9gI+u7habxk947wENrW5jBTSC+D55Iuc+E8Zk/Xl6mshHJNMqDKHYUyZ8654l5haa+t2
 gOUfZnWwzCXvphvdnKvmlZp9KnciWSiFyH8p314eMOw==
X-Gm-Gg: AR+sD10c33A/Ffd585ZMMES+FgtORQ6VW7d3bbLFjlzSPrbyFBn92zcyGL63a7a/1mP
 tUuw4Gj21CMzSjw2OW3SZMe8owvs6Duix4+xh7owkymsREoOh0iecVWh/kJLYT8qrJrqMe1Q6uC
 XwCyQMt4/kksVnhRqIQ+3Bjy/WHyEGtXdputnHapscUGddzR5CzufVKRqMlTKaPF8IXxaO0vRWQ
 giuEI/EABMQfJffnYTqOz4DzcqbNzyINYo9khyldYFoZ+ORz2P6nGgh8TZq0Vst3UnMg2lHkN8C
 HA6RdOLLQYWyQWTcT/nCYaKw8iMijX44K49SZHThWMBg0HDFkbxSE4raqAIjF2l5NkGeDu4WVb/
 1E9njAoLc/LIK6obWPTP3p+xmWpjsvKPI79NNgW6/G/fTDcEAk9DsNaaH3qTRJdi2Y1UAYjS/kw
 XKg96uDeIcScsN5Oyld9UBdElOiU+EPw6OjODwnaksz+95UOiTViFeZRo3lf/5Agf/HIAzm0jmZ
 ECchOHWMzeNRKIdPKjXd5702ZMOSZMEcymgntvHb1rBxd6DnaZrFSEfLPU850UPgxYuxu5vQqit
 gfrHaVtPqJL1VxnJBt0waPegFDnom7mTEBDmALByIVyaHYvJzCrVlYA/y7vV
X-Received: by 2002:a05:690e:12c2:b0:668:8d0:20c with SMTP id
 956f58d0204a3-668bfdbc26emr3440528d50.20.1785150510318; Mon, 27 Jul 2026
 04:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
 <20260710-efi_security_protocol-v1-1-a06cef90057b@redhat.com>
In-Reply-To: <20260710-efi_security_protocol-v1-1-a06cef90057b@redhat.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Jul 2026 14:07:54 +0300
X-Gm-Features: AUfX_mzrZbt5Jjt2Y3E3mdmRQQakWvbY2tRT5IzaY7Cebtu4VRAwAtNU4bdJoPU
Message-ID: <CAC_iWjLaDkhrZgSbEQ6Yh7dxD9Zf8MKh0GHg83kwhwXgSas_fQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: implement EFI Security Architecture
 protocols
To: Ian Mullins <imullins@redhat.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Enric Balletbo Serra <eballetb@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Udit Kumar <u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785150512; x=1785755312; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lvpmrojrE4PVjK1ooXn5kpjGFDAvYNvavhII13SZc3k=;
 b=bfWfnrdADIm1M7lSTuFM5vMYofx/Nj4dP+1lc6tL9GSBwr4QMft8rtcJcODO4Y4qFe
 c8ZXKGCxSJ/oadIC7+mvgJnRgf6nvNPJ6HNLU/EZ2qlchMeorHgtWX7ONZZNAij4VGyP
 5S+eskWSIU5ZzgsNomPOkbCg/ag3lcrgtdzd19jVBMAUG0lmQ/hpX86kGE4BuqPJN7wn
 fkhFHEokH5lXysRu6LLkdsJG3SpgaN9npJ1x+YW6KqoaH0C5ggZStCupS90G8qAEItx0
 SoJyzGagWZx+2E3wMF3xDoBI+L4EoP7NiVBOOhTaVOpZJhWv7hfvUNdgAHbhozTHCTpE
 u66Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bfWfnrdA
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="bfWfnrdA"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Ian

Apologies for the late reply, I was off.

I have my doubts whether we should support something from the PI spec,
since we are trying to keep things confined to the EFI spec, but I'd
like to hear from Henrich as well. I guess since systemd added it we
should follow if we want to boot distros ....


[...]


> index de57823bd44..934bdd89a69 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2120,7 +2120,8 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
>         efi_dp_split_file_path(file_path, &dp, &fp);
>         ret = efi_setup_loaded_image(dp, fp, image_obj, &info);
>         if (ret == EFI_SUCCESS)
> -               ret = efi_load_pe(*image_obj, dest_buffer, source_size, info);
> +               ret = efi_load_pe(*image_obj, dest_buffer, source_size, info,
> +                                 file_path, boot_policy);

Why do we need the extra argument here? The file path on the loaded
image protocol isn't enough? If it's not then we can either pass it as
an extra argument to avoid processing DPs again or retrieve it from
the loaded image ptr. I am not sure what I prefer though

Something like
struct efi_handler *handler;
struct efi_device_path *dp1;
ret = efi_search_protocol(loaded_image_info->device_handle,
&efi_guid_device_path, &handler);
dp1 = handler->protocol_interface;

[...]

> +static efi_status_t EFIAPI
> +default_file_authentication(const struct efi_security2_arch_protocol *this,
> +                           const struct efi_device_path *device_path,
> +                           void *file_buffer, efi_uintn_t file_size,
> +                           bool boot_policy)
> +{
> +       if (efi_image_authenticate(file_buffer, file_size))
> +               return EFI_SUCCESS;
> +
> +       return EFI_SECURITY_VIOLATION;
> +}
> +
> +static struct efi_security_arch_protocol efi_security_arch = {
> +       .file_authentication_state = default_file_auth_state,
> +};
> +
> +static struct efi_security2_arch_protocol efi_security2_arch = {
> +       .file_authentication = default_file_authentication,
> +};
> +
> +/**
> + * efi_security_check_image() - authenticate image via Security2 protocol
> + *
> + * Calls the currently installed FileAuthentication callback on the
> + * EFI_SECURITY2_ARCH_PROTOCOL instance. This may be the default handler
> + * (which delegates to efi_image_authenticate()) or a custom override
> + * installed by an EFI application such as systemd-stub.
> + *
> + * @file_path:         device path of the image being loaded
> + * @file_buffer:       pointer to the image data
> + * @file_size:         size of the image data
> + * @boot_policy:       true if image is being loaded as a boot option
> + * Return:             EFI_SUCCESS if authenticated, error code otherwise
> + */
> +efi_status_t efi_security_check_image(const struct efi_device_path *file_path,
> +                                     void *file_buffer, efi_uintn_t file_size,
> +                                     bool boot_policy)
> +{
> +       return efi_security2_arch.file_authentication(&efi_security2_arch,
> +                                                     file_path, file_buffer,
> +                                                     file_size, boot_policy);

Can't a different EFI application install that protocol? We are only
using the local copy here

> +}
> +
> +/**
> + * efi_security_arch_register() - install Security Architecture Protocols
> + *
> + * Installs both EFI_SECURITY_ARCH_PROTOCOL and EFI_SECURITY2_ARCH_PROTOCOL
> + * on the root handle during EFI subsystem initialization.
> + *
> + * Return:     status code
> + */
> +efi_status_t efi_security_arch_register(void)
> +{
> +       efi_status_t ret;
> +
> +       ret = efi_add_protocol(efi_root, &efi_guid_security_arch_protocol,
> +                              (void *)&efi_security_arch);
> +       if (ret != EFI_SUCCESS) {
> +               log_err("Cannot install EFI_SECURITY_ARCH_PROTOCOL\n");
> +               return ret;
> +       }
> +
> +       ret = efi_add_protocol(efi_root, &efi_guid_security2_arch_protocol,
> +                              (void *)&efi_security2_arch);
> +       if (ret != EFI_SUCCESS)
> +               log_err("Cannot install EFI_SECURITY2_ARCH_PROTOCOL\n");
> +
> +       return ret;
> +}

[...]

Thanks
/Ilias
