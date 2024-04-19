Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB54C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 00:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F888845F;
	Fri, 19 Apr 2024 02:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P7ozzxZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20C4788319; Fri, 19 Apr 2024 02:47:40 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C408869D
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ecf1d22d78so308224b3a.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713487656; x=1714092456; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYTZ/yl6j0SASH60pHnu3EpHTFdmrhHbW9/TYhzvWxU=;
 b=P7ozzxZEWPgTFTDuNOfy7AuOZpfGOe5BcPQ3hWeHz+qwjsb/ok8ir8AC6b14NKxzNR
 HNAl2DRQm5RUNKRziSWImb4X1i/O3mrKrw8cea9iXvMOAEBXi9jfzK3W5sqlYWlIb/X/
 mHBEprQo4udgr5Hkem1RnbSEs17VSYBDWgF5kdI9e4Ecu+WX3RjuuUuicolXoEFBm0dd
 LlPB8r8rcu5rPiSCvyXK2l7VaRmG+bqTmENlBJAtoYKb7mIXhrqgR26bBXnJjEl/secl
 6+e7qHlfUW3pLBP6WL7VO4mmr9btYLeJbMyvuFUZkTEruB2ubpAKKz6sXp3/deFohPcL
 Vekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713487656; x=1714092456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYTZ/yl6j0SASH60pHnu3EpHTFdmrhHbW9/TYhzvWxU=;
 b=E2fbOIzpdsatH0jm526xdHLNkoVqyUcJZWGIz31R6n2D5TK9q0sdhamuf3EnoLL0Qs
 7libjKqUOr3/Cg+BsQ7TxONYKMjNfQNbaOvUaLHXtVXsm0NLIYwsHH3ZYWRwtpcpG2O2
 IG3KxrW5LJEWcfW5/+HtNoZU2AxaPpP1WS/OcQd2rtQ0PoxfYAlZcA8dNyQXrEZbYX9H
 QvSltd8+LHVej/n4ruGP274vcoN7jsNjqYeyoGi5J5QVMenAudvQhP6krxWMMCPmDUV7
 n/ELh2VROYIKtw57IacjtsmYFWKyR44Qo9LLeVvF5KzvjWo4iYvENi1rHj6arUiquilR
 8JOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0xR5I66msLZbXMJfAoSESSHYA6gYRPWwhutWoxhxzHbmEFyL3m2leiyyNdKRxLzEcEuBSKxpOs7Lp3hGa8LyZeioBvw==
X-Gm-Message-State: AOJu0YzdQ+mnPs4GqS6LQd5Ft8Bc4AWz5HkihMIyZXbQF/y/rPwZZCfw
 ZuXkCgrnwGl/4DIIuGBtwd+S1rwkJVSXQYDqocuIZ7jz0TrnrbQJHItBReniRBZMgCDDLHEvTH6
 etHmgFuBqU47FJk0L9FeBK+YkTgWM2Kl2
X-Google-Smtp-Source: AGHT+IGqZqmls2EqhY8EyRGHkQ0LV5LZhd+HIC6X4Z0wCTZ5CpXbY3KL589JX0+PlYCPS0jlEiRFMp0u4jPQEfOtfYQ=
X-Received: by 2002:a05:6a20:f3a6:b0:1aa:9550:a706 with SMTP id
 qr38-20020a056a20f3a600b001aa9550a706mr900358pzb.4.1713487655905; Thu, 18 Apr
 2024 17:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
 <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
 <CAOMZO5B36vz1w9ZZzJ+oZtypanTb7k6PvXNwG6KP8QBqcniGOg@mail.gmail.com>
In-Reply-To: <CAOMZO5B36vz1w9ZZzJ+oZtypanTb7k6PvXNwG6KP8QBqcniGOg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Apr 2024 21:47:23 -0300
Message-ID: <CAOMZO5COnoM3FGLkEgn1ke=+ZEhx_eGLRV0XGS7uSgWm_RvCJw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com,
 Claudius Heine <ch@denx.de>
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

On Thu, Apr 18, 2024 at 4:05=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I tested with mainline TFA 2.10 and also with NXP 2.8. The error
> happens in both cases.

I don't get the error if I pass CONFIG_FSL_CAAM_JR_NTZ_ACCESS=3Dy:

U-Boot SPL 2024.04-00793-g3434b88d2c2f-dirty (Apr 18 2024 - 21:46:06 -0300)
No pmic
SEC0:  RNG instantiated
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
Trying to boot from MMC1
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.10.3(release):lts-v2.10.3
NOTICE:  BL31: Built : 21:04:50, Apr 15 2024
