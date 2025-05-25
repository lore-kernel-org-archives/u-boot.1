Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1C2C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 09:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D915182B0E;
	Sun, 25 May 2025 11:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="R0oeaNw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA0182AB9; Sun, 25 May 2025 11:18:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD998003E
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 11:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748164708; x=1748769508; i=xypron.glpk@gmx.de;
 bh=Aj9NSkLny2+srb+N7w7qy+VkcYWEw6DVbOiIzpfQHso=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=R0oeaNw2Pi/Zn3LZHORCVVOotzNZUI1nQBXRxPOBDFQA5v1SRjoKkUkJP6zP95d0
 L/3JTQtS8JTxUjsQC3zVTkeDl4P91yQmzv3E2DoSXVv8iZqyhD2Gu1RM+U+X5dtAA
 s4Vp16TkK7GxTH7WbLeq4dKWut/nYZWACHK31cM49LEgtFzRqwKOTUcPBi7YMeTpM
 kPCw+lkXh1yFKc115mtgdiP8tjQKKBrH3eB4J98Wh/Mgbe/Xd/TOAXUG1COxOEBXP
 J4TcslUZcWUniOo4RtQ1qULGakRh43LVQ0hzUwFAT6eoqEgjvPOH3ceFN+6s7OeVY
 qyP4Fx+lybH9W6vN/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.142]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6e4-1uqYyj47dm-00f06e; Sun, 25
 May 2025 11:18:28 +0200
Message-ID: <501660c5-2c69-4f93-ae10-d83253706890@gmx.de>
Date: Sun, 25 May 2025 11:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] efi: Include device-path functions in the EFI API docs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250524172827.1243975-1-sjg@chromium.org>
 <20250524172827.1243975-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250524172827.1243975-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nOuH/91+M/qxyDjHwXRBn4ZZ3LY82pZE+RiBuwl7TAdOBlMzzA5
 w5cJNx0BGM8sLn9OBdmcWRTJC9q/M71vFofn9Aigb5HvUiyL0PjW4pFBkBBVzcwH+9PlRp/
 YF+NIGAH0tzzga4agHi0bvwqG2o8JnUS7QafyyWd7MlJPBVtTLMw/EZzvfjZjEGEE9We5tq
 8auJ1j+CrhNyop2kD632Q==
UI-OutboundReport: notjunk:1;M01:P0:GHf+S3r42gY=;Jp2QbeCqdGqbIOtGN66Y6sKhQEV
 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
 z0Oh7dVU49HuMeX2p0PG+TheC5V4L9+b8h
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

On 5/24/25 19:28, Simon Glass wrote:
> Include these function so they can be browsed in the API docs. Exclude
> END since it causes a warning, which becomes an error:
>=20
>     ./include/efi_device_path.h:22: warning: cannot understand function
>        prototype: 'const struct efi_device_path END; '
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

We expect builds to succeed after each patch.

In patch 1/3 you need to change '/**' to '/*' for variable END to let=20
'make htmldocs' succeed after this patch.

Somehow you dropped Ilias from the Cc list for the series.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
> (no changes since v1)
>=20
>   doc/api/efi.rst           | 6 ++++++
>   include/efi_device_path.h | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/api/efi.rst b/doc/api/efi.rst
> index 43d6f936fb0..a98298f93dc 100644
> --- a/doc/api/efi.rst
> +++ b/doc/api/efi.rst
> @@ -178,6 +178,12 @@ Driver binding protocol
>   .. kernel-doc:: include/efi_driver.h
>      :internal:
>  =20
> +Device paths
> +------------
> +
> +.. kernel-doc:: include/efi_device_path.h
> +   :internal:
> +
>   Unit testing
>   ------------
>  =20
> diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> index 67474d6d0c1..33b6cfe9b79 100644
> --- a/include/efi_device_path.h
> +++ b/include/efi_device_path.h
> @@ -14,7 +14,7 @@ struct blk_desc;
>   struct efi_load_option;
>   struct udevice;
>  =20
> -/**
> +/*
>    * END - Template end node for EFI device paths.
>    *
>    * Represents the terminating node of an EFI device path.

