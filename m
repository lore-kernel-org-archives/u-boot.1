Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FB5CF45D9
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 23:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20DA83923;
	Tue, 13 Jan 2026 00:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nmI36zkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC29683935; Tue, 13 Jan 2026 00:41:48 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB34B83759
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 00:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-64b92abe63aso14324591a12.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1768261306; x=1768866106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GAN5iCQh7KwomWQRUb6WnkkfdQoWzQ18xh8QuTIYfrU=;
 b=nmI36zkH4Mrfhd7VqZteM3nHAVH2jJNY/1Wk0juiPt7lAfxw+5b11Q57SqiVCM8kBi
 2GYWPT7RXnWMQWG69V2wqTZWpAe/s99JuDK3KtkaPPuzhri6Ul9qWi60fMFs6PIO4aGG
 RBJwGTYLuB5MvaUxepH/+8bBmjUz5zpiY9PAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768261306; x=1768866106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAN5iCQh7KwomWQRUb6WnkkfdQoWzQ18xh8QuTIYfrU=;
 b=wg0lqNwAtL0qLV/hDeF1DdSVYyEsFBstLRRz/zSQW4N3TJtPCgMCtBUrgZ8VBrWt94
 JYPgpuYWqWO958qff1qpD7EfKeiWVrGAzgpMYsQ9LuvJhrPVC9cdf4IeaWicsrbnHL0m
 620w2vDLbIeaBwi1hPU5TXJ9t4G6AFoJz6jIG/PcJ1MHLQvatxc0aRVNLlp9iX4r59eu
 gersoZeEkWh7kUQJAc8MQ+SK+rdNnkOxzCUIhHl3dE0NNXzg056ok1UQMicnyyq7OpBl
 r7LMZwbIE48n4WgnHPVAGvFwaY3avo4aNqtmKbBq3k4cDZCQi34j0a8u1aK2F6beeD74
 Qy8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc1f7msLOAG9A5XCNjODSJnO85YU3DnREJn9GCJuionI17xfaG48fsYY0k/4weBaiiWJTlWus=@lists.denx.de
X-Gm-Message-State: AOJu0Yyb4QELQjxNoXlVExHzXuPyaNDqPxcP4k6c5FYXJ8fwxtnQ0R23
 vW4G4Xe/xTa9QDceYdVGaNXMM2JUMZ3txJQQAqqdTtqxyBuAK0ef5MnrPSl1cRXg91GQd/sKkzH
 QH1fUWDdhsAVIpbTIf2sSJ0LsIRBZlqYIPDwkZaI0
X-Gm-Gg: AY/fxX7KhpUw7SspMUBRzZNiL5/Cfoxx6i+If0XM122N9SySwhQ1Tx4kThM/gZbhXG4
 iEbAWbGHc8AykXA7VSqaP+OYZwDOpYzCOksW0qgRwv/WflZlCbAGVvPn8TZqbxD1x8uozDYXVRv
 yV3sJ+5QtaYDmfhwwuOUQejOafEbnndWypvUVYeMGhla2opOJExs4dI/EhsDfu4AarFUx/aPBTd
 XjrKeRFgvwZZa6gvY54aF+0zQa7e23PmHcbPdx+MCmTnyZczeEQa8IcEVfxXSwp+ZTiSQ==
X-Google-Smtp-Source: AGHT+IGfyEGuprEDwzTdhwbJzUTw70mg9WtfFtUOY/56KUhqWs+RFSsdbwe2Jo8TopmItu3/umMU6VfCd0mw2KIxCIw=
X-Received: by 2002:a17:907:94cc:b0:b87:124c:5f54 with SMTP id
 a640c23a62f3a-b87124c62dbmr572507666b.59.1768261306112; Mon, 12 Jan 2026
 15:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
 <20251203-fit-compat-v2-4-0fea56f23809@cherry.de>
 <CAFLszTjqZhQVP0m8QUUKsJbJLZo4VZmH3+3sdVYn267EthAKzg@mail.gmail.com>
 <cc2e746e-9864-4fbe-aec3-2419667dab38@cherry.de>
In-Reply-To: <cc2e746e-9864-4fbe-aec3-2419667dab38@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Jan 2026 16:41:33 -0700
X-Gm-Features: AZwV_QjtoyeZJSeqE9Cd3KEjjdu69WPv-ucuY8QcfQy43vQjp1abi23elYGSZ1Q
Message-ID: <CAFLszThSDyJ+O6PGFvQfctfXEEkc5=P5vvoGL8bGwgBXgFr8uA@mail.gmail.com>
Subject: Re: [PATCH next v2 4/4] boot/fit: print all configuration node
 compatibles
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
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

Hi Quentin,

On Fri, 9 Jan 2026 at 04:39, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 1/9/26 12:35 PM, Simon Glass wrote:
> > On Wed, 3 Dec 2025 at 09:19, Quentin Schulz <foss+uboot@0leil.net> wrote:
> [...]
> >
> > Reviewed-by: Simon Glass <simon.glass@canonical.com>
> >
>
> Thanks!
>
> > Concept has:
> >
> > 40fd6b04b9f boot: Show compatible strings with FIT information
>
> ? I don't understand what you mean?

Just mentioning that I have an almost identical patch in the Concept
tree. I also recently did a refactoring of printing in general, to try
to make it easier to maintain. It's quite a lot of patches (27), but
perhaps after the bootm_final stuff I could send some of them.

Regards,
Simon
