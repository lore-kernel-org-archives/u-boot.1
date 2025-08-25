Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD68C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 18:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6165B82DA1;
	Mon, 25 Aug 2025 20:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fzzi0Lsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4930283020; Mon, 25 Aug 2025 20:49:51 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7B382C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 20:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61c38da68ddso5254629a12.2
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756147788; x=1756752588; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MXFhFby4JZ6rzfkFVF3kldklqgQAOqYRk4GAhSpdo34=;
 b=Fzzi0Lsa2bJCBB8fniJqpPRdhiQbhrP7uROkcWkacxh00L4+QBkhPCHYPDNuMraAKQ
 nx8lg9MAt0Q/OXm6y+oY8CthKHizeFYK7stcMP0w8Wnr8/B6jQx3djccv/Dthf36Q8Ci
 thWTp+XgDsD/19ikCuW/gv9cOivT4+pxbxJXO03IYDDbH3MKygalC2EoJ7LhlTjKqVAR
 Z9elkmuxS57tiCMGanlddQKHpZV95Bni5QApvBNcXEFQ6c9Rnb1IJ7LhGks2SlWxnbo1
 pR02Y6rwpqm3BV9ZmVgoG8V0jRYB98KmNewuTKklTZigySagD1qiXupvSNvVqUZmIq1u
 y71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756147788; x=1756752588;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MXFhFby4JZ6rzfkFVF3kldklqgQAOqYRk4GAhSpdo34=;
 b=oaCusw7daS+vrFlMCyAe33FPBxmW2qFvNDmkbdnw1z4o4GWoJcRStLEeZ4NWrjzi9P
 dDL1M74VAYELcIMjPauMp+g1YxytNuKyKQvnMmpZ0laDm3fqVry/rpifEfYZ6dkUc0lG
 xxC9KQ/pDxzCVBMLKwdFln4eZIEJPpwV4sr7myuHn/eB0GKHPQ4bOu/GGQcA9yD6YhW4
 xjm8ZOjriaP0dNfpPZBQ7Vfq0sHZmsoOYSqhdJVz9sCbfSet/Is0gfwZY9rUM9CmePLj
 kyIbFuuh9SG/KCPxobxoCOYgj1gk5sR46A1JkCd8lZ1zCtl9jGaQ904pU7sO8AA3DXec
 my/A==
X-Gm-Message-State: AOJu0YwgJLrwxjMk9yxo9BlQDmPr9921+CEZTVtzk6dYGPsoBnM3pcXI
 Zj60AymkvAGuDc5mb/jT9tx0Qe0hc6EoV8XDjVA7VGJuCbo2iQrPzoxmUaA1Xye6kLFtV5plCLF
 pr0H89fuxuZj5N6JLWek64U24WRDBxAfSvsw1
X-Gm-Gg: ASbGnctAJ+djF7ionjRq6dg5f6A285w/HZx7Ed1HBCMdtAuAaTOv45JYlDk1JYqtsHE
 xTnBtL8pMNMbx0lrY+nYixaJikfmBcR/YP5Gx5BF6qqlRtiVQEwjaKwZshwNQui7DH1Irz4lrrm
 y4UV81mWrVn7CDbI/VDDuzGLBeUMKn1C2fzi6r21XuErpVbiq2aZydalGi8iz9ZyBx07udPs9cR
 u8x9TzE
X-Google-Smtp-Source: AGHT+IFk6//h2+ZpoVN/3NBhtXCtIo1GO6iOE86VckCFyh8BhvrEeeYtC+ajr5PMizMHGC3dYjmJHGsXoWWX8h+1L0o=
X-Received: by 2002:a05:6402:2353:b0:61c:793e:9f07 with SMTP id
 4fb4d7f45d1cf-61c793ea749mr2431865a12.6.1756147788215; Mon, 25 Aug 2025
 11:49:48 -0700 (PDT)
MIME-Version: 1.0
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 25 Aug 2025 11:49:35 -0700
X-Gm-Features: Ac12FXyAkjNw6T0xaXluVDJjXbJ2irCGRNrVp-v_ML91c79vW_yItGvY2r-oPt4
Message-ID: <CAJaLiFwxjWPg+SQ4VVO7Oay4OX-WcCTmNa7FPHCYW6JLQmd9Uw@mail.gmail.com>
Subject: tools: patman cannot find aiohttp module
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

I've just done a git pull on the master branch. And then ran patman
and got this error.

./tools/patman/patman  -c1 -s2 send -n
Traceback (most recent call last):
  File "/usr/src/u-boot-marvell/./tools/patman/patman", line 21, in <module>
    from patman import control
  File "/usr/src/u-boot-marvell/tools/patman/../patman/control.py",
line 24, in <module>
    from patman import cseries
  File "/usr/src/u-boot-marvell/tools/patman/../patman/cseries.py",
line 19, in <module>
    from patman import cser_helper
  File "/usr/src/u-boot-marvell/tools/patman/../patman/cser_helper.py",
line 18, in <module>
    import aiohttp
ModuleNotFoundError: No module named 'aiohttp'

I'm on Debian 12.11 and have Python 3.11.2. Is there something I might
be missing?

Thanks,
Tony
