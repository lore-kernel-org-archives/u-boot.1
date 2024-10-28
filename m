Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EE4D1358C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 06:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A97885F5;
	Mon, 28 Oct 2024 07:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lbUjOIGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C14488FE8; Mon, 28 Oct 2024 07:11:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4567988360
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 07:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730095862; x=1730700662; i=xypron.glpk@gmx.de;
 bh=wDEz7ZyUOPSb7LCdVu4BKv4Eh5F57iSVT82BLfC6grc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lbUjOIGj2gfKN0m5ty8DE0AKTicmTqvn125ajHMlbTzsAohaRdSeO94DREly6Dsq
 zYE87qfCAZ8UoeZCLvPi1/CXr5KqoBdXuf9rkvqUCXK9omuj44dfBRfTUfbPPXwp1
 U0MQu5OGPXgjenuF9FAEd5/GKpviLGurtWX37Ydiy79Q4aI3RbSzpS+111wametTx
 LLu2SY9cXBLEA7y9qa4zFAlh8xROwiAM+i+CkB5rl9HsDLfY9KWnBMPir3OX9jzfS
 +jMi/p77POai7DK+hVYp4YbJQUFp8omTY+f+WcRv64n9uZ5KGqk/oso8kmK8xFDax
 U0j8CBRWErwyJ4GR8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.43.6.224] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1trN8m0U9i-00uiFR; Mon, 28
 Oct 2024 07:11:02 +0100
Message-ID: <81ad3aba-00f9-4ccd-b7b4-86437aeefe39@gmx.de>
Date: Mon, 28 Oct 2024 07:11:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disk: Mark static functions in part_efi.c
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 u-boot@lists.denx.de
References: <20241026080555.135472-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241026080555.135472-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:111uVfkwoETqt7FR0mMU6RTnK22jbtd7fpjUjmQmPF1+xcU3YlC
 gJo48of4A7E2Pf1MOIq2mouX4Z3wM9TpGx1fXfYu2SMgMMtP1g1STkGm66jmgj0GmbqepMe
 GSrPDC7fKSmNjfTFUuhooIRiApj7maKNLdLs6ubGq3nvXDwqbRgQYp5lbOB9zJL95DuvBP0
 gbHUqMJnQMZyyRtOSPg+g==
UI-OutboundReport: notjunk:1;M01:P0:r0rNnRjWzUU=;8BQYR4z3eJJOpQ7eAMAE7cK+E46
 q+BP8avoO+AriI/0Kcerv44bc/d48+BdYN+qiOXqlruvU3sZ7m3YDYF9nw47Prnd/VA+7d1cY
 pwC639mAVmHUmU2sX9ylwlK2i640I6X7+nJee/lDWz081HyQ3nhstr9xRRyFUuTv49hmVHQFG
 A/AnL1zRd+V4e77H49OdNdwSQS8VKkRjU8Cvsk97J8vcLFy2uvt0VVK3V1bo8edH5g13+3GXm
 VIR3aErtAXDLTiWpfDLaT6KiIyNZhivcuWG3UGAESswkmmo9h5wsfWPEhbdLAXR39HVO0fRbM
 2KwnBW5hcgP4A+5fvRnluEPca+4Wo2FujoWHeXmrdTeZqd7mqB0bE5+oxNADgjyo0SNewgikd
 Y8rlCrcNuawUoNemJpgqSEQQ4kAD0CceXo74toyZBCjurBayJkLZSkAC7QipMRobQVfEdZbC4
 H9aWFB1T00bYv6la9xG9pUXty9bSBoSC4WVCbrlkCOIDsHgevKHSqY418LspmVMPcOS2x3ezi
 TAqaYW43YaTdrL4LR7p6zlpHjdpBhOlNC6+vEB2pHS+rz/lmnwwEUOM9UG5lTsG2u9itYPeFx
 CDPPhpV7nVHN5z9A7nq5o5ovw1gBde5fAy/jvpLfFtklqbupTZGOpzHLHIDB7fW89ss0fW9BJ
 7RUaifgo4KrnKSHAGypTXX3cgWRlOdd1CikvK2pmyogwZ241T6wsBgiUuhjCnpdk3MOH/RNWY
 zoATFWpA5askydETbgDGVe+36mWxo7YzfXCOxeoVmfCjnKBURUSwQx5XmV7egvak5v+tz3nSd
 glJip+cNatBrOsQc3w/3UMTw==
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

On 10/26/24 10:05, Ilias Apalodimas wrote:
> Mark all the functions that are only defined locally as static and
> quiesce W=3D1 warnings
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   disk/part_efi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index 7f04c6ecd69e..cb2fcc2bab2d 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -216,7 +216,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
>   	return 0;
>   }
>
> -void part_print_efi(struct blk_desc *desc)
> +static void part_print_efi(struct blk_desc *desc)
>   {
>   	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
>   	gpt_entry *gpt_pte =3D NULL;
> @@ -258,7 +258,7 @@ void part_print_efi(struct blk_desc *desc)
>   	return;
>   }
>
> -int part_get_info_efi(struct blk_desc *desc, int part,
> +static int part_get_info_efi(struct blk_desc *desc, int part,
>   		      struct disk_partition *info)
>   {
>   	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
