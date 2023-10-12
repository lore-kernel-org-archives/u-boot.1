Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0568ACDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 570CF86E1F;
	Thu, 12 Oct 2023 05:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="1iNK/vdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903F186E0F; Thu, 12 Oct 2023 05:41:32 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7207286C0B
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a645e54806so77251166b.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697082090; x=1697686890; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=13H9ldlffZnGHRAEHO1o8w1suUwvpWLHdIzoWV9JBEY=;
 b=1iNK/vdzqWqUYrm78BjqZ27sUvz85CDtKy1jgREgvs9r5JrXxC9vuulHbSFeSc6NnY
 nUiwl4IMo5+vT19U/8xvPK7MowksDiYo4BPFmMtsERbwsOmqDqLSpncG5ngE2KW/eIYV
 YT96je0mDDEQnTQFkOHVkOopBZt3VLbgf9YSWJLSa7x4xciSYL+CEmyYO0C08qeZu5Ek
 GAZeyxSP8ip+xXtPAe06sGM6MF0FcurywD52zXb0Q9L8LBJpRU0QBprcmMt6OmPA4Ed2
 7yNQjGfTFr2aM5m7r6pLca7NOgxH9EfpmiXCoii9JgUqbjmEXFJAYDtrdajbR+u5xURf
 x2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082090; x=1697686890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=13H9ldlffZnGHRAEHO1o8w1suUwvpWLHdIzoWV9JBEY=;
 b=j372qtNZwoK1zh/0pXVdsX4YjafUrw6NVyL4AFdNVn6d6D7OGJffLpuxBka0wJFM9T
 qByrMO5GhYhl4WfVjlGegDuwaXzfD3Dwd6dJAuw88s3hTub7EyOustgasrk1BY8ubDiQ
 BCcIoHUqgSwYryHnT2wBMySeJbIcUXTqmOYRszBVBMeuxplsT5DM57ruIwpTiheOaWdb
 Mioy7nhgu2ED/Fh7HR6H8zg7r21DSmGhHkxJWllpLsaiM8ZUdm/B9lRnIFpkfhJjBwCn
 dg77fS/NDdWFRqkdpmmYhHfS4NKm8PlIW/MCp4ilAwWXa1MookHBIEmVROD4K2tz1pkQ
 HPWQ==
X-Gm-Message-State: AOJu0YxCngqy/0uxFXpzB8QoVZ4nNwQFvvFNAG26iATpJO5gzAi+8Mkg
 S9G/2pHhpL9sfJ21Cw4YUFadrDodVgwIuviVyyzRf8Px/abk0syZD7k=
X-Google-Smtp-Source: AGHT+IFNEey2lgtWqw23ne9VxfHvG/KwI4hZ0gg0D/vdEpAPAj89Vjdnw6dIAzyB5J97c2w00hzlFhRBTflMjDyM6OA=
X-Received: by 2002:a17:907:7850:b0:9a2:474:4aa0 with SMTP id
 lb16-20020a170907785000b009a204744aa0mr21038992ejc.48.1697082089852; Wed, 11
 Oct 2023 20:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231011105825.2956485-1-bmeng@tinylab.org>
In-Reply-To: <20231011105825.2956485-1-bmeng@tinylab.org>
From: Simon Glass <sjg@google.com>
Date: Wed, 11 Oct 2023 20:40:59 -0700
Message-ID: <CAPnjgZ146sWENJ-zwSyxAL4jQZOdnPoshg9cGv62ER2c4mWM_A@mail.gmail.com>
Subject: Re: [PATCH] net: e1000: Drop e1000_eth_ids[]
To: Bin Meng <bmeng@tinylab.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 03:59, Bin Meng <bmeng@tinylab.org> wrote:
>
> e1000_eth_ids holds compatible strings for e1000 devices, but it
> is meaningless as e1000 is a PCI device and there is no such
> compatible string assigned to e1000 by the DT bindings community.
>
> Drop it.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/net/e1000.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
