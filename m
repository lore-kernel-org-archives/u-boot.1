Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D87CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0283B81021;
	Mon, 19 Oct 2026 13:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4dL2-rGXrVbd; Mon, 19 Oct 2026 13:15:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0368881008
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415737;
	b=ix7XIXXCzmgY86K0TLEBYobuUGUn68PjIy8RvdTNdduwydT4iYXVra83xGDB1diF3z6F
	 UuIv0aYDEcz35trAoG5svg1neZzbesMTokts86b0wSf/7smn6kyzQUk8uoX8RE3rO2Ju1
	 3qMl2iK1or+6ixZGy1rS7MjRIzZ+BrYoMN5Ru+Iv9rYFOsr+M4Sv0QFWketxgT9g/dqBJ
	 sEaMO6ppqAI/Prqxl153HG1xKXUbcFlC1XlgygeZ7CNz4x4oQ49PmW3ybPxeth5cgGuw/
	 nHdNpiAY69Ra4xSGJynfS/mYQ1AtzVW/SoB23w82OF/KmrSYUkY3ZRh/veSUhkRZLfw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=h3qigaMiAcSmTQaHqbISQ7XKggciZD57d6bHCjePfyI=;
	b=S8LPNfsIKulMgD9s1WF8rBiKWMs9ssmLrdoOPftKPrsE74sEp8s1i9pNiupxLoSUsEzf
	 pSbgCygrze8c1nUXGLCnIwaXU0+zk7ldGnQGFCbdOASIJc9Vecd+5nBoI+oCO8hAwN+c4
	 nx3+c4ZigyQWMgbmVCw/bISVqPmU/3jP9brmX4VTLjGaldLfJGW/9HAeplXeKhtq2e1bP
	 lvlG0u60rvj1Q9P8ITmAYM/vjtjwMm+OjVQpNXiMX7dXTgfe1YTcF0Y7d0m+ztS7ebDzR
	 k0R22ZnwXg222FZDCa61mZobgyklPPNmv9X3rFP8GawXgCDiVmRrqhu2czWMnqVrTNg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415737;
	bh=h3qigaMiAcSmTQaHqbISQ7XKggciZD57d6bHCjePfyI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aiU2Yox6jG6dIhLEQFIYGiEEdCpjhvN+2CaGSLvnqQuMBOXS77ULadI7bfUTazu2w
	 siri1DaWAe2Ra5CVZJcMPbBd6+Bju+VfMsMDBGUKioim6KksgOyP2kwH1xAzFi6BJ8
	 JMSfbsSA2kDaAWPaX3ZuL9VGfUxHwni8XeVXKT0yLfEkpy52eW5ZapQ5KlxwG8tdGe
	 DwUGWfVWIGPP4egV/+742nrxfEEX8nzd3eBEZ9LDfRUn4giUAnKN5QTZ9jUobj1ELq
	 Z1URYEp749/dVB8NPjZpF4ptptCl8LsMopmrbNA7lkvz/dlT8l5HReaE8WqKSvtiPV
	 XsL4yt/QDkXGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0368881008;
	Mon, 19 Oct 2026 13:15:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 286221E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 007A84065B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GezERiUFyI3u for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:15:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15F0B40655
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415728;
 b=BjWKJEU4ZlsCzl4EYYoDrEt3dycLGpYNdw8rEAnD5l4v79f+Djzn/JlUKef7vOsEeLUu
 FQ5LJ1JR81F7G4J0Ba3cPeEI+vawYJ7w6NjriJVHQehVaZUiOYf7o8RnuiRoFoFp9/nrl
 qHKx9tjD2DOp/64zCnvELApB/l7Mzrr9v1oDM+huCKshnKG+mE+uZeBCNqSnRyEedWmGa
 yq7JqtFvVAJiAx+nYUhbiizKObM8cm5BbFbWMKyn6M0IDUmmSNlLfF7nJrHOfyhnEwkzb
 xdyznFiejycQLYADtV15nlnf/6dRV0phxZf/K1xbUdAt8ZXfYC5NM8ycu8VT41IFFGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415728;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=h3qigaMiAcSmTQaHqbISQ7XKggciZD57d6bHCjePfyI=;
 b=bVlxcEZa+K+n2WpM9LsoQIbCEkv5sYXt712NRKV27S4Ebgeqd0vpYCyHo4Lu72iQeggr
 yoanzNqWGSfhuCFqKOgFOH5MwMqTxPkIA1JW+qiJ8uS3gNOdbXZqMEAUqXaV3EO6fjrBN
 vKGMvqBuvogIA6FPmOzSLNiRvTN4GKwIRbitBG+EgyHnlq7r9SlRAOTxVKA48kMITwJxa
 zIo+eve+1D5Xb9snv8bupGBt21Kd2Rd6QEYaxlIThWLG5k6bWVvnWZF0icCa8hi3g/fyd
 +n3ndtZ7b9OIXIjk+Hba3pG5kmgIBBF/C8PVM1la5D/hbo1oQ0/8aU77q8f/0r68neg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dj3WBshz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dj3WBshz
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 15F0B40655
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:27 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso2445348a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415725; cv=none;
 d=google.com; s=arc-20260327;
 b=hneP1AocpX2lcBgol+SN/QdDA348CWeAaHdsz1Hjzg9y+8yl4ieE/05NmuGcpYsYVP
 vbviBSofGPWUuSd8CFylcyFBmpSK0VciHzSJy/fkomVaqU46BD4TiI5NWydqtQUPsdjn
 3vAPImRLJm0HMJ3s1NhRXq7llPU/4roLIhJJYkMvQUGNTH6yd4ANKQQ4oxGIKbLxkfc5
 notWC8ZrXQiJviBOWM71Ehrizghi9tEfbkKIl1GY5CCGFjsa1tEJxzzR4W+QKtAPn45y
 wH1Bypw/TN9LhNAWog1jC5+nD9tRe+n5Mz8UkR7jfeo1hTRQuFAE9mA7UBxu7NCAfW4l
 CXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=h3qigaMiAcSmTQaHqbISQ7XKggciZD57d6bHCjePfyI=;
 fh=KBEsqgNGnEVnbbQmK3EQgCFFc32vRbkLT/5eNseshaU=;
 b=kiJ84UXH31rKYZQ0yaSeTqeOqX437DUI6jCU5akIJS0G79M8LHr8ZbnKuOWDXfUaTM
 WMOGy2LIG9lhBe1CaiIIOCQM0zqOMb7MxxFHsJX/4L8OeQQSPISmr4dYd+7WQflB84PG
 +xtkw3myE6ymi8iejFGD3F716Fx8+4qykYFhGM/aMTbKCHVxgadlYkQk09t625HQlksQ
 MrXP92kvPbo6MoioNBUWECqdOhn5Mf8zhHSzCwBJv+OCcuNOJ2Wd2ttmCeP7jdXXicOC
 857SGrgxH0h3nqMMhKLXJcITtP6LMfXOFiI/EOOo0LIZfIawmhVTZw/EAuzs7jrvJ3CE
 +AUg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415725; x=1793020525;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h3qigaMiAcSmTQaHqbISQ7XKggciZD57d6bHCjePfyI=;
 b=dj3WBshzO0fxDxCEBwJ75FulBA3cH/9P1he2P/tjUe0bJS9x8qZMvvfnDgzORu1AGR
 iF2TZ1rVhlBsnW8tOl2YRvW0lSxwBEQ3NiEvzppVPC5nyUJgWmXXLOCf2Yms5n6hB9Bl
 nVfMbx0w0gNmcYqLPEMRp01Gj4A4f8xfV1kdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415725; x=1793020525;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h3qigaMiAcSmTQaHqbISQ7XKggciZD57d6bHCjePfyI=;
 b=OSnQiG1Yg9Qn9IGiWII7Err5ZY+LSCqO/oWAUwFvZp3a3g5cXIzBKTa+HzivDUYDyR
 s5Xb8CnJ7uf4rz2qaPz3+4IwwwT7mYSyEWpruOxrpvEUi9pzGI3Uq+Q///cq7O3Wt6hE
 PCxGQ4E/aay3lUbRR9a/MPC9lOYIqxC33uhKkACIKqChTUAP8qRsi/OATWpvhLX4j8jQ
 oDdxT3UhpfI/+1PXbfYTzJ4v5VojRD/Ocow/FRV9dZ0zLXQ+MvLV/EK0NpbdqevsExzs
 aiXMDwxGBLjIXKRrn6yaOKueS6/Ix9lJib79BBPmYUC+lnR6iD0qD4/fRK0jEWG5xB01
 EYEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzD+JcltwBKzUhJkxSajIMdjMbuqLdnpWcrryDsh/VLS8hrutyaIX20YRmK7toWmYlbOciAlcU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLg06VNfLLKON4zkL8lLw07ndXPtNgFDTDwIIutBiEmFnNHh/bt
 mxaYYyoBOil3vrBN6ZbPj+vbW6BaAaHVRq9/4WccIaevMHLMsOE5JUD15yomIy4Vny/0dIMVCKR
 T0p6gam2+JPXYCy23UYZgHKbIKULuuDHzPUYG9j0btnlc88uaT1JSGw==
X-Gm-Gg: AYBFou0orhguLhbXa21DkiOfSkl+WgY5FZZAXsHY8MebPhLNHtvUQDEhOiYiWq40LLL
 fB5wXoiltGtJphpN50t72KXIMkGnXXGPpUD3RtLK1F9yQDZlBhXb0qZWAjlaAEMjX2AwIxzs+vF
 CWPSSYfSoBuJ4Pcanp6b38Lgs1yBlGlNEWT9LpKlNA5sLnGI2EROXCMq/qY6HlzS0va5jXOXbBp
 wn3poXOCKIYLocE17OOA6A5qZbLgfevWE2B60g2kXvLl0WZTyyfwrPxtsNTRENrjw/BB8V3ENt8
 +7LV1BlxXgcA/5sHZwYV5Ds6Szoy4MDC2mm1nwL9GZjp8G/thxT8KQ==
X-Received: by 2002:a05:6402:3216:b0:6b1:ee83:19a7 with SMTP id
 4fb4d7f45d1cf-6b3a8162278mr4723816a12.5.1792415725620; Mon, 19 Oct 2026
 06:15:25 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:15:22 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:54:47 -0500
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-17-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-17-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:15:22 -0700
X-Gm-Features: AclHuK9KD7QPI54y0PNiCyL3NseJZ71ylVu7HhV3Q06XGS_CPE6yWVWeRCEVoZI
Message-ID: <CAFLszTgZrTR8tGpYMnYPND-8v2WKOH=kbqEFsOueJh2ag3vMGw@mail.gmail.com>
Subject: Re: [PATCH v5 16/20] efi: LoongArch: Define LoongArch bits everywhere
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> efi: LoongArch: Define LoongArch bits everywhere
>
> Add PE machine type, removable boot image name, vendor class identifier,
> client architecture identifier, relative ELF relocation, and undefined
> instruction for LoongArch. They are all coming from UEFI specification,
> PE-COFF specification, or IANA websites.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  include/asm-generic/pe.h                          | 2 ++
>  include/config_distro_bootcmd.h                   | 5 +++++
>  include/pe.h                                      | 2 ++
>  lib/efi_loader/efi_helper.c                       | 4 ++++
>  lib/efi_loader/efi_image_loader.c                 | 7 +++++++
>  lib/efi_loader/efi_runtime.c                      | 4 ++++
>  lib/efi_selftest/efi_selftest_miniapp_exception.c | 3 +++
>  7 files changed, 27 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
