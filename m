Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51246606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vSy6ufyP;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=b6HWnKCp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EBB9810DD;
	Sat, 31 Oct 2026 09:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZOsGmSbugpL; Sat, 31 Oct 2026 09:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 691C3810DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793440723;
	b=CwxVym3ZwZaYpU17aarUq625rDOdn6pPjJPdiU5ZfMoMjG2XnrBD2SRnzLlXGmObwd/v
	 ETCqDlUbVXNlSYmI1MLdWcvxWYLmNzMw2mukdqHpQJNcFuuiOc1VCVFR+yR/yrAiSiqdh
	 qrIC2RkIGLsgxhmXt+sQEdkzMt/0Hbn58YWbvyG/uhaxoSGgxHrc5iB23OmiMybntIHka
	 SgdBAL+9+qZ5JgbIFDNfWSII9PIDcpz9nuh6m39wD9ihdVTwn+wVIKZ7/RWCVbvcn3jJn
	 6KtQQbjCHrFTjk5F15tKtblVgecpv7f2kyyy3zYQDNO4zJAfqu2zpnNoOP1MAxVdA8w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793440723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OvhZI6zk35hjZ7R/EWOY2K8H36uzgclB5L+9f4HfopU=;
	b=ZBqXldwVs86xChR/Larq6SfNU9yJaF9GR6zc/7EB9bQj5MegQxXnIMOFhZiHqRnLLWrw
	 Jj/pz+JdGInovqFA2Rv8uIftsJ0K+R3fcMnuxgCCi658PwF887xyEAkwV2EYb4QPBmpSP
	 hEAbhXbJflncltV3YF9fm+f0IALxyixik4Y4x6eEHzZSFVeyF9hELM+nivErG2VH5ozwg
	 YYbSURcRnOJG4ZlkNd4XIwOCM/aKiUVWfCrttaEO+byc7cHeeOGnmf1Xeb2YIGBjfnGd0
	 G2M7Os4m2wUCuKs+F9ygge6pzRsgYxvhwSIeFxWwr6X2L5MwlK1GsarCuUregAjhL5A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793440723;
	bh=OvhZI6zk35hjZ7R/EWOY2K8H36uzgclB5L+9f4HfopU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vSy6ufyPkDIDgtjv3s6i3Sh7Jl9fnqvCHGWtGTHe8BoV70wJ5GIzt953yBzgSacv/
	 NnsOMN9bvkZsBegJncUxYWQjMT7lLf1aWrue4u+/O3uDv6q8nTgNPHFX/cmPny4JgR
	 A/c6G809sPW3ut6++mT7JjLUwGhHYW1Q/pMR1olgeEQ3tWBvwTc21OMJcTT3Uzbwes
	 cJVM3RAoLWjdCiQgyiUgjpChjPjndOqsTPzxCN0sOB1kYpB1FOqj01py/6tcbYmr60
	 FMeaM8luMWudP+tRhclSFGBQwplMouEN6M33NBYunvGg7yJwY8H+7TRulDUCQkX7ra
	 mlc1hvsfwpy2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 691C3810DF;
	Sat, 31 Oct 2026 09:58:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA0834BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBA9E606A9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydh6XiVoek_n for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D42EC60633
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793440721;
 b=GMXetOLvG8QOmxbP+lN83zV8iLhY3syL+EXzExLVMydEjfWiFuWHY4C2aVyGiE8b3HAa
 dT7Zfa2f4GSkKFgpbtB3abGvwdoMiKHMfbrQ9NJfdheOSOhK/4GdSy0CHRgJLGsRT0jrS
 4ejmUG5Yv/75BmNDDpjzOkYBPDu69dQ/Xsax4sq2VMt8DNpELtmf0rzVYRk02aGVRE0yz
 SMFg+Tc1hBrKLMjj36peyBNhpOKFbHmRiI0KZSkCoEloLMcUmClCoq5vQKMxhu9yz+lc1
 jPyIpv5rvnonXnXctEARj/lU+t9znL8/qDfkN1Py4t7zz42wqxNLDvZQaPY7l6kV/mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793440721;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=OvhZI6zk35hjZ7R/EWOY2K8H36uzgclB5L+9f4HfopU=;
 b=IuHTrmrfsYcntV9aqkLh31yNBb26RR4TndIzPERCWZaBfjcH3WFiDdOLEVeuLqf4klHz
 lMJ7rqdC0uhJRkW444zww8SskLwhr7Z9jWGoK3w23Oa7V1TynkMNx4vLjMa/OleGgzyGs
 v8vW/yjUL1qFu1qHgSW1pTCATCfS2ipSYa1KCWud34mbiuFyN3raz9kWl4XY2hZsQziGf
 8IUmwmhH+IMkHrEsyTM0t7dYyXa4lCYmaqemXVMm0/Gg3vMA2aD8ziH7h4OoBOgaTgg2F
 zWaCkWZ+riOYTSuVmayyz/DrSZxXVfutx9zMryVGmEEWWFVrcabrfRkQ3dRFdfo0OXA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=b6HWnKCp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=b6HWnKCp
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D42EC60633
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:58:40 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so2149444a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793440719; cv=none;
 d=google.com; s=arc-20260327;
 b=OUycw7ZZXRjuEj/nKtEQeK7Tbl2N3h7SRboNNPAh4eD6T8Ki/jfzB0epB0v6kNy4Ep
 /SzH8675iPWEWiwJZUQYqUbaSxOf0YtFjgV60AEuRYXQyASl9FZIPn8skW01KTK4uK0e
 NWKj8WGtpcK72bgUFEb3pa+OE+U+3VgPP4A05WTh9QtwdmGh22qJkDtLR+byw2u7FIlN
 vh0LPThKNCqS7uEocVV99CAcBqGMlr+7+n/6AYIKUV+fR3Rg8tt2+KZhAUzqiyeV9WaF
 zflmACKsORDEFJGwHimEMgWMvZkxbxkPKrkgMcRGUgWWyXlVpepjCrdcC5FP/JiUf9w/
 SCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OvhZI6zk35hjZ7R/EWOY2K8H36uzgclB5L+9f4HfopU=;
 fh=KJZvJetTwi3lO0+8aMeADCsJJkrg50SAAgTFTwjd/B4=;
 b=hzyBgnwtZTo0UMWDuxoypiwqdC74zaavqsNrEmvU1YgFuykxLYV+fvMyoxuQ1HR/jw
 HwwjBchigAnIIcuHWZUp1b3EO2RMQZERE5gu8kvoKgFGjHLYRhY2h71NicuS82fIX7rd
 t/lgxvpM3u1lDKHpX09QQsEO9+OgVypaGgeleoGJbka6jqXQviRo53vUMl0a9NVywtK7
 00xmb6cD/FTYhppc96MzCA/FRzQvWsXcE2iY6lKTLSzSKLr2bbJcg3FfgPsdSvuRxz09
 N/yVvLb+qzK9NxHzpxSsg1Ff+l6Nhgr/pj31igcrhcUIYGsEfNFVza4JfJ6FSzVzRa0w
 mvpw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793440719; x=1794045519;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OvhZI6zk35hjZ7R/EWOY2K8H36uzgclB5L+9f4HfopU=;
 b=b6HWnKCpFieRN/zw9YZLeyq2hH55Gzw4oBPDt0W0q5JF6OOursREdMAwhqtiZ/GZbx
 6Jg/JnvhINdpkGFIfwBrgNs/n3iNSXtg6zCQVM88+x8rWjcio2TQbgg4fgJsz0c7dVV3
 kBl0lx0JMdMwZ8YZPq6zIfgtO3tFWFD0M3cgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793440719; x=1794045519;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OvhZI6zk35hjZ7R/EWOY2K8H36uzgclB5L+9f4HfopU=;
 b=jBNDQYuZ09L154ftUiHaCCRio14TGCBPfvm2yHoEPVBZ/b+1sLmMVBuhS0KxSW4ptf
 +5aHunTLJWI4a93eE13qbYZOYpqbzT02z5aJeiU5br+Q6b/mpYKGvpVIXjJAO91Fbr/1
 MtYPHW1cJXAzufMPNQTC9r/CiUUu7a40vHiCtceJLI+MKnVHRtE4TltoDoLtCt+Cgpjv
 HA71cBMvK5XmzfLLGkChojX2uwRw2Yx7/4AykRYpy6cOEFbqU0OGwT2GTlTrnEAieaEv
 bsbyEuajN/ZI6aohMFUIM8RTLtGSiejcqSJsgyjertq/OHiG3xysp7mwp9n2keTF1gzt
 mNaQ==
X-Gm-Message-State: AFq9FYIeDURpfwOydR1RjmIviYHAIXTP0uRONR6//AEzZVMlZ3UDSdlm
 f+0ccC7ZDYOgACx2EmGjuAcImA53ZPnXaR33vRJJq3fTgNUCMQprIjBqlNNAPgPW03uE8rk/UlP
 fqFeBxU2PfRd0Jx2N3laUxjZRRgTBIenN5DxYRHmWflLV23SyVsuywg==
X-Gm-Gg: AYBFou3uGkjGgUW/bC1GaEdqwBTmig7seJpUGfPAutqRAjGgP3/nAMdRVDApu0pTaf+
 xLX/gDl6gLROVTfqDKDakj0bP2QiJEPUbbOo2dFZMt9qxz+moNYMwUELnrZ+9vmd9xmNfAnWSpv
 lzHE2mrFuqm77Clx0+T0VsRHJsXGynHWOcfzGUgr4m/kZOQV1wO1WBUeqcCyfmaRoqJk3mpmjUE
 5NOUSDTNnJjcCTNCRlOjxZSu1D+vwKMEy+66om7gffM0lESRhEalvAcMicWFaT7/d5p/qX9jr+S
 S0Doo3oWJ1dXoGjDYJIe0ymvuBSHqOCutwEz+rdnvOHmSl12SvWyXi4yz66Hy5zL2It9ZWvHLjd
 FT8I+BFbZxN09XbtQRm/OP4bVxf0j/WTvJNsFzJfJQNvKK8/R9Fmg2w5ndqSmSYH1ANz+l3o=
X-Received: by 2002:a05:6402:a6c3:20b0:6b1:b75e:e0b9 with SMTP id
 4fb4d7f45d1cf-6b4d4d764e7mr2413473a12.29.1793440718670; Sat, 31 Oct 2026
 02:58:38 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:58:37 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:58:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030222954.80242-1-pepp@me.com>
References: <20261030222954.80242-1-pepp@me.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:58:37 -0700
X-Gm-Features: AclHuK-7EYPgJ4FuQbBTAy3Whz3sd-wJQ--PInnUaEUWBZLqaJqrsa9xp_wHc1Q
Message-ID: <CAFLszTgcKzb=Ov0YWsHiReUvFXOxyHj3XRfpHJwZ9tnkV8oatA@mail.gmail.com>
Subject: Re: [PATCH] board: raspberrypi: rpi: add nvme to boot_targets
To: pepp@me.com
Cc: u-boot@lists.u-boot-project.org, duwe@lst.de, sjg@chromium.org, 
 mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On 2026-10-30T22:29:54+11:00, Peter Esselius <pepp@me.com> wrote:
> board: raspberrypi: rpi: add nvme to boot_targets
>
> bootstd only scans the labels listed in boot_targets. The NVMe bootdev
> is created by "nvme scan", but automatic boot never considers it because
> the board environment only lists mmc, usb, pxe, and dhcp.
>
> Add nvme after mmc and usb so the existing SD/USB boot order is
> preserved and NVMe is tried when neither produces a bootflow. This makes
> an NVMe-only system boot without an SD card while keeping the SD card as
> a fallback.
>
> Tested on a Raspberry Pi 5 (4 GB) with a BIWIN CE430T5D100-512G NVMe:
> with no SD card, U-Boot 2026.10 scans NVMe and boots extlinux from the
> NVMe ext4 partition; with the installer SD inserted, it still boots the
> SD first.
>
> Signed-off-by: Peter Esselius <pepp@me.com>
>
>  board/raspberrypi/rpi/rpi.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> @@ -77,4 +77,4 @@ pxefile_addr_r=0x05500000
> -boot_targets=mmc usb pxe dhcp
> +boot_targets=mmc usb nvme pxe dhcp

The other option might be to remove this altogether, so bootstd uses
its default approach of scanning from slowest to fastest device. I
would argue that NVMe should come before USB (which takes ages to
enumerate).

Regards,
Simon
