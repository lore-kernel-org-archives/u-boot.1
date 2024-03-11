Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809CFC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D4C86BDB;
	Mon, 11 Mar 2024 12:42:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIj7UsEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED1483414; Mon, 11 Mar 2024 12:42:15 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC7186BDB
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e693adc8a2so78275b3a.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710157332; x=1710762132; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JUL2TD+jYGom2QCrj/dlSUjwdkrKPKBn2Dh1kxBYEY=;
 b=MIj7UsEA+Kp668UL8NoWq5POvH6oxZ3uWudd3AED0to4MK5LEOEOuPFqYpzAF7G5ZM
 p7KTVqVs6TkNmvU6167713wyVSZ/IGPH0M+KyQVm/3lq19TKwL6MiJs5mnkoD42gNkVB
 PxCWb3iWRvnOqMvExy7FdBFjkgjVrOpZk0l3mi/WiYnrrwKHNtu0x/a121DGNQViAP5m
 RLMlturzmC+3ZFcBHNs9iYVX4lb/RQfF4Rg/cgTJj1Ocx402gxPXEsH1dqEU9RqpZ916
 0zWhnaw82NyZ4kZhYuSbfJlaCFOhrn7h7zgCh9axgOh86/K2m9Nsldus0BqBL2KxzG3y
 38bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710157332; x=1710762132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JUL2TD+jYGom2QCrj/dlSUjwdkrKPKBn2Dh1kxBYEY=;
 b=TbAq7IiY+e7EaZAvSDlDZlhZt+Vbrv/TgTJpRR8ws2BbCBt5qD6F0VeOibJOvC3UXu
 s1GgLIPca9HQ5Dr+qkzPXxArqwZ/7rMeG8NIw7eXmdG44sZph2Fd2tQQ5TBOPZHyNTvT
 evBzNnnbrkNN8jAvmvyeu+QJ2s2t+qXxruiKWSAcmHKF+/+GiUfOmtMDv+VVVjXswv36
 MulYVfJQWT6IWFhnvWtXlPw8QYhWB8VjnvBQN8CT4SX/tTui5l0jHXml/cHdXCV770OA
 2hcNFO4mTDxzDnw7ZwGyrC5lth9z8TeARalM5CjaGZSdM1V4ra1inwjZ0Mg+6ir/AjoS
 DrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnfZMiXUqA019HMTBgxsmIC7+l8qAwxXTbG/3qicDHKrTqqAYxn2PFL24Y3m4RGBDMfjpTGUh98hvd43rZwycr5iwdSg==
X-Gm-Message-State: AOJu0YyMHXOvF/U9TS6Pqdtzkvvbp7Y+31bvkj4vOsNZkjz1j7z6R8v+
 C/1zVBqrIb4H135KW9cd6y26mTCwhktpBxbptkov/Y3JPj/6jtqVNX24CJZwJNkGtuelMv99fVE
 37HvA6Dk4iBvZBtbf+/g24hwzC2I=
X-Google-Smtp-Source: AGHT+IH+2JnsZN0LneOFiGODdLjebXAxrX19av2Oj74ZcNvyr79PoW9bSHkys6eb95UICeeeqHdBl8EC+R0/pzUuNEs=
X-Received: by 2002:a05:6a20:9f04:b0:1a1:42db:9c5a with SMTP id
 mk4-20020a056a209f0400b001a142db9c5amr10155239pzb.6.1710157332045; Mon, 11
 Mar 2024 04:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240307152302.2338472-1-parth105105@gmail.com>
 <CAOMZO5DrVC9+=_EGX7ADYFk57MfLbEv1YjcdKRCPSFZ1_yHmpw@mail.gmail.com>
 <20240311113440.GA13671@francesco-nb>
In-Reply-To: <20240311113440.GA13671@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 08:42:00 -0300
Message-ID: <CAOMZO5A=TfvoKqY39k8-oYdmS_pWxW6eUcOdsys8mW3029qwng@mail.gmail.com>
Subject: Re: [PATCH v1] configs: colibri-imx7: enable watchdog
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Parth Pancholi <parth105105@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de
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

Hi Francesco,

On Mon, Mar 11, 2024 at 8:34=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> No, on colibri-imx7 the reset is already working, it uses the PMIC so
> it's not affected by the issue that was affecting most of our other
> boards.
>
> The reason for enabling the watchdog here is just an improvement to
> improve reliability, given we have it enabled on other boards with no
> drawback it seems nice and consistent to enable it.

Thanks for the clarification.

In this case, I will apply it to u-boot-imx next branch.
