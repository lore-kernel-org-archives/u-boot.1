Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE0BC79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B660808C5;
	Tue,  8 Sep 2026 07:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XDPuXrlsKrJ; Tue,  8 Sep 2026 07:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C8FF2808BB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788852936;
	b=NMAzEx4WbNKFwpSRUI0ER5ph42rwkPcpIDC6mdB0Y7wDzX+X7A7cO7LlYZvDxONNR6oh
	 fu4Fy2YRg7MLKzE/bsoqR9O2M739w6uQgrjFDHKWqDj8OiCyem4NHj47VxZx6tOuk+Djc
	 FgJC16VdVOChsT4CLT14adWzrEIyN0DZjHry/F9GxJdS3hUKVH9ZDl3AI56cl5jsZ7bk7
	 /uR4KBWbSBI2BxypQ4OZ8eKOrAR3G2xrYqd6nC3CjicjjTDV3CwXsIuk57lz+Nmna7Ctu
	 jiW+gQ/PeSyrz6iVNzW6sH8vHPIUMVZeo6374GfKO4ZreMyu3tTjs6h2QNZpl7PCCVg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788852936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+FX5JOxiDENOrM561lN86jf+Y2htj84bv9PeA/Qhe5Y=;
	b=NObMdWXDpf8bXLvXV7xC1RDpe1zWmAEP42k5WrysQI7XC+6r3IdQAtVsNH7B8r7VnbFL
	 Y+qfpfDZQpUYJd3O1+/363AaI3amtZqSrgC1x3+M2pLjzaOhSLi1hJZR4ODS+L9a6zwbs
	 rD2xKYg0WNt9fS8S0wM2T/XUegCdDT5/nDZMbQDpNTCWIBMH1KFyPfW3CBukrhu1cVRuZ
	 7q6NAe+4CiYvq4h3fjqORuZpNnkMlwtm6rxpBEr9yVg1RNem8EXaLGBFGqnS6fsLRwKpf
	 yF8eMcsecPoTPgSqBXIVoAVegoktLhA3zeUTQ+aaQ+g8S8/0Yb2Q/YzULb+j8SaTs4Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tiLXCZC3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788852935;
	bh=+FX5JOxiDENOrM561lN86jf+Y2htj84bv9PeA/Qhe5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t3Zhe93/vH46D7392FUVlg/Uft4nyDIJodFfqJsnhmB0Pz5ogtnUiotS64BVFz6Pa
	 ohsik4/zIfe5PDpiqiOKKkx5cgp7cCGYlQ7PHgQppzzJ4hgR3DizCWLcQVjE1kyp0D
	 Cw+1opgr/XM4uDdSzf8gCs6bkWYM0xctQukIOYvsP11Q7koqElsA3OXstu6bOkXXiH
	 hXxnQZGbOXAfDe3a+USiEtCF/FV7Atcec+tFpfytGMtila5lW4OoG/AlSw3K4WFFx2
	 EBqziRBM0dNppalceoc+hvhjamvn6rYRZGMi/24y7CBLMMbOZ6AFATDFiA8gbd2S+x
	 tnDqPLPLKG7cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8FF2808BB;
	Tue,  8 Sep 2026 07:35:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F14849D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24D4F808BB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yi7-dVSNt3v5 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB2AD808AE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788852933;
 b=Sk7lZkJgoOR4mdsV07WxpKMfeoA4MEx7euCb7TwOmrrUXg8KAYdD/nWSML1iJaFrdi9v
 4w+j2KEELB73YY4WZHY9/Nc49SYI+33A7aTegac8vuDlddGd5hMZmMN4pCGkaEXWfoTNX
 2nGKh3eBUTZH0S2fUJTNxPyhfCRaNz53NU3y1zV/K1Nz0n7q/Mpi+i4kzYtqm9iHQyHVQ
 VdM1Gqwuqc2b1SRPTHpo+3Lkz1ic8kR9K57FCJyBlp3rS1B3S+1F4/NV96zn/DcChqXB7
 J/CvDXiELvVQl+8flweg3Qv9fjwbs8t294LCs0Z2fuizJKDZEvqOzndnMLCw0I0UXQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788852933;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=+FX5JOxiDENOrM561lN86jf+Y2htj84bv9PeA/Qhe5Y=;
 b=JUm4fgyK33lAcFPVQQdTvcPijAZTCsN48DxRHZmYG2DfOQpY1SFyRQG7CU8WYe9CBXRY
 z91lOaYzpXJ8TbKDX5ef72NCbDcwvG+iLIVxzrw9dJ3dMIvMhOejkd0MXRV3fbxyV+42r
 cvF+T3goRKna/UsWeJJw5OzrC46QJFzUBPCZx3tPVPzpXLYc6Og5BMsoB4BdHf6F1wJyB
 5Ed0YyL/RcRJyxTdtZW3fsqRmLc4DeDlJFuTGCf+sf1QmL5uMqg4LZFQEvORnrZ28MHjX
 6uVjNcGUsQrJw9sEYP0A4jX6qD1n3LfgZQ8JrYbE2M0TQutUC4bbL2aVTrqW160E6oA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tiLXCZC3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tiLXCZC3
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB2AD808AE
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:35:32 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8706dfdcd4fso52171177b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 00:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788852931; cv=none;
 d=google.com; s=arc-20260327;
 b=k97Mp0tFBcTsunjHkiB/52HyICtmftrNDdcRftxYcB0PXgMccvdcukgDpLppO6fxZh
 Va3GrXIrhJ9RbjbRyIjC/mfFMBiKvrL6d9InGap0alGO0WDSnWwWUzPzC98MbOEJBdZS
 7crDAk41A4miFTCCcZCOazqQR4jsIWp0LyYdOh2sIQ4Lab+hdFwgDFtHNPC0KbYfpqsB
 mzCYuVRPH3v613ig4a92uA3y8kKLCXtJrNID97uuYquF6XQ9b0iZKU4iCTnK6/Xru4db
 hHChmuD9iFNdAY/FICXqWTShZpLZ7AHNLrdff9kWlfdDAuYRQtBig+zTNurSeKG2jXbH
 4r9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+FX5JOxiDENOrM561lN86jf+Y2htj84bv9PeA/Qhe5Y=;
 fh=2klGlu/6kDXA+mS03unMo242w1tQj70wuFMUt/3UxlE=;
 b=gsZh8O6D36CKtPwMCNBjvRAKNS70n5kz5HeCdw5GDDncp7wknejvUL+fv5CSSJ6PLm
 l+Z9xqsAgNW+tmgvgXb9B6CX3rgwlQFjQAtuIDL74efl/GGEoh6iQyVvy35muwDzeu2B
 IKzNqWJvJ8wWTFk9hPA1jrZKNQTLqkGqrlgz8Qv+IHzD7EwsHlNhCA3ztEKE2b4YqtsD
 8DfkRjP/BMJn5uWZzOaZCRLj0PDZ35tGfB/JMSGz9kEiSyw/KGM7+wooj85MvwTS0qHf
 744Gje6NWYjTm+DuVgL1PKtjvIton8XbBO1RJcxnECgGlSInIsWJh/XNxIwhemLIYjhX
 75bA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788852931; x=1789457731;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+FX5JOxiDENOrM561lN86jf+Y2htj84bv9PeA/Qhe5Y=;
 b=tiLXCZC3a0LGDHVxR+844U1EBuhZ5tsEDrZ6JnJ2GiGTLSWWMRP82IL5A+i97Pqy1O
 7KwH8hzImxK9anKqqBxrG+M2a6200aoq5j72GBH/kKkrN3JDnb2ggquNfD7o2byAGxK4
 OM69j+/i2XLh2b6h9h/3cJeHKV8nBhNXjr681kiY9cILH/deVPVqI50l6UCop4KJGSQ7
 eMAA7BcmDPMOZhnTzv93demy0pJrS4R0+wMSlFIHQ4hYYPoRdPJb1cVk32TIffSo5zDP
 L4H4hdL6HDAHliePxP9FcaZWgUiYWb5czXRJe4wO+29hM9st+vUNNYv2sz6ixx4JGK2r
 wxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852931; x=1789457731;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+FX5JOxiDENOrM561lN86jf+Y2htj84bv9PeA/Qhe5Y=;
 b=FuknYxMWXyU8yen1T8I/R3rYeURsl0BrgqG+7gqnKjqWeONdV0VrlWI8xA/b1htLrq
 Zi/dugQ2cNI0MfY4SkaOxMNFyG6n5x2nh+yF6YnLvlTDv19UdF7YBEN1ehqRv3FVI5Hl
 ZYgKUTTRAm8Aw+glSIH9yN4mQZ9T7vMXaMFl8KPWzDSRn0LxgJUxN7nf0FzFAiaO7t9x
 SN8nQesqM2tPfaRert0rgiJHXt/QUDC4rINZpFQeRkX+ekL6HKxkMOj+0tOFvcTKQZIW
 Az/gFxS3a+/3hvVGtolmxBCkzsVqxQiR+luHFU2OoxsvqMR/ZFYTt13/kPbh1RSqm4hK
 NZiw==
X-Gm-Message-State: AFuF++mxJHj59QkYvRq87xudpfufyQCC2Y2PBUhtTgMuCPqF2dnQKKy5
 uHZpQDoZPxbo13igAkPVF+50F0ippzZ8q20lrtaPa5HS6HMpUt/raRDiYxxxQt3tzzBqpNJer42
 NjfmM9Rkpki4zQyev1Ojj9CU4TRCva42UPSnfq4DmZw==
X-Gm-Gg: AYBFou1tpNirUoGk7DuCVinqLgaXyu+iLKhNYS50KTk+nMfQbRGEr+CairyaDESmkQe
 L0AYBCCantF/VvCWA82FcRGcB7JagFkHjCokW4U3zobVb1TpkRqqQ78ggo7BrY2lrlyzdOktBly
 QNpiTlQbzFOOs2JGE/IZjngZbAVNnsvZOgI/4PIpgKQftFHEXZAmEMptX7FwdEpF2sfdKMVMyn5
 Y8Hui0E7B+gLAtCEwh1BVYGjUBiWyvzGCduwRGQxSBAVIubp7jMe+w6dK+DvoIb02yJO1Zo7OPe
 SDrfAyBG4JrmsIsz51hyofNGlYHfbFF2K215L52DsymCyFHF3mtDLH22TxGdZFxwy9dLL1VY2GD
 hEZlewS+vq19pH/lhVEJzfv+sFMEEbmLCURAgppoJ2VeUvlkEDW+h5UPRiX8/PaXm+PNgWW+F0z
 zIOK5UZmBj5nOPUjpsXRdHnIZ2sKszsoUetnxGEk7oYwNGHxvJYU8bD1aaNEhVvNIDGPa1p9sQD
 TpsPgk9ZUwVpNY6ssoyjXvxGgV2G8WgwvJzntF7iQAmaNlfrAD5XYYG4VcljCY3qPTmx/I3bdM2
 R/t4vKR7RZbnbHFyqgD368x+DHi+3E3fVwNF0+G0wLSdMxsnhOfqUjpSY53zArbqERV1FCGmrjA
 rx7KoVMuA5ICBbjCI9OuPL2LGInl46+q2baHJg3Om9Oo=
X-Received: by 2002:a05:690c:9b03:b0:873:5bb2:6c2f with SMTP id
 00721157ae682-8735bb2747emr68885167b3.54.1788852931024; Tue, 08 Sep 2026
 00:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-guidptr-v1-1-5cb72c450436@arm.com>
In-Reply-To: <20260907-guidptr-v1-1-5cb72c450436@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 10:34:53 +0300
X-Gm-Features: AcwNN1XZAl6fftq6ME3hK4BoLk-0Xe-rnc8DXBTkWx_2cz0JLq-BPWuB2q5e1h4
Message-ID: <CAC_iWj+EgirBUNxBXcZqV77D7FwRWO+zkUfBzQRgsC2nTCy-KQ@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: pass GUID by address
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/alternative; boundary="000000000000827024065af3c76e"
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

--000000000000827024065af3c76e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Sept 2026 at 15:16, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:

> Instead of passing a GUID by value to the hash_algo_supported()
> function, prefer passing a pointer.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/efi_loader/efi_signature.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_signature.c
> b/lib/efi_loader/efi_signature.c
> index c2be5cb61b3..21a96426356 100644
> --- a/lib/efi_loader/efi_signature.c
> +++ b/lib/efi_loader/efi_signature.c
> @@ -166,7 +166,7 @@ bool efi_hash_regions(struct image_region *regs, int
> count,
>   *
>   * Return: true if supported false otherwise
>   */
> -static bool hash_algo_supported(const efi_guid_t guid)
> +static bool hash_algo_supported(const efi_guid_t *guid)
>  {
>         int i;
>         const efi_guid_t unsupported_hashes[] =3D {
> @@ -177,7 +177,7 @@ static bool hash_algo_supported(const efi_guid_t guid=
)
>         };
>
>         for (i =3D 0; i < ARRAY_SIZE(unsupported_hashes); i++) {
> -               if (!guidcmp(&unsupported_hashes[i], &guid))
> +               if (!guidcmp(&unsupported_hashes[i], guid))
>                         return false;
>         }
>
> @@ -219,7 +219,7 @@ bool efi_signature_lookup_digest(struct
> efi_image_regions *regs,
>                  * if the hash algorithm is unsupported and we get an
> entry in
>                  * dbx reject the image
>                  */
> -               if (dbx && !hash_algo_supported(siglist->sig_type)) {
> +               if (dbx && !hash_algo_supported(&siglist->sig_type)) {
>                         found =3D true;
>                         continue;
>                 };
>
> ---
> base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
> change-id: 20260907-guidptr-9865d0f0dd1b
>
> Best regards,
> --
> Vincent.
>
>

--000000000000827024065af3c76e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif"><br></div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 7 Sept 2=
026 at 15:16, Vincent Stehl=C3=A9 &lt;<a href=3D"mailto:vincent.stehle@arm.=
com">vincent.stehle@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Instead of passing a GUID by value to the hash_a=
lgo_supported()<br>
function, prefer passing a pointer.<br>
<br>
Signed-off-by: Vincent Stehl=C3=A9 &lt;<a href=3D"mailto:vincent.stehle@arm=
.com" target=3D"_blank">vincent.stehle@arm.com</a>&gt;<br>
Cc: Heinrich Schuchardt &lt;<a href=3D"mailto:xypron.glpk@gmx.de" target=3D=
"_blank">xypron.glpk@gmx.de</a>&gt;<br>
Cc: Ilias Apalodimas &lt;<a href=3D"mailto:ilias.apalodimas@linaro.org" tar=
get=3D"_blank">ilias.apalodimas@linaro.org</a>&gt;<br>
Cc: Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com" target=3D"_blank">tr=
ini@konsulko.com</a>&gt;<br>
---<br></blockquote><div><br></div>Reviewed-by: Ilias Apalodimas &lt;<a hre=
f=3D"mailto:ilias.apalodimas@linaro.org">ilias.apalodimas@linaro.org</a>&gt=
;<br><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0lib/efi_loader/efi_signature.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.=
c<br>
index c2be5cb61b3..21a96426356 100644<br>
--- a/lib/efi_loader/efi_signature.c<br>
+++ b/lib/efi_loader/efi_signature.c<br>
@@ -166,7 +166,7 @@ bool efi_hash_regions(struct image_region *regs, int co=
unt,<br>
=C2=A0 *<br>
=C2=A0 * Return: true if supported false otherwise<br>
=C2=A0 */<br>
-static bool hash_algo_supported(const efi_guid_t guid)<br>
+static bool hash_algo_supported(const efi_guid_t *guid)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const efi_guid_t unsupported_hashes[] =3D {<br>
@@ -177,7 +177,7 @@ static bool hash_algo_supported(const efi_guid_t guid)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; ARRAY_SIZE(unsupported_has=
hes); i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!guidcmp(&amp;u=
nsupported_hashes[i], &amp;guid))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!guidcmp(&amp;u=
nsupported_hashes[i], guid))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -219,7 +219,7 @@ bool efi_signature_lookup_digest(struct efi_image_regio=
ns *regs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if the hash=
 algorithm is unsupported and we get an entry in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* dbx reject =
the image<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dbx &amp;&amp; =
!hash_algo_supported(siglist-&gt;sig_type)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dbx &amp;&amp; =
!hash_algo_supported(&amp;siglist-&gt;sig_type)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 found =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
<br>
---<br>
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5<br>
change-id: 20260907-guidptr-9865d0f0dd1b<br>
<br>
Best regards,<br>
--=C2=A0 <br>
Vincent.<br>
<br>
</blockquote></div></div>

--000000000000827024065af3c76e--
