Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89736C25B79
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 05:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA8E88289;
	Fri, 24 May 2024 07:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EKGOhOvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312DA88294; Fri, 24 May 2024 07:56:29 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43650881D3
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 07:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2bf59b781d6so505448a91.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 22:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716530185; x=1717134985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mKfr7yQO75g2Cx85waI0aGcjP3vRVY46DSRVO8kKkKE=;
 b=EKGOhOvgwjaQMA6zCewCwwNNvfkBfr5klF+J9zKgSRcrxwvhhYpF0F7n+I1ubcETk6
 hTnDhFGMp6W5oyyQliT6Gs8vW/ylQETWJFqfiy9sE1LOf2SA7OWU6OiHhv7QQIV5RvT/
 QhIZgsgHHjc4Lvu5u9tBL23vn/CWMruygbZSG35YZcTHokimA1xolQWLzoYxJz2sCOF2
 adq8C2xVyPF3Eux01XzC34FAtcbjqMvDs3lWfn2TGimyTwVBahMu4xaTT2EVG/+JXcQm
 SizWOXx/Q5dZcxwB9uulMmXZHv03vQKUlVuqA8Hn5pk8uczIBRe06q3jO8A1gjIOs84A
 Xkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716530185; x=1717134985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mKfr7yQO75g2Cx85waI0aGcjP3vRVY46DSRVO8kKkKE=;
 b=IhTITSn9WYauWxPLLhQDYBsoyTttAl9qQciRzbrszLSXG+BTessQQrXNrwuur/++ZY
 1wB6z8ddmZq3YmrVh++aq1Z2jn41RK9llj4QmAITnM/wepKNX88szsR3tU+bpEnLnzLi
 SVQYK7yszI00f5t+uma1Tr30EoXjY2kL8nCLOeKWGc7P1cXlW+IVIaw3D2oym4zIJY1E
 mav08a3V4LrtnkbrE6a+fMnyiIKTor+6ng2EA5D/g7EzyFVUgcYi20otizPOdiOufSpE
 XxJzUpHPy5q0FX0VMYTmL4c/Uki+HwPtj1ZCtwOfaYATzbnmXuAljzyU8DyPetbDDCrX
 pcaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm0LFyrmukCVLrHzSMWbzgjOnLMD604IU9FsZ+ea17G8mrOGLfM7gWFlftTBDeE7h8HlKGKIc6FD0aPrsCqLXWXMPDGQ==
X-Gm-Message-State: AOJu0YyLZvgXwzldC6ylKpJw3b5x3FlV+/SRsou9TwtJwZeLOnce+2R6
 ndsDJ4Nkc05bvnD//O4tLMSBPUDai/hRvMXcPOqPPh9gg4PbAOWsJB8BMh+eg7+/nIdLM2Qloq0
 f0fUyh5HdnKB0ohS80jEmwVXyo1HQydHprPnfWw==
X-Google-Smtp-Source: AGHT+IFAmQ7R4X16Jk0epvIT1opoUyKrQg1Fb/GcPRYsObHWYH8hwN5EWEEI9qDtfQ5QqUmLfLTnV+lLGRAoo3Y7KzI=
X-Received: by 2002:a17:90a:470e:b0:2b4:35a9:65fb with SMTP id
 98e67ed59e1d1-2bf5e1393e6mr1275428a91.10.1716530184663; Thu, 23 May 2024
 22:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 08:55:47 +0300
Message-ID: <CAC_iWjLaJAJNVg-Rv3pWZj495HiLQcVUgq=GROhLejXoVHc4Aw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] efi: CapsuleUpdate: support for dynamic GUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

Hi Caleb

On Fri, 26 Apr 2024 at 17:19, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> As more boards adopt support for the EFI CapsuleUpdate mechanism, there
> is a growing issue of being able to target updates to them properly. The
> current mechanism of hardcoding UUIDs for each board at compile time is
> unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
>
> In this series, I propose that we adopt v5 GUIDs, these are generated
> by using a well-known salt GUID as well as board specific information
> (like the model/revision), these are hashed together and the result is
> truncated to form a new UUID.
>
> The well-known salt GUID can be specific to the architecture (SoC
> vendor), or OEM. Exact rules on how these are used (e.g. if vendors
> should be told to generate their own for their products, and if that
> can be added upstream, etc) will need to be decided.
>
> Specifically, the following fields are used to generate a GUID for a
> particular fw_image:
>
> * namespace salt
> * soc name
> * board model (usually from dt root model property)
> * board compatible (usually the first entry in the dt root compatible
>   array).
> * fw_image name (the string identifying the specific image, especially
>   relevant for board that can update multiple images).
>
> Once generated, the GUIDs can be printed with the "%pUs" format string,
> these can then be stored externally to U-Boot.
>
> The SoC name field might be controversial, it could be generated from
> the last entry in the dt root compatible in most cases, or in some board
> specific way. It might make sense to remove this field if it is
> unfeasible for some boards.
>
> == Usage ==
>
> Boards can integrate dynamic UUID support as follows:
>
> 1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
>    EFI_HAVE_CAPSULE_SUPPORT
> 2. Skip setting the fw_images image_type_id property.
> 3. In board_init() (or anywhere before the EFI subsystem is
>    initialised), add a call to efi_capsule_update_info_gen_ids() with
>    the board specific info.
>
> == Limitations ==
>
> * Changing GUIDs
>
> The primary limitation with this approach is that if any of the source
> fields change, so will the GUID for the board. It is therefore pretty
> important to ensure that GUID changes are caught during development.
>
> * Supporting multiple boards with a single image
>
> This now requires having an entry with the GUID for every board which
> might lead to larger UpdateCapsule images.
>
> == Tooling ==
>
> Not part of this RFC is a tool to generate the GUIDs outside of U-Boot.
> I suspect this might be a requirement, but it makes sense to decide on
> what fields we use first.

Yes, tooling would be good.

>
> The tool should take in the salt, DTB, and a list of fw_image names. It
> could also accept values to overwrite the individual fields if they
> aren't derived from the DTB for some reason. It would then generate the
> expected GUID.
>
> A potential idea here would be to integrate this into the build system
> so that it prints a warning if the GUID changes.
>

There's work being done in that direction as far as capsules are
concerned. Apart from the u-boot binary from your board, the build
system should also generate binaries

Thanks
/Ilias

> == TOOD ==
>
> Missing from this RFC are unit tests for the dynamic UUID feature, these
> will be implemented for future revisions.
>
> I would appreciate any feedback on the above.
>
> This follows a related discussion started by Ilias:
> https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/
>
> ---
> Caleb Connolly (4):
>       lib: uuid: add UUID v5 support
>       efi: add a helper to generate dynamic UUIDs
>       doc: uefi: document dynamic GUID generation
>       sandbox: switch to dynamic UUIDs
>
>  arch/Kconfig                 |  1 +
>  board/sandbox/sandbox.c      | 28 +++++++++++++++-------------
>  doc/develop/uefi/uefi.rst    | 35 +++++++++++++++++++++++++++++++++++
>  include/efi_loader.h         | 28 ++++++++++++++++++++++++++++
>  include/uuid.h               | 16 ++++++++++++++++
>  lib/Kconfig                  |  8 ++++++++
>  lib/efi_loader/Kconfig       | 14 ++++++++++++++
>  lib/efi_loader/efi_capsule.c | 33 +++++++++++++++++++++++++++++++++
>  lib/uuid.c                   | 33 +++++++++++++++++++++++++++++++++
>  9 files changed, 183 insertions(+), 13 deletions(-)
> ---
> change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
> base-commit: d097f9e1299a3bdb7de468f0d9bbc63932f461cd
>
> // Caleb (they/them)
>
