Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEACC54E49
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 06:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8FD487ABC;
	Tue, 12 Mar 2024 07:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KTCFAKg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97EBF87C86; Tue, 12 Mar 2024 07:14:50 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9EE879BB
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:14:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-513b39eea3dso989820e87.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710224088; x=1710828888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/OyTOZqvFi11j6/DOKS3SVT+rNs7u0XRbq6UF/ch/z4=;
 b=KTCFAKg8VT1pduTGF7bAFo3TBdAWzCY0P0mCRUJ6Qe9+dxIUV1LEXFCWymo0/8B0WR
 FXFRDhCnEPW20bBB/VxiRjCxdC1bU5ij1DyOyNN1zOQa8CHkEZFq0aYUapwWTY33hMwX
 +sHprUeOowcMkGl7UKbaDajLsP2WSw9UxY/3FJWNZX4BHM7LX8zW/T6IiCUPfdeRXu0W
 6pV9OIXzXtP/7XsSqslJmUV1lWhJgLSB/31wwQ5JCKFUUtHDs3MwbhUhjGitBFQ/oro9
 QC36ifJglgDPM9V65O0cfOgBHzQ8TedP1mMW7arr0q8qs7Xt3t7H94ZnfWYNeLGlG0fZ
 8bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710224088; x=1710828888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OyTOZqvFi11j6/DOKS3SVT+rNs7u0XRbq6UF/ch/z4=;
 b=sL76lL20HrU7ArU9WjVP0H77AEpyHQnQVGJSq0sr1OcLEm7XQ8C6r3ug7z7eFHZiEz
 23D3kLeZHR5lFtkES3p53byvC38Eka5Rr1wxDaGmR4mNVJXyJxtVGhWgJmWrAsMgQ9hU
 bUKhoDlu37d0CDuVNUTfToyJ/+Oi5pPjtlggPHSJ+rbWn0vGdnU9DU92JlVmdZQuegFj
 E34o3n1yzB0erCPW+lB7h4Sk3VNmy3nct0PQjjXo67Sqfcb/Y5uxE2u8MJ/AAeQoe2dq
 b1dCJi4CWH9pONGTyvZARcy8q0Nev80S4wH071WBcXcJcEjlBFljK0vaZi6BauXA0S+n
 bdcA==
X-Gm-Message-State: AOJu0YxfD+WwPB7IH8HnuVletGqSdRBdX3leRWLafh40n6PkCTM+Ij7u
 EnL8P2UgaP3Z1UqwoSZZZz/pcgjQyVl3qu4u1DV9B7o2ocoy2Xm1ARSae9vnSNRmUlMeWFwNZRF
 cjMI9n/aQf2ifpQS2YOohQHQAvhJ2bmrYDWNktA==
X-Google-Smtp-Source: AGHT+IH5UR69YAS4bqP7I3KQzADEoBSNtle52OS4h4KYvHbTLLIZrSxocyK8XdqJ0Hw0HNDtKn8bC/pq6c/5k4GOmf8=
X-Received: by 2002:a05:6512:33d3:b0:513:aef9:5401 with SMTP id
 d19-20020a05651233d300b00513aef95401mr1995291lfg.66.1710224087651; Mon, 11
 Mar 2024 23:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera> <a3c1d482-2b2c-4c7d-96c9-2fe877d09ccc@amd.com>
In-Reply-To: <a3c1d482-2b2c-4c7d-96c9-2fe877d09ccc@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Mar 2024 08:14:11 +0200
Message-ID: <CAC_iWjL4buJzzbJrhu7s8py+EOjqrDY+wq4egkzZSUwj=mmNjQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Michal

Apologies for the late reply

On Wed, 6 Mar 2024 at 09:48, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 3/5/24 16:47, Ilias Apalodimas wrote:
> > On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
> >> There is no reason to describe u-boot.itb on system without SPL. Pretty
> >> much this is cover all systems which are using only boot.bin which contains
> >> all images inside.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >> ---
> >>
> >>   board/xilinx/common/board.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> >> index 9641ed307b75..4f38b7d27684 100644
> >> --- a/board/xilinx/common/board.c
> >> +++ b/board/xilinx/common/board.c
> >> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
> >>              .image_index = 1,
> >>      },
> >>   #endif
> >> -#if defined(XILINX_UBOOT_IMAGE_GUID)
> >> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> >
> > What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?
>
> Your comment is valid but I am not aware about any CONFIG_IS, etc which checks
> that string is not empty. If name is "" it will return yes and second image is
> doing to be defined.
>
> But I found handling in the code like this.
>
>   36 #ifdef CONFIG_DEFAULT_FDT_FILE
>   37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {
>
> which can be used in my second patch not to describe second image in
> set_dfu_alt_info() if string is empty.

Yes, I think that's ok. The problem is that if we merge this as-is, we
would have to disable CONFIG_SPL_FS_FAT to make this work, which is a
bit misleading

Cheers
/Ilias
>
> Thanks,
> Michal
