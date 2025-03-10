Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7D3C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 06:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFC7811B2;
	Mon, 10 Mar 2025 07:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jZHgeX98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76F0811DF; Mon, 10 Mar 2025 07:50:36 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD4580107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1741589275; x=1742194075; i=xypron.glpk@gmx.de;
 bh=YRN0mJn1VxCRXM93agYYgwc92qmXbR17TAJrn3Cf8QM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jZHgeX98/zGPIHUg5xqfybOazn6BGG9qUJik40UW2ginPIu6DuR9EpyHnrPVakHX
 bDVWEGOra73YkeyhXToBDl2UZCcw7iy2XPGEeCE1byX3KNVHDlru8ptYkrr1g8/P2
 dOi+Db4RTbOzRhrEg8BJjtoRpPRaMFpmEBjymN2iYCrO4/2y2wFgFtH/u9RaOktvR
 xXRBpvB8LzVCj3m6sZMDb2RAcGu01YPQZJBP51q89PxN+dAnhqGw3GhhfkaMnjH8D
 pehAmKBWe+VvpywjgirN6Qg/RJNqXVACxqZrFWpYzSi3qYcenXXyse0B232HMUUeT
 x1V3YlgvUZHr0RA0Rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1tv7pH3yDN-008XSs; Mon, 10
 Mar 2025 07:47:55 +0100
Message-ID: <1a1654b9-af4b-46dd-9aa9-94ab13bf3185@gmx.de>
Date: Mon, 10 Mar 2025 07:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] efi_loader: efi_net: Add support for multiple
 efi_net_obj
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250303141317.265098-1-adriano.cordova@canonical.com>
 <20250303141317.265098-8-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250303141317.265098-8-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b//OOqdH187jpNc3iL3XtSrO1Su4io+Sy1d0CRMQipkJlFQvGPa
 pEvmBO7nrZot3geu2+tdEmGuV2n9wQgHbuUNMAiBbYTRj5wTuEy1BqNtv3Fn0kfDQ+wHAB7
 9WApQDqFLR8SdyxQkb5rVp2F3wbiEsXtDPPuleL6vV8lC6f2nnsK/ES0guT73uaILdTO1xo
 E1tzFCNtXkPN+Q7ITMdmQ==
UI-OutboundReport: notjunk:1;M01:P0:+dAjcE7klOA=;WyP5jn3KrU/pQz2q8ZLYI4KETtg
 hw6SVA24svAlcn/JjWwyxFGNIcpmjzO6xOWX91EBbYg0fXHOcGoUqbSBtHXII0UsiuO8lA+I2
 xFJ/xZhYls6ZXe55s1W/NcSUWhXendXPR7/PbwO4Fnfh626QQfLMEkTeXRfyXqpV7SqLovr9d
 Y4WFD/VlDNVG0Hil/bCyJuxco/Bz3HL6eEVpvTobDs5/IZ998+rg73QcyZrN5aylxfnvWs31m
 6NROJHUlXWu5yV8ko1D1sAJ9vuy5BZpRu4D6GwWlN/AUOjhd9BOx5clsO/NaelT1rQJCtfKyp
 RISfmfeDab7G8WbjbetJ9dvE6IIwbtdkxC2O4+sNnkIHZdC2X+SqYKdKMVMy0DFcLDni+ZaBG
 kZ9OAKSavUdSgB5Nj2Lxrftn2O0tHxhBp8WdSPsg14uul33M7ogswPsmkdAYYwKiXjMUoXexU
 vo07QS3WevvmxuiWA2FlUoTnYPFa8ULiXb+G5OYygKdEcyqmadYMabQv+O3ugZLcRj6+yN/yL
 j4zqNLsF1AkLeAKfGHc3EDqg5DZ/kAN6EQy6TZI9XvM3z6kzasJa/EKJGaf9+XltTJPcZwQCw
 vvFj3SKIPxHSr0MFz1g/WUKhz4lgnwizOrTS7woJIfXYhv7L0mtg/QF1KfMfJIEpxOTETiIk9
 yEypMweWDdV9v7Otyk9QRv0xCwr7FOFQtC5TeG5La2xg5zkrXe054vN8GvI/WLpaRbj1PAo7W
 W9XiqeA+D6KNNf4fB+3YXnceW2Ogi4M/orfkY7K9vbVERgJCpAFn52P/DX5IewRpoq6jzq6op
 /EvoXjU9I3o1g/T2l0jcvXnozQDva8hZsW8SkPBiC4BswFYWpCctADEEYBn1Lvl9teC1pKH3R
 2uKQT3AjLerE/rSJ2uA3w2bY/vks/MwF2HFHm+m4IHJxnaL/GFJYPa/nPGWj/VgZJKBM65cjm
 FAGLvslhI0+xeqPOEgT2gF4B6lY5rxMztTu5M+j+CvbdSU2f4Ls3kCmWR6Bm8wyE4CS8J+Ce2
 4OqDG9X21QE5lGlP2ge/oRgxTmecgjnoz2EY+Jj2Ixm6LTPNiWJli9+HMsW0rRmsZRe87bclH
 W7hPuIRIhvXblhYvDsm1Eti4hCY5EAq2YLJwMrGUSE/Ta3dbfsPqK0lu12ML28+xoAa9WWnk3
 X9RR7gam/uOLoQm9SSU0xo72mw0l+3gMAEHjagGpmjPtUfmSIc2a2oT+pcYlj9E443WLMZG9d
 8OZWlyUM3RCxB99KzVY7hbpeHhLtk2E2xn3J2/PkAS+VZk9Yw3LGsiOJmZGuz1iRYI4VXm+dh
 bcJ5fFDLrGQdsTL+WCgSFNRLd22J4n3Yu4SPRsCMJLIVgMTkH1BQOpEqTjf/GvRWhzjDMDv5+
 Awc92XU3h/XMMjL5HEyzPoDRY22QFtEkE186knyVITDI97m21OBaP/P47U
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

On 3/3/25 15:13, Adriano Cordova wrote:
> Add support for multiple efi_net_obj structs in efi_net.c. This comes
> in preparation for an EFI network driver supporting multiple network
> interfaces. For now the EFI network stack still registers a single ether=
net
> udevice as an EFI network device even if multiple are present, namely
> the one that was the current device at the moment of EFI initialization.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>
> changes in v2:
> 	- fix Sphinx documentation in efi_net_obj
> 	- fix wait_for_package error
>
>   include/efi_loader.h      |   5 +-
>   lib/efi_loader/efi_http.c |   4 +-
>   lib/efi_loader/efi_net.c  | 264 +++++++++++++++++++++++++++-----------
>   3 files changed, 199 insertions(+), 74 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index d387e583f20..995ae3357ec 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -140,8 +140,11 @@ void efi_net_set_addr(struct efi_ipv4_address *ip,
>   		      struct efi_ipv4_address *mask,
>   		      struct efi_ipv4_address *gw,
>   			  struct udevice *dev);
> +#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>   efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, =
void **buffer,
> -				u32 *status_code, ulong *file_size, char *headers_buffer);
> +				u32 *status_code, ulong *file_size, char *headers_buffer,
> +				struct efi_service_binding_protocol *parent);
> +#endif
>   #define MAX_HTTP_HEADERS_SIZE SZ_64K
>   #define MAX_HTTP_HEADERS 100
>   #define MAX_HTTP_HEADER_NAME 128
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 60309ee3112..189317fe2d2 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -36,6 +36,7 @@ static const efi_guid_t efi_http_guid =3D EFI_HTTP_PRO=
TOCOL_GUID;
>   struct efi_http_instance {
>   	struct efi_http_protocol http;
>   	efi_handle_t handle;
> +	struct efi_service_binding_protocol *parent;
>   	bool configured;
>   	void *http_load_addr;
>   	ulong file_size;
> @@ -243,7 +244,7 @@ static efi_status_t EFIAPI efi_http_request(struct e=
fi_http_protocol *this,
>
>   	ret =3D efi_net_do_request(url_8, current_method, &http_instance->htt=
p_load_addr,
>   				 &http_instance->status_code, &http_instance->file_size,
> -				 http_instance->headers_buffer);
> +				 http_instance->headers_buffer, http_instance->parent);
>   	if (ret !=3D EFI_SUCCESS)
>   		goto out;
>
> @@ -408,6 +409,7 @@ static efi_status_t EFIAPI efi_http_service_binding_=
create_child(
>   		goto failure_to_add_protocol;
>   	}
>
> +	new_instance->parent =3D this;
>   	efi_add_handle(new_instance->handle);
>   	*child_handle =3D new_instance->handle;
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 2fac39ae513..aaffc7c7a13 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -24,19 +24,13 @@
>   #include <vsprintf.h>
>   #include <net.h>
>
> +#define MAX_EFI_NET_OBJS 10
>   #define MAX_NUM_DHCP_ENTRIES 10
>   #define MAX_NUM_DP_ENTRIES 10
>
>   const efi_guid_t efi_net_guid =3D EFI_SIMPLE_NETWORK_PROTOCOL_GUID;
>   static const efi_guid_t efi_pxe_base_code_protocol_guid =3D
>   					EFI_PXE_BASE_CODE_PROTOCOL_GUID;
> -static void *new_tx_packet;
> -static void *transmit_buffer;
> -static uchar **receive_buffer;
> -static size_t *receive_lengths;
> -static int rx_packet_idx;
> -static int rx_packet_num;
> -static struct efi_net_obj *netobj;
>
>   struct dp_entry {
>   	struct efi_device_path *net_dp;
> @@ -70,16 +64,6 @@ struct dhcp_entry {
>   static struct dhcp_entry dhcp_cache[MAX_NUM_DHCP_ENTRIES];
>   static int next_dhcp_entry;
>
> -/*
> - * The notification function of this event is called in every timer cyc=
le
> - * to check if a new network packet has been received.
> - */
> -static struct efi_event *network_timer_event;
> -/*
> - * This event is signaled when a packet has been received.
> - */
> -static struct efi_event *wait_for_packet;
> -
>   /**
>    * struct efi_net_obj - EFI object representing a network interface
>    *
> @@ -91,6 +75,15 @@ static struct efi_event *wait_for_packet;
>    * @pxe_mode:			status of the PXE base code protocol
>    * @ip4_config2:		IP4 Config2 protocol interface
>    * @http_service_binding:	Http service binding protocol interface
> + * @new_tx_packet:		new transmit packet
> + * @transmit_buffer:	transmit buffer
> + * @receive_buffer:		array of receive buffers
> + * @receive_lengths:	array of lengths for received packets
> + * @rx_packet_idx:		index of the current receive packet
> + * @rx_packet_num:		number of received packets
> + * @wait_for_packet:	signaled when a packet has been received
> + * @network_timer_event:	event to check for new network packets.
> + * @efi_seq_num:		sequence number of the EFI net object.
>    */
>   struct efi_net_obj {
>   	struct efi_object header;
> @@ -105,13 +98,25 @@ struct efi_net_obj {
>   #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>   	struct efi_service_binding_protocol http_service_binding;
>   #endif
> +	void *new_tx_packet;
> +	void *transmit_buffer;
> +	uchar **receive_buffer;
> +	size_t *receive_lengths;
> +	int rx_packet_idx;
> +	int rx_packet_num;
> +	struct efi_event *wait_for_packet;
> +	struct efi_event *network_timer_event;
> +	int efi_seq_num;
>   };
>
> -/*
> +static int curr_efi_net_obj;
> +static struct efi_net_obj *net_objs[MAX_EFI_NET_OBJS];
> +
> +/**
>    * efi_netobj_is_active() - checks if a netobj is active in the efi su=
bsystem
>    *
> - * @netobj:    pointer to efi_net_obj
> - * Return:     true if active
> + * @netobj:	pointer to efi_net_obj
> + * Return:	true if active
>    */
>   static bool efi_netobj_is_active(struct efi_net_obj *netobj)
>   {
> @@ -121,6 +126,25 @@ static bool efi_netobj_is_active(struct efi_net_obj=
 *netobj)
>   	return true;
>   }
>
> +/*
> + * efi_netobj_from_snp() - get efi_net_obj from simple network protocol
> + *
> + *
> + * @snp:	pointer to the simple network protocol
> + * Return:	pointer to efi_net_obj, NULL on error
> + */
> +static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_networ=
k *snp)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && &net_objs[i]->net =3D=3D snp) {
> +			// Do not register duplicate devices
> +			return net_objs[i];
> +		}
> +	}
> +	return NULL;
> +}
>
>   /*
>    * efi_net_start() - start the network interface
> @@ -135,6 +159,7 @@ static bool efi_netobj_is_active(struct efi_net_obj =
*netobj)
>   static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *th=
is)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p", this);
>   	/* Check parameters */
> @@ -143,11 +168,13 @@ static efi_status_t EFIAPI efi_net_start(struct ef=
i_simple_network *this)
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	if (this->mode->state !=3D EFI_NETWORK_STOPPED) {
>   		ret =3D EFI_ALREADY_STARTED;
>   	} else {
>   		this->int_status =3D 0;
> -		wait_for_packet->is_signaled =3D false;
> +		nt->wait_for_packet->is_signaled =3D false;
>   		this->mode->state =3D EFI_NETWORK_STARTED;
>   	}
>   out:
> @@ -167,6 +194,7 @@ out:
>   static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *thi=
s)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p", this);
>
> @@ -176,15 +204,17 @@ static efi_status_t EFIAPI efi_net_stop(struct efi=
_simple_network *this)
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	if (this->mode->state =3D=3D EFI_NETWORK_STOPPED) {
>   		ret =3D EFI_NOT_STARTED;
>   	} else {
>   		/* Disable hardware and put it into the reset state */
> -		eth_set_dev(netobj->dev);
> +		eth_set_dev(nt->dev);
>   		env_set("ethact", eth_get_name());
>   		eth_halt();
>   		/* Clear cache of packets */
> -		rx_packet_num =3D 0;
> +		nt->rx_packet_num =3D 0;
>   		this->mode->state =3D EFI_NETWORK_STOPPED;
>   	}
>   out:
> @@ -208,6 +238,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct=
 efi_simple_network *this,
>   {
>   	int ret;
>   	efi_status_t r =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
>
> @@ -216,6 +247,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct=
 efi_simple_network *this,
>   		r =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> +	nt =3D efi_netobj_from_snp(this);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_INITIALIZED:
> @@ -229,12 +261,12 @@ static efi_status_t EFIAPI efi_net_initialize(stru=
ct efi_simple_network *this,
>   	/* Setup packet buffers */
>   	net_init();
>   	/* Clear cache of packets */
> -	rx_packet_num =3D 0;
> +	nt->rx_packet_num =3D 0;
>   	/* Set the net device corresponding to the efi net object */
> -	eth_set_dev(netobj->dev);
> +	eth_set_dev(nt->dev);
>   	env_set("ethact", eth_get_name());
>   	/* Get hardware ready for send and receive operations */
> -	ret =3D eth_start_udev(netobj->dev);
> +	ret =3D eth_start_udev(nt->dev);
>   	if (ret < 0) {
>   		eth_halt();
>   		this->mode->state =3D EFI_NETWORK_STOPPED;
> @@ -242,7 +274,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct=
 efi_simple_network *this,
>   		goto out;
>   	} else {
>   		this->int_status =3D 0;
> -		wait_for_packet->is_signaled =3D false;
> +		nt->wait_for_packet->is_signaled =3D false;
>   		this->mode->state =3D EFI_NETWORK_INITIALIZED;
>   	}
>   out:
> @@ -303,6 +335,7 @@ out:
>   static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network =
*this)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p", this);
>
> @@ -311,6 +344,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct e=
fi_simple_network *this)
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> +	nt =3D efi_netobj_from_snp(this);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_INITIALIZED:
> @@ -323,12 +357,12 @@ static efi_status_t EFIAPI efi_net_shutdown(struct=
 efi_simple_network *this)
>   		goto out;
>   	}
>
> -	eth_set_dev(netobj->dev);
> +	eth_set_dev(nt->dev);
>   	env_set("ethact", eth_get_name());
>   	eth_halt();
>
>   	this->int_status =3D 0;
> -	wait_for_packet->is_signaled =3D false;
> +	nt->wait_for_packet->is_signaled =3D false;
>   	this->mode->state =3D EFI_NETWORK_STARTED;
>
>   out:
> @@ -504,6 +538,7 @@ static efi_status_t EFIAPI efi_net_get_status(struct=
 efi_simple_network *this,
>   					      u32 *int_status, void **txbuf)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
>
> @@ -515,6 +550,8 @@ static efi_status_t EFIAPI efi_net_get_status(struct=
 efi_simple_network *this,
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_STOPPED:
>   		ret =3D EFI_NOT_STARTED;
> @@ -531,9 +568,9 @@ static efi_status_t EFIAPI efi_net_get_status(struct=
 efi_simple_network *this,
>   		this->int_status =3D 0;
>   	}
>   	if (txbuf)
> -		*txbuf =3D new_tx_packet;
> +		*txbuf =3D nt->new_tx_packet;
>
> -	new_tx_packet =3D NULL;
> +	nt->new_tx_packet =3D NULL;
>   out:
>   	return EFI_EXIT(ret);
>   }
> @@ -560,6 +597,7 @@ static efi_status_t EFIAPI efi_net_transmit
>   		 struct efi_mac_address *dest_addr, u16 *protocol)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
>   		  (unsigned long)header_size, (unsigned long)buffer_size,
> @@ -573,6 +611,8 @@ static efi_status_t EFIAPI efi_net_transmit
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	/* We do not support jumbo packets */
>   	if (buffer_size > PKTSIZE_ALIGN) {
>   		ret =3D EFI_INVALID_PARAMETER;
> @@ -617,14 +657,14 @@ static efi_status_t EFIAPI efi_net_transmit
>   		break;
>   	}
>
> -	eth_set_dev(netobj->dev);
> +	eth_set_dev(nt->dev);
>   	env_set("ethact", eth_get_name());
>
>   	/* Ethernet packets always fit, just bounce */
> -	memcpy(transmit_buffer, buffer, buffer_size);
> -	net_send_packet(transmit_buffer, buffer_size);
> +	memcpy(nt->transmit_buffer, buffer, buffer_size);
> +	net_send_packet(nt->transmit_buffer, buffer_size);
>
> -	new_tx_packet =3D buffer;
> +	nt->new_tx_packet =3D buffer;
>   	this->int_status |=3D EFI_SIMPLE_NETWORK_TRANSMIT_INTERRUPT;
>   out:
>   	return EFI_EXIT(ret);
> @@ -655,6 +695,7 @@ static efi_status_t EFIAPI efi_net_receive
>   	struct ethernet_hdr *eth_hdr;
>   	size_t hdr_size =3D sizeof(struct ethernet_hdr);
>   	u16 protlen;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
>   		  buffer_size, buffer, src_addr, dest_addr, protocol);
> @@ -668,6 +709,8 @@ static efi_status_t EFIAPI efi_net_receive
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_STOPPED:
>   		ret =3D EFI_NOT_STARTED;
> @@ -679,16 +722,16 @@ static efi_status_t EFIAPI efi_net_receive
>   		break;
>   	}
>
> -	if (!rx_packet_num) {
> +	if (!nt->rx_packet_num) {
>   		ret =3D EFI_NOT_READY;
>   		goto out;
>   	}
>   	/* Fill export parameters */
> -	eth_hdr =3D (struct ethernet_hdr *)receive_buffer[rx_packet_idx];
> +	eth_hdr =3D (struct ethernet_hdr *)nt->receive_buffer[nt->rx_packet_id=
x];
>   	protlen =3D ntohs(eth_hdr->et_protlen);
>   	if (protlen =3D=3D 0x8100) {
>   		hdr_size +=3D 4;
> -		protlen =3D ntohs(*(u16 *)&receive_buffer[rx_packet_idx][hdr_size - 2=
]);
> +		protlen =3D ntohs(*(u16 *)&nt->receive_buffer[nt->rx_packet_idx][hdr_=
size - 2]);
>   	}
>   	if (header_size)
>   		*header_size =3D hdr_size;
> @@ -698,20 +741,20 @@ static efi_status_t EFIAPI efi_net_receive
>   		memcpy(src_addr, eth_hdr->et_src, ARP_HLEN);
>   	if (protocol)
>   		*protocol =3D protlen;
> -	if (*buffer_size < receive_lengths[rx_packet_idx]) {
> +	if (*buffer_size < nt->receive_lengths[nt->rx_packet_idx]) {
>   		/* Packet doesn't fit, try again with bigger buffer */
> -		*buffer_size =3D receive_lengths[rx_packet_idx];
> +		*buffer_size =3D nt->receive_lengths[nt->rx_packet_idx];
>   		ret =3D EFI_BUFFER_TOO_SMALL;
>   		goto out;
>   	}
>   	/* Copy packet */
> -	memcpy(buffer, receive_buffer[rx_packet_idx],
> -	       receive_lengths[rx_packet_idx]);
> -	*buffer_size =3D receive_lengths[rx_packet_idx];
> -	rx_packet_idx =3D (rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV;
> -	rx_packet_num--;
> -	if (rx_packet_num)
> -		wait_for_packet->is_signaled =3D true;
> +	memcpy(buffer, nt->receive_buffer[nt->rx_packet_idx],
> +	       nt->receive_lengths[nt->rx_packet_idx]);
> +	*buffer_size =3D nt->receive_lengths[nt->rx_packet_idx];
> +	nt->rx_packet_idx =3D (nt->rx_packet_idx + 1) % ETH_PACKETS_BATCH_RECV=
;
> +	nt->rx_packet_num--;
> +	if (nt->rx_packet_num)
> +		nt->wait_for_packet->is_signaled =3D true;
>   	else
>   		this->int_status &=3D ~EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
>   out:
> @@ -730,6 +773,7 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>   {
>   	struct efi_pxe_packet **dhcp_ack;
>   	struct udevice *dev;
> +	int i;
>
>   	dhcp_ack =3D &dhcp_cache[next_dhcp_entry].dhcp_ack;
>
> @@ -750,6 +794,12 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>   	dhcp_cache[next_dhcp_entry].dev =3D dev;
>   	next_dhcp_entry++;
>   	next_dhcp_entry %=3D MAX_NUM_DHCP_ENTRIES;
> +
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
> +			net_objs[i]->pxe_mode.dhcp_ack =3D **dhcp_ack;
> +		}
> +	}
>   }
>
>   /**
> @@ -763,6 +813,11 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>   static void efi_net_push(void *pkt, int len)
>   {
>   	int rx_packet_next;
> +	struct efi_net_obj *nt;
> +
> +	nt =3D net_objs[curr_efi_net_obj];
> +	if (!nt)
> +		return;
>
>   	/* Check that we at least received an Ethernet header */
>   	if (len < sizeof(struct ethernet_hdr))
> @@ -773,15 +828,15 @@ static void efi_net_push(void *pkt, int len)
>   		return;
>
>   	/* Can't store more than pre-alloced buffer */
> -	if (rx_packet_num >=3D ETH_PACKETS_BATCH_RECV)
> +	if (nt->rx_packet_num >=3D ETH_PACKETS_BATCH_RECV)
>   		return;
>
> -	rx_packet_next =3D (rx_packet_idx + rx_packet_num) %
> +	rx_packet_next =3D (nt->rx_packet_idx + nt->rx_packet_num) %
>   	    ETH_PACKETS_BATCH_RECV;
> -	memcpy(receive_buffer[rx_packet_next], pkt, len);
> -	receive_lengths[rx_packet_next] =3D len;
> +	memcpy(nt->receive_buffer[rx_packet_next], pkt, len);
> +	nt->receive_lengths[rx_packet_next] =3D len;
>
> -	rx_packet_num++;
> +	nt->rx_packet_num++;
>   }
>
>   /**
> @@ -796,6 +851,7 @@ static void EFIAPI efi_network_timer_notify(struct e=
fi_event *event,
>   					    void *context)
>   {
>   	struct efi_simple_network *this =3D (struct efi_simple_network *)cont=
ext;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %p", event, context);
>
> @@ -806,16 +862,19 @@ static void EFIAPI efi_network_timer_notify(struct=
 efi_event *event,
>   	if (!this || this->mode->state !=3D EFI_NETWORK_INITIALIZED)
>   		goto out;
>
> -	if (!rx_packet_num) {
> -		eth_set_dev(netobj->dev);
> +	nt =3D efi_netobj_from_snp(this);
> +	curr_efi_net_obj =3D nt->efi_seq_num;
> +
> +	if (!nt->rx_packet_num) {
> +		eth_set_dev(nt->dev);
>   		env_set("ethact", eth_get_name());
>   		push_packet =3D efi_net_push;
>   		eth_rx();
>   		push_packet =3D NULL;
> -		if (rx_packet_num) {
> +		if (nt->rx_packet_num) {
>   			this->int_status |=3D
>   				EFI_SIMPLE_NETWORK_RECEIVE_INTERRUPT;
> -			wait_for_packet->is_signaled =3D true;
> +			nt->wait_for_packet->is_signaled =3D true;
>   		}
>   	}
>   out:
> @@ -1011,9 +1070,19 @@ static struct efi_device_path *efi_netobj_get_dp(=
struct efi_net_obj *netobj)
>   efi_status_t efi_net_do_start(struct udevice *dev)
>   {
>   	efi_status_t r =3D EFI_SUCCESS;
> +	struct efi_net_obj *netobj;
>   	struct efi_device_path *net_dp;
> +	int i;
>
> -	if (dev !=3D netobj->dev )
> +	netobj =3D NULL;
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
> +			netobj =3D net_objs[i];
> +			break;
> +		}
> +	}
> +
> +	if (!efi_netobj_is_active(netobj))
>   		return r;
>
>   	efi_net_dp_from_dev(&net_dp, netobj->dev, true);
> @@ -1056,6 +1125,11 @@ set_addr:
>   efi_status_t efi_net_register(struct udevice *dev)
>   {
>   	efi_status_t r;
> +	int seq_num;
> +	struct efi_net_obj *netobj;
> +	void *transmit_buffer;
> +	uchar **receive_buffer;

Both buffers must be intialized to NULL because your jump to
out_of_resources if calloc() for netobj fails.

Best regards

Heinrich

> +	size_t *receive_lengths;
>   	int i, j;
>
>   	if (!dev) {
> @@ -1063,6 +1137,23 @@ efi_status_t efi_net_register(struct udevice *dev=
)
>   		return EFI_SUCCESS;
>   	}
>
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
> +			// Do not register duplicate devices
> +			return EFI_SUCCESS;
> +		}
> +	}
> +
> +	seq_num =3D -1;
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (!net_objs[i]) {
> +			seq_num =3D i;
> +			break;
> +		}
> +	}
> +	if (seq_num < 0)
> +		return EFI_OUT_OF_RESOURCES;
> +
>   	/* We only expose the "active" network device, so one is enough */
>   	netobj =3D calloc(1, sizeof(*netobj));
>   	if (!netobj)
> @@ -1075,6 +1166,7 @@ efi_status_t efi_net_register(struct udevice *dev)
>   	if (!transmit_buffer)
>   		goto out_of_resources;
>   	transmit_buffer =3D (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIG=
N);
> +	netobj->transmit_buffer =3D transmit_buffer;
>
>   	/* Allocate a number of receive buffers */
>   	receive_buffer =3D calloc(ETH_PACKETS_BATCH_RECV,
> @@ -1086,11 +1178,13 @@ efi_status_t efi_net_register(struct udevice *de=
v)
>   		if (!receive_buffer[i])
>   			goto out_of_resources;
>   	}
> +	netobj->receive_buffer =3D receive_buffer;
>
>   	receive_lengths =3D calloc(ETH_PACKETS_BATCH_RECV,
>   				 sizeof(*receive_lengths));
>   	if (!receive_lengths)
>   		goto out_of_resources;
> +	netobj->receive_lengths =3D receive_lengths;
>
>   	/* Hook net up to the device list */
>   	efi_add_handle(&netobj->header);
> @@ -1162,13 +1256,12 @@ efi_status_t efi_net_register(struct udevice *de=
v)
>   	 */
>   	r =3D efi_create_event(EVT_NOTIFY_WAIT, TPL_CALLBACK,
>   			     efi_network_timer_notify, NULL, NULL,
> -			     &wait_for_packet);
> +			     &netobj->wait_for_packet);
>   	if (r !=3D EFI_SUCCESS) {
>   		printf("ERROR: Failed to register network event\n");
>   		return r;
>   	}
> -	netobj->net.wait_for_packet =3D wait_for_packet;
> -
> +	netobj->net.wait_for_packet =3D netobj->wait_for_packet;
>   	/*
>   	 * Create a timer event.
>   	 *
> @@ -1179,13 +1272,13 @@ efi_status_t efi_net_register(struct udevice *de=
v)
>   	 */
>   	r =3D efi_create_event(EVT_TIMER | EVT_NOTIFY_SIGNAL, TPL_NOTIFY,
>   			     efi_network_timer_notify, &netobj->net, NULL,
> -			     &network_timer_event);
> +			     &netobj->network_timer_event);
>   	if (r !=3D EFI_SUCCESS) {
>   		printf("ERROR: Failed to register network event\n");
>   		return r;
>   	}
>   	/* Network is time critical, create event in every timer cycle */
> -	r =3D efi_set_timer(network_timer_event, EFI_TIMER_PERIODIC, 0);
> +	r =3D efi_set_timer(netobj->network_timer_event, EFI_TIMER_PERIODIC, 0=
);
>   	if (r !=3D EFI_SUCCESS) {
>   		printf("ERROR: Failed to set network timer\n");
>   		return r;
> @@ -1202,6 +1295,8 @@ efi_status_t efi_net_register(struct udevice *dev)
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
> +	netobj->efi_seq_num =3D seq_num;
> +	net_objs[seq_num] =3D netobj;
>   	return EFI_SUCCESS;
>   failure_to_add_protocol:
>   	printf("ERROR: Failure to add protocol\n");
> @@ -1233,8 +1328,10 @@ out_of_resources:
>   efi_status_t efi_net_new_dp(const char *dev, const char *server, struc=
t udevice *udev)
>   {
>   	efi_status_t ret;
> +	struct efi_net_obj *netobj;
>   	struct efi_device_path *old_net_dp, *new_net_dp;
>   	struct efi_device_path **dp;
> +	int i;
>
>   	dp =3D &dp_cache[next_dp_entry].net_dp;
>
> @@ -1256,7 +1353,14 @@ efi_status_t efi_net_new_dp(const char *dev, cons=
t char *server, struct udevice
>   	// Free the old cache entry
>   	efi_free_pool(old_net_dp);
>
> -	if (!netobj || netobj->dev !=3D udev)
> +	netobj =3D NULL;
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && net_objs[i]->dev =3D=3D udev) {
> +			netobj =3D net_objs[i];
> +			break;
> +		}
> +	}
> +	if (!netobj)
>   		return EFI_SUCCESS;
>
>   	new_net_dp =3D efi_dp_dup(*dp);
> @@ -1290,10 +1394,13 @@ void efi_net_dp_from_dev(struct efi_device_path =
**dp, struct udevice *udev, bool
>   	if (cache_only)
>   		goto cache;
>
> -	if (netobj && netobj->dev =3D=3D udev) {
> -		*dp =3D efi_netobj_get_dp(netobj);
> -		if (*dp)
> -			return;
> +	// If a netobj matches:
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && net_objs[i]->dev =3D=3D udev) {
> +			*dp =3D efi_netobj_get_dp(net_objs[i]);
> +			if (*dp)
> +				return;
> +		}
>   	}
>   cache:
>   	// Search in the cache
> @@ -1527,27 +1634,40 @@ void efi_net_parse_headers(ulong *num_headers, s=
truct http_header *headers)
>    * @status_code:	HTTP status code
>    * @file_size:		file size in bytes
>    * @headers_buffer:	headers buffer
> + * @parent:		service binding protocol
>    * Return:		status code
>    */
>   efi_status_t efi_net_do_request(u8 *url, enum efi_http_method method, =
void **buffer,
> -				u32 *status_code, ulong *file_size, char *headers_buffer)
> +				u32 *status_code, ulong *file_size, char *headers_buffer,
> +				struct efi_service_binding_protocol *parent)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
>   	int wget_ret;
>   	static bool last_head;
> +	struct udevice *dev;
> +	int i;
>
> -	if (!buffer || !file_size)
> +	if (!buffer || !file_size || !parent)
>   		return EFI_ABORTED;
>
>   	efi_wget_info.method =3D (enum wget_http_method)method;
>   	efi_wget_info.headers =3D headers_buffer;
>
> +	// Set corresponding udevice
> +	dev =3D NULL;
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && &net_objs[i]->http_service_binding =3D=3D parent)
> +			dev =3D net_objs[i]->dev;
> +	}
> +	if (!dev)
> +		return EFI_ABORTED;
> +
>   	switch (method) {
>   	case HTTP_METHOD_GET:
>   		ret =3D efi_net_set_buffer(buffer, last_head ? (size_t)efi_wget_info=
.hdr_cont_len : 0);
>   		if (ret !=3D EFI_SUCCESS)
>   			goto out;
> -		eth_set_dev(netobj->dev);
> +		eth_set_dev(dev);
>   		env_set("ethact", eth_get_name());
>   		wget_ret =3D wget_request((ulong)*buffer, url, &efi_wget_info);
>   		if ((ulong)efi_wget_info.hdr_cont_len > efi_wget_info.buffer_size) {
> @@ -1556,7 +1676,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_=
http_method method, void **buf
>   			ret =3D efi_net_set_buffer(buffer, (size_t)efi_wget_info.hdr_cont_l=
en);
>   			if (ret !=3D EFI_SUCCESS)
>   				goto out;
> -			eth_set_dev(netobj->dev);
> +			eth_set_dev(dev);
>   			env_set("ethact", eth_get_name());
>   			if (wget_request((ulong)*buffer, url, &efi_wget_info)) {
>   				efi_free_pool(*buffer);
> @@ -1577,7 +1697,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_=
http_method method, void **buf
>   		ret =3D efi_net_set_buffer(buffer, 0);
>   		if (ret !=3D EFI_SUCCESS)
>   			goto out;
> -		eth_set_dev(netobj->dev);
> +		eth_set_dev(dev);
>   		env_set("ethact", eth_get_name());
>   		wget_request((ulong)*buffer, url, &efi_wget_info);
>   		*file_size =3D 0;

