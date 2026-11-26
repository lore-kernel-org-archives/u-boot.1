Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E24606A68F
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K1bxTOEn;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Y8eCj8So
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7968180E71;
	Thu, 26 Nov 2026 09:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lAkIYfLSLFI; Thu, 26 Nov 2026 09:24:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 321F580F32
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795685075;
	b=gwcfBFNLNzZ1f3m975AuTH8hrIgkKWqqpPVpke9BgA431P0LdSx0yixLQ4AO+Lhvec3/
	 po8NVOvdw9OZQe5R9vGPRxP2s2nwBcnd/lZ01enHa6DdgETh9ddT/4Evpv8OxmQPiTtZc
	 qvxzvg5Qwdcd3zIbzYNywqCj3KMVlP0wvCYm2WBnAW1cRJKS20OKULMy43XIGyTWq85Qb
	 qtA8wFq0dNfmek9nOoV6dVwRVlOSYZA2N3AYP9DbpfxwMA1F6ozx/4M7xYOJZu196BGo8
	 NQ+25tlrh9ZKtaOzGHfL9WZQfnL/g4tn7HmVkgyLClQO09uVek9wAR8AQfZkbenSuFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795685075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PG2KVAIGckNhS6rb92r/uMsikF30rLWS9GCOy78J0d0=;
	b=JG36ku3eOqWOqGfEAhFiaA6hjOy9GQvGa5klNyntjYKNX8jcZpY8yO4i7EtC0gCxspYX
	 hBoMqLMWqkiufLCKDxcv4ALohWVwF+EDwuyywVjZPYAvV1BKG+Ly3SgCb3e1y7iD8vYi+
	 VmtlPrH7ogHzsdeLPw9cMPqNzo7yOAmQcPy/HQXWWV8QiODegECH3fjMZs9fAIpzQe41/
	 mORdxJZvOAuBpPuGzLt/Bd9J4dAt/T3BDdHKCkKl+1lMAy/07stLh0fhYLwUI0ghnMgJo
	 cRZSUjLZP/PtMpqpQl0RvC1X1PNPERFGiYSmUnoRtdjetco4XD9Lzloocz76LkcgqLA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795685075;
	bh=PG2KVAIGckNhS6rb92r/uMsikF30rLWS9GCOy78J0d0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K1bxTOEnhAv0jgZhtnjxOxKOYP2XEbKuojOT0pz5pM5sR2DyeWyDn3b0epsmiI0nu
	 SH6Wc6W5KaDNb3rx1xnrQ10IWnpQ8PnNZiMynC68pbIcWERgXAyhgmhcMyZPxJtVn/
	 ynDrbENr1Cs7rxZSUsN2v2mLbK1GYQJfJfkx4P136OE3kMZg5tmoVKK0AvRPtKN5DM
	 f71UXR6I6wZcYwXPmfJFuaovJ4Ubph2CZWzfwNWfdhPOnz8ZmmMJm3xcprYKdImhsu
	 Js1FKrDl7/ELzL7IaG5R8zNHFCmw5/wPGoWL9+g94xmgcUUKVHepqQy4JmYxxNXQMV
	 GQ+o5CZayKPtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 321F580F32;
	Thu, 26 Nov 2026 09:24:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22FD9260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08FDF405A7
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:24:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id axwEVUKrSsnI for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 09:24:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F248F4057C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Y8eCj8So
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F248F4057C
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:24:29 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 58C433F68B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795685068;
 bh=PG2KVAIGckNhS6rb92r/uMsikF30rLWS9GCOy78J0d0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Y8eCj8So8siPX+isV9Ffwl4p6cjpA95t+k2EBp3cGqieD2CXNJV/NJ65PD016y7QL
 oQK44rqkPiRSIUiUbs5FV3Sd5rAOO1M7XcZpq1VXE0sz9us5L4K4XOwP9Fnb8a2zDi
 GczAj3MWW/sy1LpUxukGv2jwGWvF8LTWMuWtglB3CJioZT3UfTN5AVKPI6LQHfozhY
 pJkXIfOVPiHdlb1tKD4D2GJNkAxtxPvug2eLNEhNpCLKspibHTCR+my0+P3Og9guPr
 4c/2GVFdKiv0PIWHkivtzShcNwyK2Z0cnGchBVUDvvF/utIR9voblqex4EqNMAm3g0
 guIi7d+7EwfKl+vDmGPQ1hpiDM/wN6AFP/yvCnz6eWQ2+CwbWtHoPyx/HR6RqPljte
 /Nnp96SiTApXAgyyZrbcN+l91AIwO/6/BfucNuWXuttjumSAR1OlYRP1EXCmYdZ9AV
 zKt4QI4sDmdoNH+r4YdCiWykKMiXmM5m7AdGR3yk8H4yWaxSOoAkX2mW6NVDEz5w/V
 EXZRtqqmjy36zeBMb3y6ai3z46O0QAPHf6pkkNldMduXJvc0IbwuHuTIfLOlwSQzSU
 p3ejm6SvOHl6Uj6Mgkm5srTzT6FK+Lxrpxd5kOfSj5ZToM76K6ymN9pTc75TvhBE5y
 exT0k+hFLYU1UJs5yu7JOnQk=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so5589082f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 01:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795685068; x=1796289868;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PG2KVAIGckNhS6rb92r/uMsikF30rLWS9GCOy78J0d0=;
 b=igCuxdDaci1Q+ddgdOBZZiQ3fP+WWlEbkJknGIWH4FOB4G/bdGN+dD7YfmLvDiE1VK
 uAt8gNE3RP7RzAwyKg63BsoArFBbQpbz8lygTkaKPPAe7fg1nFx/5Z2bCZ4y7olxlE48
 YrJBXv0dwk3wK/geh6tfFcMqovJdgT6yvIRzocKzTOOSfPfrGnp2NyYVF6876QNtHeNd
 VQ8K3JCxAqjYlv09aCSMmQx50Na83JMxDQVkaGzZyTH2v/F5feLncODTjNksaHHGxl+l
 +R5HABWJsmI0U5F7YmECpBAxk6NrUNF2Rp4wiiJDJ37j2ZqN2L24RX6Egs4of4P3JK3G
 7S1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH2G/5qNXy88mQWZ/VTfp2BDoOZuSEKjrnO+8rJ2LRCS5Y4IaakeVa1WTFijgauls0yqfeR2ww=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+B5jWyFtNQEPuvdU0bc2rhLa93iUmUHTgnuTyV0KsrrBUulTzP
 pA/7Z0dS1+ZjbP3dzveRWi2DTe3TCWDROJdIRBAEt8R9BqX8kirMDlLDoId6CCJecXhT3NGQWp3
 4gXs/P73A/WiKBH5z8naubydD4iSjWKairL56GdaJ86EhNDsxteHs3bn6WOwLQiB2njla+sSH1+
 nHZN6udhuFJw==
X-Gm-Gg: AZFdTZeuzA03JMGOwDzbBAh1hdHtA7R/eYRz5ilkKyZmkZwpJeuTGsayl0juJ6WWEhp
 DjgjqxIFGwBhiiYRI4eIifT6khLi+sd7yLb8Qrcnd3Q1rJapYSab24D22pomZ1RhO7xY5sdGdR2
 WXIg7FqLfyZmB4NnME+d2AQx1RTCT7bv/WYDwO0r0xqrEKrnS7PdqNY5bPWN5K1dzivg5aKLKus
 /ZKTqukJkPSkDOGbMCprCGzbtt1Pg4a8ADtT6dpd6kwyjAgINvzqclI2ULhgVT8NlQm0YBwIVhr
 dW1X6LL38CPWN8k5IGns9gvNJitDpDS4gMLKPif+TcLJnT5XBO0A1PlMdz/Krwv9clKIm25m7ks
 9vnIfyJzB9dUh42VUKLt/fSv0sk+0OQ2NJEXgrnamRslHDjLeaODDzEjbU8IbXwpu4OtZGM33LT
 uigzey+5miH6AWy6T9aG/tng58uwhkfwyo7nWGbTvXNi5x5xxNbY5EujAHmWRQkt+SlTVOXTI=
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id
 5b1f17b1804b1-4bb88809950mr417984215e9.17.1795685067838; 
 Thu, 26 Nov 2026 01:24:27 -0800 (PST)
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id
 5b1f17b1804b1-4bb88809950mr417983835e9.17.1795685067474; 
 Thu, 26 Nov 2026 01:24:27 -0800 (PST)
Received: from ?IPV6:2a02:908:1242:30e0:3b0e:99ad:b595:81a?
 ([2a02:908:1242:30e0:3b0e:99ad:b595:81a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm372498755e9.1.2026.11.26.01.24.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 01:24:26 -0800 (PST)
Message-ID: <28c31535-e802-448d-99f7-b0e6f69aef1f@canonical.com>
Date: Thu, 26 Nov 2026 10:24:25 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/2] efi: gbl: Add GBL GUID names and protocol
 documentation
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ji Luo <ji.luo@nxp.com>, Ram Muthiah <rammuthiah@google.com>,
 u-boot@lists.u-boot-project.org
References: <20261124211914.3088229-1-dimorinny@google.com>
 <20261124211914.3088229-3-dimorinny@google.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20261124211914.3088229-3-dimorinny@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 22:19, Dmitrii Merkurev wrote:
> Add the GBL protocol GUIDs and GBL_EFI_VENDOR_GUID to list_guid[] so
> 'efidebug dh', '%pUs' and 'env print -e' print them by name, and
> 'env set -e -guid' accepts GBL_EFI_VENDOR_GUID when
> CONFIG_PARTITION_TYPE_GUID is enabled. Add a unit test in
> test/lib/uuid.c to cover them.
> 
> Add doc/develop/uefi/gbl.rst with a short overview and the kernel-doc
> output for include/efi_gbl/, linked from the UEFI and Android doc
> indexes.
> 
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> ---
>   MAINTAINERS                |   1 +
>   doc/android/index.rst      |   3 +
>   doc/develop/uefi/gbl.rst   |  97 +++++++++++++++++++++++++++++
>   doc/develop/uefi/index.rst |   1 +
>   lib/uuid.c                 |  47 ++++++++++++++
>   test/lib/uuid.c            | 122 +++++++++++++++++++++++++++++++++++++
>   6 files changed, 271 insertions(+)
>   create mode 100644 doc/develop/uefi/gbl.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ca3d064cd8..efcb6f06eaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -124,6 +124,7 @@ F:	test/py/tests/test_android/test_avb.py
>   ANDROID GBL
>   M:	Dmitrii Merkurev <dimorinny@google.com>
>   S:	Maintained
> +F:	doc/develop/uefi/gbl.rst
>   F:	include/efi_gbl/
>   
>   ARC
> diff --git a/doc/android/index.rst b/doc/android/index.rst
> index 225d6f125a9..ac04f6944a6 100644
> --- a/doc/android/index.rst
> +++ b/doc/android/index.rst
> @@ -12,3 +12,6 @@ Android-specific doc
>      boot-image
>      fastboot-protocol
>      fastboot
> +
> +See also :doc:`../develop/uefi/gbl` for the UEFI protocols used by the Android
> +Generic Bootloader (GBL).
> diff --git a/doc/develop/uefi/gbl.rst b/doc/develop/uefi/gbl.rst
> new file mode 100644
> index 00000000000..ac51db8da07
> --- /dev/null
> +++ b/doc/develop/uefi/gbl.rst
> @@ -0,0 +1,97 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Android Generic Bootloader (GBL) Protocols
> +==========================================
> +
> +Overview
> +--------
> +
> +The `Android Generic Bootloader (GBL)
> +<https://source.android.com/docs/core/architecture/bootloader/generic-bootloader>`_
> +is an open-source UEFI application (``gbl.efi``) from the Android Open Source
> +Project (AOSP) that standardizes Android and Fuchsia boot, Android Verified
> +Boot (AVB), A/B slot selection, and Fastboot across architectures.
> +
> +``gbl.efi`` runs on top of UEFI platform firmware (such as U-Boot's UEFI
> +subsystem) and relies on standard UEFI Boot/Runtime Services alongside a set of
> +stabilized GBL-defined UEFI protocols for board- and SoC-specific operations.
> +For development builds of GBL, all custom GBL protocols are optional; firmware
> +can implement them incrementally as platform features are enabled.
> +
> +The canonical upstream protocol specifications are maintained in AOSP at
> +`gbl/docs/efi_integration.md
> +<https://android.googlesource.com/platform/bootable/libbootloader/+/refs/heads/gbl-mainline/gbl/docs/efi_integration.md>`_.
> +
> +Protocol Summary
> +----------------
> +
> +================================  ========  ====================================
> +Header                            Revision  Purpose
> +================================  ========  ====================================
> +``efi_gbl/avb.h``                 1.0       Android Verified Boot board
> +                                            callbacks, lock state, rollback
> +                                            indices, and persistent values.
> +``efi_gbl/avf.h``                 1.0       Vendor DICE handover and
> +                                            Secretkeeper key for Android
> +                                            Virtualization Framework (AVF).
> +``efi_gbl/boot_control.h``        1.0       A/B slot queries and active-slot
> +                                            updates, one-shot boot mode, and OS
> +                                            load handoff.
> +``efi_gbl/boot_memory.h``         1.0       Platform boot and preloaded
> +                                            partition buffers.
> +``efi_gbl/debug.h``               1.0       Fatal error notification prior to
> +                                            system reset.
> +``efi_gbl/fastboot.h``            1.0       Vendor Fastboot variables, staged
> +                                            payloads, and OEM commands.
> +``efi_gbl/fastboot_transport.h``  1.0       Custom Fastboot transport channel
> +                                            (e.g. USB or serial).
> +``efi_gbl/os_configuration.h``    1.1       Android bootconfig and kernel
> +                                            command line fixups, device-tree
> +                                            and overlay selection, and FIT
> +                                            configuration selection.
> +================================  ========  ====================================
> +
> +Common Definitions
> +------------------
> +
> +.. kernel-doc:: include/efi_gbl/common.h
> +
> +Android Verified Boot Protocol
> +------------------------------
> +
> +.. kernel-doc:: include/efi_gbl/avb.h
> +
> +Android Virtualization Framework Protocol
> +-----------------------------------------
> +
> +.. kernel-doc:: include/efi_gbl/avf.h
> +
> +Boot Control Protocol
> +---------------------
> +
> +.. kernel-doc:: include/efi_gbl/boot_control.h
> +
> +Boot Memory Protocol
> +--------------------
> +
> +.. kernel-doc:: include/efi_gbl/boot_memory.h
> +
> +Debug Protocol
> +--------------
> +
> +.. kernel-doc:: include/efi_gbl/debug.h
> +
> +Fastboot Protocol
> +-----------------
> +
> +.. kernel-doc:: include/efi_gbl/fastboot.h
> +
> +Fastboot Transport Protocol
> +---------------------------
> +
> +.. kernel-doc:: include/efi_gbl/fastboot_transport.h
> +
> +OS Configuration Protocol
> +-------------------------
> +
> +.. kernel-doc:: include/efi_gbl/os_configuration.h
> diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
> index e26b1fbe05c..ddee5d40877 100644
> --- a/doc/develop/uefi/index.rst
> +++ b/doc/develop/uefi/index.rst
> @@ -14,3 +14,4 @@ can be run an UEFI payload.
>      u-boot_on_efi.rst
>      iscsi.rst
>      fwu_updates.rst
> +   gbl.rst
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 16ca8f37751..99227718e72 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -20,6 +20,15 @@
>   #include <rng.h>
>   #include <linux/ctype.h>
>   #include <hexdump.h>
> +#include <efi_gbl/avb.h>
> +#include <efi_gbl/avf.h>
> +#include <efi_gbl/boot_control.h>
> +#include <efi_gbl/boot_memory.h>
> +#include <efi_gbl/common.h>
> +#include <efi_gbl/debug.h>
> +#include <efi_gbl/fastboot.h>
> +#include <efi_gbl/fastboot_transport.h>
> +#include <efi_gbl/os_configuration.h>
>   #else
>   #include <stdarg.h>
>   #include <stdint.h>
> @@ -223,6 +232,39 @@ static const struct {
>   		EFI_IP4_CONFIG2_PROTOCOL_GUID,
>   	},
>   #endif
> +	/* Android GBL protocol GUIDs */

These UUIDs are only relevant if the protocol is implemented.
I suggest to put both the UUIDs and the protocol behind a configuration 
switch to reduce code size on other systems.

Best regards

Heinrich

> +	{
> +		NULL, "GBL AVB",
> +		GBL_EFI_AVB_PROTOCOL_GUID,
> +	},
> +	{
> +		NULL, "GBL AVF",
> +		GBL_EFI_AVF_PROTOCOL_GUID,
> +	},
> +	{
> +		NULL, "GBL Boot Control",
> +		GBL_EFI_BOOT_CONTROL_PROTOCOL_GUID,
> +	},
> +	{
> +		NULL, "GBL Boot Memory",
> +		GBL_EFI_BOOT_MEMORY_PROTOCOL_GUID,
> +	},
> +	{
> +		NULL, "GBL Debug",
> +		GBL_EFI_DEBUG_PROTOCOL_GUID,
> +	},
> +	{
> +		NULL, "GBL Fastboot",
> +		GBL_EFI_FASTBOOT_PROTOCOL_GUID,
> +	},
> +	{
> +		NULL, "GBL Fastboot Transport",
> +		GBL_EFI_FASTBOOT_TRANSPORT_PROTOCOL_GUID,
> +	},
> +	{
> +		NULL, "GBL OS Configuration",
> +		GBL_EFI_OS_CONFIGURATION_PROTOCOL_GUID,
> +	},
>   	/* Configuration table GUIDs */
>   	{
>   		NULL, "ACPI table",
> @@ -296,6 +338,11 @@ static const struct {
>   		"EFI_CERT_TYPE_PKCS7_GUID", NULL,
>   		EFI_CERT_TYPE_PKCS7_GUID,
>   	},
> +	/* Android GBL */
> +	{
> +		"GBL_EFI_VENDOR_GUID", NULL,
> +		GBL_EFI_VENDOR_GUID,
> +	},
>   #endif
>   #if defined(CONFIG_CMD_EFIDEBUG) || defined(CONFIG_EFI_CLIENT)
>   	{ "EFI_LZMA_COMPRESSED", NULL, EFI_LZMA_COMPRESSED },
> diff --git a/test/lib/uuid.c b/test/lib/uuid.c
> index 5ae8a30b8a7..aa1842f9921 100644
> --- a/test/lib/uuid.c
> +++ b/test/lib/uuid.c
> @@ -14,6 +14,15 @@
>   #include <test/ut.h>
>   
>   #include <efi.h>
> +#include <efi_gbl/avb.h>
> +#include <efi_gbl/avf.h>
> +#include <efi_gbl/boot_control.h>
> +#include <efi_gbl/boot_memory.h>
> +#include <efi_gbl/common.h>
> +#include <efi_gbl/debug.h>
> +#include <efi_gbl/fastboot.h>
> +#include <efi_gbl/fastboot_transport.h>
> +#include <efi_gbl/os_configuration.h>
>   
>   /* test UUID */
>   #define TEST_SVC_UUID	"ed32d533-4209-99e6-2d72-cdd998a79cc0"
> @@ -188,3 +197,116 @@ static int lib_test_dynamic_uuid(struct unit_test_state *uts)
>   }
>   
>   LIB_TEST(lib_test_dynamic_uuid, 0);
> +
> +static int lib_test_uuid_gbl_efi(struct unit_test_state *uts)
> +{
> +	static const struct {
> +		const char *uuid_str;
> +		const char *expected_name;
> +		efi_guid_t guid;
> +		bool is_protocol;
> +	} gbl_guids[] = {
> +		{
> +			"6bc66b9a-d5c9-4c02-9da9-50af198d912c",
> +			"GBL AVB",
> +			GBL_EFI_AVB_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"e7f1c4a6-0a52-4f61-bd98-9e60b559452a",
> +			"GBL AVF",
> +			GBL_EFI_AVF_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"d382db1b-9ac2-11f0-84c7-047bcba96019",
> +			"GBL Boot Control",
> +			GBL_EFI_BOOT_CONTROL_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"309f2874-ad59-4fd2-af5e-ce0f4ab401a6",
> +			"GBL Boot Memory",
> +			GBL_EFI_BOOT_MEMORY_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"98ca3da1-c1ac-4402-9c16-7558d3ed5705",
> +			"GBL Debug",
> +			GBL_EFI_DEBUG_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"c67e48a0-5eb8-4127-be89-df2ed93d8a9a",
> +			"GBL Fastboot",
> +			GBL_EFI_FASTBOOT_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"edade92c-5c48-440d-849c-e2a0c7e55143",
> +			"GBL Fastboot Transport",
> +			GBL_EFI_FASTBOOT_TRANSPORT_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"dda0d135-aa5b-42ff-85ac-e3ad6efb4619",
> +			"GBL OS Configuration",
> +			GBL_EFI_OS_CONFIGURATION_PROTOCOL_GUID,
> +			true,
> +		},
> +		{
> +			"5a6d92f3-a2d0-4083-91a1-a50f6c3d9830",
> +			NULL,
> +			GBL_EFI_VENDOR_GUID,
> +			false,
> +		},
> +		{
> +			"b86bef58-5d90-41f1-b721-b3e3b31505fc",
> +			NULL,
> +			GBL_EFI_RESET_DATA_GUID,
> +			false,
> +		},
> +	};
> +	u8 bin[UUID_SIZE];
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(gbl_guids); i++) {
> +		ut_assertok(uuid_str_to_bin(gbl_guids[i].uuid_str, bin,
> +					    UUID_STR_FORMAT_GUID));
> +		ut_asserteq_mem(bin, gbl_guids[i].guid.b, UUID_SIZE);
> +
> +		if (gbl_guids[i].is_protocol &&
> +		    (IS_ENABLED(CONFIG_CMD_EFIDEBUG) ||
> +		     IS_ENABLED(CONFIG_EFI_CLIENT))) {
> +			ut_asserteq_str(gbl_guids[i].expected_name,
> +					uuid_guid_get_str(gbl_guids[i].guid.b));
> +		}
> +	}
> +
> +	if (IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)) {
> +		const efi_guid_t vendor_guid = GBL_EFI_VENDOR_GUID;
> +
> +		ut_asserteq_str("GBL_EFI_VENDOR_GUID",
> +				uuid_guid_get_str(vendor_guid.b));
> +		ut_assertok(uuid_guid_get_bin("GBL_EFI_VENDOR_GUID", bin));
> +		ut_asserteq_mem(bin, vendor_guid.b, UUID_SIZE);
> +		if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) {
> +			ut_assertok(uuid_str_to_bin("GBL_EFI_VENDOR_GUID", bin,
> +						    UUID_STR_FORMAT_GUID));
> +			ut_asserteq_mem(bin, vendor_guid.b, UUID_SIZE);
> +		}
> +	}
> +
> +	ut_asserteq_64(0x00010000ULL, GBL_EFI_AVB_PROTOCOL_REVISION);
> +	ut_asserteq_64(0x00010001ULL,
> +		       GBL_EFI_OS_CONFIGURATION_PROTOCOL_REVISION);
> +	ut_asserteq(1,
> +		    GBL_EFI_PROTOCOL_MAJOR_REV(GBL_EFI_OS_CONFIGURATION_PROTOCOL_REVISION));
> +	ut_asserteq(1,
> +		    GBL_EFI_PROTOCOL_MINOR_REV(GBL_EFI_OS_CONFIGURATION_PROTOCOL_REVISION));
> +	ut_asserteq(8, sizeof(struct gbl_efi_slot_info));
> +
> +	return 0;
> +}
> +
> +LIB_TEST(lib_test_uuid_gbl_efi, 0);

