Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F8DC27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 21:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AB6888953;
	Thu, 13 Jun 2024 23:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PhdSPU5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBE888918; Thu, 13 Jun 2024 23:48:23 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AABB8894E
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 23:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b06bedc5d1so9102006d6.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 14:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718315300; x=1718920100; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmEoJy7mLL/w1IfC+zpmUSHs0MQN63NFz8Pw7IdYFZo=;
 b=PhdSPU5p6mdJdYk3TBzXVn94CjnF/94gW3AjPLJaNPITW/uzYpaERZjEbpUdUb0dC9
 QrCqOgwEPlxyD07XqHaNhcdM7fbkDnMYMLR3Sk7QsCw4dtqdB1zGU2tpn65KGcyiQNzD
 B18ZPHCWhBBQcrzT3UTAFsZCdBljeevGv1Wd+ltyNm/Dzlv9sWlTxwElH4SxKcjVlZga
 V3Yok1stnCH1ysCidLBULb23Fvmp6KPmCeJTLy+pz/SGi6PRmffMA1UHeooiEn21apFe
 SxtUwLo1eSSIhgx6Qltdf/SqH8YFYr8w5a2Mrb4MpQj2/0hoscDWZLPnZLegihhQWB/9
 NbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718315300; x=1718920100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmEoJy7mLL/w1IfC+zpmUSHs0MQN63NFz8Pw7IdYFZo=;
 b=Oxc5GW7taJflA53xsHhpg1Egil0uMF4Xg0bTmywHWqWqRr5MIgm1sEOScwU+j2CdD+
 ia1Ur9v2gNxRrEFtEMdoqwec/sAkYxnR8mgTd+D5EDavoJtK59ZPze3+gnsazaCQAJFg
 yhX5+ybUDZ1ZC6AyVnC3h5p3il2AXeq0ww5o/FwrOuzY2cGoB0bzr+DerO/nyoCYt2VK
 pVTolkYgoHzmVAYhVGYX4QJHVcLZyAzCZfiVJ7ANpB+La8DGN20i7DMpkxKcNHv6B1ym
 U74hQKCzeFvP0MeP6Fo/NufUZqXgIDxmvHQJHvfQUnIiQFMcTEvV+zHODDdToUvO6GST
 HU0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZGGnF/YgtyytNWBv5U2G1eqb4igKg53ckX0Bqpg9OepspQ+DahEUTnth/iIVLq/6Ib/83Yp1QCR/rJgJCCjv1mXqZ7w==
X-Gm-Message-State: AOJu0Yx+svdti3yABaen4OLOhle1BEacCv0PTWnJ+MYzRPUYywrQwf5c
 cZJ5ndo7k3Fus7Sl8VCSpmR/kIMGpRx3Hnn3GG3U49TmI5s7qcQklp7L0aSgEkXwgF/zDgraF0O
 7zsJT+fq5Khvp3s3LYuSmgRAd1UU=
X-Google-Smtp-Source: AGHT+IF1WmTRs3BgG6Gy6pulsQk9ZIVm3fmibDLASHbbjLG6U1UDo+3ztk0lAAY9RC4TaafcR/F+wIDFa9n9iTn7RsU=
X-Received: by 2002:a0c:dc88:0:b0:6b0:9479:cdc9 with SMTP id
 6a1803df08f44-6b2afd61676mr8469536d6.49.1718315299998; Thu, 13 Jun 2024
 14:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240613080604.3828083-1-d-gole@ti.com>
In-Reply-To: <20240613080604.3828083-1-d-gole@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Thu, 13 Jun 2024 16:47:53 -0500
Message-ID: <CAOCHtYjAFE0sbyYRXnbsv9EohNfH99vsuVYiZbi2Ami_xdoxWw@mail.gmail.com>
Subject: Re: [PATCH] board: beagleplay: Fix the bootpart to pick from root
 partition
To: Dhruva Gole <d-gole@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Vibhore Vardhan <vibhore@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Nishant Menon <nm@ti.com>, c-shilwant@ti.com, 
 m-chawdhry@ti.com, vigneshr@ti.com, Judith Mendez <jm@ti.com>
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

On Thu, Jun 13, 2024 at 3:06=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> The Kernel Image and DTB files are supposed to be picked from the rootfs
> of the SD Card, this fails in legacy boot flow because bootpart is set
> to 1:1. Fix it.

and where is that rule defined?

Production boards ship with Kernel Image and DTB's in the 1st fat partition=
..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
