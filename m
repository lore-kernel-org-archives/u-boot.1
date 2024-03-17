Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BF8C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 09:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD7E87916;
	Sun, 17 Mar 2024 10:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="FoQaFnia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428A98796B; Sun, 17 Mar 2024 10:16:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B707878A1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 10:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710666973; x=1711271773; i=xypron.glpk@gmx.de;
 bh=yek/icQhxd8jXZf4ZgFeKn5bzhTuNnVNze9PJwQZsO4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=FoQaFniaTR4F+ts/T8aogNCyGdh7tsdX45r+WDdvQcPNY7t3NkdB285VztDR83nG
 rSaM4DxHMK0nIgW8oyQ3CwYAqgXLldamjJ2iHpPMTnFrglVwFZnOmwPp4B3B4h3kw
 FHFOJbK73cxrEBUAcGkSCVTD2TEl8pSmBv4X9015XoWq93BoG3ydZ42T6+1JZqe+g
 jK/5mnCT3tc1tS3JOkilIC/nosjvPE1Yho4k1nibo9Hf5bVlk7fdKF1/yDi3WjH0e
 vgNdnyszm22UrLf4NC0EXIew8IM7Dlh9A1gFpiz1zQFgNhUd1KVOQWlzEU5uLeRBT
 QoeL1AxWDzmn6fnmwA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1r0Ij310qi-00pvcH; Sun, 17
 Mar 2024 10:16:13 +0100
Message-ID: <e4a6620d-fe51-43c7-b2ef-7d5be287c5c4@gmx.de>
Date: Sun, 17 Mar 2024 10:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] boot: fdt: Drop lmb_alloc*() typecasts
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <20240317061730.654893-2-marek.vasut+renesas@mailbox.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240317061730.654893-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HElpNCgKImWazd3K/AQWc9cTtnU0haRaHgljf19rQFtHPPDko4U
 +4LtdUJkh8qNVz/RJ4gNLT84wmgJNXL+Hry3ZAAouWdGZeQwRa60+qhr3rDw3k1c/xahHpe
 GP7qrNZR9Pu2ro1VIHum0qiXtVUO0Zla45Dz4WIpdsWEZbyZdaaprpARbJlptYHLT+9Dk46
 ceZ9ovYNX+wSx/8txV87g==
UI-OutboundReport: notjunk:1;M01:P0:i2FoIM+Dd8s=;Jo+dQULGV6U8HWDl1V+1DNJvqfV
 UgkG35coY3VA1Vbpr5PGcz/wr2qp3EBq0Ozykb5mLMJK8t5HVnO+cUQdtGduzoyW8K8R1T3UI
 jYyGJyJTPhCu0tkV/Jdcnu0jVEBcFoNewiEZSZApPaCrqoHvzI0s+WouZWlU2k/ui2VXQLnhk
 6dEbBjmFI4o3BlpL8gwFyDd7MNyLQGGAjxe6pPB0j9RKVbZJ67JGdTO1GQglfEOyz+Ft2gsrp
 Q335rRon4sQIEgLCduNRb6YKe6LsOyI5yWRw3wvib56igqrliBQKnkKxgTyWkxCVEPHQq9OBP
 II/LmaQ+w3GcJTsybLpyUqB0lUwAAGAmsNuRUJu4HE9nhRc9/NvYuF3LViTGSjsBWkWEzKYPS
 SD+xC1sy1INs+OfWpIV+unx2/Y1euwbVOtICBrQO8n2RyhQrLM4To9Pyws6+Ks9rittpmMLWt
 uCyHEKRPSvp9hruf+aFO2tP2JjFkL5quES/IeQRsUNKCfI8SD2dqWRh1Kl9M+OaDantSDWvn+
 AeRWfzSUCp0Ybkfvxj0x7kTFx/8fIBw/jCZwxDSN/dsh05Mf8FvnCn0lEw4DFMFyqNNwxeKPJ
 44SyQCXDsZQLgw8SJktqWdbQSoHIh+w3r5Hmv2ERGLUScdcPGr6iR0uBetLOi/Gj22qAq8DN6
 +1oJdTp90knkwVAeXLNSkrYMsglH6H6cxVPIBdT7sG/Ad0T/nPX9wwZzuSIMK3v4cBIMiX9Ln
 m9i+FPW36I2YVPCctsgkFVPi2Gfe27GzMbA0tgmr2DL6QfPnTMtSVbCfZfbSQyLo7dJIaZBdb
 hEgfblZFZ4Fe2ziUGeDir6WFZmPO6rgayoouztmwUQ8qU=
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

On 3/17/24 07:16, Marek Vasut wrote:
> The lmb_alloc_base() returns phys_addr_t , map_sysmem() accepts
> phys_addr_t as first parameter. Declare $addr as phys_addr_t and

%s/$addr/addr/

> get rid of the casts.
>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   boot/image-fdt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index c2571b22244..c37442c9130 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -162,6 +162,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_fla=
t_tree, ulong *of_size)
>   	void	*of_start =3D NULL;
>   	phys_addr_t start, size, usable;
>   	char	*fdt_high;
> +	phys_addr_t addr;

Please, keep variables in the narrowest scope where they are used.

Best regards

Heinrich

>   	phys_addr_t low;
>   	phys_size_t mapsize;
>   	ulong	of_len =3D 0;
> @@ -186,7 +187,6 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_fla=
t_tree, ulong *of_size)
>   	fdt_high =3D env_get("fdt_high");
>   	if (fdt_high) {
>   		ulong desired_addr =3D hextoul(fdt_high, NULL);
> -		ulong addr;
>
>   		if (desired_addr =3D=3D ~0UL) {
>   			/* All ones means use fdt in place */
> @@ -224,8 +224,8 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_fla=
t_tree, ulong *of_size)
>   			 * At least part of this DRAM bank is usable, try
>   			 * using it for LMB allocation.
>   			 */
> -			of_start =3D map_sysmem((ulong)lmb_alloc_base(lmb,
> -				    of_len, 0x1000, usable), of_len);
> +			addr =3D lmb_alloc_base(lmb, of_len, 0x1000, usable);



> +			of_start =3D map_sysmem(addr, of_len);
>   			/* Allocation succeeded, use this block. */
>   			if (of_start !=3D NULL)
>   				break;

