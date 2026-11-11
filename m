Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0596606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ubaelmtb;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dC9RnFdo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FD96408B0;
	Wed, 11 Nov 2026 11:42:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tgEb2V0skKQx; Wed, 11 Nov 2026 11:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B87284089E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794397339;
	b=Aq08yvcbUxdUdzEWQ+v7bdrJCLPxDy10Ctwwju26HhECtMaIoYKUEhYnqzmq9vvZ63Fk
	 kYNNSfUedjkfBJdGk+Mnznn3gnkl+rtaV5jIYsS/DchoVHjGv+SM1R6ymMC5YhXDz5fPd
	 fzIl4uunl9IMUVByEV+x0hcTj7UdIQ9IDmJ6rI/GDd/bmRTk9Gi0wjScxP59dGvDIMIP1
	 vWtPIQtdp1NFY3GXSPiUYJnkJ4YSfNvVV1vQxO9kRwBb+LQDMk07459oX15aEo80hPya0
	 S2ungtRPlxhzp7Fd/voLN6zsvxovmQwBrPL0paYxkMGqs9lrMZMDb5ZO05/U1c8glBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794397339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EvRizs5VsHA+dyS/ELFIzJF3zqm94lusD9JZocmV7X8=;
	b=YgUHguL/dJnBMBwoPLmtuqPCUaCFx1fcvKtPU9KPTxUkHYxKCP31a/7DEoTq67qTCItj
	 LnXjSUUg9XRcPmufBDufOljz1C+Ar3B0N8eGOFgq0WIdPNMZIEClkhVbH2X57IGBOSDZq
	 HQvghiYFsqyy4boqXFmMinPxwL/r0K5Pp4Cyv1cu53GwSuNlvdB8rNXQGlPrjz680ea6Q
	 xBUsM9JHrJvg1RkzgzYKh8urb6/fa6vI1F/m6rIyBD5ai0vG1jFb28hvbZxxtiXILu61S
	 n3hkaS5HT13sBM8hnvypEcwCgmxJT4gac8HGa++9N0l/7jMRAl206+CSh+fWH5vUkhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794397339;
	bh=EvRizs5VsHA+dyS/ELFIzJF3zqm94lusD9JZocmV7X8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ubaelmtbaUWYkLZKKWLHVJFzRwrhM3OAVQJRDh/XehuSAiXSd1AfUPjFMapz/Pzgi
	 Pq3og5VfuT2tIvQSqd69paJaqGtOrzt9cuzvRovWTBt9nl5lBsFIoFlkmn5fD23v3P
	 fm831uKZlevBE/ywlCLCNEun/yqy5GiMUI8XdL5+gVEwt64o5k0gM3To2Q1SifB0h0
	 3QZd5DNyifpJTbsfqrnE24d4xuTGlWkdJnqHyLq39avw6YeRI25rxy0OIpw4FGINwX
	 t8zzsaKTLgSVW8Rd9JTGt+0CEEtdZZkrabXYARBG1naGY8wf9xklZB9dQ8TzWZp2/d
	 ev1dMutbhj99w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B87284089E;
	Wed, 11 Nov 2026 11:42:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF4A617CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABF4F40217
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jSZ7_BdX420S for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 11:42:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9CCD2400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112e; helo=mail-yw1-x112e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dC9RnFdo
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CCD2400D5
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:42:16 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b360828905so30829997b3.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 03:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794397335; x=1795002135;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EvRizs5VsHA+dyS/ELFIzJF3zqm94lusD9JZocmV7X8=;
 b=dC9RnFdoPgZNOasYrgtoN/G8m+I9QRarhIGngRpyfIgLbqW7D7OYOYiEFTwqexI8eB
 f6w4B0Uq/OrA00grub2YGOIFbAQ12eDY1v05B7vsPUKvkc1DBKb89EiARgRozm+VovNJ
 lr3bk/gQRs9LKEjBGhXzRBfRdqALq5LvyPZK8mFZd/8EYC8H7CdJaySm8vY1EJah3+0f
 aMbZci3mla+EtR3iL0HEWXK8vZDfpmWJYrlWZOGl5RPxjsW7PXazRcsehLt3UsTW96de
 vrLZE1bteHAusonTtvahVosHXE5+E99px15DGPWJ5dx6R7xg7wGKCGCLs3GkdyRX0xJA
 iEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794397335; x=1795002135;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EvRizs5VsHA+dyS/ELFIzJF3zqm94lusD9JZocmV7X8=;
 b=CEvka7diYLkxWXG9WQPAASv+s/JvkSo9WpbVvMtW2gda0S8UnwrISYBvnDT0F99fZy
 2BYik86a2q402D+aVqtRBckwtqGD3wmK7sWTa8dwXEUgxvv/XkX3Pkj5mSxN/nMbuU5D
 rXz7gJwJtKWtJsiDq6KsKwRHctDiHZ8QMM7vCydWiKcJdFs0HBtK0I+kWb7Pk/GDEQIS
 UI3QOpsXXqgouV/Vl5kMGmJtRroiroWvjuG4ja6kjxgotatThfe1fL+0kUfF8SsX41BD
 ZcPq6Htmxf0fnldR2AsiqVVIye8qgbYhG9dUyYqGciAYcx+0FosM4XuKPa8ZnVormfEY
 +OBA==
X-Gm-Message-State: APuU4Z8bT38EWVjpjjclu/zADfOqg2nf7CQdKyio2kOAIGxNgKJhquYJ
 jhB7lVxMxpNpLjITOWg7A+dmLtPt2Bqd6pMonQu+YnyTjsSoZ836x59wVRPvnw+NKuTr52MzdQC
 h9GO8ymLexqwMmnONpSI5u6xCBj5J9/ZshNHSG5MamQ==
X-Gm-Gg: AYBFou0ZbGegMhGwlLcLzYT46n+h8CEMoZ8Q1Qq3x7O2+68l0Nm4IupOFd5zUQB4R3T
 v7NPyJWU8q0JHX3s4RIfIGcEGQM6A24JMqkbCewvAlUg5H5cKrznsSw/Q7UpFS3Dw72pALZ+WfI
 YIzQerOX8Hx1/G/8IehrmKAPiE4JWesZ5FvwyE3F+NX5xnmlT9Ec3IwXSL3k8FxwKkhGQcOqgDg
 5VpLumfa+geU0FMhYabTIaIoZhauS1IbcvuxOa5GE1DYmiOPLHv66BLrgOMNIuBgeExJf2bga1r
 83p8f3/uGKIvoJykL6EVDsUXZLALFO7YaywS1opVSBD92p4ZpdLw++oc75XTCfwGUPew/ynZOYx
 alHJgM2pGXQIZb+XZrwnMU6co4eywLOZ4gumvS3Ubv4q0Diwnw7gvDy4GdRPSe57aYJ6ahYM7Lf
 SUzeYzacCo9dYc9rCbPhEypGt2t+HQ7Oe5UOEEBQ4OtFxb4eJSi2YTiJ+JFd1D03RlljGx6XOnR
 bNvjK3LOAGvEbaEapIbLfiXrw2i2dXHAbJFaZklxSoUymPbHV1bpKO0osu4L5toSWiyofvcrolc
 T3Ozj4mknF6bsefUnZp7EkYSewICadmMY7gdviyrLaeu3qv2m9wp+c4vovCMk80ZkhY56+4GPgo
 p6zuas6aDnOnuYGQoDoR842YqO8ep748z68EQ69lURpLgIqu+htLPuLnEhMs5KYlRBGYJtEqp95
 n+a3y+RW4262o96mOZLO4PR6JgRGH1zUd2WnM=
X-Received: by 2002:a05:690c:c142:b0:8ae:8021:568b with SMTP id
 00721157ae682-8b3a80edba0mr14195607b3.55.1794397334795; Wed, 11 Nov 2026
 03:42:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-genio720-ufs-rpmb-minimal-v1-0-701a62dfa034@baylibre.com>
 <20261111-genio720-ufs-rpmb-minimal-v1-7-701a62dfa034@baylibre.com>
In-Reply-To: <20261111-genio720-ufs-rpmb-minimal-v1-7-701a62dfa034@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Nov 2026 13:41:38 +0200
X-Gm-Features: AclHuK9idqOlXeTTsse6CrISbmYmn5kVAfqrCJzVS4u0AxfMOWqqJSEI1AoZZR0
Message-ID: <CAC_iWjKA6T2g651b5SCE2M+AX5gJkdswnUdq3YhYNsUToQt68g@mail.gmail.com>
Subject: Re: [PATCH 7/7] doc: uefi: mention UFS RPMB for OP-TEE variable
 storage
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jens Wiklander <jenswi@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Carlo,

When we designed and implemented this with Jens it was in theory the
abstraction we aimed for, but has anyone actually tested it?

On Wed, 11 Nov 2026 at 12:21, Carlo Caione <ccaione@baylibre.com> wrote:
>
> U-Boot's OP-TEE supplicant can relay RPMB requests to a UFS device when
> CONFIG_SUPPORT_UFS_RPMB is enabled, but the UEFI documentation still
> names only the eMMC transport for OP-TEE-backed variables. Mention both
> options.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>  doc/develop/uefi/uefi.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 94ddf690440..5dddfba32ca 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -214,10 +214,11 @@ CONFIG_EFI_MM_COMM_TEE=y.
>
>  Tianocore EDK II's standalone management mode driver for variables can
>  be linked to OP-TEE for this purpose. This module uses the Replay
> -Protected Memory Block (RPMB) of an eMMC device for persisting
> +Protected Memory Block (RPMB) of an eMMC or UFS device for persisting
>  non-volatile variables. When calling the variable services via the
>  OP-TEE API U-Boot's OP-TEE supplicant relays calls to the RPMB driver
> -which has to be enabled via CONFIG_SUPPORT_EMMC_RPMB=y.
> +which has to be enabled via CONFIG_SUPPORT_EMMC_RPMB=y for eMMC or
> +CONFIG_SUPPORT_UFS_RPMB=y for UFS.
>
>  EDK2 Build instructions
>  ***********************
>
> --
> 2.56.0
>
