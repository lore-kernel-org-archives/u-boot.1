Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF1BE92FCB
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 18:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3DF383EDF;
	Mon, 29 Dec 2025 19:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MKWWdKe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3896D83EE3; Mon, 29 Dec 2025 19:25:07 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2058083EC8
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 19:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-37a2dced861so98597921fa.1
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767032704; x=1767637504; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uk2ApdbbcQFRg1/eusxlDg6+xGi3HjEFU8TINtQ5u4=;
 b=MKWWdKe6Fm5DliLUbyQieeOhMfSPNYSTXkzlkWGqFEzeq5LS7ZKeLFC4+i8hD0G80+
 sTMGV/R/aE1zP43P/bkWOjbSHtwrKCWrApY24SfzqTVyN4pZ74ZGVl1PZJBZjiESKba1
 yOKNatDt2Ci5V0S7GAKt5pTRa/jg/SAhr47U6LHN6T20ghRV2J8wtlIBbz11TFQ99KvV
 iWgMW0wEpBSh3bX3tQZRwJLEel0Gq/e7h7KfIjD6KK8VSbsA8Ux+5rQcEREMJCDTMJVn
 mIWtifXmtiKhvm6LOGgMmnR2bfr4gpJVuZCYyJWyc+KzdOUUT7liijnGyVkiNRz9ic9v
 TxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767032704; x=1767637504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1uk2ApdbbcQFRg1/eusxlDg6+xGi3HjEFU8TINtQ5u4=;
 b=jLo3lAoUe2o+AJC1LmopJEtSnmX7U9zvuTBKKzqLU8FPWfnHIuSgy4hMf47i1YRsIm
 uHyEqqchnPhHie9WJMtw95amCXJG69MEliTg62iK5WBBoC3Wyubmd96q2Tz9WR2Cw1Rx
 xaVbI68Ir9OwMQiPlAoY/Os5MoCzx8kB2Es51+1HC7MHZ8kBHeOg+mo6TjYlRNguZrtK
 yCNRhC55PHQuF/xbLkJ8VgyQd0UC1o9H9uRw02IStCrLXhqLHcZmcPOe4lYVkuFfQurH
 gXS1oxuxrQ4PEz5MMcyTfK1OaxqqmikSz5Tqi5CCI58XfK8iZBZsV9dwSNnxJxZblfYZ
 PkNA==
X-Gm-Message-State: AOJu0YyU7EFnDUopkOi7ZbyNayt/jMyBBOFXfD4VrXuX4aPSNVaHIhCc
 k8/GJ2RWgA87kPtG1kWmGiCPN21hPfGeuCZATorcebfUjGy8DfvcKu1kVntZWH6LVZT1Tp0rkrM
 LR6SRMTnysmI2TrOBzS2+LaQqdm7P3mN1ig==
X-Gm-Gg: AY/fxX7n8yJ6U7XG3dNoZYY+UM6bH/A16wUwypVNsBqrjrTYRQ46D6qnJQNc28v25TF
 S5hq/mws991mfRMlKHBGD6ARnDKslAMDlUH45YR4dz1JmmJnrLga7Q+toDyrzv6bHS7dtTAD2IT
 r4AakkWdyTDGBMdq913G3uzmX46GLLt+8+vwFz11HzkW4kO0DBnC/j/guVL0ydWcZTlOQg2JLvY
 fsexBiZtXdYwgjO6+SpO+G3CmlhvDXVfoJpMlIQBc3eTzlUOnfdni4+jo+HWoMIK+uQNOl4e4Tr
 BeSj2xxX4L+ve7Lh1OosR9hp
X-Google-Smtp-Source: AGHT+IFw/j95Z2uU8ZYmXancN/TAjHQJvMi/QGR+/lBLX3ZMosWyQEin/llBgUhqIbOhoH0mMPUPEsPZZ1mymHrEkTk=
X-Received: by 2002:a05:651c:211d:b0:37d:2f1c:56e2 with SMTP id
 38308e7fff4ca-381132901b2mr127651211fa.19.1767032704286; Mon, 29 Dec 2025
 10:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
In-Reply-To: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Dec 2025 15:24:53 -0300
X-Gm-Features: AQt7F2r32ocJQw9hLYeIUJsl6fSS4aM5Omki0Kn73ZkZTg2A9yR4LgX8gvo0ZMU
Message-ID: <CAOMZO5BHbb_40gNU+drGkKeZwG+yQ07OKSEkQKLkmBHT6Q_MBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Refactor i.MX IPU driver
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 David Zang <davidzangcs@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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

On Mon, Dec 29, 2025 at 7:48=E2=80=AFAM Brian Ruley
<brian.ruley@gehealthcare.com> wrote:
>
>
> This patch series is designed facilitate the porting of the i.MX IPU
> video driver to use the generic clock framework instead of relying on
> its own clk definitions, which is known to cause problems as noted in
> a prior patch series [1].
>
> This brings some much needed clean-up and gets rid of nasty globals by
> instead utilizing structs that are managed by the driver instance. This
> approach resembles the architecture used in Linux.
>
> The changes were tested on a bx50v3 device, which is powered by the
> Advantech i.MX6 Q7 module.

Applied to u-boot-imx/next, thanks.
