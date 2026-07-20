Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A022CC44527
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 10:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97223838D7;
	Mon, 20 Jul 2026 12:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="MV79hdRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE87E83E76; Mon, 20 Jul 2026 12:42:16 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C037080517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 12:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-39c7ce122c7so87856031fa.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 03:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784544133; cv=none;
 d=google.com; s=arc-20260327;
 b=seiiDCoUlHLW5V4ya7HooDbJedeGSvkuSZgL0KBZ9LNRb/Eax5mr8TpF6sxHnCHLgC
 DROtaP5+8lYZbvqqFdJsecCchk3cENq+QOzdU035wLaCo2yWoiEWbzQ8SsyjkUAetpEv
 N6W5jILzTluZSwHrmcG9321siAGCEsZfqAY9tKC2kpMspe90oK5rsKF+294Bw7zf7Y2k
 xnUiSYik8/7ZrvY82f2r7iPWdmTvPFjc445QBL8PLNYSrmAqHPjj3ZSwXzOz7evutymZ
 aTdbmY1ZrdlUZ4NLVVYyMHtIqNiN5jrhW4P3lWXSHNlzFJJl1Qua8dKnutKOlLpwoBYg
 cBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uZDLfjoHFNc6RbnIoIIqcmlWhEWhB0d2pw9DZyIO1Ng=;
 fh=6UBnUKz9/L83auj29GqmCSZtIe9E5G5He9Oni5g29Rk=;
 b=LASEn87MfBo/4R0Yo6pAmPDrG8VN0+VPT7XhW6PikLCATmBNdCsJvaz2bpnUIjUnlQ
 vjbvawyJJV+uTlKWo923o+f+fTmqf7boQEyAIN04OfYGIFM8W9e9TemxMJrDWvCqrIJ4
 gnAXwglFfRe9jraZqzgAaMeXk1l3xgzyNXkCzvQNhBA2JtJ3Kl1XbXgdoXJCAdASDkyN
 FkMVpyjjh5imbcb8Gia0AQeHfImfuM/v7tq5bvCI7UABmTnpVXMmJhY9aG1tIElF3B1z
 b9znyPrn6u/QE6J0bQYdt/NzW/k4rEw2MJZ08D3g9fdHDSXhByNC2xdGzXHF8CKVcQdu
 VZFA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784544133; x=1785148933;
 darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uZDLfjoHFNc6RbnIoIIqcmlWhEWhB0d2pw9DZyIO1Ng=;
 b=MV79hdRyoizBjlQLfojO+O3JZX3RaevXT0Mi3gDMdIIjka1U14GvJDY0ADH5DCa4FP
 tRX6f6OZlYEKoz6vf3b3zkk5XK6wCWtcZxG/zT5Rtu3d0bhvWrawNz7I/Ju27XTKoVQ5
 Va0vEWEtlEP0M2+p2jHTSrfBN4OYwPIfmGUowCufFkn7iVxpD3P+X2ihSQwejGwXxm/6
 8EouwTT9epWWs/f5UM+1tFvwPV8mHbe+/JJ8iIiaD4MEoaPGwt4Bjqbimp1Seo4iTNAe
 SZj5ELx584fTGgmw37ELeTuE0S1W2UYTZ38fqiiVg4Qlt2P/cq30Lynqgxw57p+hYiro
 Km7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784544133; x=1785148933;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uZDLfjoHFNc6RbnIoIIqcmlWhEWhB0d2pw9DZyIO1Ng=;
 b=nXiOT6FGFBCvhBgI4pcjk5McIjelSnR8iicp6kwmulmUR0w1NJdHpfLpSKwpfkW7se
 g/f9axID3ToLqD02Tf6pRUr2/8SCptMp38QjA1vx4Z7t0nFGqB0Lq/V/JV+HECosuWT+
 r0+qPybNmwtjhDfRgRM9xgTyML761kKGhdrNMzAaWHcMBotYvtk24YSM+Fh+zoDSWFBS
 +buHg2JNJPVrrXhAD7BEdUv7HSxS4gO+7ycErg2oqHAoCCeb11oA4uknS4wBbJ9WtPpR
 7jvU7ESMsbfWH4tSYnECvewz3kQS1m21NgMZto3JHu5O25cXMIFGNR4ybbmFbQk5ORxK
 +/1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RohGgfzt183h00GhPwFjbKB+IwlysHiTRamS9SyYMGPzmjOXyvQ6gJDeuRMADScGY6HPYHNYK0=@lists.denx.de
X-Gm-Message-State: AOJu0YzICiWzjTmGBUrmYp+jcr4wP/o++5xOReV+qOlx7aAmg986s+b2
 XofK7mHWwRKg3ws7f9NySfq4mMdTkw7/MM9vSGH5NVEtsUJ8OTwiCH5gqCu8IF0r5twFItpFGpv
 4grP5lGVkI3v93z5SCtYZz9jLvQYrM3vjmeXWBpVHyQ==
X-Gm-Gg: AfdE7cne2jtSRuZytUeDcCvoa+NlahkdULPZFpN60p5sTvJ+m3yPIpmNrtGgB5AO+5d
 PgPB6lD6UvKwiOOnr0Fx2yfK3urhIpdOmjj1t25H1LmKl8xCs1jYce3bdWixXijrVamYSHVD83E
 zzdGIR30LZxr5+jWMFiXtcDo4e8D+OLHgWZKPH0zbHKh3ybUIXoBXAwBUWhjXRcG2vyWEY7Z2Gf
 /ilRwqzG4yVUO2f900BaOA558Lq346P6yBNXM2Z7Mx+22UsEKs2byVvSgzp9H8D2bry8NQfiPGl
 DpsyL5rm11X2A3G9+Wd22aLDaoTgdxc2qz7FKzfY+bZLR348s58yz1nDC+OxOeY17b3Jqs1zhez
 okeuM9EFi2fFh58KBdSU=
X-Received: by 2002:a05:6512:3d22:b0:5ae:bec7:8b73 with SMTP id
 2adb3069b0e04-5b28facc8c2mr2956452e87.57.1784544132887; Mon, 20 Jul 2026
 03:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-3-dbd01185f911@riscstar.com> <al0Fk8JyfYhu5b9y@pie>
In-Reply-To: <al0Fk8JyfYhu5b9y@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 20 Jul 2026 18:42:00 +0800
X-Gm-Features: AUfX_myYCoe44MtGFaT9rNePb10OKWC2mNlZJmR_tJcgNI7zpYGMvjMncQaDHcY
Message-ID: <CAH22mJyDMK1-TyaZierfaF88NtgVvKF2Ac3yARBVcgobGQO0-w@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] mmc: enable CMD23 for multi-block transfers
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
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

On Mon, Jul 20, 2026 at 1:13=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
>
> On Tue, Jul 07, 2026 at 11:21:44PM +0800, Eric Chung wrote:
> > Enable the support for the CMD23 (SET_BLOCK_COUNT) command to
> > manage multi-block read/write operations. This allows the MMC
> > core to use CMD23 in preference to the legacy CMD18/CMD25 plus
> > CMD12 sequence, reducing command overhead and improving I/O
> > performance on multi-block transfers.
>
> From the description, it seems CMD23 support isn't essential for MMC
> support on SpacemiT K1? If so, it might be helpful to separate MMC
> core changes into another series, and focus on basic support only. A
> smaller series is easier to track and review.
>
Actually CMD23 is necessary for Spacemit K1. So I can't split it from
this series.

Best Regards
Haojian
