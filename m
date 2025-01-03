Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C9DE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 11:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8663080295;
	Fri,  3 Jan 2025 12:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="oV6KL3wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9F1802EF; Fri,  3 Jan 2025 12:22:58 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA9180196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 12:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 13DC53F1CC
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735903375;
 bh=/tD4A083u92Fp5hULCrU4rCeg/tmndM2/lL4Ng5oJEY=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=oV6KL3wfUOPbGOdbjuOf5EF//VcuKhP7PUDsj/n/z9rAZm8D3rnVrHggfZkzczNoS
 qdad05x+E0V69zCIiJeT5FKGZWxCNrRzfEZIemis6t4MexA/7X5tJcR5cQw2VjuvHl
 E6nHyezDC1hwHbO8NzP5prxbyRwxcRgayoTqIoJV9jNLaY9WEMx0kCNq/IwbZbIfTY
 L9dKgUkkuitWEiWGp+WAwJSCp7fo8Xu3ExHd9K9XpeBBdmXS47Wu9fjuoOWavJY8Xi
 jDinUUXr4hh4cNx6NNNgcvIuueehY0lwrTDoCdWmRjTMwzzq4Dh0aSkoSRbApwuhK3
 xJLTfDxlvuVLA==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa665246a3cso184097366b.0
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 03:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735903374; x=1736508174;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/tD4A083u92Fp5hULCrU4rCeg/tmndM2/lL4Ng5oJEY=;
 b=SjRSX3Rf/tNQCc+T2v+dznsh0yEuOePTAcJw0qPNn5i+IwibX83R4f1qqnJQ9pvc00
 vxzG62KUdH/Fc9qHVpPwVumisoSwF5i2AavwWHHCC3jrNCAYHJmKW4DOjTDnb7PP5JOJ
 jW1MuU9XISnQvn2MoBLw64ZkqdrVZLm/Yh5uBXfKpXDvj8hlYxJzSMfrZJ3YdQ3++Udx
 N7JB4f7vKwpevVD+KL3CxqLB9BKlSYTv80rtIc/DOpEHh1jrdIgnImEKMRPXOVGHBz4X
 SQxydUxqHOSa0mV9Z2mmKGzJToIyzE6Ugz7KCP1E+2f7wMhcb4MZdvtytnsGl9KCj87S
 Glrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0xozvPqg75KwRU6n+hI0LpPwnaibSUjcl/LBXWfPVvOuOc+/zCGd5KMhCKAhAW9ZdTeqhyLs=@lists.denx.de
X-Gm-Message-State: AOJu0YwFs6fms1QepUcbaMKQIiDEe54DEvAv+zXMjc6xTt3uhSiGnHUD
 0pwb7tjqfAPVYcAkz73WzrTkk5caHVBaEgqj7y/FNB87CuzRIte7cSn7sR/y1MozFC3cfT5FdYs
 FPZ7xpkNKHiD1Ib3GBfWMFB00HK5beMipU5viMcKnhl962zpFNH8bbCblF906gQEF30ozR68CQ0
 A=
X-Gm-Gg: ASbGncsYOewbfYSb9HqpNgw0gOCt4A3fd1gx7cx+gpX8caD4h7Obvc8qLF6yQb5bzkq
 BkQImgIKiSAJfY/TVjBxQauD3NOLpMIAPARQ3h0TJJslQH4T81ad5SBRyxl8VUnCKJY0U6wcb51
 vl79wI6fCiBchZbNP7C0sgCY9xN9VIuc/NhNun3oFKwaAG7NLfYqLxK6vXvVtE9EhOKIlcvxPyq
 wpIuOhYvojg/fgHv3DZsDN9/a44BiIRk1sPy/0bhzoLbUgAmnq2OIXXfzI9LHNzNU65cTDVxcm9
 +7GszW9UqaoaIqlCQfkeEKwgpxP9JEVVxUaWvekPag6d+QeK
X-Received: by 2002:a17:907:3e90:b0:aa6:abb2:be12 with SMTP id
 a640c23a62f3a-aac3354ff4dmr3405993966b.37.1735903374659; 
 Fri, 03 Jan 2025 03:22:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEil53wG7EOaUYwV7o3kV9sIijF6KlxHREWl3my/sXFrbFIfZVLU2VqZjCIsJi0WClbjfvQ+A==
X-Received: by 2002:a17:907:3e90:b0:aa6:abb2:be12 with SMTP id
 a640c23a62f3a-aac3354ff4dmr3405992866b.37.1735903374277; 
 Fri, 03 Jan 2025 03:22:54 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:45ea:1404:1d92:3f16:4f2b?
 ([2a02:3035:6e0:45ea:1404:1d92:3f16:4f2b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aaf5c6bdb1dsm550585766b.112.2025.01.03.03.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 03:22:53 -0800 (PST)
Message-ID: <944c5d1e-828d-4d7a-919c-bcc56e557675@canonical.com>
Date: Fri, 3 Jan 2025 12:22:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Correct ECPT table GUID
To: Yang Gang <yanggang@byosoft.com.cn>
References: <20250103081843.29-1-yanggang@byosoft.com.cn>
Content-Language: en-US
Cc: Jose Marinho <jose.marinho@arm.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250103081843.29-1-yanggang@byosoft.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/3/25 09:18, Yang Gang wrote:
> Refer to UEFI specification 2.10:
>    #define EFI_CONFORMANCE_PROFILES_TABLE_GUID \
>    { 0x36122546, 0xf7e7, 0x4c8f, \
>    { 0xbd, 0x9b, 0xeb, 0x85, 0x25, 0xb5, 0x0c, 0x0b }}
> 

Dear Gang,

Thanks for pointing to this problem.

U-Boot provides script scripts/get_maintainer.pl to find all addressees 
for a patch.

Fixes: 6b92c1735205 ("efi: Create ECPT table")
> Signed-off-by: Yang Gang <yanggang@byosoft.com.cn>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   include/efi_api.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/efi_api.h b/include/efi_api.h
> index f07d074f93..d3cf012693 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -227,7 +227,7 @@ enum efi_reset_type {
>   		 0x71, 0x94, 0x19, 0x9a, 0xd9, 0x2a)
>   
>   #define EFI_CONFORMANCE_PROFILES_TABLE_GUID \
> -	EFI_GUID(0x36122546, 0xf7ef, 0x4c8f, 0xbd, 0x9b, \
> +	EFI_GUID(0x36122546, 0xf7e7, 0x4c8f, 0xbd, 0x9b, \
>   		 0xeb, 0x85, 0x25, 0xb5, 0x0c, 0x0b)
>   
>   #define EFI_CONFORMANCE_PROFILES_TABLE_VERSION 1

