Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02254D3B7C1
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E4B89682;
	Tue, 26 Nov 2024 10:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tdArbTm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF5F89682; Tue, 26 Nov 2024 10:21:15 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96CF2890DF
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732612871; x=1733217671; i=xypron.glpk@gmx.de;
 bh=dqfYMwxJRDJc36nHuIlW8yWAtiiiz/yj37LswBSpCSk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tdArbTm65VaPIInSGHDDoJFsPAtDmYzxUwdqGZjDd2S673+rytaXsENnD7q9+6r7
 u+2liGAY+V7gB4xajnjG5LXKKvu0dyVlH94hyosxnC18ccDfQQQSd9A5SjOW9IWGx
 eIOR0fhxMCaMf9Q+K+euUccmEqk54DQPs4HnQ9hh1qJge1rtyaQNfogqWIbs4ZmnJ
 CSmDxZzMPtw6H0Pue73M0p0QBDnk/nZ2CkWB1uDzZ2IQUwmyJJ/3t6TwsQ7iLBzSv
 KSCOyjXqV8xgtp6Vkv5io4rqAYhbKCV+fmqGX7+c+i6glMA1P3RsDNNXBrFeIekf5
 8/BXqg56jO2IMN4AdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ofE-1tk48H0P2M-00s25Z; Tue, 26
 Nov 2024 10:21:11 +0100
Message-ID: <82524b67-6736-4214-9e81-c7413db29848@gmx.de>
Date: Tue, 26 Nov 2024 10:21:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] efi: Define fields in struct efi_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-2-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125204456.1525752-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SfCZg9572pr4JQg9CWSYeKzizdlNlTe+AwheoA/zWEuloUu/+sp
 VY1KyWn2uhG7fqhl44VUoUV8ikMJ+tgRdGC5OENYTFtQkg+A6amZIy3Y8rDarvc+0Xk4R5D
 dU0V9H8jJlr0qQCydy6cRyZVh39CSLSbN3NiKRDpFO0tMUrTGBsUqOQ9wUEwlyX1CCNWZsE
 Imnu7eKwPgxTcllCKAB0A==
UI-OutboundReport: notjunk:1;M01:P0:1KfDqa8PxPY=;O+cuBtzk6VDW69QuKdrmHB7b523
 2/YgdIT8qIdMXgqDEswHwx9YruKYs6Wvc7h1pSEAgxsBDOctngzk8SQ/rfe51SEZGYGTnvTzZ
 IAr5ZEKZwDQQLeWk+VXT7Bzsvdl6YIOIB8Z8X3WZ8+a4ViQbsUaAL23gmCLBFzmOlU0HHPRjL
 k/dHTCHOy9vZnL8sWcP6/8lX0dTHgq2lBs29ZpfM1ro0XC4f1lUVbmKsr57MjDHsF3rpSFmsa
 X2rrbJlxEMPwsFiuFAEJQ7S1lmjkbLBwQUMAqzsIi1Dd25S3xQ4yoA9AgC1bLnHKq/G8KneAa
 MxWRagucT0z0ipeIxPUdjg6C2caE2vvqHHoGV9BRy5jYXRTPnDiEiGv16hJfRQA6BdxPcE0X+
 U0ffS6zGwLPDCA8Zdgj+3xZbpAe7AXPAcq8GYSfFl3lQ8yrxic5o/vFMy3NOn+d/3neaEtTDk
 LsjQ9rR/p5ky8CrgpsEKIZVjIBTvxAuegRWvimLX3r53/nDkfVsMqmEt8lRCy9YuCIkLOvCFm
 0Ey2s6QIp4A5tBJc0JHp1gOecSli7eIVfFKoMJ7nNNKha4brF3yjUuoC6l2AxndVj4/elfPSV
 mj+GS5udRq7CtUCixOHT7SC2N7TP8e2BsM4iuOfqvyxKIcBZeloIMx7D96FkeUx1e478gEhsM
 lPYMnxYmOeIJD8xZTvgkcLCyrnM5kXri/dPlC5t/LMPEBoB/erdXGSZ0+p1RnZR3YuoUmr5ic
 cetdq0NJEJElQb574kIbfYQ2tJKm/5nliCE+hlXUHv1ME4M9rS8B4MyulHyeNySK5iUaSpYeP
 VQWLqh2RzfQFb5JrWEr3TAZZS0mnda+2OL2ZAYYcQ4ZDTVbZDeCEI0qDGV43GwStywgFiEPBm
 lIPydgHB9RlmCcrafAJx5aBzWAR6xCfTnQX3Iny4odZpJOOxTWImgAZzf
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

On 25.11.24 21:44, Simon Glass wrote:
> There is quite a bit of confusion in the EFI code as to whether a field
> contains an address or a pointer. As a first step towards resolving
> this, document the memory-descriptor struct, indicating that it holds
> addresses, not pointers.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   include/efi.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/include/efi.h b/include/efi.h
> index c559fda3004..6f48c6569d5 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -273,6 +273,21 @@ enum efi_memory_type {
>   #define EFI_PAGE_SIZE		(1ULL << EFI_PAGE_SHIFT)
>   #define EFI_PAGE_MASK		(EFI_PAGE_SIZE - 1)
>
> +/**
> + * struct efi_mem_desc - defines an EFI memory record
> + *
> + * type (enum efi_memory_type): EFI memory-type
> + * reserved: unused
> + * @physical_start: Start address of region in physical memory. Note th=
at this
> + *	is an address, not a pointer. Use map_sysmem(physical_start) to conv=
ert
> + *	to a pointer

NAK.

EFI requires identity mapping. The value physical_start must be usable
as a pointer (void *). It cannot be a sandbox virtual address (phys_addr_t=
).

Sandbox virtual addresses have no meaning in UEFI. Restrict them to the CL=
I.

> + * @virtual_start: Start address of region in physical memory. Note tha=
t this
> + *	is an address, not a pointer. Use map_sysmem(virtual_start) to conve=
rt
> + *	to a pointer

Wrong again.

Best regards

Heinrich

> + * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE=
_SIZE
> + *	bytes)
> + * @attribute: Memory attributes (see EFI_MEMORY_...)
> + */
>   struct efi_mem_desc {
>   	u32 type;
>   	u32 reserved;

