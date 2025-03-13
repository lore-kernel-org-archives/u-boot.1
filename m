Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122C1C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 21:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A7080FF7;
	Thu, 13 Mar 2025 22:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HD3wIYcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DB8810E8; Thu, 13 Mar 2025 22:10:21 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B0A80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 22:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-30bd11bfec6so14380711fa.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 14:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741900219; x=1742505019; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/AuwYvlAngBAZNhb9xy+AfaNjBA6wfWn3oIJxM6BJg=;
 b=HD3wIYcvWpiHlbmWb1NhFA3hioSn7U61dQW3tNRrEn6Js0u9axXfHGOjrGwxM8zi0r
 frBbKI6L7flhpHffrQQTAkBrBoOx3V3PoH3BJdc8OXmHb08Wo/U+AvgEJxtCWdh5ByED
 OyUnXRWQkXxwJjP4uTIdVLKFMJr3nmpeMRhX3Sk8hVVDaHKLMI+w/C/Fh2DNWhUm2iuw
 trBFpe8h3olEUekJpW+L/aICrNIslZiOGbjwrFYulr5XEsWL9Hd9gF36j44duLLamSbz
 IUz/yeEgtKd97ETOs8CY3MjaJNgi1YZCVdG3YgRYDuqtd9VfGovIso759PIy0uYDbaM2
 TDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741900219; x=1742505019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/AuwYvlAngBAZNhb9xy+AfaNjBA6wfWn3oIJxM6BJg=;
 b=kQmBhyS+QHn5lN8V//blHw9plPYFgFC6RbkYzzoXTEgn94zwrYBZPNo2l/BfC8QObd
 TVzbqmLol0BOYgaaysftJVOt9uTyKOj0sS2yuGj7qvtRL8blCz4QqdKnSLJAmkLyd7vu
 pwqSzkxKOrjdxTe2MnJcPZufGZVSK7OcAlUTr/ntLz36LknT/1XAG2wNI2uecJLqlxNb
 3mPRk4zRACnpEk9zJaRtKnsMr00af1hoijM208yScjC+L6ncAbd9JBZ7h9s+Fuk6Bu60
 KWfKINBbW1ydEhK+HOjamXaZ2aYCRvxnm5bWIeB1LQ5xqBZMiX6XrBczR50rIvUjwRHB
 HljA==
X-Gm-Message-State: AOJu0Yx20u7JV4mfmxHlgpj7vk6SwVklQlW73p7A+3HpAR025jcCxfc0
 foFd1hfnIhIj1PTt3PzuZFGmKuKXbNK7Rnn2QQVn4QipNWiRRfTC3iEMPhKAl4TIk8VYnVfPyFH
 f18+mvgoVtNnZ2fJVtUSlhEH6OWk=
X-Gm-Gg: ASbGnctb6Y/cwAYCffmuv7bh7wc0dr7wI7dl45ODDptcTb3pUb+BxD9EAzueOt4Rsys
 F3HBT5Z5ocyZSBlkc+SOdb/AM8wynJa51Tls25G7ZChQfKNMWd6ZDPo+Bl3vtggvOTAuH769ClF
 0+KL9ZGv2X98gKc9JgRF2TVjQpJUIK45Oz0DHuHikzdi8y4mCtxLpMQWazIA==
X-Google-Smtp-Source: AGHT+IF3S65QWHdb7oXCk7Rf44whe9sF4TbC4Tk0SgiP27zhZmjVuwkj108A9bw8ybjQc5dI3ww5kFtMaV9RoPTKw1w=
X-Received: by 2002:a19:4344:0:b0:549:4d7d:b61b with SMTP id
 2adb3069b0e04-549abae785cmr3793309e87.35.1741900218436; Thu, 13 Mar 2025
 14:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250311013430.510151-1-marex@denx.de>
 <CAOMZO5BuSS7Q2h_GOOkhcDyH4UNibe9FJHvHBmB8z+Qy9ZJP3A@mail.gmail.com>
 <da9bee03-b143-4d94-90c3-4e7a08a26e62@denx.de>
In-Reply-To: <da9bee03-b143-4d94-90c3-4e7a08a26e62@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Mar 2025 18:10:07 -0300
X-Gm-Features: AQ5f1Jqu4xEo4Jv6DrF80Y1_Y_wuE0tHwuypEko3cNZ93CIpeDx7DwC6iNDVCDQ
Message-ID: <CAOMZO5DBWfNR2wx1fLbRWX4jjsZ2Nuqt+RQaKqHqhMi=x2b6XA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Drop bogus regulator extras on DH i.MX6
 DHCOM DRC02
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@dh-electronics.com
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

On Thu, Mar 13, 2025 at 5:06=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> This is a bugfix, so should be master.

Tom, could you apply this one directly to master?
