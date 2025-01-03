Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109C8E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 23:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA1280295;
	Sat,  4 Jan 2025 00:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DW7jM6m+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38700802EF; Sat,  4 Jan 2025 00:05:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94829801F5
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 00:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735945526; x=1736550326; i=xypron.glpk@gmx.de;
 bh=Id/Yfy4D/3bQdupCSEc3B3OZo5RrmIomO0CGSuzOGQc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DW7jM6m+jy3S4yMheHe9HV7b6cpDNDyNWyRWoGuW+bZoTSXGAhInw6k2wyRlXOQk
 ipTsjnJpRMf/IFU2wHdMiwr+7lltNew9ART6tcZ8jPU8c9mXGA+liIHBkqAheHcEh
 EuwxemoD8cEa+SIz2tgm8ldT3Os+O6srghQ3a/fBOb2xj/Rslfoua580MAZi6yd+A
 w0frBd1rdxPmMWmkG/3wTPBBUL+Si6oFOL4zRHf8IEETdwAT7pM30dI7ZjFsF1KnV
 KDBMpkdSMUDttSSSvYjKPhUPP4FPc5CFHaVG6YTZim2H47aX+c/M8/3XB8XGdgTo+
 bUvmk3vp5FEOvRD90Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7iCW-1tYqyi2msk-00qvbN; Sat, 04
 Jan 2025 00:05:26 +0100
Message-ID: <1839b1f7-b78c-450a-aa05-78858a4f2d45@gmx.de>
Date: Sat, 4 Jan 2025 00:05:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] efi_loader: efi_net: let efi_net_set_dp properly
 update the device path
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20241206171835.2403418-1-adriano.cordova@canonical.com>
 <20241206171835.2403418-3-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206171835.2403418-3-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1fzENfRBXYE5Aw8omiK+hrZUE+eVy8hCqDc/0xy9gIqcAXkWuYz
 rLechRNhHss5ASwetjVJHh0zzO10awpGmy6tduDaKMZ3PrDeViLOrlP8f861dU+pczYOWbc
 u1nDeJKYC9F9T837eS3yp9QA2pIlOYuxluFIrAoPJziPuxLzlLe5YHCexUC/3WHJpfZdUBE
 7SFrbnC4XvOxx0r32D5QA==
UI-OutboundReport: notjunk:1;M01:P0:pbvYKrh29Xw=;AUZMtze5m6lGTEsLxhZXMZyL/Dp
 OdVj9y9IYKdI8ALIZFhHPEaI0piKBSHlLOrh/2bYII5ndHLDWq4Q7TdDOKoCKgNNP2l+lxBKj
 FSWaIRZFYdZIAewCtCx16r+mSN0nJOuve0BUGqUD9unU9njTjNYzpLhZiXvJoqCGD8dmCahvo
 34u9/zNAgoxoBrrw91W2KEBE0z4tXJ6TXsUjUFgo/7EreNU6NLbAqhgxasd2VPNoEL+vblJqa
 sRDXKoizkTPy8PmLx3l5afNx7TXyI8dQ0p2DFiVYQbJFJ2e/LF1muDD2VB9j9pCblermlpE+N
 FZ7DT6AfRat2zbZL0wNpsVzi28yYlEnB+r6wG1cYBqLXp85EqcjN9oiap8o2HBfPxbgnTSEyY
 WanLeZGcRTPtDJkXo10be25b7N7Vq5ETNBcar/lt+o7MINpansnOCxgZWo1DIdF2hvvRRbc8+
 wGkWLE+d1ADuTDWhdw6Ql23fJMZjsx3rdjQql9b8rtj6NhHKnQc+9V9ke4QQphioNvh3Zczq5
 DoOVoXH6BPcQEg5YOfO8hGQu+Z44V6wH+EVs2BIwGwPEZkZbbo0vqCSzF5xSAbdYoSEXiREdo
 jaHDtiHouAxYOij1B4JsSJLWpdUq+FZNCKsK/QbOLviCJjOm7zTltAosIh2jtARiAPWPZUMVt
 m6IvWPgZr+VTk+99XpuSKJ66/iM5mjgFjMkCgp83UIshmK/YlN5Mdc42O2a5IEDDjg18gR1zx
 03k62Ad/8y37vN8wP38gFeNVq4k3/5CBAI/C69Nd4MiiTP57bQ8qEp+xy0UE8YklHuNgWYVF6
 uL3XS5suIhDgQtnKCkFQQW+H3nmwHWMiLnMHEp5PLcDfqlsAKCVZCMJGmKEu4v1WVCe2wuil1
 KHHcX5u0xBCZ59+4wabh/QodkGVazJkWOuKiXOps4pX0fEeEykanXzKOpF6fH6+jiZQOM1cWP
 AOc3skXjk9OFTEiiUVwxm5w6F5sgSSu8N6A3Hy1OvCo1rC9xcJfTaWgvZtMT+75cDbC+npHPG
 4EZHJ7YvWw5KeCvUozD/dZfR7NPjdxFsMLL+W5T6m0d3sXoch4Kw5NSvulOakW9IifXGGwBL0
 PJl8UhLXdPWTPsg96FRe8NUz21XzP6
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

On 06.12.24 18:18, Adriano Cordova wrote:
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
> Changes in v2: use reinstall_protocol_interface() and new_net_dp in the =
body of efi_net_set_dp()
>
>   lib/efi_loader/efi_net.c | 61 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 52 insertions(+), 9 deletions(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 67593ef50c..ac8e54639b 100644
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
> +	efi_status_t ret;
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

This leads to a build failure with clang as you have not initialized
variable ret.

https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/987832

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
>
>   	return EFI_SUCCESS;
> +add:
> +	ret =3D efi_add_protocol(&netobj->header, &efi_guid_device_path,
> +			       new_net_dp);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto error;
> +exit:
> +	net_dp =3D new_net_dp;

Why should we set net_dp if there is no net_obj?

Instead of jumping to exit, we can jump to error: with

ret =3D EFI_DEVICE_ERROR.

Best regards

Heinrich

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

