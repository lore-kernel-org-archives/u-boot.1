Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8F7CD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D65882C6;
	Sat, 30 Mar 2024 20:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZZR3P5Pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFF7882CD; Sat, 30 Mar 2024 20:49:27 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 433A3882C1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a1f8308532so730393a91.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828164; x=1712432964; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0Oa+o9sHcjFPoMki/YBD2n0/VrlsJkhzXZdv62vjIA=;
 b=ZZR3P5Pb9MKeEWBCz9mbaqqScSajIhqfuACc8/rb7FKJOiIdqfJ/IlVKessJc77oCM
 fp4GB22SKZ32JA+4cZVcR0qaRxgbLMngO+69MX4nTcHEXHxvZDGHcPv4zPjIwY0Zjbkt
 aWtyvV7tSqiiRVsbVQXajFFVKYWLIUFFIPW4niazgwTcmbwYtIGZtc9LWh3gLuX1Bb8D
 uKCQgnShAeHcdih/5UbAQqQYExeMq6CREPoEITeJAYgCo3brzvd+DXCeH6Vs2w8cHl7R
 hmF/6zhtKEFu+BDLFQ53sh+Rvg0xmytRvbgKnexIPksn73sXp3fBqaGWqqooC8DSNMIz
 tB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828164; x=1712432964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0Oa+o9sHcjFPoMki/YBD2n0/VrlsJkhzXZdv62vjIA=;
 b=jTsydf65Fb6yRjUxVw3JpejxPmZpKjshc86zQJexv6E8fzanvJSP2LrGJiTkgjAbh1
 n289RuHgvfUo9fhx3G0X/SFfe6lZa1mFCNDPjLfsZvUq7uVbDr+kNkIhlBrj2fhq3GGp
 NomjETakwHqFzDwNsHbJT7lMSEnGesxHfmMEXf6jnDDkvwDXWpFdhW9jS2gcKmdo+ikC
 yn2q6v0903GgTeawcxW7lXqwPRVUln9wYxyvC/8MoMuAR91HoiUuIq3eD/MyJi0i0TTy
 WiC2tyJyZ+ymbVNen0PVo9QII/jnNAcFJAf3POLgyfNhjaIKv1mbPLYARh6S8FijW9ty
 TZwg==
X-Gm-Message-State: AOJu0YwJZGbIl0cIWMEstsaJ5wWlteuLjZ3I9OYVpRTxrHP3Oxrw6fpW
 9d8TUOsKVyZEYTmD179EkIhhXCIh1e3q609c2X/te+SDqP9biIMNf24O0IZQHLnmXeoOQD4bWQR
 iffuU4rQ+e8G+eX/sxqZUuFIyGjZUTtodWpI=
X-Google-Smtp-Source: AGHT+IG9mFb+fpMlGfjOzkK+yFDWB0x3akT7niNWndX0AI0sIXOM3bJrr/AEbdqSq7Ewaj13oiZd2Fl6uHKOg4txnjs=
X-Received: by 2002:a17:90a:688d:b0:2a0:2605:69be with SMTP id
 a13-20020a17090a688d00b002a0260569bemr5657521pjd.2.1711828163654; Sat, 30 Mar
 2024 12:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
In-Reply-To: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:49:13 -0300
Message-ID: <CAOMZO5BPvMi7=AsCt5OTkfs4jhrh7sxg=Rb452puM-EDY1gg9Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] crypto/fsl: allow accessing Job Ring from
 non-TrustZone
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, 
 Gaurav Jain <gaurav.jain@nxp.com>, Breno Matheus Lima <breno.lima@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
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

On Thu, Mar 28, 2024 at 7:18=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> This series allows using Freescale CAAM Job Ring from Linux without havin=
g OP-TEE,
> this is needed for example on Toradex Colibri iMX7 where we just have U-B=
oot + Linux kernel.
>
> To achieve this add a new config option to allow the non-secure world to =
access job rings.
>
> The functionality has been broken since U-Boot v2019.07, with commit 51f1=
357f3428
> ("Revert "drivers/crypto/fsl: assign job-rings to non-TrustZone"")
>
> Link: https://lore.kernel.org/all/4b64a9de-a840-4065-a530-f81155b4b9f2@to=
radex.com/
>
> ---
> v2:
>  * Kconfig: spelt "CAAM" instead of caam
>  * Kconfig: removed "default=3Dn"
> v1: https://lore.kernel.org/all/20240325114642.3664840-1-ghidoliemanuele@=
gmail.com/

Applied to u-boot-imx/next, thanks.
