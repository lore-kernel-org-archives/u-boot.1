Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A37E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74C1088EAE;
	Tue,  3 Dec 2024 20:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IrLM8MEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBFF89185; Tue,  3 Dec 2024 20:43:44 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4872788486
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-215853ed047so31377815ad.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733255020; x=1733859820; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Z3iGz0T16Vfti9f90w1ygFuYc1HIEWWR3Zx2hDXzVs=;
 b=IrLM8MEeOHjDl5E8HeEfA+r80UV/KhG7bl/wHUQfHTkjCvoq475dlQEiGRTIY74yQ2
 Xhe1FmUQuDzJXSdS6Qrr5XlPx39uzvP855cY8StJ2i2SRED+D5AKgWAZYMocnY72zTj1
 MCFbWVqASOFq4WFmmJ9gl0zKjz2sy8HXTQj5+imOkiA1mtAl1qM0Ia2mMDYIedesiJ/g
 tkiR0Fkw1O2J82QXARHa8oHpP8EpjFwMzxMBFV+Gn77MPuoYKsYMtQcF9/fMKvKQ+xym
 10YzjxQRIsa8rx7my1ni5gHjyEQp/6YPC/H/d9vBqihSQE9eT5IGrEwCmqOxa4S95ybp
 gP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255020; x=1733859820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Z3iGz0T16Vfti9f90w1ygFuYc1HIEWWR3Zx2hDXzVs=;
 b=RQz1exHkF1sYpec0PKfEdhiah1kYxi0zGHOVqzm+xRShIrink+qtVo5IdY9R1INGwI
 05rz63YgnnZI5CUcBErOacdl1kr5g3SgxrdzO7ZZWsMX/FkS7KWXDC5Wpl0HiTZVHfn6
 6hAIjMJEvWyDOyLQwutYgie0ixcEyBrMYiQTwV0u6UlUlf8mCAIKBNhxfTzjJ5Zhfxmp
 wXREABSNsmM5LDWYeF/6NZt5higt4KtSR0hu6DiLzLH5NKsIXbXgEb9DXwsmdWj3Plk5
 QX7zhEpy9lh/85fLqu1IIp56EBadz9r2VORSCcRfnM7klDvy70rXsqFBj+8PKdWmSVjj
 E/ZQ==
X-Gm-Message-State: AOJu0YwnzRgqnNx5YquENi2+B9wrS3Y6pspoQbsCqNGD5FBS6JRoq1Ax
 aFQ4PdWuNheRUyZkfNZRbDnc/uUKKnfmjuWR/7KCrwXnBAVpktvdLMWwWY/QgSjbGWDXYHB/8gq
 amJp/c3vmRCBzO9IkqP3lBJBzBsg=
X-Gm-Gg: ASbGncvwMZlOc/v3Qw45Q/zJUKQlCVXXLOUS19CysvmPAJOqqm8iuKbbeAYfI8wpdoA
 Vt7UZdADpWnp7wKoPqqTERUSc+Ccr8Q==
X-Google-Smtp-Source: AGHT+IFThA+Ix7GLXL+78OyRBi+X+FoEef/PrslG6F5r/mLmzwmXO8PcrJ5HhL0DUvcsDu821B9pp8RzDvghKO7HVJI=
X-Received: by 2002:a17:902:e546:b0:215:6af0:11d3 with SMTP id
 d9443c01a7336-215bd189da0mr52672335ad.53.1733255019737; Tue, 03 Dec 2024
 11:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-15-adrianox@gmail.com>
 <CAC_iWj+pRW2uO3uZ3zCfZ4ZnfswuRRWHMkc7+n4bGghjrpyQ2Q@mail.gmail.com>
In-Reply-To: <CAC_iWj+pRW2uO3uZ3zCfZ4ZnfswuRRWHMkc7+n4bGghjrpyQ2Q@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 3 Dec 2024 16:43:28 -0300
Message-ID: <CAMGU2hU1M19rCqVp1r96tK51ab5PT-WcGiDfePCoZktGGEMTkg@mail.gmail.com>
Subject: Re: [PATCH v6 14/14] efi_selftest: add test for IPv4 Config2 protocol
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

El mar, 3 dic 2024 a las 10:03, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> Hi Adriano
>
> On Thu, 28 Nov 2024 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > Add a test for the EFI_IP4_CONFIG2_PROTOCOL. The test sets the ip
> > policy to static, adds an ip address, and then reads the current
> > ip address and checks for it to be the same as the one that was set.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> > (no changes since v4)
> > Changes in v4:
> > - Removed unnecessary void* casts
> >
> > (no changes since v2)
> >  lib/efi_selftest/Makefile                |   2 +
> >  lib/efi_selftest/efi_selftest_ipconfig.c | 170 +++++++++++++++++++++++
> >  2 files changed, 172 insertions(+)
> >  create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c
> >
> > diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> > index 140c08effc..17fbfad116 100644
> > --- a/lib/efi_selftest/Makefile
> > +++ b/lib/efi_selftest/Makefile
> > @@ -53,6 +53,8 @@ efi_selftest_watchdog.o
> >  obj-$(CONFIG_EFI_ECPT) +=3D efi_selftest_ecpt.o
> >  obj-$(CONFIG_NETDEVICES) +=3D efi_selftest_snp.o
> >  obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_selftest_http.o
> > +obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_selftest_ipconfig.o
> > +
> >  obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) +=3D efi_selftest_devicepath.o
> >  obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) +=3D \
> >  efi_selftest_unicode_collation.o
> > diff --git a/lib/efi_selftest/efi_selftest_ipconfig.c
> b/lib/efi_selftest/efi_selftest_ipconfig.c
> > new file mode 100644
> > index 0000000000..67a7d4f411
> > --- /dev/null
> > +++ b/lib/efi_selftest/efi_selftest_ipconfig.c
> > @@ -0,0 +1,170 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * efi_selftest_ipconfig
> > + *
> > + * This unit test covers the IPv4 Config2 Protocol.
> > + *
> > + */
> > +
> > +#include <efi_selftest.h>
> > +#include <charset.h>
> > +#include <net.h>
> > +
> > +static struct efi_boot_services *boottime;
> > +
> > +static struct efi_ip4_config2_protocol *ip4_config2;
> > +static const efi_guid_t efi_ip4_config2_guid =3D
> EFI_IP4_CONFIG2_PROTOCOL_GUID;
> > +
> > +/*
> > + * Setup unit test.
> > + *
> > + * Open IPv4 Config2 protocol
> > + *
> > + * @handle:    handle of the loaded image
> > + * @systable:  system table
> > + * Return:     EFI_ST_SUCCESS for success
> > + */
> > +static int setup(const efi_handle_t handle,
> > +                const struct efi_system_table *systable)
> > +{
> > +       efi_status_t ret;
> > +       efi_handle_t *net_handle;
> > +       efi_uintn_t num_handles;
> > +       efi_handle_t *handles;
> > +
> > +       boottime =3D systable->boottime;
> > +
> > +       boottime->locate_handle_buffer(BY_PROTOCOL,
> &efi_ip4_config2_guid,
> > +                                      NULL, &num_handles, &handles);
> > +
>
> You can avoid looping over a null handle here by checking num_handles
> and remove the if (!ip4_config2) { later.
>

The (!ip4_config2) { is necessay because the protocol can fail to open too


> > +       for (net_handle =3D handles; num_handles--; net_handle++) {
> > +               ret =3D boottime->open_protocol(*net_handle,
> &efi_ip4_config2_guid,
> > +                                             (void **)&ip4_config2, 0,
> 0,
> > +
>  EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +               if (ret !=3D EFI_SUCCESS || !ip4_config2)
> > +                       continue;
> > +               break; // Get first handle that supports ipv4
> > +       }
> > +
> > +       if (!ip4_config2) {
> > +               efi_st_error("Failed to locate ipv4 config2 protocol\n"=
);
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       return EFI_ST_SUCCESS;
> > +}
> > +
> > +/*
> > + * Execute unit test.
> > + *
> > + *
> > + * Return:     EFI_ST_SUCCESS for success
> > + */
> > +static int execute(void)
> > +{
> > +       efi_status_t ret;
> > +       enum efi_ip4_config2_policy policy;
> > +       efi_uintn_t data_size;
> > +       struct efi_ip4_config2_manual_address manual_address;
> > +       struct efi_ip4_config2_manual_address orig_address;
> > +       u8 netmask[] =3D {255, 255, 255, 0};
> > +       u8 ip[] =3D {10, 0, 0, 1};
> > +
> > +       /* Setup may have failed */
> > +       if (!ip4_config2) {
> > +               efi_st_error("Setup failure, cannot proceed with
> test\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
>
> Will this run if setup fails?


I do not know, I took the skeleton from another test where this was present

>


> > +       /* Set policy to static */
> > +       policy =3D EFI_IP4_CONFIG2_POLICY_STATIC;
> > +       ret =3D ip4_config2->set_data(ip4_config2,
> EFI_IP4_CONFIG2_DATA_TYPE_POLICY,
> > +                             sizeof(enum efi_ip4_config2_policy), (voi=
d
> *)&policy);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed to set policy\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       /* Save original ip address and netmask */
> > +       data_size =3D sizeof(struct efi_ip4_config2_manual_address);
>
> sizeof(manual_address); same for the rest of the code
>
> > +       ret =3D ip4_config2->get_data(ip4_config2,
> EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> > +                             &data_size, &orig_address);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed to save original ip address and
> netmask\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       /* Set static ip and netmask */
> > +       memcpy(&manual_address.address, ip,
> > +              sizeof(struct efi_ipv4_address));
> > +       memcpy(&manual_address.subnet_mask, netmask,
> > +              sizeof(struct efi_ipv4_address));
> > +       ret =3D ip4_config2->set_data(ip4_config2,
> EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> > +                             sizeof(struct
> efi_ip4_config2_manual_address), &manual_address);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed to get ip address and netmask\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       /* Try to set interface info, this should fail */
> > +       ret =3D ip4_config2->set_data(ip4_config2,
> EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO, 0, NULL);
> > +       if (ret =3D=3D EFI_SUCCESS) {
> > +               efi_st_error("Interface info is read-only\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       /* Get ip address and netmask and check that they match with th=
e
> previously set ones */
> > +       data_size =3D sizeof(struct efi_ip4_config2_manual_address);
> > +       ret =3D ip4_config2->get_data(ip4_config2,
> EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> > +                             &data_size, &manual_address);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed to get ip address and netmask\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +       if (memcmp(ip, &manual_address.address,
> > +                  sizeof(struct efi_ipv4_address)) ||
> > +           memcmp(netmask, &manual_address.subnet_mask,
> > +                  sizeof(struct efi_ipv4_address))) {
> > +               efi_st_error("Ip address mismatch\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       /* Restore original ip address and netmask */
> > +       ret =3D ip4_config2->set_data(ip4_config2,
> EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> > +                             sizeof(struct
> efi_ip4_config2_manual_address), &orig_address);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed to restore original ip address and
> netmask\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       efi_st_printf("Efi ipconfig test execute succeeded\n");
> > +       return EFI_ST_SUCCESS;
> > +}
> > +
> > +/*
> > + * Tear down unit test.
> > + *
> > + * Return:     EFI_ST_SUCCESS for success
> > + */
> > +static int teardown(void)
> > +{
> > +       int exit_status =3D EFI_ST_SUCCESS;
> > +
> > +       return exit_status;
> > +}
> > +
> > +EFI_UNIT_TEST(ipconfig) =3D {
> > +       .name =3D "IPv4 config2 protocol",
> > +       .phase =3D EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> > +       .setup =3D setup,
> > +       .execute =3D execute,
> > +       .teardown =3D teardown,
> > +#ifdef CONFIG_SANDBOX
> > +       /*
> > +        * Running this test on the sandbox requires setting environmen=
t
> > +        * variable ethact to a network interface connected to a DHCP
> server and
> > +        * ethrotate to 'no'.
> > +        */
> > +       .on_request =3D true,
> > +#endif
> > +};
> > --
> > 2.43.0
> >
>
> Thanks
> /Ilias
>
