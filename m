Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA25C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 13:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6949180F10;
	Sun, 26 Jan 2025 14:18:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVCgiDjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 096DF80F7C; Sun, 26 Jan 2025 14:18:52 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086AE80EEF
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 14:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3061513d353so38831991fa.2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 05:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737897529; x=1738502329; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IugiXhiMo5+DOeLbSSQlpI6ORDxnsrd4tt68VMQVGiQ=;
 b=jVCgiDjKK+RWw7hOsGou+c6/1iddAXjHW8veVF8Rx6zew+OdOyp/mxtni4YXLmKDUo
 M7afmeheLbzFkH74pEPoTXAc4kIustoJrIVrD2B7ZsO2opm8YkX/15mfqwQPYDQWYs5r
 WIeBJnOoNyzaG03Tr93iAPSTgiGCRf3qW73D9TeroT2MN0L3W0+OaJrKE/C2ad+Habjm
 QJm4TNh+a2i4cYxWHxsb3ywrSUgl6MioVbFA9fdoSvbXfRG8fZEmPmAWbfRxjasiUzwj
 y5MaqxPprwUvEItVzmB2JPjKvitqWQMbgiVjHJjeNMwFAIbm8RO9lwaLj0mjKUqypij3
 e4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897529; x=1738502329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IugiXhiMo5+DOeLbSSQlpI6ORDxnsrd4tt68VMQVGiQ=;
 b=v5PSj5sI2vwx4lf7rInxj+56ilxs4Lv0Fg6ByAHnchT7FcAOrY6FkBtgOxacJ3Pd6b
 0QfeZv102q/2yH3wUKu430T7bDc71E0rCMCUes59hRQK7wMHw6Nu23LxEDVDGcXmGPir
 JQTYv8XUoJxLWpQzmQTmquyizJXrFrvwrjQHcAK/DPWxFmFjjT1wXp9zLBGyUSKRuT6q
 RAkVD19YaXGcUFErL+R/lu7IjhkZqGKEFslJ9hlrAcsgCkbmzlNNCyQW1j2qXv9oKcWq
 w8ge8KXSqaUPBiJmi5NOfV5bTJc6hPs8qv8VB+eOuNetg6o+EmBOE4GMQ5UhzMrZC+4K
 1oPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIGpHt7AiaTvM2TtYnB1zXluzKxafhp0xfPLuItMlBTD4ZwzjgciG1zLikf7P1TsWWZRYECyE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6Gr4FYcz/VYUBJCYnq/tVDB33Jc8FEQYfRI3xup078jj8qDvQ
 lpWJMU9C2yQnMIeJF8g2J4ErqAzM8uYAw096oKNvWdI62zSRFlHg5d5UvQpFSK6uwlQEJX6B/K0
 BxASFynl1TpZOPpovG1R0xS7w6rQ=
X-Gm-Gg: ASbGnctHyEyaFLe4TgXzZ+Pt5FuEpVHUjys4uZnDztAmLqyhn9Aq0VKQ2ZozjFl1yh3
 i8fMqFvz+tyWK0XDAWio8YOwD8tZ+LrleRQln46vVgBtwQusXYQosvtiHWmjxVsglL8q7cfXNiZ
 nrHvGPo5iZNU0p4hVBww==
X-Google-Smtp-Source: AGHT+IE3Ph5ZL4n9YAiR1l4ZJJ91fq7wwzTfDVt++zKVPSK1UXYfcSKz2Al4la9wwJozPwOKevSXOsGYMbj85dcJ/KQ=
X-Received: by 2002:a2e:be9d:0:b0:300:3a15:8f2a with SMTP id
 38308e7fff4ca-3072ca60c6amr138596101fa.2.1737897528925; Sun, 26 Jan 2025
 05:18:48 -0800 (PST)
MIME-Version: 1.0
References: <20250124145520.185414-1-marex@denx.de>
 <CAOMZO5DTbaq+ArihsEE68YbD8S-v9ny2+Nc8XbXZ-JWRRTUFTw@mail.gmail.com>
 <efaf3c1b-c3c7-44e2-9cee-c854cb67e74a@denx.de>
In-Reply-To: <efaf3c1b-c3c7-44e2-9cee-c854cb67e74a@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 26 Jan 2025 10:18:37 -0300
X-Gm-Features: AWEUYZnbFoNEfntu-R9YftnoFh6v3BSDkVerU2INLMSVMte_GaWxlDig9nxi1Dk
Message-ID: <CAOMZO5BqhQ0jN6MO1RooKxSDBbfuq5z7heV_N8oMB0R0MyU41A@mail.gmail.com>
Subject: Re: [PATCH 01/10] pinctrl: imx: Push imx_pinctrl_ops into drivers and
 staticize
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Marek,

On Sat, Jan 25, 2025 at 1:36=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> Does it always fail , i.e. did you try to rerun the pipeline ?

I had to retry a few times and then it eventually succeeded.

I will send a PR soon.

Thanks
