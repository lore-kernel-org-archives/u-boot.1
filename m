Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1B9ECE577
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 19:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E7C88DC6;
	Mon,  9 Sep 2024 21:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VshYTs2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A9388E15; Mon,  9 Sep 2024 21:11:38 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF99588D08
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 21:11:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f7529203ddso32138721fa.0
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725909096; x=1726513896; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=haTJCk00ZcLSdRWdOwNLw8LpXGMRtGcJ5YzgUpk21u0=;
 b=VshYTs2DFBdfMwk0hyz08k3VFLoUhUPFG2TAyvmSI/leU6qlK/+HswZygg4U0CLprA
 Y7IRfpUdaKXyH+uxgnCdHui9ZDhmHBF2QGx5wGnYhiz38zfM2mTwI9Ap12tM2H5EEjxg
 RECeD4h7gai4q6/fLNBkUKXE7+i8bLyCqUJ8YN1+v7Lyri/7IDheOO4zz6JtLSVJ5S6k
 6+/BAA/Z2gVxX+gVRN6wXpC0KM2MF5berUEHGzqdWO8pvtZtloruwwCDOsEQuU0mF6Aw
 vpoORmWjZywdN5jY5XTH/IQG67j69ioQBPCCtTpiTstMNlDjHwdUjT5RCCZRaBTjRWYy
 VSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725909096; x=1726513896;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=haTJCk00ZcLSdRWdOwNLw8LpXGMRtGcJ5YzgUpk21u0=;
 b=kogjyKl33cG6vmQecMROcAkA8aJEpj08Qr3AN9/CgWiPsd6AyC8G/mswdxKQGn2ScL
 5pdsT5N363RMCrPCQQgelIx0D9454rirATTyHMdEtnnBEV8Fpzq83Xyp64jbjVqKt5dI
 4wfeq7CTG2lRNOJAYbtQolE9VUL/23lVSsn6WibHjJC9jOr2a5IThn/2v+Kiu7Ih5hGd
 pxmMJ8X/dQPHbg2vsnE1zfmMj3WFum+h/o1xSk+7wI+BLYmLiT8eBt5dmpAhbqu6hEqN
 F6CL4zLpBOqwnCh5789zgLXT8Py6T/MXoqH6fjkpGGTUBH3az1PUlMY4vFEGrT0sG6cu
 MU+Q==
X-Gm-Message-State: AOJu0Yxduqobl9UYrcadiwy54xFF1JLToDgUcoHrT6eWHgqZJtqv4mMY
 jorc2/cvfia0oLBnCi414C6j8LaN47jkTq5hgvZZ7Cbf4S0CqcGl4Xn7w22F4byoZpq94K2MXD4
 9dYiWGl7y603kdCgM5PETN+tF67YbJ10y
X-Google-Smtp-Source: AGHT+IGpbmqZ33AD1FaU3loN+HjexgYRyg6bozS9VvfzT4zd1VtjSFr+aaRe6isKRGh93Q5IAqO8Y2MumK0nCpSfcM4=
X-Received: by 2002:a2e:9d16:0:b0:2f3:f287:17df with SMTP id
 38308e7fff4ca-2f77270d09fmr1919121fa.20.1725909095391; Mon, 09 Sep 2024
 12:11:35 -0700 (PDT)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Sep 2024 16:11:23 -0300
Message-ID: <CAOMZO5DT5-dtAF1cDbga3vjtk1UakQin1XboPyjmG=-h3-808g@mail.gmail.com>
Subject: imx8mq_evk: Boot regression
To: Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Otavio Salvador <otavio@ossystems.com.br>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

imx8mq-evk fails to boot with top of tree U-Boot:

U-Boot SPL 2024.10-rc4 (Sep 09 2024 - 16:08:22 -0300)
PMIC:  PFUZE100 ID=0x10
SEC0:  RNG instantiated
Normal Boot
Trying to boot from MMC2

I ran git bisect and the first bad commit was:

commit 37e50627efacd8dae18b564e9d8886a033e181bc
Author: Marek Vasut <marex@denx.de>
Date:   Fri Apr 26 01:00:37 2024 +0200

    ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman

    Rework the flash.bin image generation such that it uses the new binman
    nxp_imx8mimage etype. This way, the flash.bin is assembled in correct
    order using plain binman, without any workarounds or sections assembled
    in special DT node order.

    Reviewed-By: Tim Harvey <tharvey@gateworks.com>
    Tested-By: Tim Harvey <tharvey@gateworks.com> # imx8mm_venice
    Tested-by: Fabio Estevam <festevam@gmail.com> # imx8mm-evk and imx8mn-evk
    Signed-off-by: Marek Vasut <marex@denx.de>

It seems that that binman conversion for imx8mq has issues.

Does anyone have any suggestions?

Thanks,

Fabio Estevam
