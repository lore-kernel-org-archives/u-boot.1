Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7D6C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A410A801DE;
	Thu, 20 Feb 2025 08:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mf8O+lyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B6B80A46; Thu, 20 Feb 2025 08:54:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECEF801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740038087; x=1740642887; i=xypron.glpk@gmx.de;
 bh=0VbvcFQ1eQ/5S6Xj6i1yYyV+nd5wzXkpIiQe9vdUFGU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mf8O+lyN5wpPE6FeE4OQVqZIusoLbVvpkRnyGnch+Wl7KsUSUD60AYEBWV3/8AXl
 5MwEcLqgjrsjl5W2jhoeYSavIx3uaIpP8LqU43jeQY27XL78UQiQnMwqgvUTKQ7kl
 p4m4jjW6getSiZRj+IoV5PYDRef8pN7ASBDvxTIo63GQDBNxk5jNjKjrhMYJhDIsR
 4xPz77BHtuoNr8Una25TIQN+x4HmIGQHW3/+OzuV2qpDI5J1LWvLi/ivDQiK2Htm3
 uHmi1FuaodhWBhpVOmghMqZM8PWxKbA4bsRDW/jriQ0mRBTq8Kh5rjNQmlWkL6vUR
 umx6c/J/OAwKhDRSZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wyy-1tfV5P2Nz2-00A5Nx; Thu, 20
 Feb 2025 08:54:47 +0100
Message-ID: <2185e2ad-e9cf-4ea7-ad59-c5446efaf733@gmx.de>
Date: Thu, 20 Feb 2025 08:54:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250127123445.1040480-1-adriano.cordova@canonical.com>
 <20250127123445.1040480-2-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250127123445.1040480-2-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/qp9A1HkxIZ455QKp5HWrx3HNbNb77pa1w75iMOkgg+ZL/ujI2B
 gjXX6WDaC/+zUcOrlmyiSLYvJrzXX0jfUDXsDExJh+4ZR+7kJZlX3g+ctfFOC4SxjK6yAeN
 LUndYJ8fCymJWjAMaegLDHDxQOZeMbiNIEhckFQhb9slgZ2iIQs+kzCynk3gJv/6pygSUvg
 ovKU3bCqbo+WrzS8IgTxQ==
UI-OutboundReport: notjunk:1;M01:P0:SPEph+ahSqQ=;klOigpBLRPirB6W9OOlYvSyuhxD
 dzPszMSCrA+k8xZBsP6gEEi32trEkI/JYlv6yfT9XsD+iawfV+REfb3Er2yE8IVwppuEdvq6V
 ZvfwIVNYT8obKvV8+1E3icXMco+pj0sEcsjLap0KgizMOjVSs9+ACj99TZjFEeQ63UmaIFNps
 eLixrlTh6VvK7KRP5+UALIbzniw+hGpHtlwhtJEzPfJJJFPGy3qNREUIqF455SsQavyI79Yk/
 IB0qdeeRGsjeV3isvqyXaZKxRsOY+jKv4x0ibMbfaQkp/w+fJvHAMd9Or1nELuTgk2atgTXyK
 cNrdnGpYEc0Vv5FQ+XuqHeygoqLBs6qJUbQIoHceUYeYIVTg/rHoZNdBGlTWLXS49Zsy9lyN9
 +RmWWl1RQCTQ5h5RLR1o5IDiB2hGjHnAyYSdn84DhyLWG14+Oh2r5eByuSE/HGRKZ3hyPkROY
 KWYWaBEywA6KEN4C+uczxeiERCyTmWfq3igejmhc1YOjlmauYT7j+8emYdwTbdj6Vr63junLH
 FPtF0JqdhwOBo3s9chlC6uyFB+xfwLV2gUhHrha+L983VpQ8+isNhbUAdR5049XJBD1Hx+OgX
 9RAIg3clcBdbmNnvsU8fkec80nnphHoJYIGE96xxP43wyBV+aGRNUDYshujgio92mUnrgljde
 PS1B9etfsV8ut339C2X3i1bJolOlaBSL5tmgTQeJlW0SH0d3IbHY3SjqcteWq372J+6FXzPjm
 PaV9D8JmqxGf6UB65OyhQXYcMNybXFmeOwppX0A/Z8ZGDvR3yC7aZp8oeX7kz7+FjiXbubgJh
 VRZGpq1ztHO4+TnMeKFvs3eIJTLSFDPwmM3tjKxGCd8YeaVfkUJnZRbzc4GIHyMxTVsnwH8pE
 VOcpCSR/7z+xEJjgG9/fPtLjCdZBGjuMPCrXB/Lnj+ArTIzNzW8pyTftgkAhxl3rSJSjBVxjv
 q3yxHo+meO2Qmw04X92YdvV+RRg9sG54ZKfksrDaM9eIZM6WK8x7acNPuCr5WZWvsxotbKOvU
 YEYFNTkeEHeHxZ4oaF2ETJD9k26EI8jApLKbSYopgoVrRJYKORG+dIojHvs7kGN+H7nVAQxm+
 jEAJQKFCVDl9P3M+XWrdUw71sl3NpCyT9mWx20QgQmsVBA0E+jz8f+w+nWqcAGl0H/UB3FK3d
 sDAhDOOQv0wVjGblpGuhkjlM1l+b9DWo8gdyPFB1eHrcgzqMZPQL38hGAr62XfzDs6vEKHlV/
 xiYDw0QH4ycCF2Jl4/OfWscZ3L2ZWg5hFdkFnIH4mhnldjT5gJ+TCh7yXNOU31/TLi0MQsFFd
 A+3rkRrWBZFmVN7PKjPBTs34tIpRg13KMkKViJkUJXBX1K5RcwH/0PmBOyqsNa43Q1Fm3yGhe
 3hiNwG3FV00zl4N/TzGHFHlwv4eaM8KaW+GAJdpDXy0SLAzpAV7mfu7M1y
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

On 1/27/25 13:34, Adriano Cordova wrote:
> This commit fixes an use after free introduced in Commit e55a4acb54
> (" efi_loader: net: set EFI bootdevice device path to HTTP when loaded
> from wget"). The logic in efi_net_set_dp is reworked so that when the
> function is invoked it not only changes the value of the static variable
> net_dp (this is how the function was implemented in e55a4acb54) but also
> updates the protocol interface of the device path protocol in case efi
> has started.
>
> Fixes: e55a4acb54e8 ("efi_loader: net: set EFI bootdevice device path to=
 HTTP when loaded from wget")
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
> Changes in v3: initialize ret variable in efi_net_set_dp
> Changes in v2: use reinstall_protocol_interface() and new_net_dp in the =
body of efi_net_set_dp()
>
>   lib/efi_loader/efi_net.c | 61 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 67593ef50c0..f696a47060c 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -925,12 +925,15 @@ efi_status_t efi_net_register(void)
>   			     &netobj->net);
>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
> -	if (!net_dp)
> -		efi_net_set_dp("Net", NULL);
> -	r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> -			     net_dp);
> +
> +	if (net_dp)
> +		r =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> +			       net_dp);
> +	else
> +		r =3D efi_net_set_dp("Net", NULL);

Hello Adriano,

thanks for spotting and fixing the issue.

Patch 1 of the series is already merged.

Why would we create a device-path here and not install it?

If this is really intended, please, add a comment.

>   	if (r !=3D EFI_SUCCESS)
>   		goto failure_to_add_protocol;
> +
>   	r =3D efi_add_protocol(&netobj->header, &efi_pxe_base_code_protocol_g=
uid,
>   			     &netobj->pxe);
>   	if (r !=3D EFI_SUCCESS)
> @@ -1055,18 +1058,58 @@ out_of_resources:
>    */
>   efi_status_t efi_net_set_dp(const char *dev, const char *server)
>   {
> -	efi_free_pool(net_dp);
> +	efi_status_t ret =3D EFI_SUCCESS;
> +	struct efi_handler *phandler;
> +	struct efi_device_path *old_net_dp, *new_net_dp;
>
> -	net_dp =3D NULL;
> +	old_net_dp =3D net_dp;
> +	new_net_dp =3D NULL;
>   	if (!strcmp(dev, "Net"))
> -		net_dp =3D efi_dp_from_eth();
> +		new_net_dp =3D efi_dp_from_eth();
>   	else if (!strcmp(dev, "Http"))
> -		net_dp =3D efi_dp_from_http(server);
> +		new_net_dp =3D efi_dp_from_http(server);
>
> -	if (!net_dp)
> +	if (!new_net_dp) {
>   		return EFI_OUT_OF_RESOURCES;
> +	}
> +
> +	// If netobj is not started yet, end here.
> +	if (!netobj) {
> +		goto exit;
> +	}
> +
> +	phandler =3D NULL;
> +	efi_search_protocol(&netobj->header, &efi_guid_device_path, &phandler)=
;
> +
> +	// If the device path protocol is not yet installed, install it
> +	if (!phandler)
> +		goto add;
> +
> +	// If it is already installed, try to update it
> +	ret =3D efi_reinstall_protocol_interface(&netobj->header, &efi_guid_de=
vice_path,
> +					       old_net_dp, new_net_dp);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto error;
> +
> +	net_dp =3D new_net_dp;
> +	efi_free_pool(old_net_dp);

How can we be sure that old_net_dp is a device-tree that we installed
and was not installed by an EFI application?

Best regards

Heinrich

>
>   	return EFI_SUCCESS;
> +add:
> +	ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> +			       new_net_dp);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto error;
> +exit:
> +	net_dp =3D new_net_dp;
> +	efi_free_pool(old_net_dp);
> +
> +	return ret;
> +error:
> +	// Failed, restore
> +	efi_free_pool(new_net_dp);
> +
> +	return ret;
>   }
>
>   /**

