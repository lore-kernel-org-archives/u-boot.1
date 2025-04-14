Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363BFC369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 16:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664A382075;
	Mon, 14 Apr 2025 18:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="siuSlrhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A5468212A; Mon, 14 Apr 2025 18:03:54 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC85A8043C
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 18:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744646623; x=1745251423; i=xypron.glpk@gmx.de;
 bh=jXPCZp6M7AVcvuWZl+4t0Ho5X8nTZay7UkE37cu2qM4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=siuSlrhq4558cJp5ox+2P43qlrbJ1ijixVpECoHUHnhgYZb4Uyc3hhyo5GKFveNB
 efRADqPORNWfm8HJu8yUHIsWD5ZkPTACEFUp1pyB5DC1HFn4NDRcBjAnnt/WpTdod
 T4l0RL+0rQDLa419fnuvVTYIHS3zrcjSCKpByYz3mlbsrGJqV8w/UgkXN7Mk+a+Y7
 8dZkFt2cDMMrzmfDuZj6q9cyvvkJfvjVu7VAgnpw23m/qsdgei7qjZSjwPbiBcvbP
 LDC+BPPvY0r/V9FSLLlVWfCQ9RETEK2+nzq8mnwCvAW/91KxfJx4RiFFEQ8wpwVpn
 D7/W62FpVnmX2b3Oaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0X8u-1t8Fqd1MEW-00y3NK; Mon, 14
 Apr 2025 18:03:43 +0200
Message-ID: <c08fde08-7526-4565-98f6-004f0d02b6c7@gmx.de>
Date: Mon, 14 Apr 2025 18:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] efi_loader: efi_net: add snp_owner field to
 efi_net_obj struct
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 =trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-13-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250311164758.421900-13-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LykPw4LMAz++DrV5rHwRNYnIRR8/a2LfSic/jcocz++EX5a6MtR
 pH5q2pbfOfKSMEpf391IDniyupaOUfTII5YrPDT4Bextqm5CN+7mfQEjuzsMuMoiZhDwAaw
 ZNlrQIjrqyoszfhQYj3+3MW74WRGknXr3OBqjy0Mb/VI0VQ1IE0wkKjka8WxPYL/JwdApQf
 uCeksvLrJ3yXEH7bj7Pdw==
UI-OutboundReport: notjunk:1;M01:P0:tvRpheEAYt8=;H9UrGEKPMfSyqhWHjouebDuK2sx
 xgG09cHDF29r3gVUDTnfkVfvGE2XVwxGBwYrTdy6d2JJvX5BhBlZdywBaXf8Kov43KGdSreQd
 KxS0MVmmGQfnM65H3TfLj2sf8jSmT7e+xq7GS0obX86pwTOzUp7dCW0mhVlA0qqjeQcSTm+os
 Eu3NMLsJRJGkmysB9ungh8MQfxyvqYIdlS3uFzaDK1DtMjSHH5zs23mD+LGTbUjbT3Srr0iPN
 8lCvxwp6n6vnIS3rvBvcTkgyTAl/vCDY4uUcQPUgjPkjXLFxO0b4B5sX6NNUdp19sRAFGsova
 NmbkWEUMjf71uosjKoarzM2+/HbG0iAVDBGEgErkSnr33R0iVpJ0VVqZAyUnwKtU+mJtzPjFN
 5Y4photCRSzU5JgIGSlpiDmQPaB+JMDxFhi0xOucSFrsobjaLczLZsTv8u5Z9WMUJMMnFaOgG
 b5IhnBVCjmWMn26NDgN6y93YUgLFRqiU9pLPYw0+qrMeGS2/H0IYlrUB+teBQvYF5C6IwFx3X
 joSXaBTL2dOh6NHSdaup1Q5w9AWlgYAPuOwSIQYtTVDLFJ/MOp6+GMrcJenxIAWcEzkN2aZl4
 4d6YEG6fHimBilxTLu4akDUbIADnafMJxFAQGeG1KtD6tnrS0FseRIeu+DMIvVdGRwzCcYm86
 D7IuoUztoDvV/Z4MB3SgX9GpmSBLhJ0AMUptfi/TG0lrG1UycFXieDHEPuTChkLtOc4pviQCJ
 /e00Yx2JNQqXACpknOrkdPKq85gE5MYFfQL1bmYIRysG+ca2hoejbx6gS5c1ykzIL8UOdmYuD
 urU6n0H+SOXzCmXO0CsG/tOKSIU3xYImiZ8hK7hS/1dJfb9a5OwC4Q/faHRCvquSr6UohV8hS
 hZqOm5OOBIpRu1jsd4v38vBYYgTt+pkcauiSekG2ji5Kelv8usim6N23cbTxJN3h73mtvI61e
 oDPtyrBdK+kwL6CNWTXIDCmWTvVJ98UFMg2pUloqdxT9fWxCNknWiqIsXRi1EPodN+FBIzK8F
 AXC/kjB92NLpDb13Egs+JMSfynAOa0xpdDrjHl09eOrooGsWs5qOMw5O32F/uDMMV7E0wXqsv
 wway0tTkcaO0eTVjOLg5uQmgUAqlQQweq9rnhVYllvtZAPRUJt++yeSS/3p32ORKnqKxp3vVc
 a4xcrYCbj+g5tnHEC0Y/WRob5mQTBYlBNS5nfPY+YkLWMrKAH7d1lK3to1nJf0rlRg7UFJyEA
 BJHNVa8gdTDcPc3SEM40JbNK8ch5+uLqLAEKQ9ifydBdPXoQ41ewn2AmYbTFsZu6MJkSlwj6T
 BzIEN/9nmp4a5aP1bSm/1kwIcd9hvmmMXFrzJUb3qz9sr0C5rKaDmugFWNsR2gF+BIHeGjwpS
 0trSEIjbuywh6yOLSFlAwCI4a2w+k/FW6q8ZjbVVt5lw7YfBeYKdKV1WBoSU+8MsRcPLefgY/
 3ow8Z27JPgIk/5git3N1/ALWi430=
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

On 11.03.25 17:47, Adriano Cordova wrote:
> Two efi_net_obj's could share the same efi_simple_network_protocol inter=
face.
> For example, say a working U-Boot net device is registered in the EFI
> subsystem, this will create an instance of an efi simple network protoco=
l.
> Then another handle, say handle A, could be created using this same efi =
simple
> network protocol interface, and connect controller could be called. A U-=
Boot
> udevice would be created for handle A and it would be registered in the =
EFI
> subsystem as an efi_net_obj with the same simple network protocol interf=
ace as
> the efi_net_obj we started with.

Why do you think it would be problematic if some new udevice is created
which via efi_net_driver could call into the driver of the physical udevic=
e?

What we should avoid is having multiple handles pointing to the same
udevice.

>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_loader/efi_net.c | 51 +++++++++++++++++++++++++---------------
>   1 file changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 5a00e7a570c..3ad51d343da 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -110,6 +110,7 @@ struct efi_net_obj {
>   	struct efi_event *wait_for_packet;
>   	struct efi_event *network_timer_event;
>   	int efi_seq_num;
> +	bool snp_owner;

Building the documentation fails because a description for the new
element snp_owner is missing.

Best regards

Heinrich

>   };
>
>   static int curr_efi_net_obj;
> @@ -134,15 +135,17 @@ static bool efi_netobj_is_active(struct efi_net_ob=
j *netobj)
>    *
>    *
>    * @snp:	pointer to the simple network protocol
> + * @bool:	snp owner
>    * Return:	pointer to efi_net_obj, NULL on error
>    */
> -static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_networ=
k *snp)
> +static struct efi_net_obj *efi_netobj_from_snp(struct efi_simple_networ=
k *snp,
> +					       bool snp_owner)
>   {
>   	int i;
>
>   	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> -		if (net_objs[i] && net_objs[i]->net =3D=3D snp) {
> -			// Do not register duplicate devices
> +		if (net_objs[i] && net_objs[i]->net =3D=3D snp &&
> +		    (!snp_owner || net_objs[i]->snp_owner)) {
>   			return net_objs[i];
>   		}
>   	}
> @@ -171,7 +174,7 @@ static efi_status_t EFIAPI efi_net_start(struct efi_=
simple_network *this)
>   		goto out;
>   	}
>
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>
>   	if (this->mode->state !=3D EFI_NETWORK_STOPPED) {
>   		ret =3D EFI_ALREADY_STARTED;
> @@ -207,7 +210,7 @@ static efi_status_t EFIAPI efi_net_stop(struct efi_s=
imple_network *this)
>   		goto out;
>   	}
>
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>
>   	if (this->mode->state =3D=3D EFI_NETWORK_STOPPED) {
>   		ret =3D EFI_NOT_STARTED;
> @@ -250,7 +253,7 @@ static efi_status_t EFIAPI efi_net_initialize(struct=
 efi_simple_network *this,
>   		r =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_INITIALIZED:
> @@ -347,7 +350,7 @@ static efi_status_t EFIAPI efi_net_shutdown(struct e=
fi_simple_network *this)
>   		ret =3D EFI_INVALID_PARAMETER;
>   		goto out;
>   	}
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_INITIALIZED:
> @@ -553,7 +556,7 @@ static efi_status_t EFIAPI efi_net_get_status(struct=
 efi_simple_network *this,
>   		goto out;
>   	}
>
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_STOPPED:
> @@ -614,7 +617,7 @@ static efi_status_t EFIAPI efi_net_transmit
>   		goto out;
>   	}
>
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>
>   	/* We do not support jumbo packets */
>   	if (buffer_size > PKTSIZE_ALIGN) {
> @@ -712,7 +715,7 @@ static efi_status_t EFIAPI efi_net_receive
>   		goto out;
>   	}
>
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>
>   	switch (this->mode->state) {
>   	case EFI_NETWORK_STOPPED:
> @@ -870,7 +873,7 @@ static void EFIAPI efi_network_timer_notify(struct e=
fi_event *event,
>   	if (!this || this->mode->state !=3D EFI_NETWORK_INITIALIZED)
>   		goto out;
>
> -	nt =3D efi_netobj_from_snp(this);
> +	nt =3D efi_netobj_from_snp(this, true);
>   	curr_efi_net_obj =3D nt->efi_seq_num;
>
>   	// The following only happens if the net obj was removed but the even=
t
> @@ -1205,7 +1208,7 @@ static int efi_netobj_init(struct efi_net_obj *net=
obj)
>
>   	dev =3D netobj->dev;
>
> -	if (efi_netobj_is_active(netobj))
> +	if (efi_netobj_is_active(netobj) || !netobj->snp_owner)
>   		goto set_timers;
>
>   	if (!netobj->net_mode)
> @@ -1417,6 +1420,7 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t =
handle,
>   			free(netobj->net->mode);
>   		free(netobj->net);
>   	}
> +	netobj->net =3D NULL;
>
>   	if (handle) {
>   		netobj->handle =3D handle;
> @@ -1429,6 +1433,8 @@ struct efi_net_obj *efi_netobj_alloc(efi_handle_t =
handle,
>   		}
>   	}
>
> +	netobj->snp_owner =3D efi_netobj_from_snp(net, true) ? false : true;
> +
>   	if (net) {
>   		netobj->net =3D net;
>   		netobj->net_mode =3D net->mode;
> @@ -1556,14 +1562,9 @@ int efi_net_unregister(void *ctx, struct event *e=
vent)
>   		return -1;
>   	}
>
> +	interface =3D NULL;
>   	if (drv !=3D dev->driver) {
>   		ret =3D EFI_CALL(efi_disconnect_controller(netobj->handle, NULL, NUL=
L));
> -		if (ret !=3D EFI_SUCCESS)
> -			return -1;
> -		ret =3D EFI_CALL(efi_close_event(netobj->wait_for_packet));
> -		if (ret !=3D EFI_SUCCESS)
> -			return -1;
> -		ret =3D EFI_CALL(efi_close_event(netobj->network_timer_event));
>   		if (ret !=3D EFI_SUCCESS)
>   			return -1;
>
> @@ -1581,6 +1582,15 @@ int efi_net_unregister(void *ctx, struct event *e=
vent)
>   		}
>   	}
>
> +	if (netobj->snp_owner) {
> +		ret =3D EFI_CALL(efi_close_event(netobj->wait_for_packet));
> +		if (ret !=3D EFI_SUCCESS)
> +			return -1;
> +		ret =3D EFI_CALL(efi_close_event(netobj->network_timer_event));
> +		if (ret !=3D EFI_SUCCESS)
> +			return -1;
> +	}
> +
>   #if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
>   	if (netobj->ip4_config2) {
>   		r =3D efi_ipconfig_unregister(netobj->handle, netobj->ip4_config2);
> @@ -1603,8 +1613,11 @@ int efi_net_unregister(void *ctx, struct event *e=
vent)
>   		ret =3D efi_delete_handle(netobj->handle);
>   		if (ret !=3D EFI_SUCCESS)
>   			return -1;
> +	}
> +
> +	efi_free_pool(interface);
>
> -		efi_free_pool(interface);
> +	if (netobj->snp_owner) {
>   		if (netobj->net)
>   			free(netobj->net);
>   		if (netobj->net_mode)

