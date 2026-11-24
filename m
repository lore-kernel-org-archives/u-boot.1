Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294F606A333
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w2+k0V4a;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OQQNoDDa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 788B1407AD;
	Tue, 24 Nov 2026 11:53:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MbS9ww9Mr8MD; Tue, 24 Nov 2026 11:53:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54E9B40603
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795521214;
	b=VnmEEX60el4SnXjBgCEflUxCZ/G50HnaxJffZbhvIkr5PXeaTfC0YHeDRo4znv6v63+K
	 BcJWX/tZk9f2Gn53TZxZlu1P7VLbalKDrKFGufyYdEQbyhK7A9wWyLRZtcvJG3pZfE9fw
	 waZ9rzdEnHzdIUaNj4+iospeglP54JcVepumDc2EH8LpLynYPbPh8eRQfjn6tTeB4Fy2u
	 D+XFnA4r/VAzPAC+ghSF9yZnGC+4ndzS5QrtkFksoBJ2QUdOdApDoerVJKINX6RyUEpYm
	 et7XQYw6L0pohzcMy4nlem2hqJ9PQ+ezTdLSX7dWCD+xHPFB/mnhDyX0y5aAr+pB8cA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795521214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eGi6Go5RzFegjgKbRGsKXobYIpHgzVko8wJnGKm3Vgw=;
	b=DphhayQ2b88ItbNkjtzXcy1yU1S0GaXtxdH6nNFjQ8EnjYQMnvzHxRtNjztoxiApb778
	 Qybs8G4tf/T4pN3EVC1HbfKefmZtkz1NSdxp/ovXA3p1+qBy/wZQnRXQe7ej3MsM8wrtt
	 TK/1VT9cLKtIDOMcMkoZoWq/88XPTV6AA+RYjGExgvlDFcgc6IPg8Wl85PkDOxA5PMWAf
	 QFf2OwpfE9Y7MyCdb+CFBPvlqnkSvn0xfzlr7gzk34JSucOEGJTxwKxW1Wuc0N0rZGPCK
	 q4aQ+2EuI0eOGCTS+B0Q7fJh/D69VtiFKDWFPuGSmjOplSC6hY6cjB/XDUScfmtW4Ww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795521214;
	bh=eGi6Go5RzFegjgKbRGsKXobYIpHgzVko8wJnGKm3Vgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w2+k0V4a0gTRPDIjKiLfJuFQZYsDb5ljsI7PULjVzt0TejzK1AJ7d/qdoAK6EO+oC
	 WEFsjbRFkqmitd+WpWyKZte8R6xVzX/akxT39QdnF8gYSzsUx+Q82VP/q5TpGROg/Y
	 XsBTRSa0aDPLLxgANmOSyIfvR32Ss+oSNyuXY+rQ3NVVXMZwmw+VxwZzhbuJ/hutV1
	 5XnSU43ZBFMq1KLg3o3xkmfXQUA9eZ6TOByIuzM99/8XYD6qsFXTvolHv6CbHbAYLa
	 jQl8TQ3e0LFuP7A9BKJxsHV8R1d7xLAIYUfs3Rh+f7NJjwfYd4gyI+TI+puAw9oU/N
	 F5Thku3HnYtAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54E9B40603;
	Tue, 24 Nov 2026 11:53:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17C0BD43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09D52607C7
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JYxqORVAd0sV for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 11:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2437607E0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b135; helo=mail-yx1-xb135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OQQNoDDa
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2437607E0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:31 +0000 (UTC)
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67db3a48dc6so5021974d50.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795521210; x=1796126010;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eGi6Go5RzFegjgKbRGsKXobYIpHgzVko8wJnGKm3Vgw=;
 b=OQQNoDDa9FTpFcXD2xAnzhHtVxwov6/g4hek3oKWPWlwzdTRDL+Fg58UJKkIS3tK9m
 R7yaX4hWgkrK1tqtBcYta3lPHFRbB/3M4h/TjRzqLShUbvSlCFApbrDp2c6apgyx3iXa
 8tQOAaH3l2VWBW3JxPBi14nvoMtgZGKGK5qbzQSvROxzuLyzr6kSC8zQE0FnTSYwMM63
 5QV+PnTmD/WddskB3mFhOSS6AFcMdFzk1xcN4KnfozpXgoIt9mjYBIwvemlN23hDGau6
 YdQ36m6xdRUrXSbpdfRaaWEOybCldq/DwA/jAUMVL2A8RShZPa+Q8oEBB1W5mNY5xQ17
 f1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521210; x=1796126010;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eGi6Go5RzFegjgKbRGsKXobYIpHgzVko8wJnGKm3Vgw=;
 b=aQ/sGI/FBkx7/2ycGyrDYa30SM0wlSsQrn4tdDvpcK7fZPtwI6t4PHvrffwerzFEOg
 hNhdKrXO515ChmLP3t8WrEvjMVv+gDth/SRy0xqv+KAukCmqjwC9KGzUTXB78TQioLZe
 pANUgrZDfwL1c9h8PNIFXQuvehL2NllntQ88TdTRcH0A2RJvhs5qSKhPprUn16Biqyi0
 ldQeAr6Depd+7SxRq+gtTPeAF9G6ySYRvwDZ8ALxbcWjOEdooEy1bWjs3oTsw47IPBgy
 /or/PNuGRXdH+KRs90fE291ULg5X57NSa6NColdpn7YiJLaCB0lotIipuCDpkY5eNc7u
 4wEA==
X-Gm-Message-State: APuU4Z/4PjNTxfHaFGphTOZpVDNIJz4DQecDYdjysSLpo/2D5lniKQJp
 3r9vE9rjATEG2eFeIfZ+qf6YbAccyp9U2+P270WUbgWN8QtjmPbK+b+x9BXioZXzAkGvY0ciwDI
 Ud87q14b0SS/wy4DglB7eW+81qGaPalcftQ0CopXZ6A==
X-Gm-Gg: AZFdTZdJDaYeyjSqI8w10RZvKUlZ7ZIA/2uTAW2olxcuXc8qQ38enlRODX+f5h4kl2E
 GM7sK85TIFPXcJogRB6uJmoANfIhNICaDrOS4teG7ga51Pq7rBnkW6xxEn6gVJheCZoHmKN4iym
 lRE56pzQFUWtR7dE5QjSVDMKStok19yDWMNB46JYE3f/ln0ZscN9G71JLfdvQsqXHTy981HG/D9
 6+EH3pzoqAGsUXz5rRJIL7TFCy3u1bvjiQNTKk9vgpT+eoDxKuQohekx/OZfEd6S+A6Wz8XONqY
 4pDkxHzKskcK7nxsHs8oE0X8KBx1SXjl5hU+SGE+gdGH02ikVkwmrv9FGhbXgsLi46xOSxM5R9w
 FcIKxVaIJrRizJl3AEXV5RCTazrjnfM1JQb8pkkPZTShsG+J+W2jLKKx1ifIH2wwCrPBkGQ+zhI
 Rvpfgw/IdA6ZANZKKQjEVS3tweTk87R+x9ysjW64iqJfdiiGdkE1zfqAy0qyvlcuxKlsAc2OUX5
 eEo5xIayyPnEIEKTCheGKtQYF0NldijXMTeCRSCPxPJNWsZVsWyAOltqzeQOujE1H5as8DwSVCg
 XKClkPQNzdjz2LAafTAWUpCummhzA66OJ6skN5lrsM6aka2FtWUbFsdPh/KsKTKi44QLTtHsSrM
 O6reNFhoToLvAxb3MNVsJz9zENVoto2O1fE8y5A+l/fkxVTHwbPxsGedwRNIWZE9oZjS5aleU0L
 YQw/WqfbWwVfNgj+riienRSQNQncyi4vxGOksoXMes6ywW7/BBtnDWvMj55T6xAMN35l5su7Q=
X-Received: by 2002:a05:690e:488f:20b0:679:a65c:5a98 with SMTP id
 956f58d0204a3-67df4419125mr2889944d50.59.1795521209872; Tue, 24 Nov 2026
 03:53:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
In-Reply-To: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Nov 2026 13:52:53 +0200
X-Gm-Features: Aa3M54o5j6NJck5Y8E_cSPJ7D2ry7lc9Kbwvq_vXkGF1hoBHibhpxoqZ4N_pTF0
Message-ID: <CAC_iWjKBFg08H0cxbB44kKtZvgQmh20c8yo+M_PnACtV2FXCYQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] efi_loader: check PE images before using them
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana,

I think it's ok to send a v4 now.

Thanks
/Ilias

On Fri, 6 Nov 2026 at 23:56, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> U-Boot takes the offsets and sizes of a PE/COFF image from its headers
> and uses them before it knows whether the image may run. With Secure
> Boot on, efi_load_pe() authenticates the image first but goes on
> copying and relocating it when authentication fails, and only then
> returns EFI_SECURITY_VIOLATION; efi_image_parse(), which collects the
> regions to hash, runs before the signature is checked, and so does the
> walk of the certificate table. TCG2 measured boot parses every image as
> well. So an image that will be refused, or one that is only measured,
> can make U-Boot read or write outside its buffers, or hang.
>
> This series checks those fields against the image where they are read,
> along the lines of EDK2's PeCoffLoaderLib and DxeImageVerificationLib:
>
> - patch 1 has efi_check_pe() check for a 64bit NT header again, as its
>   comment says;
> - patch 2 checks the headers, the sections and the certificate table in
>   efi_image_parse(), and fails on errors of efi_image_region_add();
> - patches 3 and 4 have efi_load_pe() reject, before allocating the
>   image, a section whose end wraps around and section data past the end
>   of the file; patch 5 makes room in the loaded image for all of the
>   headers;
> - patch 6 checks the relocation table against the image;
> - patch 7 rejects a certificate table holding a certificate no longer
>   than its header, which could make the walk loop forever, or longer
>   than the rest of the table;
> - patch 8 refuses to load an image whose subsystem is not one of the
>   UEFI image types, as EDK2 does;
> - patch 9 marks an image whose TCG2 measurement failed as not
>   authenticated, so that it is not started unmeasured;
> - patches 10 and 11 add unit tests and a Secure Boot test.
>
> Patch 9 no longer needs Heinrich's "efi_loader: handling of missing TPM
> in efi_load_pe()" [1]: the series applies to main with or without [1],
> and [1] applies on top of the series.
>
> barebox, whose EFI loader is based on this file, made several of the
> same changes this year; patches 2, 3 and 4 follow them and say so.
>
> Valid images are unaffected: the unit tests check PE32 and PE32+ images
> with 16, 6 or 5 data directories, an unpadded last section and a file
> alignment of 0, the EFI selftests and the Secure Boot tests pass, and
> each patch builds on its own. Tested on sandbox.
>
> v2 passed U-Boot's Azure CI, all jobs, with [1] (build 13728); v3
> changes only patches 7 and 9.
>
> [1] https://patchwork.ozlabs.org/patch/2335140/
>
> Changes in v3:
> - rebase on current main; patch 9 no longer needs [1] (Ilias)
> - patch 7: fold the new check and the old "dwLength too small" one into
>   a single check, which rejects a certificate no longer than its header
>   or longer than the rest of the table (Ilias)
> - patch 9: put the new check ahead of the one for a missing TPM, so
>   that the patch applies with or without [1]; the commit message says
>   that an image is refused when no TPM is found, which holds with or
>   without [1]
> - add Ilias's Reviewed-by to patch 8
>
> Changes in v2:
>
> Ana Bobillo (11):
>   efi_loader: check the NT header size in efi_check_pe()
>   efi_loader: check the PE image ranges in efi_image_parse()
>   efi_loader: reject a PE section whose end wraps around
>   efi_loader: check PE section raw data against the image size
>   efi_loader: make room for the PE headers in the loaded image
>   efi_loader: check the relocation table against the image size
>   efi_loader: check certificate lengths in efi_image_authenticate()
>   efi_loader: refuse a PE image of an unknown subsystem
>   efi_loader: do not start an image that cannot be measured
>   test: lib: add tests for the PE image checks
>   test: py: test invalid certificate lengths in signed images
>
>  lib/efi_loader/efi_image_loader.c             | 369 +++++++++----
>  test/lib/Makefile                             |   2 +-
>  test/lib/efi_image_loader.c                   | 501 ++++++++++++++++++
>  test/py/tests/test_efi_secboot/conftest.py    |  31 ++
>  test/py/tests/test_efi_secboot/test_signed.py |  36 ++
>  5 files changed, 833 insertions(+), 106 deletions(-)
>  create mode 100644 test/lib/efi_image_loader.c
>
>
> base-commit: feb8913982e4462c01fd914271f92254a25dc101
