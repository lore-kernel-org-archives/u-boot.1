Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44356C3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 16:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A64F2805D7;
	Mon, 24 Mar 2025 17:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tiksVZwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11DF806FC; Mon, 24 Mar 2025 17:10:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4695680548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 17:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742832639; x=1743437439; i=xypron.glpk@gmx.de;
 bh=Ua0yGuX9IOt5ERji6nzychv9Js3oG1uLpq25RfHapRs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tiksVZwlSi5Ut1NHdWT00XJJYj97dUJXoy2S16KL15StgUOZNs1qVXcvG9pQgboF
 IO+K4C5KnmKTBbH6VsU3ppth7rA2DPH9lZ4OQrW4SGOhWqQ1ZEJ5Ur8aSb9ZZYaVd
 FicAMNZzuL0guMzzjT4ilnL2PB+w+SvgMZrYqswllRppB09ObISkxn7UeFYQDYGaB
 a4MCYbJzgxc1x5Si+9Y6CAoCk9oSOyTpVxpTedbyvyMUCXjZLFQUt+F6u2CboKcwr
 BruuCm/wMPOH5vhph1a9UoGuXqeqSpZS2E+AdLsElj87swkRAmtEX775Nx8YUEw0t
 KJXSQ0JamjCkTB+rzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1tooHq18w1-002JE1; Mon, 24
 Mar 2025 17:10:39 +0100
Message-ID: <8ed61628-28a7-40ed-a733-224bf9531834@gmx.de>
Date: Mon, 24 Mar 2025 17:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: fix ipv4 device path node conversion
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250324083443.1537006-1-vincent.stehle@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250324083443.1537006-1-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HzUVPi+UxWpvipYD+XfwqblEUoBJ9KHFP+r0nHQ5yWJ5s+6rVKQ
 /wRqIE7rh6COG8BZ5ZdStumIAec3yXeA5zHL+DMUPBQvrWIpH1SZYkM7xbv3pMqqGKfvKtV
 4UztEQTCLGehMpCrHWLh0EqkG5zeYYlODosPFLxNMehOH346KvMdLKg8UzbqqWKa4cY7ovp
 fsfYYvag6cLZMsKmtWtXQ==
UI-OutboundReport: notjunk:1;M01:P0:9Hv63cfg4yg=;F6dn6bytztb4TNkO6mG8bREq880
 J47eK4cw/9xJm5QUNKH4Q4P8WzEVb5MJRVV/bHVptuR20XtIjsm7VwNNoQIP2qFGwCqMhiUpW
 Iroi+CUyNRB6btPdYepi72S6Jys9lU6ax/gQpIkrMYwM7rnhLVABumZlkBQMcJYNWgy0wh5zH
 5K1I9wL5BoIgasrb8TmDzWWSxl/BHE+0VVoM+DSKqiPfEcajvC895SDW4N0d1gHf0VSjif9vt
 5L2fTPEpEF57KATPk8IMfMZCOCmzGyOLXwKzWg8g1X61tr5B/4d8FvXw2EN3TKyZ29dpUgCTV
 XgZS1xXGi/HboF5mZjpFzPafK3WnFdjTYEhaCjMjhlxyY2/9uuk63ZTIkPLFi0amdvOUyih3H
 qqxQTeLQM6+vOV2+pwG+DxRqm0df1tR++HX5jUEKgkjmm5xsoyXkLhsR2XnOh//SHBM9YJxrr
 LwOOGhUkEh32/Jm8AiZufe8pVXsUlwKk0dLrFzuJMamk9uAYahdlFYTTZn3RiQgCvQG1Swb+X
 2egRdTKYKBVbar6adgg+w/mLL0JWyjUIr527sHgBld6LXKZeC0Yl0OyASgMKHEenauLecQv1d
 7GM1SmZGVULRMyqUpj5Aj3SlPG3zksMFFqO4phC+D7ShsS8xN4gNMY1KCQQSmNHbQGyPkyDhT
 RrR4m5Q+HxUXk70s7Gpg/b0D2hS9t+RtBZwzm1wqVDrpxq0WgBCCIB1E5j+ylT3eTmAJcrV0a
 YJ2STi50cffjlAp4HfZ+H38S/E4nf3ALDBAN+yeJABrwUmP7emMDjs1x1c2V6KjPApcvpwSDR
 hGLLfB90ZIbUpSRlkk4iMeOi0BeNiRuSrDZpoqsMu1ELSerOJzy7FqKj56fjSHcVN0cI0AZu1
 f5Qat6RFJJnghqtijO3ROjlDvhnuD0e3xfB7ltAW9fUzOOXvDfW08pJXNYFXEeq+dhtWp6yA0
 2pZAC5l+/+EGdPP9PuCyY4J4x85FXYKQggIwmB/nwdzBFBUJgLD1500C1gf2Wi2LF/FCvZI2L
 E5UBLFhw6MLBcY6RQXsCPNFcJPxGLR2bPjXfnE9360qkkqzl9+2WbNKrFZ1S+3BlYVOKJBRfz
 fnuAZv2wel5EdwCo4A64B90xewRbU+mFmXX7zEdwgvqo1EaqIEd8BJfxKf4ez45HgRtTIWYSe
 Q5aLcoMV/1QRJ7u0Zz0eWvflJcpHfz2kUbAVm+ZU0sRwXNGa24yqcB7QnXd63R66DWzOeDotC
 nqFsTGEg1gTJ68p0ERAKqIZDkC8d9d6QutWqfNlIzrg3jgR6unW3MpHGQLjbNJvDFPaVAQXnw
 kHeCaI5vCfTNgrQPpYXa2xRW2SGf3zbKXgEijhY2CoYp4qqSDtnOeJpgyxKD4mwDwWGooCMAV
 697ua/RZ1csOhBedoeOj7FWSQ8QU7zUP5cijtB2A1Y6JcJ1+pR/toHq8VWjpizMQMnXz2rbu7
 c0LuCKX9oIFpA0OaGeibHdfH9DWA=
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

On 24.03.25 09:34, Vincent Stehl=C3=A9 wrote:
> When converting an IPv4 device path node to text, the
> EFI_DEVICE_PATH_TO_TEXT_PROTOCOL will produce the following string:
>
>    IPv4(5.6.7.8,TCP,UDP,0x6,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)
>
> This string erroneously contains multiple protocols: TCP, UDP and 0x6.
>
> Add the missing `break' statements in the dp_msging() function to fix th=
is
> and obtain the following expected string instead:
>
>    IPv4(5.6.7.8,TCP,DHCP,1.2.3.4,9.10.11.12,255.255.255.0)
>
> Fixes: aaf63429a112 ("efi_loader: add IPv4() to device path to text prot=
ocol")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_device_path_to_text.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/e=
fi_device_path_to_text.c
> index f6889cb7399..452ec1b2e8b 100644
> --- a/lib/efi_loader/efi_device_path_to_text.c
> +++ b/lib/efi_loader/efi_device_path_to_text.c
> @@ -181,10 +181,13 @@ static char *dp_msging(char *s, struct efi_device_=
path *dp)
>   		switch (idp->protocol) {
>   		case IPPROTO_TCP:
>   			s +=3D sprintf(s, "TCP,");
> +			break;
>   		case IPPROTO_UDP:
>   			s +=3D sprintf(s, "UDP,");
> +			break;
>   		default:
>   			s +=3D sprintf(s, "0x%x,", idp->protocol);
> +			break;
>   		}
>   		s +=3D sprintf(s, idp->static_ip_address ? "Static" : "DHCP");
>   		s +=3D sprintf(s, ",%pI4", &idp->local_ip_address);

