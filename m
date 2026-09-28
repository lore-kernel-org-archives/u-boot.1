Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570BECA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C98180F03;
	Mon, 28 Sep 2026 15:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzTGAquoNt8r; Mon, 28 Sep 2026 15:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3F84880D9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608443;
	b=IUeGMDm8vtvIj3ng0pZ9+7Rm9SMg/i4YAzKTImCgYY+4dl3Uo7TlyJqbcIBAx5HrTJY/
	 0nKXXbsRiux8mnUw33e5v8pnnsIug3zo5xzENahx1mBkeJTq4m2XQTeIe2k8bqBtb17fh
	 Lj14p9iDHoEVaMNXqMSy+SgATmWv+x7wEyVPaLJ/oUnkLjVp0mY4CAuiWyAxLRklFzOHs
	 KpWdRBV9h26px7GUXiwcUNXea2yeuglBGHYb4QCMs44wmoDOJXcrw5aFwXu8C73F0tsYq
	 3pyomCA/40XdM/fAZuw4JwzxTP0l4g2CJMXNyZXe5FHySv6Pc5UIPEssQj8Bvo/u2sA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VNlfDrS1fr9KnjwqDS9xy2kS/t3Q+oiu4UtBCUveGN4=;
	b=OkcnXzXgSmnVuZcBQTycdZQ5/sZ0ZV+T2u8YGSTHlmc7d8mqA4cZfPted6G9gAyZO+PI
	 iJh2+04BRGfgo5ZH4PaCJpqvsWMWROnBcXK7RKOUkhdyip8S2WpjdTZC3DtvZ0QhibfVz
	 IqTJKkkf/IfJa7+er7Z4vVelPKyHT2KLy73/HlXAO5Pmd+fAVRDpwf9h7iVdfkB7NOOPy
	 wAFKeZWIV2mamqyXabXXKyMjlp9HlHCYR5EPCUXJHCiyXqSyR5g05GhIOsFlF/XB7Cjvw
	 YsU42KH/kkdXYZDyGQn/ERGtQCl7VMf0QarHSuUcpc/JgTCgYGr7ITGKQIwYHBtbUPA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="lE2n/Bqn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608443;
	bh=VNlfDrS1fr9KnjwqDS9xy2kS/t3Q+oiu4UtBCUveGN4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=akOrrgjl8HvshpaG/DzRPQ15ZP8L1YlgN53cW4Nkhkq5gIJolhCiMwu5i8zjj2n8N
	 dH5W1yts9pxD3Dh8fkxJUpygUkSdikSg7uJfeyM78h4VAYw7KZ1K3Ve/ceElhijtiK
	 5jEaorivQK7S5TREpETslpjOwEtvv9FPA1jXFGCGS4IH2Q1Tqkmx/+4iIkPZUrJViM
	 QowXnr4bsyM4ftH1PNrt7tAV+c9nEQalh0KJ+OwYtO8VvUeD8bHhF+PboF+MbwkYvO
	 aylb8YYZeWhoFP+IYScbZeXsSyXmTsoMmgqCRzBwy6NUr6gkIiCNa/+1O8t/fOrTk3
	 B5T0kI5JS3sjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F84880D9C;
	Mon, 28 Sep 2026 15:14:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB98132F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF67F80EC6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J9b1i1lqpYPZ for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:14:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 001BD808D2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608440;
 b=Bf6jakLyHU5v0eYEyHgwbs8BbyLxVZgsT+PxM/z8aUd88TruyaJAMh3d8lj15JiEXW6P
 8kL5vRByMNvl4igvRaiCHRe0nQX6YWeuq3Qpr18JRllaFXZfFiuKimQv73HmJHMWoI4Uu
 /AWSF5ex58wT8Kn5DGAnhfl+YA29mEpVoUACs+sivTXyceXK+thlT1Uo4kujFwoPyQW8D
 innEzbyGONTEWxtVWPmTOQU/inP9dSHNKFTX9ROhNcm2jwnqcGOLguCgzF1jpb+zqFFgf
 OJLXsMVuqXgotWT0wmeiWrKPj2aVAoJVrlNpBk7goA3cuVCTYE4iDiKyZjVblv6A6Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608440;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=VNlfDrS1fr9KnjwqDS9xy2kS/t3Q+oiu4UtBCUveGN4=;
 b=p5ru3RIeocbFRIQg4W0RiIp5IZkcPIvo4g7ec1MOY/eGOYdyBtJ2kag6fBM8+V280xw3
 hjHkGcaLTKQV1REjUjGB0aCPUhb2TOcTwVv8b1g48nJJ4R3wfS/CwWoloB12w4vuuvqRf
 02RLGEMeUsCNqo28Ld8vYUj6bbyK6ZsfHwDBSR/f11VatesKuw3JtQ67HQmNTx+7yCdC4
 zHFthjFAatCferVlb88YFoj3RfGgWC1WWGcoFUOw709uR5wjoKM1Rm6a176AQpk2ryb2Z
 D4ucm0drKNRIIvn+QzWl7GcOuconFyva9srIYaKdy/C9yx+rxonNrOLYgJGvS344Axw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="lE2n/Bqn"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lE2n/Bqn
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 001BD808D2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:13:59 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso14765915ad.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608439; cv=none;
 d=google.com; s=arc-20260327;
 b=WC43EVVWgYF4lsBldESZHozI+E0V4fSSO2AA9OgIXJdtiCUG1maDTQWeEElbcgIqiv
 BwM59YMj+ZbKlbMlnCHqxtlW2frtRnP0RxcTFZ3OF/ZPpUD7a4AXB1NgB9yjHHEBYo5E
 tZpUP3nrDeQmZr55OKIeTV1x+sPdE+VSVxfT/kxOM9i8n3mWQ0gWnlEq7r+vbWLXbxYG
 zp3xsuBkgMiJ/wnajeY4HuYiU4Mn0Z1e50ktsY4jMmBC+KtJj8bDloUdGURVzTcRrrr/
 4Lu5wkNnar0fVwVu2Pq1T9t9mkw4dD3j3iKysyS1tbxTA6N8EX/tOzVDkLvvi7k7n3OE
 N1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VNlfDrS1fr9KnjwqDS9xy2kS/t3Q+oiu4UtBCUveGN4=;
 fh=K2mvaQ9HczY2n4Cm0cdVu5AkwD2BuDMtQGv7TuOVGCI=;
 b=iy6Y/RT1mArPgx9i0qvhlLzuO2t8NFxGML0ZBjao5Bstz2ViEibHKKlIEbhp0i0ri8
 pq4qiEy98fYanO+btCST+8sOeg/J9dOAt7qG7Bz5iCBVxtUO6Czjl51LQanMEEhq6NmV
 I0wbbGfVEBpBeSsdvK8cqVKPen5SA/SpGNJLFJGHnMIPZ0HMAXQd2Ue+Ntzpg2iWhK2b
 4it21hrVHB+0DDHLx/f/Ubj1m1i1bDk2reVKFvE632IV6UqtOEePy2NG7M7DxGfIC8cz
 5/knP9o00N9WL51dZ84lJJ4/QMEJ3c7aNeK7q32fYsOaf0hzrGtbSH7g9HJihXbmuakd
 2Cgg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608439; x=1791213239;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VNlfDrS1fr9KnjwqDS9xy2kS/t3Q+oiu4UtBCUveGN4=;
 b=lE2n/BqnrWkXp7DOkaxbzOpPcDOq8RjXt9GMIuFdvzYbUdHvnBaCrk8dv0wRD9Vwfg
 p1/u9dD/+5+ZeFKO3N8Wrts8jpUbu0y1mLz3fw66/lm9cIlGAD930kqsVMsRXx/peLLd
 aC1QVHOGHI+VBN40NH+AyBveEdCGwJuX8qfuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608439; x=1791213239;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VNlfDrS1fr9KnjwqDS9xy2kS/t3Q+oiu4UtBCUveGN4=;
 b=cnh66dvxJkVzt/dvcNDXfHWMLI8oEVHi8rz1JVaGgGMrhPedtGy1Y5siv/Go/Vn55K
 ClALzen/h3sjH/H88OD5w90TZAcVYESUI8jTD9e+wpaWWPHcWVXp1SjJCjGRKmKx7SCz
 klj7JC9J9jyf63slg3Yw3MTzHTeXkugzH5QUCC6fjb4rugnG3lLTaNEpFY5t71HQCGiV
 70YG8iw0qzgDrj3QYwnvWrQF9luDOxIHHWIBbq5VFittVsDc35HgXm6jFvRwMGiUqmI1
 USC9DVKw5KsGvwkQ+0A20uD39UoteAc0iKaAKqeIj0ih6fzKlPdaKr7wbZCRzsZBKe2B
 C1DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzABGj/dVGy0PuJ5ldiwbfjC7ANUZi4UbmTwD+lqIG7BWnuYfvJz9HkNmnC+FCQGHqZdj/rRj4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL/xzR8b0SPkW1UJ0oE5QKSi5VzyzHziIyE0k6yr+9YObHgjPSH
 Ny5+fYYubvAUAKwycAKRpe+WNhV9cgA19+4sQVcEeXPhkim9NZvrpkphtYRIdUCFCYPWN2H2PE5
 U9T3OnjRLi7nNgcFqozNqFfOaoNXKWIFnxOOkyG3G
X-Gm-Gg: AYBFou0r5A5rp8GHeUx3Q3tbtquFDKVArqOSQSjvtMk4QNF5iCDwpQmUmARxEoGB7vW
 9FiUpdxEo+SZbIUXzopdSW12dV3XPW32U6E6hsreBATfuM5Aci0lrOUDbE0N3nsRhZ/WXXWC/wI
 SPAfvTNgI0/St/ZWzyqrbjvD265PzTLx96l/EiOSXUAn7h++PQVitshbP3f8dlCyNJI68sG28TI
 uxv9ZlOX+DeByd3dZ/7mPq6txulMjli7SQ2pROa9GSsf0RKp4EWTCXpj3I9FedLjZMIjptyCocF
 34ei1x+2WzSUpXojsGVLfOpCznvUr5s6Up7Bhha3a1AjeGPnxoPKhQ==
X-Received: by 2002:a17:903:2f90:b0:2e1:35ec:e034 with SMTP id
 d9443c01a7336-2e135ece4e3mr26127325ad.5.1790608438899; Mon, 28 Sep 2026
 08:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
 <4432efbe2011d177eaaa2115451dba7276cff249.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <4432efbe2011d177eaaa2115451dba7276cff249.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:12:49 -0600
X-Gm-Features: AclHuK9XT4KYN3rcQYPxxN5jN-5UgjBwUEuM0aTxDDC6CFpNnhoYIslj18E-iLg
Message-ID: <CAFLszThrDrfjXh+mYAiv4yZk=2FavmPp7rt6CE3O8a1EeuJm+A@mail.gmail.com>
Subject: Re: [PATCH 8/9] test: boot: add imagemap unit tests
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Neil Armstrong <neil.armstrong@linaro.org>,
 Randolph Sapp <rs@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:
> test: boot: add imagemap unit tests
>
> Add a test suite exercising imagemap:
>
>  - the translation-table core (map, lookup, map_to, cleanup, region
>    growth, the block-aligned read path, and edge cases) using a mock
>    RAM-backed reader, so most tests need no real storage;
>
>  - a NOR read through mtd_blk: write a known pattern into a
>    device-tree partition of the sandbox SPI-NOR and read it back
>    through imagemap, exercising imagemap -> spl_load_region ->
>    blk_dread -> mtd_blk_read -> mtd_read for real;
>
>  - a UBI-volume read through ubiblock: attach UBI on the sandbox NAND,
>    create a volume, write a pattern and read it back through imagemap
>    on the ubi_blk device.
>
> Registered under ut_boot_imagemap in cmd_ut.c.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> MAINTAINERS          |   1 +
>  test/boot/Makefile   |   2 +
>  test/boot/imagemap.c | 645 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c        |   2 +
>  4 files changed, 650 insertions(+)

> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> @@ -73,6 +73,7 @@ SUITE_DECL(optee);
>  SUITE_DECL(pci_mps);
>  SUITE_DECL(seama);
>  SUITE_DECL(setexpr);
> +SUITE_DECL(imagemap);
>  SUITE_DECL(upl);

Please keep the list alphabetical - imagemap belongs between image_fdt
and lib, not between setexpr and upl. Same for the SUITE() entry
below.

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -0,0 +1,645 @@
> +/* Test: map() re-reads when extending a region to a larger size */
> +static int imagemap_test_map_extend(struct unit_test_state *uts)

...
> +     {
> +             void *p3 = imagemap_map(dev, 256, 128);
> +             ulong p2_end = map_to_sysmem(p2) + 256;
> +
> +             ut_assert(!IS_ERR(p3));
> +             ut_asserteq(2, priv->regions.count);
> +             /* New region must not overlap the extended first region */
> +             ut_assert(map_to_sysmem(p3) >= p2_end ||
> +                       map_to_sysmem(p3) + 128 <= map_to_sysmem(p2));
> +             ut_asserteq_mem(image + 256, p3, 128);
> +     }

Please drop the anonymous block - hoist p3/p2_end to the top of the
function, or split into its own test case. The nested scope is unusual
in U-Boot tests.

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -0,0 +1,645 @@
> +/* Test: read beyond image size returns error */
> +static int imagemap_test_read_oob(struct unit_test_state *uts)
> +{
> +     struct udevice *dev;
> +     u8 image[IMAGE_SIZE];
> +     void *p;
> +
> +     ut_assertok(create_mock_loader(image, IMAGE_SIZE, &dev));
> +
> +     /* Attempt to map beyond the end of the image */
> +     p = imagemap_map(dev, IMAGE_SIZE - 32, 64);
> +     ut_assert(IS_ERR(p));
> +
> +     /* map_to should also fail */
> +     u8 dst[64];
> +
> +     p = imagemap_map_to(dev, IMAGE_SIZE - 32, 64, dst);
> +     ut_assert(IS_ERR(p));

Please declare dst at the top of the function - mid-block declarations
are still avoided in U-Boot.

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -0,0 +1,645 @@
> +IMAGEMAP_TEST(imagemap_test_map_basic, 0);

All of these bind and probe devices under dm_root(), and the
end-to-end MTD/UBI tests rely on real DM state. Please pass UTF_DM
(and UTF_SCAN_FDT for the MTD test that walks device-tree partitions)
so DM state is reset between tests - otherwise a test that aborts
before imagemap_cleanup() leaks a bound imagemap-test device into the
next test and the second run fails on the name clash in
device_bind_driver().

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -0,0 +1,645 @@
> +static int imagemap_test_ubiblock(struct unit_test_state *uts)

...
> +     /* Attach UBI by name; this binds the ubi_blk block device */
> +     ut_assertok(ubi_part("nand2", NULL));
> +     ut_assertok(ubi_create_vol("vol0", 0x10000, true, UBI_VOL_NUM_AUTO,
> +                                false));

There is no matching detach, so a second run of the suite (or another
UBI-touching test afterwards) sees UBI already attached to nand2 with
vol0 present, and ubi_part()/ubi_create_vol() will fail. Please detach
UBI at the end (and ideally guard against the pre-attached case at the
start) so the test is re-runnable.

Regards,
Simon
