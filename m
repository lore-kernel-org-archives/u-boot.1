Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504F2C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 12:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CC480EEF;
	Tue, 25 Mar 2025 13:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNFiL2AA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A64378192A; Tue, 25 Mar 2025 13:56:05 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7730808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30c091b54aaso56254861fa.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742907358; x=1743512158; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox+bi6nQIIeFX56lUjitMQLdH/KzNsuCAbERueIgnh8=;
 b=gNFiL2AAADwnZ8Go8VvWwR+V9oNx92pBsYuIDZ9RwVHfTlWJRXZOIdL/bL/cNGNERz
 SNgUronGwxDYhPAiML9Ezig0jjQbYjhqUJFSdVcoxEUZpxPZ/EAcCzc/EbbYThALUIak
 xgCFvRE6kGDarCImHA8qdzlbgh5ikpVuUuaszxzQXDMHsYk06ffNnV4pnwt5i6Y+GXqq
 sszNQXa74jcmrvBUS9vC1Q0fjbQ2bsORscEzOiFbOserIM/xgY1XkjR1KzyfR/jgc6Jk
 fc8e3Ksue6E2JJPDfbq/oWKak21mZMJ8g7GR4xk/kXBqrIzNi3JNZFlevb6eknPixsWq
 j4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907358; x=1743512158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ox+bi6nQIIeFX56lUjitMQLdH/KzNsuCAbERueIgnh8=;
 b=SSvIt9wGYCs+nXMNuK/xd3+lTcGZROYUppNlxVlWgedGE1kF+1LWlLrb1GYHl2l/Z7
 uzUkpounuy7DNHQhVf+RCDEKoyjgVxm8T7R3M3j5GRF29ZV4Bn6Olrz4XEwxGCJeIXOV
 GH/ZNL6qYSlgfxkXRUWfH4nS6Bl1lke+sBMJdiQcGfmcPNVCfzdWeTwkXcLRn8AbqIgm
 INZ/PUaWbyr8CBtRdefoVH49Tw7uaHg+3kYe2uPkwJR54vyEQD2mjHfmrf8IrPXcf7sO
 IuUpduJbQzN8QWcVkq0rWSpYZWzFlOEf2ElGs9d6JeoiPQUBIVEhr19IVgTKhIq3ToC5
 CZig==
X-Gm-Message-State: AOJu0YwHG2Wo56cF7vyFsgWU5KCF0hIfNWwG7AcbIfCpvndAdlCuUcdD
 8iJOcOlg9MQ7DhOmHyKHVX3jPWr+fmh3RWyKuXtezXdNe95K94X/WsQfHIElzr8mE56G3PsNxCt
 D/1GeuDu5c+HYSVWoD3qCkMuT3Rg=
X-Gm-Gg: ASbGnctpcT0/WedZORdLjtG2gVm8SPJK00NIf6XW6B1m1j5i3cyxeXQJ+HTUeQ0mswX
 LeQ2l9O4OaE7j2X9ZOvHcWO7SPXcZdnzK11Gn75JPB1xJIdelbv9pkCkSW5+6XyY0U6byUcryA7
 J8103LzWMD1qgfTB5YkaOucjrzrg+BmUMSIRZpZZH/+0JXU2Zj2BX8gfar
X-Google-Smtp-Source: AGHT+IE/BzrXV/rIeTJ2zmO+oyta5Tr10xWY1Ugp8XjG8d/22XAJiCI33DuD6asWgjE1/F94y+rkRyuRXHnt1BUUVGA=
X-Received: by 2002:a05:651c:50a:b0:30c:40d6:5cdb with SMTP id
 38308e7fff4ca-30d7e21a675mr65360761fa.11.1742907357819; Tue, 25 Mar 2025
 05:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250324232725.859935-1-aford173@gmail.com>
In-Reply-To: <20250324232725.859935-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Mar 2025 09:55:46 -0300
X-Gm-Features: AQ5f1JpuYPTHeWwHuEV5SlyYU7gXjGGvn7PpXOxLD--D-LI7HDlLGWe6ew2LNq0
Message-ID: <CAOMZO5BSTcNKHcXrvBuLV1L+Pc-_sj7AXTMa8PGdT9HGpL55xg@mail.gmail.com>
Subject: Re: [PATCH] board: beacon: imx8mp: Fix GIC clock for Overdrive mode
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
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

On Mon, Mar 24, 2025 at 8:27=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> There is a config option to run the PMIC at nominal voltages
> which is not enabled on the i.MX8MP Beacon kit, so it the PMIC
> runs at overdrive voltages.   Unfortuately, the check for this
> condition to set the GIC clock parent and rate is backwards from
> what it should be, and accidentally sets the GIC clock to nominal
> if the PMIC is in overdrive, and sets the GIC clock to overdrive
> if the PMIC is in nominal.  Fix this by inverting the logic on the
> check.
>
> Fixes: ab53bd43dbde ("arm64: imx: Add support for imx8mp-beacon-kit")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied to u-boot-imx/next, thanks.
