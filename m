Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4647CCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C44839D6;
	Wed,  5 Nov 2025 01:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="exNxRb2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37EA783968; Wed,  5 Nov 2025 01:42:07 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A14A839D6
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-7864cef1976so6619537b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303324; x=1762908124; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLe5kHWUXUjixD65wDzOAr8Y+KoJUcpveIbJkQlKUaw=;
 b=exNxRb2XsKSXLYGatB1q+Q8iocu428ExpdYhe/dk9Sqfa34YhmvSkRei4J0JKQ76Ol
 Lh3TXOkkjhrryRydfPZVdCNDiSO9KN3T874d6bIQoCUNzJa+rZv1ZvZ8gMjfZQd97rWd
 ut7vun63BtHScUlo9OYM773wCvNWT2XYb4HbarqL/tNtLzEFNndzccY6yVVkp/vXRwME
 /4z7IGUG26GVplkM+tOqZRA5lVpUwGBa7cQq0qRLy+ti5ntl4t/V54nNmU8oP0YCj6Ol
 kpMUYYOX/xx6wtLpNWnfs7kL9rlmZdp5pVuJ/TipQVDbz+eLCbYQ6nI6v9xRRxSpfQnj
 MOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303324; x=1762908124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLe5kHWUXUjixD65wDzOAr8Y+KoJUcpveIbJkQlKUaw=;
 b=VKo8ulr2IbhgS/09Bu5CyG2wX4db8tauC9bZWMCyNBHr59+62IcVrYc5RNWndUDvej
 zlqMmnX34ncTLDl9M2LmcToTY5IfCG3ni4hH/OjwJ0IJFHJdU/sUKeyaY9J76eyMM7AV
 rJ5u2vAdfr4OIIiKjeqj9/ARPAyjpR65MfOoNI2M5+NRl6w7gcHhLZf/l17X3VwHbBvp
 4udRBlv3T0ecgc34iORIzPpPtqnriQ3bCaL8BuXHVD+nNLClXuTUBcSZT++5e2inXtRy
 ywBmoNcQwmKhADrToWu4qrqYhWIPZmLoBMWuNFxY6nqFGfFUWx3bMTyl45ZGa52BNa4B
 QlhA==
X-Gm-Message-State: AOJu0YznbxdPQd+jrJ93VrZFrcCTR8i1k+xeklspcfeWYQn4C18o9cUI
 z2fnAutKZcQemzP4nxIr+oNw3qUTJpW+Op87Bb7xdf16LTrx07pEdObVhk+GGNCix4o7LjutiVS
 99aOReUJebuN9jpN7fDCLDdkcSUgG4jhWgy+g
X-Gm-Gg: ASbGnct3J4s38Y/yGlNIJ0QRHL4Qp+VGHQRWXD458iLyGpakujSKZPGu0zCUEAucei3
 Ncn79ExJwBPiSbDU06TY+qZRuVAshen9NjCJ/YhGTEj1PRNJMrP6tqCR/67W/s86PGSH+sEF1oT
 Z5z+87CwRjxWVbHfphfMy8RYBPt5ptItnVYEixDBC9ulWDS4GRK2CQ1FNj1a6vkF21B1FaYQlWp
 lBCktFDfZ2dOu6Ri1f68vFrOpxCElmmxmDhpmqXKevwDpbl6nmWtrhH+6dn
X-Google-Smtp-Source: AGHT+IEjvrn9waeikf3ozlAXXwm/JL2M0yT00bqcB8AFdrngtsk7jk1jFwcZ4CCM98pX8i5WMbcS2yk28xDGaz4zUxU=
X-Received: by 2002:a05:690e:11cc:b0:63f:b5d5:e7f2 with SMTP id
 956f58d0204a3-63fc7632399mr4151640d50.22.1762303323823; Tue, 04 Nov 2025
 16:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20251104234231.89796-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104234231.89796-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:41:52 +0800
X-Gm-Features: AWmQ_bmRw9pgHfhr4UE8xITnDBOxU-pPG7TLyAaso8r_b4AXaZEUh40ccq-b3uU
Message-ID: <CAEUhbmVq5P9q1Eczs-oaKNLe6dTyK6uA3DqV0nAx8UHwY2RnKQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio: typo 'private date'
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Nov 5, 2025 at 7:42=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/private date/private data/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/virtio/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
