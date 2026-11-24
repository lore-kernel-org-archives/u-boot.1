Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EA606A32E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YTDZeXK7;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lRSHDV/Z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6C13407AD;
	Tue, 24 Nov 2026 11:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPORiZQh8PSo; Tue, 24 Nov 2026 11:52:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9B9F340689
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795521132;
	b=gYw8DcKrxSoy9SD9fM3hESMEymLtYaaOh2j7bF019rOw+7LP2VSLDYZv+r3IDf8hJ49p
	 oUK3SSskm5FRIoxOfQh9ldOyIgJZnHZ2/fnYq0Ss0wGt1yY+tInGTxibwiYe2kBqoAbj5
	 mNKH79LMmo21v8tWGzLJlALDPdrwQKRCv+d4bGLnOvDwqR0kMzo+JUCXm7oHdUj038w4A
	 /kOwxiGRM4yZV6e+GuAxeFniIzpykjXxV8J2eKH8tXjNt8RLAhLWYLvukZADnAApqGg8B
	 /D+zxFAvrPlnDDFDUssmZPE+TQpM62wiEyNiY4AIWoxR+ELpn8Tg4nrWMiiGhlRHRYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795521132;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/UdpHR1Ffi3F6mAiFrjr3us6ESRqsPkxyaLiABwH8O4=;
	b=BcLM8/qkGweoCMa+J74zCfHNJc0ymyI8WDCTTihaJDF7akpdjwlcZpwupJBiT6v+bolj
	 66eMCGEEVIvtmHpFqVl6lDt4mRVQ1K/C6eE3JWh2PyGo7mts3FxdAulsgK1lHc9+0GMDl
	 5uXP6CIxFm+Q1oIs8AiiG5d3B40s1USu28mhHFNZnp2hOshNzSDADbVwnHly4/CvgRSqi
	 QwWNl65lAxLyUjBfHQl8T40Er4zvORs5NEAGAVbaHx6HSoJQhoIc6nlV1OtMorbqL2t0K
	 ++T18oI1/46kU8RYHKP8/L7nOsCS6SeCX8E6uSL16GPkdg+kfRtr+UT8d49DQZJ+mcQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="lRSHDV/Z";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795521132;
	bh=/UdpHR1Ffi3F6mAiFrjr3us6ESRqsPkxyaLiABwH8O4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YTDZeXK7E/+5V5EVJd8JGoSC/6DzWkxTscZ2bJ2NGzhnNQQJ0rcwvexPttby21LZa
	 ZDGiwR14i3egK7cBJpLeUCKsAYW1ymqS2iZfaNk004c7yFExjZoJw0zLPyUapdNdB9
	 1xxeAeHmWEfg3H63nvLAAw3RsWYNMAwT/Q1O9fX4x3eOTYA7Hek5pJHK3pMLgtB9ge
	 nYwt6b+d0DUCr/YRuTORJ5JN1JRSfyu70GtqcdE7RX/3gMhHSbseAS6vNFPu/YpyU6
	 kdkQ6ZZ1mLCqjzt7sOi36LhzM7R+hGwfeKgCs3r+AWL4wIqPMl70Hwr8/0oz4RUWro
	 q1iyq5nF7cumQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B9F340689;
	Tue, 24 Nov 2026 11:52:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ABCD1C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29C4540689
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85xGq-WpFfBp for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 11:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F45C40603
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lRSHDV/Z
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F45C40603
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:52:09 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67bee1f693bso3446627d50.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795521128; x=1796125928;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/UdpHR1Ffi3F6mAiFrjr3us6ESRqsPkxyaLiABwH8O4=;
 b=lRSHDV/ZZZ91G7o9RGOXIbMENlTFzt1lZcjNoy4uwIXw/1u3P2T6xXgzdw/o7JbAVq
 NlFDasfDR73Nk7b1+RHEJfaaFh/HqZlv5rIsrrZFlDkSahJetF7IbU8Tp/l6fu7DDEhF
 W6RaH3HpJstFuAeU/dr+/iYDMxpwCASikIT5Hk7fmM50C3nVTe8aLLsH12/tqqoJ3HZT
 Y6wT+tdFrLZMOn6QT+2NuR6vx8iVvT6RSDzCPh6PgxxFQPI6JnRpAWjFq6bs98VDDlBv
 /1GAxhnzEsetb2IBL/qw+BUMhNJOIEgKGS+wWDZRau94wIxZvqEZ061jR670ZYcDRp9E
 SIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521128; x=1796125928;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/UdpHR1Ffi3F6mAiFrjr3us6ESRqsPkxyaLiABwH8O4=;
 b=nWt7peCTbHgaJnobiV2tqJjngTTCH3BNLO2RsG+ZZBJQH3GMDhsPhLv/OtMRYZMOlE
 VHpweJ94TDSg0NeFvZ6r6jzCzzMMBwFrPg/VESDOQrpJ2lIr3cS2/rSBOWkAioxlCrfW
 hiQvi16ZKtrA+8c0gB1v3jumXg5uSj2JSAtXZWRE1GDKAIFU2GeuwP845Vg/5A1CNgsO
 zQ4v4SbMLCgkFcMO/6on5VoBikbGL2Z0lvNy62mRrao6eX3Kguw5U5cMXFGQa3yv/V6e
 FskpJvHvd/5KIJPczcYLPIQyHJ6hG8A/ybgDsbHjXYEQJiZuGK34mJwak3j1NoP70sDb
 607w==
X-Gm-Message-State: APuU4Z/Atj0ftBakKyvTuRry6V/s3CW7bfw5lHeHtNF65zb0sv6+50a0
 o59WZh7jSuFwjNVA1joVuA4juQbXjTLvE8xDF8apjdtIU8WpVGAflCpxHxc/qDKFHTXHh0tYgyz
 31Wm/sMbRyIF3a6UFqEoKzyXcWbrru+MJyGUpesaaZnC+Tl5x6xhoZnZmnQ==
X-Gm-Gg: AZFdTZehZEqW53/Z1O1ZEHEMYqYmosmSvo4UifcRMbBZBw5LIeGa73+y0RL67ktbTGM
 qyvNNqG5Oaqk9v6DRaqVLAsIFvPJ5o4HWPcuW8No+fwkdKBtEG/CNR/Bo0kg3cUaD5W+vzJBmEG
 3qevJk4MxkBuugrI6KiUxUGjpwmIfSBVDk64HWfbXvV+4jHHLVPABaq1VmwE12dD3G43zU0ckrl
 OeXmfUzV2TgewVeYz/4hqr+An288HaqscrFc0Yftn8wauXd/37J+jJQ8CFfQh0NSzHqIZG2cm5Y
 8GfUkCjZwjU3rps86DFiqyrUcVnF75jQG3VPoB2PEPZw+fu7PFm85nhyTBg4SY0IfM4vDJXfcj8
 7+eZoTU0/VBuAgoRsce7ggv/ev5kJq87VxGEuPxaeQvnXhhb/wAS0oMD9T3VdZKDPqVn+CtK57z
 S9ktKbAxaIytazPScRO0ZIwDjNLz7kZwmuzdUpJ6QS0JOqxpG31C04BVQRPkAq862cm9C3Dn4tN
 1xXYgUfIu6by0OzN0nPXp6ZOkvohAEzNRfKOt4vVtNZOiIbxdWzZ1z4VMeNmwP9oLISenleSyxT
 vRLObAEixVUKf9WtyTKv5VIkZscpBYtM76X7n/IxVN3FghLLJU7fYtfKUxQpRmgalqssI76XHhO
 PiGPKqz2kRJixr3pN0R548oV/gc1CXLNqRyOF34cmmkVw1STQ1lqqs9YIefgUlvcIcjsmbKzoul
 dTfyw4inyU0+UEW0FTYb8K5LCmK1ReQtgoe//fjeaVtAdpb/aq8e+8M2ROFhRUjvAZsEUcLC0=
X-Received: by 2002:a05:690e:4004:b0:67d:bedd:494e with SMTP id
 956f58d0204a3-67df40be117mr8087675d50.0.1795521127577; Tue, 24 Nov 2026
 03:52:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
 <b185f41c-1008-47f6-aac2-1005fae9f8e8@gmail.com>
In-Reply-To: <b185f41c-1008-47f6-aac2-1005fae9f8e8@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Nov 2026 13:51:31 +0200
X-Gm-Features: Aa3M54pke0dO3c0o-ANX-U3eRfsqG8tm00d7hJBO-t8YF0KOm0c_TpnuMjLmWBU
Message-ID: <CAC_iWj+3rkakpiCVOv+ykTrujp8Ocqibz1Y5rkZRYBhmynJDFA@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] efi_loader: check the PE image ranges in
 efi_image_parse()
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 23:56, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> efi_image_parse() collects the regions of an image to be hashed for
> Secure Boot and for TCG2 measurements. It takes the header size, the
> section table, each section's raw data and the certificate table from
> the image without checking them against the image size:
>
> - SizeOfHeaders and each section's PointerToRawData and SizeOfRawData
>   are added as regions even when they run past the end of the image,
>   which is then read out of bounds when the regions are hashed;
> - the section table is read wherever SizeOfOptionalHeader and
>   NumberOfSections put it;
> - the end of the certificate table is computed in 32 bits, so a large
>   offset wraps around and passes the check;
> - errors of efi_image_region_add() are ignored.
>
> All of this happens before the signature is verified.
>
> Call efi_check_pe() first, check each offset and size against the image
> size without wrapping, add regions only through a checked helper and fail
> on its errors. Require the optional header to hold exactly the data
> directories it declares, at most 16, as EDK2 and shim do. Take a file
> alignment of 0 as the PECOFF default of 512 and require any other to be
> a power of two. The padding of a section to the file alignment is hashed
> only as far as the image goes, so an image whose last section is not
> padded is still accepted. Check the certificate table against the size
> of WIN_CERTIFICATE, not of a pointer to it. The sorted section table is
> now freed on the error path too, which the new error exits from the
> section loop need.
>
> barebox, whose EFI loader is based on this file, added similar checks in
> 4ec1f7166778 ("efi: validate PE parser input ranges").
>
> Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  lib/efi_loader/efi_image_loader.c | 254 +++++++++++++++++++++---------
>  1 file changed, 176 insertions(+), 78 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index 7cda338882c..82083cb73d9 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -393,6 +393,45 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_size)
>         }
>  }
>
> +/**
> + * pe_range_ok() - check that a range lies within the image
> + * @len:       size of the image
> + * @off:       offset of the range from the start of the image
> + * @size:      size of the range

The naming here seems a bit off. image_size, off, len is more readable.

> + *
> + * Return:     true if [@off, @off + @size) lies within [0, @len)
> + */
> +static bool pe_range_ok(size_t len, size_t off, size_t size)
> +{
> +       return off <= len && size <= len - off;

What happens here if len == off and size = 0 ? As it is it will return true.

[...]

>   *

>
>         /*
> -        * Count maximum number of regions to be digested.
> -        * We don't have to have an exact number here.
> -        * See efi_image_region_add()'s in parsing below.
> +        * efi_check_pe() checks the DOS and PE signatures and that the image
> +        * is large enough to hold a 64bit NT header, which is longer than a
> +        * 32bit one. Every optional header field and data directory entry
> +        * read below therefore lies within the image.
>          */
> -       num_regions = 3; /* for header */
> -       num_regions += nt->FileHeader.NumberOfSections;
> -       num_regions++; /* for extra */
> -
> -       regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
> -                     1);
> -       if (!regs)
> -               goto err;
> -       regs->max = num_regions;
> +       if (efi_check_pe(efi, len, (void **)&nt) != EFI_SUCCESS)
> +               return false;
> +       opt_off = (u8 *)&nt->OptionalHeader - (u8 *)efi;
> +       opt_size = nt->FileHeader.SizeOfOptionalHeader;
>
> -       /*
> -        * Collect data regions for hash calculation
> -        * 1. File headers
> -        */
>         if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
>                 IMAGE_NT_HEADERS64 *nt64 = (void *)nt;
>                 IMAGE_OPTIONAL_HEADER64 *opt = &nt64->OptionalHeader;
>
> -               /* Skip CheckSum */
> -               efi_image_region_add(regs, efi, &opt->CheckSum, 0);
> -               if (nt64->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
> -                       efi_image_region_add(regs,
> -                                            &opt->Subsystem,
> -                                            efi + opt->SizeOfHeaders, 0);
> -               } else {
> -                       /* Skip Certificates Table */
> -                       efi_image_region_add(regs,
> -                                            &opt->Subsystem,
> -                                            &opt->DataDirectory[ctidx], 0);
> -                       efi_image_region_add(regs,
> -                                            &opt->DataDirectory[ctidx] + 1,
> -                                            efi + opt->SizeOfHeaders, 0);
> -
> +               dirs_start = offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory);
> +               csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
> +                                             CheckSum);
> +               subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
> +                                               Subsystem);
> +               dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
> +                                            DataDirectory[ctidx]);
> +               header_size = opt->SizeOfHeaders;
> +               align = opt->FileAlignment;
> +               num_dirs = opt->NumberOfRvaAndSizes;
> +               if (num_dirs > ctidx) {
>                         authoff = opt->DataDirectory[ctidx].VirtualAddress;
>                         authsz = opt->DataDirectory[ctidx].Size;
>                 }
> -
> -               bytes_hashed = opt->SizeOfHeaders;
> -               align = opt->FileAlignment;
>         } else if (nt->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC) {
>                 IMAGE_OPTIONAL_HEADER32 *opt = &nt->OptionalHeader;
>
> -               /* Skip CheckSum */
> -               efi_image_region_add(regs, efi, &opt->CheckSum, 0);
> -               if (nt->OptionalHeader.NumberOfRvaAndSizes <= ctidx) {
> -                       efi_image_region_add(regs,
> -                                            &opt->Subsystem,
> -                                            efi + opt->SizeOfHeaders, 0);
> -               } else {
> -                       /* Skip Certificates Table */
> -                       efi_image_region_add(regs, &opt->Subsystem,
> -                                            &opt->DataDirectory[ctidx], 0);
> -                       efi_image_region_add(regs,
> -                                            &opt->DataDirectory[ctidx] + 1,
> -                                            efi + opt->SizeOfHeaders, 0);
> -
> +               dirs_start = offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory);
> +               csum_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
> +                                             CheckSum);
> +               subsys_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
> +                                               Subsystem);
> +               dir_off = opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
> +                                            DataDirectory[ctidx]);
> +               header_size = opt->SizeOfHeaders;
> +               align = opt->FileAlignment;
> +               num_dirs = opt->NumberOfRvaAndSizes;
> +               if (num_dirs > ctidx) {
>                         authoff = opt->DataDirectory[ctidx].VirtualAddress;
>                         authsz = opt->DataDirectory[ctidx].Size;
>                 }
> -
> -               bytes_hashed = opt->SizeOfHeaders;
> -               align = opt->FileAlignment;
>         } else {
>                 log_err("%s: Invalid optional header magic %x\n", __func__,
>                         nt->OptionalHeader.Magic);
> +               return false;
> +       }
> +       dir_end = dir_off + sizeof(IMAGE_DATA_DIRECTORY);
> +
> +       /*
> +        * The optional header must hold exactly the data directories it
> +        * declares, at most 16, as EDK2 and shim require. The section table
> +        * follows the optional header; it and the whole header area
> +        * (SizeOfHeaders) must lie within the image, as must the certificate
> +        * table.
> +        */
> +       num_sections = nt->FileHeader.NumberOfSections;
> +       sections_off = opt_off + opt_size;
> +       sections_size = (size_t)num_sections * sizeof(IMAGE_SECTION_HEADER);
> +       if (num_dirs > IMAGE_NUMBEROF_DIRECTORY_ENTRIES ||
> +           opt_size != dirs_start + num_dirs * sizeof(IMAGE_DATA_DIRECTORY) ||
> +           !pe_range_ok(len, sections_off, sections_size) ||
> +           !pe_range_ok(len, 0, header_size) ||
> +           header_size < sections_off + sections_size) {
> +               log_err("%s: Invalid PE headers\n", __func__);
> +               return false;
> +       }
> +       if (authsz && !pe_range_ok(len, authoff, authsz)) {
> +               log_err("%s: Size for auth too large: %u\n", __func__, authsz);
> +               return false;
> +       }
> +
> +       /* The file alignment is a power of two, by default 512 (PECOFF) */
> +       if (!align)
> +               align = 512;

Isn't opt->FileAlignment a requirement of PE/COFFs? IOW we should
reject the image instead of pretending it has an alignment.

> +       if (align & (align - 1)) {
> +               log_err("%s: Invalid file alignment %u\n", __func__, align);
> +               return false;
> +       }

is_power_of_2() is already exists in our header files.

> +
> +       /*
> +        * Count maximum number of regions to be digested: three for the
> +        * header, one for each section and one for extra data.
> +        * We don't have to have an exact number here.
> +        * See efi_image_region_add()'s in parsing below.
> +        */
> +       num_regions = 4 + num_sections;
> +
> +       regs = calloc(sizeof(*regs) + sizeof(struct image_region) * num_regions,
> +                     1);
> +       if (!regs)
>                 goto err;
> +       regs->max = num_regions;
> +
> +       /*
> +        * Collect data regions for hash calculation
> +        * 1. File headers
> +        */
> +       /* Skip CheckSum */
> +       if (efi_image_region_add_checked(regs, efi, len, 0, csum_off, 0))
> +               goto err;
> +       if (num_dirs <= ctidx) {
> +               if (efi_image_region_add_checked(regs, efi, len, subsys_off,
> +                                                header_size - subsys_off, 0))
> +                       goto err;
> +       } else {
> +               /* Skip Certificates Table */
> +               if (efi_image_region_add_checked(regs, efi, len, subsys_off,
> +                                                dir_off - subsys_off, 0))
> +                       goto err;
> +               if (efi_image_region_add_checked(regs, efi, len, dir_end,
> +                                                header_size - dir_end, 0))
> +                       goto err;
>         }
>
> +       bytes_hashed = header_size;
> +
>         /* 2. Sections */
> -       num_sections = nt->FileHeader.NumberOfSections;
> -       sections = (void *)((uint8_t *)&nt->OptionalHeader +
> -                           nt->FileHeader.SizeOfOptionalHeader);
> +       sections = (void *)((uint8_t *)efi + sections_off);
>         sorted = calloc(sizeof(IMAGE_SECTION_HEADER *), num_sections);
>         if (!sorted) {
>                 log_err("%s: Out of memory\n", __func__);
> @@ -516,14 +600,29 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
>         qsort(sorted, num_sections, sizeof(sorted[0]), cmp_pe_section);
>
>         for (i = 0; i < num_sections; i++) {
> +               size_t size;
> +
>                 if (!sorted[i]->SizeOfRawData)
>                         continue;
>
> -               size = (sorted[i]->SizeOfRawData + align - 1) & ~(align - 1);
> -               efi_image_region_add(regs, efi + sorted[i]->PointerToRawData,
> -                                    efi + sorted[i]->PointerToRawData + size,
> -                                    0);
> -               log_debug("section[%d](%s): raw: 0x%x-0x%x, virt: %x-%x\n",
> +               if (!pe_range_ok(len, sorted[i]->PointerToRawData,
> +                                sorted[i]->SizeOfRawData)) {
> +                       log_err("%s: Invalid section %d\n", __func__, i);
> +                       goto err;
> +               }
> +               /*
> +                * The padding to the file alignment ends with the image. Round
> +                * up in 64 bits, where the sum of two u32 cannot wrap around.
> +                */
> +               size = min_t(u64, ALIGN((u64)sorted[i]->SizeOfRawData, align),
> +                            len - sorted[i]->PointerToRawData);
> +               if (efi_image_region_add_checked(regs, efi, len,
> +                                                sorted[i]->PointerToRawData,
> +                                                size, 0)) {
> +                       log_err("%s: Invalid section %d\n", __func__, i);
> +                       goto err;
> +               }
> +               log_debug("section[%d](%s): raw: 0x%x-0x%zx, virt: %x-%x\n",
>                           i, sorted[i]->Name,
>                           sorted[i]->PointerToRawData,
>                           sorted[i]->PointerToRawData + size,
> @@ -534,25 +633,23 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
>                 bytes_hashed += size;
>         }
>         free(sorted);
> +       sorted = NULL;
>
>         /* 3. Extra data excluding Certificates Table */
> -       if (bytes_hashed + authsz < len) {
> +       if (bytes_hashed < len && authsz < len - bytes_hashed) {
>                 log_debug("extra data for hash: %zu\n",
>                           len - (bytes_hashed + authsz));
> -               efi_image_region_add(regs, efi + bytes_hashed,
> -                                    efi + len - authsz, 0);
> +               if (efi_image_region_add_checked(regs, efi, len, bytes_hashed,
> +                                                len - bytes_hashed - authsz,
> +                                                0))
> +                       goto err;
>         }
>
>         /* Return Certificates Table */
>         if (authsz) {
> -               if (len < authoff + authsz) {
> -                       log_err("%s: Size for auth too large: %u >= %zu\n",
> -                               __func__, authsz, len - authoff);
> -                       goto err;
> -               }
> -               if (authsz < sizeof(*auth)) {
> +               if (authsz < sizeof(**auth)) {
>                         log_err("%s: Size for auth too small: %u < %zu\n",
> -                               __func__, authsz, sizeof(*auth));
> +                               __func__, authsz, sizeof(**auth));
>                         goto err;
>                 }
>                 *auth = efi + authoff;
> @@ -569,6 +666,7 @@ bool efi_image_parse(void *efi, size_t len, struct efi_image_regions **regp,
>         return true;
>
>  err:
> +       free(sorted);
>         free(regs);
>
>         return false;

Generally speaking this function has grown to the point of being
unreadable. The extra checks are nice, but find a way to break down
the function. pe_range_ok() is a nice start.

Thanks
/Ilias
