Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67C3CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C6984935;
	Wed, 27 May 2026 03:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BQCIi4aO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB648493E; Wed, 27 May 2026 03:17:48 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6CE84935
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd8f6ef4ba6so1681725466b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844666; cv=none;
 d=google.com; s=arc-20240605;
 b=PIyQotjpFldJYYRdQAsCxrWyrhBdhBEo8KGQPSSQcAM5vkCrPa0kkrJ5R+7I5N0Xuw
 H1LpVfkQeBs3Dqy5BUkSre3Us/mRaidzD1DyoD/V+Vw/5ymoiCtc1RilPWL1ulDOA/XY
 yieBS07qbM0GbLKkpbt7e17lKz2fBORxq5KNSfhzpPEq/f162EfTfZLhs9SKGiq0LpMt
 mwh19gvklv3uIYYFdztNQltlHSTjJ+pVv1kmD1FIHSwTXzbjXmavI9CahP2Sq5hgtI9Z
 7lwTXFSyl/owLXJrIC/1BrYmzaYdppHWy+x3WEWCqIjCi92d851tjfixlmZDmcaVxZSe
 b1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AfkGIvZrE0yk1bGfXvm0erM7GZJbOoj9ctkx92CQvjk=;
 fh=7HzJ9BBBx4iZa4XdRLXOksY74UmWuqL7h1CjcfaRqlM=;
 b=dAxyKO0MHS67O1YhnRLxd4qaUh3GasYiXV1VivuxaNum7dvGBWML8rqwRSwisrdHsT
 ei1gfsARNTKfuUwI3gsY1FyOukXnc5bhjNz+RMqELcO+XbRME//lVWgQa3XGDUmHXxin
 Z6HXSVgBvdeciaA6INqeL+eqmNgpxpj3LJ+iRnrvSSql0v0qon0mgMO8jb4IQqaPYPKe
 pyDjIkmoPFT8m8f/0F4LbdwmLtL9g0ucyca/VL3AvRLRT/MHDkaMY786r9DIcZKQI4Z2
 kuAqz+I0zJmSC+oSpGMH6zn6Lt0gygTYdhithxnE/+11yhEsNgSMyf+lI5ILSRQS9h+M
 3sNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844666; x=1780449466; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AfkGIvZrE0yk1bGfXvm0erM7GZJbOoj9ctkx92CQvjk=;
 b=BQCIi4aOnP+Q83mNY8eTwXAcfOMkeueCs1TR9P/9SdWZCvpG9ZjAXnmsDitD0AXL0C
 RKiz7tng3hCTnznrQA1mRg7ZhTjrIb3/he0K8WluUjqxJs/qt9SiwrmnY3Ud+ng78v0u
 Fo/LnmQG+OwZ55bX2k4iYlXdw4s888AGFq1Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844666; x=1780449466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfkGIvZrE0yk1bGfXvm0erM7GZJbOoj9ctkx92CQvjk=;
 b=PUPuch214VEQaHxzoorKOKtGImLFqeacHTgzheJNnMFaoXuCBA/Orwr2fzTvoJJ7P/
 TsBKsjpSFGZ8ZCw2uqMPMZJpdQMA5ko5tO6VWqJs3SP7Mx7i8R30JsSqKnbLsPWR4Z4r
 NT3LgmFr5bAHNzrGBBIGT+rOwDmETxyjcxTCwg0QHUQopL/uznJH+XXgpAcs6bIv8fI0
 UdZkhTc4zAJUI29eOOsIH2IbNNpwjgoOh/b3eH1ijuQCi/Ld0s3IolU9qkigYeP8qU6C
 /CpQ6fWWDKkDQyq2KaVN5bP3vpJUgEU2ub0R8wAPRSzEhF+Lkb5qUHygxo+MWwQd/2Nv
 XvqA==
X-Gm-Message-State: AOJu0Yz52HZkJjvzrH/Of98FJnQBU1uhhVFW6oVjFBITfR0qSsGY3JqN
 nTtRCRlzFCRKJIHTKazvXiRUCxIR7ku2K97k4l9I39jHjKUKKRCwUzE9qAbJV27/8ZHqLnsBkKX
 bPq0zPIziyrsozb7o1dr7tvT5fTZHHuTjjmfFG+BW
X-Gm-Gg: Acq92OE47f3iACaP+N39xG4ZSeRB7B6xCLIodDMYc6NOu/rR8wL0PiB05VTmDnvyjMq
 02iY6jXZX9EncYqwYo5EkPaeQdAzzU4DoLdriMmeTnBnacP3O58dvhEXOlVtSW+7wEY1c/CuLfD
 y7c/Uo5y6QQzemuw3MuBv4yusBiGAdmzib1yBRmlx5OfULSxeh4OPVb12qh4oydmj17VDBXN4nY
 53q3N+00M2eQesTI+aq5haC0anbKftDNeVogu2c51C4MSss1v8+79AJEZ0Zs+opsTa9Dwm63Md/
 B6nWDvb+HqoS2YtG
X-Received: by 2002:a17:906:844b:b0:bd5:2e64:afba with SMTP id
 a640c23a62f3a-bdd2580be79mr960062266b.29.1779844666638; Tue, 26 May 2026
 18:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-4-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-4-be3597b85b5e@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:17:20 -0500
X-Gm-Features: AVHnY4LkOlfPhhTKDNGHmC0w5TnqDzSXl9yUMQmVUUmxVKcdXdMaA8-0fiHYE7U
Message-ID: <CAFLszThtiwRXNn524aEcEF4cqUKFpe3nqgH_J2FQNYP99XJjEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] net: dc2114x: Use dev_remap_addr()
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
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

On 2026-05-26T07:25:09, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> net: dc2114x: Use dev_remap_addr()
>
> Use dev_remap_addr() to simplify code.
>
> dev_remap_addr() does same thing as dev_read_addr() + map_physmem(). And
> it supports both live device tree and flat DT backends, avoiding direct
> dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/net/dc2114x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
