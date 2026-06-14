Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B4FCD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 11:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC49084704;
	Sun, 14 Jun 2026 13:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BOCcVY/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F54800AE; Sun, 14 Jun 2026 13:51:08 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B647848B0
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so4393529a12.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 04:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437864; cv=none;
 d=google.com; s=arc-20240605;
 b=MAXh7b6R1O5a8SPQ15BNCsm5tTrschmJ7TDzKY9yRCcBl1izZE6rbvBBGfW6lXXK2+
 FErKzJhY+mpn8Bm2WKsY27JwbceHqhKmh6bvx2joH55ccMsymEcTDJij6vL0sVkGf/zo
 mFijJVRXOJGCX+/C81AQxhIBE8pBCqmzs55DjL/4xMuJWQ/sua/io/J4eQyRwHA6o70h
 JQ+mb6nw0IQCIrXqF6oLspIHpkgnI2gHiP4Pss2kXvJiIrD3vWmHODDIWIEctovxkuqm
 7BDhDurX3SjAeFWHQZudJrMShHnytKaUJbmg8gRQd7UJfHPmVSyBt75aOzd53nxuW3NN
 oYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lJZmUYk9jKrty+MrJUUzVhJwx4u2lujATK4nIYYURy4=;
 fh=BwvpJUFKz2lIY0poKDaPH6FInvB0TyF36I1HHCUz8SE=;
 b=D2Hf/HWRqQk3UQK7zlRkwwJSwvC64Hnwh5v2jl1v3m0pGD5unRpyavlieuf6/LNyIx
 OaHyZOjpCaBYL4sA0dn6cLlO7n7J5sD3RCmaS2jwJei45S96KDXWy2k09DxWIrnaCrdp
 TGsMei6UqPPs+GSRxRppXeB8GVhrqAHaFHIcaI0fauIIhhdleBeGA8XspxVWq9exkYy+
 IJscM2/hzpwQ2xk+1G9danDCqdpPl6edvipRw9r8GB1GKOvJmb4Vsfcywctu/6qVK40K
 6/hBOpvUe4GQ7na2RAqh9snDYNYJGcBdJ2rpnXdD9lHK5ZfivAhz/7rgHQFoeyRWk+C9
 nyYA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781437864; x=1782042664; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lJZmUYk9jKrty+MrJUUzVhJwx4u2lujATK4nIYYURy4=;
 b=BOCcVY/Em2k5u4GGTj0QtNfVH6XFcMhJ5a95cYkwnk4DDil9HjrsVDBtwIgWBl4yRq
 WDy03Fb0UU22SVUuvU6fod4YvqOH/BMiZDGBfWnKv7mU2C9WL/433FO9Dtm0SHylEXAX
 4zJEvVed46aZBA97ozu3UiGyt5X46aKraI0hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781437864; x=1782042664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJZmUYk9jKrty+MrJUUzVhJwx4u2lujATK4nIYYURy4=;
 b=LkFI5yLqDiNWAnbUapDlpAanN83/gvDOX78pHsK7MQQq3lgwpaHC2SM3+thA8P0f8k
 IPRmaSuUy4AFrZGAP3dWm7az9bjodujhxUaphhJcV+vDuYN9GTJFuB0BAZo5IQRnrku9
 TF7P1TA84C44s/cSSJqczpHYyUyX8wjgmUNVdUt/Di/35KnXHPNdkE8+p7nWnQOI+nsJ
 3IDxiv/GxO+GS7KVkkHquSi/BuMu75xtuBJ4/rfBZ9m12OU1tbbvbESvhnM1pRx6AwPa
 yfYxeHAuIozW9pApgjBk8ubWIQLzRZPC/DUZvW70t6egVfUXS+3jMaTY6t5yudIVpyYr
 taOQ==
X-Gm-Message-State: AOJu0YxqBDQUOujweBE8o7cTH06tHSC6wvCap/NEImu5QY7dFrz/sui/
 Oa7k5vVxFbLfDpqcW+0RPhC8LBVB2Zzotqf6PCSbyUKxUMHxdp01FJvDg4XaN4G1M/kMKNs/PYd
 wVOfbsQQwO6rk2YCCxh11bSzGAnKoMYZ8oAoUblAS
X-Gm-Gg: Acq92OHvsP7JNhRBdZ6ltMkx+A3XYMVy2sN5bC8nB0Ep5f8QGlz+LcpavB+QR9KoE/J
 /2xv+Uj5ZfYdg6/aGylaNVFVwam8J6n02qaLcp3uRNpWczepwT4aTuCcU9aX7v3N9kAJd+MOPMd
 WKWSV7vLDRn84MHAr0yi6bNirbO1isxay9TkN+dGXAdFBGlUFFoF4PoleH6o72k4n3YcxhEIpoc
 VHStvb8hrMzXVCLz+Ab7aZA8uqOwDZAxvLHGBZGbMLpo/CArsYeHZvg7miMyeLsFOVNbPJE+Zqx
 Ft+OSQNjBSIh7vGC
X-Received: by 2002:a05:6402:268b:b0:691:5f30:37ec with SMTP id
 4fb4d7f45d1cf-693c6a8cf66mr2390664a12.25.1781437864456; Sun, 14 Jun 2026
 04:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
 <20260602-fastboot-abort-keyed-v1-2-414aac5a06b8@samcday.com>
In-Reply-To: <20260602-fastboot-abort-keyed-v1-2-414aac5a06b8@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 05:50:49 -0600
X-Gm-Features: AVVi8CeU-zl5QYY7jqWcHwLlzbIowkHJKrJjeBBtqQJlULdjqxOwbWdMYNLCS00
Message-ID: <CAFLszTgC_j8vb96cUdKYrpR=JzkxJygmNsW-8R35YBF9fggVvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] board: qualcomm: phone: enable
 CMD_FASTBOOT_ABORT_KEYED
To: me@samcday.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On 2026-06-02T08:45:46, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED
>
> Thus users are able to exit from fastboot by pressing a key.
>
> It's also possible to bail out by running fastboot continue from the
> host, but it's nice to be consistent with UMS. Also convenient to be
> able to bailout during testing if USB isn't working properly.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> board/qualcomm/qcom-phone.config | 1 +
>  board/qualcomm/qcom-phone.env    | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
