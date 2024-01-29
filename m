Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DE6C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE9E87C9B;
	Mon, 29 Jan 2024 13:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pijQoY39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D0187CE2; Mon, 29 Jan 2024 13:24:13 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 499F08798C
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6039716f285so17610077b3.2
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706531047; x=1707135847;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2idnBMfhO9uerqo7ZWilRdDMThGh/0eq+hVA9ncs0A=;
 b=pijQoY39YL0D7GPKLbg1RGbuSP1VpdBxriRbemnmYQFJnQoKJZp0tHxPCujmSN1TsX
 2FWXfDdBgkPcF3ADl6H9MvIAVi8t14NFMOusmj9kkfE6UYiSsmP3DjPHDxjQ1AVspLj7
 V4tqcoiOpb0mg/KWKHZoPTzQREbY73gR47Rmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706531047; x=1707135847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2idnBMfhO9uerqo7ZWilRdDMThGh/0eq+hVA9ncs0A=;
 b=QPudToq/fPBG+OdDHVGEYnR+c3JdPd2VIaxk0MrlVUpny6+sBllEHJy/Bc6AhutNKj
 OUZr576GcnjEE3zLTmh67A485d5ONFhFIg9Hj/I/AeuiScBZkc4svG8eLhKDUF7naIqs
 1kqF/cD8O5DiSXLC1w9sgQjQSmKkXZ5b8VsTQazsH4PV/UNRuW35fIR401lF6wjvKU92
 c74eneJJnBVROZSOTuDOMyOeq7ENt8Ia+M+Kv+IPgucjkkMmf5J2M8kpYeETvhdTs235
 E4YgzeY0zjVpVO+59BOf96Vqd1VarNUJgZH+tpX5IZwjjj0MvbgCDuIXAnJTFG8FuLEb
 omFw==
X-Gm-Message-State: AOJu0YyJ+W3NSuq2z4Bs0+sTQJMf+duqbuaqzoFSUiVgTDhiDW9v4PH9
 XLdNzWgwI8A6IT9OB3pgRVeZUYdKbd9WBSMYwA3o3kcICgqTE9jo8CJnt7pAvBAp3WXJDYMczCn
 HcX4dKDWFDf/UFqV9ecFSz/WvKcvWRa0X3nmYJQ==
X-Google-Smtp-Source: AGHT+IH9r3cd8XTrdYkQnFhSGl4CJsrnXNWlfiy+5hoRaEzJJ8xiSXNtasWm7X1HycTufN7cFVvgI1GxyjsbexF1ZfM=
X-Received: by 2002:a0d:df16:0:b0:5f0:42de:8c3b with SMTP id
 i22-20020a0ddf16000000b005f042de8c3bmr4312840ywe.36.1706531046971; Mon, 29
 Jan 2024 04:24:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:53:55 +0530
Message-ID: <CAMty3ZBMd06bj8gJOv99nMfmk70BmBRiPaFdRVBh9CKgmxDapw@mail.gmail.com>
Subject: Re: [PATCH v2 00/30] Fix issues with QSPI and OSPI compare failures
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 michal.simek@amd.com, vigneshr@ti.com, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 6, 2023 at 3:02=E2=80=AFPM Tejas Bhumkar
<tejas.arvind.bhumkar@amd.com> wrote:
>
> A set of patches has been developed to resolve concerns regarding data
> integrity failures in QSPI and OSPI for the Versal, Versal NET, Zynq,
> and ZynqMP platforms.
>
> The series has undergone testing with flashes on the default setup,
> and comprehensive testing is currently underway to test the series
> with all available flash parts.
>
> These patches are built upon the v5 series, which can be found at the
> following link:
> https://lore.kernel.org/all/20231201031839.239567-1-venkatesh.abbarapu@am=
d.com/
>
> Changes in v2:
> - Removed the SPI_NOR_HAS_TB flag for gd25lx256e and is25wx256 flashes
>   since it already exists in a tree.
>
> Algapally Santosh Sagar (1):
>   mtd: spi-nor-ids: Add support for W25Q02NW
>
> Ashok Reddy Soma (10):
>   mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx flashes
>   mtd: spi-nor: Add support for cross die read in dual flash
>     configuration
>   mtd: spi-nor: Enable DTR octal flash program
>   mtd: spi-nor: Send write disable cmd after every write enable
>   mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only if SFDP is enabled
>   spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
>   spi: cadence_qspi: Clean up registers in init
>   spi: cadence_qspi: Initialize read and write watermark registers
>   spi: cadence_qspi: Enable ECO bit for higher frequencies
>   spi: cadence_qspi: Write aligned byte length to ahbbase
>
> T Karthik Reddy (9):
>   mtd: spi-nor: Add config to enable flash DTR
>   mtd: spi-nor-core: Set dummy buswidth equal to data buswidth
>   spi: mtd: Use split reads if multi-die flag is set
>   mtd: spi-nor: program quad enable bit for winbond flashes
>   spi: cadence_qspi: Setup ddr mode in cadence qspi driver
>   spi: cadence-qspi: Switch SDR/DTR using SPI_FLASH_DTR_ENABLE config
>   spi: cadence_ospi_versal: ospi ddr changes in cadence ospi versal
>     driver
>   spi: cadence_qspi: Add spi mem dtr support ops
>   mtd: spi-nor: Add block protection support for micron flashes
>
> Tejas Bhumkar (5):
>   arm64: versal: Enable defconfig for Micron octal flashes
>   mtd: spi-nor: Update erase operation function
>   spi: cadence_qspi: Fix versal ospi indirect write timed out issue
>   arm64: versal: Enable soft reset support for xspi flashes
>   arm64: versal: Enable octal DTR mode
>
> Venkatesh Yadav Abbarapu (5):
>   mtd: spi-nor: Update block protection flags for flash parts
>   mtd: spi-nor: Add support for locking on Macronix nor flashes
>   mtd: spi-nor: Add support for locking on ISSI nor flashes
>   mtd: spi-nor: Add support for locking on GIGADEVICE nor flashes
>   mtd: spi-nor: Add support for locking on Spansion nor flashes

Look like there are 3 or more topics are covered in single patch set,
please break them and send separate series.

Jagan
