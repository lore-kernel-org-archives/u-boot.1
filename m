Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AC2D2A53C
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC75288DD0;
	Wed, 16 Oct 2024 20:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NkrhD8O3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F7B88DDC; Wed, 16 Oct 2024 20:29:06 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B405288DA0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:29:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f72c913aso143872e87.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729103343; x=1729708143; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5LkcJ7MbTsCthy0y+xvkMJJff1fliMFWmbLurXUNto=;
 b=NkrhD8O3BoDqA0PzmMiBwk/woC6qbmCjncS4g7Vr8j8eTCU4E+lAnZNSWqzXij839T
 ihKwLtL7sUse5aREmn+ov0fMxHzUXSzFov9UPmhTA/Dvj46eh6ZZ4bNWdDNZQxEqbx6q
 T/42nYrKDWWpGrnDjmenF3h/EoSCKqLuBhGzjHcPI/kZTYLyf+hMg8d81CfjhKxsuPMN
 NC8UTJaCsrHKdpK7fA+AFhgpsxQTo8SOV/P6KHFS3Yl8c3IIDpAzcseZbvg9OMyZKuIF
 vdjwktTf8dKAtacjlTzegK/JWf92Xs2hjZjZUTlvG3iFKJAt5MJ3Rzqqi2tHwA7ekfGE
 3Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729103343; x=1729708143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5LkcJ7MbTsCthy0y+xvkMJJff1fliMFWmbLurXUNto=;
 b=YzAbfPB+xiC4PeKQYPEnfNV07JL+aGXKyclngNvcsz5zGwNvl5i+xsfK4zS/FUV1v6
 9HJDKkDJl05mA4GHqDX+ITWX69dPPG8DjMdbepy6qK0PeDlv4sppEDlnZ5m3AGXBl8Jw
 0oaHUvJnrNPxZy3bF2dd4RKmLeoc+1AvTgFGdTcpAlmttrbTwI6hcxV+mEcd+4PEfOdo
 LFfzS1HMG4x7auY2CwpItPQf+W5BWg7z4wdelhdFH6OGe4aLvF8gLIbJ1yTHqdlh+fxk
 cgNY/2VIxr0QDAbQnXRkS57Qku+S9ouRp32PntxGGgLaYT1dQoSRlOUrTXeT1ienYV2b
 dVjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiHpzge8S1341tPFrJzvg6uP/x0SG1aeF3fkQcIpLcfLxJ7IeJ7r8dgRjICAS5NV+XTDXzKIo=@lists.denx.de
X-Gm-Message-State: AOJu0YwzFv5jO9bicwqmv4gcQjJaunFHY5U1rYGoErE5bYOoxa0jPTgs
 6p0jY0yu+1cM7XWZ01vUtJNse32DIM2kkw4CmKvsHVerD029f6b13Ik71EUWGJJWkX2PSdbbkcW
 fiIJXOJvHpvlVbe3FYFZdWPfsTjM=
X-Google-Smtp-Source: AGHT+IF9I4CCtu9cmAYJeUsHKt2bXfyeaMWZY8khINeSTQTd6hfuMIWtw493ig/tb7vxbpwSVUSh7QuwJjQYtMAu958=
X-Received: by 2002:a05:6512:2215:b0:539:f4a6:ef40 with SMTP id
 2adb3069b0e04-53a03f949bbmr3503422e87.54.1729103342663; Wed, 16 Oct 2024
 11:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 15:28:51 -0300
Message-ID: <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
To: Peng Fan <peng.fan@nxp.com>
Cc: "egyszeregy@freemail.hu" <egyszeregy@freemail.hu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "sbabic@denx.de" <sbabic@denx.de>
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

Benjamin,

On Sun, Oct 13, 2024 at 9:39=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> Would you please give more background on this, I not got
> the point on why doing this?

I also do not understand the reason for this change. It is not clear
by reading the commit log.

Please describe what exactly fails to work before the patch and what
works after your change.

> > +#ifndef CONFIG_SYS_MMC_ENV_DEV
> > +#define CONFIG_SYS_MMC_ENV_DEV 0
> > +#endif

I don't understand the need for this.

env/Kconfig has a default 0 for SYS_MMC_ENV_DEV.
