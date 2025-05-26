Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD1DC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 08:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEB582CF8;
	Mon, 26 May 2025 10:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="c56W1p94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E8182D18; Mon, 26 May 2025 10:58:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD44A82C57
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 10:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748249892; x=1748854692; i=xypron.glpk@gmx.de;
 bh=v9AqocG9FncxGvesmCwxxREx/S2XtYs6K3S4vS4hY2A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=c56W1p94UJFQC+MAxc5+cleXxdb8asX2U8XX+P3iT497bk7SYdT2kAVGmsAw7sVk
 ZPcakLEjDqwigdByZLTb9bms4FAVLx3kYQtLttQBZXJJIwuSF0OfS6cTNnm5aVc+5
 0VWtYqgKQQlPAxgH5D7lraOgsDuh/u/NSXXinvh1DT/AuWOQ8+kt7UoJyH+GsHQuo
 Gsk0mdxBDcE5O5MlSYW3tkGZM6vvQZ0jnY6xvftJBdrgFaz9nLe4WXL2gQGxNVWmz
 tezS9BloKrarMx30DRfskxxqsaXOkIlYc4FxXUgIsty1Zf7fhMoKlMJ3KHYohFUXa
 XC/OIU5asIwlDds9kQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1uPqGJ1WbH-00WAOZ; Mon, 26
 May 2025 10:58:12 +0200
Message-ID: <7d1326b4-12fa-4fbd-a1cd-d54883c5250d@gmx.de>
Date: Mon, 26 May 2025 10:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] efi_loader/net: Rename efi_ipconfig.c to
 efi_ip4_config2.c
To: Adriano Cordova <adrianox@gmail.com>
Cc: ilias.apalodimas@linaro.org, sjg@chromium.org, trini@konsulko.com,
 jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
 <20250516081839.28587-4-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250516081839.28587-4-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EeP+twgv/zkNC5xBBs7bSnNXjXworcrx3SXj14rS4B7LASOcVOB
 AOPAscFSPRuecTanjt+aJGOrjn+GtZLyezE0BCt2P3EpoV1daHaB0mkO1sXv29HrKii4FAv
 003Qzf4AT/9C2hTzSdbluvhliMIsPcNdoIvrSS2dL5G+9/9zrNBmRRBuUy+VWC5aaozk7rt
 GF6RJ82x/Ea1FRv3hLNYQ==
UI-OutboundReport: notjunk:1;M01:P0:OqBOvoN3am4=;o5wiWq/h/y/eA2BzfST/ZK4YYBt
 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
 UFAzlOIEQoInA=
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

On 16.05.25 10:18, Adriano Cordova wrote:
> Rename to keep it consistent with the actial EFI protocol name

Nits: %s/actial/actual/

Otherwise

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>=20
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>   lib/efi_loader/net/Makefile                              | 2 +-
>   lib/efi_loader/net/{efi_ipconfig.c =3D> efi_ip4_config2.c} | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename lib/efi_loader/net/{efi_ipconfig.c =3D> efi_ip4_config2.c} (100=
%)
>=20
> diff --git a/lib/efi_loader/net/Makefile b/lib/efi_loader/net/Makefile
> index ab41f358de9..75131877e30 100644
> --- a/lib/efi_loader/net/Makefile
> +++ b/lib/efi_loader/net/Makefile
> @@ -1,3 +1,3 @@
>   obj-y +=3D efi_net.o
> -obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) +=3D efi_ipconfig.o
> +obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) +=3D efi_ip4_config2.o
>   obj-$(CONFIG_EFI_HTTP_PROTOCOL) +=3D efi_http.o
> \ No newline at end of file
> diff --git a/lib/efi_loader/net/efi_ipconfig.c b/lib/efi_loader/net/efi_=
ip4_config2.c
> similarity index 100%
> rename from lib/efi_loader/net/efi_ipconfig.c
> rename to lib/efi_loader/net/efi_ip4_config2.c

