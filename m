Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE3ED49211
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 12:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2942288E6B;
	Mon, 18 Nov 2024 13:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HOOpt3a7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F9B893E3; Mon, 18 Nov 2024 13:28:37 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86FD88E5C
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ea78d164b3so699815a91.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 04:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731932913; x=1732537713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6QAfGid8YStkSQiiIssR/XkD3FNfrpWoPqTbXUf6Yc8=;
 b=HOOpt3a7gZ5CASA/jj3XF+JZl8VbfEy1huPlGyzy7CETOUBm9Q2nuK+sao2UGcPp+z
 TZMyZDcnYBYFoBPymahdlsiC7gkQZX791CSRVCB3JUbMhHHPLyQLLi8b+o1BRCXrfdw5
 O8ZHul5y8f96GuiuqLzsIk8FpWqhVHi7uK6O8LkSiN6/4/tLGIWA0m/6bW7MElfQ9R/P
 oKDML8XipclYdynVwiGQaGU3F0am/F6WU96GlqVKP96c3Q6Q5h3hs/iqQCOnAJRZSr+G
 U2ioFoR3/pOF2vFRFzzCJoNQUArHzwAO7+I/eJ/mYbTo3kVeYNCkAKNb3X8DJm80pYc0
 3oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731932913; x=1732537713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6QAfGid8YStkSQiiIssR/XkD3FNfrpWoPqTbXUf6Yc8=;
 b=TQakHObgQrEz/9CSKaqgUowcXca3Qmn4wAlNZvfiwrrf4c/RBneuLwXyMAm8oPC3oO
 JhoxzzPeFwZtbR2WeJ1UeURrw8UxIa8q9wAPw6HyV4Q7IExxrhf3IZqAXe9e3t84TbQ+
 hO8k2r6wk0UGCnx/HouzJASd9A+wY/VK4AQ1hNzru7YU7JBlWv7yN6v9ivnW1/LJ3Lu3
 X3/0KMRdTAPhn9r6gxr1+gLF5AXJht708xVNW4aUeGBLg4JM4nKCzCZjoehiqKnBuMaB
 szsGjsSUrOOTuQoEt991+TS5Xp1T2i0OBND9MesDLbDRgq7NVxqeUYkkO2PR7uIXd3cP
 QrNA==
X-Gm-Message-State: AOJu0YyhOzD6P8YLXQfFORF15mdjLKs5JzV/+n1ItTOPHNEQ1dLSivNM
 kHcj2GDp2We63b6GbPrehhP4Ggqk+J459EIE/3UD/ovivcgRA8QGXen6PbyCUcnqo2W2lL35XmL
 28r+vDIBXjSu40+lJ4piI8J8y4So//3ijeom4jA==
X-Google-Smtp-Source: AGHT+IHfV9BFCOEPyb402NATdOM0aGQLO7sDLTUKFmsciByGxvGwAn8psPGrgztuQn694vN113k0PKqUtkrqRhkJTQo=
X-Received: by 2002:a17:90b:17c2:b0:2ea:4a6b:79d1 with SMTP id
 98e67ed59e1d1-2ea4a6b7a8fmr7297161a91.11.1731932913177; Mon, 18 Nov 2024
 04:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-16-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-16-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 Nov 2024 14:27:56 +0200
Message-ID: <CAC_iWjLGCcPcdu2H+nZejkqHaYLh=B-Kd5f2c79YzHaN9rwWuw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] efi_selftest: add test for IPv4 Config2 protocol
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

Overall this looks good. Get rid of the unneeded casts in memcpy for
the next version.

Thanks
/Ilias

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add a test for the EFI_IP4_CONFIG2_PROTOCOL. The test sets the ip
> policy to static, adds an ip address, and then reads the current
> ip address and checks for it to be the same as the one that was set.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  lib/efi_selftest/Makefile                |   2 +
>  lib/efi_selftest/efi_selftest_ipconfig.c | 173 +++++++++++++++++++++++
>  2 files changed, 175 insertions(+)
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
> index 0000000000..e81ab4e334
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_ipconfig.c
> @@ -0,0 +1,173 @@
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
> +       ret = ip4_config2->get_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> +                             &data_size, &orig_address);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to save original ip address and netmask\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       /* Set static ip and netmask */
> +       memcpy((void *)&manual_address.address, (void *)ip,
> +              sizeof(struct efi_ipv4_address));
> +       memcpy((void *)&manual_address.subnet_mask, (void *)netmask,
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
> +       if (memcmp((void *)ip, (void *)&manual_address.address,
> +                  sizeof(struct efi_ipv4_address)) ||
> +           memcmp((void *)netmask, (void *)&manual_address.subnet_mask,
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
> + * Close the timer event created in setup.
> + * Shut down the network adapter.
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
