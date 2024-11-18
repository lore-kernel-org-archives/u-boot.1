Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97835D49212
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 12:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E6F890D1;
	Mon, 18 Nov 2024 13:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cNoqYb+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB109893E3; Mon, 18 Nov 2024 13:45:34 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E334890D0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ea4c5b8fbcso910688a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933931; x=1732538731; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yraoeRj+JH1BYqzf8cBu1UNCfFh1m3hjswt0ppz17X8=;
 b=cNoqYb+JvQeejcqokwgmLAMHa2XYzF9S8BdX7ad9hYuZkCKM+WInJmiYkmlhEW7WhT
 Opimxi0RuibgvOdDHfBwUqw8TakYLvyQOZ/Bj9t3zFp1iK7RRW4B+ZzKWZiuPT2zeT5L
 enF+ZERZSMkXwK4SKHzxIDCyWDfiY+h/L7G+Xsj6D1FlSHmkoXHuNYH+EVPlM+zg2dCa
 YoPi31yNR29uOyxaRJ1jJg4Tt0C5TA955MdM+lAHOI0QoWgW1K0rCSr87eEKrUk/o6nq
 hDd9+nZiAIiOk+G2Va1hGd9xdDwzkVWiaAyjJtR3lg/5Z1WcJnuBltaZ/+Zq6pae9PHf
 4zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933931; x=1732538731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yraoeRj+JH1BYqzf8cBu1UNCfFh1m3hjswt0ppz17X8=;
 b=jNSLRpkAn8QOl84UaTRTezQLujHN7e7aGoz3R9L+jsLd2kAAEDG2YRa8IxAoUjxIEb
 ty0gSMPS/bsVGg3C5NfzcUT7rT9s8Zt4pNYU+YNbCywfy5r96Gawrl8xmZ/OXgJJheGW
 Nd9E1Z1kaBEl/QPAx2zGVGY36AFl8Nbin8ntNVfsW8E0r+ibKXRs4E1AMk13bNtLe14W
 mJUSwziLYisEz24IhQ9TBDSZUBQZuJHHpCbbsflxrmO90NqBtHNh6Yk+enGBWc/8pFiu
 9BvE65+rZLfDogCwuAW8gLfyZu1swBf747KnLKIot6OlyG+iFbkMt5b5sFrNIi5QKoJ5
 BwaA==
X-Gm-Message-State: AOJu0YxarsewSuPRpl1pzn9PkChixP2EtyrBCxOxVwFuJxuty2cTeA54
 8uuVnwqw284PCFsVtOpjtcner0AzT/5xk5QC+e/FftsG7mbnSfgvzPTAMPEXQ6T+reAIsD7FJWT
 BnsDDOB3JoHKxpcBQWr/Cah7K4qBokWmloYLXUQ==
X-Google-Smtp-Source: AGHT+IEhJbYZbQ0CQJPhCSg1Ud5evoPFA3vrHWbjQ7OrCHNZcWvbwHCFk8JQvt6LdG/N4BeRd/zz1IENCPCMqvBd7jE=
X-Received: by 2002:a17:90b:4fc6:b0:2ea:5fed:4a32 with SMTP id
 98e67ed59e1d1-2ea5fed4b7cmr6553231a91.11.1731933930784; Mon, 18 Nov 2024
 04:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-12-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-12-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 Nov 2024 14:44:53 +0200
Message-ID: <CAC_iWj+z9X5H8kfzd-Z=3gb4+LRQkTidT9s6Dy0OCPOqq-ejgg@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
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

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add an implementation of the EFI_IP4_CONFIG2_PROTOCOL. The protocol
> is attached to the handle of the efi network device. This is the same
> handle where snp and pxe are attached to.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  include/efi_loader.h          |   3 +
>  lib/efi_loader/Kconfig        |   9 ++
>  lib/efi_loader/Makefile       |   1 +
>  lib/efi_loader/efi_ipconfig.c | 216 ++++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_net.c      |  20 +++-
>  5 files changed, 244 insertions(+), 5 deletions(-)
>  create mode 100644 lib/efi_loader/efi_ipconfig.c
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 4d05c08441..5029ac39f1 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -627,6 +627,9 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
>  efi_status_t efi_gop_register(void);
>  /* Called by bootefi to make the network interface available */
>  efi_status_t efi_net_register(void);
> +/* Called by efi_net_register to make the ip4 config2 protocol available */
> +efi_status_t efi_ipconfig_register(const efi_handle_t handle,
> +                                  struct efi_ip4_config2_protocol *ip4config);
>  /* Called by bootefi to make the watchdog available */
>  efi_status_t efi_watchdog_register(void);
>  efi_status_t efi_initrd_register(void);
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 58d49789f1..d823b2855b 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -476,6 +476,15 @@ config EFI_RISCV_BOOT_PROTOCOL
>           replace the transfer via the device-tree. The latter is not
>           possible on systems using ACPI.
>
> +config EFI_IP4_CONFIG2_PROTOCOL
> +       bool "EFI_IP4_CONFIG2_PROTOCOL support"
> +       default y

I think making this default 'y' is a bit too much.
The EFI_LOADER size keeps increasing. Can you only enable it on QEMU &
SANDBOX for testing?

> +       depends on NET || NET_LWIP
> +       help
> +         Provides an implementation of the EFI_IP4_CONFIG2_PROTOCOL, this
> +         protocol can be used to set and get the current ip address and
> +         other network information.
> +
>  endmenu
>
>  menu "Misc options"
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 87131ab911..30cd1de9d6 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
>  obj-$(CONFIG_VIDEO) += efi_gop.o
>  obj-$(CONFIG_BLK) += efi_disk.o
>  obj-$(CONFIG_NETDEVICES) += efi_net.o
> +obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
>  obj-$(CONFIG_ACPI) += efi_acpi.o
>  obj-$(CONFIG_SMBIOS) += efi_smbios.o
>  obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
> diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
> new file mode 100644
> index 0000000000..4853b2b05d
> --- /dev/null
> +++ b/lib/efi_loader/efi_ipconfig.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Implementation of EFI_IP4_CONFIG2_PROTOCOL
> + *
> + */
> +
> +#include <efi_loader.h>
> +#include <image.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <net.h>
> +
> +static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
> +
> +struct efi_ip4_config2_manual_address current_http_ip;
> +static enum efi_ip4_config2_policy current_policy;
> +static char current_mac_addr[32];
> +
> +/* EFI_IP4_CONFIG2_PROTOCOL */
> +
> +/*
> + * efi_ip4_config2_set_data() -  Set the configuration for the EFI IPv4 network
> + * stack running on the communication device
> + *
> + * This function implements EFI_IP4_CONFIG2_PROTOCOL.SetData()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:              pointer to the protocol instance
> + * @data_type:         the type of data to set
> + * @data_size:         size of the buffer pointed to by data in bytes
> + * @data:              the data buffer to set
> + * Return:             status code
> + */
> +static efi_status_t EFIAPI efi_ip4_config2_set_data(struct efi_ip4_config2_protocol *this,
> +                                                   enum efi_ip4_config2_data_type data_type,
> +                                                   efi_uintn_t data_size,
> +                                                   void *data)
> +{
> +       EFI_ENTRY("%p, %d, %zu, %p", this, data_type, data_size, data);
> +       efi_status_t ret = EFI_SUCCESS;
> +
> +       if (!this)
> +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> +
> +       switch (data_type) {
> +       case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
> +               return EFI_EXIT(EFI_WRITE_PROTECTED);
> +       case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
> +               if (current_policy != EFI_IP4_CONFIG2_POLICY_STATIC)
> +                       return EFI_EXIT(EFI_WRITE_PROTECTED);
> +               if (data_size == 0 && !data) {
> +                       memset((void *)&current_http_ip, 0,
> +                              sizeof(struct efi_ip4_config2_manual_address));
> +                       return EFI_EXIT(EFI_SUCCESS);
> +               }
> +               if (data && data_size == sizeof(struct efi_ip4_config2_manual_address)) {
> +                       memcpy((void *)&current_http_ip, data,
> +                              sizeof(struct efi_ip4_config2_manual_address));
> +                       efi_net_set_addr(&current_http_ip.address,
> +                                        &current_http_ip.subnet_mask, NULL);

Those functions are defined as void, but might fail and not define an
address. We should check that a valid address is set before returning
success?


> +                       return EFI_EXIT(EFI_SUCCESS);
> +               }
> +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> +       case EFI_IP4_CONFIG2_DATA_TYPE_POLICY:
> +                       if (data && data_size == sizeof(enum efi_ip4_config2_policy)) {
> +                               current_policy = *(enum efi_ip4_config2_policy *)data;
> +                               return EFI_EXIT(EFI_SUCCESS);
> +                       }
> +               return EFI_EXIT(EFI_INVALID_PARAMETER);

I think it's better if you exit with EFI_INVALID_PARAMETER at the top
of the function if data !NULL and datasize == 0 or data !=null and
datasize == 0

> +
> +       default:
> +               return EFI_EXIT(EFI_UNSUPPORTED);
> +       }
> +
> +       return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_ip4_config2_get_data() -  Get the configuration for the EFI IPv4 network
> + * stack running on the communication device
> + *
> + * This function implements EFI_IP4_CONFIG2_PROTOCOL.GetData()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:              pointer to the protocol instance
> + * @data_type:         the type of data to get
> + * @data_size:         size
> + * @data:              the data buffer
> + * Return:             status code
> + */
> +static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_protocol *this,
> +                                                   enum efi_ip4_config2_data_type data_type,
> +                                                   efi_uintn_t *data_size,
> +                                                   void *data)
> +{
> +       EFI_ENTRY("%p, %d, %p, %p", this, data_type, data_size, data);
> +
> +       efi_status_t ret = EFI_SUCCESS;
> +       struct efi_ip4_config2_interface_info *info;
> +       int tmp;
> +
> +       if (!this || !data_size)
> +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> +
> +       if (*data_size && !data)
> +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> +
> +       tmp = sizeof(struct efi_ip4_config2_interface_info)

Always try to preferer defined variables  -- sizeof(*info)

> + sizeof(struct efi_ip4_route_table);
> +
> +       switch (data_type) {
> +       case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
> +               if (*data_size < tmp) {
> +                       *data_size = tmp;
> +                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> +               }
> +
> +               info = (struct efi_ip4_config2_interface_info *)data;
> +               memset(info, 0, sizeof(struct efi_ip4_config2_interface_info));
> +
> +               info->hw_address_size = 6;
> +               memcpy(info->hw_address.mac_addr, current_mac_addr, 6);
> +               // Set the route table size
> +
> +               info->route_table_size = 0;
> +               break;
> +       case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
> +               if (*data_size < sizeof(struct efi_ip4_config2_manual_address)) {
> +                       *data_size = sizeof(struct efi_ip4_config2_manual_address);
> +                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> +               }
> +
> +               efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_mask, NULL);
> +               memcpy(data, (void *)&current_http_ip,
> +                      sizeof(struct efi_ip4_config2_manual_address));
> +
> +               break;
> +       default:
> +               return EFI_EXIT(EFI_UNSUPPORTED);
> +       break;

Fix the indentation here

> +       }
> +       return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_ip4_config2_register_notify() -  Register an event that is to be signaled whenever
> + * a configuration process on the specified configuration
> + * data is done
> + *
> + * This function implements EFI_IP4_CONFIG2_PROTOCOL.RegisterDataNotify()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:              pointer to the protocol instance
> + * @data_type:         the type of data to register the event for
> + * @event:             the event to register
> + * Return:             status code
> + */
> +static efi_status_t EFIAPI efi_ip4_config2_register_notify(struct efi_ip4_config2_protocol *this,
> +                                                          enum efi_ip4_config2_data_type data_type,
> +                                                          struct efi_event *event)
> +{
> +       EFI_ENTRY("%p, %d, %p", this, data_type, event);
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +/*
> + * efi_ip4_config2_unregister_notify() -  Remove a previously registered eventfor
> + * the specified configuration data
> + *
> + * This function implements EFI_IP4_CONFIG2_PROTOCOL.UnregisterDataNotify()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:              pointer to the protocol instance
> + * @data_type:         the type of data to remove the event for
> + * @event:             the event to unregister
> + * Return:             status code
> + */
> +static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct efi_ip4_config2_protocol *this,
> +                                                            enum efi_ip4_config2_data_type data_type,
> +                                                            struct efi_event *event)
> +{
> +       EFI_ENTRY("%p, %d, %p", this, data_type, event);
> +
> +       return EFI_EXIT(EFI_UNSUPPORTED);
> +}
> +
> +/**
> + * efi_ipconfig_register() - register the ip4_config2 protocol
> + *
> + */
> +efi_status_t efi_ipconfig_register(const efi_handle_t handle,
> +                                  struct efi_ip4_config2_protocol *ip4config)
> +{
> +       efi_status_t r = EFI_SUCCESS;
> +
> +       r = efi_add_protocol(handle, &efi_ip4_config2_guid,
> +                            ip4config);
> +       if (r != EFI_SUCCESS)
> +               goto failure_to_add_protocol;

No need for a goto here, just exit here

> +
> +       memcpy(current_mac_addr, eth_get_ethaddr(), 6);
> +
> +       ip4config->set_data = efi_ip4_config2_set_data;
> +       ip4config->get_data = efi_ip4_config2_get_data;
> +       ip4config->register_data_notify = efi_ip4_config2_register_notify;
> +       ip4config->unregister_data_notify = efi_ip4_config2_unregister_notify;
> +
> +       return EFI_SUCCESS;
> +failure_to_add_protocol:
> +       printf("ERROR: Failure to add protocol\n");

log_err

> +       return r;
> +}
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 30234ae1c7..fa3b0c0007 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -54,11 +54,12 @@ static struct efi_event *wait_for_packet;
>  /**
>   * struct efi_net_obj - EFI object representing a network interface
>   *
> - * @header:    EFI object header
> - * @net:       simple network protocol interface
> - * @net_mode:  status of the network interface
> - * @pxe:       PXE base code protocol interface
> - * @pxe_mode:  status of the PXE base code protocol
> + * @header:                    EFI object header
> + * @net:                       simple network protocol interface
> + * @net_mode:                  status of the network interface
> + * @pxe:                       PXE base code protocol interface
> + * @pxe_mode:                  status of the PXE base code protocol
> + * @ip4_config2:               IP4 Config2 protocol interface
>   */
>  struct efi_net_obj {
>         struct efi_object header;
> @@ -66,6 +67,9 @@ struct efi_net_obj {
>         struct efi_simple_network_mode net_mode;
>         struct efi_pxe_base_code_protocol pxe;
>         struct efi_pxe_mode pxe_mode;
> +#ifdef CONFIG_EFI_IP4_CONFIG2_PROTOCOL
> +       struct efi_ip4_config2_protocol ip4_config2;
> +#endif
>  };
>
>  /*
> @@ -993,6 +997,12 @@ efi_status_t efi_net_register(void)
>                 return r;
>         }
>
> +#ifdef CONFIG_EFI_IP4_CONFIG2_PROTOCOL

use IS_ENABLED instead

> +       r = efi_ipconfig_register(&netobj->header, &netobj->ip4_config2);
> +       if (r != EFI_SUCCESS)
> +               goto failure_to_add_protocol;
> +#endif
> +
>         return EFI_SUCCESS;
>  failure_to_add_protocol:
>         printf("ERROR: Failure to add protocol\n");
> --
> 2.43.0
>

Thanks
/Ilias
