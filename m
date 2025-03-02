Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C4C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 09:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27EA80079;
	Sun,  2 Mar 2025 10:34:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="eGMOGG6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37D56806FC; Sun,  2 Mar 2025 10:34:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E72ED80050
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 10:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740908030; x=1741512830; i=xypron.glpk@gmx.de;
 bh=l2Vb/68N1NkUIy9qeCuQGYyydqBs7gXfrFNKXJy3/2A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eGMOGG6QKomjn05rMxflFmHCl08d904h1Y9qeZH21QdqvnKxdw7k91Abi97IlqyC
 CNVJ/G8kH/kNLvVkRymotuLX124J9AnHlgCv48vC4SOza6Plru3P84ikQA2In+D6I
 dMao2ZAhdcF8UCCHG9oWzK6K/EtYOKYCckSUqwuPs67H3ZPsS+9udPLsiG2aM0be/
 sIBp/YvC1JNj6zw47n21hXC4v6alY7J5HLgeLu8PPgObUav1/cJ0tCol7dOA1mlM8
 MnLtVMtbFppAmM7wqcI/56aY1j6S10FX8aQ2X4JIwVs26NJNLpcV0FZLQOgBMI2rf
 tiLAKx1a4/0P+Wch3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1tnZF41cA8-00GhNu; Sun, 02
 Mar 2025 10:33:50 +0100
Message-ID: <279e740d-2de6-4679-9539-b0ea927e058e@gmx.de>
Date: Sun, 2 Mar 2025 10:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] efi_loader: efi_net: Add support for multiple
 efi_net_obj
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250206174018.465530-1-adriano.cordova@canonical.com>
 <20250206174018.465530-9-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250206174018.465530-9-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/c3wsMovNxnb6D4t3reb5YFDGxMiFAzkIv8pQuKrfJN+Z95+Ux3
 YHyScugdE3lRxg1rzzHzQH5XF09uU2boPSWePigUBZSCaZajPquukSREgQlciSFvhQWzuKJ
 RY5oBOLTMzkI7MAfI5wc5LpnCUgsYCJQb+9sZH0BAErStPT+HdILzkCVnt+cTo2im+dnXA0
 UC2Y9Ii+P+2XlT1qWd3wQ==
UI-OutboundReport: notjunk:1;M01:P0:WGdK2GdeQvU=;j/cw5vqgPz//OKCYUbKA4AJaSuT
 9+gPDS+6/E/evn+GqZsjdbJVkLVBzsTkQb+cK5DZf10hf6CbXylQNMlu898x9z6c2xwO5HdEX
 FfzukJsDmv7svOcVokmF/jcf24t8QxJSNTtAFHDkO+e9bK+92dQnv3UETOD78isIbVDd0Rm51
 /IUDR6w5EFEHP4kFW/IqSSmNr2GEq7jrdteq3h5qr/QeIMXL0W+mmaccciUOPPOXgdpVbzJae
 0aHifaykqycwuJjaTq8VHZMfGoYCpQQJ++B2Qvm8txHNwiIY6mVqVxsrNk//bCRhkJsXOZwwg
 LSTIbTGW0VxkID4lzXT7fh24MhQiJ1b4811/KgTAkrjJACQv0QqXpngvWnrJIejEO4K19sczG
 YipN8511OPz8AiUC+IhgUZCu/7mumGDoc9xv/rYAermh0rMrp8wKvYMeJwpZC5yxHf/RHjdYW
 vX8Eiq3oa5KSQOQDffoR2HKZ8d25ofURY3EInBeqTXt+2205xhqaS+CNgq2i2Fv0yKWQ4O7Fh
 1UQxF/ubZzS9/xMNkFHWGp6UZtRihjLM9+RPTwD8tUGFucM7Y5z+EzD+x9rJdSE3ET35BT7Zh
 l5mKypIusvE92zzURC819Gp5h/jd49RGXYUeJiriyyHTd0cICQE5uYvTg2SvRRCqOVLRzzhQ2
 IHBp1kSPYBhxBRxxBHbUcqqBXA1wzaiJFD1IoChDWQ/XQi/itjEkzEupUMHVMn7XqeZKJX2CJ
 +QoTifMsOWNKFsUx26ihGeTDaGXLDUZJWM6jo4hyysY0Gq9YsUcC3Cv5sz0UACYs7h6XoZhT/
 a4VqrJSIpl+q2lkrbnc2VOaG35TAMaUnhjCimyZ1x6/99LpTNrUSJnYzTF+73AxfuHzoolf6j
 +FGz2/apdfyc5QfVtBqOXEKR1vxaUoM9Jegk0j3H9xhS7V3RIXkn3nC0PbAN3zQcewWAksTe/
 61w/Kei2RcNeCkIhf/WO7B11Ce7B727PKBAMtEhVk3aC6V8ksp9RGD+S24Ft33n9j6guvuX06
 klOaIckAkHGi2rjb9OIkY52iwpxdoA0ukpOMCT6Anmvydl56ojonLkUmzfeZDF0+Ue0kEdwSd
 8Ro4jR8r45/G9vL64zT2BpNigUWwtTKHIVURYUc6QiW98tCBimUGlyJZrHnDWrv61MtzGkgHi
 MszxF9sT57N9j+DXnkTE/XQ/rWkiOn4VHqdYjddVKBB89mi6AGneRBhYFZVMifpjpOgY1PxTH
 KEcCdHzbDgMwRf6IFxk6Jcelr14JpWaBnIif2ncmfQ5U3CmgjkwrFXDn9x0RBfpTkaUChNDWp
 8gvhi4LBQ7TLkH3eMHX+JdNPCBh58+nN5RjfFl2Trx5qxLpv9jznACkJgPCti0e+OBq1ulwCN
 Yyv4jDcnd5ELn5bn1RW9y81gXQ/RA82hsGe3txMmUm0PzXN4CxaKWjzgCa
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

On 2/6/25 18:40, Adriano Cordova wrote:
> Add support for multiple efi_net_obj structs in efi_net.c. This comes
> in preparation for an EFI network driver supporting multiple network
> interfaces. For now the EFI network stack still registers a single ether=
net
> udevice as an EFI network device even if multiple are present, namely
> the one that was the current device at the moment of EFI initialization.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   include/efi_loader.h      |   5 +-
>   lib/efi_loader/efi_http.c |   4 +-
>   lib/efi_loader/efi_net.c  | 260 +++++++++++++++++++++++++++-----------
>   3 files changed, 196 insertions(+), 73 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index a65edae3440..83a4d5b747f 100644
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
> index 2fac39ae513..b539ae071c7 100644
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
> @@ -105,13 +89,32 @@ struct efi_net_obj {
>   #if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
>   	struct efi_service_binding_protocol http_service_binding;
>   #endif
> +	void *new_tx_packet;
> +	void *transmit_buffer;
> +	uchar **receive_buffer;
> +	size_t *receive_lengths;
> +	int rx_packet_idx;
> +	int rx_packet_num;

This lets make htmldocs fail:

./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'new_tx_packet' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'transmit_buffer' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'receive_buffer' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'receive_lengths' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'rx_packet_idx' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'rx_packet_num' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'wait_for_packet' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'network_timer_event' not described in 'efi_net_obj'
./lib/efi_loader/efi_net.c:108: warning: Function parameter or member
'efi_seq_num' not described in 'efi_net_obj'


> +	/*
> +	* This event is signaled when a packet has been received.
> +	*/

Please, use Sphinx style documentation for structures and their members.

Please, have a look at
https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enum=
eration-documentation

Best regards

Heinrich

> +	struct efi_event *wait_for_packet;
> +	/*
> +	* The notification function of this event is called in every timer cyc=
le
> +	* to check if a new network packet has been received.
> +	*/
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
> @@ -121,6 +124,25 @@ static bool efi_netobj_is_active(struct efi_net_obj=
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
> @@ -135,6 +157,7 @@ static bool efi_netobj_is_active(struct efi_net_obj =
*netobj)
>   static efi_status_t EFIAPI efi_net_start(struct efi_simple_network *th=
is)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p", this);
>   	/* Check parameters */
> @@ -143,11 +166,13 @@ static efi_status_t EFIAPI efi_net_start(struct ef=
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
> @@ -167,6 +192,7 @@ out:
>   static efi_status_t EFIAPI efi_net_stop(struct efi_simple_network *thi=
s)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p", this);
>
> @@ -176,15 +202,17 @@ static efi_status_t EFIAPI efi_net_stop(struct efi=
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
> @@ -208,6 +236,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct=
 efi_simple_network *this,
>   {
>   	int ret;
>   	efi_status_t r =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %lx, %lx", this, extra_rx, extra_tx);
>
> @@ -216,6 +245,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct=
 efi_simple_network *this,
>   		r =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> +	nt =3D efi_netobj_from_snp(this);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_INITIALIZED:
> @@ -229,12 +259,12 @@ static efi_status_t EFIAPI efi_net_initialize(stru=
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
> @@ -242,7 +272,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct=
 efi_simple_network *this,
>   		goto out;
>   	} else {
>   		this->int_status =3D 0;
> -		wait_for_packet->is_signaled =3D false;
> +		nt->wait_for_packet->is_signaled =3D false;
>   		this->mode->state =3D EFI_NETWORK_INITIALIZED;
>   	}
>   out:
> @@ -303,6 +333,7 @@ out:
>   static efi_status_t EFIAPI efi_net_shutdown(struct efi_simple_network =
*this)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p", this);
>
> @@ -311,6 +342,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct e=
fi_simple_network *this)
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> +	nt =3D efi_netobj_from_snp(this);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_INITIALIZED:
> @@ -323,12 +355,12 @@ static efi_status_t EFIAPI efi_net_shutdown(struct=
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
> @@ -504,6 +536,7 @@ static efi_status_t EFIAPI efi_net_get_status(struct=
 efi_simple_network *this,
>   					      u32 *int_status, void **txbuf)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %p, %p", this, int_status, txbuf);
>
> @@ -515,6 +548,8 @@ static efi_status_t EFIAPI efi_net_get_status(struct=
 efi_simple_network *this,
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_STOPPED:
>   		ret =3D EFI_NOT_STARTED;
> @@ -531,9 +566,9 @@ static efi_status_t EFIAPI efi_net_get_status(struct=
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
> @@ -560,6 +595,7 @@ static efi_status_t EFIAPI efi_net_transmit
>   		 struct efi_mac_address *dest_addr, u16 *protocol)
>   {
>   	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %lu, %lu, %p, %p, %p, %p", this,
>   		  (unsigned long)header_size, (unsigned long)buffer_size,
> @@ -573,6 +609,8 @@ static efi_status_t EFIAPI efi_net_transmit
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	/* We do not support jumbo packets */
>   	if (buffer_size > PKTSIZE_ALIGN) {
>   		ret =3D EFI_INVALID_PARAMETER;
> @@ -617,14 +655,14 @@ static efi_status_t EFIAPI efi_net_transmit
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
> @@ -655,6 +693,7 @@ static efi_status_t EFIAPI efi_net_receive
>   	struct ethernet_hdr *eth_hdr;
>   	size_t hdr_size =3D sizeof(struct ethernet_hdr);
>   	u16 protlen;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %p, %p, %p, %p, %p, %p", this, header_size,
>   		  buffer_size, buffer, src_addr, dest_addr, protocol);
> @@ -668,6 +707,8 @@ static efi_status_t EFIAPI efi_net_receive
>   		goto out;
>   	}
>
> +	nt =3D efi_netobj_from_snp(this);
> +
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_STOPPED:
>   		ret =3D EFI_NOT_STARTED;
> @@ -679,16 +720,16 @@ static efi_status_t EFIAPI efi_net_receive
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
> @@ -698,20 +739,20 @@ static efi_status_t EFIAPI efi_net_receive
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
> @@ -730,6 +771,7 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
>   {
>   	struct efi_pxe_packet **dhcp_ack;
>   	struct udevice *dev;
> +	int i;
>
>   	dhcp_ack =3D &dhcp_cache[next_dhcp_entry].dhcp_ack;
>
> @@ -750,6 +792,12 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
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
> @@ -763,6 +811,11 @@ void efi_net_set_dhcp_ack(void *pkt, int len)
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
> @@ -773,15 +826,15 @@ static void efi_net_push(void *pkt, int len)
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
> @@ -796,6 +849,7 @@ static void EFIAPI efi_network_timer_notify(struct e=
fi_event *event,
>   					    void *context)
>   {
>   	struct efi_simple_network *this =3D (struct efi_simple_network *)cont=
ext;
> +	struct efi_net_obj *nt;
>
>   	EFI_ENTRY("%p, %p", event, context);
>
> @@ -806,16 +860,19 @@ static void EFIAPI efi_network_timer_notify(struct=
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
> @@ -1011,9 +1068,19 @@ static struct efi_device_path *efi_netobj_get_dp(=
struct efi_net_obj *netobj)
>   efi_status_t efi_net_do_start(struct udevice *dev)
>   {
>   	efi_status_t r =3D EFI_SUCCESS;
> +	struct efi_net_obj *netobj;
>   	struct efi_device_path *net_dp;
> +	int i;
> +
> +	netobj =3D NULL;
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +		if (net_objs[i] && net_objs[i]->dev =3D=3D dev) {
> +			netobj =3D net_objs[i];
> +			break;
> +		}
> +	}
>
> -	if (dev !=3D netobj->dev )
> +	if (!efi_netobj_is_active(netobj))
>   		return r;
>
>   	efi_net_dp_from_dev(&net_dp, netobj->dev, true);
> @@ -1056,6 +1123,11 @@ set_addr:
>   efi_status_t efi_net_register(struct udevice *dev)
>   {
>   	efi_status_t r;
> +	int seq_num;
> +	struct efi_net_obj *netobj;
> +	void *transmit_buffer;
> +	uchar **receive_buffer;
> +	size_t *receive_lengths;
>   	int i, j;
>
>   	if (!dev) {
> @@ -1063,6 +1135,23 @@ efi_status_t efi_net_register(struct udevice *dev=
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
> @@ -1075,6 +1164,7 @@ efi_status_t efi_net_register(struct udevice *dev)
>   	if (!transmit_buffer)
>   		goto out_of_resources;
>   	transmit_buffer =3D (void *)ALIGN((uintptr_t)transmit_buffer, PKTALIG=
N);
> +	netobj->transmit_buffer =3D transmit_buffer;
>
>   	/* Allocate a number of receive buffers */
>   	receive_buffer =3D calloc(ETH_PACKETS_BATCH_RECV,
> @@ -1086,11 +1176,13 @@ efi_status_t efi_net_register(struct udevice *de=
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
> @@ -1162,12 +1254,11 @@ efi_status_t efi_net_register(struct udevice *de=
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
>
>   	/*
>   	 * Create a timer event.
> @@ -1179,13 +1270,13 @@ efi_status_t efi_net_register(struct udevice *de=
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
> @@ -1202,6 +1293,8 @@ efi_status_t efi_net_register(struct udevice *dev)
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
>   #endif
> +	netobj->efi_seq_num =3D seq_num;
> +	net_objs[seq_num] =3D netobj;
>   	return EFI_SUCCESS;
>   failure_to_add_protocol:
>   	printf("ERROR: Failure to add protocol\n");
> @@ -1233,8 +1326,10 @@ out_of_resources:
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
> @@ -1256,7 +1351,14 @@ efi_status_t efi_net_new_dp(const char *dev, cons=
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
> @@ -1290,10 +1392,13 @@ void efi_net_dp_from_dev(struct efi_device_path =
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
> @@ -1527,27 +1632,40 @@ void efi_net_parse_headers(ulong *num_headers, s=
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
> @@ -1556,7 +1674,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_=
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
> @@ -1577,7 +1695,7 @@ efi_status_t efi_net_do_request(u8 *url, enum efi_=
http_method method, void **buf
>   		ret =3D efi_net_set_buffer(buffer, 0);
>   		if (ret !=3D EFI_SUCCESS)
>   			goto out;
> -		eth_set_dev(netobj->dev);
> +		eth_set_dev(dev);
>   		env_set("ethact", eth_get_name());
>   		wget_request((ulong)*buffer, url, &efi_wget_info);
>   		*file_size =3D 0;

