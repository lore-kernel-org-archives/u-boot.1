Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA62CFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64FF18312A;
	Sat, 29 Nov 2025 22:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="irmDwzL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F91832AD; Sat, 29 Nov 2025 22:11:45 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C852830CA
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5959d9a8eceso1927001e87.3
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764450697; x=1765055497; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QP4qSTI5xv01ICJAg65JAUO0cUDXR9B9964KJqC3gYM=;
 b=irmDwzL3a3b7n9PwRYjaN9V/TeeNknYTc12drLtg+8kpeOnmvanOfdkC9P7wyuJvOu
 q/yqItxdGWlLfsd3jUaVQeloiXfal+oE142SRqFUf4G/+oihwmxOefEU1UDpSoQdz7b+
 CP83TFAEDvWKCBhHZX+/xHdX9UnFqjXmFiMRrBD4APqVCk+hG3aRRQBDVsa6KW7BQE0U
 lthu5XgD4TZToF0b1lZEpA/IFINR90QetDIREsDjN8bnDkWSj2ny/q71tR5agL3FgKSz
 jrvIG/4IQqTvXhQyIXPFM5xLiMFgAkzYaQXQHBIB2uqpXd4tppz4JSSqccHltXCris3Z
 A5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764450697; x=1765055497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QP4qSTI5xv01ICJAg65JAUO0cUDXR9B9964KJqC3gYM=;
 b=hyPvm8wHjX+zOR2wAc1aCEowFlHF9ijqithGEFJo5YFcN9DXq1AylBnwNDp+yU+KgY
 myqUtTWUHadOM01FHXi75vWDp5G0aoXjc2t6/XD5TTp7juRVidjV0+9qdRKedBldsi/V
 aJyIf9U2wtVp6j+ff6qm1caAnryZe9j1XxkrbAqXmr5NwSTKgXwoV1gilbQY/weywH7W
 I9zkPRAS9TAMhFz9mj8bUDo6mszaWIPsiKWPZTP2pLGTZB01GqfXoLSf+JsnQKJ46HeV
 Zr+MAqxji33PNbWnGQ/1xyKaoU+NwsMT3i/X0MgKBHvUHUK5xidIjzqf0mVBL+kfoMLh
 OQvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwvZSO+4tZIupkGeRxg7fzwDJxTuUEWfX20L2CkBfAuV++JbldVem/HNdJdTeSTtWjPABPQJ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxB/pp5j44Rw0vbx90LQMFEzx+M+IhmJSnfLMZtD3rLue1axzTh
 OTZwxnhEyK5F9Mj2VJaJcdjYY3INgfgallCOrUoeXfbVIsxcgIxDyZD6ukd6T/AKQgtkZvfC/+6
 V4/vt8qE8BAE3kmj6XgMEUos9hfd9B7I=
X-Gm-Gg: ASbGncuXwG6OK5+GwLNhH3lDE/Di2G5IBg96KOdFcPgPuUHxAaRdLQbyb16yMaT4B67
 9krdztVUuOzOmL6+j9SsOfXUEloWxxqlKVpwe3y1+YZj/SRh2wKJtpk1+oUxRiVOOmv8Ps01kjv
 V1yjDJIDzWlzFuH3SSz3MLSyJ9LP8+t4DNDN6X1zJE6G+ho9N0zvHCNaQchQ82si4qVs+HdSVPx
 q/E5DsQIsE5HoQ612hiQ3uKAWK2IKYNGgBbPqGjRaNdZaUpYa2PSgqBQsV0lGdjnPAMSnMPyhZv
 OW3MK1VG/xHcLipHgu1Z1aluhp0=
X-Google-Smtp-Source: AGHT+IFgBLJvavaWShWGHWMemQBdx8tRQFQQsEYEJKIytbq2mGLXRlPPv0O6Pd9IQkJVfcCHPhUpbc/INE8p/8/XiWA=
X-Received: by 2002:a05:6512:696:b0:595:81e1:2d00 with SMTP id
 2adb3069b0e04-596a3e565b8mr14125291e87.0.1764450697143; Sat, 29 Nov 2025
 13:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20251114142959.88459-1-william.martin@muxen.fr>
In-Reply-To: <20251114142959.88459-1-william.martin@muxen.fr>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:11:26 -0300
X-Gm-Features: AWmQ_bnA9FqR0U20BTV8tV7y99KCyAtsOnHdxWkU2nB1XP6QKHzXldwo6tapPwU
Message-ID: <CAOMZO5CEuG9J_=R9GY1kMGRHMG9Xtwnn38aJMjrir4EXFP+nMg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx8m: soc: Add support for 'boot_device' and
 'boot_instance' environment variables
To: William MARTIN <william.martin@muxen.fr>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Herve CODINA <herve.codina@bootlin.com>, u-boot@lists.denx.de
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

Hi William,

On Fri, Nov 14, 2025 at 11:30=E2=80=AFAM William MARTIN <william.martin@mux=
en.fr> wrote:
>
> Some SoCs have supports for 'boot_device' and 'boot_instance' environment
> variable. Those variables help to choose the right boot media during the
> execution of the boot command.
>
> The i.MX8M SoC doesn't have support for those variables but provides
> internally all the needed information to create those variables.
>
> Fill this lack adding support for those variables in the i.MX8M SoC.
>
> Signed-off-by: William MARTIN <william.martin@muxen.fr>

This patch does not apply against next. Please rebase and resend.
