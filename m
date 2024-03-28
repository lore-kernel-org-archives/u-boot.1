Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CC8C47DD9
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 00:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEDE98804C;
	Thu, 28 Mar 2024 01:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UTX08Iza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF308804C; Thu, 28 Mar 2024 01:44:58 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0BBB8800C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 01:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd3c6c8dbbso689345ad.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711586694; x=1712191494; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbKWBqehJX4GL0a4EzlbeFRLPJ6jvL+ej0CnyYoz2LY=;
 b=UTX08Iza9S66u3TCna5VSu8k2esMdU25pBbf37xoZCf5Wcf35IU4Lp/LbqrQm8hi//
 hE8io91z1PWUkmY0cPJPzup5K7cxOB36d+Z70DaG5qlStLH2Ha+qCnXO1Og/T2WikilF
 0u7QtbWueJ1csM8VKbXSV3qTAKxgWLwms2/QQ6seAcweFM5RW3EN6mz6sN9TtRgLiR9G
 mYgguutDOugY/8bkUmy7B1phiEynUuYKmRnuJloZ5lvZ7XgOLrMj63C+OC1KVlRH9vYO
 DEeVklMJYxzvn+0tfRw4UyiOpRLgcJ2a3NOzdvV42G20AfpZ1QXMMvbgYLIcqw7TbBFh
 okxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711586694; x=1712191494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbKWBqehJX4GL0a4EzlbeFRLPJ6jvL+ej0CnyYoz2LY=;
 b=Uea+KX0eCG5I18UyIOUIVdS3XzTELUg7R26KA/ea3VETusVdL1fRMma64bVb0PLF6J
 Qa/RLag/xlO6T+kzLiGZrLe/K8S20i3Rp5dohfueYCPCZP5Tges6TDypKl8patChbaUp
 gIFPZyQAIpbvVJjyo0jF+5+ooPZpJmPeNdFk21FQ9XMDwA9Aps3nT8dbSLrt7D12P28l
 Z4x9hKReJwZX3DdwS4p5ughjJVUoAhzSTSm9Bo9LA2r9r+kNfRE2Fy1ESdX0/YKMWX87
 xdt0YapODEisAyDe3A1Mz6Z1iLKG5gw3B+PGFD/corrk7WyIs6667vtH0f6BsIHw1AMv
 oCtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsqDPlXD6pNIe7U5uLM0wTeHH2uApTB5A5OYDCaDPcw77Db1XmjzA/FQv8GdBfVazFKfU0wN/faBUJ2CrD58f1VIDa9Q==
X-Gm-Message-State: AOJu0Ywuqd849W7XTK3HOSlaxh/1O+o7jjcRAxmgvj0bBqWhMPLI3KM7
 fsdaZN43VZhzu+dlR3nPBWxR/qe5psvyPIDARxJZe6ORAc2wiTotrYTAcrZlNS5jfZ63Lbnffg8
 ebIV5Xss/djcjDtVgBQKsY34YYrk=
X-Google-Smtp-Source: AGHT+IFt+vzBPVy0laJYpNgt5S1mtZm7TiDDndUibg2ih2+1BCrWzGcqpC8ym0lXmJEtZc4u5R/m4IQ8j5gs6kveUtY=
X-Received: by 2002:a17:90a:f18c:b0:29b:f9be:6b51 with SMTP id
 bv12-20020a17090af18c00b0029bf9be6b51mr1156668pjb.4.1711586694346; Wed, 27
 Mar 2024 17:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
 <20240328-imx93-of-v3-6-4e7f341ed7ea@nxp.com>
 <CAOMZO5CXyBTm7JnfYB60hx3oipY76RSY0U-GPaoVJO=Agwr4Vw@mail.gmail.com>
 <DU0PR04MB94172BAF7D3AEB561F2E7842883B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94172BAF7D3AEB561F2E7842883B2@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 21:44:42 -0300
Message-ID: <CAOMZO5B-M0KLVGfdGT9q2Tj_4uYn1bv8wXGickvzwzhAc0nLeg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] imx: imx93-11x11-evk: convert to OF_UPSTREAM
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Peng,

On Wed, Mar 27, 2024 at 9:40=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> I could help convert all imx93 boards, but I could only test nxp
> imx93 boards, not able to test others.

Just copy the board maintainers in your patch and they could help test
the conversion to OF_UPSTREAM.

Thanks!
