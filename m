Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28FAC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C34CE88566;
	Thu, 27 Jun 2024 10:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V7JAU4Pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139A48852A; Thu, 27 Jun 2024 10:37:29 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0014D882B6
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6a3652a732fso29972716d6.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477445; x=1720082245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OM1DyXqEC78r3P2Ou6hzsjeBYBvXUJg54/L3v2qoKnA=;
 b=V7JAU4PvobTkVux51wM2gL11BOWp3X5121PKeEJKN3EsNd54AK1muoSrAKAIGv3jmI
 CxkwTvr1ZIpbKaR6t/EdsKUzVlfi87Ed9nu4XqpmOc91S6W79W/VadsHpSjKmVlKGNY/
 tx90Wz8wKvgAQitSw7hWiujE3eFkmOBSMpxMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477445; x=1720082245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OM1DyXqEC78r3P2Ou6hzsjeBYBvXUJg54/L3v2qoKnA=;
 b=VQiJCsPNb1AjiGJxXKDyUhrTW/iE+Y9CVn6PYuss7HOjodpfWiVYF6tUTjRJI7HY0A
 Ubvgld6HY3pz5aGjUXGwg9euJvbAqWEE9MX4vgBQ1Z/t3nnrJzTSBjPdElAKlGm6+xTb
 /bxlOL4m2csJld5S7FvO0aUNz8DZnOaeYKTunQFWe3gx1toeWfz8WBSZ72i+y0rdYNvM
 RTlri8ce6/b73JPxCIqCIni/pE4+k1NNNKqAlSrgWdWBexiR2iV/fOXiDmL7P8COI1N+
 T8lzUYYIM1yZE5veh7uyTGh/iYirYCPlNFGBgeCeNelmnYshHFRBcFfmeQSg8LRBhuc8
 jw4Q==
X-Gm-Message-State: AOJu0YwmuDH1pDW0L76BgLZtXCdiDkMRyt8b848ZpuYI8vvpxFHIITAZ
 wFdA+jg43+F1J3z9MdaRqpQVJnFDAM8YrMLGQoReTi5G7+cgWo0P3xUCDpeE1v86pPm5d7IrQ/4
 6E/yM+tdzajRYzU+rrduX8A73fWbuIWINRSOa
X-Google-Smtp-Source: AGHT+IGyNj6HkNbrmJ/Tl7V7pxohC91sk2Q0s8cZEi2NUPdgTRoXDI3+HNPoqfj/v4aY4mD3POaGJVNXAbnLkBJXCkQ=
X-Received: by 2002:ad4:5305:0:b0:6b5:7e09:970c with SMTP id
 6a1803df08f44-6b57e09981dmr39970716d6.33.1719477444984; Thu, 27 Jun 2024
 01:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240624170041.1024-1-bage@debian.org>
 <CAFLszTg=n1fa8itjbw9t2X7hwjXMr2=o4GaR=5wj27WT1seW3g@mail.gmail.com>
 <8f512ff0-b4b9-4aaa-941c-728030f48ba2@debian.org>
In-Reply-To: <8f512ff0-b4b9-4aaa-941c-728030f48ba2@debian.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:37:14 +0100
Message-ID: <CAFLszTgfOvnux=simD9bM1HpvBt5o5S+Jbz5FNF1-msSgFL+ng@mail.gmail.com>
Subject: Re: [PATCH] doc: fit: Make data-size a conditionally mandatory
 property
To: Bastian Germann <bage@debian.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Bastian,

On Wed, 26 Jun 2024 at 18:37, Bastian Germann <bage@debian.org> wrote:
>
> Am 26.06.24 um 10:00 schrieb Simon Glass:
> > Can you please add a PR here?
> >
> > https://github.com/open-source-firmware/flat-image-tree
>
> In that copy, the property is already conditionally mandatory.

OK. I think we should figure out how to include the copy in U-Boot at
some point. See [1] for an idea.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/cover/20240604195256.1820285-1-sam.povilus@amd.com/
