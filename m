Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39328C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 13:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A904875F8;
	Thu, 30 Nov 2023 14:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M7e/RbJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0108875FE; Thu, 30 Nov 2023 14:18:44 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BF2875C3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 14:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2858eda2919so235650a91.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 05:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701350320; x=1701955120; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLeR485m4dpvlmsbhOYKZygBuk7y86AYRH8p9eLqC3c=;
 b=M7e/RbJXVWUx2IUgyTPk/RmRMgATQ1JaOQH5hBwwcD5aS5sj1uYjyJ/5u1eL8KsTnd
 vyRjcTXSzZtlwECwDQA/SXoaCoUaV8VyF4NgP1uo3NTfXHBAEflBPMJfvgiwue6LDUFA
 xBrgZdclKOWemB0CIa9wBaUdN9Ar8bq61XQ07XP/OZOQ8xKmwdbZyjaMijOTfKtq7I5n
 Q37dbjxFH2AzS3rmzr5LrP+fk7McMlZIOelRjiCAi3mSk2C3Le8H+rhjiHfcmz7lH4mM
 MX6PEvX3Yb/Vwu6zArFW8HMUm4Bi/EIkli1AsF7gFoCHBr8rD1batWUvG2YvgGJD7Gpa
 mlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701350320; x=1701955120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLeR485m4dpvlmsbhOYKZygBuk7y86AYRH8p9eLqC3c=;
 b=DQG4Bm453a67YSSBdvSAzlNKPwGn4u5IDzdUA3An9CHerV7g++q2EHnlgmXgFuEd1Q
 I1tKGPesxZmA3V3AG/ToPtKo8zwKUxDs+TU7+kzJ+Xw6F3R+xNYkVtbQTRCc4CnNBMDz
 nczKGsUU009qO2IL20LBdmp3mbjfY9yBb9G2LlkjaAp065vU0xRrcYHMHWHFolCNNzwq
 vvNqIe+KG3KF/0XvXqqAWqmHiOiFDUnt9/OITAKGZkWEDGz1mYkjYbZNPp4ydRgIG88c
 3d965A/nSvfAWhWkzi39oMF52KgWgJOxRVAmvheF7H+6zpjYEdc14wTFO7PhXKo2yqeG
 WO0g==
X-Gm-Message-State: AOJu0YziCC9T4GY+QU4UdU6F+DAmwVWZdzrxDGhFLzHgu2s42zdLX0UN
 Lqs4PvyRaVZV9qwjvbyw5t2XcTvn91KOQRSvwZo=
X-Google-Smtp-Source: AGHT+IFLRh1UPySsrvD73t+I+9oRlWu3r8zV+9xpqB6GPGD24CAFmaeT32HIUWBXB0bdn2/hYeOHkkHTm7sXY7cxXfM=
X-Received: by 2002:a17:90b:1bc7:b0:285:b86b:6391 with SMTP id
 oa7-20020a17090b1bc700b00285b86b6391mr15885489pjb.4.1701350320581; Thu, 30
 Nov 2023 05:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
 <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
 <CAJ+vNU3Nun6WWGq-1+ZNUwsEkQXuE4NE+AUiU_ttr+Y+AbXDhA@mail.gmail.com>
 <CAOMZO5ACEd9q4QPmdeSsKWdsN5Gu9smH-VAowpSRhBaxA3pT-g@mail.gmail.com>
 <CAD8XO3Z4JLJfG7ceZS6_fOFY0fyQ_7GMQLdLioVp7xxcvDSgUQ@mail.gmail.com>
 <CAOMZO5Bbg-3HyOtjofw0+gR6htx02_cDV3qbdPCb0aZQvW6pqA@mail.gmail.com>
 <CAD8XO3ZCOELS+7g3A2dVz8n-bw-NgENPKaPZCLM53joGYc5=sg@mail.gmail.com>
In-Reply-To: <CAD8XO3ZCOELS+7g3A2dVz8n-bw-NgENPKaPZCLM53joGYc5=sg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Nov 2023 10:18:30 -0300
Message-ID: <CAOMZO5AGQpQ6vB5rPSsXfy38K2u7EU5c8ApvzRKynn2b3xDbTA@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com, goldsimon@gmx.de
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

On Thu, Nov 30, 2023 at 10:14=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linaro.=
org> wrote:

> I will test that. smsc95xx_eth included in some CI tests and it worked. S=
o some differences on real hardware...
> Log says that a ping packet was sent, but no packet on rx.
> Might be the start function of  smsc95xx_eth called wrongly....

Please note that on the board I tested there is no smsc95xx involved.

It is an i.MX8MN board with the FEC Ethernet controller and an 88E6320 swit=
ch.
