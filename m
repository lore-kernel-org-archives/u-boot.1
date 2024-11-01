Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA038E674AA
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 07:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5AA88D13;
	Fri,  1 Nov 2024 08:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tRCqUDeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0669888EAF; Fri,  1 Nov 2024 08:12:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C3188360
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 08:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730445152; x=1731049952; i=xypron.glpk@gmx.de;
 bh=FAhoYoMZTkVv+apbVHto6S6iGCzCN9Gw15LXRmVQOgQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tRCqUDeY5FiV+lPnydWXDIeDqTG9gfw05gufFr8K1Wtu44ERgVyvacfvHCspzNeB
 fv6HHh2v3S0tc8pvwZNjAG4lWrTij7hajwl4/2cYXJG8CJJ14g9CTMpLed2xMi0o0
 jC08oqhKsdR5yw/EMUV6CxmeftvfsN6ImkDHlYWh1RQ/M7XGMfR72Mx3muURB01pu
 EkbJoxo35QUXr47bBx5xnRD+PUezDOUd1QcgzfUNibriRc51ZeIyJe1BwS4ibo6uO
 s6Zohsue569A2mKmgz5m3ZbiDu3J1RtgsPEZzR03f28zjJ4u38Dm/ijYr2e/8+IE9
 0B1qUgMo19KngPQPog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.150.8.169] ([145.103.114.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DJv-1t88DN34nt-004upQ; Fri, 01
 Nov 2024 08:12:32 +0100
Message-ID: <72d526db-f72b-4690-93aa-444cccdae249@gmx.de>
Date: Fri, 1 Nov 2024 08:12:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: apple: Mark device with DM_FLAG_VITAL
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-1-8a6877946d6b@jannau.net>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-1-8a6877946d6b@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:35Fj64e3CAaUw5KMRWw9fo7gi+oVVFp91PleALqHBIwEP3aJaF4
 ixs1OCND+pgAzHmHc47KYNS83NiGLU6fVDe69q/X38M44V7SqmhJNg9EgHq7N+Pjf/ocMMe
 bOuz+kfgBpwlP792lZvyhGsu7OEzSVUW1B4MZ3tpardm0ir4+5IXeoYGWk53O77nJFaN5SZ
 3dYuuZs8h+3sLNY3FuIqg==
UI-OutboundReport: notjunk:1;M01:P0:IfsYB/V8lMM=;sQ6k5PQaL+qWAhiXxiSnm1DYp1L
 L4DJVLioNJG5PF3srMdPZ9udu9RrLT9hEHAH1N+af62Bpd0PT8HY5MrVhTDXDtbwOdd/ASKfD
 yiyzJj1tMt0h0xXT4bm9pOWqONU31HyuH4wzQVsOOKUYvLaZQ8G5GXYDMN/UpJD5yoGuCu5Ow
 HQdKIfBDAdf1mUfq/bsXM+rO75oBI1a8IWGQPGXqpF+/jGdRXOaDLh9pkg9pSDro7r9k8Drkp
 MFWfuPxGv/72V4jZ4A2UDT24Q5RSiHLSZF0LzHD2PGFp2CQDUPVwgnGRqcQ0eIEHYnKlpi2ri
 24FiW1kow2X7gTWwbqT9AVkipeATUaaY/g95JMnPqDoOPwuaTARaEjZup3cbnNRz+4XNwJsea
 TRGTF/PEZ6pIbtR0wk14yzUE3ZKgHePcE0Pj8TSXEqugl3TPwXM0vW/jvuy+UBaUaVxEbE80L
 AgFrcdq9tcWCzkfcAVj5nsZScj0t6zhttWYBALqVQFTl0uq+ZF7U5Zpl04VDQr1MtAI0eKKtp
 vjCbED6xUUQrQtP7F8zaVTwOs0afejhBJi06gvpimXm06ctyV6cCB8+/PhXZA2i0lK8nTRjSk
 N+qHqrwwoCUfIrmm7QQJDJoKfPLw8Zf7cuztqtqv4UIeHXthFnIOfLwrDw+wLGZSltHeXV1zh
 8uvIBxX26UxgNOHdINOQ87X55kcFam1OwJxh11pufhEEIcebyVH6xNQmxYTI3WP0Rw+B0JtNR
 XmJIrnrBvwTzAOfVfYsKBT5pR7Msf1NB2HJ4vlz4ufsJF81c2iPhDCOqP5o52jNjQeCC2Om6b
 fM0RimUExy3OY6CaqRV8DbUg==
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

On 10/31/24 23:48, Janne Grunau wrote:
> Avoids NULL pointer dereferences in apple_dart_unmap when the iommu
> device is removed before its user. U-boot's device model does not track
> dependencies between devices.
> Observed on a M1 Ultra Mac Studio with v2024.10.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Hello Simon,

could you, please, review this patch.

Best regards

Heinrich


> ---
>   drivers/iommu/apple_dart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
> index 611ac7cd6deb4fccd45ccfe8cbb9b3e36e2af753..9df174f32d721c39079e6573=
6c91e3e27a72ace2 100644
> --- a/drivers/iommu/apple_dart.c
> +++ b/drivers/iommu/apple_dart.c
> @@ -312,5 +312,5 @@ U_BOOT_DRIVER(apple_dart) =3D {
>   	.ops =3D &apple_dart_ops,
>   	.probe =3D apple_dart_probe,
>   	.remove =3D apple_dart_remove,
> -	.flags	=3D DM_FLAG_OS_PREPARE
> +	.flags	=3D DM_FLAG_OS_PREPARE | DM_FLAG_VITAL
>   };
>

