Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590B7F3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D998418C;
	Sat, 11 Apr 2026 16:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GX+HJSWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2DC841D5; Sat, 11 Apr 2026 16:37:37 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEE384198
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9d9971d059so145410966b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775918252; cv=none;
 d=google.com; s=arc-20240605;
 b=T/I2B5j1Mjhr2fLGQduwQT4rcPcXkiSuN7hu2lBMozESEJsjhEd0g3hxSZb6D/RXyQ
 bh4cMmZZZ7DH7c1E1Dhpa3CIAkfQfCL313mB+9GG3GK2k8iz8lmuiOGmgtnq7PZH+h2t
 VtNZMhOSFk23QnGJ0hdBT5d2/K9mNU8LknT/EPLve2xFNbyeAmAEYcxH+YPcvV77llaK
 EH32K/uZ3FdNk6LMu314svshsnxYfD64CwH7fShZorzWIL2KB0IQY2ih/AORuL1pkM1M
 +UljhTxBqSeIfzMTCEw/2VqWd7srbh9LSQOHcLELeedR6RRRKOq2VTNsgN9ic+LQiwy7
 mfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QUDsYm58gdvYWK8OGgT8zMvxWNSgQeLQAf9J3qgCYgI=;
 fh=bmSH9koqKj4GnjbTG0n5xSv8UKRMztqmSvaMRIXvRvQ=;
 b=bNLcX5wV4GEN4arVEWUKcwofECEQ8RuRGrAV746pRJ75StfkxhcFoga1Ha2SdDhzPF
 2HFv3KJf2xmV9who+Cnx+hAj/U3zhAEiXFB+4g6XXbIECx050rueHVzfZ4APtslp2dVn
 hhlbIFQKX78zT2ESlJVZiOyTpJ6r0wzgkvAebuXIH01v21ZqBsW0/MWuklGGXPTur5TH
 JcsMAX1xSuq9FHs7iEMX+2Vs4Mdh+2LaFmFy4ffSmbvdrBhP5HHxluN4ts+nSK4Jc1eB
 +VoeLaeADYUzTydn7Ur/tJmKPz+DX5TGn3fVnEo9corCTwuXT8VHnSfNMhEDsBaSQk+7
 Gnig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775918252; x=1776523052; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QUDsYm58gdvYWK8OGgT8zMvxWNSgQeLQAf9J3qgCYgI=;
 b=GX+HJSWmXxYMNfxIzh9GKIyy94VwaBf3VsQrHiHinfhiFayoPaCaZMO4oEnwtxHqen
 xa8sGVkVGZnwurRz7CtpZqvnf8LJ0ii2FCw4tABUA+nKAunYnpXhAD9zApknwc4m8O5W
 HQnhIQQXKx1e2+34b4KElRc+uESxUpkO7RNME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775918252; x=1776523052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUDsYm58gdvYWK8OGgT8zMvxWNSgQeLQAf9J3qgCYgI=;
 b=l3W7hqh2j7K4cBlf0dPTw/wfT8gRnAO/tnr9odnnYvHcFrkYXJ+FiX2mSqLnxrZHYR
 ksFWwe5FZHx1IplFGDyIw6GbH/NCPQBpoiDYpr+YG/HAQWwsSFd0YyegxoJpWUi6/oUh
 zhE6KulumHQvcI6pDRmwNGXHAUhg09GS6bwrVdETXmYE3bu4lzZaIYt4vKeE58VmWqpF
 4TC9DndH1jAslyQ2EOWiBAKTP4vtyxaAhEwi/8h09nIxP/nqlsDW5zGLaBBxrkkNkKnG
 46IHg3VSvTaydsCzhfoJzdDNrKRp7aQEFnhaU6MvuUiZVda4v1IhWaEQZVwf/U/QMgmE
 7VJQ==
X-Gm-Message-State: AOJu0YzOgfuKOMpNECjS1Dm+KTUVe37gxviAvEoLKymIs1Tra7mVET6H
 eWseyHr4objO44RadIeqykqq6siapynOppK5UTc5MJz2JskSGEN5aLIZmY+VasdXgnB8AqSIGc4
 YBGNGHqWZ3DvB5Wrtnlu5/mFuSbU9hDLWJ1TBZcYdjaEYzNYPKEza5g==
X-Gm-Gg: AeBDiet42ogh8RqZ1n0SnYktAEEJC7n1I31BElwY8W7QQQMkau5ThNcdT0bU3OX6ShK
 eu7jECSA3hIPNYZP+gRAjASAWNXsaJnmkpUe+If6FQwsv53N39TwyzYBunph4+INVhIAcJuqISi
 54mGpz0uivPT5QzWvKaqQ10B5oaVfcbYV2xjcZt5vVxWyydp0HYdN74LO/gWwFkO6ddhXkrS1UY
 ZfxzNVy83HoTRWvESMjDIyX6pCDt8SVw7Th+kEDL/8TGhN9lEzITiOtxbYT46tKLow3D/eJsh4q
 2Gi6sw==
X-Received: by 2002:a17:907:e107:b0:b9b:5164:905c with SMTP id
 a640c23a62f3a-b9d72793041mr227149666b.14.1775918252463; Sat, 11 Apr 2026
 07:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260405144944.41074-1-lucienzx159@gmail.com>
In-Reply-To: <20260405144944.41074-1-lucienzx159@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:37:19 -0600
X-Gm-Features: AQROBzCd4VArlL-QBU78MHp8Pvlcsyv9M9RU0UkNhvyNU_zwkmFkpWPJ4HaOTnc
Message-ID: <CAFLszTgMvRHfrEa8=-m+AszoKvxg-TshcH2qx4z--yN6ZwoQGg@mail.gmail.com>
Subject: Re: [v3,0/4] phy: add common PHY polarity properties support
To: lucienzx159@gmail.com
Cc: u-boot@lists.denx.de
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

Hi Lucien,

On 2026-04-05T14:49:40, Lucien.Jheng <lucienzx159@gmail.com> wrote:

> Patches 3-4 add sandbox DM unit tests for the new library

Patches 3 and 4 have a bisection problem. Patch 3 adds test code
referencing DT nodes like /phy-common-props-missing, but those nodes
are only created in patch 4. Please can you squash patches 3 and 4
together, or reorder so the DTS changes come first?

> Add obj-$(CONFIG_PHY_COMMON_PROPS) build entry in test/dm/Makefile

I don't see an update to sandbox_defconfig to enable
CONFIG_PHY_COMMON_PROPS for testing. Please can you add a patch to
enable PHY_COMMON_PROPS in sandbox_defconfig, or imply it from
SANDBOX?

Regards,
Simon
