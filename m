Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E87CCF9C5E
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B224288970;
	Fri, 20 Sep 2024 18:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AyaBkEdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26EA0889E2; Fri, 20 Sep 2024 18:53:27 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38BDC8880F
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5365b71a6bdso2744991e87.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726851204; x=1727456004; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSefCrOqjlED6bGYbK/Daj8dKrIZuEk8D+E/euMaijo=;
 b=AyaBkEdXO0ppmfOigipw+v0UkU1v7/zvaq04eJZvpFAb27Fafy5mjTcgynZVLdC6J4
 h95Zx1iLUU61ntQMj1ZOiUzwm6cn4Lh0YNEdZmSKpg0LuOsM77+C8WEqyoKcOTujijCK
 nVZRDdSA+FQBaiPHXh6GlshYcgEvtmj4ZmOO6ldJaAreKnF7bCJb+O59JGRiq1YEcWUI
 bdleDZQieS2NEy8Mx9aOVZ14pJSPZSHihFsIYVBHJa1SzOs6plPVjwlbtAl4RG1k+rFz
 GTEm2znjosS9bwzKY1Ab2V9nA+1P4cidQBl9GZo+XFwtAnYaeQSFnCHeSPiP0KRUMC2u
 Ro5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726851204; x=1727456004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSefCrOqjlED6bGYbK/Daj8dKrIZuEk8D+E/euMaijo=;
 b=X0Q1Qhq3bdJK+b/V5lxwnLjdW6XDqy4BWorPPeFzdXXJ8/tOoKmcQHX0BZpl73+rVX
 Q7bsUAnjwwOdz8HsBuQP5+MB7eBEc77gxz+SztIMXyqIk+xmwJ5yLtCR52IZTDY1d+sw
 xJsabtWA3W/ZaDTkYOl2lx5y+ISyDP5oUpCsWXdwcSQhxWEZXKHicWJiV13nYROkWMlx
 5rgnAlbLFPSSpC8CKGDdsVsu8bMidF73Lp2ehopepjlZG3QSO87rmy++Sz07+9scWeba
 KiZ6BxST0CF2AVIj7/C/2H+kfscfeGSXtTqouP3UFA7jJ5m0ypaiR909rgbsImEob8U5
 QVtA==
X-Gm-Message-State: AOJu0Yy9XCQPRM/tKKXCMfwNoxtJIUcrYu9WztkCxxqubOks/Br2QDGw
 5mcJ5bWuJFZ8UADgDPv11EZOPuylsmyynLWiYFMGow0n3YVF9nP2X7DyqziKKEgSmc5ShWbwG51
 fTvy+NWpbg43a1ma+Tq4vZw3Rj7A=
X-Google-Smtp-Source: AGHT+IHpkETsRyCigRYr1dE9glxM4wDNWyRZtAKYVWa4eR6pM5vSLSM+oF6/7u7nYZsOR8jBsM6Da4+9nFv2a4KKNhI=
X-Received: by 2002:a05:6512:220b:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-536ac33f61emr2714177e87.54.1726851204085; Fri, 20 Sep 2024
 09:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj0HNbEy7VSaDA=Vd05+EWT1rxcDOBxu6e=BY1aQ54ZPg@mail.gmail.com>
 <20240920161114.916381-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240920161114.916381-1-joakim.tjernlund@infinera.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Sep 2024 13:53:12 -0300
Message-ID: <CAOMZO5AMpO4yQwu2d3NGYaeBAhYYZW7aH8gOjX20DBgGB5+9xg@mail.gmail.com>
Subject: Re: [PATCH] ICEXMSW-2822: Add mkimage secp521r1 ECDSA curve support
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Mykyta Iziumtsev <miziumtsev@infinera.com>
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

Hi Joakim,

Please replace ICEXMSW-2822 with ecdsa-libcrypto in the Subject line.

On Fri, Sep 20, 2024 at 1:11=E2=80=AFPM Joakim Tjernlund
<joakim.tjernlund@infinera.com> wrote:
>
> From: Mykyta Iziumtsev <miziumtsev@infinera.com>
>
> Adds support for secp521r1 ECDSA in mkimgage

Mykyta and your Signed-off-by are missing.

checkpatch should have warned you about it.
