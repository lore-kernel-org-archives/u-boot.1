Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1463FCA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 10:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 528A68876E;
	Wed,  4 Sep 2024 12:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jzrxeg2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 792E388381; Wed,  4 Sep 2024 12:48:55 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7231A88BFF
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 12:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f3f0bdbcd9so8106431fa.1
 for <u-boot@lists.denx.de>; Wed, 04 Sep 2024 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725446933; x=1726051733; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5p+hPWsKiVTpEi5pFuzjO0FDH5WtkNFhb4IhOn7RXvY=;
 b=Jzrxeg2UXRml3VbR4u8bixKKEy05hLj38XrtFX0O24aYcVfL80rc0MAUd6BHcgRsjL
 fs/jDhxH3cE+ZvklVs1NZt2MYkAMvOP7GHw1NYXMR/dCbtPHwO301uhuHoxiJa0zk/RK
 LtatAuXaW8StoUBLcjb4tY9t375/t5HYPU/RYhNEm81DmGtbMdtDVkDYQ27OvVa6PCZw
 wGAUaWj4ODwkB97Mm+qLIaEMHPejidqHpUm69C2pJclbLYHFfObgWJryYimqJxdvsBzj
 HwtW4A7g+No4N3UkeFa9z283Y8mxhFa5ja+6bRrXrUd6Lm13woRGifuthmXwWUGtjz/w
 svPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725446933; x=1726051733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5p+hPWsKiVTpEi5pFuzjO0FDH5WtkNFhb4IhOn7RXvY=;
 b=uvKN/Fn2j3ZJDVMSEJise0BBNSpWsuMs/MLPwcDyix+m+Ni4UQ9KkS3ZUSsEQbL3+b
 PjKd93IQZhLSjVmoUg2aoc8iHpXSskDnpZYfyu60pTTY7ErdxI+ViyGMvxOsLJkmUsrl
 ioxjeac5nGkKqK3vE+9Lrj4fGJPIMjMv5gh1Tnr/c4PHfVDbi2HFPWLUe1IR9MGh+/hj
 45kJ7aht5SaRUMGWzPZ0Zbc8dk6y/9rM0R4HS0N5pEox4SgOv1YA14geXVwInTgSoQiI
 WVcMLOdcKUdheDES11Zq1MzFn8AQXoiVZgzUvSLxotmqMb1lGC6PKBvqHh5OVyTB7BJ+
 S7NA==
X-Gm-Message-State: AOJu0Yxr0rBd6pM6frXBWCFATu7x52BcfJxd43F2JrdMwV4n9fdSaHuT
 bUkc4OqeMbvnF2gYX8F0jPXCzfilSWfGryF9+IEjJUBGWrxcNcQRM+1ONmA/p8dpFkJwfR8s+15
 oUZn8WBGlB9wj2WStyqUmY3cTHX51j724K0Qy0w==
X-Google-Smtp-Source: AGHT+IGTeUvcx3/PkpoApmnQTfP4A/IpaHAT2OUCzYBFCdATkptuwjJB2iq/ZgKmCptS9dGtxmsVAd3GxVCRB+f+OCE=
X-Received: by 2002:a2e:be9b:0:b0:2ee:8453:5164 with SMTP id
 38308e7fff4ca-2f651b8aa1cmr18351771fa.0.1725446932295; Wed, 04 Sep 2024
 03:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <d3a2b1f8-0288-413c-a28f-ce2d1456607d@amd.com>
In-Reply-To: <d3a2b1f8-0288-413c-a28f-ce2d1456607d@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 4 Sep 2024 16:18:40 +0530
Message-ID: <CADg8p944=XMurNnVTz7hvMtvAKStYEpLZxP9gRKss+Qf08XRNw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 4 Sept 2024 at 13:45, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/30/24 13:40, Sughosh Ganu wrote:
> >
> > The following set of patches are miscellaneous fixes and some
> > hardening of the FWU update logic.
> >
> > Sughosh Ganu (6):
> >    fwu: v2: perform some checks before reading metadata
> >    fwu: v2: try reading both copies of metadata
> >    fwu: v1: do a version check for the metadata
> >    fwu: check all images for transitioning out of Trial State
> >    fwu: add dependency checks for selecting FWU metadata version
> >    fwu: do not allow capsule processing on exceeding Trial Counter
> >      threshold
> >
> >   include/fwu.h            | 11 ++++++
> >   lib/fwu_updates/Kconfig  |  1 +
> >   lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
> >   lib/fwu_updates/fwu_v1.c | 18 +++++++--
> >   lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
> >   5 files changed, 99 insertions(+), 42 deletions(-)
> >
>
> I think there is still issue with returning values.
> Take a look at my log. I am in trial state - I accepted both images already
> that's why fwu has everything accepted. But I can still apply empty capsules
> which are passing.
> 1. if they are accepted status should be reflected and visible via fwu
> 2. if they are not accepted error from command should be returned.

The code currently, does not behave incorrectly, but we can indeed
return an error status if the empty capsule checks fail, like is done
for normal capsules. I will add this change in the next version.
Thanks.

-sughosh

>
> Thanks,
> Michal
>
> ZynqMP> fwu
>         FWU Metadata
> crc32: 0x12fd554e
> version: 0x2
> size: 0xda
> active_index: 0x0
> previous_active_index: 0x1
> bank_state[0]: 0xfc
> bank_state[1]: 0xfc
> bank_state[2]: 0xff
> bank_state[3]: 0xff
>         Image Info
>
> Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
> Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
> Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
> Image Acceptance: yes
> Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
> Image Acceptance: yes
>
> Image Type Guid: CF9ECFD4-938B-41C5-8551-1F883AB7DC18
> Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
> Image Guid:  52DA04FB-9D0E-EE11-A57F-637805837C3F
> Image Acceptance: yes
> Image Guid:  46926007-9E0E-EE11-A23A-A38980B779A1
> Image Acceptance: yes
> Custom fields covered by CRC 0x12
> CUSTOM 00000000: 31 32 33 34 35 36 37 38 64 65 61 64 62 65 65 66  12345678deadbeef
> CUSTOM 00000010: 0a 0b                                            ..
> 0xffd80050 = 0xb002c001
> 0xffd80054 = 0xb0020ff0
> 0xffd80058 = 0x1d000048
> 0xffd8005c = 0x0
> ZynqMP>   tftpboot 0x100000 192.168.0.105:capsule1-revert.bin && efidebug
> capsule update -v 0x100000
> Set rate id 48/125000000
> Using ethernet@ff0e0000 device
> TFTP from server 192.168.0.105; our IP address is 192.168.0.155
> Filename 'capsule1-revert.bin'.
> Load address: 0x100000
> Loading: #
>          3.9 KiB/s
> done
> Bytes transferred = 28 (1c hex)
> Capsule guid: acd58b4b-c0e8-475f-99b5-6b3f7e07aaf0
> Capsule flags: 0x0
> Capsule header size: 0x1c
> Capsule image size: 0x1c
> ZynqMP> echo $?
> 0
> ZynqMP> fwu
>         FWU Metadata
> crc32: 0x4aef4913
> version: 0x2
> size: 0xda
> active_index: 0x1
> previous_active_index: 0x0
> bank_state[0]: 0xfc
> bank_state[1]: 0xfc
> bank_state[2]: 0xff
> bank_state[3]: 0xff
>         Image Info
>
> Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
> Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
> Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
> Image Acceptance: yes
> Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
> Image Acceptance: yes
>
> Image Type Guid: CF9ECFD4-938B-41C5-8551-1F883AB7DC18
> Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
> Image Guid:  52DA04FB-9D0E-EE11-A57F-637805837C3F
> Image Acceptance: yes
> Image Guid:  46926007-9E0E-EE11-A23A-A38980B779A1
> Image Acceptance: yes
> Custom fields covered by CRC 0x12
> CUSTOM 00000000: 31 32 33 34 35 36 37 38 64 65 61 64 62 65 65 66  12345678deadbeef
> CUSTOM 00000010: 0a 0b                                            ..
> 0xffd80050 = 0xb002c001
> 0xffd80054 = 0xb0020ff0
> 0xffd80058 = 0x1d000048
> 0xffd8005c = 0x0
> ZynqMP>   tftpboot 0x100000 192.168.0.105:capsule2-accept.bin && efidebug
> capsule update -v 0x100000
> Set rate id 48/125000000
> Using ethernet@ff0e0000 device
> TFTP from server 192.168.0.105; our IP address is 192.168.0.155
> Filename 'capsule2-accept.bin'.
> Load address: 0x100000
> Loading: #
>          5.9 KiB/s
> done
> Bytes transferred = 44 (2c hex)
> Capsule guid: 0c996046-bcc0-4d04-85ec-e1fcedf1c6f8
> Capsule flags: 0x0
> Capsule header size: 0x1c
> Capsule image size: 0x2c
> ZynqMP> echo $?
> 0
> ZynqMP> fwu
>         FWU Metadata
> crc32: 0x4aef4913
> version: 0x2
> size: 0xda
> active_index: 0x1
> previous_active_index: 0x0
> bank_state[0]: 0xfc
> bank_state[1]: 0xfc
> bank_state[2]: 0xff
> bank_state[3]: 0xff
>         Image Info
>
> Image Type Guid: DE6066E8-0256-4FAD-8238-E406E274C4CF
> Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
> Image Guid:  F64A0548-2CCE-ED11-8F66-7BC4531CFE6B
> Image Acceptance: yes
> Image Guid:  3E9C814B-2CCE-ED11-BEC8-23DE4C6D2CF2
> Image Acceptance: yes
>
> Image Type Guid: CF9ECFD4-938B-41C5-8551-1F883AB7DC18
> Location Guid: D7CE8A58-CE2C-11ED-81CD-D324E93AC223
> Image Guid:  52DA04FB-9D0E-EE11-A57F-637805837C3F
> Image Acceptance: yes
> Image Guid:  46926007-9E0E-EE11-A23A-A38980B779A1
> Image Acceptance: yes
> Custom fields covered by CRC 0x12
> CUSTOM 00000000: 31 32 33 34 35 36 37 38 64 65 61 64 62 65 65 66  12345678deadbeef
> CUSTOM 00000010: 0a 0b                                            ..
> 0xffd80050 = 0xb002c001
> 0xffd80054 = 0xb0020ff0
> 0xffd80058 = 0x1d000048
> 0xffd8005c = 0x0
> ZynqMP>
>
