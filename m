Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96522E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E0A87154;
	Mon,  2 Oct 2023 03:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SK9MG8z/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C093C8717A; Mon,  2 Oct 2023 03:20:59 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB02486B3C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59f4f80d084so154895547b3.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209648; x=1696814448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QO7DrImNcxSy3k73wbxmODoOtEFtUp7zBxVlpD0apXo=;
 b=SK9MG8z/C1sznKN86K5uqD99BSlgfCHeeJODOH0AesFzAJ+NczG/zKRqYoooJoUEwv
 mXD3cw5QbVUZBY/eErlXyCfaI1o/bWLLua476BqH5rT4NE+6yJHTjmfRNmJIy+4SNUd2
 Gjzmso0IvjTSDbalxeux21h+3AB8vY0rkSMIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209648; x=1696814448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QO7DrImNcxSy3k73wbxmODoOtEFtUp7zBxVlpD0apXo=;
 b=tBs/RAkimsqXsjOZZpskf3mrxUQ/VNhHPguE9NAEsz2SqVwmdvWGyrK1j1/VxWOg5+
 uwgujTOFFdMQMbJKq7KZZeFBPbhFDC6nupqBB6qyfg3KH40QxaQkiklvoNDQbMT/hSEF
 gQLvv0hx/jEbo4512n67K8lJ+0jFt6FOZi8fsXdSuR4Rs+Eyx4wPV+80KPosqcGVyVae
 RpFqRBfGtUIA1I7b+oK4zpoFxOzdbZAavQqY9dv8RTJk2ScJGamByiwtCmaLJCb5e5Ib
 vn8eVVl0UNF9u2cK3a9uwvYFwDDA8jFJLsxOi1guwd9SKgd+w5NaaoH6V0zpB8x4470J
 /O0w==
X-Gm-Message-State: AOJu0Yys31IHebuWmORdIkWi/rJMO2GfbZqa11M1l2EhDxy1kGs5TBGV
 kv+IWnm1j0blt3ZrtNMAZw/6BIqyo0iPXKUqAXpgWQ==
X-Google-Smtp-Source: AGHT+IG/KkEd92EvEKogU21yq5q0j/KPoq/iPqIgQ4cdGv0j9BQrEdAgPVu9Lgt1eUed7Cd/yccx/E9ojADUHxKMudc=
X-Received: by 2002:a0d:d587:0:b0:59f:4c52:2f5d with SMTP id
 x129-20020a0dd587000000b0059f4c522f5dmr10397067ywd.2.1696209648313; Sun, 01
 Oct 2023 18:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:50 -0600
Message-ID: <CAPnjgZ3c9PQzXEt8nFDNa=Htq98mM=Zzx4yjq5cYrPUn27FNwQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] core: fix doc comments of dev_read_addr*() and
 related functions
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
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

On Wed, 27 Sept 2023 at 07:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> - The dev_read_addr_name*() family of functions has no "index" argument,
>   doc comments should refer to "name"
> - Specify the error return for several devfdt_get_addr*() functions
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  include/dm/fdtaddr.h | 12 ++++++------
>  include/dm/read.h    |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
