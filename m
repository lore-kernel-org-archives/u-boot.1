Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52546C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 09:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C9A800CF;
	Tue,  4 Feb 2025 10:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uWfHmN7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62649801BE; Tue,  4 Feb 2025 10:33:52 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B49800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 10:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so5282588276.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 01:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738661629; x=1739266429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ya7KTqhxb4vE6Lq0ocKpxBiRnN8iRPqig2KAVp87zks=;
 b=uWfHmN7RPO/kkqSMxRqo/6pLu3H2H+FU3Qsagh0QBX/iqAM4qTMP1DJWWkz64+OZ9m
 dP7IGTmRGZCUWdP2Wo2+UNK+0odkP+kMU4Id4TpbaQ4DzBxNB4o129X6BpwOWHx9RgrE
 SW+4Cg9uiTE3YXiAnpwSMfMKJhXjIjSdXOr/8LgcJ3kbF8W+rT6vgszGVA8pncyLfRLA
 iyWb+N6dTLZoyez167xQPpT+RZDEPha1u9RwU2V8heCADInaLTI/9gHBkMKBuinoBYZk
 YE+unEyvToGrFW8VclgySd7rcgLZQ2NPmP3u7qPtHmDgc52d0btL8xPoCgjRo5ZJYTWt
 ACVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738661629; x=1739266429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ya7KTqhxb4vE6Lq0ocKpxBiRnN8iRPqig2KAVp87zks=;
 b=MRWtsqRgA+AieyKfdtg6rVvpxL+nlW2UPWEY7r3AVgvJhO0YZar38X7d6yMcLXn8YU
 rW0HVx8SPs2Ef6/LkRoBRrdO4+a5oXOyPfDcq5oZsIcWQxalUULfwhB+cXzxAFhZ6G6x
 z6pv8dKwOGZb0v8I8gq2R2ko+PasBH2ClacOWwk/noi1t1dIdZ813kiMEfPMFWUHVI5E
 bdk0dIL39Mlef8/W0DGHviz/P8gDmdMRL3CgQGffz97sNfIZCJPz/CD+227tXRf6R22B
 cQkbofrXdy/7ts4KGosHcD0LwD4yI+QZabNuKeD43xKoC2EoRF1vIZ8t2t0dKk5XOQPc
 UqiQ==
X-Gm-Message-State: AOJu0Yyn//qlo+B6WRvdO90sf7PiQHRmavie4p9byvIkTYdAjcCxS6Ep
 uqnubiSpezqnEC65/pTNycnD4Zd1hojPtOF6e8vN9O69v+T4OTHZsjAunwBTUMbpxlm2Oo28/xa
 PCU3Ku3k0rUI2Gqql+H1rm2S9hrHgI0y1Lwpgcw==
X-Gm-Gg: ASbGncv9ni3UP1nkpDCcQV406pJoLHPvMbAzktzxnPJ/tLko5hRhIzc4IhWdo6wRadf
 tZarze2cHykH5oLOiks7jSEJsCT7E0c1Rhh0La/foLqC3dvs5RHToXX/tKSpC+OOGa70aNI+h
X-Google-Smtp-Source: AGHT+IHV+6rvWcv7YpXX5maZPgjy+q/Cma687QoHp0pm70Jbg5doEJPMNioYsgAEm+76INePQ0NSYsSVWUfzqmxYUTI=
X-Received: by 2002:a05:6902:2386:b0:e5a:e8e8:b1c6 with SMTP id
 3f1490d57ef6-e5ae8e8b318mr9925617276.27.1738661628772; Tue, 04 Feb 2025
 01:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
 <20250122170858.961359-3-adriano.cordova@canonical.com>
In-Reply-To: <20250122170858.961359-3-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 11:33:12 +0200
X-Gm-Features: AWEUYZmMSOW3V9Y0g5EQcQE3KzkwiOblY-wXcnN_woo4MV0UJMuCcbbXbu8yzYs
Message-ID: <CAC_iWjK+XejN6iAAEnKuhq3B2DcARA3uxj9F3s+pkXL8Md8G_Q@mail.gmail.com>
Subject: Re: [PATCH 02/21] efi_loader: expose symbols to be used by the EFI
 network stack
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de, trini@konsulko.com, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
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

On Wed, 22 Jan 2025 at 19:09, Adriano Cordova <adrianox@gmail.com> wrote:
>
> The following symbols are exposed:
>         - efi_reinstall_protocol_interface
>                 This is done so that the device path protocol interface
>                 of the network device can be changed internally by u-boot
>                 when a new bootfile gets downloaded.
>         - eth_set_dev
>                 To support multiple network udevices
>         - efi_close_event
>                 This comes in preparation to support unregistering
>                 an EFI network device from the EFI network stack when
>                 the underlying U-boot device gets removed
>         - efi_[dis]connect_controller
>                 The EFI network driver uses ConnectController to add a
>                 NIC to the EFI network stack.
>         - efi_uninstall_protocol_interface
>                 connect_controler for the efi network driver can install
>                 protocols, which need to be uninstalled in disconnect_controller
>         - EFI_SIMPLE_NETWORK_PROTOCOL_GUID

All of these function are intended to be called from an EFI
application. Because this make it cumbersome to use in U-Boot internal
we usually split the function to
efi_reinstall_protocol_interface_ext -> called in EFI context and is a
wrapper that adds EFI_ENTRY/EXIT
efi_reinstall_protocol_interface -> the actual implementation, that we
can use internally

Heinrich, I assume we want to keep this similar ?

/Ilias
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  include/efi_loader.h                | 22 ++++++++++++++++++++++
>  include/net-common.h                |  1 +
>  lib/efi_loader/efi_boottime.c       | 23 +++++++++++------------
>  lib/efi_loader/efi_net.c            |  2 +-
>  lib/efi_selftest/efi_selftest_snp.c |  1 -
>  5 files changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9afbec35eb..626d2bbb1a 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -308,6 +308,8 @@ extern const efi_guid_t efi_guid_host_dev;
>  #endif
>  /* GUID of the EFI_BLOCK_IO_PROTOCOL */
>  extern const efi_guid_t efi_block_io_guid;
> +/* GUID of the EFI_SIMPLE_NETWORK_PROTOCOL */
> +extern const efi_guid_t efi_net_guid;
>  extern const efi_guid_t efi_global_variable_guid;
>  extern const efi_guid_t efi_guid_console_control;
>  extern const efi_guid_t efi_guid_device_path;
> @@ -711,6 +713,15 @@ efi_status_t efi_search_protocol(const efi_handle_t handle,
>  efi_status_t efi_add_protocol(const efi_handle_t handle,
>                               const efi_guid_t *protocol,
>                               void *protocol_interface);
> +/* Uninstall new protocol on a handle */
> +efi_status_t efi_uninstall_protocol
> +               (efi_handle_t handle, const efi_guid_t *protocol,
> +                void *protocol_interface, bool preserve);
> +/* Reinstall a protocol on a handle */
> +efi_status_t EFIAPI efi_reinstall_protocol_interface(
> +                       efi_handle_t handle,
> +                       const efi_guid_t *protocol,
> +                       void *old_interface, void *new_interface);
>  /* Open protocol */
>  efi_status_t efi_protocol_open(struct efi_handler *handler,
>                                void **protocol_interface, void *agent_handle,
> @@ -721,6 +732,15 @@ efi_status_t EFIAPI
>  efi_install_multiple_protocol_interfaces(efi_handle_t *handle, ...);
>  efi_status_t EFIAPI
>  efi_uninstall_multiple_protocol_interfaces(efi_handle_t handle, ...);
> +/* Connect and disconnect controller */
> +efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
> +                                          efi_handle_t *driver_image_handle,
> +                                          struct efi_device_path *remain_device_path,
> +                                          bool recursive);
> +efi_status_t EFIAPI efi_disconnect_controller(
> +                                       efi_handle_t controller_handle,
> +                                       efi_handle_t driver_image_handle,
> +                                       efi_handle_t child_handle);
>  /* Get handles that support a given protocol */
>  efi_status_t EFIAPI efi_locate_handle_buffer(
>                         enum efi_locate_search_type search_type,
> @@ -741,6 +761,8 @@ efi_status_t efi_create_event(uint32_t type, efi_uintn_t notify_tpl,
>                                         void *context),
>                               void *notify_context, const efi_guid_t *group,
>                               struct efi_event **event);
> +/* Call this to close an event */
> +efi_status_t EFIAPI efi_close_event(struct efi_event *event);
>  /* Call this to set a timer */
>  efi_status_t efi_set_timer(struct efi_event *event, enum efi_timer_delay type,
>                            uint64_t trigger_time);
> diff --git a/include/net-common.h b/include/net-common.h
> index 29d31f3726..1d507b13b0 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -291,6 +291,7 @@ struct eth_ops {
>  #define eth_get_ops(dev) ((struct eth_ops *)(dev)->driver->ops)
>
>  struct udevice *eth_get_dev(void); /* get the current device */
> +void eth_set_dev(struct udevice *dev); /* set a device */
>  unsigned char *eth_get_ethaddr(void); /* get the current device MAC */
>  int eth_rx(void);                      /* Check for received packets */
>  void eth_halt(void);                   /* stop SCC */
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index 080e7f78ae..79ebe94889 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -58,9 +58,9 @@ static efi_handle_t current_image;
>  static volatile gd_t *efi_gd, *app_gd;
>  #endif
>
> -static efi_status_t efi_uninstall_protocol
> -                       (efi_handle_t handle, const efi_guid_t *protocol,
> -                        void *protocol_interface, bool preserve);
> +efi_status_t efi_uninstall_protocol
> +               (efi_handle_t handle, const efi_guid_t *protocol,
> +                void *protocol_interface, bool preserve);
>
>  /* 1 if inside U-Boot code, 0 if inside EFI payload code */
>  static int entry_count = 1;
> @@ -98,12 +98,11 @@ const efi_guid_t efi_guid_load_file2_protocol = EFI_LOAD_FILE2_PROTOCOL_GUID;
>  /* GUID of the SMBIOS table */
>  const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
>
> -static efi_status_t EFIAPI efi_disconnect_controller(
> +efi_status_t EFIAPI efi_disconnect_controller(
>                                         efi_handle_t controller_handle,
>                                         efi_handle_t driver_image_handle,
>                                         efi_handle_t child_handle);
>
> -static
>  efi_status_t EFIAPI efi_connect_controller(efi_handle_t controller_handle,
>                                            efi_handle_t *driver_image_handle,
>                                            struct efi_device_path *remain_device_path,
> @@ -1037,7 +1036,7 @@ static efi_status_t EFIAPI efi_signal_event_ext(struct efi_event *event)
>   *
>   * Return: status code
>   */
> -static efi_status_t EFIAPI efi_close_event(struct efi_event *event)
> +efi_status_t EFIAPI efi_close_event(struct efi_event *event)
>  {
>         struct efi_register_notify_event *item, *next;
>
> @@ -1378,9 +1377,9 @@ static efi_status_t efi_disconnect_all_drivers
>   *
>   * Return: status code
>   */
> -static efi_status_t efi_uninstall_protocol
> -                       (efi_handle_t handle, const efi_guid_t *protocol,
> -                        void *protocol_interface, bool preserve)
> +efi_status_t efi_uninstall_protocol
> +               (efi_handle_t handle, const efi_guid_t *protocol,
> +                       void *protocol_interface, bool preserve)
>  {
>         struct efi_handler *handler;
>         struct efi_open_protocol_info_item *item;
> @@ -3665,7 +3664,7 @@ static efi_status_t efi_connect_single_controller(
>   *
>   * Return: status code
>   */
> -static efi_status_t EFIAPI efi_connect_controller(
> +efi_status_t EFIAPI efi_connect_controller(
>                         efi_handle_t controller_handle,
>                         efi_handle_t *driver_image_handle,
>                         struct efi_device_path *remain_device_path,
> @@ -3733,7 +3732,7 @@ out:
>   *
>   * Return: status code
>   */
> -static efi_status_t EFIAPI efi_reinstall_protocol_interface(
> +efi_status_t EFIAPI efi_reinstall_protocol_interface(
>                         efi_handle_t handle, const efi_guid_t *protocol,
>                         void *old_interface, void *new_interface)
>  {
> @@ -3844,7 +3843,7 @@ static efi_status_t efi_get_child_controllers(
>   *
>   * Return: status code
>   */
> -static efi_status_t EFIAPI efi_disconnect_controller(
> +efi_status_t EFIAPI efi_disconnect_controller(
>                                 efi_handle_t controller_handle,
>                                 efi_handle_t driver_image_handle,
>                                 efi_handle_t child_handle)
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 67593ef50c..918d43c70f 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -22,7 +22,7 @@
>  #include <vsprintf.h>
>  #include <net.h>
>
> -static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
> +const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>  static const efi_guid_t efi_pxe_base_code_protocol_guid =
>                                         EFI_PXE_BASE_CODE_PROTOCOL_GUID;
>  static struct efi_pxe_packet *dhcp_ack;
> diff --git a/lib/efi_selftest/efi_selftest_snp.c b/lib/efi_selftest/efi_selftest_snp.c
> index 15af8d3e18..b00c76c2f1 100644
> --- a/lib/efi_selftest/efi_selftest_snp.c
> +++ b/lib/efi_selftest/efi_selftest_snp.c
> @@ -67,7 +67,6 @@ struct dhcp {
>  static struct efi_boot_services *boottime;
>  static struct efi_simple_network *net;
>  static struct efi_event *timer;
> -static const efi_guid_t efi_net_guid = EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>  /* IP packet ID */
>  static unsigned int net_ip_id;
>
> --
> 2.43.0
>
