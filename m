Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6E8C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20A188A3D;
	Fri, 23 Aug 2024 21:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G3oxlXbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F9088A7F; Fri, 23 Aug 2024 21:14:21 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD41888A39
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53346132348so2715750e87.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724440459; x=1725045259; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZownQkg69WFpUM3OQObHdkW1p2KTE2MbB0BWQLeLibo=;
 b=G3oxlXbjPR3qiVa4n9RzzPem4lpONI2IWQBMayTRB3HUC5PDEFC8EwkY6EcsLapy9H
 Wa2P5w+WFKRkoiQUKgIainAVibiXEzj0lNKCh3QEe40nE1bXZ+RFI6An9BNWa6/wnNmR
 60X2Nc2b1bY8nW64fO+S0NNAs5I2n3UzhSq/5aDULyiFCqQbbdDAuv27fdnh/ttzYJM+
 a+0EzrXxYrPCjOY3ao0456MGPPqCn9ykVbj/0vwm9I4S5EDfRSzAH7OLittSsHSMiq4b
 9xaiJRgTUttsIiyCRrODLNFa4qqk0OZ2mgwoFZYFu38xUr8pj/DrEPo9ARTzZQW1HFFV
 JbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724440459; x=1725045259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZownQkg69WFpUM3OQObHdkW1p2KTE2MbB0BWQLeLibo=;
 b=lq6U1OQld47tyPT4oOmgcG8jZdb6nVojhRTfqyUq3XtaswbsAjvHklUiBDyDWXD+CR
 Dv04j5d+LbS6jHU3HDRb3vne7f3N5m9qpJP4t5w2vEnmES7xjWu5/uxVw7qw41G6Gu4d
 KVqHzCzfcGc/K/IWHFC+cCVTWaLMCQ1HduzDmduehrA1shrzz8e8m6w7ybHES2Ktu3ua
 27iuem2Sr/vx/khc1cH2R1mZmCMUZEUcdAYvMJQsmgKgJovv+i8S5Wq/uj2sJ5ImkwdP
 v5ZfKc0IZw/5ZPZ6MenIdAcyrVlrfE91OT7I1OT9rC7bG9xXy55Pu/lfzN+0A7fGmbMQ
 neGQ==
X-Gm-Message-State: AOJu0YxRqVt1LNax8jQeTlgmnkzTBZ6OlYPzEebCeMCOx4lKFSPYTg3v
 eJ8P0dfdRs18tsQY+IepC9hSGlGKQd9o/Yjiywu0U4Ml21cIr9zMhGR1pKXs83NNGmNfcN6FvrR
 xuEGrajCal27792u+IKamNQVJUjE=
X-Google-Smtp-Source: AGHT+IFl9rAHuyCBp7kpQkA94zQBTqcprPdnkFRqH+vcltk32LzQpsl2E1r2RX97kJUBXsWWiKUSmUObFl2/TL/F0YA=
X-Received: by 2002:a05:6512:1054:b0:52e:fd53:a25e with SMTP id
 2adb3069b0e04-5343876c50bmr1940528e87.2.1724440458639; Fri, 23 Aug 2024
 12:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240814182845.762118-1-festevam@gmail.com>
In-Reply-To: <20240814182845.762118-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:14:07 -0300
Message-ID: <CAOMZO5BZQ2DUnuN++R=HqMepQM08369eWJWC9tdirj4swXxn8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] tqma6: Remove non-DM board code
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Wed, Aug 14, 2024 at 3:28=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> CONFIG_DM_MMC and CONFIG_DM_SPI are alway selected so the mmc
> and spi board code can be safely removed.
>
> Remove it to make the code cleaner.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied all, thanks.
