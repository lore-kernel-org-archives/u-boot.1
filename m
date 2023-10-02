Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCFCE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD3D87496;
	Mon,  2 Oct 2023 03:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lzl0H5mr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6524A8748B; Mon,  2 Oct 2023 03:22:34 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E6A87452
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53406799540so15799245a12.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209747; x=1696814547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xuEz2XzACHND5cth383dBgfBA+5MivC47r+qywCmxJk=;
 b=Lzl0H5mrgJqu82MiUHizBWKK+HNzOILTW5b3nUPoduTv8zViCIpFntQgJ9MEy0aXTX
 KeWZGYxhb8iC1vRHewNMbVIKz3A1zSud62IXp6/3YpsKKoi+ba4vFcInjkZHYyXZR4vu
 T++9rKpXAv+SWNtEF5Feh4Tr78rE6FKvHoZMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209747; x=1696814547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xuEz2XzACHND5cth383dBgfBA+5MivC47r+qywCmxJk=;
 b=fYytadHswdo+Ncx5+7uKO7tY1ahl0e9IbCH1MsumRaHrENlzOwDT3AlJVdnIK/H3mL
 pDsr/UPGvPOPLQ71J5uk9wmsmtKsA2yWrfPUJsPWnBdQDHyiAKXeN+fQmeaVS/9FZFyw
 qUbWVYDlbYFMBmn06+WecdVU+ZaC+godLDTF+33tDu6hnxtkLS/XcG8CD3XCDTcwGyQ2
 0OjipcZ4kHekZg2ZP6Icr38whz5OPS7UPE2ak6YWk9zP1UD9mMlqbxqC3VPFfhpV81Zb
 mftwqw+tFaeT6OWbHsc1S/OJhDi617Z8fCU08ur2990Ra5xJUOg40Cs4CEkLL5icq4zE
 PufA==
X-Gm-Message-State: AOJu0YwWWocSlrBhjcZTy73sfZv55aSlRIvrEVDYyr5w1QK88szrrDn2
 A9EeU6a05Ha1bctuY+MzuO1dJHBnwMeCel4IDgBbTE7wdQzcO+kYTI4=
X-Google-Smtp-Source: AGHT+IFiIFOm90/k5QzLeBm3whmHvSPCNgt+w9sgPVK6eTqDLHYp9cHjaf1QZDdBHUWecD/Ede1ywVNMPofmhlR4XsY=
X-Received: by 2002:a05:6402:1481:b0:530:5465:ad6d with SMTP id
 e1-20020a056402148100b005305465ad6dmr8565419edv.2.1696209746683; Sun, 01 Oct
 2023 18:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <9dd66b67-e372-fcb9-ed38-7ad24d83edbb@gmail.com>
 <c2acc0c6-0a8b-f4e1-7877-73fa5eef404b@gmail.com>
In-Reply-To: <c2acc0c6-0a8b-f4e1-7877-73fa5eef404b@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:46 -0600
Message-ID: <CAPnjgZ2EMus-Q9DY+-7dn-P5+VSLELd8nnp4NOxR0XxHzZfamw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dm: prepare rkmtd UCLASS
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, u-boot@lists.denx.de
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

Hi Johan,

On Thu, 28 Sept 2023 at 12:51, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
> in combination with existing userspace tools and rockusb command.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  disk/part.c                | 4 ++++
>  drivers/block/blk-uclass.c | 1 +
>  include/dm/uclass-id.h     | 1 +
>  3 files changed, 6 insertions(+)
>

A new uclass should have a sandbox test and a header file or some
other docs describing it.

REgards,
Simon
