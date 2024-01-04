Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3CFC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 17:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402A9879BE;
	Thu,  4 Jan 2024 18:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eCjAb9OU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C98F86758; Thu,  4 Jan 2024 18:50:07 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2D4879AC
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 18:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9bd8adb9aso33595b3a.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 09:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704390601; x=1704995401; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSOqzdAgxF4FJobI7wSyY4QZXpiJ8HtAa5fpofhs1Ac=;
 b=eCjAb9OUycHmSXObNnSAn3l18U87jIJKInF4Hc/v5qyID7Ifdli/ACGnjFoGRrclxv
 2x7F1cEVaO9QArsUMJ4d94HG2UphqWIpwAZAPD2q8aZUaJHyF27X30vAVDIBs1ajAhKL
 DeIKsqpYr6mJDbzwt/s4liGOW6BRmJDkhejhIUDxT6nkrXasmC4rRLsVKHORqmk7oewR
 Dn8v7DgqSCNe+5rTtth0sr3fWDdNWZukXt+5vcy/cJvJy/lCXQHx0GrZOYwswNRk0s2i
 7zybKh+DH4aTdLaMeoPStfMAZ4gmRqR3T/K+4b8Gr9n6rZWndNw3dYEvPceA6owUI4Kj
 moRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704390601; x=1704995401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSOqzdAgxF4FJobI7wSyY4QZXpiJ8HtAa5fpofhs1Ac=;
 b=GmvDiCvltV03xvuvMh4B4mChWT/kVbeuibXU45ZrilvKtlFu+FFShzRij6aN71s8jL
 7HTTk9qtjfMOBo99XmiiZ05IQ5Fz2F0N59gDsn2/Vxx3i48sh2yBMtQK4ntHVC2kL8LC
 cU872ZaRNdeyV+wyk7mASumbQ8PrxM+iUenuSMT07i9MMenKaMak1Ds3+ySCL+yuE+W0
 u1DFrPjlRLxvjaPZD0ujmUiHU8R+DMmnj9bgzDEJ6EkjW6tRhg/1FV74W5m0kj1MQynd
 OrbGjPNQPj5kJFtVsU/Xv9Ngz5unBgB1+67mrb2Gwtv4fbPHN+QexxItjOHhZbZEmuvd
 Jiiw==
X-Gm-Message-State: AOJu0YzB6JGpmwd/3imE7vMxK/Q72GKsK5VrzCM/6gx6O6+kvrPpN5gj
 yQJI3CyBtgQBWxDVs7IzN/QTWRAnxrJlztuIoJg=
X-Google-Smtp-Source: AGHT+IEvmio/JWT4wQt7N8l5j9203mDd/xM3vWpt9vxnIH0WeJEdVJgcZxbbLJrSdrYXBotQKK69EU4nWrbgU1r77es=
X-Received: by 2002:a05:6a00:4b0b:b0:6da:83a2:1d5e with SMTP id
 kq11-20020a056a004b0b00b006da83a21d5emr1843227pfb.2.1704390600634; Thu, 04
 Jan 2024 09:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20240104155357.21865-1-othacehe@gnu.org>
In-Reply-To: <20240104155357.21865-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jan 2024 14:49:48 -0300
Message-ID: <CAOMZO5Cw3WE5j02GmFpGB7z4-LBA7Tne7X2TG=riTxpYvJZRuA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add imx93-var-som support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, u-boot@lists.denx.de
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

On Thu, Jan 4, 2024 at 12:54=E2=80=AFPM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:
>
> From: Mathieu Othacehe <m.othacehe@gmail.com>
>
> Hello,
>
> This v5 fixes imx93_evk compilation by enabling binman support for this b=
oard.

Still fails:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/764792

Please run a CI job for your series at https://github.com/u-boot/u-boot/pul=
ls

After it passes, then please submit a v6.
