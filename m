Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7538FE64A8A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B66893D9;
	Tue,  3 Dec 2024 14:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x9cgxlDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C76B893D9; Tue,  3 Dec 2024 14:03:38 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D1F89535
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6efa1e49ef0so19951387b3.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733231015; x=1733835815; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSfNwFlfCycyHeRakOgqMySrRctzxjFQXb8M+cp7UKU=;
 b=x9cgxlDL+zppNCTCCuM50eytaNbxEVZwJP8zzAhdFYJu42rtu8vlisb5HOHGMwY0Gr
 uXhMyJPm87K3csaVPYz2JGCg7a1aNkRhyB2xPBrQJPNBvMPbNj8rWN3MWmSAPyYqcW83
 h2Coxlk65veaT47xa9sJQI2JvUSo0KFt35XgvjTo0aca/zInN7luUc9Gm16OohuX+TDN
 M8HfWBhQBnPilCAucjU0eBl2GRfVch83i9O6+5o5vAtrCG2AYmpXyGfJwKQdP02JwvFh
 sFkOZdMtiqLIl+0b/PO112JPNtc1UYBxl1bjYVugvqbCEmKURjKpKlHvXsv0UrXzGckK
 E08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733231015; x=1733835815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSfNwFlfCycyHeRakOgqMySrRctzxjFQXb8M+cp7UKU=;
 b=UTex0tcYt6dyzOTndPJZoXFk0MAqw9zdMU/l+qfALLLIy3c8jhPNSCdsSw/qZQ4d/O
 Gvyaq9N9padberoqiMcSLTJgAgw+iWUi4+Fk1MyHz2OD17e5rXKZ2JON1ZR11nSyqM2Q
 lvo7HSpqhSt6kguiy/2syqOl6pfV1TWDVL1TehFUeD4zWma/WUFCtUpgymXc4b9ZSxH8
 zj5nRuIL39uzHz9ms++LGGUMsjpNtQMuj9h5Dus/rPXueqKCVMiOlibtAtoMoVFMd2Wk
 B0qS5Q6AxpuIeNkF6UFf+Ac+CFpLFFEj8pWs4TLR2xYyJXJbYfr0G3r4qn0NWBGm75qS
 m1Jg==
X-Gm-Message-State: AOJu0Yw5Rh14xnyRumGhNaYEXsUhgKO4p7WT/sfl3WgcRDLN6697XRrI
 g4GfOn6WdR/FeuiWKrGH0ZASUlJnAW7ffjyriBonQHrEwj8do1nw1H2Z+L+jcvkpNRISypvs9VG
 kVNE9m8pwTnIELj5tfrN/iSb/RZhwUmc9Skqxdw==
X-Gm-Gg: ASbGnctn1cRjOGveYrKr7Pxg1cdx4w3aTYVSBWksheLV97n2kiRoH2cBZanWIaydFBy
 KV3B+PizWl15qQtYImkyv+3KC3wPmjJg=
X-Google-Smtp-Source: AGHT+IEEDxVIrbWsA9F1bTM9nEfTvra6BlnaB21GRXN5lz82CaXHFIGL4voXnQHvs7yq9atfQxCbebbfF4DBxe0PWKQ=
X-Received: by 2002:a05:690c:6113:b0:6ef:5688:f966 with SMTP id
 00721157ae682-6efad32b823mr31306027b3.37.1733231014649; Tue, 03 Dec 2024
 05:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-15-adrianox@gmail.com>
In-Reply-To: <20241128144416.604126-15-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Dec 2024 15:02:58 +0200
Message-ID: <CAC_iWj+pRW2uO3uZ3zCfZ4ZnfswuRRWHMkc7+n4bGghjrpyQ2Q@mail.gmail.com>
Subject: Re: [PATCH v6 14/14] efi_selftest: add test for IPv4 Config2 protocol
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
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

Hi Adriano

On Thu, 28 Nov 2024 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add a test for the EFI_IP4_CONFIG2_PROTOCOL. The test sets the ip
> policy to static, adds an ip address, and then reads the current
> ip address and checks for it to be the same as the one that was set.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
> (no changes since v4)
> Changes in v4:
> - Removed unnecessary void* casts
>
> (no changes since v2)
>  lib/efi_selftest/Makefile                |   2 +
>  lib/efi_selftest/efi_selftest_ipconfig.c | 170 +++++++++++++++++++++++
>  2 files changed, 172 insertions(+)
>  create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c
>
> diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> index 140c08effc..17fbfad116 100644
> --- a/lib/efi_selftest/Makefile
> +++ b/lib/efi_selftest/Makefile
> @@ -53,6 +53,8 @@ efi_selftest_watchdog.o
>  obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
>  obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
>  obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
> +obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_ipconfig.o
> +
>  obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_selftest_devicepath.o
>  obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += \
>  efi_selftest_unicode_collation.o
> diff --git a/lib/efi_selftest/efi_selftest_ipconfig.c b/lib/efi_selftest/efi_selftest_ipconfig.c
> new file mode 100644
> index 0000000000..67a7d4f411
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_ipconfig.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * efi_selftest_ipconfig
> + *
> + * This unit test covers the IPv4 Config2 Protocol.
> + *
> + */
> +
> +#include <efi_selftest.h>
> +#include <charset.h>
> +#include <net.h>
> +
> +static struct efi_boot_services *boottime;
> +
> +static struct efi_ip4_config2_protocol *ip4_config2;
> +static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
> +
> +/*
> + * Setup unit test.
> + *
> + * Open IPv4 Config2 protocol
> + *
> + * @handle:    handle of the loaded image
> + * @systable:  system table
> + * Return:     EFI_ST_SUCCESS for success
> + */
> +static int setup(const efi_handle_t handle,
> +                const struct efi_system_table *systable)
> +{
> +       efi_status_t ret;
> +       efi_handle_t *net_handle;
> +       efi_uintn_t num_handles;
> +       efi_handle_t *handles;
> +
> +       boottime = systable->boottime;
> +
> +       boottime->locate_handle_buffer(BY_PROTOCOL, &efi_ip4_config2_guid,
> +                                      NULL, &num_handles, &handles);
> +

You can avoid looping over a null handle here by checking num_handles
and remove the if (!ip4_config2) { later.

> +       for (net_handle = handles; num_handles--; net_handle++) {
> +               ret = boottime->open_protocol(*net_handle, &efi_ip4_config2_guid,
> +                                             (void **)&ip4_config2, 0, 0,
> +                                             EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +               if (ret != EFI_SUCCESS || !ip4_config2)
> +                       continue;
> +               break; // Get first handle that supports ipv4
> +       }
> +
> +       if (!ip4_config2) {
> +               efi_st_error("Failed to locate ipv4 config2 protocol\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       return EFI_ST_SUCCESS;
> +}
> +
> +/*
> + * Execute unit test.
> + *
> + *
> + * Return:     EFI_ST_SUCCESS for success
> + */
> +static int execute(void)
> +{
> +       efi_status_t ret;
> +       enum efi_ip4_config2_policy policy;
> +       efi_uintn_t data_size;
> +       struct efi_ip4_config2_manual_address manual_address;
> +       struct efi_ip4_config2_manual_address orig_address;
> +       u8 netmask[] = {255, 255, 255, 0};
> +       u8 ip[] = {10, 0, 0, 1};
> +
> +       /* Setup may have failed */
> +       if (!ip4_config2) {
> +               efi_st_error("Setup failure, cannot proceed with test\n");
> +               return EFI_ST_FAILURE;
> +       }
> +

Will this run if setup fails?

> +       /* Set policy to static */
> +       policy = EFI_IP4_CONFIG2_POLICY_STATIC;
> +       ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_POLICY,
> +                             sizeof(enum efi_ip4_config2_policy), (void *)&policy);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to set policy\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       /* Save original ip address and netmask */
> +       data_size = sizeof(struct efi_ip4_config2_manual_address);

sizeof(manual_address); same for the rest of the code

> +       ret = ip4_config2->get_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> +                             &data_size, &orig_address);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to save original ip address and netmask\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       /* Set static ip and netmask */
> +       memcpy(&manual_address.address, ip,
> +              sizeof(struct efi_ipv4_address));
> +       memcpy(&manual_address.subnet_mask, netmask,
> +              sizeof(struct efi_ipv4_address));
> +       ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> +                             sizeof(struct efi_ip4_config2_manual_address), &manual_address);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to get ip address and netmask\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       /* Try to set interface info, this should fail */
> +       ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO, 0, NULL);
> +       if (ret == EFI_SUCCESS) {
> +               efi_st_error("Interface info is read-only\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       /* Get ip address and netmask and check that they match with the previously set ones */
> +       data_size = sizeof(struct efi_ip4_config2_manual_address);
> +       ret = ip4_config2->get_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> +                             &data_size, &manual_address);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to get ip address and netmask\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       if (memcmp(ip, &manual_address.address,
> +                  sizeof(struct efi_ipv4_address)) ||
> +           memcmp(netmask, &manual_address.subnet_mask,
> +                  sizeof(struct efi_ipv4_address))) {
> +               efi_st_error("Ip address mismatch\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       /* Restore original ip address and netmask */
> +       ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> +                             sizeof(struct efi_ip4_config2_manual_address), &orig_address);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to restore original ip address and netmask\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       efi_st_printf("Efi ipconfig test execute succeeded\n");
> +       return EFI_ST_SUCCESS;
> +}
> +
> +/*
> + * Tear down unit test.
> + *
> + * Return:     EFI_ST_SUCCESS for success
> + */
> +static int teardown(void)
> +{
> +       int exit_status = EFI_ST_SUCCESS;
> +
> +       return exit_status;
> +}
> +
> +EFI_UNIT_TEST(ipconfig) = {
> +       .name = "IPv4 config2 protocol",
> +       .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> +       .setup = setup,
> +       .execute = execute,
> +       .teardown = teardown,
> +#ifdef CONFIG_SANDBOX
> +       /*
> +        * Running this test on the sandbox requires setting environment
> +        * variable ethact to a network interface connected to a DHCP server and
> +        * ethrotate to 'no'.
> +        */
> +       .on_request = true,
> +#endif
> +};
> --
> 2.43.0
>

Thanks
/Ilias
