Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FDCD49211
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 12:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08B1088D61;
	Mon, 18 Nov 2024 13:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o7t7j662";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED3DA88D7E; Mon, 18 Nov 2024 13:08:49 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9E788BB7
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7f8095a200eso2828255a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731931726; x=1732536526; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4urFcqNTKlSxmqyNSgMYSfvZKGEgcU9V2ZWdvCwBfvc=;
 b=o7t7j6629eg2r5LAqdBbGRv09Ph0GDiXGXnWDDkStMrnBtSnwM3n1Ll7BRQa5FWH+4
 kSWLbhvGBNxd0CPB3zipeI76pjGAc3oBWk7Mp5k3gLan59X3up6sOhijyYuMjCSYdSej
 MmT+CINdx0aF1KXkuo4pzuyc+e5+Fjy1Kl4a7KOKgxqad8EAyL2P+PumnQW6LCwwHEGI
 EZDIOlf1DSiEdgx81l7JhbqxgyMj6Dnt7UHepIsFU4itQyRqVLNhYL1E/iqbNXz2lxx3
 8zaxbdfJwz3C4LnebBN2cjrVe7niTvLerDk5ppLGDt+aoIsl/jOc2haaFEQbhgXf0/Rr
 rdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731931726; x=1732536526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4urFcqNTKlSxmqyNSgMYSfvZKGEgcU9V2ZWdvCwBfvc=;
 b=gPFadYxRwrbC6kBkNBQPRYXKKtbK/wWNNbtwi+idQt0AF0y2j9cIF7HTZ4DsI8+D2b
 vA13lrmL8Shm/mbuUvmklpa1VGYMA21EKbZ7o40EEuW03wYsxAAxRsOdd2v56tEzqQvK
 X6QB+TyRcaQI4CPRzggwFSB125tbMqYwKZeXRKyupLNZU2ZcN33x9OYHIbHqR1t9sCYr
 llmk2+O90kh6RDCvFJ5ijR7CdLL+Mins9RYhb+htOb6lgQe4Mp2A4t84Oz0g6wBoC5HX
 2L6GLvLRX6BY5JQVYpLvj8BXFyyN/HH6XMBczK7PRRlykNR3jCCqnC+zS6jpKsIWCmrC
 ldMA==
X-Gm-Message-State: AOJu0Yx+TAadQ/lKlEXnP0vov8ywVo8GscNYqJCLV0QUwc/RmytIS1kZ
 WpktdE0skFVGSs+oS88nOxwvgljRNVpYrA1e0fVEGOlJxbVbyEJjpiBArZsHlqk/YBOR5aVXl0I
 YyD+ZlcfzvgMRvuyIZ0U0/LE+Vz8ZsgV+vNM+dw==
X-Google-Smtp-Source: AGHT+IHdz9iF1HuAT5U8wcORg0jPEdz5nVunOlvOKin1MfZFbqO8SxxBt/BBXFpwp01Hw2s32K27RvD4VE3/310/K9k=
X-Received: by 2002:a17:90a:e7ca:b0:2e0:7b03:1908 with SMTP id
 98e67ed59e1d1-2e9fe63fca3mr24412222a91.10.1731931725970; Mon, 18 Nov 2024
 04:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
 <20241111210959.560738-7-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-7-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 18 Nov 2024 14:08:09 +0200
Message-ID: <CAC_iWj+fhEMH2kLMuLOZEZFPRfGTPW5DaAChttp642-H0iiTLg@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] efi_api: add definitions for HTTP and
 IP4_CONFIG2 protocols
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

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add EFI definitions for EFI_IP4_CONFIG2_PROTOCOL,
> EFI_HTTP_SERVICE_BINDING_PROTOCOL, and EFI_HTTP_PROTOCOL.
> According to UEFI spec 2.10.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> (no changes since v2)
>
>  include/efi_api.h | 203 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 99ee749522..61c4eda8f8 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -1725,6 +1725,209 @@ struct efi_pxe_base_code_protocol {
>         struct efi_pxe_mode *mode;
>  };
>
> +#define EFI_IP4_CONFIG2_PROTOCOL_GUID \
> +       EFI_GUID(0x5b446ed1, 0xe30b, 0x4faa, \
> +                0x87, 0x1a, 0x36, 0x54, 0xec, 0xa3, 0x60, 0x80)
> +
> +enum efi_ip4_config2_data_type {
> +       EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO,
> +       EFI_IP4_CONFIG2_DATA_TYPE_POLICY,
> +       EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
> +       EFI_IP4_CONFIG2_DATA_TYPE_GATEWAY,
> +       EFI_IP4_CONFIG2_DATA_TYPE_DNSSERVER,
> +       EFI_IP4_CONFIG2_DATA_TYPE_MAXIMUM,
> +};
> +
> +struct efi_ip4_config2_protocol {
> +       efi_status_t (EFIAPI * set_data)(struct efi_ip4_config2_protocol *this,
> +                                        enum efi_ip4_config2_data_type data_type,
> +                                        efi_uintn_t data_size,
> +                                        void *data);
> +       efi_status_t (EFIAPI * get_data)(struct efi_ip4_config2_protocol *this,
> +                                        enum efi_ip4_config2_data_type data_type,
> +                                        efi_uintn_t *data_size,
> +                                        void *data);
> +       efi_status_t (EFIAPI * register_data_notify)(struct efi_ip4_config2_protocol *this,
> +                                                    enum efi_ip4_config2_data_type data_type,
> +                                                    struct efi_event *event);
> +       efi_status_t (EFIAPI * unregister_data_notify)(struct efi_ip4_config2_protocol *this,
> +                                                      enum efi_ip4_config2_data_type data_type,
> +                                                      struct efi_event *event);
> +};
> +
> +struct efi_ip4_route_table {
> +       struct efi_ipv4_address subnet_address;
> +       struct efi_ipv4_address subnet_mask;
> +       struct efi_ipv4_address gateway_address;
> +};
> +
> +#define EFI_IP4_CONFIG2_INTERFACE_INFO_NAME_SIZE 32
> +
> +struct efi_ip4_config2_interface_info {
> +       u16 name[EFI_IP4_CONFIG2_INTERFACE_INFO_NAME_SIZE];
> +       u8 if_type;
> +       u32 hw_address_size;
> +       struct efi_mac_address hw_address;
> +       struct efi_ipv4_address station_address;
> +       struct efi_ipv4_address subnet_mask;
> +       u32 route_table_size;
> +       struct efi_ip4_route_table *route_table;
> +};
> +
> +enum efi_ip4_config2_policy {
> +       EFI_IP4_CONFIG2_POLICY_STATIC,
> +       EFI_IP4_CONFIG2_POLICY_DHCP,
> +       EFI_IP4_CONFIG2_POLICY_MAX
> +};
> +
> +struct efi_ip4_config2_manual_address {
> +       struct efi_ipv4_address address;
> +       struct efi_ipv4_address subnet_mask;
> +};
> +
> +#define EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID \
> +       EFI_GUID(0xbdc8e6af, 0xd9bc, 0x4379, \
> +                0xa7, 0x2a, 0xe0, 0xc4, 0xe7, 0x5d, 0xae, 0x1c)
> +
> +struct efi_service_binding_protocol {
> +       efi_status_t (EFIAPI * create_child)(struct efi_service_binding_protocol *this,
> +                                            efi_handle_t *child_handle);
> +       efi_status_t (EFIAPI * destroy_child)(struct efi_service_binding_protocol *this,
> +                                             efi_handle_t child_handle);
> +};
> +
> +#define EFI_HTTP_PROTOCOL_GUID \
> +       EFI_GUID(0x7A59B29B, 0x910B, 0x4171, \
> +                0x82, 0x42, 0xA8, 0x5A, 0x0D, 0xF2, 0x5B, 0x5B)
> +
> +enum efi_http_version {
> +       HTTPVERSION10,
> +       HTTPVERSION11,
> +       HTTPVERSIONUNSUPPORTED
> +};
> +
> +struct efi_httpv4_access_point {
> +       bool use_default_address;
> +       struct efi_ipv4_address local_address;
> +       struct efi_ipv4_address local_subnet;
> +       u16 local_port;
> +};
> +
> +union efi_http_access_point {
> +       struct efi_httpv4_access_point *ipv4_node;
> +       struct efi_httpv6_access_point *ipv6_node;
> +};
> +
> +struct efi_http_config_data {
> +       enum efi_http_version http_version;
> +       u32 timeout;
> +       bool is_ipv6;
> +       union efi_http_access_point access_point;
> +};
> +
> +enum efi_http_method {
> +       HTTP_METHOD_GET,
> +       HTTP_METHOD_POST,
> +       HTTP_METHOD_PATCH,
> +       HTTP_METHOD_OPTIONS,
> +       HTTP_METHOD_CONNECT,
> +       HTTP_METHOD_HEAD,
> +       HTTP_METHOD_PUT,
> +       HTTP_METHOD_DELETE,
> +       HTTP_METHOD_TRACE,
> +       HTTP_METHOD_MAX
> +};
> +
> +enum efi_http_status_code {
> +       HTTP_STATUS_UNSUPPORTED_STATUS = 0,
> +       HTTP_STATUS_100_CONTINUE,
> +       HTTP_STATUS_101_SWITCHING_PROTOCOLS,
> +       HTTP_STATUS_200_OK,
> +       HTTP_STATUS_201_CREATED,
> +       HTTP_STATUS_202_ACCEPTED,
> +       HTTP_STATUS_203_NON_AUTHORITATIVE_INFORMATION,
> +       HTTP_STATUS_204_NO_CONTENT,
> +       HTTP_STATUS_205_RESET_CONTENT,
> +       HTTP_STATUS_206_PARTIAL_CONTENT,
> +       HTTP_STATUS_300_MULTIPLE_CHOICES,
> +       HTTP_STATUS_301_MOVED_PERMANENTLY,
> +       HTTP_STATUS_302_FOUND,
> +       HTTP_STATUS_303_SEE_OTHER,
> +       HTTP_STATUS_304_NOT_MODIFIED,
> +       HTTP_STATUS_305_USE_PROXY,
> +       HTTP_STATUS_307_TEMPORARY_REDIRECT,
> +       HTTP_STATUS_400_BAD_REQUEST,
> +       HTTP_STATUS_401_UNAUTHORIZED,
> +       HTTP_STATUS_402_PAYMENT_REQUIRED,
> +       HTTP_STATUS_403_FORBIDDEN,
> +       HTTP_STATUS_404_NOT_FOUND,
> +       HTTP_STATUS_405_METHOD_NOT_ALLOWED,
> +       HTTP_STATUS_406_NOT_ACCEPTABLE,
> +       HTTP_STATUS_407_PROXY_AUTHENTICATION_REQUIRED,
> +       HTTP_STATUS_408_REQUEST_TIME_OUT,
> +       HTTP_STATUS_409_CONFLICT,
> +       HTTP_STATUS_410_GONE,
> +       HTTP_STATUS_411_LENGTH_REQUIRED,
> +       HTTP_STATUS_412_PRECONDITION_FAILED,
> +       HTTP_STATUS_413_REQUEST_ENTITY_TOO_LARGE,
> +       HTTP_STATUS_414_REQUEST_URI_TOO_LARGE,
> +       HTTP_STATUS_415_UNSUPPORTED_MEDIA_TYPE,
> +       HTTP_STATUS_416_REQUESTED_RANGE_NOT_SATISFIED,
> +       HTTP_STATUS_417_EXPECTATION_FAILED,
> +       HTTP_STATUS_500_INTERNAL_SERVER_ERROR,
> +       HTTP_STATUS_501_NOT_IMPLEMENTED,
> +       HTTP_STATUS_502_BAD_GATEWAY,
> +       HTTP_STATUS_503_SERVICE_UNAVAILABLE,
> +       HTTP_STATUS_504_GATEWAY_TIME_OUT,
> +       HTTP_STATUS_505_HTTP_VERSION_NOT_SUPPORTED,
> +       HTTP_STATUS_308_PERMANENT_REDIRECT
> +};
> +
> +struct efi_http_request_data {
> +       enum efi_http_method method;
> +       u16 *url;
> +};
> +
> +struct efi_http_response_data {
> +       enum efi_http_status_code status_code;
> +};
> +
> +struct efi_http_header {
> +       char *field_name;
> +       char *field_value;
> +};
> +
> +struct efi_http_message {
> +       union {
> +               struct efi_http_request_data *request;
> +               struct efi_http_response_data *response;
> +       } data;
> +       efi_uintn_t header_count;
> +       struct efi_http_header *headers;
> +       efi_uintn_t body_length;
> +       void *body;
> +};
> +
> +struct efi_http_token {
> +       struct efi_event *event;
> +       efi_status_t status;
> +       struct efi_http_message *message;
> +};
> +
> +struct efi_http_protocol {
> +       efi_status_t (EFIAPI * get_mode_data)(struct efi_http_protocol *this,
> +                                             struct efi_http_config_data *data);
> +       efi_status_t (EFIAPI * configure)(struct efi_http_protocol *this,
> +                                         struct efi_http_config_data *data);
> +       efi_status_t (EFIAPI * request)(struct efi_http_protocol *this,
> +                                       struct efi_http_token *token);
> +       efi_status_t (EFIAPI * cancel)(struct efi_http_protocol *this,
> +                                      struct efi_http_token *token);
> +       efi_status_t (EFIAPI * response)(struct efi_http_protocol *this,
> +                                        struct efi_http_token *token);
> +       efi_status_t (EFIAPI * poll)(struct efi_http_protocol *this);
> +};
> +
>  #define EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID \
>         EFI_GUID(0x964e5b22, 0x6459, 0x11d2, \
>                  0x8e, 0x39, 0x0, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
