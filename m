Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE49C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E15086A1C;
	Tue, 15 Aug 2023 00:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BKwairCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C3586A26; Tue, 15 Aug 2023 00:43:50 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00AAF869D0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d35a9d7a5bdso4739608276.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9/NrudismA3K/0rIIzm4UjedOZ29BV274KjAemrXRlo=;
 b=BKwairCDDoe69rKtx6QkNZGg20c5gp2RZK4JDFTOoSnsYkDKGxE1m/JjklQOme54wq
 JgNRxOw4zR59aPbo05g7fZfYlOF6fnpfPw5MDHwJOuHzayQdrLYJP6q2aCekFCdc0o8v
 vAkTmL9Ly4plwuSZE2dX1PnhG4EpO1spoMXNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9/NrudismA3K/0rIIzm4UjedOZ29BV274KjAemrXRlo=;
 b=lPe4Y6VLFsNwOmNiJAEinn3pCdcZedYqPUj+Q1YDzUA4Y+AO940BYxnzLRyYswcsKQ
 ptZaSPzm+NDNyz+w5r0ReQP5yjX+SZiI7nOdIdhbzlVhDaAYGsgZF3RgW3gssmrC7ISO
 BR6pXwzjYgp7jp8O8bSbJeHQD84HyUMt8k2Wifowx03e6Itqq8l+8tph2ulwhgXQmvyX
 fnHT2V46RkCXjMjv//LHBkcNmpXNerzRjepGjIAcKDrhkpl6O9Ictr3krkWC/Vf0TgFJ
 Gc+/oCpNgrtOY16jfunllpyrMvhiBmmleldcCYlu03MjsiU6DddD9EuCf0Q4Mlce5Xrz
 FZGg==
X-Gm-Message-State: AOJu0YxhmcDQXtgH50LObQMjQLofg/YrEbk1ciLOv51pUMhpbi+SizIh
 QoAx+lblUKjNJ39zm+Zk+HX/QAxzHbDwVkculnTqUw==
X-Google-Smtp-Source: AGHT+IFVr0vZ0dSCCMhqv1jHW9e/sueSdoZV90qnjuDK7J8PgPRxKAf0d9qPjUoEc9Tlarx5PWtZ1BjcBeJNnNVnm/8=
X-Received: by 2002:a25:83c4:0:b0:d42:d029:ff99 with SMTP id
 v4-20020a2583c4000000b00d42d029ff99mr11301177ybm.55.1692053026597; Mon, 14
 Aug 2023 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230814064802.15717-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230814064802.15717-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:42:48 -0600
Message-ID: <CAPnjgZ10WBt5gfgN83G93o9HRM5F8S7X+=zNGg9EM+q+thfFww@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: description of board_get_usable_ram_top()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Ovidiu Panait <ovpanait@gmail.com>, 
 Jason Liu <jason.hui.liu@nxp.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
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

On Mon, 14 Aug 2023 at 00:47, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Improve the description of function board_get_usable_ram_top().
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/init.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
