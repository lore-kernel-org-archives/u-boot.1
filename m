Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6C2E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3FAD88E7B;
	Tue,  3 Dec 2024 20:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T3p3G2bj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA6389655; Tue,  3 Dec 2024 20:37:08 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C42D88E42
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-724ffe64923so6221179b3a.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733254624; x=1733859424; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VTKl9EA/0/54/ic+0yc4sMx8XxxDtW8jZSz5LxQJDGg=;
 b=T3p3G2bjBcH4QS4k+DUc0sE5ZUHit6rsgMzLQMT/uOJ0w5Gsq7nHZIkVl2zOLb4KNO
 D2lCs6QIvaIwEWSimr9d8kpwaYvbh3RtUzK46abDSgLW4rhpp65zMnwdVu0s7/pnrFZl
 HtGk6HS66IpdvGZop60d9OUiNyBPqg6eVMUf6YToDoq6NQCfkafC+LwbcwDljmuP160e
 kt7QrncoOlVxTySo3BUoTe7h/vmmrrt1pHIzygGbvcePpNztUSB69zWSM0tGitDrQCPm
 A9tgRX5U0BLGMg7TjG8lVBzzcYdjxHMsoliS7bNH4xvyw6IXKhqUFwzRKdMMWeQXRe9M
 zAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254624; x=1733859424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VTKl9EA/0/54/ic+0yc4sMx8XxxDtW8jZSz5LxQJDGg=;
 b=qB3rFoBJNDKL2+7M3HoNWAdLF6o95knOQh1ERafQb8yP5ec35XxKc6xPEdrmKoTrsT
 Pb87pMw57ASUXEjDAL2EGpW+e6NAAWJ1524RmZNDQbMpGEotYcFo0Gca6t6nDSBuAhJQ
 8txVqsc2qp1/w/O+zmcR1WD1D0znf1zVo7CSm/RgItqtwFkYUIf6iWxhNHQ+xskMivsA
 7ROKZD+IRnrnYN2j0moJBXi54r1vkRi2fLX3JuYxp+KnyJSeHoYCeudqLTBw7Ks6GSI+
 V3MkWDDql5yGYPvbmatfI9O45TT04BPkhl94uY074psdiQP6Jab02WdBedZ6YOukAm7l
 p1Zw==
X-Gm-Message-State: AOJu0YyWpsO6az0cUWrlRoJwEiEdTiFZP1wR5Cn97pZOnDU/NynV7SGQ
 fTSWKQMMEcpVzONbd0/qo/0kv1svO2IQRGq2xjyd6pvJ2GheMNcokZA1ogu/vS8flu/gBy8jlv7
 KXvmqr7OLOBk+TNlAOf2GuXBwUCY=
X-Gm-Gg: ASbGncuNP7TwH+PhNuEFOXK6hncKtxdZoHh4zJR3yCqwgxUpBpGISKY9X8THdSzeneS
 UH9vvr444pWR2r7u8u7PBYaRn960VDQ==
X-Google-Smtp-Source: AGHT+IEUxZRfcu5S/qIsiqEbh/nUowtgD90/ribZq3idQX31L41nP5nzF8ggIpHMo6crrA/osSz1bpinHjVJ+tArE/Y=
X-Received: by 2002:a17:902:e751:b0:215:2f00:67b1 with SMTP id
 d9443c01a7336-215bd1b470dmr47650405ad.6.1733254623715; Tue, 03 Dec 2024
 11:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-14-adrianox@gmail.com>
 <CAC_iWjK8P9BAwOAzJNeaE+tsQ81TjQqKeFsy5hoP2cRMjSGzQQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK8P9BAwOAzJNeaE+tsQ81TjQqKeFsy5hoP2cRMjSGzQQ@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Tue, 3 Dec 2024 16:36:52 -0300
Message-ID: <CAMGU2hU-L8OfRLhyqhD6HzmOqiaXTabEAVuwWwa7rxvJ8WSZ3g@mail.gmail.com>
Subject: Re: [PATCH v6 13/14] efi_selftest: add test for HTTP protocol
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

El mar, 3 dic 2024 a las 10:11, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> On Thu, 28 Nov 2024 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
> >
> > Add a test for the EFI_HTTP_PROTOCOL and
> > EFI_SEVICE_BINDING_PROTOCOL.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >
> > (no changes since v2)
> >  lib/efi_selftest/Makefile            |   2 +-
> >  lib/efi_selftest/efi_selftest_http.c | 315 +++++++++++++++++++++++++++
> >  2 files changed, 316 insertions(+), 1 deletion(-)
> >  create mode 100644 lib/efi_selftest/efi_selftest_http.c
> >
> > diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> > index 414701893f..140c08effc 100644
> > --- a/lib/efi_selftest/Makefile
> > +++ b/lib/efi_selftest/Makefile
> > @@ -52,7 +52,7 @@ efi_selftest_watchdog.o
> >
> >  obj-$(CONFIG_EFI_ECPT) +=3D efi_selftest_ecpt.o
> >  obj-$(CONFIG_NETDEVICES) +=3D efi_selftest_snp.o
> > -
> > +obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_selftest_http.o
> >  obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) +=3D efi_selftest_devicepath.o
> >  obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) +=3D \
> >  efi_selftest_unicode_collation.o
> > diff --git a/lib/efi_selftest/efi_selftest_http.c
> b/lib/efi_selftest/efi_selftest_http.c
> > new file mode 100644
> > index 0000000000..ce3cf33887
> > --- /dev/null
> > +++ b/lib/efi_selftest/efi_selftest_http.c
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * efi_selftest_http
> > + *
> > + * This unit test covers the IPv4 Config2 Protocol, Http Service
> Binding Protocol,
> > + * and Http Protocol.
> > + *
> > + * An Http HEAD and an Http GET request are sent to the same
> destination. The test
> > + * is successful if the HEAD request gets a response with a valid
> Content-Length header
> > + * and the subsequent GET request receives the amount of bytes informe=
d
> by the previous
> > + * Content-Length header.
> > + *
> > + */
> > +
> > +#include <efi_selftest.h>
> > +#include <charset.h>
> > +#include <net.h>
> > +
> > +static struct efi_boot_services *boottime;
> > +
> > +static struct efi_http_protocol *http;
> > +static struct efi_service_binding_protocol *http_service;
> > +static struct efi_ip4_config2_protocol *ip4_config2;
> > +static efi_handle_t http_protocol_handle;
> > +
> > +static const efi_guid_t efi_http_guid =3D EFI_HTTP_PROTOCOL_GUID;
> > +static const efi_guid_t efi_http_service_binding_guid =3D
> EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
> > +static const efi_guid_t efi_ip4_config2_guid =3D
> EFI_IP4_CONFIG2_PROTOCOL_GUID;
> > +static int callback_done;
> > +
> > +/*
> > + * Setup unit test.
> > + *
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
> > +       struct efi_http_config_data http_config;
> > +       struct efi_httpv4_access_point ipv4_node;
> > +
> > +       boottime =3D systable->boottime;
> > +
> > +       boottime->locate_handle_buffer(BY_PROTOCOL,
> &efi_ip4_config2_guid,
> > +                                      NULL, &num_handles, &handles);
> > +
>
> Same remarks as the other test-related patch, Check the number of
> handles early and exit
>
> > +       for (net_handle =3D handles; num_handles--; net_handle++) {
> > +               ret =3D boottime->open_protocol(*net_handle,
> &efi_ip4_config2_guid,
> > +                                             (void **)&ip4_config2, 0,
> 0,
> > +
>  EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +               if (ret !=3D EFI_SUCCESS || !ip4_config2)
> > +                       continue;
> > +               ret =3D boottime->open_protocol(*net_handle,
> > +
>  &efi_http_service_binding_guid,
> > +                                             (void **)&http_service, 0=
,
> 0,
> > +
>  EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +               if (ret !=3D EFI_SUCCESS || !http_service)
> > +                       continue;
> > +               break; // Get first handle that supports both protocols
> > +       }
> > +
> > +       if (!ip4_config2 || !http_service) {
> > +               efi_st_error("Failed to locate ipv4 config2 or http
> service binding protocol\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       http_protocol_handle =3D NULL;
> > +       ret =3D http_service->create_child(http_service,
> &http_protocol_handle);
>
> I haven't checked the creation patches yet, but does it make sense to
> return EFI_SUCCESS if the protocol handle for the creation failed?
> IOW if http_protocol_handle =3D=3D NULL shouldn't we return something els=
e?
>

Hi Ilias, thanks again for the reviews,

I am not sure I understand your point here. If the creation fails then we
return EFI_ST_FAILURE

>
> > +       if (ret !=3D EFI_SUCCESS || !http_protocol_handle) {
> > +               efi_st_error("Failed to create an http service
> instance\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       ret =3D boottime->open_protocol(http_protocol_handle,
> &efi_http_guid,
> > +                                     (void **)&http, 0, 0,
> EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> > +       if (ret !=3D EFI_SUCCESS || !http) {
> > +               efi_st_error("Failed to open http protocol\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +       efi_st_printf("HTTP Service Binding: child created
> successfully\n");
> > +
> > +       http_config.http_version =3D HTTPVERSION11;
> > +       http_config.is_ipv6 =3D false;
> > +       http_config.access_point.ipv4_node =3D &ipv4_node;
> > +       ipv4_node.use_default_address =3D true;
> > +
> > +       ret =3D http->configure(http, &http_config);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed to configure http instance\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       return EFI_ST_SUCCESS;
> > +}
> > +
> > +void EFIAPI efi_test_http_callback(struct efi_event *event, void
> *context)
> > +{
> > +       callback_done =3D 1;
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
> > +       struct efi_http_request_data request_data;
> > +       struct efi_http_message request_message;
> > +       struct efi_http_token request_token;
> > +       struct efi_http_response_data response_data;
> > +       struct efi_http_message response_message;
> > +       struct efi_http_token response_token;
> > +       enum efi_http_status_code status_code;
> > +       void *response_buffer;
> > +       efi_uintn_t len, sum;
> > +       char *url =3D "http://example.com/";
> > +       u16 url_16[64];
> > +       u16 *tmp;
> > +
> > +       /* Setup may have failed */
> > +       if (!ip4_config2 || !http) {
> > +               efi_st_error("Cannot proceed with test after setup
> failure\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       tmp =3D url_16;
> > +       utf8_utf16_strcpy(&tmp, url);
> > +       request_data.url =3D url_16;
> > +       request_data.method =3D HTTP_METHOD_GET;
> > +
> > +       request_message.data.request =3D &request_data;
> > +       request_message.header_count =3D 3;
> > +       request_message.body_length =3D 0;
> > +       request_message.body =3D NULL;
> > +
> > +       /* request token */
> > +       request_token.event =3D NULL;
> > +       request_token.status =3D EFI_NOT_READY;
> > +       request_token.message =3D &request_message;
> > +       callback_done =3D 0;
> > +       ret =3D boottime->create_event(EVT_NOTIFY_SIGNAL,
> > +                       TPL_CALLBACK,
> > +                       efi_test_http_callback,
> > +                       NULL,
> > +                       &request_token.event);
> > +
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed to create request event\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       ret =3D http->request(http, &request_token);
> > +
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               boottime->close_event(request_token.event);
> > +               efi_st_printf("Failed to proceed with the http
> request\n");
> > +               return EFI_ST_SUCCESS;
> > +       }
> > +
> > +       while (!callback_done)
> > +               http->poll(http);
> > +
> > +       response_data.status_code =3D HTTP_STATUS_UNSUPPORTED_STATUS;
> > +       response_message.data.response =3D &response_data;
> > +       response_message.header_count =3D 0;
> > +       response_message.headers =3D NULL;
> > +       response_message.body_length =3D 0;
> > +       response_message.body =3D NULL;
> > +       response_token.event =3D NULL;
> > +
> > +       ret =3D boottime->create_event(EVT_NOTIFY_SIGNAL,
> > +                       TPL_CALLBACK,
> > +                       efi_test_http_callback,
> > +                       NULL,
> > +                       &response_token.event);
> > +
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               boottime->close_event(request_token.event);
> > +               efi_st_error("Failed to create response event\n");
> > +               return EFI_ST_FAILURE;
> > +       }
> > +
> > +       response_token.status =3D EFI_SUCCESS;
> > +       response_token.message =3D &response_message;
> > +
> > +       callback_done =3D 0;
> > +       ret =3D http->response(http, &response_token);
> > +
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed http first response\n");
> > +               goto fail;
> > +       }
> > +
> > +       while (!callback_done)
> > +               http->poll(http);
> > +
> > +       if (response_message.data.response->status_code !=3D
> HTTP_STATUS_200_OK) {
> > +               status_code =3D
> response_message.data.response->status_code;
> > +               if (status_code =3D=3D HTTP_STATUS_404_NOT_FOUND) {
> > +                       efi_st_error("File not found\n");
> > +               } else {
> > +                       efi_st_error("Bad http status %d\n",
> > +
> response_message.data.response->status_code);
> > +               }
> > +               goto fail_free_hdr;
> > +       }
> > +
> > +       ret =3D boottime->allocate_pool(EFI_LOADER_CODE,
> response_message.body_length,
> > +                                     &response_buffer);
> > +       if (ret !=3D EFI_SUCCESS) {
> > +               efi_st_error("Failed allocating response buffer\n");
> > +               goto fail_free_hdr;
> > +       }
> > +
> > +       len =3D response_message.body_length;
> > +       sum =3D 0;
> > +       while (len) {
> > +               response_message.data.response =3D NULL;
> > +               response_message.header_count =3D 0;
> > +               response_message.headers =3D NULL;
> > +               response_message.body_length =3D len;
> > +               response_message.body =3D response_buffer + sum;
> > +
> > +               response_token.message =3D &response_message;
> > +               response_token.status =3D EFI_NOT_READY;
> > +
> > +               callback_done =3D 0;
> > +               ret =3D http->response(http, &response_token);
> > +               if (ret !=3D EFI_SUCCESS) {
> > +                       efi_st_error("Failed http second response\n");
> > +                       goto fail_free_buf;
> > +               }
> > +
> > +               while (!callback_done)
> > +                       http->poll(http);
> > +
> > +               if (!response_message.body_length)
> > +                       break;
> > +
> > +               len -=3D response_message.body_length;
> > +               sum +=3D response_message.body_length;
> > +       }
> > +
> > +       if (len)
> > +               goto fail_free_buf;
> > +
> > +       boottime->free_pool(response_buffer);
> > +       if (response_message.headers)
> > +               boottime->free_pool(response_message.headers);
> > +       boottime->close_event(request_token.event);
> > +       boottime->close_event(response_token.event);
> > +       efi_st_printf("Efi Http request executed successfully\n");
> > +       return EFI_ST_SUCCESS;
> > +
> > +fail_free_buf:
> > +       boottime->free_pool(response_buffer);
> > +fail_free_hdr:
> > +       if (response_message.headers)
> > +               boottime->free_pool(response_message.headers);
> > +fail:
> > +       boottime->close_event(request_token.event);
> > +       boottime->close_event(response_token.event);
> > +       return EFI_ST_FAILURE;
> > +}
> > +
> > +/*
> > + * Tear down unit test.
> > + *
> > + * Return:     EFI_ST_SUCCESS for success
> > + */
> > +static int teardown(void)
> > +{
> > +       efi_status_t ret;
> > +       int exit_status =3D EFI_ST_SUCCESS;
> > +
> > +       if (!http_service || !http_protocol_handle) {
> > +               efi_st_error("No handles to destroy http instance");
> > +               exit_status =3D EFI_ST_FAILURE;
> > +       } else {
> > +               ret =3D http_service->destroy_child(http_service,
> http_protocol_handle);
> > +               if (ret !=3D EFI_SUCCESS) {
> > +                       efi_st_error("Failed to destroy http instance")=
;
> > +                       exit_status =3D EFI_ST_FAILURE;
> > +               }
> > +               efi_st_printf("HTTP Service Binding: child destroyed
> successfully\n");
> > +       }
> > +
> > +       return exit_status;
> > +}
> > +
> > +EFI_UNIT_TEST(http) =3D {
> > +       .name =3D "http protocol",
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
