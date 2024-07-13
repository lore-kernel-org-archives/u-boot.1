Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94839C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE6ED8886D;
	Sat, 13 Jul 2024 17:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fWECsvJ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 661A48886D; Sat, 13 Jul 2024 17:15:42 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3381887E13
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70af0684c2bso2182611b3a.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883739; x=1721488539; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+dcNbFQOGcRlZxRSHC90EW8ae3H0mQnVAwLpwdJki7I=;
 b=fWECsvJ8pSAQm2So4xHLOqbRmeEqqQxHTthdNcaa+AZ1iEHG0xfGkw5EJaSkMnYMI3
 Kn70d20E6lulKiAB8JM1k0vHE+h9ZT40tTPP9dwPh0C49KRZXI1Im2NccL0eHzCHlgIW
 E/mPxMDlmsLvl6JU8PAJ8ZK+WCg5+LRh/IMvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883739; x=1721488539;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dcNbFQOGcRlZxRSHC90EW8ae3H0mQnVAwLpwdJki7I=;
 b=Wm+nHl3ZNE8EqgZRofDfvqYYT22jPQIvyKLd4Uw73maDY6CPyvBnNiOaZxEfJSsAXb
 IRVn5gHKLW+zyXlqpI0ipvu+EASI3iU4wjQfPfL9+jkJBsPF4PhuL1ItIc4IcQkZGxsL
 xy15bcXUTGV1XEEMAuKdZyV28Wf9fnIbzKHj3UyW9ku14ZWBPeeu8ZKgoB0mv6QDTTZ9
 hHGUN0qJ3HrGxuj8FKSrDQ0FfIoyA4crqqAeWF5Ug/BzOwwSnVrapx4zb0o9AYtZKwkl
 IVS8XiS6hcSf4kksPyQyCHJMpG6RgPXdG6mlHPIVOn/5aKyLih5VX6jqbj1apRSPXHMq
 PjVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoxH6UdVLTOFmLpEkiTQQOcaEGv7uN/47ExYlqJ4akpGihlnGzU3ceRllN0gsllIb0prDW2JSt7AC3Agf4K8pstu9CHA==
X-Gm-Message-State: AOJu0YwoZtpN+R1JMSKfluS9/Z4UaBIDVwecgyqUAymjxll6fvOScZA4
 VsfOculcEmv4RrfxY9RUYfUw6mWdXx4VYjB9ucNjlpidDyjWv6Uu0iI8dnYnNWb/VCBCT3jSY+9
 C4LpEYf+wkNmUlJwF3ENTNcUi4If9RTehGNmg
X-Google-Smtp-Source: AGHT+IGi1kPSsCfPegwcim+6q4ZzUvsdMMPUuRWwmfFtrkm04FVFOHXt5V79UlkQw/uv0BPYczT7d1Kpqy/dGbk2itE=
X-Received: by 2002:a05:6a20:6a21:b0:1c2:8c8f:aa0c with SMTP id
 adf61e73a8af0-1c298203935mr16278713637.12.1720883738736; Sat, 13 Jul 2024
 08:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708143518.GC38804@bill-the-cat>
In-Reply-To: <20240708143518.GC38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:26 +0100
Message-ID: <CAFLszThqo=2Gzc4wFoFRmkctJ2514oVnN-rvtzfvvxQRuNyzXw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi Sugosh,

On Mon, 8 Jul 2024 at 15:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:

I don't believe coherent is the right word here. Perhaps 'more
persistent' is better?

>
> > The aim of this patch series is to fix the current state of
> > incoherence between modules when it comes to memory usage. The primary
> > issue that this series is trying to fix is that the EFI memory module
> > which is responsible for allocating and freeing memory, does not have
> > any visibility of the memory that is being used by the LMB
> > module. This is further complicated by the fact that the LMB
> > allocations are caller specific -- the LMB memory map is not global
> > nor persistent. This means that the memory "allocated" by the LMB
> > module might be relevant only for a given function. Hence one of the
> > requirements for making the memory usage visible across modules is to
> > make LMB allocations persistent and global, and then have means to
> > communicate the use of memory across modules.
> >
> > The first set of patches in this series work on making the LMB memory
> > map persistent and global. This is being done keeping in mind the
> > usage of LMB memory by platforms where the same memory region can be
> > used to load multiple different images. What is not allowed is to
> > overwrite memory that has been allocated by the other module,
> > currently the EFI memory module. This is being achieved by introducing
> > a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> > re-requested once allocated.
> >
> > A review comment on the earlier version was to do away with the static
> > arrays for the LMB lists of free and used memory. This version
> > uses the alloced list data structure for the LMB lists.
> >
> > The second set of patches are making changes to the EFI memory module
> > to make use of the LMB functions to allocate and free memory. A
> > *_flags() version of LMB API's has been introduced for the same. The
> > earlier version was using notification mechanism from both LMB and EFI
> > modules to maintain memory coherence. This version makes use of the
> > LMB API functions for the memory allocations. This is based on review
> > comments of EFI maintainers.
>
> Please re-work so that the series is bisectable. For example
> xilinx_zynqmp_r5 fails that check currently. And I found that looking in
> to why it grows by ~1500 bytes overall. This likely is due to
> CONFIG_EFI_LOADER=n and so while the case where EFI_LOADER is enabled
> tends to be a size win (reduction) or wash we need to look at the
> CONFIG_EFI_LOADER=n case more. The alist code will be a little growth
> and that's fine enough. But realloc and do_bdinfo are the two big
> growths at the top, in this case.
>
> --
> Tom

Regards,
Simon
