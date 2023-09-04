Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39256C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2778691A;
	Mon,  4 Sep 2023 11:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xw0F3L1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9D186908; Mon,  4 Sep 2023 11:21:45 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4662986908
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-500b0f06136so2195328e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819302; x=1694424102; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1pZZ4VrZ7ZNtjr1OgaN3QNlsSwZ7f9gAPWkLOFEZZo=;
 b=Xw0F3L1aQvSdOxYmiGxj50vvNQzIOoriWhwEUoNfCjA6j27tXSJSNLpFdDgeQQzsVG
 Ay6d8AUpmTauFMsV2FoNr2u/MmsPGmrqEmtlfX/aDw5P+ihKv5g0TW76mJ7jdpkFEPkv
 CY15VJkgLpYYeOd2JYHh5Ol57rfhXZhOi1kCygBdwDY6TmJ0NR3vuisLRfBCmZrB10v/
 C91WfOwLV2h2omgWD9GLA3zsE83nMH6JOuRB3MAP0A4HAqzz0lskQTte1dkYU9pddRZ/
 Wak3gBF2/V2VCI8LaZl3cP1Nl04MuKjsjY1Y3b83Qs/nsK+tB50qPvjxbhEGoHyewgAO
 eigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819302; x=1694424102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1pZZ4VrZ7ZNtjr1OgaN3QNlsSwZ7f9gAPWkLOFEZZo=;
 b=Kb6Kk3bu1SP5sKNZOufrcDas6NRw/XKlhYT/2GkCWmJIapjalgPj9O1m9BPeV+bs5W
 EdXFVbVZ01nTkuSEtxG/Rl2j0MZtqpLAnvCfnVevcbjn2l67XeKPRzVUPjSfbHrUjCcE
 awycv9hislARWxtusWD/YiJMYVuOWwrDkcuf0iGQvReCKfna3G99FXt7W5wqJgjiOCkw
 ZqcJTaaRUmbS4nZzTtZ088UKbAyQM4PLaSxqgxpxaF6ScNPOUNTwtn4AG+uZgibWgYz3
 XDX7zwiZcaBDIT9gbxhc60+ny8gOnZkft8klO9QwQevv83bygzgL9472KWorj80Kys0w
 1kyA==
X-Gm-Message-State: AOJu0YwWUgydkKon6F0gj9U25uHyPDlPG1cpIchxMFfr+gEElSw2XYtC
 qF6r8W4/eHQSxC9B5dUbaZFRTXNpO42EpEnqPxQ=
X-Google-Smtp-Source: AGHT+IH3jDVQEhR8RTcxYD2oSSoKa2vpzS1LUdeI53+Son/kc8YIx6dAdHUs4Vn46jkomdKjcqLeH8adoUPjH4nN/XM=
X-Received: by 2002:a19:8c1d:0:b0:4f8:711b:18b0 with SMTP id
 o29-20020a198c1d000000b004f8711b18b0mr6053732lfd.3.1693819302219; Mon, 04 Sep
 2023 02:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-3-sjg@chromium.org>
In-Reply-To: <20230823184746.842091-3-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:21:27 +0800
Message-ID: <CAEUhbmVManYHdmBF2b=Wwiyphc6oGf=FCa=9_OrC-Utkm-jGTA@mail.gmail.com>
Subject: Re: [PATCH 2/8] x86: Add some log categories
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 2:47=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Add some missing log categories to a few files.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  arch/x86/cpu/broadwell/sdram.c | 2 ++
>  arch/x86/lib/tpl.c             | 2 ++
>  2 files changed, 4 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
