Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD3C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 24 Feb 2024 22:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AF787CF8;
	Sat, 24 Feb 2024 23:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a3pIgs0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5604D87CF8; Sat, 24 Feb 2024 23:14:17 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC54C87D0A
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 23:14:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso856423a12.1
 for <u-boot@lists.denx.de>; Sat, 24 Feb 2024 14:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708812847; x=1709417647; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJYyqt1uytZpQL2KA7w7MRBFKEX3Z9IwAEbJmxzsjVk=;
 b=a3pIgs0g3XWYBCfRVXX3mQlPNopzyZ7z+bqNnSOshriLU1RElQRL5NwLb2qf9g5MxT
 2j9ur2l4pX7RICwDLsqWANP9awwErKSm6XG2ql+xufeHpeDmuYDYtJeXEfCGm5LdwguP
 MYe1ij53aeYfhhG1QJXqmMe3U5S+Mujw+fhJ6x/lZgHtYT7LLCdUBmRlXC3DUMQrKHu3
 2HLFZjsvyBNfqUgjDQL76VpCm/O5kxIwegE6XYg0OGzzSyp9VCIX42fDISGh1zY7wW8J
 ep4r6qytlfHmUktbnAwGN1xw9z5MB6mjsu0LLS4d5OEDOeG0Kcq5K9Am3shuDpN9V0rq
 wk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708812847; x=1709417647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJYyqt1uytZpQL2KA7w7MRBFKEX3Z9IwAEbJmxzsjVk=;
 b=OQTJ1E6Se4HV/o0wotlwx0bgBy5RpEvTTi8s+GY/Q+CdNY/SNxi/EvLS3tHm8aGvFy
 XzW3NLA6QMt2tyrVMYDf1E88r5w8oy1hvw/6pGaFzd1dud5Zs5WsFJAosRgFJbN+JAq7
 ngUNKmN4eonhUvk61BUoLR0CALuSqAIgT7SLrJ6dNKeyPll+UjcN0tGYgZaaZY1bbcGY
 vWY2gBvuC4X01D4kvc2lQw9V3NibkNPJZG73mYk4ruG12Omx/QmOxlHrX8DLZChQeBJ6
 NpaXm+0kTbDQk6p7UuxiiJg5TvDZFDbGmXVhLdhgg3QIUMLsuMzcLmCNK8YCqkaYwmRE
 7cTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3hVUli/OuOVCpjCkRJc2U9D4IpN8ipxd9qNvfcqoFj/23joTeebmlkVHtUkhlIH5ftkkl/HGVCMS1WIr3U5+N3kkGkQ==
X-Gm-Message-State: AOJu0Yw7Ozc2NdxNEnmA1rtfNkpgyTf8Zq7T4nFkUfdFIMeHACneEu+n
 oTz8ydW87IcRWVWbKymUiMgzYczq+KpHGIwHFB0Iubj9gUjuIt1D3DrhO/kngAh2hqDCQD1sJ5R
 xkcgb4St2hEZl3+epQy+VTX9jVzs=
X-Google-Smtp-Source: AGHT+IHn/W3UDHXHdel27spT561yc3GkEsiDeKGRH9924wlbSVE/VEoMkoGJ1rApjDFgMV1NTrYgNfSJgs5HXbciqC8=
X-Received: by 2002:a05:6a20:3cac:b0:1a0:e9ad:282d with SMTP id
 b44-20020a056a203cac00b001a0e9ad282dmr4064768pzj.2.1708812847619; Sat, 24 Feb
 2024 14:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20240221173930.868473-1-festevam@gmail.com>
In-Reply-To: <20240221173930.868473-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 19:13:56 -0300
Message-ID: <CAOMZO5B3D4ad9HsUtU-GQuJ6z46q8h2UtPFpqar40GEOSD5cFg@mail.gmail.com>
Subject: Re: [PATCH] imx53-qsb: Convert to watchdog driver model
To: sbabic@denx.de
Cc: jason.hui.liu@nxp.com, u-boot@lists.denx.de
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

On Wed, Feb 21, 2024 at 2:39=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
