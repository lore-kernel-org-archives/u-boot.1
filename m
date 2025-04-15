Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C919C369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 08:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1552881F7E;
	Tue, 15 Apr 2025 10:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="r7nU6f2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B3882047; Tue, 15 Apr 2025 10:19:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1580E81F6B
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744705142; x=1745309942; i=xypron.glpk@gmx.de;
 bh=Uak7Vtl42wV9BWVj1f1ZvdvIY157KOMUpG0DaJk6VgM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=r7nU6f2PqIayxNX4u8hsyRn+2PjSeNGVkD7E6bItnDEFD92iiU9FI3k0GIONbayK
 cKFGzci8JKZzeKLrXhaY0r8/gYCXKzfuh9NDG67Z67obid5Qiy92wKBws2/WHUolX
 rEFOA4nU9D2/A674Dfg0D7MVoW59SqGmrjwO1PorBlTxaHSPG7vm9lTbd/20kPJSq
 BnaccTd4R0Btnow+/Fri9/BjNmXuzXfg1VGbfC0l9H7PRZNOwrE/wSuZ4gRs7SIWE
 jrg97nCFrcIWHU3jdTWS/eEGrQyJnX/vHH2oXyZM6kn+mZREe+PHy34vSKXXa6o6p
 ENT58yWB7GfNxboR4g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1tceUC1CPm-00UL35; Tue, 15
 Apr 2025 10:19:02 +0200
Message-ID: <b9395b36-16d8-4089-b0fb-85982d9c0564@gmx.de>
Date: Tue, 15 Apr 2025 10:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] efi_net: efi_loader: Add efi_netobj_alloc to
 allocate an efi_net_obj
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 =trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
 <20250311164758.421900-6-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250311164758.421900-6-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SBoenpHUL+0HNZZoFByCCXKB+iRNHQjkMPV1SjXHqOZKqSgkQjt
 8LMjy9LhqKPjsag0eZ3xGbWBPtlFy70C2ANqzyjd8KsmDwzYbw0TruXJUHy8ZgwWSuhtgiX
 xZa8Wi6g7FYC7W88Oy2KSBDOU5FVDJEjLCI73LimpTmNSR8RJiYDYRcBUapFhAVuLIt+5Yy
 S+VUkjqL2Zw0g2B1yGQ1w==
UI-OutboundReport: notjunk:1;M01:P0:yubY8nsABM0=;glB6sGv4Zb0emIRcAC8OUC18Sdv
 E8dPR1sLyIMzfY5x6wSYZ1wP7Sz4vCpx7NO1Sr5uz+kB/bdsnTWnkldNeHa+TtMKLRxgo35Gd
 YDpaGjkTPVFhvh2MDvM3YnNry4TISzN+awFif6GHsU3Aeh/zQUHywuqkQ6FAEuLnmGfD1Mcph
 /X7nmYi0wSC3zVRhyAjpX6HJI6XU/a8PVYpPk8h9R68oHioAH6svA0Dd5EAK6DXOqUaM3raXM
 kzIDQR2/J2nUDrBeqnHzE5R33oDjH2//9b12dMTCyeW3COJ6FG/4IZIcH2x/RuhbxeehHFDUo
 cdjRMmGDRFe+C6E7TS2ZJpDKuxlCLpAx3Uygx52SyG9u5IY857jXadaYadCWO+/OL8pxtqTrN
 etf0Nw/0Vmh4u3HqbEoF7cCFUpBj0G/ToFoxEgthyEWeUdcNs5QwEH7LVy4jXksKjrCnmXhzV
 1SrzPU3sswCZI6aiQV2kpEhvPU3No0dwBFAdCPmZjkq2M/A5eb2jS6mnBOOZL75IO07RrQCB3
 md0l+yto+EsZ7hE6k9xv60WILfFk4QPKAD6bptpjXr1r6hH3pIwfiqZfznQdxZ8P1+/kyYOH2
 ejjCPP/3SjGXfeoeR3Q0J3oveKoUMn2RLkqaIvD+LdpKvjIQZyp0Cf8++U07O96bH/2kKjwA6
 CVsr+RQxBBsxwxw1lkcysFZuUY7JgzuiYYcFvmS9exgm9kzuZbI/sU5iiZtzrCxgQSNFcfJSS
 Etz3QyOd7bWYzIWuUTHfGtl5CpGjU6DIvGsBma/LGGxYNnUi0aCHO16zdLTj2mBrj7Oimpbqp
 m5VYJ6ndM/GzR3f0zYUsGvaTpmJ7tgY9QDtAPDnUiAtiLX+5slWfCpIIEIps+x7xl8f0SKaD5
 ZOWdbDq9Y5u/BCngGd+QFP4SeC5wE9Vset2EORF9Mr/CfB6o6LXdfyo6TuStexFmBjD8/3iFT
 IWRDCA0dLyVSUodAhJdPl1wBFORrTCN7cVYUpjBsplpoj7bqk0M5Sk8yLO/rq0s4HqSG7iIFK
 M+Lf9ffAmaHxDqoyUOCjvz+H2mjMlC81DYX75D75Md/gt9oXLAlonsHQwK9myJQPQJUbxVR9r
 4B4SLJyKpcVnaGOs9p7zE4iqLYq9h0IW6hopU7eXQjPq/OxJio3+JX/j3RhwPPmKLQhF+38hS
 xDk6nI2qSi4VsM1PALFEZetvQ2PuDsHtzmVbNRRBSgg0L1hmb2YRY8jv8M+GPa5zcCFfRbMgK
 KPoTybMXHkfwy58TmJLUcE5KNVH/RCtrrGIMPXhU+k8tgTQFA/UM4GNUWn8BNz32gI1GlxWVo
 SBXWtYd1PpWvKVwKmUa55OTU5QrV4ec7LOCdWvNHYK2TE/XGsHjAOmlO0hwi5Xpnm/3zAC0Ee
 XgGJCT5CWR9edLyeoo5LqV5BQ9dw7x6EDUbTcW9UvVqMj++mIHrx9m41NRtAH8Ou7e27Tbhto
 Nr+XBJSnqvXDQTuKzgxhbqx55gPI=
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
> Rework the logic to allocate an efi_net_obj and its members. An
> efi_net_obj now gets allocated only in efi_netobj_alloc.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_loader/efi_net.c | 131 ++++++++++++++++++++++++---------------
>   1 file changed, 80 insertions(+), 51 deletions(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index a40d319a27f..a14ecf3d182 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -1152,19 +1152,10 @@ static int efi_netobj_init(struct efi_net_obj *n=
etobj)
>   	size_t *receive_lengths =3D NULL;
>   	int i, j;
>
> -	if (!netobj || efi_netobj_is_active(netobj))
> +	if (!netobj || !netobj->net || efi_netobj_is_active(netobj))
>   		return 0;
>
>   	dev =3D netobj->dev;
> -	if (!dev) {
> -		/* No network device active, don't expose any */
> -		return 0;
> -	}
> -
> -	if (!netobj->net)
> -		netobj->net =3D calloc(1, sizeof(*netobj->net));
> -	if (!netobj->net)
> -		goto out_of_resources;
>
>   	if (!netobj->net_mode)
>   		netobj->net_mode =3D calloc(1, sizeof(*netobj->net_mode));
> @@ -1344,6 +1335,84 @@ efi_status_t efi_net_init(void)
>   	return EFI_SUCCESS;
>   }
>
> +/**
> + * efi_netobj_alloc() - allocate an efi_net_obj from either a simple
> + *			network protocol interface or a net udevice
> + *
> + * @handle:	EFI handle
> + * @net:	pointer to simple network protocol
> + * @dev:	pointer to net udevice
> + * Return:	pointer to EFI net object, NULL on error
> + */
> +struct efi_net_obj *efi_netobj_alloc(efi_handle_t handle,
> +					struct efi_simple_network *net,
> +					struct udevice *dev)
> +{
> +	int i;
> +	struct efi_net_obj *netobj;
> +
> +	// Find a slot for this efi_net_obj
> +
> +	// Try to recycle
> +	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {

We should avoid artificial limitations like MAX_EFI_NET_OBJS.

Objects that exist once per handle should be linked to the handle by
installing a protocol interface.

> +		if (net_objs[i] && !net_objs[i]->net && !net_objs[i]->dev && !net_obj=
s[i]->handle)
> +			break;
> +	}
> +	if (i =3D=3D MAX_EFI_NET_OBJS) {
> +		for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> +			if (!net_objs[i])
> +				break;
> +		}
> +	}
> +	if (i =3D=3D MAX_EFI_NET_OBJS)
> +		return NULL;
> +
> +	if (!net_objs[i]) {
> +		netobj =3D calloc(1, sizeof(*netobj));
> +		net_objs[i] =3D netobj;
> +	} else {
> +		netobj =3D net_objs[i];
> +	}
> +	if (!netobj)
> +		return NULL;
> +
> +	if (netobj->net) {
> +		if (netobj->net->mode)
> +			free(netobj->net->mode);
> +		free(netobj->net);
> +	}
> +
> +	if (handle) {
> +		netobj->handle =3D handle;
> +	}
> +	else {
> +		netobj->handle =3D calloc(1, sizeof(*netobj->handle));

All handles in U-Boot have to be in a linked list, see
LIST_HEAD(efi_obj_list) in lib/efi_loader/efi_boottime.c.

The only way to create an EFI handle is by installing a protocol
interface calling InstallMultipleProtocolInterfaces(*handle) or
InstallProtocolInterface(*handle) with handle =3D NULL.


> +		if (!netobj->handle) {
> +			free(netobj);
> +			return NULL;
> +		}
> +	}
> +
> +	if (net) {
> +		netobj->net =3D net;
> +		netobj->net_mode =3D net->mode;
> +	} else {
> +		netobj->net =3D calloc(1, sizeof(*netobj->net));
> +		if (!netobj->net) {
> +			free(netobj->handle);

EFI handles can only be deleted by uninstalling all protocol interfaces.

> +			free(netobj);
> +			return NULL;
> +		}
> +	}
> +
> +	netobj->dev =3D dev;
> +	netobj->efi_seq_num =3D i;
> +
> +	printf("\nefi_net: allocated EFI net device %d\n", netobj->efi_seq_num=
);

This printf could be useful for debugging but it is disrupting the
output of network devices and nothing that an end user would be
interested in.

efi_net: allocated EFI net device 0
eth0: eth@10002000
efi_net: allocated EFI net device 1
, eth5: eth@10003000
efi_net: allocated EFI net device 2
, eth3: sbe5
efi_net: allocated EFI net device 3
, eth6: eth@10004000
efi_net: allocated EFI net device 4
, eth8: phy-test-eth
efi_net: allocated EFI net device 5
, eth4: dsa-test-eth
efi_net: allocated EFI net device 6
, eth2: lan0
efi_net: allocated EFI net device 7
, eth7: lan1

How about:

log_debug("efinet %d\n", netobj->efi_seq_num);

Best regards

Heinrich

> +
> +	return netobj;
> +}
> +
>   /**
>    * efi_net_register() - register a net device
>    *
> @@ -1356,9 +1425,7 @@ efi_status_t efi_net_init(void)
>   int efi_net_register(void *ctx, struct event *event)
>   {
>   	struct udevice *dev;
> -	int seq_num;
>   	enum uclass_id id;
> -	struct efi_net_obj *netobj;
>   	int i;
>
>   	dev =3D event->data.dm.dev;
> @@ -1378,48 +1445,10 @@ int efi_net_register(void *ctx, struct event *ev=
ent)
>   		}
>   	}
>
> -	// Find a slot for this efi_net_obj
> -	seq_num =3D -1;
> -	// Try to recycle
> -	for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> -		if (net_objs[i] && !net_objs[i]->dev) {
> -			seq_num =3D i;
> -			break;
> -		}
> -	}
> -	if (seq_num < 0) {
> -		for (i =3D 0; i < MAX_EFI_NET_OBJS; i++) {
> -			if (!net_objs[i]) {
> -				seq_num =3D i;
> -				break;
> -			}
> -		}
> -	}
> -	if (seq_num < 0)
> +	if (!efi_netobj_alloc(NULL, NULL, dev))
>   		return -1;
>
> -	if (!net_objs[seq_num]) {
> -		netobj =3D calloc(1, sizeof(*netobj));
> -		net_objs[seq_num] =3D netobj;
> -	} else {
> -		netobj =3D net_objs[seq_num];
> -	}
> -	if (!netobj)
> -		goto out_of_resources;
> -
> -	netobj->handle =3D calloc(1, sizeof(*netobj->handle));
> -	if (!netobj->handle) {
> -		free(netobj);
> -		goto out_of_resources;
> -	}
> -
> -	netobj->dev =3D dev;
> -	netobj->efi_seq_num =3D seq_num;
> -	printf("efi_net registered device number %d\n", netobj->efi_seq_num);
>   	return 0;
> -out_of_resources:
> -	printf("ERROR: Out of memory\n");
> -	return -1;
>   }
>
>   /**

