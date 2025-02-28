Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73F8C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 11:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19848809D4;
	Fri, 28 Feb 2025 12:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yy9M/Lk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16BD80F06; Fri, 28 Feb 2025 12:57:43 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BCF800C2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-8622c3be2f4so804774241.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740743860; x=1741348660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CTuDCNgM/X7eaSZAV3KqWubaqaj2gXWBkLUnaJLOnDo=;
 b=yy9M/Lk0Tudl8d8zGbaa02MOuF6W34U17cmAJs67ahxKeDN2fA346E2P7XJ6sOJsAs
 BSE7dVbHKFX7EjnjhH6qRvfuHrGkEFZbink0zCS2XopIG1OdrewHlYAcFmTLe6RxPP+q
 pCU3ZzssI0KP+fdkFWMIYdi14e+KUWVIqdEMOOIXckT/97FHA8/HRKpQJz160u2pXzyl
 bXqovGc8xP36Lv7OWX16b7DhJjQOrFrgnuDt6J4PUonMLjpkgMi5wfs6ydSbhTqe3ppX
 AxTukxtzmr/csB+PlWTbla8bInpUE6CF7qrEdWrLPARa8px8pvprftgVjeYa9rDj1NYL
 8rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740743860; x=1741348660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CTuDCNgM/X7eaSZAV3KqWubaqaj2gXWBkLUnaJLOnDo=;
 b=MGaKwZA9GuGqsxMqmP8Wil0k+/78s/n2STP72rIbRxzQeopZpThYxhndgMJJFJXImG
 2kCzpriHDd7O/s/oagvPrujUomR8DMPU0Dmndxag4p+OMX6FpF8P2aPpIRx5ky7L+cyM
 sUsjXZIOx/3icZ/FGOqd0XyzQkwrSlFgBCThJbeTVSJnVT6qHEQgMppt6zQ0yt/+XN2B
 EKl5xHZzAK2g4IDpvFAJDxvri4ZFS1oN88F3Mut4GavRxM6+YpiEKZCIbrtgd+pKAOtD
 GBrkLg1iWCtgWKJHfwVXMLgYlfzj+vYpFkA3M72WbgFdMpZazvwXp4xcVHkE/rE8WH91
 ZJnA==
X-Gm-Message-State: AOJu0YxqfQQISpoMRpdYHZAkL0lj4hV5a41//Dgh5SPXvE4XzxFv9kLz
 sYtUPzBqz0BYNIJ1e7kngWrs0vwwvb8t0U3N/uv/dmonT/cktbDPCNNqt/d0+edZbJwI34xBt4y
 QgjgqgT7/I/7w+t0RTeHMEbSsTMqaS9Oj9b3S3XBXGf2VHX6ssP8=
X-Gm-Gg: ASbGncv4FSs5+ffawUB6a5FPApy9GXA9ry2sGZUX1709OKNjA6jTJPpjfTVI6mf08I2
 zflr8Mm6L15nTQDqgxbk2bmByjCYWvDJBHJ69bG9iPKfnlQKf/nu8LsTF1WaOQCzGvLHMsGoSMT
 Jb+iVmLxxE
X-Google-Smtp-Source: AGHT+IFemH2YbSerqdDMCV1H0buEmn64sX/0h6J4hJnEARiCoqkQ8CIRA5lb0AaX86Ibw6wJJOM7xOwfwp5GVccEXjM=
X-Received: by 2002:a05:6102:3ecc:b0:4bb:c490:7d6c with SMTP id
 ada2fe7eead31-4c044b05107mr2010802137.9.1740743860320; Fri, 28 Feb 2025
 03:57:40 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p97dZNnizzt7Z-3_=_1bgJV0mJAd+HmK+BFmZ7rhmdx+uQ@mail.gmail.com>
 <43dc4f73-0eff-41bc-a963-f67189f02dc2@gmx.de>
In-Reply-To: <43dc4f73-0eff-41bc-a963-f67189f02dc2@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 28 Feb 2025 17:27:29 +0530
X-Gm-Features: AQ5f1JqmbV-IloIiqMsX0Vf3AsB4-FYAlktSQlvXRQggeTzoE-CHMf860vXMcRw
Message-ID: <CADg8p97Wg8YLR3xztK1whS6u39vLJMQbtQzjUDjtEZFAsA_SLQ@mail.gmail.com>
Subject: Re: Re-installation of device-tree as EFI configuration table
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

hello Heinrich,

On Fri, 28 Feb 2025 at 16:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.02.25 11:34, Sughosh Ganu wrote:
> > hi,
> > The logic in efi_install_fdt() is such that with the
> > EFI_FDT_USE_INTERNAL passed as a parameter to the function, the EFI
> > configuration table is first checked to see if a device-tree(DT) has
> > already been installed as the configuration table, and in case a table
> > is found, the function returns without any other changes. However,
> > there might be scenarios where the earlier installed configuration
> > table might not be up-to-date, and in need of modification. One such
> > scenario is that of adding a pmem node to the DT that is to be passed
> > on to the OS. There could thus be a scenario where a DT that is
> > installed as a configuration table does not have the pmem node, or it
> > might have the wrong/stale values for the pmem node. Should there be
> > some logic to indicate that the configuration table needs to be
> > re-installed afresh so that these scenarios can be handled. Thoughts?
> >
> > -sughosh
>
>
> Hello Sughosh,
>
> The logic dates back to
> 6182495e101f ("efi_loader: need either ACPI table or device tree")
>
> There are more scenarios where keeping the prior device-tree may be wrong:
>
> We could have a first boot option specifying a device-tree where the EFI
> binary returns to U-Boot and a second boot option tried afterwards that
> comes without device-tree.
>
> So we should always install a new device-tree.
>
> I wonder if in copy_fdt() we should avoid a memory leak by keeping track
> of a prior allocation by copy_fdt() in a static variable.

Yes, that would have to be handled if we install a new device-tree on
every invocation of efi_install_fdt().

>
> Do you intend to send a patch?

Yes, will take this up. Thanks.

-sughosh

>
> Best regards
>
> Heinrich
