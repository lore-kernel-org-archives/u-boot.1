Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724E3C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD09687AD8;
	Thu, 14 Dec 2023 18:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VkJyWWME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A61387AE6; Thu, 14 Dec 2023 18:22:03 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D594B87ACC
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28ae1de660bso431848a91.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702574519; x=1703179319; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ibdy7zNuBOVtHgdyv1gcxNPYKkdB8A/aoXA8qRUGV6M=;
 b=VkJyWWME8okR6Ztjyci9isvQu0kBId2wOg+cEpqxrLo35W8sFKHwHXbMJOS+ZT0eiP
 QA5j17RMgeRIa5C1eXIj+eIteIYzD4heT7Ns6KfNTHm1PnY3KgFi2+cqBJhjIodehcs/
 /AenpkpwUCkLYy+VpwSNM9tpAdJk6iBoX0y3vBgdtApwouKAAswCoxlpTprLlb3LYHCQ
 I+33gIDK6bjrAhEa19YgZ5gpOf/E5VlUza6xhbzDlQI+IuNcDSXpgXyqvGW7OMMm5y5M
 9QIWx83YRaJBJDT7jaR9huSRk5WTV70f7pUdQ9l+wRMFpUJ5KdIvD3d3kOwRtxyvCTnO
 TvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702574519; x=1703179319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ibdy7zNuBOVtHgdyv1gcxNPYKkdB8A/aoXA8qRUGV6M=;
 b=RhKEfJDILoSb2ZVFToqNV4L/GFDy7dW/1qGNec8yuU9yO6md/jhqSgy/znLjDzhIYm
 87g3KmyFbaSBg72po47nzyxDvcwngZWlea7hHoyjX/4B75V5rHgU4NQ7C78Bo12usSaS
 AA58SILTEJ6uPFuQgN+NLclVvB9vaiv1wbYZLFVmKcm19+BK8hZAfOTDylHdnIE3Ms+j
 4aPVWTY0k9wyeAdANhNKEeqVaRxfCxWTP67zqJvMBMk+DkygPrCVq7135QLdQ4t9vJj+
 3ABkH+vhQqEJk45xg2Gm8CuweKnUAeo4U3B/F7VpvvvDlSbqnyX9mWDyGpg3BQyCBLYb
 mNYA==
X-Gm-Message-State: AOJu0YzolrxZF63u5STFCD2Rwv+xtO5IyymgtooMquCSWLU7j+b27R3c
 FrR5FPy+QPrw4ycV9n8rUI1xcGffooCW7G5qy5E=
X-Google-Smtp-Source: AGHT+IGy5BKK82vHYjikXKMC7psisJoDJg1mQws4BE86O+uPh5KZKjZzjcw7TYOG0HtoyaRotDIWeiTc6CS9qcnZpRk=
X-Received: by 2002:a17:90b:3908:b0:28b:f84:d85c with SMTP id
 ob8-20020a17090b390800b0028b0f84d85cmr1753404pjb.2.1702574519202; Thu, 14 Dec
 2023 09:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20231214162227.1199831-1-tharvey@gateworks.com>
 <20231214162227.1199831-3-tharvey@gateworks.com>
 <CAOMZO5Bx5Rb3oh2MCeh7ebuwJaLM3ZxUM7F3_2bP6TkPUrQY=A@mail.gmail.com>
 <CAJ+vNU0Pg56JKbN6=V6-0+Dbd6xnkyNF6LUCY=rR12nHD1HZ8A@mail.gmail.com>
In-Reply-To: <CAJ+vNU0Pg56JKbN6=V6-0+Dbd6xnkyNF6LUCY=rR12nHD1HZ8A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 14:21:47 -0300
Message-ID: <CAOMZO5AY0WsGXqL-Op1Pv7Lk9K0rzT8Xh4ydkhZR8uK4NwTE3w@mail.gmail.com>
Subject: Re: [PATCH 3/3] imx8mp-venice: update DRAM config for 2000MHz
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

Hi Tim,

On Thu, Dec 14, 2023 at 2:09=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Fabio,
>
> Thanks for asking. I suppose I should have put a Fixes on "[2/3]
> imx8mp-venice: fix DRAM bus configuration" as that one does resolve a
> real issue (patch 1 just removes a bogus file and patch 3 is a memory
> speed improvement).
>
> Should I re-submit or do you want to just queue all three in your next
> fixes pull?

No need to re-submit. I will queue this series as fixes soon.
