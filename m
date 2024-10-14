Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A99D1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A001F8917D;
	Mon, 14 Oct 2024 17:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X/aBj0HJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B52888936; Mon, 14 Oct 2024 17:50:58 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBA189173
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbce8d830dso35246076d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921053; x=1729525853; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xld8H/7UHiumlElw0HrRWljHyjMZT2GS/hmaPKwwGjo=;
 b=X/aBj0HJd/ZXNkcm443RA3jM6Xs00XzQvp/agaJVNd998QuCAPyMZ8fzQUkTiZi7uJ
 JT6s/9yzyigJQ9fkylWJZM9vL2j4LxuqX7txLagB95M4n0LNSPskyxKuiY7EkYL19yfB
 xAI8zmAOvrzXtqcd6bI4NcbntCu0suRIMhO50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921053; x=1729525853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xld8H/7UHiumlElw0HrRWljHyjMZT2GS/hmaPKwwGjo=;
 b=XqCEd90+SsUkTwVSGhhA56C54tygc8oA7IqpobFu1Dx7QIOlenIGyLRCNnNNVzZ6o5
 H0GS0AzjVDJJ7+Vh9lC46llmCrTLhdl9kvJzLUb81CC9m7zVRfUASSKCizlBhhEvaqMZ
 up7WIMXCcFlH9gD9UYNfT++K/E7ov84gq7ySBsn/KuqPxNqYAz3B/UGBzyYmYYD+Utxj
 yNjR0RRP/lrKRfW+WOOFW23y3Kmt4Bd6oaL5+DZSxAsMPSKTHyN5eIdlCcPcxXP2n8ie
 6bHpbn5AcKHpevoOdgoEc93Mg+bbTJx8XxVPtdc81EwGpErc40XQrTW5KItIGDuBX4+m
 +8Gw==
X-Gm-Message-State: AOJu0YzjtuX3RWuJRHtG6r2AizjUJpcIsm3aWZw/IJn2rPr9rlBPlIoQ
 qGDyazTOi0I0aCl+Q551DHCG7ktkn/PLdt8CsLotb0vxY+joS7mGshKveUfg4S5n4fw4IlDD6S7
 6BiK2h+etsx2vEIFIx18vAq59sdpe/tPHnqrS
X-Google-Smtp-Source: AGHT+IFjBcDJ1bHCMAIkNnkP92SZjVhA0Ua+ZnP43XQBrv6AXJCSoOfW7X7Y0EF4rjLm5LBQUGYg2c9UQexpzA3o5cU=
X-Received: by 2002:a05:6214:5241:b0:6cb:cd88:1790 with SMTP id
 6a1803df08f44-6cbf9e76f83mr160263726d6.36.1728921052931; Mon, 14 Oct 2024
 08:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-7-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-7-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:42 -0600
Message-ID: <CAFLszTh+RL20_0KCpXuK7w9+L4Z9FhOk5-xnzQ6vrKBkSkRBXg@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] lmb: notify of any changes to the LMB memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:56, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> In U-Boot, LMB and EFI are two primary modules who provide memory
> allocation and reservation API's. Both these modules operate with the
> same regions of memory for allocations.

The primary means of allocating memory is malloc() !

I certainly don't want to see this language in a U-Boot commit. LMB is
mainly used for reserving space for images. EFI is used for allocating
memory in the EFI loader / booting EFI apps.

So how about:

In U-Boot, LMB is used primarily for reserving space for loaded images
and to avoid overwriting U-Boot's memory region. EFI has a
memory-allocation feature, used by EFI_LOADER.

Use the LMB memory map update
> event to notify other interested listeners about a change in it's

its

> memory map. This can then be used by the other module to keep track of
> available and used memory.

I think at this point, it is only EFI, so you should just say
EFI_LOADER (or EFI) here.
>
> There is no need to send these notifications when the LMB module is
> being unit-tested. Add a flag to the lmb structure to indicate if the
> memory map is being used for tests, and suppress sending any
> notifications when running these unit tests.

I don't quite see what the need is in any case, since even in your
series (without mind applied), EFI uses lmb to allocate its memory.
What problem is fixed with this patch?

Regards,
Simon
