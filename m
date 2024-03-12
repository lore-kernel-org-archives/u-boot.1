Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F9C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3E687F65;
	Tue, 12 Mar 2024 16:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A019387D3C; Tue, 12 Mar 2024 15:58:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 58686875B9
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:58:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bence.balogh@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69B2FEC;
 Tue, 12 Mar 2024 07:58:51 -0700 (PDT)
Received: from e126523.budapest.arm.com (unknown [10.57.81.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AD473F762;
 Tue, 12 Mar 2024 07:58:12 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:58:11 +0100
From: Bence Balogh <bence.balogh@arm.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: Re: [PATCH 0/4] Generate capsules from config files
Message-ID: <20240312145811.GA407350@e126523.budapest.arm.com>
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
X-Mailman-Approved-At: Tue, 12 Mar 2024 16:00:41 +0100
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

Hello Sughosh,

We are planning to use these changes in the Corstone-1000 platform.
Do you have a timeline when these are going to get merged?

Thanks,
Bence

On Tue, Nov 21, 2023 at 12:30:24PM +0530, Sughosh Ganu wrote:
> 
> Add support for generating capsules through a config file. Multiple
> capsules can be generated through a single invocation of the
> mkeficapsule tool, where the capsule parameters are fetched from the
> config file.
> 
> The format of the config file pretty similar to the one used by the
> capsule generation tool in EDKII.
> 
> The functionality is enabled on the sandbox variant and the EFI
> capsule update test is now configured to generate the capsules through
> a config file. The sandbox_flattree variant generates capsules through
> binman, thus covering both the paths.
> 
> Sughosh Ganu (4):
>   tools: mkeficapsule: Add support for parsing capsule params from
>     config file
>   doc: Document capsule generation through a config file
>   sandbox: capsule: Add a config file for generating capsules
>   test: capsule: Generate capsules through config file
> 
>  configs/sandbox_defconfig                     |   2 +
>  doc/develop/uefi/uefi.rst                     |  70 ++++
>  .../test_efi_capsule/capsule_gen_binman.dts   |   2 +
>  test/py/tests/test_efi_capsule/conftest.py    |   7 +
>  .../test_efi_capsule/sandbox_capsule_cfg.txt  | 162 ++++++++
>  tools/Kconfig                                 |  15 +
>  tools/Makefile                                |   1 +
>  tools/eficapsule.h                            | 114 ++++++
>  tools/mkeficapsule.c                          |  87 +++--
>  tools/mkeficapsule_parse.c                    | 352 ++++++++++++++++++
>  10 files changed, 781 insertions(+), 31 deletions(-)
>  create mode 100644 test/py/tests/test_efi_capsule/sandbox_capsule_cfg.txt
>  create mode 100644 tools/mkeficapsule_parse.c
> 
> -- 
> 2.34.1
> 
> 
