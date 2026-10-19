Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DF1CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A72B04064A;
	Mon, 19 Oct 2026 08:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8AklGzy0KjLv; Mon, 19 Oct 2026 08:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E93F84064E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399862;
	b=KYEbn4XZUulak8jgY4wK+I97V63LJ0QngaEzLsl4odEr8inWXiv3RtmYiP8wTTXz1iO6
	 iTz1Kib56iWk1dvejJFXz4xyw/xNjQoOMMDYpO8xQtgIt9vyzkHTJSwuH+2x7PiYFlmij
	 upvjDYuotPZWjd3G7Ss9K0b/zQ0lnrcQp4DaEit0GkfPjmPc+Hhq9eAGsnMLrcwWOwJrC
	 8Mc3a51F3/GBHDLCCSsUjeF97irr6u/E2Td7jaeYiMRtHEc1ixW7O+Y+UOFMC3Hx3szXP
	 I7ovy1KT61atdwch5PmNiNgT6v6WyOQyWYOXGEYKv9bxMTFMFkcCFRRaAe1XWZNkugQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792399862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2t3NDIepVK4YIX+h2RUTvgUlmX5U/GVcWk3jCRDrGGM=;
	b=f9pigU9ejJbr7ZQpWMeWk1PLZS5UqH0MytDxinjvLdAgQcjnIzeFcPp/LmgVVCYp0pPF
	 CfDF0wr46yr3nMgCtGT1FRMYurFtkufsm90fTySbP2/4W/0wMxbFyZEK+rEjhI/UUCdRp
	 c33xY+xY85vOrUjE9ypY1Vb2Sg3jMSBQrmXYltTLS/qTZX4LK09kFFgZOOMM3iqHYL7G4
	 kNWQONCuoNkVel5dOxO21dCY2OFH1ku+nDfagGDt0bdQrK11xpq1BAjB9x2T58FDOjN2Q
	 Iajn7DTqPp1lIJLktINgl8hKHckmGRet46IcMFD5QwnKuFbsOSNxMb08ZeyYd0SQWFA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=sYn7gg1a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792399862;
	bh=2t3NDIepVK4YIX+h2RUTvgUlmX5U/GVcWk3jCRDrGGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AsW7xYaplZ7olyZgyh/1apbtjUKWQP089COpCRE8ehdvbFt6K0QTzeGEoCMI73PM0
	 P1LyMzk36/Bf0VVzywbHkaK0KP6jsKanl9yrCqvyipfciopIo+amuZ9b/6K9+KvScn
	 6073z8NWeu8BSHa5Z8kJoMn/Yk+Q9VEXMojSbTnf9cTXzcFnhv6glHrATpFEpfW9SX
	 +HCc+6YRHauQwt54yBeX+4rqL1QdOrJj/QAii5ET1vthwj6ywXhPKcRdNWcLTDVaRZ
	 ZZaQF4Q3JkaW5/8dsmgxKmPP6TFvdfoezAgpWDlBNxsjaNb1h0xG280jAMlGYBK91c
	 C3eIlJvh+ZO3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E93F84064E;
	Mon, 19 Oct 2026 08:51:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 756052A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B0034064E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R_UF_l_XhaEG for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:50:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 485894064A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792399859;
 b=S93tQyDZKp0Ne1epTsUPaocINXHF4qdDr2XBRdZErS7FyzpDllC3nAGeaDBqVjo40HW+
 PHfBXHX4hXNGzh27wM62R6ZkcuCnStptRzF7XGjGEZ47Otqy1VsfTIdfUYY1FslHSlqNM
 Q3ivR/qLuR41SdkS0CVxMZCWJuuwfmwkAJnubQ1dkaO661FuWnTQKlUwoPJd/bCZvpE88
 /bWk6/DmR6suXh75dlDA3EL7ABZdzsB4IcMtWaFUzSmrioHF3oxogIPba3s7zxRDRb98n
 cElyfeAzzZSQrCk6sqcbNeDcsw7wvGu9NgABinxTVCD9oeyJNSvlVVAp6BcvJFCajwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792399859;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=2t3NDIepVK4YIX+h2RUTvgUlmX5U/GVcWk3jCRDrGGM=;
 b=VYX/ytxHfqrYT8ZrHaHEx8nWkPRixmzGOJwkzLeRuqT01dHIqu9KsJHzL5eUXdDlEr3A
 dBYatKgIIN1gsqJhc0sfwDN++6zmQvtQukhcE8cAAelXwOSlafErj3VLUz8BdWOr5bdNf
 FO+ZWY/Uq4XrATEV2tw+WDP3rdB5Y93zeyE4hD2cVKTABeXdq2Gcn4Kusm7XWJ6NppUK7
 2guhh1RhyJWaeQsfi6KRviHnsKLlIaKtHD3lddts/xpnWCL31RKl4ctboDPjgq/4mvmNW
 NsrzsjQ+s7nG2jmsmmJoccsXH+KDOpSjQYgBwyGH3MWHlGsPyH6AfCXTqVnsUK097lQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=sYn7gg1a; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=sYn7gg1a
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 485894064A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:50:58 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3ab07d956f2so8311331fa.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792399856; cv=none;
 d=google.com; s=arc-20260327;
 b=aoGqXTD7kGqOIQZb4yBTrQZQASR1VGpRXEhsZVs2MVVnpIBI9SpxqYpHqUF0ki/EgD
 5keHYBx8gjhr915XkUyexroQqI+w7m4lcH1/GaByEPmJIbrR05AqoJsRKNv8zJQRH2FX
 MhGxSMjXJzBbNGWolBOXPAIydxUEWCjZVnJYkh5IT6Om5LFNhg6b7UIoBp4Wt36E0O8+
 SSuSbddhUUFsil2FWb+db+oJhsbFbEziijA0hgeUmaFKMhDJQu6Rc893Ebw+alGLIuny
 L8G1ggYqg0G4dpJwWwZ6Q8DRsy2l56e+RTymUuumJMCP+u6UwkmRoB2t8Qg9S99Vd1ie
 ka5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2t3NDIepVK4YIX+h2RUTvgUlmX5U/GVcWk3jCRDrGGM=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=bYvryRxymJdMp2eF6VICaA1lq2ry7sPq6dTr/jtOy7MXmg3KMNlCYXvGNAu+Wy9u1d
 CeEmx3JXUP75J1c6YXYXa6RkgNG2lX4yHmp5vBgZiFvVf3JoV7wVHystcXDGR70oHan9
 YKTLTDmimHM2UJoM829BTZjd5r8vfr5uq9OeXBJlkNWYTsdWQrH7Hb4HFrpi/uu5BQ5q
 TMn3wDsi9O20q0sqZLFJ52hMWqJTFhO8jdAeGliMTw6eX8Y6EIoZIZ/YD0Evka8T9eG/
 NAvX+mcExsYaaFSDqfYGDlBd+7YsUls3MqsrOCLwOU64c18oWggEGY/xcI3sctwI1Zhj
 guMA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792399856; x=1793004656;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2t3NDIepVK4YIX+h2RUTvgUlmX5U/GVcWk3jCRDrGGM=;
 b=sYn7gg1aUYIcN2ZJmvxJVTwKpubIVbAA27XVowJEeXYT9Z6IZLsV34gLyVRyxJ4I/f
 /f6IP2X01kQqblqHneDt7h0+N+/pYu0QzD4XJym5sVBYGMWf6N8F7E8XuHuV5K40NC35
 Nyc6bv/yAlPZ+vj3WdCD3cbwM1pWNp7B1aBHGoPEFJe8VaV5Vvlmcx4+86ssYNPRoB9P
 bf5kc6GrPWzxoftQQdtAGoe1sKjJ2VrZayKirxAECpjDkJ32jQkESi2IknZt03PCXdlD
 mBkFCGG9fLir+J+VwAlB5p8En4xC6GC0b4xU3HXorh1YoFUePYotTg8RTw6GG3vIDICk
 QmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792399856; x=1793004656;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2t3NDIepVK4YIX+h2RUTvgUlmX5U/GVcWk3jCRDrGGM=;
 b=MnXWv4s8wHbfDHGw6Nyv1VFz4YP18QUBdax8pOsPHoya/q2rrVe9UMuD8zRyewHQ1F
 HsB7Uwp9WESMsxwN4txYX3iYXpKWZplN4j0y/ia4JFt6Epn3MDE4r+beulW92E1z92di
 6Ulu1Ck8BipVpCZ2uh4/ojNp2MhhXW6pWE82cGBU5f6Jh2mbJ4zVbBZfb79/B0BbmLPj
 N3bHMfFiUcAsZB8jErTEVBXCX0MejVV9DpkvuLP8aXWSJ2k3IIf/TIP3qj1s7s/Wkv+V
 UXkY+4v6vPFjOupZ8VzKrCsqkIuwPo7fVVkO2nntHFJHbwpZY8CeIlht+hs7MJBdPiQM
 0a/A==
X-Gm-Message-State: AFq9FYJWyXWrJK2TcuPKEoov3Ko50R0EEDkP0Hqay86lEJ4wqM1OgfIU
 XwpofoeZiIBGWLIlR3g0/B84jlORUriAleUln4/3Ik1HAR3DN0ldVu5YrGm07TZRCSq2cyQGqgh
 i9lvTD0R8FKF4u7cPwKMCwck3LvBKZDbYkWSuU+bzug==
X-Gm-Gg: AYBFou2sJn0dXJPCBUVhoKVUy/6YDwFoGWbKc4dMHOeqZSDE5g/JjpaYSErp/5CLIcg
 bRvr0mKOZ8ZiKPgHRMy9sm1475Br7vUjuo0aJqolvr8SJNMm/Et75ZWdAAX1KQAWhpIUAP5zNts
 XiqF4WbYcXJYoN+mwV4SAtNt72sDu7P79b8XsEs+T/mS3o74obbwyEoQY9hzI2Ot44anlGOlYP9
 wUXn5NiCI1PjO3xFmNPgeUZpy7xUwYIiR93sZxIZFXLHCFphbC6Xa6Q0UBhZnHkeSWIrS00kuBM
 UMr2Icbpl7PyGZUC87lh0IjvtN/nnjEE1wv+kMheFMKhCDOOds3Sv6eTFuoMn7JaqejPxOhFA+s
 VIh57b+ZP0HCbSiRsB1nEhMCe6R+TqTxT6XYBUpTszkmgtY90BnzOWPHedMgUbmqxMd3BqcN5mj
 Oxpsiqwza+qICi
X-Received: by 2002:a2e:b8d5:0:b0:3a9:d9db:61b0 with SMTP id
 38308e7fff4ca-3ab292f8d6cmr16960111fa.24.1792399856370; Mon, 19 Oct 2026
 01:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <a249fa2eb6aa4ce01b9e09b54964a0efe09d8264.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <a249fa2eb6aa4ce01b9e09b54964a0efe09d8264.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 16:50:43 +0800
X-Gm-Features: AclHuK_h_-D1J1ItuMcHfqzoV2b4If9pUdpwZ7GtQ51sLemIx1osUFtU1C1UoGc
Message-ID: <CAH22mJyNZhJq367cLYknhknGmkbXOxn31npUUeQscjniSyXAXw@mail.gmail.com>
Subject: Re: [PATCH 5/9] pci: spacemit: report link up from the link status
 register
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> The driver decides the link is up when the LTSSM state in the
> DesignWare PORT_DEBUG0 register reads L0. L0 is a physical layer state;
> the data link layer may not be up yet, and config requests sent before
> it is are lost.
>
> Linux's pcie-spacemit-k1 driver reads the link status register in the
> "link" window instead, and needs both SMLH_LINK_UP (physical layer) and
> RDLH_LINK_UP (data link layer); FreeBSD's spacemit_pcie driver does the
> same. The window is already mapped (as phy_ahb) and the bits already
> defined, but nothing read them. Use them, and drop the now unused
> PORT_DEBUG0 definitions.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 9 ++++++---
>  drivers/pci/pcie_dw_spacemit.h | 5 -----
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 5e0871986b..3394ddbd18 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -81,10 +81,13 @@ static int is_link_up(struct pcie_dw_spacemit *pci)
>  {
>         u32 val;
>
> -       val =3D readl(pci->dw.dbi_base + PCIE_PORT_DEBUG0);
> -       val &=3D PORT_LOGIC_LTSSM_STATE_MASK;
> +       /*
> +        * As in Linux, the link is up once both the physical layer (SMLH=
)
> +        * and the data link layer (RDLH) report it.
> +        */
> +       val =3D spacemit_pcie_phy_ahb_readl(pci, K1X_PHY_AHB_LINK_STS);
>
> -       return (val =3D=3D PORT_LOGIC_LTSSM_STATE_L0);
> +       return (val & SMLH_LINK_UP) && (val & RDLH_LINK_UP);
>  }
>
>  static int wait_link_up(struct pcie_dw_spacemit *pci)
> diff --git a/drivers/pci/pcie_dw_spacemit.h b/drivers/pci/pcie_dw_spacemi=
t.h
> index 2c17f113b7..6f198f7d58 100644
> --- a/drivers/pci/pcie_dw_spacemit.h
> +++ b/drivers/pci/pcie_dw_spacemit.h
> @@ -22,11 +22,6 @@
>  #define PCIE_MISC_CONTROL_1_OFF        0x8bc
>  #define PCIE_DBI_RO_WR_EN              BIT(0)
>
> -#define PLR_OFFSET                     0x700
> -#define PCIE_PORT_DEBUG0               (PLR_OFFSET + 0x28)
> -#define PORT_LOGIC_LTSSM_STATE_MASK    0x1f
> -#define PORT_LOGIC_LTSSM_STATE_L0      0x11
> -
>  #define PCIE_LINK_UP_TIMEOUT_MS                1000
>
>  /* Vendor and device IDs */
> --
> 2.55.0
>
>
Reviewed-by: Eric Chung <eric.chung@riscstar.com>
