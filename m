Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04518CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 14:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D437607A1;
	Wed, 30 Sep 2026 14:18:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9mpVZuLzbsy7; Wed, 30 Sep 2026 14:18:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E58A860A4C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790777923;
	b=Ncr0l+/D1nsxqIw6dv8p0x2yUNYk/AoS1HkjScqBM2mUFBGOXQEQmsxqU+9I7zXS3HQn
	 Gcikk5IGhMFtHT5OjmVuNc+58iYwHqvqFUM+3ODfV6PqUeQga1fcyMhwzeo70/ySQlfSS
	 cHsuI4CCP+pGyLBaE660M2sb6sVlrH/E6o8YKcVW0Vde5CVRWhhzQcW/sfrlqYo1tfpw0
	 vLbxCQc3yvV+2z0abG03ul/fgiQICt6b9OMRfAKf+v4O4EoY1nBN9IsMhewh+3sRG7QvA
	 b2rAOnYE3fH3eKLVDTacjlcC0fsZwvKt/KbsLjA6C8ed0BIxR+oaCt8YFVeIPCMrT6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790777923;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1CaXnlcoxnecj6wdWzavq3wSOuzPv50wOiwuPqwvYcM=;
	b=iEmq43pUW8KvWV8av5IVK6Uikwmed73zbpTi8zqF+uURUNZZg6fBEvRUKXUoZxaBrpTS
	 CQ4rfKavGCa4a/Ca5Tx4ZJ4icUwi0Mcy5g50b+7oKU5p9Oj9vj58atCY2VvOW+bBAv9I7
	 mWlXlLXNWN8TszbJ8qf3rgOH8doWt7zjSv/qlcWrFBYwjwKsNYGebiHhKC8k9ku4MFkCn
	 kjiJOTmwCxwN5Qt6boA60lgSLdskb34XwP5v8lZP+WeLaFlEIo2lXOutDMfoR+a0+G4wa
	 XY+7dOmLpZ+O5qs3PG0R6gLsLDQFZGc/eH1uH38MJ2UI/1Vk/YKyoFFsewu0+bYfMCQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790777923;
	bh=1CaXnlcoxnecj6wdWzavq3wSOuzPv50wOiwuPqwvYcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1sxJSoLf89Fp8MailGHL5H+t+SqntJAZWgSdtl9aCB4iXNBJrBA7W6XUoE0YNrAH
	 FgKuVrNlbuKdNaEX348KSAxo2PLFBr+aQn/JWRg+ZqFabjAtCLDVpRCjmGflATWYUa
	 mtYf7r3j4Ggpe8Hp9pAmEIrP7fQU1d8NDHhqlo/BMMBjUPnVyJbkfNowcSosWVkAbf
	 ZflODuF/t3I1ZTjtIVkdMuTzGI8sfYIylrO7OtOtN+JjYlko3WZJGCeIkzNNQERfsM
	 xPC3NRJ3Xt0rsEUUyOi7wsqf3GgiNJCg0vlZS+MScrSjpqKrc7TnRPnjPwUdcv8szN
	 oJyPizClwnrIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E58A860A4C;
	Wed, 30 Sep 2026 14:18:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AAD9832A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C9014042D
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svv52YptPho3 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 14:18:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DF1B44009F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790777920;
 b=P50tJ6XuVh/FhJabNbWdk9gLMi2ZvnCzBYD2MckNAoMK4CK7dgXan9eaqijtcJqwNmQe
 KHlaFwJtz0Ro3mNWBdik7uN87ujWstzHZf55QwIfHpSj5tdM4yDemfS1luZaCS8oEVjQ7
 MAtAfRMEHfW/75MSQ5V4irVYakluyB/6wEiG0kdVchazDBtaR2dzQ1Iho6uhGRqyEfly1
 O2nb6BuhhI6iHa5/5jECJRizzfU1X9w6iR5YFliJadMoNw1196i9QbWabdmDHRHjNsp6Z
 bPPvdYhPuFZA/SpBpsAbTQzew+fvfHMpZ5+CtjJ2gVxPTZDTHcNT5XusINChWkU98Vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790777920;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=1CaXnlcoxnecj6wdWzavq3wSOuzPv50wOiwuPqwvYcM=;
 b=thMJy8U7J8xijhqUD7H3R+N8nEk9NkNN1o1QoVllyrgYrSYkBPd777L+945A8hIzQslm
 zWN0+lexPE300Zqcxmydx1bpikHApBr0OkyKtCNPXijYVtMd9HkNK9GTWeRYcZtOSxPYI
 el97cUjJog8brg/MQOvLRQ6BSaGf6WleTPi5yzyWgVtZuEAN9jA3vtw30EA5GvmJFgbW1
 mN6yTXOn+r/dioYxei5LbeaHnKeZ3+IkfPx9AMnKBgxl/5aNw2oXkaYwpuCF+IOyyOCGR
 /1Q3fesQUxLTe8+NCDSZioITpNrleD9HGoXgsCQohVD0pJdKMiTFZ7k/Qhc9RblytKQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WMmJ0zIg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WMmJ0zIg
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF1B44009F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:18:39 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6c24d19ebcfso2892813eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790777918; x=1791382718;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1CaXnlcoxnecj6wdWzavq3wSOuzPv50wOiwuPqwvYcM=;
 b=WMmJ0zIgx9You6/f2EY7iUkqFnpWSAa8eb1k3dOS6EonyYnvPxIyIH8hkdCIyb8OsO
 AEHDDExctcigSLXApBF4MHU6cIeGOpC77l+SkUirbbqI6NIKirYIXVMp3I6GUfqB82ij
 w+F824tP652J8fnBLqS1H+NS6p1B0uR0Rbm40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790777918; x=1791382718;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1CaXnlcoxnecj6wdWzavq3wSOuzPv50wOiwuPqwvYcM=;
 b=Uq4Iea7Nq2imfBas9O7+dtN2JV6KV+ysqslWu+wainVfOygbuFr8QuSmbgLuwq1i0I
 MSOtZrNPyNjdJEn9+BAKJl8VK/enYLiNMuf8dt10/yUmLU15/1fqDydfaZTM5ZHm9Dm8
 aoPrayGRrcfkHO29vYK3nfJV3wFp4qtpzzwQnmZJBOoInTPIPVZCFALK3mb7z5VWlIZJ
 rKkKNnctxFPedj5+3w2E8HEIFqC2bv6tQ9RGpSt2WBhnUkaFLN1VmP+GVlW4BUHkItNH
 fgff/KKTQzTHOa5QXsI1cPUpV1ajc1zEhlXP9RNIPjDrAKrgwLTQFSvZ/gJqZMpCimZ3
 C1yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUROQrUmKkqCz/6QHSmL+6dcZV14Ws8QT+wSWCP8Q1kryVOBzWIzInFK1NA07Ht6TUqUUalh0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kOxM0OVnO972wHsqnOQWgHs+A1pDNfBeTCf3Xh8GvmF4V2TfFn
 Y+ri1UFAd5rpSG1A1UbMm1K45Uc4Gr3QiYenjMG4XxPUbleHlHTtxyRoLh1RSfYxMv4=
X-Gm-Gg: AYBFou39roGza7JTkGNEo+Bq7EmFPOc/s2z0ES2LschgVInpbWxX4JOyM2GTrNpfWfK
 4rh2N9uRJIyU80Vq1Zol8ANCO5yizFm8xUidDFbK3SEVCxnT3BJmk5wT/SGV6kW32szJVOuIvUN
 xOj+cvllrUnRqk6bbOAkLNiwnyKeCtJaP7wQQcIXOd0ogfEiholB6Q/yWm/OHkY7cnZNxmbNxtC
 JtXmpTzw1RVpTy2PMjiyGADUC08ua+sIDU6Eztu3A2rKc1ISi9wKpYrPnZhSzwwxPJA8Dog9O2X
 rLxI6FnSoF387Z8Mli5a0OAsdL/M+ClsuH/xlAXJ9qMAi7fW41/Zez/Ms4IBXfWGOFZdXpMKdNj
 m6eQPPaVrTw3FfdFv109rVkvvA7/acgjwR/i7eiph9C7UDCpiZg5TyYUEJPXn0pPTmugHhZw0An
 7Q4CjeMeH1+qLR+7y4rcG/CBxy3GoAMAdmXdqQXbj/fOscLlQczDqrwNBOIOl0G0H8UaCgkszDB
 K882zxUNUzyFzHDdZwAnQTv+7roPRMnUi8sFL/TR2SxwCkokzI46eDs0y8x7qkEfwBteZCVpBBL
 FlrWg5C5vJu/cO3M+Efx
X-Received: by 2002:a05:6820:c0cc:10b0:6dd:92d:3f2 with SMTP id
 006d021491bc7-6dd092d04b1mr941859eaf.16.1790777918455; 
 Wed, 30 Sep 2026 07:18:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-820631cf6dasm923117a34.13.2026.09.30.07.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:18:37 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:18:34 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Liang <leo.liang@sifive.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] lmb: Add StarFive JH-7110 SoC as requiring DMA below 4G
Message-ID: <20260930141834.GF858934@bill-the-cat>
References: <20260929230758.616924-1-e@freeshell.de>
 <bdec8558-0408-4efc-8a50-e726c8be9cee@mailbox.org>
 <8a759e95-866e-460c-9899-d5bb30ff4e04@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qjMlfTdtY7c+V1kx"
Content-Disposition: inline
In-Reply-To: <8a759e95-866e-460c-9899-d5bb30ff4e04@freeshell.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--qjMlfTdtY7c+V1kx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 06:51:24PM -0700, E Shattow wrote:
> Hi,
>=20
> On 9/29/26 17:43, Marek Vasut wrote:
> > On 9/30/26 1:07 AM, E Shattow wrote:
> >> Platform drivers and hardware for StarFive JH-7110 SoC are not capable=
 of
> >> DMA access above 4GB
> >=20
> > 4 GiB
>=20
> Yes, I agree.

Fixing as I apply.

>=20
> >=20
> >> . This was previously a problem for MMC access then
> >> resolved by a workaround, since reverted in a3075db94d49 ("lmb: Reinst=
ate
> >> access to memory above ram_top"). The symptom of this is EFI boot fail=
ure
> >> of GRUB from EFI System Partition on USB MSC with a starfive_visionfiv=
e2
> >> board target that has the on-chip Cadence USB, tested with Pine64 Star=
64.
> >>
> >> Restore the workaround with a dependency on LMB_LIMIT_DMA_BELOW_RAM_TO=
P.
> >>
> >> Signed-off-by: E Shattow <e@freeshell.de>
> >=20
> > Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>=20
> Looks good to me as suggested.
>=20
> Thanks,  -E
>=20
>=20

--=20
Tom

--qjMlfTdtY7c+V1kx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar0aNwAKCRAr4qD1Cr/k
CpOqAP9J/7hirZPpGZlIdljWGCgKbEcsUQEQgiaLKN5TayhvswD+Ovwd/dDRwrzP
67DjnmR74cb3RZqwD687W0de5Kn9oQ0=
=H/7O
-----END PGP SIGNATURE-----

--qjMlfTdtY7c+V1kx--
