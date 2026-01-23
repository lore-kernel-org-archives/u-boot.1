Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71900D72345
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 07:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF0FA839DF;
	Fri, 23 Jan 2026 08:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vwomzK+Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2884D83A6A; Fri, 23 Jan 2026 08:40:46 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AF7839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 08:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6467c5acb7dso1878783d50.1
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 23:40:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769154041; cv=none;
 d=google.com; s=arc-20240605;
 b=GrFMru6v5IZnOCE+8wuJfW0PpRb1RT6mpVNnml+q8YM5yHI8EkhAScb3NcQQ7+4oC0
 EWUvRVcLe1MEQRUIzQ06W45GeZW3O4HF4wExI7KMibQo9rFkY4V1zWskRXXzFMp2sDbN
 OZ2SsS0WGjMuRpQ4aH9BoI/z8+i8lWbWEbxjDxIuF96p76edmE7afuCH/E47IxZRVA8S
 w4NCCMEzo0ZO8FSqi7TY1Xw2d6Sgcyo2IWbSRracI3Jvu9dSSh2UN0avkLsz/05lomWA
 MUIUQe+JzjunT5JJ3SVNy+pj7yFQJkgsz2KSWlMB1nb/kNpMAk7m8fY0sMjgLoe785lC
 dU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bGDiF2+/to0vhp2Uajuq4IFqChL93upSZKk308BgPMA=;
 fh=4rIj4h4+CTlKNqL42LoqJd0VfBDO/6nCD62lTmWVvM8=;
 b=W7rbEdbpqlnXsKC1hdKP9+MCKZ6xcU8eDgsJ6GMYpd+XYA67JqltYYhQSVDm8fYy4g
 D12Q9Bm9URiFfB//CdJPsMOk+8gc4P8QUgTb9/HH0K7ZikrvqcnJMlTCRhXoEK3ygTn0
 qFUR56Nbdx5H7323auzkeCIyUiRhiHDX7XdZo4Y4ObFkIgHRTMbvJX34MzfLKv+lCJ69
 iNJjgnFoNzYrcH/J/EvTffRRsamZchUE/bvs2XI0J7EWg09KHg7L/v69GVNVCLjjUFp2
 /VVksl0OyNFeaPpLeMFplZseBc5mDRmGCDbSB0H9vzVuRtTVdx9Wx2Mi/sfnwCpdXwKV
 mxXQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769154041; x=1769758841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bGDiF2+/to0vhp2Uajuq4IFqChL93upSZKk308BgPMA=;
 b=vwomzK+Y7kaSwg4IDe1P8mwn8GPwaTxdNFNcpJZ8Fdx0446rjFWp3xTv6Rfx81UAZs
 7/Nntwzy2SK1+f3fqswBtIk6J6mplpNr6Kr+FpGVtNqjVR5Oh45R21uCFu01aCn89toa
 9ZZuW991RRmsUK0i1p/a6/HkltPdJB8J8n+s9Cvj3+bN2UN3w1TSvdekkLCov77ipMuA
 zLwAGphxInBOPh2ZNdjEfSJSDJuAPWFvXhU5CTyOWXF1XJ9vrJWsV4OFoEMQDsblx+m6
 PC6NVMJF2jTGiUmQYQ2m7M7kbp2irV4OLBuyq2gMhaBOREOmvRYYyDBOpjafhNyU7/0V
 7i6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769154041; x=1769758841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGDiF2+/to0vhp2Uajuq4IFqChL93upSZKk308BgPMA=;
 b=gVqAcqEJa/CEYE432Bu0lci/xLoJAdBVaZq94jBO5SDIlQssS76DOqshRxZe5199Jd
 OzO3SuR0iDqCn13BR2VOZ5/1mfCMd28+UhPYZf2KqU0yHQiCTg7tDU8zJaPFi3jpszbe
 HPHZ2dxd1Pu5Ec5bfH8aPZ1NMvZsPcWYWX1IeMIqbfUNUuaiKP0akveXGTPhBiODnsYi
 BToByArel6bGhcXQIwG4UfsYeyzGclR58xuX3lWlyv0nAGMTdqyJx7ONyW4SwTzxj5fi
 SAM1/ZBzo3J0iyWQPB0WzaFrFdnQLt19HVGSZBQF4Z4voStslZtMvv1aI7dQe9o1H8mK
 Kq8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Vxs3LKzeEHJR40gjBQk6ACqosseer1dKjAmlhL8wl9jdAu0ibz9r34vJwp0sMR8DxlA39m4=@lists.denx.de
X-Gm-Message-State: AOJu0Yysau0ud6x5M+4tsKQ1wVGgz1y96IVGrj085XZH72DJh/Seh69J
 8XukNCG5Np1Qv4re6miEJumpsqVL34oNQztOZ6H7N+cKT0+lJZ7XjFXK6pw8atWVKltCevemb8g
 10REh8J1KW+q+sET0I8/FJ88Tfx73zIZ+y4yFb3ECOQ==
X-Gm-Gg: AZuq6aJ55crEo7InE77eV4x8fARJUcCckmPViXPJwS2KVaeKIyNnG4b3aVfRN41wi/c
 ifWbZlk5l054juCGymRIPFfFGFr4ROkCUiz3Hn8XKMv3THrc0bD5v8ukxBV2NbFkE4rI62QjXIA
 +iUrSu0o1qa10BgKWWBuGB06O9ca7dycmiynHHyoVnA6ZeKY/BBFVHadP7khHCfiS599RkzTB/W
 DTdb/9pegnBuMIGyf6WbyMp5DqqWLU9pEO8XPfAzp5nfzUIYS0LwyMh+za3BKHUbfe14MekR2qB
 ifxOlJo82ka5AUfkW9ltT2+xXPEcXINBdsYQ6FRs/z4n3+CvfShlmb0FS1QmyFcg02KHWNFzIet
 j6+zl+UL6VuMGX/0LOSohlt30W00xiGo4NO8sKAxcRcu8SY8TqNcr/Cfi3+TS+fHkpDD4vQV0FU
 C9TbWx3On5zd52wk5IIoEcvfS5i+Z9Trat1V59iFVlqi77ViCN2KeAW55+ribujG6V1vp/3TYXj
 QgBkFoyjqd+1gMRkeIHmG8izXxUmW9gAPmVUNE3Y1N7+udkyZd1AjaNsQyalgloPSiJgT1VaFo2
 4tVrYJFXHIE8YG9PpsJ6vffFboCDNkg4
X-Received: by 2002:a05:690c:6f0a:b0:78c:6921:9447 with SMTP id
 00721157ae682-794399f181fmr16798397b3.40.1769154041165; Thu, 22 Jan 2026
 23:40:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1768403729.git.michal.simek@amd.com>
 <da6f7b65cfb5aa81b7ff13848f532cde1b009227.1768403729.git.michal.simek@amd.com>
 <CAC_iWjKrfLXNy6a+bBUAW-xHSicir1TL0vXey2MVz8MxDsMYMA@mail.gmail.com>
 <6b91098b-8072-4691-b2b4-a41ecf6879e2@amd.com>
In-Reply-To: <6b91098b-8072-4691-b2b4-a41ecf6879e2@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Jan 2026 09:40:04 +0200
X-Gm-Features: AZwV_QhuAlvEsSfvjCjlQuzPPUOQUCKvpQ3QbP2FRvgNu546_gwWrRoTH1O_FkA
Message-ID: <CAC_iWjLBZz1m+9o1PJJegEPE6SGfNvbAe_JuAUrrFTCE=ydOjw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] efi_vars: Implement SPI Flash store
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, git@amd.com,
 Shantur Rathore <i@shantur.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

On Thu, 22 Jan 2026 at 14:32, Michal Simek <michal.simek@amd.com> wrote:
>
> Hi,
>
> On 1/22/26 13:18, Ilias Apalodimas wrote:
> > Hi Michal,
> >
> > [...]
> >
> >>
> >>   config EFI_RT_VOLATILE_STORE
> >>          bool "Allow variable runtime services in volatile storage (e.g RAM)"
> >> -       depends on EFI_VARIABLE_FILE_STORE
> >> +       depends on EFI_VARIABLE_FILE_STORE || EFI_VARIABLE_SF_STORE
> >
> > Will this work on nands as well? They got a  much shrter lifetime that
> > spi flashes.
>
> I don't think this is valid argument here. Users have options to decide where to
> put them. The same argument can be used for u-boot variables saved in NAND.
> Obviously I can update Kconfig option with saying that you should be careful
> about it but it is user choice.

Yes I think that's a good idea.

>
> >
> >>          help
> >>            When EFI variables are stored on file we don't allow SetVariableRT,
> >>            since the OS doesn't know how to write that file. At the same time
> >
> > I am not sure we need to allow this for now. At least not until we've
> > talked to the efitool maintainers and make sure they will accept
> > another 'special' case.
>
> Not a problem for me to disable it for now.
>
> >
> > The problem with allowing this is that if people enable it, boot a
> > linux and do a setvariable, it will return a success. But none of the
> > variables will be preserved after a reboot unless someone manually
> > updates the serial flash contents. In theory, we can preserve the
> > driver  model and the spi drivers in EFI runtime services and allow
> > 'proper' setvariable at runtime.
>
> Wasn't this the same case for file based one? I mean u-boot had it but efi
>
> Yours efivar patch was merged Jun 23, 2025
> But this symbol was introduce in U-Boot April 18, 2024.

Yes but the patches were sent a long time ago in efivar. If you look
at the original PR date it was a lot eariler [0]. It just took a long
time to discuss and merge.
Apart from that the case for file stored variables is by itself pretty
unique and convincing the maintainers to accept the patch had some
basis. I don't know if they want the same workaround for spi flashes.

>
>
> > However, I think this is not very useful. Having an unprotected to
> > store authenticated EFI variables, is dangerous. Someone can erase the
> > SPI flash and efectively disable secure boot. Due to that, I prefer
> > the current file based approach for EFI variables -- which doesn't
> > store/restore authenticated EFI variables (and which this patch
> > implements). The obvious downside is that enable setvariable at
> > runtime is tricky once again....
>
> Isn't the same happening with file store too?
>
>  From implementation perspective it should be the same as file based. Obviously
> efivar part is missing.

Yes. However, that commit included instructions on how to set runtime
variables with dd, so people could use it until the efivar changes
were merged.

>
> >
> > [...]
> >
> >> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> >> index be670a8e7c25..feab212b245b 100644
> >> --- a/lib/efi_loader/efi_variable.c
> >> +++ b/lib/efi_loader/efi_variable.c
> >> @@ -397,11 +397,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> >>                  ret = EFI_SUCCESS;
> >>
> >>          /*
> >> -        * Write non-volatile EFI variables to file
> >> +        * Write non-volatile EFI variables to file or SPI Flash
> >>           * TODO: check if a value change has occured to avoid superfluous writes
> >>           */
> >>          if (attributes & EFI_VARIABLE_NON_VOLATILE) {
> >> -#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> >> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE) || CONFIG_IS_ENABLED(EFI_VARIABLE_SF_STORE)
> >
> > Do we need the ifdefery here? efi_variable.o is basically compiled
> > whenever we have the variables managed by the non-secure world and
> > this function will exist either with a file back storage or a SPI
> > flash
>
> It can be reverted and return EFI_NOT_READY for EFI_VARIABLE_NO_STORE.

Yes I *thinkk* that will look cleaner.

>

[0] https://github.com/rhboot/efivar/pull/267

Cheers
/Ilias
> Thanks,
> Michal
