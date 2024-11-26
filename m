Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9125CD3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D23A89657;
	Tue, 26 Nov 2024 10:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="k3ke6UCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682C78967E; Tue, 26 Nov 2024 10:23:03 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C23A890DF
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1732612975; x=1733217775; i=xypron.glpk@gmx.de;
 bh=f7ooIiRWG6xzyqSeK7aODmZGrpa/qwtcD79mXe+HNMM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k3ke6UCYWg5w6K5cgeZTli5KyrLZFBSIyp09702kDBqKR4qK16FSNv5hbBihby8Q
 TQ0SzuBqt8/6dKJc/Lw64dpFXA3P+ZBq0vu7KPFBtWk5+/3xoqPKhqJxs4ij/hHIu
 S6B/J0pSXhVz5BIKzw44E4oqHqE5iU562zIaEP4mwYN3KG1Sg64I2YpJ2TcL8IXQ+
 /iIN+iCW2EzTaBA8oplXx/bE5USp2XX199OBjy335cCZSHlbyOdinQuffnqTJImy8
 DfFPIO3xp8f956R2KwlSLmCQIRYePqlMbIymEBCPXDgHvvrMh0JBVNZPirux/L1MP
 OCvoIfyVZ86e9fC5/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1tJyO629GT-00EZgr; Tue, 26
 Nov 2024 10:22:55 +0100
Message-ID: <74286a06-89dc-43ec-a669-f4dd0a97fee6@gmx.de>
Date: Tue, 26 Nov 2024 10:22:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] efi_loader: Convert efi_get_memory_map() to return
 pointers
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-3-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241125204456.1525752-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o4/vy5fyjRebAZ0ODfOWk4T7F/D9rnMgGCaa5KgTyUdDBNKLR+H
 k/FyaPycQ1krUt0xSQlTFJoKoCZABjoDCa7CwVhEI9uoiS+cBbuUQBG5IN07U9Z8+tpxZj6
 zUSDYWCKTb2IXTF8ke2LQsP+7MemUaIHsD11JO+Q89ZHitOV/sSJxUliC+DturBxhVU2tf2
 QR/FmWlYB2gx6XAD+DvZA==
UI-OutboundReport: notjunk:1;M01:P0:0OjS8oOBM5g=;2JAdwUoaxZsDbBrACcvVSO2ZBNx
 /ce2XVP7tP1PQ8sFZL67QY9Z4mFE28KdT547uAJ0Q9EuuOmIM5rfJmVZf7Vw3WkmpBejhIoDt
 0SjUcicgiCEbQTzi39u5SqmX0GfSbm9L3WfDtLQ+x325WLfJc47hq4czXrOCPNA8cjk0ihP+i
 zcyB4Vh9wgGlE8fVdNXi5zh+mvSKQJxMOiB3jnyUKx+raXUAh2Ix0IrJ1//pTa+fxDO7JpduG
 J2d7IfQx09k0cCduf8OjeTjPFXSy0iDEt2yt7VANbnGI3lXMZDJEG6mR+GuHu3BvEHaYmS54M
 HuVAibNDlTvVRdLXXlMP7b7D1LJaD3tb0z+y9D9AMNRrxSgtghc6b3vQAnuQiqf0tODH5RbJO
 c94Iz0L3cI9w9nr3W1JOIBh1PErGJLgj8F/eGhf3TmK1S6AvER9ktSh/Sqp1ROdeyMxoLbicU
 uAsCKhN7cSq6DOO4QiwRruNrBld8wTLawdnFGO0TuZ2Fy5meLuCBFnmAz72iz/JFcR4TrQT3O
 e4HRUQjTuA9DEMxaYo7L3JBxvq+IPgVqpvJYIdA2QlMwUTDX9YwUUochGjaR8edE+bsrS7Ht5
 0tM4SbCsPQ3d7YiImbvCZZXVHNXFIgxJoMy4AVbaw88TbebYokT6SkradroNQpC2g1lIxU92T
 Z6hFT8/AgmLJmUs6LNaF5LWGcpKvI/29H/sMAQS3CMjlECs+EpTBiPQWMVEoxFS9sVN/lwOlr
 SDY5EKdNLYzEqdUfS2576YEtLzGXWDmH3LesKVExfgvoTXSGnKRrRApyEAmYOCh4F5o+MHQ45
 8uVYeHUiVBT0sLY7YKR2Zvp1bnj3ElMZX425RrXhP/kRAZ+32MCqzd67OqA7q+2+mY9AXv7Sp
 1y9/QKrpVvzxKue/X4srdOARxudjWtL/8RXpY1+BIC6zxF/MPstf67bBT4I8V1XwDsTWk6H9e
 TVRJ1IoaBAF93a+mSXvj4Z3jhQEyIZVCJ/+di9SqfQn7dA5re6TykADH9/e4yhkM62PGFY+RA
 bn4KKSLCPllwuHFztFDFKI15f0adRL2WyqxUU5ocJp/y44rOagos5BCvLsnQ2n0SMFrlN9Cow
 nZJKVNgmZ+BrRDvTHLmPGwtTlC50J7
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
> This function should return pointers, not addresses. Add the conversion.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/efi_memory.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index e493934c713..8b01821a993 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -748,6 +748,11 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory=
_map_size,
>   	memory_map =3D &memory_map[map_entries - 1];
>   	list_for_each_entry(lmem, &efi_mem, link) {
>   		*memory_map =3D lmem->desc;
> +		/* Convert to pointers, which is what the caller expects */
> +		memory_map->physical_start =3D
> +			(ulong)map_sysmem(lmem->desc.physical_start, 0);
> +		memory_map->virtual_start =3D
> +			(ulong)map_sysmem(lmem->desc.virtual_start, 0);
>   		memory_map--;
>   	}
>

NAK.

physical_start and virtual_addr are not sandbox virtual addresses.

The sandbox virtual address space is irrelevant for UEFI. They should be
restricted to the CLI.

Best regards

Heinrich
