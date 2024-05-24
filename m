Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E41C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBD8D888DF;
	Fri, 24 May 2024 18:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXyezCoq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A9CC888E6; Fri, 24 May 2024 18:27:32 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA7AC88647
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:27:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2bf196037a7so257702a91.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716568047; x=1717172847; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoAnobIiHrhaoHm2ITZGcMvuWPHbYBiad5uyKb6h6ss=;
 b=kXyezCoqGmtB4oXHUHiDahvtNYjpRXPbXKw4W9/zS4a6KwYGQwz9lQORiv0YVRTuKI
 8sx6FHOcE1CTj87sogt7GOJ9O1P7nScJvC0fr2DXJSVs3sJxR56AiZWkBB8iCuk8ucsP
 4Zqwu+KNy20GMd0MSC0f+O0sCTmRlDu7J3oL/VvQrVoGUUY8E1ZuYo8XZ9aB4tc5C6Ak
 7T/SkiMNb3tdGEjpWVa7QYTiRWKBrqAqETIIB1zC6n3XIgPljc0F7yHjtO5zPKrVHxtY
 5DmaQV4Ps8XebVmq4f6yDgZ5acS/9qwPK/93gwoRILB23OY3fV/rAeRvRt/JsuYX14wg
 I1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716568047; x=1717172847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoAnobIiHrhaoHm2ITZGcMvuWPHbYBiad5uyKb6h6ss=;
 b=cOfOxxN/n3LBNZAUwHnujb5iHbSQhfk1MQn6Sq7Pexi7qmqboXP+CvSXuj2Rqx+yag
 Ts/CpqmTbAXGsy6eeBv8Ybvd0LNFbOvZQHSnbKR+GXV2ba7S+yguzPGCi+aSQ4H0HCOy
 R+vo0d1xyAPRO+BoRDtE6v9IeiajVMG9xwrPAecPgHddDn1PnnA0HTyzl66rL4gwvpKh
 vEJVa1v0lX5NQ4XNaYtWECmhOGTuI1heFVRsqIoPV2m7f+HdGtXhrkO0ZCL/bDEL1kFD
 v63IZ1fIlf4iZZ4U8q0AegopCMe5UNQ9rK+/6ICfNTtwlWYSamSh9GMosEr1zPcviAYX
 mB2Q==
X-Gm-Message-State: AOJu0Yw6Yg4x7ixxBBicsEZa11wx2C1fGj7ByIZp3MQs0+pKC4DTA/0g
 J5GEdXYnZcy43SRmEvCfjbMvaJ7oQTQ88o5NGUwU4oRYyUnTU1NY90RhCadFm6SvavVp/Lr/0++
 iQ6m9m0Tenc9yxk3FUMJgNQNpU71JY0GD
X-Google-Smtp-Source: AGHT+IGtpsE1V19GXdTxDSv896pAdNcTmjgIGQCnOS1A6IP6phJP50CN4ZEZm+fR6/ecChVH76mVkV7DnhkTEOXDAvk=
X-Received: by 2002:a17:90b:3697:b0:2bd:e688:3779 with SMTP id
 98e67ed59e1d1-2bf5e1628d6mr2631692a91.1.1716568047195; Fri, 24 May 2024
 09:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240513032822.139706-1-marex@denx.de>
In-Reply-To: <20240513032822.139706-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 May 2024 13:27:15 -0300
Message-ID: <CAOMZO5DXs=4oXVRyzLahb9eOoB2zC1K4Wo_YZU8FQCRP5aYVPQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Add doc/imx/ to i.MX MAINTAINERS entry
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Claudius Heine <ch@denx.de>, Stefano Babic <sbabic@denx.de>
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

On Mon, May 13, 2024 at 12:28=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Make sure i.MX maintainers are CCed on doc/imx/ patches.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
