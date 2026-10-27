Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mBvnWzWE;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mhd2GZqN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C06B4062B;
	Tue, 27 Oct 2026 08:59:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id czbnfZH1K9yx; Tue, 27 Oct 2026 08:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68F254065B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091561;
	b=WpxikOy3blZhWgJFVThO07zBFGMcPc49m7U+G4cXMixggydcgtcB4pwUkuR6X1MRWSdJ
	 brrWkyjczx1x4DzrJ1wUKJc9zuLMjD0+grZ20QRgjqgkR51gIxfKDjj3jtaEa1Xh3YTtk
	 YOBNKeXrEaf0N2IDaiKiH7+58YZ6TKINb3t0vMuuokJCH5zD/Wvkthq8nTfgvHyVtkYgB
	 Xm+PlCRqjVM2DbFcV+kFOARrCsIvA5Z8BwA897aJM6lM+eidUqXUN5cA+934ZdOR96UVg
	 6QaKJMIV7z7hKLQ0RUlokQ2dm+n3hGOnvr+1qjr7vQXOxmBWZBXl7YdwudKCtDcXpRA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KHsZO3rFi24aJfK27luT+9YiRNggbTrklTnUbRD2MzY=;
	b=YOwhs/tCqux3DfOH/nGzZXhuYVtYfCrHChEVL6aNSNyu5clQRexiAV+7CQiRwq7gtOdF
	 VsO8NvmCAC5d4fOGCh0WSI/z88q5dzllexWhslFAuQyyppuUqN9sTgBgejzVxBjGMQOWA
	 p6s0mDP0aB6sCwtSvQTg0wspibHZKt0dOgvEpk6+/dXho6WoqqEaGbzN/FAjrEP/dz8uZ
	 ZjBZrQaY6S/VzhH9tIXGGgE+LGDVTdx15/MUofkI+tfJq9cbDv81LdhYlLR+Qy3INqi0K
	 I6lfJrTtQ8QDULdt+EwIKRPJRx2aYgqwNhXud5FqOeovK/GwspMMNa0FchPu8wObo2A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mhd2GZqN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091561;
	bh=KHsZO3rFi24aJfK27luT+9YiRNggbTrklTnUbRD2MzY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mBvnWzWEd48wvD1znDgUAJn9rUucqWFbBCq85j76fzcgfug29nBFOoOR0WA4VKwXH
	 8Z+wX3cdfEnIzVtqmyRd+M6/Dephumh7GPHjpCwi3fyMdcnNvWbWLvp0MrIMbgC2dh
	 Xi7vv2v+AZ8Z2zcav/pfLb/M0UyWItcUaFe5vs8VuHVyjrmo0C5qVMHNeTYegmhxQs
	 0GhVA60jD6E0mCNAEISbCewp0wYFYsM6IzlxID0uTsnzSSL356lf5gAm1q/FDofm4s
	 ye+jUQOjJLdfxhvHYqe9IwzY84qPSQrKJ/Va62JQP12CHUzCk9LmnMektK1cfUogvP
	 bccbZD6ptL2FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68F254065B;
	Tue, 27 Oct 2026 08:59:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 299414D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0980D406B3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rx73p8egpOxD for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C50E14065B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091559;
 b=M3PpbOVJNvGrhlb4Uk5Q2vxD6dsTxalX5uGNTMYXi4jnhKay+z0rIIFSe5ogBlGOun/Z
 k5kFl0s8yQ0R6RhAuMDbhFXvPnHy/dT8Wci/eGFGGUS+TGv0nMEikJ2tl64bK8qVDhEsJ
 uNP1N6to2d6pk/Jw/hWNhKMP0va+lyPdpFgA75DO++4FC5SmBDrXgh9yb8fHP1FNKemxO
 onxLIefdK2sEJNu/n11TqqXVsHLu7+TjfS0j1eOKJK1cp7+k3Ny8DFL0iP9i3IM3hNgxO
 9tkt2noUZivHQ3zW/GCcvCDXeqB1LBdgBsnQlJGTmtIFdOFGJHRXVEJiV0jyku+cSTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=KHsZO3rFi24aJfK27luT+9YiRNggbTrklTnUbRD2MzY=;
 b=Tt40lnNo6GhhGNDNB2x5Kap+RDwLmxZknHIf6vQIhnQa+7+td+DnueOc6Gq2nPHS9b36
 YZyCiTMxdf+kUIJpRq9MkuAxGx3uS/V/AawqsHUNevY0yXS45nLMRIC4grgekXSfxymmh
 Ro4d1KJsbhYPqLciEQIQbH75GTrifPna5TI62I56u87EG1U9xsupZdK5StggHBA5l5ovU
 CleECYadxMSHtFZ+IXYccD0Myl7xIHHq/CHOlY+lhkPqlGexD1GDRkyRPzwmaAeYrdqTL
 8CqgkOqLvv4TEd6/z7uJNzdDdr7pcyz965t/JduHmYo+Hc4ZR0dWeIBd4pT4uUY2qLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mhd2GZqN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mhd2GZqN
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C50E14065B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:18 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so5953957a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091556; cv=none;
 d=google.com; s=arc-20260327;
 b=UQaUm1WHEJBXskKxi9zmTDEcYozPzGLKHeHp/nBsiSL6WsBp1inFRAoqs/uW0QP5ao
 oZYJlO3K3/g0CtfDkk3f1jQKprOA+CcDJ+jFgQjjFmOxfby2i9ShfHxLVzucfBKm1VCA
 +lsQ/2Ya9wjBT/Qwzu+thhbXwTDjYX5RI+JAzmY7drCVLTevcys7fcDUWsYYs4Ex2+L0
 Tne1gd3oFonQxUlPtI/z9GymvjGfvk4obLitMpmI+KWSCcJyxaRNZ+hb8zmEt5EL9yVf
 V+ZVew2t4fFIw0Be0Kt3T8DvY06UKoxhOgE3/VYzAoFY3WcJdTkp+9tzNd/rwbMkOVvz
 rRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=KHsZO3rFi24aJfK27luT+9YiRNggbTrklTnUbRD2MzY=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=OJW9YPdD1H49st5/2kyn2whDdTyfJL1HvlGx/kNQqEQfi/BUl0rFqPujUja7AVXu+d
 /aBYsU8KTuwWbjFbFNhhIjTiKZ7x0holkYwZpvDnjwVoX7dGf/WSqapJ/DSBij6bJUxo
 C2VT/NRMELCepI4lpMyo6axaB1dOZ0IqcCAoNpczCYgAaF71YaSHDVN+T5fiQo2swHyT
 3uMWl0kXsSrNoDJblzgrUIDDwbk7xPwq8iF+iWQFni87igeG7ZUgo+AdoViAH2K4RoAY
 APlBYaCXaN/2CKJVobtAnB/Hd6Oe/f3sQounT3wgdYLmsye1SB438iHfNHqFC/J25yji
 alEw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091556; x=1793696356;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KHsZO3rFi24aJfK27luT+9YiRNggbTrklTnUbRD2MzY=;
 b=mhd2GZqNZ5cWoJ1vuX+lz4dbgSkFz2oRdfXOtTIubstT7TbXaZTXyedn4lRuEjEJUo
 jcOZoREfTbUqh8kRncdaHdVwQoFJzdE71JtS2gK9r834xaPFO8fYsOND1hinOggjVTf/
 INkHWPDXc/Vvduma8O5vKmXv3yC/qtjvXbJEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091556; x=1793696356;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KHsZO3rFi24aJfK27luT+9YiRNggbTrklTnUbRD2MzY=;
 b=pdBZfksZ7Bk0JWllKyPYclpqSYPToDUyB5HrWA5eJxXZotqlNrAvJ6j6MUYyRzAKaS
 xr/mYWdkSSSNlBhYfcf+ycuRhnt4b6AH48eCRnS0OuSkavmTz30hhiGXqjsIIgCZdVeD
 BCNzghrKfAB3FFzNOMbwsINTF8FTe9zC20+hCCxr1Xo/tOiwjcvIBylGyNP1zQiBh642
 ohqtWYaAD5SAwvpkE9ITVDr6yfw3AQGjBIOLep34G8wHjeb/dxpg98QvydVlcx+/OOZ8
 baU+Sohvr0FXteqHFpKMmSpn2yLETMInd1WWOkVXzEG1GyYQvd7eQF091p96k3pBuqY3
 bXRQ==
X-Gm-Message-State: AFq9FYKS9GLo1XjN7vXc6iYDHol7w8d9wfkoOCjcAhxTwzuiKMn+CBL2
 juGDPkHHgWlvMEFgQJ3trjIzFPcOk4nJ8S3MRLxAYHEN1IrTa1c4W9I2O78pgGnIiED5tZRLSkp
 eKdNxkRXYVzhPW5pYwO5tkvRknChbxob/JMrV4Gri
X-Gm-Gg: AYBFou2fCHIC+gOZdN3t2zKNR8TbPlbsku5k4s+s4Hwa1EnvSCfHPJNo2z+mpgstt7G
 WdCtrcI3BgTbFxF9DS0xb5DWa4kUuqHk17llKRrWwIhjDPAAyPz1NFgQ3mRA4VYyhl7kNSt5YGM
 d8R1QEQqNswF4cxCCozk2jaEsVvJ+EwMtvigpkExnXS9Q/qgFoSrimdtBSTBWHJ0ju6wWn8i3/W
 8mHBKpc1DzdAnf1RIWRMUdzSy3o1KrIXU2CSIWBONzUNx9G75pHTW5Lfc77D6XBgk2hyGl0xPxg
 ftWzcdwuFrzre8jTsF0+f+5WQ97gx8iv3EvjjFl3FWe8hvSwk+cKRy+gDpCKAcusMvs2qM7J9HN
 ibl0jx854C8nBiTJef2VA1qraAk7LyP4l47tT6Qlo/XoK9GCCylKlhfNs
X-Received: by 2002:a05:6402:5630:b0:6aa:1112:62f2 with SMTP id
 4fb4d7f45d1cf-6b442fcb0b1mr7634357a12.15.1793091556318; Tue, 27 Oct 2026
 01:59:16 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:14 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 00:14:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <85b11418-82b7-4951-a9ac-cc014cd1c92a@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <85b11418-82b7-4951-a9ac-cc014cd1c92a@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:14 -0700
X-Gm-Features: AclHuK-BT8PT8KfEmfzFay_vvudzYLoNB-fud699UwVSSiV5Xc2zoQhQGXVKcS0
Message-ID: <CAFLszTgr9=w7Z_iHLSL2iEVj=erqk+YNVNM9afMNved4hCZZoA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/9] usb: storage: Refuse a block size the block
 layer cannot use
To: anabobillo3@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> usb: storage: Refuse a block size the block layer cannot use
>
> usb_stor_get_info() takes the block size from the READ CAPACITY reply of
> the device as it is. With the block layer now refusing an unsupported
> block size, such a device would fail to probe in blk_post_probe(), and
> usb_stor_probe_device() would stop there, skipping the other LUNs of the
> device.
>
> Check the block size where it is read, and treat a LUN reporting one
> that blk_valid_blksz() rejects as unusable, as for a LUN that is not
> ready. This also covers the legacy (non-BLK) path, which calls
> part_init() itself.
>
> The fallback used when READ CAPACITY fails sets the reply in host byte
> order, while it is read back as big endian, so on a little-endian host
> the device got a block size of 128KiB rather than 512 bytes. Set it in
> big endian like the reply it stands in for.

This is a separate bug that predates the series, so please can you put
it in its own patch before this one, with a Fixes: tag. The capacity
changes too: before, be32_to_cpu(2880) + 1 gives about 1G blocks on a
little-endian host and now it gives 2881, which the commit message
should mention. Also, 2880 goes where READ CAPACITY returns the last
LBA, so this fakes 2881 blocks, not the 2880 of a 1.44MB floppy. That
may be worth fixing in the same patch.

> diff --git a/common/usb_storage.c b/common/usb_storage.c
> @@ -1512,6 +1512,10 @@ int usb_stor_get_info(struct usb_device *dev, struct us_data *ss,
> +	if (!blk_valid_blksz(blksz)) {
> +		printf("Unsupported block size %u\n", blksz);
> +		return 0;
> +	}

Since the point is to skip one LUN and keep the others, it would be
worth including the LUN (dev_desc->lun) in the message so the user can
tell which one was dropped.

> diff --git a/test/dm/usb.c b/test/dm/usb.c
> @@ -84,6 +84,51 @@ static int dm_test_usb_flash(struct unit_test_state *uts)
> +		ret = device_find_first_child_by_uclass(dev, UCLASS_BLK, &blk);
> +		if (!cases[i].ok) {
> +			ut_asserteq(-ENODEV, ret);
> +			continue;
> +		}

You could add UTF_CONSOLE and check for the 'Unsupported block size'
line here, to show that usb_stor_get_info() refuses the LUN and not
something further along. This is not blocking.

>
> Add a test where the sandbox flash stick reports an unsupported block
> size.
> [...]
>
>  arch/sandbox/include/asm/test.h  | 10 +++++++++
>  common/usb_storage.c             |  8 +++++--
>  drivers/usb/emul/sandbox_flash.c |  8 +++++++
>  test/dm/usb.c                    | 45 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 69 insertions(+), 2 deletions(-)

Regards,
Simon
