Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C57DCEB2CB
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 23:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297F589003;
	Tue,  1 Oct 2024 01:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uWRfjBp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7EF8907F; Tue,  1 Oct 2024 01:18:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E83388F94
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 01:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727738291; x=1728343091; i=xypron.glpk@gmx.de;
 bh=2RpxsDojMuwZFtA1rM+Im/G3GSEwDzRjiPDd8MTfEns=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uWRfjBp8HSCwHSxzyxyhAl3g15Zu854IY8+x4e7WyiAm5I06SYBLry+dCd5YDv26
 aDYSHnjpmxaIMWauNd66f7AyASjWHepo1BeFHOukx3WsGx9ImZmg6f4V8v5EzGIbe
 3u5f+BhRqEWRB462K3kFGxWa51Y9Lo6p4RbcH1HySMibFNecJib7kTN8yj6eIC4AA
 A421j+hXQx+nFuTu70mP/5Hs/Q2TvikPjWXESQBGEpw4QkV1syjgTTcYxSERt8z+H
 vD1ItxW1LDx1CZsLtK1rD1j/TDhVrMDxxxjPlBa0Im94hEoTqjVxt74qUMla5eOEJ
 3lxEQxqGLB4CtMzZiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1rpf0G0fDr-013FM6; Tue, 01
 Oct 2024 01:18:11 +0200
Message-ID: <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
Date: Tue, 1 Oct 2024 01:18:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/12] efi: Use the same filename for all sandbox builds
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240926215950.1265143-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mBQf8fHy57vJD0LZRrmeYi/9CIETnZoMdyFxJW+8yy81xXUWV1T
 oCqNsxgDPOlDdQ+Y0EJ7YTDPJSrFrozn/HnRpDJFoJ4lgMRpL1NXKEXvh7CWd7mx/2hoa8V
 zudYxRehIyTbD3tnNwIfUsYQ46kvs5T4lkYdowvXf1DdQveMUhqsEL9b1Va5jh2ZzstnxKr
 tLGE/RwfMwkfm3tDNcIZA==
UI-OutboundReport: notjunk:1;M01:P0:1QrC4XC4Uxk=;abnRQOA9vl6NVG4QjWzjabot5XQ
 7ruYdVawvm8d6ywD8dLGe4FOgedTh3oJysvBgbKVTuJiBgG+17UZdUkVaQGD6EwxzmC5AF6yU
 vb/gxvG5DqAuhcpFA/yMn9QlAEkSUWt+a4S6DnzSHgL1/izXnmuOr9n5GURhOBux/Uaj90Gtt
 M48Z4EpVAI7T0KFXqoDYIkBR1SuXSx2dUL7kK0tSJ7EEFzQ19GmT2C6EhUc5zZDmYPTzzmumD
 OR9hD7t2/wqzaiuy0Pvatnt/1yTIvDvZHVn8cPzMJ+JM44LCSFUvSTDPqQtLJZo93oO8sedQ5
 pMpcV9qXgdnhIhx/6OgSmRUIHM/q1h5u11YYMxGz8aVdrQlIMy4G6IwXxAIHzLs2ZYBoePKv7
 nyDbe85l2Fy6mYnasfMAECu09LKJL0wHyJyFSDts8GcniDjCWQABvI8EqKefUrMxE+SIMxJVB
 hHFYVeTGOIRaDa/Brhg/rn19/76Gdzl7aK11t4zWi0b5XW8d0NCK5pqmIVVsjohje9lQb38sr
 psU1bcpvlvX2i1gzRvfggq8vkV7lYZ6hMHlLNfC627Vhybcd3MjtiTxkRhHjrlHflc8T3w/Nr
 e11N7t0qxtuNBm+ZynwWw2cEZA0I/30krje+ymnoA/wDNq0A46im5h/8xxljzZ86RtoDhMUmL
 trhww7RsAgbdK8SYnMhFoYu/ydXbpKaDOCRCNQ3glK+snQ5krWqjPkJ72AgxCIq4IK+UlQCo1
 pzwz5qKo4+o66uvaX0+eJ4bnQbs0GbG+ncyYKpAf/B+wwtFg/QyLG5VTffXRQeDVfeWfNudUU
 Lhr9ucNfaBic5Qt3KS94pjfw==
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

On 26.09.24 23:59, Simon Glass wrote:
> Sandbox is not a real architecture, but within U-Boot it is real enough.
> We should not need to pretend it is x86 or ARM anywhere in the code.
>
> Also we want to be able to locate the sandbox app using a single
> filename, 'bootsbox.efi', to avoid needing tests to produce different
> files on each host architecture.
>
> Drop the confusing use of host architecture and just let sandbox be
> sandbox.

As I already wrote in
https://lore.kernel.org/u-boot/ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx.de=
/
this patch should not be merged.

bootsbx.efi does not exist in the UEFI specification.

Without this patch I can test that shim work and grub are correctly
loaded from a distro image. This patch makes the sandbox misbehave.

Best regards

Heinrich



>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>
> (no changes since v5)
>
> Changes in v5:
> - Drop the Fixes tag
>
> Changes in v3:
> - Put back the Linaro copyright accidentally removed
>
>   include/efi_default_filename.h | 24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)
>
> diff --git a/include/efi_default_filename.h b/include/efi_default_filena=
me.h
> index 77932984b55..06ca8735002 100644
> --- a/include/efi_default_filename.h
> +++ b/include/efi_default_filename.h
> @@ -16,26 +16,8 @@
>   #undef BOOTEFI_NAME
>
>   #ifdef CONFIG_SANDBOX
> -
> -#if HOST_ARCH =3D=3D HOST_ARCH_X86_64
> -#define BOOTEFI_NAME "BOOTX64.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_X86
> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_AARCH64
> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_ARM
> -#define BOOTEFI_NAME "BOOTARM.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_RISCV32
> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> -#elif HOST_ARCH =3D=3D HOST_ARCH_RISCV64
> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> -#else
> -#error Unsupported UEFI architecture
> -#endif
> -
> -#else
> -
> -#if defined(CONFIG_ARM64)
> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> +#elif defined(CONFIG_ARM64)
>   #define BOOTEFI_NAME "BOOTAA64.EFI"
>   #elif defined(CONFIG_ARM)
>   #define BOOTEFI_NAME "BOOTARM.EFI"
> @@ -52,5 +34,3 @@
>   #endif
>
>   #endif
> -
> -#endif

