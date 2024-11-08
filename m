Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E20D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F7118920C;
	Fri,  8 Nov 2024 14:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hQXqbP+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9CF588DB6; Fri,  8 Nov 2024 04:46:28 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B50088B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-28cdd9d8d01so1016706fac.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037585; x=1731642385; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=31R1z4bDcblhJSOukuNGD5EUrsbjPEV1RdtouXYVrFU=;
 b=hQXqbP+g/JqzE3Q0oixkn3t4E7gjGKIdZEwAk0u4Hjvqoaax7YvcL/I1p40YoiyNqi
 mhZHpggG2kmoDfM4g62U0qBSTdrrIHLDeu0tbApeaeXxWd9Osj6csH0bSCVwTenCjBDX
 npAJrdUSP/ImipcPzCZQewFXcgzWtHBHOwtTpVEUoRA1P2mYTbRKpeU39/YgMXeLEMxq
 CFc5xmqQdQ5pIAkzbFsP+UUkO2jXtwEgfbSbdeTchrpHk0lzPYU2si6YNRvzpDQQNXvx
 wqqBxr/3acKbpbVjUZFgJg36VmkK6eIKzQdZ5+qgMTv7gCWwVAaDrC1aqqunhXQEn0JN
 MkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037585; x=1731642385;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31R1z4bDcblhJSOukuNGD5EUrsbjPEV1RdtouXYVrFU=;
 b=jkwVdCnz5OvSE9685d+lFXLth2t2r2g5z4k3L4Xo6SR73eHYdAJZ2Mp8MoOoz/4iJM
 tsk/3I6kdzG44XWFL8TCu8pGK+tIBVzjpT38jeyG4Q40cWYvYklZAxTrr0LfZWCtARCv
 pFkZmop+xjwjjfBrqEZq8rFc5n6lt7ZisSie/BR/KKWu05/DGkQ6C4cFb5qPKaqZBHKo
 ZzYKJm9u/MbePX2/SyjOFCd9FVDs5Fb4zcMD5lPZc2hON8OMpYtDh8RshLjJ7FqEizxF
 5ewdWKp+dbe2uL4hiRQKcMjChBhyuOLDBzk0xEoVkfrCkLltEOOK6Ytw+uLNxZRUDVNC
 8yZA==
X-Gm-Message-State: AOJu0YwV00hgpFABlZ2ro0uO83GglyVJCL8iDbEahw2oTreTI/+AQDE1
 /Tc6KWT4f+R+eS6VQpOfF+ZydiGrP+RhiRVwdJ0JtqNqUM+s6rZ7BAYMwi5/y9M=
X-Google-Smtp-Source: AGHT+IHqSQXUJQ8ETRUwZJbJdTajVqTy4yi6d6FHQQHqKmahMCUEwqlDzHm6QSWN+Zk1TBMgxsBlKw==
X-Received: by 2002:a05:6870:d915:b0:287:d54a:fa6 with SMTP id
 586e51a60fabf-29560124420mr1575002fac.22.1731037585077; 
 Thu, 07 Nov 2024 19:46:25 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240785ffb6sm2569137b3a.40.2024.11.07.19.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:46:24 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 06/15] efi_api: add definitions for HTTP and IP4_CONFIG2
 protocols
Date: Fri,  8 Nov 2024 00:46:19 -0300
Message-ID: <20241108034619.346321-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

Add EFI definitions for EFI_IP4_CONFIG2_PROTOCOL,
EFI_HTTP_SERVICE_BINDING_PROTOCOL, and EFI_HTTP_PROTOCOL.
According to UEFI spec 2.10.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_api.h | 203 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index c76519a20a..0bdc125780 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -1725,6 +1725,209 @@ struct efi_pxe_base_code_protocol {
 	struct efi_pxe_mode *mode;
 };
 
+#define EFI_IP4_CONFIG2_PROTOCOL_GUID \
+	EFI_GUID(0x5b446ed1, 0xe30b, 0x4faa, \
+		 0x87, 0x1a, 0x36, 0x54, 0xec, 0xa3, 0x60, 0x80)
+
+enum efi_ip4_config2_data_type {
+	EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO,
+	EFI_IP4_CONFIG2_DATA_TYPE_POLICY,
+	EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
+	EFI_IP4_CONFIG2_DATA_TYPE_GATEWAY,
+	EFI_IP4_CONFIG2_DATA_TYPE_DNSSERVER,
+	EFI_IP4_CONFIG2_DATA_TYPE_MAXIMUM,
+};
+
+struct efi_ip4_config2_protocol {
+	efi_status_t (EFIAPI * set_data)(struct efi_ip4_config2_protocol *this,
+					 enum efi_ip4_config2_data_type data_type,
+					 efi_uintn_t data_size,
+					 void *data);
+	efi_status_t (EFIAPI * get_data)(struct efi_ip4_config2_protocol *this,
+					 enum efi_ip4_config2_data_type data_type,
+					 efi_uintn_t *data_size,
+					 void *data);
+	efi_status_t (EFIAPI * register_data_notify)(struct efi_ip4_config2_protocol *this,
+						     enum efi_ip4_config2_data_type data_type,
+						     struct efi_event *event);
+	efi_status_t (EFIAPI * unregister_data_notify)(struct efi_ip4_config2_protocol *this,
+						       enum efi_ip4_config2_data_type data_type,
+						       struct efi_event *event);
+};
+
+struct efi_ip4_route_table {
+	struct efi_ipv4_address subnet_address;
+	struct efi_ipv4_address subnet_mask;
+	struct efi_ipv4_address gateway_address;
+};
+
+#define EFI_IP4_CONFIG2_INTERFACE_INFO_NAME_SIZE 32
+
+struct efi_ip4_config2_interface_info {
+	u16 name[EFI_IP4_CONFIG2_INTERFACE_INFO_NAME_SIZE];
+	u8 if_type;
+	u32 hw_address_size;
+	struct efi_mac_address hw_address;
+	struct efi_ipv4_address station_address;
+	struct efi_ipv4_address subnet_mask;
+	u32 route_table_size;
+	struct efi_ip4_route_table *route_table;
+};
+
+enum efi_ip4_config2_policy {
+	EFI_IP4_CONFIG2_POLICY_STATIC,
+	EFI_IP4_CONFIG2_POLICY_DHCP,
+	EFI_IP4_CONFIG2_POLICY_MAX
+};
+
+struct efi_ip4_config2_manual_address {
+	struct efi_ipv4_address address;
+	struct efi_ipv4_address subnet_mask;
+};
+
+#define EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID \
+	EFI_GUID(0xbdc8e6af, 0xd9bc, 0x4379, \
+		 0xa7, 0x2a, 0xe0, 0xc4, 0xe7, 0x5d, 0xae, 0x1c)
+
+struct efi_service_binding_protocol {
+	efi_status_t (EFIAPI * create_child)(struct efi_service_binding_protocol *this,
+					     efi_handle_t *child_handle);
+	efi_status_t (EFIAPI * destroy_child)(struct efi_service_binding_protocol *this,
+					      efi_handle_t child_handle);
+};
+
+#define EFI_HTTP_PROTOCOL_GUID \
+	EFI_GUID(0x7A59B29B, 0x910B, 0x4171, \
+		 0x82, 0x42, 0xA8, 0x5A, 0x0D, 0xF2, 0x5B, 0x5B)
+
+enum efi_http_version {
+	HTTPVERSION10,
+	HTTPVERSION11,
+	HTTPVERSIONUNSUPPORTED
+};
+
+struct efi_httpv4_access_point {
+	bool use_default_address;
+	struct efi_ipv4_address local_address;
+	struct efi_ipv4_address local_subnet;
+	u16 local_port;
+};
+
+union efi_http_access_point {
+	struct efi_httpv4_access_point *ipv4_node;
+	struct efi_httpv6_access_point *ipv6_node;
+};
+
+struct efi_http_config_data {
+	enum efi_http_version http_version;
+	u32 timeout;
+	bool is_ipv6;
+	union efi_http_access_point access_point;
+};
+
+enum efi_http_method {
+	HTTP_METHOD_GET,
+	HTTP_METHOD_POST,
+	HTTP_METHOD_PATCH,
+	HTTP_METHOD_OPTIONS,
+	HTTP_METHOD_CONNECT,
+	HTTP_METHOD_HEAD,
+	HTTP_METHOD_PUT,
+	HTTP_METHOD_DELETE,
+	HTTP_METHOD_TRACE,
+	HTTP_METHOD_MAX
+};
+
+enum efi_http_status_code {
+	HTTP_STATUS_UNSUPPORTED_STATUS = 0,
+	HTTP_STATUS_100_CONTINUE,
+	HTTP_STATUS_101_SWITCHING_PROTOCOLS,
+	HTTP_STATUS_200_OK,
+	HTTP_STATUS_201_CREATED,
+	HTTP_STATUS_202_ACCEPTED,
+	HTTP_STATUS_203_NON_AUTHORITATIVE_INFORMATION,
+	HTTP_STATUS_204_NO_CONTENT,
+	HTTP_STATUS_205_RESET_CONTENT,
+	HTTP_STATUS_206_PARTIAL_CONTENT,
+	HTTP_STATUS_300_MULTIPLE_CHOICES,
+	HTTP_STATUS_301_MOVED_PERMANENTLY,
+	HTTP_STATUS_302_FOUND,
+	HTTP_STATUS_303_SEE_OTHER,
+	HTTP_STATUS_304_NOT_MODIFIED,
+	HTTP_STATUS_305_USE_PROXY,
+	HTTP_STATUS_307_TEMPORARY_REDIRECT,
+	HTTP_STATUS_400_BAD_REQUEST,
+	HTTP_STATUS_401_UNAUTHORIZED,
+	HTTP_STATUS_402_PAYMENT_REQUIRED,
+	HTTP_STATUS_403_FORBIDDEN,
+	HTTP_STATUS_404_NOT_FOUND,
+	HTTP_STATUS_405_METHOD_NOT_ALLOWED,
+	HTTP_STATUS_406_NOT_ACCEPTABLE,
+	HTTP_STATUS_407_PROXY_AUTHENTICATION_REQUIRED,
+	HTTP_STATUS_408_REQUEST_TIME_OUT,
+	HTTP_STATUS_409_CONFLICT,
+	HTTP_STATUS_410_GONE,
+	HTTP_STATUS_411_LENGTH_REQUIRED,
+	HTTP_STATUS_412_PRECONDITION_FAILED,
+	HTTP_STATUS_413_REQUEST_ENTITY_TOO_LARGE,
+	HTTP_STATUS_414_REQUEST_URI_TOO_LARGE,
+	HTTP_STATUS_415_UNSUPPORTED_MEDIA_TYPE,
+	HTTP_STATUS_416_REQUESTED_RANGE_NOT_SATISFIED,
+	HTTP_STATUS_417_EXPECTATION_FAILED,
+	HTTP_STATUS_500_INTERNAL_SERVER_ERROR,
+	HTTP_STATUS_501_NOT_IMPLEMENTED,
+	HTTP_STATUS_502_BAD_GATEWAY,
+	HTTP_STATUS_503_SERVICE_UNAVAILABLE,
+	HTTP_STATUS_504_GATEWAY_TIME_OUT,
+	HTTP_STATUS_505_HTTP_VERSION_NOT_SUPPORTED,
+	HTTP_STATUS_308_PERMANENT_REDIRECT
+};
+
+struct efi_http_request_data {
+	enum efi_http_method method;
+	u16 *url;
+};
+
+struct efi_http_response_data {
+	enum efi_http_status_code status_code;
+};
+
+struct efi_http_header {
+	char *field_name;
+	char *field_value;
+};
+
+struct efi_http_message {
+	union {
+		struct efi_http_request_data *request;
+		struct efi_http_response_data *response;
+	} data;
+	efi_uintn_t header_count;
+	struct efi_http_header *headers;
+	efi_uintn_t body_length;
+	void *body;
+};
+
+struct efi_http_token {
+	struct efi_event *event;
+	efi_status_t status;
+	struct efi_http_message *message;
+};
+
+struct efi_http_protocol {
+	efi_status_t (EFIAPI * get_mode_data)(struct efi_http_protocol *this,
+					      struct efi_http_config_data *data);
+	efi_status_t (EFIAPI * configure)(struct efi_http_protocol *this,
+					  struct efi_http_config_data *data);
+	efi_status_t (EFIAPI * request)(struct efi_http_protocol *this,
+					struct efi_http_token *token);
+	efi_status_t (EFIAPI * cancel)(struct efi_http_protocol *this,
+				       struct efi_http_token *token);
+	efi_status_t (EFIAPI * response)(struct efi_http_protocol *this,
+					 struct efi_http_token *token);
+	efi_status_t (EFIAPI * poll)(struct efi_http_protocol *this);
+};
+
 #define EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID \
 	EFI_GUID(0x964e5b22, 0x6459, 0x11d2, \
 		 0x8e, 0x39, 0x0, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
-- 
2.43.0

