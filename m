Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B070C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 13:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95BD2879CB;
	Mon, 22 Jan 2024 14:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5EPy+tl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B790879CB; Mon, 22 Jan 2024 14:00:28 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C4C8796E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 14:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3ae9d1109so7497215ad.0
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 05:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705928420; x=1706533220; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSRKH+2vj7tnqdFpbzIgtD3Jj+79RAYWzfbOLHBjxWk=;
 b=I5EPy+tlv5dbXUL39mn7nEKDfQ9636y2H1o+xFJ4ovtmVF2/Lh1FOiNDGoAIyEhXhl
 zYi4Dc0VQUyadOmQT7XiRaxBDEAHZKbJwWPMePfDUqK6vkvxFnKP+R/MGt+eDGlQZuv2
 oC6vG9XQNckGaxFrmboaR99ITBfdsbXNEheosE8RsITt0ct+toVoeevzEVpbIUOL9WX4
 I84Og8sNmClKnU4ZrTdG4DO2KwqwaYbnmR87DSc4H+q8d8BuibpcRgFEMXnrLwNIgHWU
 t+NfMjMdpyZM3oIOKKy/3oM6m4FcWbyy3N1DWga+djc6Ia8nO+KCNe10U6PjdgUM0N/V
 jvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928420; x=1706533220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSRKH+2vj7tnqdFpbzIgtD3Jj+79RAYWzfbOLHBjxWk=;
 b=Rrcw2EmhGZn1/DgZKG8WA6OPuyZtDQ0prRA543YEUJa5+eU33aGUbHB47jlwOLhJ4c
 N6RsbKe/mshl2QbDTeflNtu7JI5MYV4S+XpP8Lo+eebEP2kGj2oaBDZ1+ekbYlqgMfFv
 IvhM+0xZ9eXUcpbB3dy7SRLWPdKv0cbCTFG/ekfeo2oBkzV2pnBZBQOSNFRdqGSyo9Kf
 01SrV+COBoWje1gTfb7JdaAQgZQW/UjHND5gupWql0dGWG+4opvgkgc5IZavhQsbIzyC
 YSQqeESMJPQHkImUzXaRL23hGQbxaMqAU6vNmiqIGiIOorRqxghIxfCpfHN5f06zVqYv
 6kbw==
X-Gm-Message-State: AOJu0YwfKhYXhFP7UlM5M3Ey0OQq7VuksYuby7m5AuNLqd5pa7XfuhzR
 +QPn0yMvaisDX75KzC6RRpoA+gW+q+4EZMO0acYny4ZQ4j+UuUeDHpvYzhaZy7mUbl8IpTg+wgR
 FD9n+LWDe+nWlPGEEOCnvh0bsnH1OOcSe
X-Google-Smtp-Source: AGHT+IEuPU507qrkM8NIfXqrsCHy3izToSpY6Rp5HdZAanC3MTV0iRGatJzF81zwTg/qUBNB2JLR3LgvBFAHJfehE7Y=
X-Received: by 2002:a17:903:2352:b0:1d3:f36a:9d21 with SMTP id
 c18-20020a170903235200b001d3f36a9d21mr8209856plh.4.1705928420196; Mon, 22 Jan
 2024 05:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20240119160845.11412-1-marex@denx.de>
In-Reply-To: <20240119160845.11412-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Jan 2024 10:00:08 -0300
Message-ID: <CAOMZO5CDjzsfDD_yO5YBQxkOMrGhi4YuwxdPG-Z64njwN6SzGA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: imx: Configure GIC clock parent on Data Modul
 i.MX8M Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
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

On Fri, Jan 19, 2024 at 1:09=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
> during the SPL start up. On this particular system, spl_board_init()
> is used to reconfigure GIC clock parent to PLL2 500M, which is the
> configuration expected by the Linux kernel. Enable SPL_BOARD_INIT
> and fill in the GIC clock configuration code.
>
> Set GIC clock to 500 MHz for OD VDD_SOC. Kernel driver does not
> allow to change it. Should set the clock after PMIC setting done.
> Default is 400 MHz (system_pll1_800m with div =3D 2) set by ROM for
> ND VDD_SOC.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
