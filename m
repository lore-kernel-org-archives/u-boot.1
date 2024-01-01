Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666ADC4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EB887705;
	Mon,  1 Jan 2024 17:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JI4EcQSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107E68779D; Mon,  1 Jan 2024 17:49:25 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61F987076
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78104f6f692so669946485a.1
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127761; x=1704732561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eYm9t4uhD2ntzp4Ep7ZFAzW15itl9wwNHoKvHkaTfl4=;
 b=JI4EcQSY/z7CTHl333nO4NgGxgHBhd8nsJ6s0HBpFSClhl56sNxoWIeM+19jyEGdNM
 GGHIFDLm/hRKi4MEgPhp9N933QwG4P7F2cB4pg/9yVKpOGdv/4IG7SxEgehVgDO8u1s1
 /3wYdQ4dW3Xa5+7FU9gsYS4fUrMXYgtq53Nqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127761; x=1704732561;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYm9t4uhD2ntzp4Ep7ZFAzW15itl9wwNHoKvHkaTfl4=;
 b=POMaZDDsjPuzlQhZ6sTJh2S7hOC+pF9XowXT5WE+q8xznCLd2h7ckVXgz3N5+xu+hm
 i7Dvx3VM5Z30sl9oJPm2hFsSSUTPDVFYK18+q4JTZ9tQwRyjD7w5OpBNoGKLmfx6iUl7
 TiHCJS2/IMFQP91ru5Kb0xffBfNVYInte/ypqJK7hhqAhjciB4sHPl4azej00gBhLoOl
 3ccV7EhmuVGiTgk7tiYkSwuBKrBJgJ5GUxnZJYnqPZY+bMyWeTczLZu9bo0CsadXMZVs
 qNu5qaVOyYOygCxQcSyPo4PnYDANWnC95IXma1eXQwxCINVCyG0R5wHRQiboUHhg/jtz
 uu/Q==
X-Gm-Message-State: AOJu0YyLVRQN9a3brL1kC4ioyyhFG5LykZT2Q7U67yz8GgYR8dcjt+R7
 zee2kn+Cea+uY7j0sLQ7rVd6ZKRCtmyxzGjiu2r+of2seAjt
X-Google-Smtp-Source: AGHT+IHJBQiVQWTNo4YpZvnkB41twVKdGZUVlIqKLXWs7N6fWaKX6BjxGRtz6ti+zIUUog1IvSzmnGB2TxJCzrwnG7A=
X-Received: by 2002:a05:620a:8429:b0:77f:ab06:b896 with SMTP id
 pc41-20020a05620a842900b0077fab06b896mr22111730qkn.29.1704127761470; Mon, 01
 Jan 2024 08:49:21 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:21 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-10-sjg@chromium.org>
References: <20231217163627.2339802-10-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:21 -0500
X-Google-Sender-Auth: _MvWdWBUfqeOmfbuGWBS7wtBalY
Message-ID: <CAFLszTiGtVYPj6hb=0cDiTafRB3VdePS0-Rj8BVpKC9dRz=wjw@mail.gmail.com>
Subject: Re: [PATCH 09/10] fdtgrep: Allow propagating properties up to
 supernodes
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The existing bootph binding is defined such that properties in a
subnode are also implied in the supernode also, as in this example:

   buttons {
      /* bootph,pre-ram is implied by btn1 */
      compatible = "gpio-keys";

      btn1 {
         bootph,pre-ram;
         gpios = <&gpio_a 3 0>;
         label = "button1";
         linux,code = <BTN_1>;
      };

Provide an option to implement this in fdtgrep.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
