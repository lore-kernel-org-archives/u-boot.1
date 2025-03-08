Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C96C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 19:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7CDE808A2;
	Sat,  8 Mar 2025 20:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LmDdAX7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 534C8809A5; Sat,  8 Mar 2025 20:32:32 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F068043C
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 20:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54957f0c657so3464990e87.0
 for <u-boot@lists.denx.de>; Sat, 08 Mar 2025 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741462349; x=1742067149; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuLYgwSzZOyadN0Md6UemMcWNTkh04QouUoq1RQ/Y9Q=;
 b=LmDdAX7Q5MCzfsZqIoAb90xOQq9DkebrPiEx0OUetdq1o6mc4qn0Yxd1cC6UK3+tJ/
 GYUtnBPG74HyT63MC1SJdaWnwVUv51uaFvQJdaQlEI28a+Dyuiavjn1CsDYBCD3c9fLA
 NQkKd9ltRNQc9IFQUMETW1WvpJgDjLL3c8QoUquWYfJ0zyyCTAOkawZNxciu6qlcvkbS
 XAyQ+oCSifAWs1kUDIPHc+GpRomnab5ZLciz548JyBFzuRRaKpgatgHEI4Ejwo0sOF5U
 bWASkzI7y8CAYhZ7YUXxTuBF2jRlP7DTecPDvVv25Z64I7MEXb5hUo7mGs4QCSM+FV1R
 XKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741462349; x=1742067149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuLYgwSzZOyadN0Md6UemMcWNTkh04QouUoq1RQ/Y9Q=;
 b=iGjC3pm0WpHPM+QwMKOkCdiW/bTxsBchQNp+04Q2MPBGz8xngW+npd31CKR6TKhq7W
 fphzBSxlt4c5m40xYFMOc6aof4h8VKOaXdZ9rZRzaMayXkyGXQhguRvyu6cEr1EdkzYW
 V9misvd3DGDywnnzIdu6tz3hJ593YusWhqete/AWeXLethpVz9fFDcZjZ/L6wvc/4AZa
 wOzOjxahGirj1VY9a0CmD22Xy6rju1iLyB9KC5KdYNuRwqp+f+DdUzYDmU+T2W/gi1w8
 6XuWR7Scnxe/OMvXGv5+xGsX+uoEGA0YJTCXpN45CHw3sKZ///MQ6VGQSDOeasAYcwti
 uzVw==
X-Gm-Message-State: AOJu0YzhKM5+l+uPB4iRM4rfLI75tP6UKUb8VCIkMKEKWyG4VWuWdWjd
 zBr1gGyc1XCnma3ro/4OlFDWShWsU4lEpoWKQywoiTfn6XUMCY/1PFIpp4UckwBKmJPt6aCJvZ8
 O2mX+95mS8PwOLCOoR/VsUSWYUak=
X-Gm-Gg: ASbGncvguVcgGnK2IOvE4wqfzleWlZnNLycVVj/7b3i5asRMiMlyxM8Zu6SoIf8/R1Q
 eLy+CDdBMlIOu3Ex8OXm28eKsABqHlpR5uf8m68sP7PE6hKkQQ7FDO0ySTvPqFm2DkhGBs0KPd/
 8hQi/CgAHHBXx8dgP2XPpPHZQLcGi13puxNYnOwjxzejZy+KmXIu9gQflP5Q==
X-Google-Smtp-Source: AGHT+IHEG1rt3aBPPN/4rsRLfvv5Re308IEc9FBnZqNin6gbDHp1B8UgiPKyr51njh5NTSqxd5FKNi4FlWhYlPX1qpw=
X-Received: by 2002:a05:6512:12c3:b0:549:6030:a720 with SMTP id
 2adb3069b0e04-54997ef5214mr1347673e87.23.1741462349307; Sat, 08 Mar 2025
 11:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20250302165249.267992-1-aford173@gmail.com>
 <20250302165249.267992-2-aford173@gmail.com>
 <CAOMZO5Ay+Msrj7tMBm8noLKHe5iPAN4=nOgX9tu7wKbWjeSPNA@mail.gmail.com>
 <CAHCN7xLMMH_BN-nVzSh3iQV=h-OPHEBY-=4OuBpHOBcYktaiCg@mail.gmail.com>
In-Reply-To: <CAHCN7xLMMH_BN-nVzSh3iQV=h-OPHEBY-=4OuBpHOBcYktaiCg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 8 Mar 2025 16:32:17 -0300
X-Gm-Features: AQ5f1JoNsK8QhocGtUdjdzRvIn3Fuy5VbtZr5p_Fd7vpjmemxGAeEfoabUJHbr8
Message-ID: <CAOMZO5CirKWYts-F1H3+-HzGz_bEa7-nWzN7mKDoosVfKpE_cA@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: imx6q: Properly handle imx6qp ESPI clk_sels
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Adam,

On Sat, Mar 8, 2025 at 4:07=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:

> Thanks for the review.  I will make the updates to the two patches you
> requested.  Is there anything else you want changed before I submit
> V2?

The rest looks good, thanks.
