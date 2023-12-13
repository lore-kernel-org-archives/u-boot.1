Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C11DC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E4D874CC;
	Wed, 13 Dec 2023 17:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iD3OwKkB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75F70874CC; Wed, 13 Dec 2023 17:25:57 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CA686564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6cea0ea6817so594063b3a.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484753; x=1703089553; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOol0FgkpcJxPxZGqtmcaeTk3Ir652hMQBNEl6SPk+I=;
 b=iD3OwKkBCPw+FDg6Cyz1M0SFcvkjv9a4AzgJ5iyoDZzhZVQe7ycP0KhpniZ8npcs6s
 nT9fPKDNz9BobMCZ4aN9WMsqrCYSg2DEb2hRZD9eeS1/xv/lJFWDQ+NgZAh/i0diBhTg
 hySN97RtqjI43V02+fvg7I5jZLOb1eA9k0tsoaP/qGhLoY8SfL0uxHe4Y1QAginN66ZV
 M6EY+3qyf+4B7z0KRfVAsTa7zaQh+8e410XzYAmTO8LXVNB465Q17PwoMzjCN7HZV2Wu
 TIdvsfOzLFQVWFshRAjkCvIOOJdF3WeDmNB78fylRukfDxmiubo2rTRqBXF9myh61Rbc
 36Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484753; x=1703089553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOol0FgkpcJxPxZGqtmcaeTk3Ir652hMQBNEl6SPk+I=;
 b=a7V+B9gIfhRpmRhMP0J4hxQiOgBGxfUka+xyQsXR8CQBy/P7klbJbUI1vuEHF12J7J
 M/mKVhOGBCRc0Mhi9M/B0MHocwK0E2E4Jx3DPKSEXdE/uRqtsimL2HF+LAnt/AagwMi3
 E0/+1MYDsfQNTj/vMC6ECReIHlpT/YMHOMBBF0oOMti+LomF9zZZ+6pTB1ggTvoMr9P+
 K05uw6V1GwHOzF+lD/kfXrXWNWpNnGIkzPYJL6aOG4Pd8+2XW+HlFmelFj8efErsXFuN
 KHL2PPO9SYGn1P1vfp9gKLfU1PO9LK4EibxX9XawNYQdHiiLIrl/sZ9LUFhMD3/NaoPk
 +pLA==
X-Gm-Message-State: AOJu0YwhyigfKwB5VJTQ1Ir5lv5PcOcouFO0gP3zDdZeSynjWZFbQY/Y
 lxWqjxuakLoti8TTIFsO9L+8zd+R97lV8d6pZow=
X-Google-Smtp-Source: AGHT+IHjIgHaBMWkDoDH9hWtySxhsrFNkqDUU6ePOUEY07tudQcVOwwjxFhLScsknXhDkuHionGMZl1jFLHuwsW3x04=
X-Received: by 2002:a05:6a00:2d9e:b0:68e:2fd4:288a with SMTP id
 fb30-20020a056a002d9e00b0068e2fd4288amr17407014pfb.3.1702484753669; Wed, 13
 Dec 2023 08:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20231018183338.2168118-1-tharvey@gateworks.com>
In-Reply-To: <20231018183338.2168118-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:25:41 -0300
Message-ID: <CAOMZO5BpCJ2v3P4m8100oPvJhGfUJFdtjFuk7NSy5H2U=++zTw@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mm-venice-gw73xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Wed, Oct 18, 2023 at 3:33=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the TPM device found on the GW73xx revision F PCB.
>
> This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx next, thanks.
