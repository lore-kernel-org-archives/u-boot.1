Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465FDCCF9E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED33839D6;
	Wed,  5 Nov 2025 01:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WubZwVVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32459839DE; Wed,  5 Nov 2025 01:48:33 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C81783981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-63f9beb2730so3771510d50.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303710; x=1762908510; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Yj/477+/gbw2CC/CsxaUBC75ENnsKpAqtfA+/mzjNE=;
 b=WubZwVVg7FhN4XpThByhFBA+m1rfrmnVPBzIrjEMsA/+5a3T1e2MbN0VSVK7WzAya1
 TeWRmKgr46ZZTMlgkeYp8sOsTdKGM7uAJO6Z6xYCMUG6Gby5VgghduV/YZ4X1PFSQfYF
 ABZix88pp5qlYR+euyasR6JpkmsBaGs3UbyH6n7lRj4W1OdFIcA+x6sR8xMrkaMOUqNz
 Alb8CZTUB50be6Ett8vcbJYI9VIYQ1/e8Y8zIQmGnUU9kiTVShv9buApdkLbqBWePE7X
 67IFBxGuwMUd8bzrjjb4ZT9WE46ZyJjCBuxfGNV+Y2axNbShAkyxVOREdm4pZ1ut079A
 JMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303710; x=1762908510;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Yj/477+/gbw2CC/CsxaUBC75ENnsKpAqtfA+/mzjNE=;
 b=WkHKJ/ivRwRBhsAzWU9Go4X70FCw1kaG0elIwtlyOYVEEW2QaM/SlKc2AOIt1X++IS
 G3e32Gp2scLpozpBlZv2qkgMaclxjRu4yW9w3gp9gWuk4XNjYzSk5klc2ySy+PUyHmQV
 LPga9+GW3H5zwaLKDXOqO5PAajrFxdoh3t/ooNs/mrNUutxMHPJsEoFzzS70haKe3QhN
 9KeNCxqU+okDuMaz6lAN8vPqYAJvxujzzxtsQZed8jcugQIE+weQTu3ZZk9in2fyVoE8
 KihCR5jI6w5LJQni4+VH8hzsgGl+Q7v6jIuisjYFvBr8w83mFgOZofbo6lklkJzpBOw4
 GJ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJyOGs0qEdDEvfIFfOiYa103kH6/l/pYj7K11RW/lYPxU02MX5Q19BQ5eJ8hgNQNDfKL4Qi+s=@lists.denx.de
X-Gm-Message-State: AOJu0YxIDj7JbgKDJikWCKrAzjkHEDddZIbMGujE9MQ36CdMY85/EmFE
 EvXX69iQaJKb2tgpnhnOqZP8ZceN1tOaK6tIO0V8RN/PWLCy0S/hLknhWs25MLqI+TO+nuEXYeo
 3PIY+r6cDAXY6OAFzdtxPa02bVUSG9Ik=
X-Gm-Gg: ASbGnctQJDfpJYuHh0LP3KLFtgvV4HVs4uxnd8HKRSfpcaeUaxTtrRiNZU3cxMdP7aw
 BgfqQ6cccWYm6c73bQ+nCAFV/MYbkhCn9M0sJW4Ed6mVlYwM5hruUtyk+8wPE6UhXMKvjkkvoI7
 LtkV19YhXJ8JuQhvb0bNos/9PIcWSSXpEkmEBvdD2pdFgj4uFJtdM3dIuvs/doIsidwrTc2aW6T
 hSzlIWSfAxmPdM+uhDlvIREiDij25TGWyZJ3n8CsS3bAv1Ww7QVkjEHcodT
X-Google-Smtp-Source: AGHT+IEap3QEhcJmE3EQKWzH9c5dz7aatS0FJk5CJ7NnpfZ1VhUfrYSValxNkx0dINb7gNB/rpBeahQcIM1buog4jc4=
X-Received: by 2002:a53:b10d:0:b0:63f:babc:dbe4 with SMTP id
 956f58d0204a3-63fd35856bdmr1025412d50.51.1762303709872; Tue, 04 Nov 2025
 16:48:29 -0800 (PST)
MIME-Version: 1.0
References: <20251104225636.49890-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104225636.49890-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:48:18 +0800
X-Gm-Features: AWmQ_bk7XqezwJbENyMtr1sW19hM5jIx5jBy8xrayj9xb7whdFBi3vQ3HXu0484
Message-ID: <CAEUhbmWmGfuymkgq-gyadokLVQF+orWo0smx=EnS86dDEG=OVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_driver: typo 'to be write'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 5, 2025 at 7:03=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/to be write/to be written/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_driver/efi_block_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_driver/efi_block_device.c b/lib/efi_driver/efi_block=
_device.c
> index 070747de515..c389b1920a8 100644
> --- a/lib/efi_driver/efi_block_device.c
> +++ b/lib/efi_driver/efi_block_device.c
> @@ -84,7 +84,7 @@ static ulong efi_bl_read(struct udevice *dev, lbaint_t =
blknr, lbaint_t blkcnt,
>   * efi_bl_write() - write to block device
>   *
>   * @dev:       device
> - * @blknr:     first block to be write
> + * @blknr:     first block to be written

Or, "first block to write", to be inconsistent with the next one
"number of blocks to write"

>   * @blkcnt:    number of blocks to write
>   * @buffer:    input buffer
>   * Return:     number of blocks transferred
> --

Regards,
Bin
