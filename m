Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC039D65C7F
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 02:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094D883B55;
	Thu, 18 Dec 2025 03:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MZu7nzuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 017CE83C28; Thu, 18 Dec 2025 03:21:24 +0100 (CET)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F184983B49
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 03:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6446704997cso112679d50.2
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 18:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766024480; x=1766629280; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=57bmm3HCB6Qns0A+WHU/b496bZub2SWCX6eexs9/m4Q=;
 b=MZu7nzuXx1Xl25gZTVcvJOqeRHuKtcTzoo6MAkAFdBUiUKwNq1rHpQq2DE67R4SlRl
 d9bMOjOJZeFIht602C44isbQeAIkRRR6KdktcGfm4XnsazVThgutBkltsQM+TB/+01jx
 wPJoHtvpppBtTFTmxkcHJ/7E6W2F/Zus4jqG3xKcjEb/cxsoKOSVboIo+swK+DmmVmuJ
 B9ufmSEz41/PaoWcufUXmfgqT3qssGPzHXkJ8zxxkq81j3MDw+Gwjz6ziPnuAQQ28wM2
 ePAqjuARa7tMQ4XKjTUouGrvF53kWlWSAGF254yxGxHg9ho0H+7veVf5srwyZaODIrVM
 rvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766024480; x=1766629280;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=57bmm3HCB6Qns0A+WHU/b496bZub2SWCX6eexs9/m4Q=;
 b=GdeO9m3GinVpFKLLy0H8nkqe+JS9VjOI+K0mjtyhFzhXWJdw4OIlpAgTz8BEcTYNVl
 3fhEjQNsNwp/iGQEDDXZwxP1X1O+IbuxvcQ5HHJgOSOQcm0a0p3/OXCxNV6BVJXYjDsw
 EBMvdY/kBqwk+g0wbNO30h+cBrigSgE3+1HBUYarE785Oq/6vifEEgigi2qMd0VY/oxI
 YWXXfkCIQhoCCo+/0eZo2MPhJalRbTwn54cSCCHhMuZIGiWzh2EfMkklTW59eSPpAEw/
 32/DxucehKxaHIr27GZkIznGtDPY7k+N1MVwqrAjrwG54htiEHO71FXsgVkHcLAB2WoN
 nC7g==
X-Gm-Message-State: AOJu0Yyo7dfQvVDUehYvlYAwQqkPAinsXUlSHhZMRXknZ4GnP+u43Yjq
 INsYnEq/8BxZm9CkgSasHaMbYFE14tkZOP87lsnSqQ+ZBXwakGRmgxTYZhHa64JbHeh64Xh1JYn
 nqNTxlmuVBQIAFmgbKww0/Xu5P38QdBtk872rHYk=
X-Gm-Gg: AY/fxX61umlNaQS6oTMhfeLB8J6M/TyO2WBbxPk9q4TjwLpTc6s+LQO9KlSlKfomYM+
 KCB3X9H85VVuMf4p5VwToEXVMuFmCugmpBbu+peWX5f5VIa08TRSxrqUWA5TPParR3EwN5cor/y
 cFSte06fiLvTPl0lJlGbgHWnQGNIsft7CZwtdGESeSJ5RD3EABle+3sfN9xlYQmbokA7DByiA6m
 iyhgxYrGhWs4sCU+cmDkxFw/8WjyyTZOg+D7UYa4pMf7q0Ig6Mzjzy7rt7VlQF6o7cucQ==
X-Google-Smtp-Source: AGHT+IFpapkUFbW07nLoG27MfeHLY28TP4dVEzYPzUf89evwXPBUi60Wa/S8yaLbX+dV5cvjTPuhmddeYdPtmo38s20=
X-Received: by 2002:a05:690e:4093:b0:644:28bb:fb53 with SMTP id
 956f58d0204a3-64555664cb0mr14681640d50.66.1766024480499; Wed, 17 Dec 2025
 18:21:20 -0800 (PST)
MIME-Version: 1.0
From: Chris Packham <judge.packham@gmail.com>
Date: Thu, 18 Dec 2025 15:21:09 +1300
X-Gm-Features: AQt7F2pED-64n5b3jHgBXZewMmFLPU-gTG5KnB_sGJDu5gkevTuyoHveHovqpEk
Message-ID: <CAFOYHZBuWrLk4LfDa2dysvdHUMH7ziDicA9a+usPaYQnKc1O2A@mail.gmail.com>
Subject: mtd: nand: pxa3xx: Null de-references with dev_err()
To: u-boot <u-boot@lists.denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>
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

Hi All,

Sorry this isn't a patch but I've just stumbled across a problem and
I'm not sure how to deal with it.

In commit 661c98121d49 ("mtd: nand: pxa3xx: Fix not calling dev_xxx
with a device") Sean updated some code to pass a valid device to
dev_err(). Most of the places had a struct mtd_info * with an
appropriate member. A few didn't and Sean used
info->controller.active->mtd.dev instead but it looks like
controller.active is only assigned via panic_nand_get_device() which
I'm not sure is ever actually called in u-boot. Being that the
offending calls are only in error cases I'm guessing no-one else has
stumbled across them.

I'm a little unsure what to do here. Some of the uses of
info->controller.active->mtd.dev are close enough to a struct mtd_info
* that I can just pass that in. But others are buried deep and it
would be quite invasive to add. I could add a dev member to struct
pxa3xx_nand_info. Or just change the dev_err to pr_err instead.

Any preference?
