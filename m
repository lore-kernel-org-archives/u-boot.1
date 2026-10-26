Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CC5606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NrQ/f7Yn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LxYD04Tb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FB18407F5;
	Mon, 26 Oct 2026 17:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zqlZuch-1gh; Mon, 26 Oct 2026 17:34:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0B4D407D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793036089;
	b=eScEGvDLq4mqWy9FlO163VjjYzXpiMfwLF/Khi2luQl4BpW1bWQfLuoEKnVHz/4xds3D
	 ki3gdTGG3VTRc8XLZJfQsxa871MYvgHooI5nBhGQgJyto2CGGbFuV6Xg1dWJZdTwGKnrq
	 febrHgnEkvbtiUydTd1uN7WWqJUmOZEDGCBvDUL4ZT/HlAMAtGMYVCNMhEMbzbbcZUpkA
	 rw/8DRAkvAIn7v5lewClOHpyg1WezatfA64Rc9jVid4NurhexpFkt5oDLHlegMNeHiHP7
	 H3uvyrzWulmKNQNrcKHPYFgItS9FA8JuqG0fq/eHDYMqt2yFsNlnBRS0MSV6iGImR4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=b4XRL9ves/VttGzHSbnFKI0PhUkuir/1ihDZm2Mu3+M=;
	b=JNN46KbKHH1tq+WySdKOG8wc9lTUTv1Y+YDsw80Se2gNXgyZpQJEHSKkOQ60N/8xIfrJ
	 62FRVfXm+4JxxAAxSQvyqCd2u9i49iZeX3umzutdtsI229xcJA3K3tAfZFz94YzsN0UGc
	 vU0awBXa9inRHr+EfdD4cFMJKG8tpejJmhBZWX8uNVBacpNpg3DiaI9W1hN16v6eI1zDq
	 g3YG0lvF3PxNc9dMe4BSrLM4L0dHD0vvCuZXAhYSHUk09R7uj7uGIaCcL/ziTXyAgatyK
	 Lb1l7IkubSUpEmFjwkB/zfeTpPrM5HL9bnIzb7QNnd2u8gEWGoMQPv6mz7LsZqdv77g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036089;
	bh=b4XRL9ves/VttGzHSbnFKI0PhUkuir/1ihDZm2Mu3+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NrQ/f7YnxR4nViapi0T32KNvZctOs5MnCaF5CFawPX6OHCeQjTUq9G6RWTp5oyn6n
	 4S/87Xv/fxYnKMjGA4/pw6nfGq6m/bEpaj0FFEaEHGaSgqghqIDiOAdkdIrtErgxXy
	 28VU6g0lRl/pSrWDs0zEf3wpKILp/TNdowDM2LZKFThK7e7LmsJVQAmTYQUFEo39yl
	 i2GMbjmU7i1/onBqcwxZgcW5Y+kel9tWicMmTcLo1GbVBylywjmmoH11j4DMhgppef
	 nQ35lZQfJoYuSKXQzITcK4GP+6ZeUPB7VhXxVZSoie6WIqMJLQsIWfGWIWezh3rFI2
	 hVrxmTz9GIaqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0B4D407D1;
	Mon, 26 Oct 2026 17:34:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 47CF4356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4568A60612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52ltg7vxbSAt for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A05EB60607
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793031989;
 b=CdxYGkIZ8sOahCUjz0UeWpWE7V1azM07DnkHgNUhUd+ZPgPJaMDCyDW3x8K5QJPKVFUE
 gNOecRQ4/vYUFdmTVfgyEjxMkZYZGMiPnpXfsMB4MPgQjQ179isPGVCXn6I0AjcsKaNj+
 2EmF/et6MvxuOEXiCrr4CLtAwSIbV8W/yOJlW2nKKc6WFXD9oIyz+AvET+99I/u5q6GPR
 F7C2ndB1b+I7NTQVKCkxhQJJVjWhFZvQARENq5QCAOWY6u3LgQk0739tiRsOOPkr6tP2k
 J+5tQeJwSnk1yJjd6cYo+vxt6T5xjjcEH1JS87KOQ/sgGCr1GNe94DglGlnTB26/HCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031989;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=b4XRL9ves/VttGzHSbnFKI0PhUkuir/1ihDZm2Mu3+M=;
 b=DRdYroH7dUKzIXFYYLFSPdo6olG9Kcxlux46uoVyjGM0AQVzWbIjWmB41ffYPk1+b+yD
 26mycgyj2+8gHcuXa+nj/hrTeRpPxVMTuG42s8Fj66/eUjSeWbiLD/QDyrAhTwXUQwV8h
 LRzy6NUfHU5LMXaLdcPYdCHi962R9M7EMtZNT41Dz4tDNaEIHF34uAhDuJCbxkQj3OY5m
 gBSUsWfBFqaT969wT1cTYfpKwZS5KoSHMrYth7Hjg/tm0OsB+kVS6QJKNBY2uzqkX8f7P
 K9+RO1SL6Nz1jmhY3ACvTRQtJ5pwwmX7UGqxroqmuBfh9sTFvwFjN1HlmYxIsswyPsw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LxYD04Tb; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=LxYD04Tb
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A05EB60607
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:26:28 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so1777764a91.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793031988; x=1793636788;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b4XRL9ves/VttGzHSbnFKI0PhUkuir/1ihDZm2Mu3+M=;
 b=LxYD04TbpdgndFwXUMTOykt0/Q1WX0Cf7q6flh9JfxD+t+DsiRJQRqpOwy37utlNtB
 /QjKsQ7BYrTfVOcw2j5mYHFBDFFKI6LZrXRcm5IA3r8Y7VJ/YJUvPSPvL9PIh5wg8lG6
 l4mP0TQOVCJHsYOptKdO507L4lh2A01d5fhs/1WWFf1kzUNlKFhNP8w7iI9qXk76brvp
 FLo5n9FX+dfVT6JlWrOLWe7a4u2dy14y6+IPwWgwfZjG8Kmy8BmccwRFpM4r4W3oyVo1
 51NJ/RAS/PL526m8aXBorQJmi7xjO+w5jxc50UOPKFnOjqSIY3t5fhVjyVHzo1k8mJpA
 9o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031988; x=1793636788;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b4XRL9ves/VttGzHSbnFKI0PhUkuir/1ihDZm2Mu3+M=;
 b=eIWygYO7kshuRFp9gXEH4ypL92WTJe1rPvXZfbxM/VEMHApcn6+p5wXUWSW9DT4QiD
 SYc+fkrfCWu2SGvpKr6CAhOta/dB15NFa6ibqQPTHmCqnr5Z7FcQ7LpoUlnWSJzDVAoe
 dbMTsEM3W4D4hIkT5or7BiqxLNTIAuEaso8Vf6o+lXOdyj3N56GtQWgjl1yK4L/p7Yx4
 fZPTbd66YMiQR9U1OteVJ3U7IrHD9gJ55BEw8X5iPJPktGvUDImu+tMzmvmQ61qdDrZY
 wVix/weAE4POi9SPPMiXcZ5axHxW5bWY64XQhBiblkujlWkzOnpFRuiYJxYaseDldX+v
 tCUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLlOK5AAIV97iyor6LPj/iXKVPZop757J+J0bgf4yhZxMnZf32RaKRuLxYpeGPyDkUw5lnRZY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLjMcuvomy5t2TEff9NbSjcElOqcg+utW6O4dqC4oudASoGKn8F
 77K55qQF6FqVpOnbWhwG/QDbc7hqGZNnyOPiIQkfG4qaOZUKrOnAxOZH
X-Gm-Gg: AYBFou0i5tsT64lLcLZPCPaAbPMyIYvUj1JEeCzqgQLQI5gZ9mcZi7iY0ejSAfeK+gz
 VVyqD/1VBUS6yw25g7Xasr++C1hWwFRnD76CT9Pz0c27sdtW+S8p7BmkPdPzYAPFoLFAPQi27/K
 YcM/3pdmQS98ik0gXBLbpAFGfTOT7ZUj+gUDBIJu8zgFNQRilb8YSSM3Y9O5be5gYpjkcmCvyTF
 /+IL9Jvnfz5712yPX3GpZX9i2bL67di4wNjClFYK/X/Wl1qyoaRcVHf1lKg1TqEQ7x3rA53OErC
 pAFZ0zhFqL8bWxknWjv5hU8NgMjYv0cDdoIL1UNYJeY3qw4lBV0KWYE4whkzVFEubTk2u8VwXrM
 6vR/06FhJs2VollI7+flfRFYLUiW6LqJMV1e9PMi12Wa3UeFkN3naSqo32uBB58Y0lVGon9UtSJ
 YmP0abcqyg7255xoWAmdthJwpuWo1xtpxlNnmRnN0G4khMmbehkhnXMW+7fqrFc8r2XWYIsduKu
 oNXK3Q89qm1VewqTC8Fx2ZjphcDO6SjgC9ewwQWys/I0syz+1pDQ+CnIOrycZTGAbtlkS6BjMZl
 yVk=
X-Received: by 2002:a17:90b:2e0e:b0:3a0:c85a:ee02 with SMTP id
 98e67ed59e1d1-3adead2f2a2mr5854978a91.17.1793031988248; 
 Mon, 26 Oct 2026 09:26:28 -0700 (PDT)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae4066cf2dsm73773a91.16.2026.10.26.09.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 09:26:27 -0700 (PDT)
Message-ID: <b8e88ff6-23b1-448f-9e5f-6f045335c51f@gmail.com>
Date: Tue, 27 Oct 2026 00:26:24 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: onboard-hub: Add support for VIA Labs VL817
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
References: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
 <20261026092432.769146-2-alan.tseng.cs@gmail.com>
Content-Language: en-US
From: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <20261026092432.769146-2-alan.tseng.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/10/26 17:24, Hung-Chun Tseng wrote:
> The VL817 is a USB 3.1 Gen 1 hub controller with one supply and a reset
> pin. Use the same reset time as Linux.
> 
> The Milk-V Jupiter and the Banana Pi BPI-F3 have one in front of all
> their USB ports. Without this, U-Boot leaves the hub unpowered and in
> reset, so no USB device is found.
> 
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
>   common/usb_onboard_hub.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 0684f7bfd..0ed70a6ba 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -289,9 +289,21 @@ static const struct onboard_hub_data usbhx3_data = {
>   	.supply_names = { "vdd-supply", "vdd2-supply" },
>   };
>   
> +static const struct onboard_hub_data vialab_vl817_data = {
> +	.reset_us = 10,
> +	.num_supplies = 1,
> +	.supply_names = { "vdd-supply" },
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
> -	{	.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
> +	{	.compatible = "usb2109,2817",	/* VIA Labs VL817 USB 2.0 */
> +		.data = (ulong)&vialab_vl817_data,
> +	}, {
> +		.compatible = "usb2109,817",	/* VIA Labs VL817 USB 3.0 */
> +		.data = (ulong)&vialab_vl817_data,
> +	}, {
> +		.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
>   		.data = (ulong)&corechips_sl6341_data,
>   	}, {
>   		.compatible = "usb3431,6341",	/* Corechips SL6341 USB 3.0 */


It’s similar to my local version :-)

Tested-by: Zixian Zeng <sycamoremoon376@gmail.com> # Babanapi-F3

Regards,
Zixian

