Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15B3CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D7D83E42;
	Wed,  8 Oct 2025 17:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VH2Niqga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1493F83E8E; Wed,  8 Oct 2025 17:34:27 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092A583A61
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7a9c15464f7so2411087a34.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759937664; x=1760542464; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WH9w3wVpTLv0Y5vvWNZr/nFbOk0+rywuZIfOVXO5BZ0=;
 b=VH2NiqgazTvz1GfMqJiQvqVWl5I+uWHqivUyFHzxo0+c88IQX6zD0JmqNaTmZJg/1k
 qqQOs6VhS9IENpBILxQNjzCvpv3uzxDe2U1DiOWnU07nGvTVqmaTOgR4yVDpyYWAZXlp
 8o3Bcag5Mr3dM+sfiY71ibfe+UvKQVqYoK0QEdtE+gpf+84GL7HWV6dJTiPYGpATAYXi
 TNzen7V+oPht2pRNf20cvSuLPZwDnWJ6KMtparSFtpUfTejNCtg//2Z5RvBZOb99x2ok
 CEmvlMXoJtb3BoEo9EX9u8Zl4B+hWHyUN//us/7gBN0BzPCF5oMGQu71IfZ2fdEE4Ebz
 cxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937664; x=1760542464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WH9w3wVpTLv0Y5vvWNZr/nFbOk0+rywuZIfOVXO5BZ0=;
 b=o+X4VEI/ouFLnvDVFeDyj3knSAmU4Jz+HybBeisAL/qzdxh7l2EvVOf8O03AzsPMFB
 865vpgOhNJXJnsU3JQE0OkNb0bN1BTq7eBkUgFZ02/P852rqlqfoazsbdciSyv0Hf21t
 WibqqPWiGIs/xRNy0odnjfP8b1CaNXaZqUb+ZlJrjF55SqOh77eqAGVWem3HP7tFh6Mb
 AbzTQrs2JRN6Jc0GhVDm8+LLHONTpmRproT22HYMrE8JnNPLFWDq40vFSGUxlAk/isZc
 ZjcGm4kPixgqrEICyDd/KBnsVCe8ECE0YXhw3edQkWiLbIOv5B6aj8G9BzsxiHc9HHfC
 ddeA==
X-Gm-Message-State: AOJu0YwXtQcMHujED2DWJ2TsTVvsZKJFvQ4sAz3jdZqhz4nRrlfLDcIR
 U+u/DQ8mXpqIvjO2w9K+9b3M6W/Lz66KUEpsqRBkNACe8wXFa3S27EdMntBSsN3tUrAADZm0aB4
 viCofy7l6o4lJiBYsuujLtRxPklbdbmi+9Jnb74e/7w==
X-Gm-Gg: ASbGncsWbvxWyfjmzxddyfbMedd+VVdIzB5U8U2zAuFkRz1sqnxQ4nq/lX2vsKRuW/G
 0VKEtiBnhEC6NoP2osaM3NX4Ah8zcxskh4wmRUseD1r/1hJQa7fBunskLPAML0QPS2ZMXwK5acy
 WlgiGUBmf39y9+QyB3T+nzO6/d4i1P2mIuGsX/uySMOU6Hd0GqjnvRT2Cg5Qqm85e/LJLLnWxNg
 ViesAWC7BG7m8TvKu2O1JVr8bToTEc=
X-Google-Smtp-Source: AGHT+IGslUWSJ+f8LoyqL8jS9rTq8p1Ld4vjaZBvbzEZVW8EqBhnsUGlWt6quzj+XsoVl6DFEjsFTTdSCnzAWChAOBc=
X-Received: by 2002:a05:6830:2802:b0:73e:7f48:e6bc with SMTP id
 46e09a7af769-7c0df7163f2mr2456342a34.2.1759937663774; Wed, 08 Oct 2025
 08:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250913163913.395-1-briansune@gmail.com>
 <20250923181254.830-1-briansune@gmail.com>
 <175989732707.1794629.12743192393543638744.b4-ty@konsulko.com>
In-Reply-To: <175989732707.1794629.12743192393543638744.b4-ty@konsulko.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 8 Oct 2025 23:34:11 +0800
X-Gm-Features: AS18NWAyEHARK_oJM-f3E3oVqAEVvMcNxzjyiRHgDK4OKj-dMUysbJWXiczJOlo
Message-ID: <CAN7C2SCedVQ5Z_5eAeC51M9zWKyqb_kkUcubzvJMSLiBy3rOhA@mail.gmail.com>
Subject: Re: [PATCH v2] cmd/dma: implement dmareset command
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, quentin.schulz@cherry.de
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:22=E5=AF=AB=E9=81=93=EF=BC=9A

> [1/1] cmd/dma: implement dmareset command
>       commit: 92dcb3ad5d98f494b2448a7345e1cb7eefa50278
> --
> Tom

May I ask do there are any documentation to show how to run this
command on boot.scr
Or possible during U-Boot setup?
