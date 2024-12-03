Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249D9E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A49AD8967D;
	Tue,  3 Dec 2024 20:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gh7oYjA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0731C89185; Tue,  3 Dec 2024 20:47:28 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B6989685
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215348d1977so50144475ad.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733255243; x=1733860043; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r043eyc0hqEvuevpsrlMko96NlnfDhBSb2G6yuurOhk=;
 b=gh7oYjA7iozWBRb9cjOSj13tV5HTtGHsGfvOzooISeHqT2m8pkxNesJYMzU8FKtFxi
 J3Lrlbqf67UfMwv2kDa9Jyi1LCbzmOqHh66RYs8XgBsnId2tF4dsUdCILvSdByxR8tZH
 7+batyGWK6BM7c8yJ3XAw82Pnq2EOBoj+mLmNVpBTOZYCFSOSFgj/QYv8tn6g5ONCwRW
 T9IXCY6IoaltHv+lTHbe5L3DnlMrouAfvs+r6otPJsI0Z6vvJsrm/HodQ/RN0z0rb9za
 Bs6FIr8x7cmwZrfsOorvAUD6DGrKxGvX4zg5cPRYWH/fDEZWkUJsZE8IvAesNimHwWTt
 TULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255243; x=1733860043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r043eyc0hqEvuevpsrlMko96NlnfDhBSb2G6yuurOhk=;
 b=aSoZjdzZCZmC8PBL5oy6m6VM+/nMcBmCIuI4LQ/ugZU/2HSDoKT0IVy+dMfGbhtkXh
 Jc76Iu/q9oFrpWGmXXA9szFS7yWGv1cNfbNJo8JmAxeo/jvMTdqp3AT38zc7B9CkVVWh
 N7n+WiTLe8CbrjRFk4714gDETQroHuFjWGF5cEDMW5jkjjViBEmeguYBcJ5y0BPP5OX1
 vsG8I5y7JUvcbKqkxM74ooUvhsoOzBntTboSTHAfncAfbUR3YiZKSel38FO64wYs9a6U
 qfk19yBnkMpJeLq+Xgz0b8cxoPlJU4K6VluSQ6UBQi3B+bxmh6WRtt0ot0sn63xcRYt3
 mkvQ==
X-Gm-Message-State: AOJu0YxeMgs029WdvvCPHIChuoo6ihtDpQp6FoDKeVetCCYkcBA5iJlx
 AJFkJhAv5AC9HOpeLHKYXCzNO+OIdaXFgv4EYKknd2Lvah2cZKgXdrFiUiCUlCMji2dZTVBS0e6
 AHJ/BSjOwTPQtGnZiUPpLnfcUV8U=
X-Gm-Gg: ASbGncupcxrPa0lKaDtt04Vz/fzKhKkMCLMUc7cjrwhufcY/kqhBv0WUENLLmRba9Gs
 oQNBIUMrcFCr35t8md3hT8ykACFBXUw==
X-Google-Smtp-Source: AGHT+IGZ4S9G30Dd6Q00b67MpX5Y03C276QYRMFYi9y+INjNxJIksERTO7AUTBjBB4Sb0l2Aex5e7zLirJbLIpKkWlE=
X-Received: by 2002:a17:903:18d:b0:215:620d:c2dc with SMTP id
 d9443c01a7336-215bcfc4774mr45373625ad.12.1733255243377; Tue, 03 Dec 2024
 11:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-11-adrianox@gmail.com>
 <CAC_iWjJdras+qx8Ov4sh9XJ8uCQ9XF7OvhudX4QtsNT1P59YCQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJdras+qx8Ov4sh9XJ8uCQ9XF7OvhudX4QtsNT1P59YCQ@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 3 Dec 2024 16:47:12 -0300
Message-ID: <CAMGU2hU7FXtc=wOyEwPxNMY4Ki0kRBSy3qOAriD6G6CiSvTtpw@mail.gmail.com>
Subject: Re: [PATCH v6 10/14] efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
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

El mar, 3 dic 2024 a las 11:05, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> [...]
>
> > --- /dev/null
> > +++ b/lib/efi_loader/efi_ipconfig.c
> > @@ -0,0 +1,214 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Implementation of EFI_IP4_CONFIG2_PROTOCOL
> > + *
> > + */
> > +
> > +#include <efi_loader.h>
> > +#include <image.h>
> > +#include <malloc.h>
> > +#include <mapmem.h>
> > +#include <net.h>
> > +
> > +static const efi_guid_t efi_ip4_config2_guid =3D
> EFI_IP4_CONFIG2_PROTOCOL_GUID;
> > +
> > +struct efi_ip4_config2_manual_address current_http_ip;
> > +static enum efi_ip4_config2_policy current_policy;
> > +static char current_mac_addr[32];
> > +
> > +/* EFI_IP4_CONFIG2_PROTOCOL */
> > +
> > +/*
> > + * efi_ip4_config2_set_data() -  Set the configuration for the EFI IPv=
4
> network
> > + * stack running on the communication device
> > + *
> > + * This function implements EFI_IP4_CONFIG2_PROTOCOL.SetData()
> > + * See the Unified Extensible Firmware Interface
> > + * (UEFI) specification for details.
> > + *
> > + * @this:              pointer to the protocol instance
> > + * @data_type:         the type of data to set
> > + * @data_size:         size of the buffer pointed to by data in bytes
> > + * @data:              the data buffer to set
> > + * Return:             status code
> > + */
> > +static efi_status_t EFIAPI efi_ip4_config2_set_data(struct
> efi_ip4_config2_protocol *this,
> > +                                                   enum
> efi_ip4_config2_data_type data_type,
> > +                                                   efi_uintn_t
> data_size,
> > +                                                   void *data)
> > +{
> > +       EFI_ENTRY("%p, %d, %zu, %p", this, data_type, data_size, data);
> > +       efi_status_t ret =3D EFI_SUCCESS;
> > +
> > +       if (!this || (data && !data_size) || (!data && data_size))
> > +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> > +
> > +       switch (data_type) {
> > +       case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
> > +               return EFI_EXIT(EFI_WRITE_PROTECTED);
> > +       case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
> > +               if (current_policy !=3D EFI_IP4_CONFIG2_POLICY_STATIC)
> > +                       return EFI_EXIT(EFI_WRITE_PROTECTED);
> > +               if (data_size =3D=3D 0 && !data) {
>
> we usually do if (!data_size && ...)
>
> > +                       memset((void *)&current_http_ip, 0,
> > +                              sizeof(current_http_ip));
> > +                       return EFI_EXIT(EFI_SUCCESS);
> > +               }
> > +               if (data && data_size =3D=3D sizeof(struct
> efi_ip4_config2_manual_address)) {
> > +                       memcpy((void *)&current_http_ip, data,
> > +                              sizeof(struct
> efi_ip4_config2_manual_address));
> > +                       efi_net_set_addr(&current_http_ip.address,
> > +                                        &current_http_ip.subnet_mask,
> NULL);
> > +                       return EFI_EXIT(EFI_SUCCESS);
> > +               }
> > +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> > +       case EFI_IP4_CONFIG2_DATA_TYPE_POLICY:
> > +                       if (data && data_size =3D=3D sizeof(enum
> efi_ip4_config2_policy)) {
> > +                               current_policy =3D *(enum
> efi_ip4_config2_policy *)data;
> > +                               return EFI_EXIT(EFI_SUCCESS);
> > +                       }
>
> The spec is a bit cryptic here, but it says
>
> EFI_INVALID_PARAMETER
> One or more of the following are TRUE:
> - This is NULL.
> - One or more fields in Data and DataSize do not match the requirement
> of the data type indicated by DataType
>
> and
>
> EFI_BAD_BUFFER_SIZE
> - The DataSize does not match the size of the type indicated by DataType
>
> I think we should return EFI_BAD_BUFFER_SIZE on both of the checks above.
>
> Heinrich any idea?
>
> > +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> > +
> > +       default:
> > +               return EFI_EXIT(EFI_UNSUPPORTED);
> > +       }
> > +
> > +       return EFI_EXIT(ret);
> > +}
> > +
> > +/*
> > + * efi_ip4_config2_get_data() -  Get the configuration for the EFI IPv=
4
> network
> > + * stack running on the communication device
> > + *
> > + * This function implements EFI_IP4_CONFIG2_PROTOCOL.GetData()
> > + * See the Unified Extensible Firmware Interface
> > + * (UEFI) specification for details.
> > + *
> > + * @this:              pointer to the protocol instance
> > + * @data_type:         the type of data to get
> > + * @data_size:         size
> > + * @data:              the data buffer
> > + * Return:             status code
> > + */
> > +static efi_status_t EFIAPI efi_ip4_config2_get_data(struct
> efi_ip4_config2_protocol *this,
> > +                                                   enum
> efi_ip4_config2_data_type data_type,
> > +                                                   efi_uintn_t
> *data_size,
> > +                                                   void *data)
> > +{
> > +       EFI_ENTRY("%p, %d, %p, %p", this, data_type, data_size, data);
> > +
> > +       efi_status_t ret =3D EFI_SUCCESS;
> > +       struct efi_ip4_config2_interface_info *info;
> > +       int tmp;
> > +
> > +       if (!this || !data_size)
> > +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> > +
> > +       if (*data_size && !data)
> > +               return EFI_EXIT(EFI_INVALID_PARAMETER);
> > +
> > +       tmp =3D sizeof(struct efi_ip4_config2_interface_info) +
> sizeof(struct efi_ip4_route_table);
> > +
> > +       switch (data_type) {
> > +       case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
> > +               if (*data_size < tmp) {
> > +                       *data_size =3D tmp;
> > +                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> > +               }
> > +
> > +               info =3D (struct efi_ip4_config2_interface_info *)data;
> > +               memset(info, 0, sizeof(*info));
> > +
> > +               info->hw_address_size =3D 6;
> > +               memcpy(info->hw_address.mac_addr, current_mac_addr, 6);
> > +               // Set the route table size
> > +
> > +               info->route_table_size =3D 0;
> > +               break;
> > +       case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
> > +               if (*data_size < sizeof(struct
> efi_ip4_config2_manual_address)) {
> > +                       *data_size =3D sizeof(struct
> efi_ip4_config2_manual_address);
> > +                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> > +               }
> > +
> > +               efi_net_get_addr(&current_http_ip.address,
> &current_http_ip.subnet_mask, NULL);
> > +               memcpy(data, (void *)&current_http_ip,
> > +                      sizeof(struct efi_ip4_config2_manual_address));
> > +
> > +               break;
> > +       default:
> > +               return EFI_EXIT(EFI_UNSUPPORTED);
>
> The spec doesn't have EFI_UNSUPPORTED for GetData. Instead it says
> EFI_NOT_FOUND "The specified configuration data is not found.". So we
> should return that for every data type that was marked as
> EFI_UNSUPPORTED (I think)
>
> > +       }
> > +       return EFI_EXIT(ret);
> > +}
> > +
> > +/*
> > + * efi_ip4_config2_register_notify() -  Register an event that is to b=
e
> signaled whenever
> > + * a configuration process on the specified configuration
> > + * data is done
> > + *
> > + * This function implements
> EFI_IP4_CONFIG2_PROTOCOL.RegisterDataNotify()
> > + * See the Unified Extensible Firmware Interface
> > + * (UEFI) specification for details.
> > + *
> > + * @this:              pointer to the protocol instance
> > + * @data_type:         the type of data to register the event for
> > + * @event:             the event to register
> > + * Return:             status code
> > + */
> > +static efi_status_t EFIAPI efi_ip4_config2_register_notify(struct
> efi_ip4_config2_protocol *this,
> > +                                                          enum
> efi_ip4_config2_data_type data_type,
> > +                                                          struct
> efi_event *event)
> > +{
> > +       EFI_ENTRY("%p, %d, %p", this, data_type, event);
> > +
> > +       return EFI_EXIT(EFI_UNSUPPORTED);
> > +}
> > +
> > +/*
> > + * efi_ip4_config2_unregister_notify() -  Remove a previously
> registered eventfor
> > + * the specified configuration data
> > + *
> > + * This function implements
> EFI_IP4_CONFIG2_PROTOCOL.UnregisterDataNotify()
> > + * See the Unified Extensible Firmware Interface
> > + * (UEFI) specification for details.
> > + *
> > + * @this:              pointer to the protocol instance
> > + * @data_type:         the type of data to remove the event for
> > + * @event:             the event to unregister
> > + * Return:             status code
> > + */
> > +static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct
> efi_ip4_config2_protocol *this,
> > +                                                            enum
> efi_ip4_config2_data_type data_type,
> > +                                                            struct
> efi_event *event)
> > +{
> > +       EFI_ENTRY("%p, %d, %p", this, data_type, event);
> > +
> > +       return EFI_EXIT(EFI_UNSUPPORTED);
> > +}
> > +
> > +/**
> > + * efi_ipconfig_register() - register the ip4_config2 protocol
> > + *
> > + */
> > +efi_status_t efi_ipconfig_register(const efi_handle_t handle,
> > +                                  struct efi_ip4_config2_protocol
> *ip4config)
> > +{
> > +       efi_status_t r =3D EFI_SUCCESS;
> > +
> > +       r =3D efi_add_protocol(handle, &efi_ip4_config2_guid,
> > +                            ip4config);
> > +       if (r !=3D EFI_SUCCESS) {
> > +               log_err("ERROR: Failure to add protocol\n");
> > +               return r;
> > +       }
> > +
> > +       memcpy(current_mac_addr, eth_get_ethaddr(), 6);
>
> You don't need the static variable for this, just copy it on the fly
> when required.
>
> Do you mean calling eth_get_ethaddr() when needed? In that case, this
needs to record the address of the eth
device that was set at this moment. I am not sure, but I think this static
var could be queried in the future from the client
side while another device is set by the u-boot side.

>
> > +       ip4config->set_data =3D efi_ip4_config2_set_data;
> > +       ip4config->get_data =3D efi_ip4_config2_get_data;
> > +       ip4config->register_data_notify =3D
> efi_ip4_config2_register_notify;
> > +       ip4config->unregister_data_notify =3D
> efi_ip4_config2_unregister_notify;
> > +
> > +       return EFI_SUCCESS;
> > +}
> > diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> > index 368f62c5b2..d3a8deecd0 100644
> > --- a/lib/efi_loader/efi_net.c
> > +++ b/lib/efi_loader/efi_net.c
> > @@ -60,11 +60,12 @@ static struct efi_event *wait_for_packet;
> >  /**
> >   * struct efi_net_obj - EFI object representing a network interface
> >   *
> > - * @header:    EFI object header
> > - * @net:       simple network protocol interface
> > - * @net_mode:  status of the network interface
> > - * @pxe:       PXE base code protocol interface
> > - * @pxe_mode:  status of the PXE base code protocol
> > + * @header:                    EFI object header
> > + * @net:                       simple network protocol interface
> > + * @net_mode:                  status of the network interface
> > + * @pxe:                       PXE base code protocol interface
> > + * @pxe_mode:                  status of the PXE base code protocol
> > + * @ip4_config2:               IP4 Config2 protocol interface
> >   */
> >  struct efi_net_obj {
> >         struct efi_object header;
> > @@ -72,6 +73,9 @@ struct efi_net_obj {
> >         struct efi_simple_network_mode net_mode;
> >         struct efi_pxe_base_code_protocol pxe;
> >         struct efi_pxe_mode pxe_mode;
> > +#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
> > +       struct efi_ip4_config2_protocol ip4_config2;
> > +#endif
> >  };
> >
> >  /*
> > @@ -999,6 +1003,12 @@ efi_status_t efi_net_register(void)
> >                 return r;
> >         }
> >
> > +#ifdef CONFIG_EFI_IP4_CONFIG2_PROTOCOL
>
> #if IS_ENABLED here as well etc
> > +       r =3D efi_ipconfig_register(&netobj->header, &netobj->ip4_confi=
g2);
> > +       if (r !=3D EFI_SUCCESS)
> > +               goto failure_to_add_protocol;
> > +#endif
> > +
> >         return EFI_SUCCESS;
> >  failure_to_add_protocol:
> >         printf("ERROR: Failure to add protocol\n");
> > --
> > 2.43.0
> >
>
> Thanks
> /Ilias
>
