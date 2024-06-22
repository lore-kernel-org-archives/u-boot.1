Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D0EC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 18:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7075288001;
	Sat, 22 Jun 2024 20:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tC03+Yoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D119D880DB; Sat, 22 Jun 2024 20:01:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F2287D14
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 20:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719079279; x=1719684079; i=xypron.glpk@gmx.de;
 bh=xLBRnzTDZ68TQWWv6H+I5uq/EdDuKXmS+IAfbXHbURA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tC03+YozPoIafoEFcTdI4l7JBZ0ewXugQavMewtxrMHhOab8mJKP3x36E54iltDK
 BEzgsGRbgOL7J9xf9eOkET8rEJ4DBIa7X+/t0u8FHh5NT4FOBxqWc5aTgYuCG3kL5
 GIYUtPZBMjB6irKpe8b2pMZsXRwM7lM/Z25AnVQJxE9CNOP0QclaLQ5Rzjxqai5KV
 eHei1BXMAvdju5Il/EaKfe1MLxmdgn/9oNNxndbVD/7Awnlb3SD9MHecBUQpzsyjM
 Q2Ff7vMMiVjey61iIesFLEZRWSR8u4cahtzGo1+oL1BNzil7MtP2vFTOh0ebqY+Gz
 tSgJ2FJCS6bJC7rU5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.41.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1sDhRs0tHn-00CdF4; Sat, 22
 Jun 2024 20:01:19 +0200
Date: Sat, 22 Jun 2024 20:01:16 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH 2/7] efi_loader: fix the return values on efi_tcg
User-Agent: K-9 Mail for Android
In-Reply-To: <CAC_iWjLgc+uH6=Wde=JsC9NK-TZsK7Uqa8J3Yz4uSSgdkTaNHA@mail.gmail.com>
References: <20240622143601.187723-1-ilias.apalodimas@linaro.org>
 <20240622143601.187723-3-ilias.apalodimas@linaro.org>
 <7abc8f32-8186-4e2b-a9f8-3b032738dbcf@gmx.de>
 <CAC_iWjLgc+uH6=Wde=JsC9NK-TZsK7Uqa8J3Yz4uSSgdkTaNHA@mail.gmail.com>
Message-ID: <1EFAD1D3-670A-495D-B4A2-3591FF24823B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZmIw/PDl1Rcna0Wzogs8bhJzH4EX9GJuhThqcwhv1TDS7NRf/vE
 sAibB1VTVX3mcdYQLFOvMvRaUWUnGsQNAZ7D9wbZ3yrDDdsI+INn6oHA/Ad00w7sIlllGQq
 dvggraQ4mEG1rRv0JpkYXlCY8DBUTZH4N2+zpqvEXBpQyutLhCIDSS2cIn5wmluKUjOLVCF
 5cj2ZKUeuhFknQf86lQCQ==
UI-OutboundReport: notjunk:1;M01:P0:kRGY3Kw1vHE=;i/ktk2vxHa0QGvpMW8cf0ZrB9kV
 rzJS/JC8Iy+6hBKXMlFsjsVYRFBjInBBROhNHJGPUY45Wl8zh0vyh3zF6nnoE96u7Fn5BmH/8
 hsBMQudkFp7T4yb2ihYa0s/dRGIC91LWCIP1gFdR1Q4HA0xEL5uGihaYEF7rLgqr3PsYoXorR
 pN2vze8/BY1mmNdSFXhjrMJFa79zahUlxdZbA1nk2BO4oUDjrpw5NfTWrqxdyXc3guW1antoL
 Oi8X2yF97iJ/4zmbheGpXepbNIic+tzh+GDpUggEqrzszmDE84v9thuqIpfxOeu49sItRq9BJ
 3ceFL0y7eecSNhx2SawL5UfDqwcIQLs2Ej/jfeKCcPzBnCj0VKmjhIggZygoBipaUOKm8GyfV
 jwakEbDVVUS747R6mJOxXX5nyXjF4PUUe7wTcPjC9y+GUZAgN1uDZmOERnmD3XzMCW5DmRNa5
 NVo9EYtG8LLd31FE6ZZWO+vGV+Ncz/MDvPipD4n7H2w4dEO9GDwVY6CigVynjp/1ZFRQNh8vG
 9OtrBaD3VWCe4BQ2M4mQP7O7L9B7nj9lOxiUZnzMUN4rQ0ly/NeWlLAmCXRtIdK9B9wfEDuwQ
 G3P3xrHvwUIBixL3lFXCayQufb2vqrZnt4AifsM8eA3gTWEvRj2s3TVNMJxDWE0sTD5pwoG7v
 fSb0t1Gd0k8FDNFVkX1ZMUKospIoB63CW8VoFrIdvsxwqaWkAys4wlJnnCQTuocuqUlaPv/If
 +wk17ITX6j7JGWnxSKLPY+UH/NjcvDyPkSpCA/2uD4F1ws97LS8tAUVay86AD/6zyYOt1XhbO
 nKGiWVYt87AlwKzB0DJ2xUiY455hPgs6JjRgIemEhWvYs=
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



Am 22=2E Juni 2024 18:09:40 MESZ schrieb Ilias Apalodimas <ilias=2Eapalodi=
mas@linaro=2Eorg>:
>Hi Heinrich,
>
>[=2E=2E=2E]
>
>> >       rc =3D tpm2_submit_command(dev, input_param_block,
>> >                                output_param_block, &resp_buf_size);
>> > @@ -714,19 +721,20 @@ efi_tcg2_get_active_pcr_banks(struct efi_tcg2_p=
rotocol *this,
>> >                             u32 *active_pcr_banks)
>> >   {
>> >       struct udevice *dev;
>> > -     efi_status_t ret;
>> > +     efi_status_t ret =3D EFI_INVALID_PARAMETER;
>> >
>> >       EFI_ENTRY("%p, %p", this, active_pcr_banks);
>> >
>> > -     if (!this || !active_pcr_banks) {
>> > -             ret =3D EFI_INVALID_PARAMETER;
>> > +     if (!this || !active_pcr_banks)
>> >               goto out;
>> > -     }
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +
>> > +     if (tcg2_platform_get_tpm2(&dev))
>>
>> EFI_INVALID_PARAMETER does not convey the problem type=2E
>> Should we return EFI_DEVICE_ERROR here?
>>
>> The authors of the specification only foresaw one or more of the
>> parameters being incorrect (EFI_INVALID_PARAMETER)=2E
>
>I completely agree that the result is misleading=2E However, I'd prefer
>sticking to the spec for now and maybe add a comment?
>
>
>>
>> > +             goto out;
>> > +
>> > +     if (tcg2_get_active_pcr_banks(dev, active_pcr_banks))
>>
>> EFI_DEVICE_ERROR?
>
>Same here
>
>Thanks for the qucik review!
>/Ilias


Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>>
>> Best regards
>>
>> Heinrich
>>
>> >               goto out;
>> >
>> > -     ret =3D tcg2_get_active_pcr_banks(dev, active_pcr_banks);
>> > +     ret =3D EFI_SUCCESS;
>> >
>> >   out:
>> >       return EFI_EXIT(ret);
>> > @@ -852,14 +860,15 @@ static efi_status_t measure_event(struct udevic=
e *dev, u32 pcr_index,
>> >                                 u32 event_type, u32 size, u8 event[])
>> >   {
>> >       struct tpml_digest_values digest_list;
>> > -     efi_status_t ret;
>> > +     efi_status_t ret =3D EFI_DEVICE_ERROR;
>> > +     int rc;
>> >
>> > -     ret =3D tcg2_create_digest(dev, event, size, &digest_list);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +     rc =3D tcg2_create_digest(dev, event, size, &digest_list);
>> > +     if (rc)
>> >               goto out;
>> >
>> > -     ret =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +     rc =3D tcg2_pcr_extend(dev, pcr_index, &digest_list);
>> > +     if (rc)
>> >               goto out;
>> >
>> >       ret =3D tcg2_agile_log_append(pcr_index, event_type, &digest_li=
st,
>> > @@ -901,10 +910,10 @@ static efi_status_t efi_init_event_log(void)
>> >       struct tcg2_event_log elog;
>> >       struct udevice *dev;
>> >       efi_status_t ret;
>> > +     int rc;
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > -             return ret;
>> > +     if (tcg2_platform_get_tpm2(&dev))
>> > +             return EFI_DEVICE_ERROR;
>> >
>> >       ret =3D efi_allocate_pool(EFI_BOOT_SERVICES_DATA, TPM2_EVENT_LO=
G_SIZE,
>> >                               (void **)&event_log=2Ebuffer);
>> > @@ -933,9 +942,11 @@ static efi_status_t efi_init_event_log(void)
>> >        */
>> >       elog=2Elog =3D event_log=2Ebuffer;
>> >       elog=2Elog_size =3D TPM2_EVENT_LOG_SIZE;
>> > -     ret =3D tcg2_log_prepare_buffer(dev, &elog, false);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +     rc =3D tcg2_log_prepare_buffer(dev, &elog, false);
>> > +     if (rc) {
>> > +             ret =3D (rc =3D=3D -ENOBUFS) ? EFI_BUFFER_TOO_SMALL : E=
FI_DEVICE_ERROR;
>> >               goto free_pool;
>> > +     }
>> >
>> >       event_log=2Epos =3D elog=2Elog_position;
>> >
>> > @@ -1306,8 +1317,7 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
>> >       if (!is_tcg2_protocol_installed())
>> >               return EFI_SUCCESS;
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +     if (tcg2_platform_get_tpm2(&dev))
>> >               return EFI_SECURITY_VIOLATION;
>> >
>> >       rsvmap_size =3D size_of_rsvmap(dtb);
>> > @@ -1356,8 +1366,7 @@ efi_status_t efi_tcg2_measure_efi_app_invocatio=
n(struct efi_loaded_image_obj *ha
>> >       if (tcg2_efi_app_invoked)
>> >               return EFI_SUCCESS;
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +     if (tcg2_platform_get_tpm2(&dev))
>> >               return EFI_SECURITY_VIOLATION;
>> >
>> >       ret =3D tcg2_measure_boot_variable(dev);
>> > @@ -1406,9 +1415,8 @@ efi_status_t efi_tcg2_measure_efi_app_exit(void=
)
>> >       if (!is_tcg2_protocol_installed())
>> >               return EFI_SUCCESS;
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > -             return ret;
>> > +     if (tcg2_platform_get_tpm2(&dev))
>> > +             return EFI_SECURITY_VIOLATION;
>> >
>> >       ret =3D measure_event(dev, 4, EV_EFI_ACTION,
>> >                           strlen(EFI_RETURNING_FROM_EFI_APPLICATION),
>> > @@ -1437,9 +1445,10 @@ efi_tcg2_notify_exit_boot_services(struct efi_=
event *event, void *context)
>> >               goto out;
>> >       }
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +     if (tcg2_platform_get_tpm2(&dev)) {
>> > +             ret =3D EFI_SECURITY_VIOLATION;
>> >               goto out;
>> > +     }
>> >
>> >       ret =3D measure_event(dev, 5, EV_EFI_ACTION,
>> >                           strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
>> > @@ -1469,9 +1478,8 @@ efi_status_t efi_tcg2_notify_exit_boot_services=
_failed(void)
>> >       if (!is_tcg2_protocol_installed())
>> >               return EFI_SUCCESS;
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > -             goto out;
>> > +     if (tcg2_platform_get_tpm2(&dev))
>> > +             return EFI_SECURITY_VIOLATION;
>> >
>> >       ret =3D measure_event(dev, 5, EV_EFI_ACTION,
>> >                           strlen(EFI_EXIT_BOOT_SERVICES_INVOCATION),
>> > @@ -1551,8 +1559,7 @@ efi_status_t efi_tcg2_do_initial_measurement(vo=
id)
>> >       if (!is_tcg2_protocol_installed())
>> >               return EFI_SUCCESS;
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS)
>> > +     if (tcg2_platform_get_tpm2(&dev))
>> >               return EFI_SECURITY_VIOLATION;
>> >
>> >       ret =3D tcg2_measure_secure_boot_variable(dev);
>> > @@ -1577,8 +1584,7 @@ efi_status_t efi_tcg2_register(void)
>> >       struct efi_event *event;
>> >       u32 err;
>> >
>> > -     ret =3D tcg2_platform_get_tpm2(&dev);
>> > -     if (ret !=3D EFI_SUCCESS) {
>> > +     if (tcg2_platform_get_tpm2(&dev)) {
>> >               log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\=
n");
>> >               return EFI_SUCCESS;
>> >       }
>> > @@ -1586,6 +1592,7 @@ efi_status_t efi_tcg2_register(void)
>> >       /* initialize the TPM as early as possible=2E */
>> >       err =3D tpm_auto_start(dev);
>> >       if (err) {
>> > +             ret =3D EFI_DEVICE_ERROR;
>> >               log_err("TPM startup failed\n");
>> >               goto fail;
>> >       }
>>
