Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90859C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 10:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B8987BB5;
	Wed, 24 Jan 2024 11:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lx2QMguT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23BD87BC7; Wed, 24 Jan 2024 11:06:02 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0408187BA2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so530626566b.0
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 02:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706090759; x=1706695559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q14eUzDXxoRiCE2j4s6edIvMWBb3WcGTrKExu1gQjIU=;
 b=lx2QMguTtB6Q+9uDRRVvmnbkqxV3fl2bsIEsVVZBXsr3oNfTzgWFmQcOKAqGV5+ChI
 Jmecz7N0bu703aqPvfVqaonIVTpasa4Ie0FsNJaK/a5AXwxWcByr1rQuseGQutljhXLR
 ECkwGWVZCGt/2ET/SuhehB/1MvuqYh3neFYAZaGx254gfk3c23wMQ9zm8iG1/CgtwVCI
 2vOrIvFdkZ4Zlis3VBaG2FCbEUVAWYGup89mg3BCqoT3OlRNYAYPLKP+LAWjaB7EYU7y
 RfKboFCtD5IVKyZrvNbSZZm9CEiL9zEmI9QoE/5lRs0WlPnPf/gV4OlwgCuYfXj6C9rx
 4T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706090759; x=1706695559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q14eUzDXxoRiCE2j4s6edIvMWBb3WcGTrKExu1gQjIU=;
 b=GovGjCz2TIokQFY6R1z+2QBwvuEgNuhM5BGlc3kRqCnnDl7oCU5upfd9AXPYRPRC3W
 TkAQ0gbGZ8iH5NTgiLIDkKBAWpcPuHnIZnFhOUbdexPD5N+hLm7OZvyyc0rL/bO9Wimr
 sjjgLKXiUskxtlakuJ2jJlbpRv3KmKyLs5m7pDXYs0eRb7mbkXKGDkdCuNXKwSeNLmYo
 ZhO8fHRSYHSeet6oJcGg3OORA/hG5z757rDHxq8x5KsRttLQZXvEjKX9Xf35k74VSA46
 AxsNNjp0pqJaeHY2gvPgTTeN47Un3cQeH4VnqxjlB3gDvEQENnlJuWA7PcwYJ9BMRFxI
 PyCw==
X-Gm-Message-State: AOJu0YxR/AWb12OQ8bpDwZG9uAWDWo7o2GKdAybqQ+sCrxzqu4Gek5/7
 v6swQtWxsscP0UJpa7EHsVHsOojAH2UWLekeUUEU9r5JqItCYtRtwb2rGkllh0s=
X-Google-Smtp-Source: AGHT+IHhYb9oQIa9FwDlQC+pNNnkGo1B+fsVF7t3OSVm9F8oEPBtSWfOxI+eNY88LN/aScfIZd1gLw==
X-Received: by 2002:a17:906:1392:b0:a28:b92e:c22a with SMTP id
 f18-20020a170906139200b00a28b92ec22amr766007ejc.22.1706090759403; 
 Wed, 24 Jan 2024 02:05:59 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a1709060be900b00a28148beabdsm15271543ejg.102.2024.01.24.02.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 02:05:59 -0800 (PST)
Date: Wed, 24 Jan 2024 12:05:56 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: Re: [PATCH 00/18] FWU: Migrate FWU metadata to version 2
Message-ID: <ZbDhBBAi1eKRHY-D@hera>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122115439.653871-1-sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Mon, Jan 22, 2024 at 05:24:21PM +0530, Sughosh Ganu wrote:
>
> The following patches migrate the FWU metadata access code to version
> 2 of the structure. This is based on the structure definition as
> defined in the latest rev of the FWU Multi Bank Update specification
> [1].
>
> Since the version 1 of the structure has currently been adopted on a
> couple of platforms, it was decided to have a clean migration of the
> metadata to version 2 only, instead of supporting both the versions of
> the structure. Also, based on consultations with the main author of
> the specification, it is expected that any further changes in the
> structure would be minor tweaks, and not be significant. Hence a
> migration to version 2.

I think this makes sense. We've already verified Socionext doesn't mind
dropping v1 support. If some from ST doesn't have objections, only
supporting v2 will simplify the code a lot.

Thanks
/Ilias
>
> Similar migration is also being done in TF-A, including migrating the
> ST platform port to support version 2 of the metadata structure [2].
>
> The patches have been tested on STM32MP1 DK2 board and the Synquacer
> board from Socionext. This covers testing both the GPT and the MTD
> partitioned storage devices for the metadata access.
>
> [1] - https://developer.arm.com/documentation/den0118/latest/
> [2] - https://review.trustedfirmware.org/q/topic:%22topics/fwu_metadata_v2_migration%22
>
> Sughosh Ganu (18):
>   configs: fwu: Remove FWU configs for metadata V2 migration
>   fwu: metadata: Migrate to version 2 of the structure
>   drivers: fwu: Add the size parameter to the metadata access API's
>   fwu: Add some API's for metadata version 2 access
>   lib: fwu: Make changes to support version 2 of FWU metadata
>   drivers: fwu: mtd: Allocate buffer for image info dynamically
>   drivers: fwu: Allocate memory for metadata copies
>   fwu: Add a function to put a bank in Trial State
>   capsule: Accept a bank on a successful update
>   fwu: mtd: Modify the DFU API's to align with metadata version 2
>   efi_firmware: fwu: Do not read FWU metadata on sandbox
>   efi_firmware: fwu: Get the number of FWU banks at runtime
>   cmd: fwu: Align the command with metadata version 2
>   test: fwu: Align the FWU metadata access test with version 2
>   fwu: Remove the config symbols for number of banks and images
>   tools: mkfwumdata: Migrate to metadata version 2
>   configs: fwu: Re-enable FWU configs
>   doc: fwu: Make changes for supporting FWU Metadata version 2
>
>  arch/sandbox/Kconfig                     |   6 -
>  board/armltd/corstone1000/corstone1000.c |   2 +-
>  cmd/fwu_mdata.c                          |  43 +++-
>  configs/synquacer_developerbox_defconfig |   1 -
>  doc/board/socionext/developerbox.rst     |   9 +-
>  doc/develop/uefi/fwu_updates.rst         |  12 +-
>  doc/usage/cmd/fwu_mdata.rst              |  12 +-
>  drivers/fwu-mdata/fwu-mdata-uclass.c     |  10 +-
>  drivers/fwu-mdata/gpt_blk.c              |  27 +-
>  drivers/fwu-mdata/raw_mtd.c              |  85 ++++---
>  include/fwu.h                            |  94 ++++++-
>  include/fwu_mdata.h                      |  56 +++--
>  lib/efi_loader/efi_capsule.c             |  12 +-
>  lib/efi_loader/efi_firmware.c            |  20 +-
>  lib/fwu_updates/Kconfig                  |  11 -
>  lib/fwu_updates/fwu.c                    | 308 ++++++++++++++++++-----
>  lib/fwu_updates/fwu_mtd.c                |  76 ++++--
>  test/dm/fwu_mdata.c                      |  56 +++--
>  test/dm/fwu_mdata_disk_image.h           | 124 ++++-----
>  tools/mkfwumdata.c                       |  43 +++-
>  20 files changed, 705 insertions(+), 302 deletions(-)
>
> --
> 2.34.1
>
>
