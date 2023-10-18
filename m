Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D80CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 10:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 269EE86D82;
	Wed, 18 Oct 2023 12:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Hs0Uc6mp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E37B86C87; Wed, 18 Oct 2023 12:20:00 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4962E86F2A
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 12:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697624393; x=1698229193; i=xypron.glpk@gmx.de;
 bh=EJbL4e04X49RbRh0ptyyaeP4HGqzYIKn/PqtNhk271o=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Hs0Uc6mpWtmOQ1KB4HhXUczHrs6SZAGYnd07SqLgvASuquPcRswdJQvYWYX2G/hfy8aMvlqTGtr
 DYjs+KljAyOSWtOchvnyD6tBshlz0LkHk+smdIpuOSYRcwaLJqRt6yaWn89DPYhjxEKsl+mnXn1fL
 vCCrvyxBKDKtrODgITzK9NqHdufWiYeC4mlcA6oEJHcIH09sYadLDemnFrhsNsjctOHtfc9+e/6Kf
 /NpRTHD7eNB0FnVIG9bn3pfFJoRU5p6trapI1/G/z07aXQ2HHtoyAC6QBAofmx6OBpg7yLCQFaIvL
 flzsZ/5U1PdjsnAoxxoKSpZqXP5Xmdqx+tow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1rjVgO0wvB-00rG08; Wed, 18
 Oct 2023 12:19:53 +0200
Message-ID: <13131882-9007-4322-ad4a-5c8b505a5328@gmx.de>
Date: Wed, 18 Oct 2023 12:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] efi_loader: add CDROM short-form device path
Content-Language: en-US, de-DE
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Takahiro Akashi
 <takahiro.akashi@linaro.org>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-7-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231016064526.2410856-7-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A7YUEJKH0Wk1jZDRmewTIqRUB+OY+KF2JUjJ7JegSr/3pW/3P7Z
 50WjYRAH2QwZqqtXamvHsCbnyzVbq0cqOj2q7JpJRO46uLhdL6eMtGaHU21nXG2lgxQ1ZLO
 MAE13BAPDqDr84q03gClJVQ4UhvIsaxCUVDudXAYmGN5gKincvlZGqhRZ7RBeYUx9UGVRDb
 pdMhwghj/tnMpDqVYBZuA==
UI-OutboundReport: notjunk:1;M01:P0:JbMLkL4KhGU=;jSzOGLf6eUXaK9sOudkUcQN0TVO
 diaf9zupxLoimAAHTxpwNKcDBf6ezAd3xUBoKX2JYOi8/RN101Y3jCerx5SBCio6N+2Z5CEEp
 tu+Mai5nuFBRLLphPhuBQB6KwK5fIO1kzO4CTKH93qQw3/+yoI/WGJRhGExI1eYFQPobdOS3L
 6j0L5HpjGlBUCNWkUr5dAsFXmEUhbBTCAzkakaR7+a9ljYIBiyc9t2hkhGD+7/DMUdqnheCX9
 xfmJ8+Y+j3jx7ZqgTJWz/e5cUh/i91Asd2Buwltr6gSkMO2s8s0ty90W1dNuDvJrRs9vYxv4C
 emUCG+b7hTbMBXHeqIv/dnEmtOE7xjCIFKsR1czUT3LH/e4sgb8j/Z8tzuMt48eX3diLxKbdP
 wD6zU/F0NHUV7T1dK2rluy0ndceGmX7vzfVpd0jsVbfaSArzMa+1YOWWeSs3rsN70H5Jvgi5C
 bItB469lcUo1AyR+pQbb8edFSAuvI7ib20RnXJ4JNiPXLvpuguMsx8RPa7j5Dgu2UH1qMK6KB
 I1YiruQo3uQTRYyCqf6D2dmeiG8xnzVCYm7GwpqL3cIdtJSmuQBxMcWGJhszbXT04v0zcwbcS
 qe9aL56qIaoPZ3gYYOM2BLc+8Na5Oq+ZzOtJCBHolnXext25EAWGR5WIB8jMUhjCtxcy1C6FC
 a8MdMAkxwYc8QIl5pmUasIncxYIPWOQdePJXrjKfp8u/7/9YgtilymYywvnVbzj3NjCmxs1sQ
 IcyDTX1loQbUVbjMAnC2QcoEjSfhGTEenkQeD6zi+12JO5MfHiKFDOKiZg9xF3D/xsuHSi3hi
 CUv+nvzyE1iDl4JvopKEIRauDA1pARd189tIBV1cuZP5cE9xcxhi+36AzVWWqs0USPikgAHZs
 Z8+GpHs+aWA7Ddv7nsOhWP2DCbcAr9GLGXzm1W94J8RSortCMkERyHptrwvHHntROkASGADAn
 +Ta5hVVxGgbY3sQOnS2Bew7Cv88=
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

On 10/16/23 08:45, Masahisa Kojima wrote:
> UEFI specification does not mandate to support the short-form
> of the CDROM media device path.
> Fedora installation ISO image is identified as CDROM media
> device path, supporting short-form CDROM media device path is
> required to automatically add the boot option having default
> file of Fedora installation image.

How is the CDROM media path created?
Why would the image not be found if the path is not shortened?
What is Fedora specific here?
What does EDK II do?

Best regards

Heinrich

>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_device_path.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_devic=
e_path.c
> index ed7214f3a3..ac673ab117 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -110,7 +110,8 @@ struct efi_device_path *efi_dp_shorten(struct efi_de=
vice_path *dp)
>   	while (dp) {
>   		if (EFI_DP_TYPE(dp, MESSAGING_DEVICE, MSG_USB_WWI) ||
>   		    EFI_DP_TYPE(dp, MEDIA_DEVICE, HARD_DRIVE_PATH) ||
> -		    EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH))
> +		    EFI_DP_TYPE(dp, MEDIA_DEVICE, FILE_PATH) ||
> +		    EFI_DP_TYPE(dp, MEDIA_DEVICE, CDROM_PATH))
>   			return dp;
>
>   		dp =3D efi_dp_next(dp);

