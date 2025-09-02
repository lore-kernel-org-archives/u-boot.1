Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF17CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 12:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C283C8329F;
	Tue,  2 Sep 2025 14:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ltTMDpnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F323C83A7A; Tue,  2 Sep 2025 11:19:55 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCA3983253
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 11:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=emil.renner.berthing@canonical.com
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED7463F2AD
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756804791;
 bh=+EGTooI1tNaOrvXJ4WFfV8tnEZQjhnvZBm4T0sjacO0=;
 h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ltTMDpnL7uYEgCDBmWPhyerHDesNf5v8qs1AsYFrGN/edWcGAW4Iv75+OthIz7F0w
 Lv9RO5R9V7zF5Lti7Vc5lG8U5gtpDG1bo1LaGaBaVuuwQGEf0POAAya0/7wazqV7Df
 92cRqWmI+I0fTjTQ24ErRc/9p2uVlou/VFNOea+mR+BXKB4EcJkclUof2XSerDZX+s
 p/Ra7hlnTyp33QfkYVmgeWhxMwno6MA6/ECcqBbH/DXIBI0N8ki2HGQN8lpWjF0yHl
 Jj+4sbPuIh+mVkwIXIoOaSlVrjKzxoxNR4jKdxgC8d2v0RehrmTTqvNlLkVWLm3DvI
 lVAGjlqMk7aPA==
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-544b20274deso665738e0c.0
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 02:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756804791; x=1757409591;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+EGTooI1tNaOrvXJ4WFfV8tnEZQjhnvZBm4T0sjacO0=;
 b=FcSyIah/RFuC39Jbhh9pzx8pi55KkCjBQ/he79MSCajrLyj0LSnAFN9D9q+69azdVw
 9gJQM2Q6uAt1vwArYYNP9t2ijm/XQPJOoJ2J1MQcCio9iD3AzTa6u3FdptZYkfInT+Bk
 ViMubLTOmHdkDz0NC8mx9WJqCVrHvqUpmmTtP4LctueBUTJgPx92R+Tip/BW3HNyBBt5
 s9LWwfZW/2CSU4/U9B6Mh+GyDg/BJS96jOI1rTtDioSV0UavUJ+cA2mdlmdTLd0lwai+
 az9P0kQky+FhyCwU7lxGKYvwpHm3L8s3ktKftvMsz7Oruk9Y3xQXG92iYW4BvS2O8UQx
 erHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs3tc33Ok+TzpUpCpRuYMh5CF3XK2fxOJtUgKd5sZ4MnXYVwJg0N1nuT0BAlPQBlWFtkvXHk4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi7I6VKPoejWZDIId5Ru28frciUXUrEf8JeKtfrU74A3qnIXA9
 a/3PLfxGquoDBqXwhzExMybJP+ChNu+jzPSCltAegY8MmrsLAO9hzWKDbQnwc+aEK0n4ic2El/G
 VAqwByJEx7Kt/HDqE1s24IktoH8BWfIZ2rpgS7Tx0hbogVULe3a2q8PZsD0TOohgGmPtUcCRQlH
 ucJEkf8p9hOnCEkTXapzcxecT7OSurAhsr3IzkDtEZZn0YGQ==
X-Gm-Gg: ASbGncta0o/u8baMd4BjM4ta85C4QBoYpFOyfFnADYHL5Nd1jHECgAlhqbhfFkzUbCG
 9e47iVD5jJWeov7ZzlLg62zJWAUY0qADsuyM77pSCDn8PS3i97sCVDea/mZFLuJN7VBp5oieV7E
 iwmbpg8s/nxlwcVy7ZKy8d
X-Received: by 2002:a05:6102:6446:b0:520:a44f:3ddf with SMTP id
 ada2fe7eead31-52b19e6f244mr3177702137.10.1756804790972; 
 Tue, 02 Sep 2025 02:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEc7S1/mZpsLWQYZZyPMetNhLKZ6b0lCdUAYXjRQqCBBpJviilRpyW6M5gwtnVgUXIdvRK+yht+1MTq38SmPc=
X-Received: by 2002:a05:6102:6446:b0:520:a44f:3ddf with SMTP id
 ada2fe7eead31-52b19e6f244mr3177692137.10.1756804790635; Tue, 02 Sep 2025
 02:19:50 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Sep 2025 02:19:49 -0700
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Sep 2025 02:19:49 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
References: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
Mime-Version: 1.0
Date: Tue, 2 Sep 2025 02:19:49 -0700
X-Gm-Features: Ac12FXwoOKzkoh-U2KRIijHcWZQSM7Woah9vfSfxRD1vDdrz0Qg0XGKuth3ysp0
Message-ID: <CAJM55Z9z2ePCrLCo4qaRM=eLitnbcO1x5qhcy=8_4fpNk1H-JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virtio: blk: support block sizes exceeding 512
 bytes
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Tom Rini <trini@konsulko.com>, Cody Schuffelen <schuffelen@google.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 02 Sep 2025 14:59:00 +0200
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

Heinrich Schuchardt wrote:
> QEMU allows to specify the logical block size via parameter
> logical_block_size of a virtio-blk-device.
>
> The communication channel via virtqueues remains based on 512 byte blocks
> even if the logical_block_size is larger.
>
> Consider the logical block size in the block device driver.
>
> Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks!

Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
