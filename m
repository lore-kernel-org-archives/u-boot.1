Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD681D5E373
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 16:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89B788DB6;
	Sat,  9 Nov 2024 17:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eWPaLy0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC25F88C4C; Sat,  9 Nov 2024 17:01:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C009A88F4F
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 17:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731168087; x=1731772887; i=xypron.glpk@gmx.de;
 bh=3xQ6ay8eFnHN1zrLfyo9G4AicK0rsBDaO8hO4Siq7wA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eWPaLy0dIk2PSerhErP2R6XQvCeEvmknzIZWbYUiNZZeAkqaPxlnC9lbBDSilAcF
 cayUd/N7ZofVefi5PNjOMqqYYtM2pOL/C7Enb/fEJPDnn1+T4JaocfKl0VGs2Wtfo
 G9Kqqg3QskbAbbpKTq7q2w3aTUu9sbSMlGYyCswveHJTuj3QN2TGiG1L0Rlsmq/od
 yS7LXC/MdnGUgSZIYT5v7sYLmeeZxbIB2BL/VlqY/WWO/C7CiileKjgoRtiPwUk9s
 ezbNRK3ho4XdH0cLOIMYoht3xd4dQDpmbpmmUVXoNP+nuLsmo7+mqlKWtOCdzkGYS
 c9tX9E9beFJwteFk+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.72]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1tWnvP1wJo-00hRNL; Sat, 09
 Nov 2024 17:01:27 +0100
Message-ID: <9cd2793e-5f3d-482d-bf0c-8d21d01bd67f@gmx.de>
Date: Sat, 9 Nov 2024 17:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] efi_loader: efi_net: add EFI_HTTP_PROTOCOL
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241108034739.346492-1-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241108034739.346492-1-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j4UP9esOnBat6+nNR+tj/JkRUUk3OZUG03xVFl8TU7eX7ojg6Pl
 imodrf1zFRKSJRNZ59Bc6rN9me9NqsqzoFhA60IzSonnKZhEULwM+6jtQMhfUlT/67nEt2R
 LgO8mqZllbujfpiG1towW4dbYSrWN8ymEhmenmryVzlixQBOo3FzI7H6LR2PkZpPUUivPqR
 i5+GgQhmfLFN162X6NprQ==
UI-OutboundReport: notjunk:1;M01:P0:tHf6usBHPPA=;GzsUBf4SfG71fKhV++uQNhifpsy
 H5ADw23yTEGHZ3Y8ILVXAW8+ih4H95b4LBVi5vpY7t/karHt4O+9fHI/KvP1SCQZC4fE+Vfzv
 IpalNdUdhJPmOD+vrIl9tMx9QgdjcTa4M6fpvaJ5gsxOiF2ZzdZ79s5v8fBSWEyXi7y68UOAf
 He3SI+0jGxMHp6QvLtKggUDoTBxY5pUbI8uxhRmPjp+iDXemg+Lmesi0YnRkExn1oDGtzEJoW
 wEf2hJHfPXHFrZscsTrxgkUpt3W4FsSp/fEgxyky5Jux4qMSvZ/+OkkRTIqHhTnnlc07K3IH2
 6QzNY5ikxBKOpnfjiVD2WvmhIjvwmEz+CrLpWCYt4M27DVBxYZJzEnZVeva0XdLnRDh5xJ2JR
 y67gsh0wq9Ljdb6OoUav5ybsyVWdr0uZWcCsi4aqzX/CAJSmywtYyFpf3CV+O3uZfnMbZ/zxY
 ajSiR2DVXwfyAlu4bQxhnS8eWfnOITpwrNd7rGEa6a5AhASjnl5XU1uEoQSBzstvEXfjMtKFv
 oDfWqdli44/LkTr+lxBCa2ODUH3CnA3dzBn6R1ll8thX/eO7b43jan1EQPv/HBA/c17VnMl9y
 DePnsO8d9iKK8//fWd9vpUAV2ULAXsIANtxAbyLsgKPFNHN1p7e8i02MaSPQSht5pC8lQPIiL
 Kygaa12z1dcl/xDqT/i0zNEYijqLGdw1VoCDAQRpd5v2Ja/4FYFKX6i5q6zo84WlrPccN/Qid
 zV6b8FqJDZl4DVfhH7Yy/jS8bopbD37ye37tKG7B5ux71n941M18WTw5dzn4KTOFNFScs4wbG
 5zS2QPO7PnKXRlBA40PD3l1Q==
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

On 11/8/24 04:47, Adriano Cordova wrote:
> Add an EFI HTTP driver. This commit implements the
> EFI_HTTP_PROTOCOL and the EFI_HTTP_SERVICE_BINDING_PROTOCOL.
> The latter is attached to the handle of th efi network
> device. This is the same handle where snp, pxe, and ipconfig
> are attached to.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

We should not print anything to the console inside an EFI protocol
because this will lead to inconsistent output. E.g. the linenumber
retrieved from the EFI console may not match the current output position
on the screen

net/wget.c contains some log_err() statements. The should be replaced by
log_debug(). If user notification is necessary it should occur in the
wget command itself.

We can handle this issue in a follow up patch.

Further comments below.

> ---
>   include/efi_loader.h      |   3 +
>   lib/efi_loader/Kconfig    |   8 +
>   lib/efi_loader/Makefile   |   1 +
>   lib/efi_loader/efi_http.c | 537 ++++++++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_net.c  |  17 ++
>   5 files changed, 566 insertions(+)
>   create mode 100644 lib/efi_loader/efi_http.c
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 216b2a9d00..b6c780757a 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -630,6 +630,9 @@ efi_status_t efi_net_register(void);
>   /* Called by efi_net_register to make the ip4 config2 protocol availab=
le */
>   efi_status_t efi_ipconfig_register(const efi_handle_t handle,
>   				   struct efi_ip4_config2_protocol *ip4config);
> +/* Called by efi_net_register to make the http protocol available */
> +efi_status_t efi_http_register(const efi_handle_t handle,
> +			       struct efi_service_binding_protocol *http_service_binding);
>   /* Called by bootefi to make the watchdog available */
>   efi_status_t efi_watchdog_register(void);
>   efi_status_t efi_initrd_register(void);
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 36377487f3..6f9bc80883 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -485,6 +485,14 @@ config EFI_IP4_CONFIG2_PROTOCOL
>   	  protocol can be used to set and get the current ip address and
>   	  other network information.
>
> +config EFI_HTTP_PROTOCOL
> +	bool "EFI_HTTP_PROTOCOL support"
> +	default y
> +	depends on WGET
> +	help
> +	  Provides an EFI HTTP driver implementing the EFI_HTTP_PROTOCOL. and
> +	  EFI_HTTP_SERVICE_BINDING_PROTOCOL.
> +
>   endmenu
>
>   menu "Misc options"
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 0c7e8cfeb8..39df872369 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_VIDEO) +=3D efi_gop.o
>   obj-$(CONFIG_BLK) +=3D efi_disk.o
>   obj-$(CONFIG_NETDEVICES) +=3D efi_net.o
>   obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) +=3D efi_ipconfig.o
> +obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_http.o
>   obj-$(CONFIG_ACPI) +=3D efi_acpi.o
>   obj-$(CONFIG_SMBIOS) +=3D efi_smbios.o
>   obj-$(CONFIG_EFI_RNG_PROTOCOL) +=3D efi_rng.o
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> new file mode 100644
> index 0000000000..41a40a7e64
> --- /dev/null
> +++ b/lib/efi_loader/efi_http.c
> @@ -0,0 +1,537 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * An HTTP driver
> + *
> + * HTTP_PROTOCOL
> + * HTTP_SERVICE_BINDING_PROTOCOL
> + * IP4_CONFIG2_PROTOCOL
> + */
> +
> +#include <charset.h>
> +#include <efi_loader.h>
> +#include <image.h>
> +#include <malloc.h>
> +#include <mapmem.h>
> +#include <net.h>
> +
> +static const efi_guid_t efi_http_service_binding_guid =3D EFI_HTTP_SERV=
ICE_BINDING_PROTOCOL_GUID;
> +static const efi_guid_t efi_http_guid =3D EFI_HTTP_PROTOCOL_GUID;
> +
> +struct efi_http_instance {
> +	struct efi_http_protocol http;	// EFI_HTTP_PROTOCOL
> +	efi_handle_t handle;		// Pointer to efi object
> +	bool configured;
> +	ulong http_load_addr;
> +	ulong file_size;
> +	ulong current_offset;
> +	ulong num_headers;
> +	struct http_header headers[MAX_HTTP_HEADERS];
> +	char headers_buffer[MAX_HTTP_HEADERS_SIZE];
> +};
> +
> +static int num_instances;
> +

Please, describe all structures, enums, functions in Sphinx style.
Cf.
https://www.kernel.org/doc/html/v4.16/doc-guide/kernel-doc.html#writing-ke=
rnel-doc-comments

> +enum efi_http_status_code efi_ul_to_httpstatus(ulong status);
> +
> +static efi_status_t efi_http_send_data(void *client_buffer,
> +				       efi_uintn_t *client_buffer_size,
> +				       struct efi_http_instance *inst)
> +{
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	ulong total_size, transfer_size;

We should use the same type as the function parameter size. This makes
it clear that not truncation occurs.

> +	uchar *ptr;
> +
> +	// Amount of data left;
> +	total_size =3D inst->file_size;
> +	transfer_size =3D total_size - inst->current_offset;
> +	debug("efi_http: sending data to client, total size %lu\n", total_size=
);
> +	// Amount of data the client is willing to receive
> +	if (transfer_size > *client_buffer_size)
> +		transfer_size =3D *client_buffer_size;
> +	else
> +		*client_buffer_size =3D transfer_size;
> +	debug("efi_http: transfer size %lu\n", transfer_size);
> +	if (!transfer_size) // Ok, only headers
> +		goto out;
> +
> +	if (!client_buffer) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	// Send data
> +	ptr =3D map_sysmem(inst->http_load_addr + inst->current_offset, transf=
er_size);
> +	memcpy(client_buffer, ptr, transfer_size);
> +	unmap_sysmem(ptr);
> +
> +	inst->current_offset +=3D transfer_size;
> +
> +	// Whole file served, clean the buffer:
> +	if (inst->current_offset =3D=3D inst->file_size) {
> +		efi_free_pool((void *)inst->http_load_addr);
> +		inst->current_offset =3D 0;
> +		inst->file_size =3D 0;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/* EFI_HTTP_PROTOCOL */
> +
> +/*
> + * efi_http_get_mode_data() - Gets the current operational status.
> + *
> + * This function implements EFI_HTTP_PROTOCOL.GetModeData()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @data:	pointer to the buffer for operational parameters
> + *		of this HTTP instance
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_http_get_mode_data(struct efi_http_proto=
col *this,
> +						  struct efi_http_config_data *data)
> +{
> +	EFI_ENTRY("%p, %p", this, data);
> +
> +	efi_status_t ret =3D EFI_UNSUPPORTED;
> +
> +	/* Only support ipv4 */
> +	if (!this || !data || !data->access_point.ipv4_node) {

The UEFI standard requires to check ipv6_node, too:

"Http ConfigData->AccessPoint.IPv4Node or Http
ConfigData->AccessPoint.IPv6Node is NULL"

See 29.6.4 EFI_HTTP_PROTOCOL.GetModeData() in UEFI Spec 2.10 Errata A.

> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}

If the API is unsupported, why invest in checking the parameters?

> +
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_http_configure() - Initializes operational status for this
> + * EFI HTTP instance.
> + *
> + * This function implements EFI_HTTP_PROTOCOL.Configure()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @data:	pointer to the buffer for operational parameters of
> + *		this HTTP instance
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_http_configure(struct efi_http_protocol =
*this,
> +					      struct efi_http_config_data *data)
> +{
> +	EFI_ENTRY("%p, %p", this, data);
> +
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	enum efi_http_version http_version;
> +	struct efi_httpv4_access_point *ipv4_node;
> +	struct efi_http_instance *http_instance;
> +
> +	if (!this) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	http_instance =3D (struct efi_http_instance *)this;
> +
> +	if (!data) {
> +		efi_free_pool((void *)http_instance->http_load_addr);
> +		http_instance->current_offset =3D 0;
> +		http_instance->configured =3D false;
> +
> +		goto out;
> +	}
> +
> +	if (http_instance->configured) {
> +		ret =3D EFI_ALREADY_STARTED;
> +		goto out;
> +	}
> +
> +	http_version =3D data->http_version;
> +	ipv4_node =3D data->access_point.ipv4_node;
> +
> +	if ((http_version !=3D HTTPVERSION10 &&
> +	    http_version !=3D HTTPVERSION11) ||
> +	    data->is_ipv6 || !ipv4_node) { /* Only support ipv4 */
> +		ret =3D EFI_UNSUPPORTED;
> +		goto out;
> +	}
> +
> +	if (!ipv4_node->use_default_address) {
> +		efi_net_set_addr((struct efi_ipv4_address *)&ipv4_node->local_address=
,
> +				 (struct efi_ipv4_address *)&ipv4_node->local_subnet, NULL);
> +	}
> +
> +	http_instance->current_offset =3D 0;
> +	http_instance->configured =3D true;
> +
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_http_request() - Queues an HTTP request to this HTTP instance
 > + *> + * This function implements EFI_HTTP_PROTOCOL.Request()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @token:	pointer to storage containing HTTP request token
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_http_request(struct efi_http_protocol *t=
his,
> +					    struct efi_http_token *token)
> +{
> +	EFI_ENTRY("%p, %p", this, token);
> +
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	u8 *tmp;
> +	u8 url_8[1024];
> +	u16 *url_16;
> +	enum efi_http_method current_method;
> +	struct efi_http_instance *http_instance;
> +
> +	if (!token || !this) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	http_instance =3D (struct efi_http_instance *)this;
> +
> +	if (!http_instance->configured) {
> +		ret =3D EFI_NOT_STARTED;
> +		goto out;
> +	}
> +
> +	if (!token->message || !token->message->data.request)
> +		goto out_invalid;
> +
> +	current_method =3D token->message->data.request->method;
> +	url_16 =3D token->message->data.request->url;
> +
> +	/* Parse URL. It comes in UCS-2 encoding and follows RFC3986 */
> +	tmp =3D url_8;
> +	utf16_utf8_strcpy((char **)&tmp, url_16);

Please, use utf16_utf8_strncpy() to avoid buffer overruns.

> +
> +	ret =3D efi_net_do_request(url_8, current_method, &http_instance->http=
_load_addr,
> +				 &http_instance->file_size, http_instance->headers_buffer);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
> +	// We have a new file
> +	efi_net_parse_headers(&http_instance->num_headers, http_instance->head=
ers);
> +	http_instance->current_offset =3D 0;
> +	token->status =3D EFI_SUCCESS;
> +	goto out_signal;
> +
> +out_invalid:
> +	ret =3D EFI_INVALID_PARAMETER;
> +	token->status =3D EFI_ABORTED;
> +out_signal:
> +	efi_signal_event(token->event);
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_http_cancel() - Abort an asynchronous HTTP request or response t=
oken
> + *
> + * This function implements EFI_HTTP_PROTOCOL.Cancel()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @token:	pointer to storage containing HTTP request token
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_http_cancel(struct efi_http_protocol *th=
is,
> +					   struct efi_http_token *token)
> +{
> +	EFI_ENTRY("%p, %p", this, token);
> +
> +	efi_status_t ret =3D EFI_UNSUPPORTED;
> +
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_http_response() -  Queues an HTTP response to this HTTP instance
> + *
> + * This function implements EFI_HTTP_PROTOCOL.Response()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @token:	pointer to storage containing HTTP request token
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_http_response(struct efi_http_protocol *=
this,
> +					     struct efi_http_token *token)
> +{
> +	EFI_ENTRY("%p, %p", this, token);
> +
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_http_instance *http_instance;
> +	struct efi_http_header **client_headers;
> +	struct efi_http_response_data *response;
> +
> +	if (!token) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	if (!this || !token->message)
> +		goto out_invalid;
> +
> +	http_instance =3D (struct efi_http_instance *)this;
> +
> +	// Set HTTP status code
> +	if (token->message->data.response) { // TODO extra check, see spec.
> +		response =3D token->message->data.response;
> +		response->status_code =3D efi_ul_to_httpstatus(wget_info.status_code)=
;
> +	}
> +	client_headers =3D &token->message->headers;
> +	ret =3D efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
> +				(http_instance->num_headers) * sizeof(struct efi_http_header),
> +				(void **)client_headers); // This is deallocated by the client.
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out_bad_signal;
> +
> +	// Send headers
> +	token->message->header_count =3D http_instance->num_headers;
> +	for (int i =3D 0; i < http_instance->num_headers; i++) {
> +		(*client_headers)[i].field_name =3D http_instance->headers[i].name;
> +		(*client_headers)[i].field_value =3D http_instance->headers[i].value;
> +	}
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out_bad_signal;
> +
> +	ret =3D efi_http_send_data(token->message->body, &token->message->body=
_length, http_instance);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out_bad_signal;
> +
> +	token->status =3D EFI_SUCCESS;
> +	goto out_signal;
> +
> +out_invalid:
> +	ret =3D EFI_INVALID_PARAMETER;
> +out_bad_signal:
> +	token->status =3D EFI_ABORTED;
> +out_signal:
> +	efi_signal_event(token->event);
> +out:
> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_http_poll() -  Polls for incoming data packets and processes out=
going data packets
> + *
> + * This function implements EFI_HTTP_PROTOCOL.Poll()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:	pointer to the protocol instance
> + * @token:	pointer to storage containing HTTP request token
> + * Return:	status code
> + */
> +static efi_status_t EFIAPI efi_http_poll(struct efi_http_protocol *this=
)
> +{
> +	EFI_ENTRY("%p", this);
> +
> +	efi_status_t ret =3D EFI_UNSUPPORTED;
> +
> +	return EFI_EXIT(ret);
> +}
> +
> +/* EFI_HTTP_SERVICE_BINDING_PROTOCOL */
> +
> +/*
> + * efi_http_service_binding_create_child() -  Creates a child handle
> + * and installs a protocol
> + *
> + * This function implements EFI_HTTP_SERVICE_BINDING.CreateChild()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:		pointer to the protocol instance
> + * @child_handle:	pointer to child handle
> + * Return:		status code
> + */
> +static efi_status_t EFIAPI efi_http_service_binding_create_child(
> +			struct efi_service_binding_protocol *this,
> +			efi_handle_t *child_handle)
> +{
> +	EFI_ENTRY("%p, %p", this, child_handle);
> +
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_http_instance *new_instance;
> +
> +	if (!child_handle)
> +		return EFI_EXIT(EFI_INVALID_PARAMETER);
> +
> +	new_instance =3D calloc(1, sizeof(struct efi_http_instance));
> +	if (!new_instance) {
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +		goto failure_to_add_protocol;
> +	}
> +
> +	new_instance->handle =3D NULL;

You are using calloc() to memset the structure to all NUL bytes.
So this statement is superfluous.

> +
> +	if (*child_handle) {
> +		new_instance->handle =3D *child_handle;
> +		goto install;
> +	}
> +
> +	new_instance->handle =3D calloc(1, sizeof(struct efi_object));
> +	if (!new_instance->handle) {
> +		efi_free_pool((void *)new_instance);
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +		goto failure_to_add_protocol;
> +	}
> +
> +	efi_add_handle(new_instance->handle);
> +	*child_handle =3D new_instance->handle;
> +
> +install:
> +	ret =3D efi_add_protocol(new_instance->handle, &efi_http_guid,
> +			       &new_instance->http);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto failure_to_add_protocol;
> +
> +	new_instance->http.get_mode_data =3D efi_http_get_mode_data;
> +	new_instance->http.configure =3D efi_http_configure;
> +	new_instance->http.request =3D efi_http_request;
> +	new_instance->http.cancel =3D efi_http_cancel;
> +	new_instance->http.response =3D efi_http_response;
> +	new_instance->http.poll =3D efi_http_poll;
> +	++num_instances;
> +
> +	return EFI_EXIT(EFI_SUCCESS);

Please, add empty line.

> +failure_to_add_protocol:
> +	printf("ERROR: Failure to add protocol\n");

In protocols we should never write to the console.

If you want debug output use the EFI_PRINT() macro.

We always want an empty line before return.

> +	return EFI_EXIT(ret);
> +}
> +
> +/*
> + * efi_http_service_binding_destroy_child() -  Destroys a child handle =
with
> + * a protocol installed on it
> + *
> + * This function implements EFI_HTTP_SERVICE_BINDING.DestroyChild()
> + * See the Unified Extensible Firmware Interface
> + * (UEFI) specification for details.
> + *
> + * @this:		pointer to the protocol instance
> + * @child_handle:	child handle
> + * Return:		status code
> + */
> +static efi_status_t EFIAPI efi_http_service_binding_destroy_child(
> +			struct efi_service_binding_protocol *this,
> +			efi_handle_t child_handle)
> +{
> +	EFI_ENTRY("%p, %p", this, child_handle);
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_http_instance *http_instance;
> +	struct efi_handler *phandler;
> +	void *protocol_interface;
> +
> +	if (num_instances =3D=3D 0)
> +		return EFI_EXIT(EFI_NOT_FOUND);

I would prefer to have only one EFI_EXIT(ret) at the end of the code.

> +
> +	if (!child_handle)
> +		return EFI_EXIT(EFI_INVALID_PARAMETER);
> +
> +	efi_search_protocol(child_handle, &efi_http_guid, &phandler);
> +
> +	if (phandler)
> +		protocol_interface =3D phandler->protocol_interface;
> +
> +	ret =3D efi_delete_handle(child_handle);
> +	if (ret !=3D EFI_SUCCESS) {
> +		printf("ERROR: Failure to remove protocol\n");
> +		return EFI_EXIT(ret);
> +	}
> +
> +	http_instance =3D (struct efi_http_instance *)protocol_interface;
> +	efi_free_pool((void *)http_instance->http_load_addr);
> +
> +	free(protocol_interface);
> +
> +	num_instances--;

Nits: Empty line missing.

> +	return EFI_EXIT(EFI_SUCCESS);
> +}
> +
> +/**
> + * efi_http_register() - register the http protocol
> + *
> + */
> +efi_status_t efi_http_register(const efi_handle_t handle,
> +			       struct efi_service_binding_protocol *http_service_binding)
> +{
> +	efi_status_t r =3D EFI_SUCCESS;
> +
> +	r =3D efi_add_protocol(handle, &efi_http_service_binding_guid,
> +			     http_service_binding);
> +	if (r !=3D EFI_SUCCESS)
> +		goto failure_to_add_protocol;
> +
> +	http_service_binding->create_child =3D efi_http_service_binding_create=
_child;
> +	http_service_binding->destroy_child =3D efi_http_service_binding_destr=
oy_child;
> +
> +	return EFI_SUCCESS;
> +failure_to_add_protocol:
> +	printf("ERROR: Failure to add protocol\n");
> +	return r;
> +}
> +
> +enum efi_http_status_code efi_ul_to_httpstatus(ulong status)
> +{
> +	switch (status) {
> +	case 100: return HTTP_STATUS_100_CONTINUE;
> +	case 101: return HTTP_STATUS_101_SWITCHING_PROTOCOLS;
> +	case 200: return HTTP_STATUS_200_OK;
> +	case 201: return HTTP_STATUS_201_CREATED;
> +	case 202: return HTTP_STATUS_202_ACCEPTED;
> +	case 203: return HTTP_STATUS_203_NON_AUTHORITATIVE_INFORMATION;
> +	case 204: return HTTP_STATUS_204_NO_CONTENT;
> +	case 205: return HTTP_STATUS_205_RESET_CONTENT;
> +	case 206: return HTTP_STATUS_206_PARTIAL_CONTENT;
> +	case 300: return HTTP_STATUS_300_MULTIPLE_CHOICES;
> +	case 301: return HTTP_STATUS_301_MOVED_PERMANENTLY;
> +	case 302: return HTTP_STATUS_302_FOUND;
> +	case 303: return HTTP_STATUS_303_SEE_OTHER;
> +	case 304: return HTTP_STATUS_304_NOT_MODIFIED;
> +	case 305: return HTTP_STATUS_305_USE_PROXY;
> +	case 307: return HTTP_STATUS_307_TEMPORARY_REDIRECT;
> +	case 400: return HTTP_STATUS_400_BAD_REQUEST;
> +	case 401: return HTTP_STATUS_401_UNAUTHORIZED;
> +	case 402: return HTTP_STATUS_402_PAYMENT_REQUIRED;
> +	case 403: return HTTP_STATUS_403_FORBIDDEN;
> +	case 404: return HTTP_STATUS_404_NOT_FOUND;
> +	case 405: return HTTP_STATUS_405_METHOD_NOT_ALLOWED;
> +	case 406: return HTTP_STATUS_406_NOT_ACCEPTABLE;
> +	case 407: return HTTP_STATUS_407_PROXY_AUTHENTICATION_REQUIRED;
> +	case 408: return HTTP_STATUS_408_REQUEST_TIME_OUT;
> +	case 409: return HTTP_STATUS_409_CONFLICT;
> +	case 410: return HTTP_STATUS_410_GONE;
> +	case 411: return HTTP_STATUS_411_LENGTH_REQUIRED;
> +	case 412: return HTTP_STATUS_412_PRECONDITION_FAILED;
> +	case 413: return HTTP_STATUS_413_REQUEST_ENTITY_TOO_LARGE;
> +	case 414: return HTTP_STATUS_414_REQUEST_URI_TOO_LARGE;
> +	case 415: return HTTP_STATUS_415_UNSUPPORTED_MEDIA_TYPE;
> +	case 416: return HTTP_STATUS_416_REQUESTED_RANGE_NOT_SATISFIED;
> +	case 417: return HTTP_STATUS_417_EXPECTATION_FAILED;
> +	case 500: return HTTP_STATUS_500_INTERNAL_SERVER_ERROR;
> +	case 501: return HTTP_STATUS_501_NOT_IMPLEMENTED;
> +	case 502: return HTTP_STATUS_502_BAD_GATEWAY;
> +	case 503: return HTTP_STATUS_503_SERVICE_UNAVAILABLE;
> +	case 504: return HTTP_STATUS_504_GATEWAY_TIME_OUT;
> +	case 505: return HTTP_STATUS_505_HTTP_VERSION_NOT_SUPPORTED;
> +	case 308: return HTTP_STATUS_308_PERMANENT_REDIRECT;
> +	default: return HTTP_STATUS_UNSUPPORTED_STATUS;
> +	}
> +}
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 015b6a7cc1..2c9fc17795 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -54,6 +54,7 @@ static struct efi_event *wait_for_packet;
>    * @pxe:			PXE base code protocol interface
>    * @pxe_mode:			status of the PXE base code protocol
>    * @ip4_config2:		IP4 Config2 protocol interface
> + * @http_service_binding:	Http service binding protocol interface
>    */
>   struct efi_net_obj {
>   	struct efi_object header;
> @@ -64,6 +65,9 @@ struct efi_net_obj {
>   #ifdef CONFIG_EFI_IP4_CONFIG2_PROTOCOL
>   	struct efi_ip4_config2_protocol ip4_config2;
>   #endif
> +#ifdef CONFIG_EFI_HTTP_PROTOCOL
> +	struct efi_service_binding_protocol http_service_binding;
> +#endif
>   };
>
>   /*
> @@ -997,6 +1001,19 @@ efi_status_t efi_net_register(void)
>   		goto failure_to_add_protocol;
>   #endif
>
> +#ifdef CONFIG_EFI_HTTP_PROTOCOL
> +	r =3D efi_http_register(&netobj->header, &netobj->http_service_binding=
);
> +	if (r !=3D EFI_SUCCESS)
> +		goto failure_to_add_protocol;
> +	/*
> +	 * No harm on doing the following. If the pxe handle is present the cl=
ient could

%s/is present the/is present, the/

> +	 * find it and try to get its IP from it. In here the pxe handle is pr=
esent but the

%s/IP/IP address/

%s/In here/As in U-Boot/

%s/pxe/PXE/ (multiple instances)

> +	 * pxe protocol is not yet implmenented, so we add this on the meantim=
e.

%s/on the meantime/in the meantime/

Best regards

Heinrich

> +	 */
> +	efi_net_get_addr((struct efi_ipv4_address *)&netobj->pxe_mode.station_=
ip,
> +			 (struct efi_ipv4_address *)&netobj->pxe_mode.subnet_mask, NULL);
> +#endif
> +
>   	return EFI_SUCCESS;
>   failure_to_add_protocol:
>   	printf("ERROR: Failure to add protocol\n");

