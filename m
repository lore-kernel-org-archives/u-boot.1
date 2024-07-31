Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B31C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 06:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C8F88934;
	Wed, 31 Jul 2024 08:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tzn4paZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B3F08894C; Wed, 31 Jul 2024 08:15:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 830BA8890F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 08:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1722406526; x=1723011326; i=xypron.glpk@gmx.de;
 bh=7LOsA//f7lluW8as3QrpuAE3B9AA4io1rEbrJJz+3OA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tzn4paZddc2Gf+n22Z34rqLAiqTn8f1yM0hBvg8YCxeNoTD/4YO1Z3RCePEWKjzf
 UJc4MQx4+yxrWvLpMO13ZWXuLmP03S2wkRSQQxBZcdafui/o71ywzDOKFSKJ7z2Rc
 7LBz3dOdGr/fs6LPOCp0/gfUAks8WbVHMpCtQIxcETF1eqZ07Gbsm156/DWODGMqV
 REP7HAOrFHwBjgP7CXLDez0y60AblP38jo0uTBvhg5CxghLnsUH2p3ldvEI7OThm6
 MkKuryQhsCr37A3HUPMQ47OwCY8DcGfv8stUm/Aouc6ttNs/NqCEH5COnDU++HsTa
 tx5yBzoZmOot7iUSFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.93.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1s60Qx1hgP-00teIG; Wed, 31
 Jul 2024 08:15:26 +0200
Message-ID: <7ac89e53-2e48-47d7-9444-2ed51a09d7aa@gmx.de>
Date: Wed, 31 Jul 2024 08:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] efi_memory: use list_count_nodes() to count list
 entries
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
 <20240730111132.1097315-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240730111132.1097315-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yZf7UjlN6s22Uw6620MX0iuLWXMt+s1sWuX4tZNyznHao5FacYk
 K1rCVzSOGsGSdtm0HocKQZcGB8e30c/ihkd1L+e9VDbqyyOFlin6iSpg+FvGU1x4X7Mk1nj
 LuA4QMcULO6AYOdBmfwzTcx2zYvGmZyI6pcPxvUu39bNItV4Gqza+lPqU0hSgEs/IsW57iV
 Xne2nog8uWkYw5h+Ef8mw==
UI-OutboundReport: notjunk:1;M01:P0:77Q/GTzerdw=;dEc/zGVdy9JQX0HrOwVVLBzDrQJ
 8b+AsVEIprL/+MRKPMQFtxicKcwMY1aEHvCXO7g4AXclVokAB0XtApaV9jCGmNIK6bT6dbgby
 7rQVm85HoTbRAQYIBfYbEnueDUx3s6fld9q3lEK6sz6mQnRxaQP71GV5qg18KpM9azFKvMF3y
 8cbvzCvq1hO08fcW0ACt6KGOQbai2U4251RTdP1mVMao1h8AdsD4dVsbTYu2EZQDJPJNhioHs
 kOby5b72LYRC5WwmZ7CvD6bEkg50H8p+fzoykKOo66bFPC9NgSGJEWohbvr9D1AuRAS/6ptZi
 gKxz8AAttAOcUnzaZLoad3bprtmCnYr32U5qRArWFqFECOn0wiGhC1jh0Ghdx/AqPrUA5xayS
 JLblCDj8hegnIHPyYgETva4pbhnYXUjlnGtHAx40t9fokagItdCqPGEK1N+SJ41HUoIEzXZbZ
 Keu4Xh85okcIYTVZhFk1tcscDMDiXuxpl/zmO3m2j5mo8nJ57VLt6YUz/aJUMmafYmXUCsovg
 w2anI1r36xeLKI4ENIFGEYcvak7josCo0DxRScDyNEbGz+Jnwc+s3jOJ2qrECAOomYfK1LpA+
 19r7X12FFc8ly2irKr+tgkVzJIS7RVwlPWVRosoRvqZz5Cs9rx0DHNsGry8pivxzWi1YQ7c4I
 BFEZNskMLbeAzFMQRKq6t/Vi7ByF+SKVC55HBtDUtmTwW3wYuSBygnCM0CgTQxSblP1RwxmpE
 8tJP7y/qmXnD6tyXAJWDfjvcc6K8epC942XXBtAXxP35+8K41Ukx1hYZZFa/sgNib0yhOGErr
 LdEBFIFrTUKfgFk+ZOmjlV6Q==
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

On 7/30/24 13:11, Sughosh Ganu wrote:
> Use the API function list_count_nodes() to count the number of EFI
> memory map entries.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   lib/efi_loader/efi_memory.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 12cf23fa3f..bfadd6bd41 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -742,8 +742,8 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_=
map_size,
>   				efi_uintn_t *descriptor_size,
>   				uint32_t *descriptor_version)
>   {
> +	int map_entries;

This variable should be of type efi_uintn_t or size_t.

Best regards

Heinrich

>   	efi_uintn_t map_size =3D 0;
> -	int map_entries =3D 0;
>   	struct list_head *lhandle;
>   	efi_uintn_t provided_map_size;
>
> @@ -752,8 +752,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_=
map_size,
>
>   	provided_map_size =3D *memory_map_size;
>
> -	list_for_each(lhandle, &efi_mem)
> -		map_entries++;
> +	map_entries =3D list_count_nodes(&efi_mem);
>
>   	map_size =3D map_entries * sizeof(struct efi_mem_desc);
>

