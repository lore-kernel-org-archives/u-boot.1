Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1B606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JuCKExBa;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tb3zFf4R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F245A80EAD;
	Mon, 16 Nov 2026 20:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mE_ZL09d9eUi; Mon, 16 Nov 2026 20:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFC2180E4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794859267;
	b=PKJAKa1Jp7g21U+dsQmqcOT+tkMVG9OgvtsyiRa3YO4lDFSjdlzPDMO4l3FsOngqsbii
	 +1EdHvTC5NZ4woyw+6rPeT84a/vaU/lDdfdV04viJ2nTY1kuQlbdTbdAETqMA8csyR5YZ
	 V42hjaSL3I1ShMv5YZz9p1k7pNQjLRYiL6bJGenbJVcEvsTGqco1OTWC+uzkKJO8SPZWW
	 FqwmcV1IO3pr7v5cX2sJ/WeRZqm5tXYqSVoUTj2aHId7fGx0tNqDRxvl+wadbGAp4zkTu
	 NrBjtSIHizNFvm56/IWU3VDqEA7L7cop+Q2Ku1XI8kaJnUNpDVZFRUHaQ0scDsITBuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794859267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R3A5yS/f0AxJeeOi/HdQSwOWAoqsYtOxk1OidwrT2Tc=;
	b=ZtmlojZpJfmgHJMPE9JVV+837LRMa1PmlETooaKYpMiKT0aL5Pz+gKIyeEQBc5Z0JCEv
	 TNVsD1rHL5rwzkl9kZCik10Y1+Kjf33Bgma+40z6/iXhRTJTPxXtHrd9BEOtVpEr5+TdY
	 Z9mQZULl6398PrgrvOtWjDXvtHW9DdFs/vh9Oixg59tSU71HdoX3w9cqdvd9O7JHyFTGr
	 Sq9dti5Bnf/7QLel7aqRbhFEt+er/x5+QgqjBbyZ31gpPK6hV2U3otnWqgUXFCEvOI92M
	 e7PNAlFIu+p2bpFGmadDc+NahN/uNBf2J9PGDdxeCbRXQAqtAM0Ni80Dn89jiWoL8BA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794859266;
	bh=R3A5yS/f0AxJeeOi/HdQSwOWAoqsYtOxk1OidwrT2Tc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JuCKExBanfWmO03Ywc2ew52dyTjVB04GtE44Z9gE1kTz2jCrgJsq40o03/+q8uFFJ
	 ipw81tnGkPYauVOkS9Ff/k9MfocdI1/s09PCkzaF6QjkrbsR/UENtdg7OLZ132IGBL
	 zjrnRP+1BnVKzwN/htvPwQpgA9X9THK5CRLdrib10V/noE6iPilw0QbBCkbNmhm0FU
	 QkyzcHM2B2OD9is4Iu9TPzdErYkL00SnytZ52gAkvXs1D7mKPTOL2Mwi/V+usb2hgE
	 kHh1z0mc+GCH1nyTv9JnwSQXWik/jM1Q+xr9PaNSy9Ezocgm3jZJCYeCdPr9drQG1j
	 w1/1zXvDWKX5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFC2180E4D;
	Mon, 16 Nov 2026 20:01:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53B1470B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 307D940766
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zAl4ylchozI3 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A6D064075F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tb3zFf4R
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6D064075F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:01:02 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b0d126f631so35546527b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794859262; x=1795464062;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R3A5yS/f0AxJeeOi/HdQSwOWAoqsYtOxk1OidwrT2Tc=;
 b=tb3zFf4RPzh2cmfMQ5tvv/M7h2xVEeGx1peA5d6HpFJ14IOeS0CvA2BHawoxbdB7RP
 uN93XH6SlczOMQTTEh7vFosc1aO4TIppZAJJRB4YaCKwugpfxlm5uwGSmLDlh/bPqKHq
 QYcy/yqky6XclNwQEOzgfgghS3ChLL+hgqlsm683Sq0015kUWos6cH83gqBfXqzY8HpO
 BHNesfpB+kcKPvrNST9d+kaTpRAMYicyRkwboTqzIpNMO+HUmIYQtHpbkrXuaAgBSCeF
 vP9bCq531on0sORHd9oDy8WYUCHqDdoqx2dRD5zfoYwAQuI+R0c6MkNMAdIahqGNv/tz
 6c8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794859262; x=1795464062;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R3A5yS/f0AxJeeOi/HdQSwOWAoqsYtOxk1OidwrT2Tc=;
 b=H5ZL0s+5SFE3BZI6nPI8I2aMHRM5H6kSnDJhLyYdJs+hSWXnZHdEYP6y5GBmXGLtD+
 lyJnu1Q8UI0VnZ8BZ0UxJBCoJ2HrjOAf3VCzS/Fi9GjGHVQBeDwoaii2r9WxKEgIyOVN
 veIJyfatsptd9dSsohsC6pnz9PIEab2mm2tNdz/EbI99jnwuqPSXZbf+nfJ6mHYBcdyf
 YHY2RLY2awtGXt4riYc0o8DYuR4whtzT5avd+yK7DUCmErNQBmMRAEAJAWxOxpGcvf7P
 hQwdeWZMgXm4wtUi62t/xoPKOOxWnu1tK1NiOoVAXSmTyNxXrW1UQ/2zh8UvSC0ajiVW
 ICzw==
X-Gm-Message-State: APuU4Z8MXW6J/JtYPpnYY61thz698MOgl0Sj8NaVdAUIDJwfY27gQaXr
 xph5V8PH23ukudE4RpIC5tjLJRVIf5uT9x6Qw8VEt6Vxae6Zerj9Zd/Ygnxyt5Un7NImwqYZ6na
 N9F5RnJo9wG6gkB4vXtxyJoSLcyGt0e2s5UTBBRksog==
X-Gm-Gg: AZFdTZdwF+DQhHEvzYWc4TvpsBSQWYQ5/MJtzxOHXyMXDcKe3y33Kwm0O1WOWfqw35a
 1RLGXjOeeTnOhu1IS3QLmZ9zndsd5QqqpBh/v5ZSTL9RFCoyIlGMc+Lr4iKghr5sAwVXa4gSM1N
 S9mkzxBMFHxbmIdK4wp+xYBOMe1uz4IX23Y3eUekv3QDnelHlD9wvbN2ugKrMXmd5JWtjpAUjgT
 eefY3DDFlRHgxR2GeqDmVkmw0O/BNt9+gtTG+p7N5j/czT9qe7vjKjVqXS6Ra9Ik40P/ZKkhh/R
 flEHtBIgUxjZh3ZSijsN7TbSRLok147uiMglFLEPO5AFlvDSIjSOXO2k+iomGeEnpA8AWQt6z7Q
 ra97akZ/C1eLkKCbN+BAjy8BdG2o7RSjtKSj3743/js/PMx1/imq3Nv5KJT5tISa65SZLubJjxh
 Qxwh+Wg30peeoBsm/9GKh/sehbkEUSPboZD5G7BXLIwA7wPSIcNmObkBHNABKNw1waD7xvAQ6og
 j3Y5nOoyAuVk4IngmOvagjYJeDqjFh2y0kuYayb2/p9j4ADbFGavOdrkJn+Pmo8eeLKAnvi8iBr
 Hf6VQYaK8F4z+riT9i3aCknZrwxRjzR45r6xf2T3KXMM9RF7g0Suu/IH1ahz3ipuKca3WcyL9ZH
 0iNEolTZ++RMwyiD9odE4eHdfegKlM6JhkZFhuqhTjJuncLJvhUZ7/fylXEx4u60LU67hpRpRWb
 u1s3cZphGnHFVmQy1ShR5EXS8NZKJ+WFgFOYA2n+bfCpfuip83o1cYQuM2wkDEGAtKMq2c
X-Received: by 2002:a05:690e:408d:b0:67d:b08b:ef99 with SMTP id
 956f58d0204a3-67db08bf887mr2793383d50.100.1794859261626; Mon, 16 Nov 2026
 12:01:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Nov 2026 22:00:23 +0200
X-Gm-Features: AclHuK8CstZUw7Y-z3aIbpj4q__LJCbp9hBqRItXs6mA9MJJXXQcycM35QZfRhc
Message-ID: <CAC_iWjJJdWmZGE-bn+NZhY6Uf9PVkpVLB4i+Oj+mMtLz0MAxSA@mail.gmail.com>
Subject: Re: [PATCH v7 00/22] arm64: FF-A runtime transport for EFI variables
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Harsimran,

The CI is broken on this one
https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/2063

We are already in v7 and skimming through the patches I found more
things that will break EFI runtime. I'll add comments in the patches
later this week. We are on v7 and I'd like to start making the
patchset smaller. You need to break this down and send a series of
patches that are already reviewed/acked (the ff-a arch parts?) so we
can move it forward.

Thanks
/Ilias

On Tue, 10 Nov 2026 at 11:58, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
> Hi all,
>
> This series adds FF-A runtime transport support so EFI variable runtime
> services can communicate with the secure world after ExitBootServices().
> It also extends tests, documentation, and Corstone-1000 configuration to
> validate the runtime path and keep boot-time behavior aligned with the
> runtime flow.
>
> Changes in this series:
> - Add EFI runtime-safe memset helper and FF-A runtime transport support.
> - Add runtime-safe FF-A direct-message handling and ExitBootServices setup.
> - Implement FF-A runtime communication in the EFI variable TEE backend.
> - Enable EFI runtime SetVariable(), GetVariable(), GetNextVariableName(),
>   and QueryVariableInfo() over the FF-A transport.
> - Add sandbox FF-A runtime transport tests.
> - Extend EFI selftests for runtime variables and enable bootefi selftest
>   on Corstone-1000.
> - Document the FF-A runtime transport and runtime-variable selftest flow.
>
> Testing:
>
> Tested on Corstone-1000 FVP with the Trusted Services SMM Gateway SP.
> The instructions to build and run the Corstone-1000 FVP are available at:
>
>   https://corstone1000.docs.arm.com/en/corstone1000-2026.05/user-guide.html
>
> The SMM Gateway SP provides the MM variable service and exposes the MM
> Communicate endpoint over FF-A direct messages.
>
> The EFI runtime variable selftest was run in two phases. The setup phase
> creates a non-volatile runtime variable before reset. On the U-Boot
> prompt:
>
>   corstone1000# setenv efi_selftest 'variables at runtime setup'
>   corstone1000# bootefi selftest
>
> Then reset the Corstone-1000 FVP and run the verify phase. The verify
> phase checks that the variable is available after reset, then exercises
> the runtime get/set/append/delete paths. On the U-Boot prompt after
> reset:
>
>   corstone1000# setenv efi_selftest 'variables at runtime verify'
>   corstone1000# bootefi selftest
>
> Both phases completed with Summary: 0 failures.
>
> Additional testing:
> - Tested the OP-TEE/non-FF-A QEMU setup by booting Linux through U-Boot
>   EFI and mounting efivarfs successfully.
>
> Changes in v7:
>
> Address Ilias Apalodimas's review comments:
> - Rebase the series on top of U-Boot main.
> - Fix per-patch buildability of the runtime variable patches.
> - Move the u16_strsize() runtime annotation before runtime callbacks are
>   installed.
>
> Link to v6:
> https://www.mail-archive.com/u-boot@lists.u-boot-project.org/msg09457.html
>
> Link to v5:
> https://mail-archive.com/u-boot@lists.u-boot-project.org/msg05824.html
>
> Harsimran Singh Tungal (22):
>   efi_loader: add runtime memset helper
>   arm-ffa: store boot-discovered runtime data separately
>   arm-ffa: add runtime-safe FF-A SMC wrapper
>   arm-ffa: add runtime direct-message support
>   arm-ffa: reuse direct-message helper at boot time
>   arm-ffa: enable runtime context at ExitBootServices
>   arm: cache: keep range maintenance available at EFI runtime
>   efi_loader: add MM SP status mapping for FF-A variables
>   efi_loader: make MM transport selection runtime-safe
>   efi_loader: make FF-A MM SP notification runtime-safe
>   efi_loader: make FF-A MM communication runtime-safe
>   efi_loader: reserve FF-A shared buffer for runtime variables
>   charset: mark u16_strsize() as __efi_runtime
>   efi_loader: enable TEE runtime SetVariable() over FF-A
>   efi_loader: enable TEE runtime GetVariable() over FF-A
>   efi_loader: enable TEE runtime GetNextVariableName() over FF-A
>   efi_loader: enable TEE runtime QueryVariableInfo() over FF-A
>   corstone1000: enable bootefi selftest
>   efi: selftest: add runtime variable tests with non-volatile storage
>   test: dm: add sandbox FF-A runtime transport tests
>   doc: arm64: document FF-A runtime path for EFI variables
>   doc: bootefi: note two-phase runtime variables selftest
>
>  arch/arm/cpu/armv8/cache.S                    |   8 +
>  arch/arm/cpu/armv8/cache_v8.c                 |  20 +-
>  arch/sandbox/include/asm/sandbox_arm_ffa.h    |  16 +-
>  configs/corstone1000_defconfig                |   3 +
>  doc/arch/arm64.ffa.rst                        |  88 +-
>  doc/usage/cmd/armffa.rst                      |  11 +
>  doc/usage/cmd/bootefi.rst                     |  31 +
>  drivers/firmware/arm-ffa/Kconfig              |  11 +
>  drivers/firmware/arm-ffa/Makefile             |   4 +-
>  drivers/firmware/arm-ffa/arm-ffa-runtime.c    | 294 +++++++
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c     | 114 +--
>  drivers/firmware/arm-ffa/arm-ffa.c            |  16 +-
>  drivers/firmware/arm-ffa/ffa-emul-uclass.c    |  49 +-
>  include/arm_ffa.h                             |  16 +-
>  include/arm_ffa_priv.h                        |  22 +-
>  include/arm_ffa_runtime.h                     | 191 +++++
>  include/efi_loader.h                          |   3 +
>  lib/charset.c                                 |   2 +-
>  lib/efi_loader/Kconfig                        |   4 +
>  lib/efi_loader/efi_runtime.c                  |  20 +
>  lib/efi_loader/efi_variable_tee.c             | 780 ++++++++++++++----
>  .../efi_selftest_variables_runtime.c          | 715 ++++++++++------
>  test/dm/Makefile                              |   3 +-
>  test/dm/ffa.c                                 |   6 +-
>  test/dm/ffa_runtime.c                         | 123 +++
>  25 files changed, 2031 insertions(+), 519 deletions(-)
>  create mode 100644 drivers/firmware/arm-ffa/arm-ffa-runtime.c
>  create mode 100644 include/arm_ffa_runtime.h
>  create mode 100644 test/dm/ffa_runtime.c
>
> --
> 2.43.0
>
