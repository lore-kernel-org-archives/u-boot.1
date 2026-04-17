Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDACF99C60
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 20:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81AAD84214;
	Fri, 17 Apr 2026 22:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmkuFXK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6315C84223; Fri, 17 Apr 2026 22:39:56 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DC18420C
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 22:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8d68bcf50fdso131563585a.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776458392; x=1777063192; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GN3qKRgNqZ3Nx8dD225h1/mG+r9b6DMJ4u6PThO6oG8=;
 b=BmkuFXK1DXsZQMni/GPvq0J3oASIE3723br9bNWOWMzctcU+e7pwcWXwR/IJ1FUh90
 s8MKgu2jBgDI9bX9yvL4igs27xHLnFWgQfxy+ADKJtmJ+0LsGEvOMhzCgLc4W4h8iqx/
 vCP4yX2nKQ8ox0QhAQH2nWROxA6K8kWFCPiZPR8eS4iJ0ke9MxKUTh7WBh4etI63nUDj
 WpPaO1FCT4iSS5kfttj0c0DiPZcHbCXlajTnILL6KtAFKiz6l9zhdo/KGM9U4xHPs7kv
 MmJ4oCvWSvdFeBa4GM/jZrcqX6N7NNkjdX52iv3WwKIhEtrf52EawcR2xAbiO0JEOxMp
 B+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776458392; x=1777063192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GN3qKRgNqZ3Nx8dD225h1/mG+r9b6DMJ4u6PThO6oG8=;
 b=ZCtieQ9txSoqw/fJAebDFcqPIrn79NrWBVGBgCODvNe7WMaO+RJQDQ4xCx/kbfZWzG
 BX0HjfyacKfNfX/El55FVwm9Eci55sbzbFpSvt9zAmi6c+WRB0nN7O6xxbNlXw3iaboe
 8J7fz1fPE7lb+fnts19pRhzg78yWQ5K865egd2eprY2CLM7x/T/DWhPgWNx3hCXjaVT+
 6kdAQAvGcaBpIQgWWh6qG6sg/7U3gr1kX1Jt1ZwoU8cu1SmKMeykwZroqQTMDzuqwPAy
 ZVvz8V9XbXpwIaWiBVRSEIh48JzasOI8FfUCCmkoGlPbAA7utbXc4PonucYmk4/dRUNg
 TQtQ==
X-Gm-Message-State: AOJu0Yx4V7IIUSVgrP9NJT0RWqWU/U6nGf2HFMablKXkkZZZAZtTXCYt
 DDV406DqPXWcgLRCcTAJHGVZ32WQ+8qGPUqJ0aOFjRMndnFomUPuZ4oWSi54UlIdZM0=
X-Gm-Gg: AeBDieuKyRV9pKzDnazRbUTZvtBAkNFQciZSQ07r/72fJDDACmuFbBREugFmBqYZZEx
 ZlOeIjWmu4h6Xucc8JnWmLvjKZC5UuIUob6U30LydegfGkZ2b1Zk037zHBKbctvai+92Zct12bj
 r+kqNU6cGL95vHraJVHlYJx9R2GsQseVUwbkgmqVyfPNaELpPr3RBhL1bkQ4c2NLqHbWM+kwiHN
 3VBDsUybcliipZ4jR0F+u5FDS7Hlj9NI5UNGaPPcxJW8OD9lrkBpFnyMBDqGMt8ZPj8qGMHmE6h
 2M5KUExa5CWFy29aNNkuEK/KVN+pbT8jj0gj2jQ8n0sDbc4PCSfbZh7DIVElvPolAcpDOboFP3J
 DP0WzeQCRcclPVRLj0saju9hnyqDG5a4KpqWSf2ws2Xq4yf6r7JC0BZzjULtQy/4BkFJo1Srfhz
 XEANaBupy1vRQFB9xK/ey3GedTLFb2xgzOmHSNpM27co6QFzBwhcDfx6mVNq2FNjuGLInUtzSf5
 32eD3KZTQdP72HQ6Gfx3DmFmRi0UQ==
X-Received: by 2002:a05:620a:489b:b0:8d0:26db:4f9f with SMTP id
 af79cd13be357-8e79001504dmr622590785a.26.1776458392260; 
 Fri, 17 Apr 2026 13:39:52 -0700 (PDT)
Received: from [192.168.68.100] (172-97-209-197.cpe.distributel.net.
 [172.97.209.197]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d5fe8ed1sm198608785a.8.2026.04.17.13.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 13:39:51 -0700 (PDT)
Message-ID: <696b7f4d-e192-44e4-8652-e8db7f980507@gmail.com>
Date: Fri, 17 Apr 2026 16:39:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Add support for DT overlays handoff
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 raymondmaoca@gmail.com
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
Content-Language: en-CA
From: Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <20250718141621.3147633-1-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

The Firmware Handoff spec changes required for this series is already accepted and merged at [1].

Please review and merge this series.

[1] Add Transfer Entry for Devicetree Overlay
https://github.com/FirmwareHandoff/firmware_handoff/pull/74

Thanks and regards,

Raymond

On 2025-07-18 10:16 a.m., Raymond Mao wrote:

> The series include refactoring on bloblist and fdtdec to support handoff
> of multiple DT overlays and applying them into the DT base during setup.
> All changes are aligned to the spec update for supporting DT overlay
> handoff[1].
>
> Notes for testing:
>
> Currently DT overlay is not yet enabled in TF-A, but with the test patches
> I provided for TF-A and OP-TEE build, importing a DT overlay blob file from
> QEMU to TF-A reserved memory is supported.
> Follow below instructions to build and run for test:
> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> Replace your local qemu_v8.xml with [2], which contains all necessary
> changes in both TF-A and OP-TEE build.
> $ repo sync
> $ cd build
> $ make toolchains
> $ make ARM_FIRMWARE_HANDOFF=y all
> Copy and rename your DT overlay blob as 'qemu_v8.dtb' into out/bin
> $ make ARM_FIRMWARE_HANDOFF=y run-only
>
> [1] Add Transfer Entry for Devicetree Overlay
> https://github.com/FirmwareHandoff/firmware_handoff/pull/74
>
> [2] https://github.com/raymo200915/optee_manifest/blob/dt_overlay_handoff/qemu_v8.xml
>
> Raymond Mao (6):
>    bloblist: add blob type for DT overlay
>    bloblist: add helper functions
>    bloblist: fix a potential negative size for memmove
>    bloblist: add API for applying blobs with specified tag
>    fdtdec: apply DT overlays from bloblist
>    configs: Select OF_LIBFDT_OVERLAY to hand over DTO via bloblist
>
>   common/bloblist.c                       | 67 ++++++++++++++++++++-
>   configs/qemu_arm64_defconfig            |  1 +
>   configs/vexpress_fvp_bloblist_defconfig |  1 +
>   include/bloblist.h                      | 34 ++++++++++-
>   lib/fdtdec.c                            | 80 +++++++++++++++++++++++++
>   5 files changed, 181 insertions(+), 2 deletions(-)
>
