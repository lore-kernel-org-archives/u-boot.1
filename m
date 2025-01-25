Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13878C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 15:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DAF880C7E;
	Sat, 25 Jan 2025 16:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VlSP9apb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6371980DF7; Sat, 25 Jan 2025 16:53:25 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237F980017
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 16:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-30738a717ffso28661521fa.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 07:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737820402; x=1738425202; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHpmeVsmExt0RTdzvPLFWWa9NM05LFNTZzWujhFCAh8=;
 b=VlSP9apb3rxFsRg7Vfty4465Nl+ddp69Czd2Iq+OTV6jDKLri6uw5Pb5IFZW2TIng6
 lSILq+F40p6BPCbrUvYfULckM+/CY9Ehvdje6zOp0MpVx42c14wxyiD+N6eCGEZ54Ure
 iFuiyElypMID19qtyHe97ZkVMTZsdDQAJNTNkXmPavorSy0eUcRAFRfjj3dQGqjzUuig
 r4981NIUeOMsljTXgQKw5lKec8hRAQMnc3OelwDLZKi3iXTP47cOkzGesJQqvUqXD4pI
 96kxXpP+yH05/3ByvMHiMKKXR4jymp3668L5Ju8KFWWY7Mz4WjopqNPm0UJC5zfs1lIn
 /nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737820402; x=1738425202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHpmeVsmExt0RTdzvPLFWWa9NM05LFNTZzWujhFCAh8=;
 b=lJ7y9KzOb3eb42RYFQ+1Z6uR8/se1Sgips05CaHhr3bE4F4TkEw9cuDZIjzIZBuuV8
 Kyg5y2J+YADCcwXOoLfgpS5ZQHK4wZJoFukXdA1+JFN5559lDHzUcM8cMImx5bVbyZ+I
 dM5WHt7gk0htQzru4o4g+hqwBTWKeF/CJgXILFz8bElKFWq8XfRqeECCXR5ESzgV+4Xj
 c11bIvEfu1eNBkfPs9Mn5JvgxCCYDRLl1PM3hkJy1+6n21qVjY7nrAyO9cKrorcuXzLh
 uDj9HR3Ong4UnEdh1FOFyzU0yKyAS6nmbyygZAyg2Z9EWDwX0VCW43PfIlcIxZTLY8xK
 xojw==
X-Gm-Message-State: AOJu0Yz966AslcePZkH8vWfq5aleLbwVScurphcLmYuuPUXIsMsvOkwN
 5MzBWau8zsF5ccZ3SZLlG56KPLY+1vE2puTtfE77Nh7A3vEe8Kuanzano4uuBzBSrNtAQCFC1FN
 6DWTxM3HzCEgrEB+QwTjLZmxJ8Zs=
X-Gm-Gg: ASbGncvTFtIc2XtHRPxb1ja4p3WkxP9fBFqKs6A91pthEaNnl6ulAfQ8gcXlUyewv2c
 EqLvC61XyUtK7EkWijH0zXRqbRHblmdl6wlusIvLhH/4xmccSszx26carMCekYqsRRqBp9swMPI
 VFt8RF47nUSmtpBYyN
X-Google-Smtp-Source: AGHT+IHeNwjzc0W7aRakxbTuqveHU3wWSyeT4+RnbU8xXV5Bw7yk8T7XYtWqgSyb1NINnbb4f/ldL0D22dGk2JuwID4=
X-Received: by 2002:ac2:434f:0:b0:540:c349:a80f with SMTP id
 2adb3069b0e04-5439c265cc4mr9181670e87.38.1737820402044; Sat, 25 Jan 2025
 07:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20250124145520.185414-1-marex@denx.de>
In-Reply-To: <20250124145520.185414-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 25 Jan 2025 12:53:10 -0300
X-Gm-Features: AWEUYZmkR2uwNJkaOkXHVrl17qPw5Q01Kw8duqyBf19qTXx3JJdvHOPNEo4Mb0U
Message-ID: <CAOMZO5DTbaq+ArihsEE68YbD8S-v9ny2+Nc8XbXZ-JWRRTUFTw@mail.gmail.com>
Subject: Re: [PATCH 01/10] pinctrl: imx: Push imx_pinctrl_ops into drivers and
 staticize
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
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

Tom,

On Fri, Jan 24, 2025 at 11:55=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Move imx_pinctrl_ops into drivers and staticize. This is preparatory
> patch for follow up pinctrl drivers which will not use this variant
> of imx_pinctrl_ops content. This should not change size, as most of
> the deployments compiled in one pinctrl driver anyway. No functional
> change.

The u-boot-imx/master-next fails with this series applied:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1005082

This is unrelated to this series, though.

Any ideas?
