Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27BE64A8B
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E76588A3C;
	Tue,  3 Dec 2024 14:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="canywIfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992748939E; Tue,  3 Dec 2024 14:11:41 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B474B88875
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ef0ef11aafso53632387b3.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733231497; x=1733836297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wgsd0q+4a+jEiax0ySAUcEa94JkqZHFFvZ6VwuV/U4E=;
 b=canywIfEdgNdE8FQdZbAUbRos7V31UA2ZQ0EjIBfN210nev68CHwdH2utGEtWqeoA1
 6ZutlUEXYAc01JOTWJ1TheZH6pG5JPlVtVd2NFPvuL9TH563w3rRJ2kv+p+wUodHeZCm
 8Gp4yHnFPxMf3aMs++tXCL9Ov7X3e2Pf85DpAEbq1IDCMte3BlHdUt2ych5U/XH31vFj
 066bgYBC6iLSdL4oeS9OhFvCB9Ti/npDAN8bKC7xZmTo7ngqHxtwYmvhWMCHVsa51tTK
 8okTd3pHMYyLY+hnx2+EkHVUNpecnxJWqOQrZMt+YnrCi0ASAhiqdfq8Z6eNHhcUq1gH
 SO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733231497; x=1733836297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wgsd0q+4a+jEiax0ySAUcEa94JkqZHFFvZ6VwuV/U4E=;
 b=b6Y5fSCB7L/ujPAHD7yYs+F1ZmbVdBzqlLQbd+mtKVOgE1TdZaRpus7+vxpQbowdQH
 z8YLKCPKRf9lly6okuJ9gt5UKGe+mmLt30GQRCPzoqhMSNJBHNP4BZBvwuxM/jcZ53KX
 Mi38eF3f4zY8gQ3mzQQtVE06pErJx7nrIQ0t0ht1ayvA7/Yrvks+pe4JQP38XjL13wsp
 BpuUeIHXlJmw3WHZLU+020B+0S+DmP35cmKCSVXDp6TFkoLv7rV7etkJ0iiK5g0di5uA
 Rl7m7HPvf4+NDrTyrnkAi9CdoH136TBnD1eRU4qC1Ba//udpGsXpnUa7jyauTmPQGwxp
 9JmQ==
X-Gm-Message-State: AOJu0Yxz4KXdM/FEirEZimMwIPsNsCR9L0EbQX+jOY9l+mMFitYRyjFv
 gSEWOcHtoCXwR6Ijj/hGb+1TrEKYfowE3IKAwuIx6YM6ui1r0nvug7Ks+/W63TS+X2mP5mXAaCs
 VuFaU+S31l+ma0WtR7zcyLTxm2yU0dvo7yVlqeQ==
X-Gm-Gg: ASbGnct+Q3MyiOP8dLNM8r1cG1xTd3D+cayQ9Gff6Rmn/CJR+TEZ6QkKk5WRdwSzHMc
 +T4OIXMZ16RWdft8uuED9oRlsqeTxXR0=
X-Google-Smtp-Source: AGHT+IGBPNMvyklRM8TTIoCbvqge5U+d1BR+KlG1XNBe8c9e5vhv1cnKaYZICZul3wwm95e1QPtxRLuQ1Z5wMr/do9Q=
X-Received: by 2002:a05:690c:4b0c:b0:6ec:b74d:a013 with SMTP id
 00721157ae682-6efad1c48aemr29815377b3.19.1733231497428; Tue, 03 Dec 2024
 05:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20241128144416.604126-1-adrianox@gmail.com>
 <20241128144416.604126-14-adrianox@gmail.com>
In-Reply-To: <20241128144416.604126-14-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Dec 2024 15:11:01 +0200
Message-ID: <CAC_iWjK8P9BAwOAzJNeaE+tsQ81TjQqKeFsy5hoP2cRMjSGzQQ@mail.gmail.com>
Subject: Re: [PATCH v6 13/14] efi_selftest: add test for HTTP protocol
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

On Thu, 28 Nov 2024 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add a test for the EFI_HTTP_PROTOCOL and
> EFI_SEVICE_BINDING_PROTOCOL.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>  lib/efi_selftest/Makefile            |   2 +-
>  lib/efi_selftest/efi_selftest_http.c | 315 +++++++++++++++++++++++++++
>  2 files changed, 316 insertions(+), 1 deletion(-)
>  create mode 100644 lib/efi_selftest/efi_selftest_http.c
>
> diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
> index 414701893f..140c08effc 100644
> --- a/lib/efi_selftest/Makefile
> +++ b/lib/efi_selftest/Makefile
> @@ -52,7 +52,7 @@ efi_selftest_watchdog.o
>
>  obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
>  obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
> -
> +obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
>  obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_selftest_devicepath.o
>  obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += \
>  efi_selftest_unicode_collation.o
> diff --git a/lib/efi_selftest/efi_selftest_http.c b/lib/efi_selftest/efi_selftest_http.c
> new file mode 100644
> index 0000000000..ce3cf33887
> --- /dev/null
> +++ b/lib/efi_selftest/efi_selftest_http.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * efi_selftest_http
> + *
> + * This unit test covers the IPv4 Config2 Protocol, Http Service Binding Protocol,
> + * and Http Protocol.
> + *
> + * An Http HEAD and an Http GET request are sent to the same destination. The test
> + * is successful if the HEAD request gets a response with a valid Content-Length header
> + * and the subsequent GET request receives the amount of bytes informed by the previous
> + * Content-Length header.
> + *
> + */
> +
> +#include <efi_selftest.h>
> +#include <charset.h>
> +#include <net.h>
> +
> +static struct efi_boot_services *boottime;
> +
> +static struct efi_http_protocol *http;
> +static struct efi_service_binding_protocol *http_service;
> +static struct efi_ip4_config2_protocol *ip4_config2;
> +static efi_handle_t http_protocol_handle;
> +
> +static const efi_guid_t efi_http_guid = EFI_HTTP_PROTOCOL_GUID;
> +static const efi_guid_t efi_http_service_binding_guid = EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID;
> +static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
> +static int callback_done;
> +
> +/*
> + * Setup unit test.
> + *
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
> +       struct efi_http_config_data http_config;
> +       struct efi_httpv4_access_point ipv4_node;
> +
> +       boottime = systable->boottime;
> +
> +       boottime->locate_handle_buffer(BY_PROTOCOL, &efi_ip4_config2_guid,
> +                                      NULL, &num_handles, &handles);
> +

Same remarks as the other test-related patch, Check the number of
handles early and exit

> +       for (net_handle = handles; num_handles--; net_handle++) {
> +               ret = boottime->open_protocol(*net_handle, &efi_ip4_config2_guid,
> +                                             (void **)&ip4_config2, 0, 0,
> +                                             EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +               if (ret != EFI_SUCCESS || !ip4_config2)
> +                       continue;
> +               ret = boottime->open_protocol(*net_handle,
> +                                             &efi_http_service_binding_guid,
> +                                             (void **)&http_service, 0, 0,
> +                                             EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +               if (ret != EFI_SUCCESS || !http_service)
> +                       continue;
> +               break; // Get first handle that supports both protocols
> +       }
> +
> +       if (!ip4_config2 || !http_service) {
> +               efi_st_error("Failed to locate ipv4 config2 or http service binding protocol\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       http_protocol_handle = NULL;
> +       ret = http_service->create_child(http_service, &http_protocol_handle);

I haven't checked the creation patches yet, but does it make sense to
return EFI_SUCCESS if the protocol handle for the creation failed?
IOW if http_protocol_handle == NULL shouldn't we return something else?

> +       if (ret != EFI_SUCCESS || !http_protocol_handle) {
> +               efi_st_error("Failed to create an http service instance\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       ret = boottime->open_protocol(http_protocol_handle, &efi_http_guid,
> +                                     (void **)&http, 0, 0, EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> +       if (ret != EFI_SUCCESS || !http) {
> +               efi_st_error("Failed to open http protocol\n");
> +               return EFI_ST_FAILURE;
> +       }
> +       efi_st_printf("HTTP Service Binding: child created successfully\n");
> +
> +       http_config.http_version = HTTPVERSION11;
> +       http_config.is_ipv6 = false;
> +       http_config.access_point.ipv4_node = &ipv4_node;
> +       ipv4_node.use_default_address = true;
> +
> +       ret = http->configure(http, &http_config);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to configure http instance\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       return EFI_ST_SUCCESS;
> +}
> +
> +void EFIAPI efi_test_http_callback(struct efi_event *event, void *context)
> +{
> +       callback_done = 1;
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
> +       struct efi_http_request_data request_data;
> +       struct efi_http_message request_message;
> +       struct efi_http_token request_token;
> +       struct efi_http_response_data response_data;
> +       struct efi_http_message response_message;
> +       struct efi_http_token response_token;
> +       enum efi_http_status_code status_code;
> +       void *response_buffer;
> +       efi_uintn_t len, sum;
> +       char *url = "http://example.com/";
> +       u16 url_16[64];
> +       u16 *tmp;
> +
> +       /* Setup may have failed */
> +       if (!ip4_config2 || !http) {
> +               efi_st_error("Cannot proceed with test after setup failure\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       tmp = url_16;
> +       utf8_utf16_strcpy(&tmp, url);
> +       request_data.url = url_16;
> +       request_data.method = HTTP_METHOD_GET;
> +
> +       request_message.data.request = &request_data;
> +       request_message.header_count = 3;
> +       request_message.body_length = 0;
> +       request_message.body = NULL;
> +
> +       /* request token */
> +       request_token.event = NULL;
> +       request_token.status = EFI_NOT_READY;
> +       request_token.message = &request_message;
> +       callback_done = 0;
> +       ret = boottime->create_event(EVT_NOTIFY_SIGNAL,
> +                       TPL_CALLBACK,
> +                       efi_test_http_callback,
> +                       NULL,
> +                       &request_token.event);
> +
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed to create request event\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       ret = http->request(http, &request_token);
> +
> +       if (ret != EFI_SUCCESS) {
> +               boottime->close_event(request_token.event);
> +               efi_st_printf("Failed to proceed with the http request\n");
> +               return EFI_ST_SUCCESS;
> +       }
> +
> +       while (!callback_done)
> +               http->poll(http);
> +
> +       response_data.status_code = HTTP_STATUS_UNSUPPORTED_STATUS;
> +       response_message.data.response = &response_data;
> +       response_message.header_count = 0;
> +       response_message.headers = NULL;
> +       response_message.body_length = 0;
> +       response_message.body = NULL;
> +       response_token.event = NULL;
> +
> +       ret = boottime->create_event(EVT_NOTIFY_SIGNAL,
> +                       TPL_CALLBACK,
> +                       efi_test_http_callback,
> +                       NULL,
> +                       &response_token.event);
> +
> +       if (ret != EFI_SUCCESS) {
> +               boottime->close_event(request_token.event);
> +               efi_st_error("Failed to create response event\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
> +       response_token.status = EFI_SUCCESS;
> +       response_token.message = &response_message;
> +
> +       callback_done = 0;
> +       ret = http->response(http, &response_token);
> +
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed http first response\n");
> +               goto fail;
> +       }
> +
> +       while (!callback_done)
> +               http->poll(http);
> +
> +       if (response_message.data.response->status_code != HTTP_STATUS_200_OK) {
> +               status_code = response_message.data.response->status_code;
> +               if (status_code == HTTP_STATUS_404_NOT_FOUND) {
> +                       efi_st_error("File not found\n");
> +               } else {
> +                       efi_st_error("Bad http status %d\n",
> +                                    response_message.data.response->status_code);
> +               }
> +               goto fail_free_hdr;
> +       }
> +
> +       ret = boottime->allocate_pool(EFI_LOADER_CODE, response_message.body_length,
> +                                     &response_buffer);
> +       if (ret != EFI_SUCCESS) {
> +               efi_st_error("Failed allocating response buffer\n");
> +               goto fail_free_hdr;
> +       }
> +
> +       len = response_message.body_length;
> +       sum = 0;
> +       while (len) {
> +               response_message.data.response = NULL;
> +               response_message.header_count = 0;
> +               response_message.headers = NULL;
> +               response_message.body_length = len;
> +               response_message.body = response_buffer + sum;
> +
> +               response_token.message = &response_message;
> +               response_token.status = EFI_NOT_READY;
> +
> +               callback_done = 0;
> +               ret = http->response(http, &response_token);
> +               if (ret != EFI_SUCCESS) {
> +                       efi_st_error("Failed http second response\n");
> +                       goto fail_free_buf;
> +               }
> +
> +               while (!callback_done)
> +                       http->poll(http);
> +
> +               if (!response_message.body_length)
> +                       break;
> +
> +               len -= response_message.body_length;
> +               sum += response_message.body_length;
> +       }
> +
> +       if (len)
> +               goto fail_free_buf;
> +
> +       boottime->free_pool(response_buffer);
> +       if (response_message.headers)
> +               boottime->free_pool(response_message.headers);
> +       boottime->close_event(request_token.event);
> +       boottime->close_event(response_token.event);
> +       efi_st_printf("Efi Http request executed successfully\n");
> +       return EFI_ST_SUCCESS;
> +
> +fail_free_buf:
> +       boottime->free_pool(response_buffer);
> +fail_free_hdr:
> +       if (response_message.headers)
> +               boottime->free_pool(response_message.headers);
> +fail:
> +       boottime->close_event(request_token.event);
> +       boottime->close_event(response_token.event);
> +       return EFI_ST_FAILURE;
> +}
> +
> +/*
> + * Tear down unit test.
> + *
> + * Return:     EFI_ST_SUCCESS for success
> + */
> +static int teardown(void)
> +{
> +       efi_status_t ret;
> +       int exit_status = EFI_ST_SUCCESS;
> +
> +       if (!http_service || !http_protocol_handle) {
> +               efi_st_error("No handles to destroy http instance");
> +               exit_status = EFI_ST_FAILURE;
> +       } else {
> +               ret = http_service->destroy_child(http_service, http_protocol_handle);
> +               if (ret != EFI_SUCCESS) {
> +                       efi_st_error("Failed to destroy http instance");
> +                       exit_status = EFI_ST_FAILURE;
> +               }
> +               efi_st_printf("HTTP Service Binding: child destroyed successfully\n");
> +       }
> +
> +       return exit_status;
> +}
> +
> +EFI_UNIT_TEST(http) = {
> +       .name = "http protocol",
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
