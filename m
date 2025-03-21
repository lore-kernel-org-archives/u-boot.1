Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA4BC36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 13:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49695803DF;
	Fri, 21 Mar 2025 14:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgrlXvhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B59806D8; Fri, 21 Mar 2025 14:27:34 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A24C8001F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 14:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so4132402a91.0
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742563650; x=1743168450; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWx18NzRbQLBZN+NJGWKPGGbqF5uH5Qqx6a2kcRNJYw=;
 b=TgrlXvhy4zEWH0lflZ6zlnqZifAHFvwYGihld5LiRvG84ckgsR7o7RKBffsFYEUUtT
 44snP/RB2mqnudEu4JhlXjOiXN8jrEteVp9GuoVsaTvRdaMQePi3Yrj0VQ45tvtgqvjh
 PqftxZaPfH6pzJAhlmuVQnhIizvSyRGHW17EpAocNBoLSKiK5MYZyNUV5zmBkHvHdlSV
 ULVHIpKwaIvB7VWTqmr6ATDqY9SQERUOjpzqtJko/ZpDp2/taszLCgwnKW5MEr9Yomxg
 KXnJ80vEkLZKZbs+JunzHUkYVxYlvHvKvqSsr5kfNe8z2idpA/c8Enqf3Jo/UJrfWf8N
 6pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742563650; x=1743168450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWx18NzRbQLBZN+NJGWKPGGbqF5uH5Qqx6a2kcRNJYw=;
 b=mo2rsNdgahE8gWkJwgHobBBWG4a7mA8azu9rqPdVfrZNquccdf39yXDKmxzkBM2c8j
 xz11YkZU7W0AU7isZ7YUqND+5fuhNkTyVU61sjoslHH4uNcm6a8KtklLRzDZ/wh7XTEP
 AdaUDUi2nijOAz4dmVngtyVrYWewlYziVD9LolRm+ANHhBb5C3VnNi63xjpdvr51+KhF
 UX+HdyhiH+6mgn9BHu3aoivXuEAZaSsD0cgDLLYTNPeuKMO7L9muG4IMs71eDv1ZKeht
 PIZObb8kCWpnezrKFnzcaQoGaaB2uUzf9PBUtKkBl/+EzpkVvkWdBu6e7QEoxksSf4sB
 lE2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwol4fq1ZFpGJVS3iox9UbjRtI8uHYt5JK3EgpBcpjZ4eKtYXXaBFMFxUv6vg/W5tV0RhX81Q=@lists.denx.de
X-Gm-Message-State: AOJu0Ywj5O+dQoHUW9LD6EnqG44JtNQU3UwBVAb3/KlGwVSNAdvtS09r
 82Rp6XRjqlKJWJ/d7DDLrkVKGS7xmxhJ6Cyy0rbLkafrcCoZwJHI5awPZc5IHYkauyPtmFUNaS9
 bTQ+LWNb+DfZkc9kCbtqE4ZBnbpg=
X-Gm-Gg: ASbGncsWRre1RnlY9ewTdfLUjHVPyg7pDSybRzYVyQNyzt/2otdAc/9zAv8zOsllIbp
 LgS+t+h4CyNyau8z+6MT8G6LNNwiZ290zyxWkmZhLxvX7vDYXVV4xpRkL2L6YjCv4wn/oidxHow
 JBSe/C/Aj73uoduLQFLC28c3DWew==
X-Google-Smtp-Source: AGHT+IH6VC4c5fbPq9NE2VjkiP4ICP0+6De3vbHrOzVh9U9bsyrGlPAlqqxKkiPDwXjv2oE8rx8arrx1zwu4SDASD20=
X-Received: by 2002:a17:90b:38c1:b0:2ff:52e1:c4a1 with SMTP id
 98e67ed59e1d1-3030ff06dd9mr5384416a91.24.1742563650268; Fri, 21 Mar 2025
 06:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250321013109.709431-1-aford173@gmail.com>
 <20250321013109.709431-3-aford173@gmail.com>
 <7592b048-da30-4512-b6a3-f435b6f3bc3d@mailbox.org>
 <CAHCN7xKStps4Cyr8=WaCU5bUY_doeh4jcUHv4XFUm7CLjq2JWg@mail.gmail.com>
 <2d30bdbe-ff01-42e8-bdfd-0748e0546240@mailbox.org>
 <CAOMZO5DqTbRdeL=h69wSNoMfCFLT9KGUGz7S4R67hoaB4nOZ1g@mail.gmail.com>
In-Reply-To: <CAOMZO5DqTbRdeL=h69wSNoMfCFLT9KGUGz7S4R67hoaB4nOZ1g@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Fri, 21 Mar 2025 08:27:18 -0500
X-Gm-Features: AQ5f1JqAkRgJ7VO51YKoBpKTUshmSy2b-9ac5LlH8MdrSMt8pEqJmkvtdKlDcbg
Message-ID: <CAHCN7x+Acbwgo-Dm3fmvat=keEhwW-r5JLNn5AkXFGAaRDAa7A@mail.gmail.com>
Subject: Re: [PATCH V2 3/5] arm64: imx: imx8mm-beacon: Enable CPU_IMX
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 aford@beaconembedded.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sumit Garg <sumit.garg@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

On Fri, Mar 21, 2025 at 7:10=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Thu, Mar 20, 2025 at 11:27=E2=80=AFPM Marek Vasut <marek.vasut@mailbox=
.org> wrote:
>
> > Yes, I know. But then, I can safely say it is desired on hardware I
> > maintain, I think we could try and run a quick poll and see if others
> > see it the same way ?
>
> I think it is a good idea to imply the thermal driver at the SoC level
> instead of per board.

OK.  I'll spin a V3 which implies the respective thermal driver at the
SoC level for IMX8 and 8M families, since those are what are supported
in the CPU driver.  Should I expand this list beyond those?  I am not
sure how far back to go.

thanks,

adam

>
> Thanks
