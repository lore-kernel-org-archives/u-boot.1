Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063F1C47077
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 00:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574398798F;
	Mon, 15 Jan 2024 01:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZAbJKCF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED948309D; Mon, 15 Jan 2024 01:59:10 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAEF8309D
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 01:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-20418dd34e3so1639939fac.0
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 16:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705280342; x=1705885142; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tq/fAAah+lwBY/FQ3U4zyI3XSDlog3XV2tHOCp2l7nQ=;
 b=ZAbJKCF6zNk/Owc6WVT7WbMWwTghrcwJKM5eVNci3Iy6fvGwgZdNcnpaSwufXho90E
 1hKpWpcIKqZP/b93Yg4UBIUMHpunmL4b16Ao5EG5IbkagVajo0S7s73HEtoCFtYCOFI4
 sPCh6IMa1i+NVHitCGnsOJTFzHM6Fo/dJPe8zqT1x3+zpLQsXqsix+FXc0GSCfrgDFpO
 T6d30Dua1BpKjxTr/pbfn4UZHzACjgWXW6ZP0znTh24fAwiFZdpC9axWsgS8x1h4BEQC
 QGc66j3hcox1upCfjqOwvHG/ss0h6VDqMrwTHd5wSam7ySKx05fWCJbRiHeTlNIRUZCG
 POuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705280342; x=1705885142;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tq/fAAah+lwBY/FQ3U4zyI3XSDlog3XV2tHOCp2l7nQ=;
 b=uscEbCZ2+xBrzm4E0kPR82pgTOxjE4fxXmoEqjYqoUQ2KvnlS0zIgCrXRBVon0Wxiu
 vNOtzWM+67PnjdEORRNTN5IoAh7vJNl3zbRhGOY1YqI5zLgC6sBCdpIJ4p1SPEhyjrQw
 /cDt8+YyYZP4Jm8dRKJsmJMk27dMOkbDmdySUYLQk5zskdSSpU6gWoN6DYSeq72s8Fgm
 bUkY7b9FlLHpp+XpSTS7G5ndEjNlV8PgK+B65XcPXbcOjJggFJUvR16MJttZ0e1AlZak
 xeA4kgatYDpQDywS+cOQMHofxbFQfPmDMVsBL5DanQ/0trqWyIVAqn0CtqX019obGoQv
 MOWQ==
X-Gm-Message-State: AOJu0YwuTO+U/NGvDTcsEuRmmlJWmewKDb3ROjtEQrg/xsKrG0Tk2D1O
 xQ8F/1Erj6pPAtpIWyrBKqSyyf4KGsvznw==
X-Google-Smtp-Source: AGHT+IEyM04W+wwgLsO50bEWeWG2Z4f/SZcG4AMva+pgccFJ9yVcFSfQsWrxNiU0eRughn96mtzQ3g==
X-Received: by 2002:a05:6358:91d:b0:175:e3a6:be47 with SMTP id
 r29-20020a056358091d00b00175e3a6be47mr2877896rwi.1.1705280342035; 
 Sun, 14 Jan 2024 16:59:02 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:4e3a:6682:78c7:6f45])
 by smtp.gmail.com with ESMTPSA id
 b12-20020aa78ecc000000b006db105027basm6524713pfr.50.2024.01.14.16.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 16:59:01 -0800 (PST)
Date: Mon, 15 Jan 2024 09:58:58 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Message-ID: <ZaSDUrTQ2Z5N+gil@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
 <20240110011637.174710-3-takahiro.akashi@linaro.org>
 <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de>
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

On Sun, Jan 14, 2024 at 01:46:45PM +0100, Heinrich Schuchardt wrote:
> On 1/10/24 02:16, AKASHI Takahiro wrote:
> > At this point, EFI boot manager interfaces is fully independent from
> > bootefi command. So just rename the configuration parameter.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> This patch breaks the 'bootefi hello' command in
> qemu-riscv64_smode_defconfig and other QEMU defconfigs.

What happened? Please elaborate details so that I can trace your issue.

On my side, I didn't see any problem with "bootefi hello" on qemu-arm64
and moreover CI check (github pull request) didn't complain anything.

-Takahiro Akashi


> Best regards
> 
> Heinrich
