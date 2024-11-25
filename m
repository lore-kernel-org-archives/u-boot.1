Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E199CD3B7F3
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E46888DB6;
	Mon, 25 Nov 2024 09:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Imv12e53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA82B899B5; Mon, 25 Nov 2024 09:42:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A04899EC
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732524150; x=1733128950; i=xypron.glpk@gmx.de;
 bh=yztaJBH9FA6MlNApjAVLTJEjzklofmJPSXiP0NMYwxA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Imv12e53ozcjtvj5Ry10AcuOpjdyPAnZV5nKSbAu1LMuCdlvi31nItCXFWuF2M6h
 3fj+g/sl1pYjJmoA6QNCTfC1CjRm+1NH+8OscdwZHXq6P614tXhmio526uY81k3ry
 wQWFAbtDCnw0AX/tu6oVPYYG2rhHRU1FyNriOkV/VkGv0nz0dFnYphhxbp0pMTkGf
 AOGU1EjBgf7nojtGnBey3BylpI83dcqoHaalX9v+tEP02o3MfW0yyIJoScInwmtJX
 cjVLZg41n65PHsZuZPZjnEI1ZzcbSZaW+rXDxC1chVEHI9yynTcIjcSJKVkjVVPZd
 gmqXrHUkgwieHesZrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.30] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wGs-1tGabZ3zwa-00B1lI; Mon, 25
 Nov 2024 09:42:30 +0100
Message-ID: <d65bf941-7fa2-4ec4-82b6-b3ff70af653b@gmx.de>
Date: Mon, 25 Nov 2024 09:42:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241125005814.236669-1-adrianox@gmail.com>
 <20241125005814.236669-4-adrianox@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125005814.236669-4-adrianox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5cITjZJ4guzHxPus1puoD4torrZCaJaEMKJX+Gw7DN9LYfukhml
 ASefEV/WAVM2Mq/30PzpQMiP8Ylfw64uT/S+UakQcgFJnS4pfNKcaBiDlQomoLGFNBUTO95
 EynRM4sOp8QyiFpKHanMWdywQzA4NuXKKFAIuLDCw03/L43b4Pam+e94AEn9GNh5lfKwnYq
 ZL+eoTSYJEql77/VkX2xg==
UI-OutboundReport: notjunk:1;M01:P0:xaQYzBQRai8=;xyriRCDrbJI/BY2hMzz/O9BmN69
 WCQYmGS7+dJHleiCR0n0fRRG0WcVOhJ9RSOFZVdMM2PvtDQdunoEbY5UFHrB0igmjlRfgFEk6
 mtoGRw4DtJPzpt8CXT8EMfC45zys1bq91bG7kusD01lS4Qv4prqpmJ6beP4m21szg5iGrH7gC
 KDdxa+CIvw6e8hXLRbDe/80TbLAa2Udck1UZgM+S1DBr7In5OzQXIGgv/8KHnonfvT1feleov
 EHDSqRvv2NCGgmJkbfcejLsCZNO0/sHJuELnzy37oRjPYDocpRVZf2zJd0Ck6bQvxkFMDMWcq
 aXuGyw/CCknvOjeIG49efHinRf1w+C9C9/U5HdHCXQk2cuulotgKXEZSwNY+KUseSOsthVqtM
 exan2d70W3Gd8Kb6HeCvajYrj3f7heMzqhugG+IH/AVCnuL7QgIBnj/AY9kQ2bozjowWUk0aC
 5m0fLbIWXRCAEsgfciByNUBgaf/Wb/q4EGsul6cJvy5SAk524HTvOYqnfFNP/unK69vT5frj0
 jEotTLX6vhRhMEjlXKEqaUtsXHkH7DZsHaUTkp3Rt7V9uOpNQteADd0mimWGohIuEk5IuTwUM
 kH3XYWvXieUBGv50cFUuDOHtIqdQIygs6OStvAmVUf4WZGqvicW2XC4whu/eYHN5munfW3Rha
 7eUjY1LbKtFgQdiyb06mENerSGpeoV4thtF8n6ejoGtZXClMJueFV87bWgfY61JfEENZJoJC+
 OcYVKES4d42EkMkgHTp2VUXMY0psLL+sK1OMHnEEvR8pR81x5EGk4/O6igrgQUWW2dXQC896G
 UpJSzF5hSI35Xc7xITMBKrqxMmBsQg220Dhpo602X/iTjn76y4dTNI3UpkzUvML+olgdML/Qs
 oaxkLr06wtqSqvsJoo3LkpGpwjX2hiaR4z88IsOI1uM2qQkrl+Tb5vmU+
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

On 11/25/24 01:58, Adriano Cordova wrote:
> Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>
> Changes in v5:
> - Add function description to efi_dp_from_ipv4
> - Allocate ipv4dp in the stack
> - Make efi_dp_from_ipv4 static
> - Remove u-boot log messages inside efi routine
> - Change (void *)(unitptr_t) to char *

Nits:

uintptr_t

>
> Changes in v4:
> - Fix memcpy mistake
>
> Changes in v3:
> - Remove some unnecessary void* casts.
> - Change sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
>    in efi_dp_from_ipv4.
>
>   lib/efi_loader/efi_device_path.c | 43 ++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index ee387e1dfd..96e72f72fc 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -974,6 +974,49 @@ struct efi_device_path __maybe_unused *efi_dp_from_=
eth(void)
>   	return start;
>   }
>
> +/**
> + * efi_dp_from_ipv4() - set device path from IPv4 address
> + *
> + * Set the device path to an ethernet device path as provided by
> + * efi_dp_from_eth() concatenated with a device path of subtype
> + * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
> + *
> + * @ip:		IPv4 local address
> + * @mask:	network mask
> + * @srv:	IPv4 remote/server address

The return value is not described, e.g.

Return:	device-path or NULL in case of an error

> + */
> +static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address=
 *ip,
> +					 struct efi_ipv4_address *mask,
> +					 struct efi_ipv4_address *srv)

Nits:
scripts/checkpatch.pl complains here.
Alignment should match open parenthesis.

> +{
> +	struct efi_device_path *dp1, *dp2, *pos;
> +	struct {
> +		struct efi_device_path_ipv4 ipv4dp;
> +		struct efi_device_path end;
> +	} dp;
> +
> +	memset(&dp.ipv4dp, 0, sizeof(dp.ipv4dp));
> +	dp.ipv4dp.dp.type =3D DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> +	dp.ipv4dp.dp.sub_type =3D DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> +	dp.ipv4dp.dp.length =3D sizeof(dp.ipv4dp);
> +	dp.ipv4dp.protocol =3D 6;
> +	if (ip)
> +		memcpy(&dp.ipv4dp.local_ip_address, ip, sizeof(*ip));
> +	if (mask)
> +		memcpy(&dp.ipv4dp.subnet_mask, mask, sizeof(*mask));
> +	if (srv)
> +		memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
> +	pos =3D &dp.end;
> +	memcpy(pos, &END, sizeof(END));
> +
> +	dp1 =3D efi_dp_from_eth();

If dp1 =3D=3D NULL due to out of memory, shouldn't we return NULL to the c=
aller?

Best regards

Heinrich

> +	dp2 =3D efi_dp_concat(dp1, (const struct efi_device_path *)&dp, 0);
> +
> +	efi_free_pool(dp1);
> +
> +	return dp2;
> +}
> +
>   /* Construct a device-path for memory-mapped image */
>   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>   					uint64_t start_address,

