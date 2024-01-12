Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A10C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B170E878C8;
	Fri, 12 Jan 2024 22:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DzRayUXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC5E86EF1; Fri, 12 Jan 2024 22:00:34 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9335B878C8
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d54c7ef801so12148595ad.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705093231; x=1705698031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXJWwzRTIfAS7jXpMqW5K/b7aofFFc6vqGHGTjArWkY=;
 b=DzRayUXjl1VbIIt4hXbGGu8gBZUQO+v0T2RAjLbyLhrPcMXTiqg3zsFEC9KWG0QAxg
 2zqUlLw4Xg6CAr4JuqXqThSpocViUM0VkqjOzdlfasrfdeWjRuMoRofXuBUWhB+HeAO7
 15HlYdf68ZErY05QLfV7Tv3OUEQTCT/lexPPGK5/2mbjDcG4y5cOJlE4zbLDegEo58rz
 KfCDBJdWVCBei7c6W2iyObb4/I8OWvkblZc+8wbI6em707EwG8TJWQetAb9j8X/R7rGQ
 fqWsAUT4koTIMeUSkRwgkC01BhpgLf4U8+OPklm2mHYp8WxKeV6GydCyZpdyxDStvXAU
 U2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705093231; x=1705698031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXJWwzRTIfAS7jXpMqW5K/b7aofFFc6vqGHGTjArWkY=;
 b=ii3JICqF0bo4FEPMrrowkOhSrIdDD9lFpzxphTbqALV2lYGxkKNkKzmApHWu+HNtfB
 p1F7vO16fBZxMObH6uVidbMUJnlhzj1LY8G/GB2k8hDVU4fknOmp+HyfJlU6/+Ye4yUu
 gUHYU5RwJ88KKckAaU0t6WIhitITjqrgYH0qr9cI4ChfXwBuUCYzKWTf1XGoMl1RSlUT
 r7qIc21WV0wAKJg9Kipsw+JHfwUM8h2O46Pxvk9dbpndevzZf6rxse9WOjjBwOj3AOzS
 0dJbmdPd1FnVNMjqmiADPNI//aS3NRrYmFjXZVc/mYL/IISNixuBaZ5GPb0RIA2/1PZq
 +osw==
X-Gm-Message-State: AOJu0YwrL9xyyvDvNkEio7gQo8JwWnio8qMqGPUYJXJ1a0fh/+KeccWf
 zt2q7zL5d1hnxoH9bpP93XHyKoICFOPlg7F1ILw=
X-Google-Smtp-Source: AGHT+IErKJhv1Awc6Ln9Pob4DyaFe9ObiN+52hd8KBMgLASEm3UqS53YtpFjUig7bCvXMJSFrT9mj460K7G6I62/hIs=
X-Received: by 2002:a17:90b:384a:b0:28b:9a2d:c1c5 with SMTP id
 nl10-20020a17090b384a00b0028b9a2dc1c5mr2922581pjb.2.1705093230899; Fri, 12
 Jan 2024 13:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20240111125625.2815180-1-primoz.fiser@norik.com>
 <20240111125625.2815180-2-primoz.fiser@norik.com>
In-Reply-To: <20240111125625.2815180-2-primoz.fiser@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2024 18:00:19 -0300
Message-ID: <CAOMZO5CjfkTQhFk2nA7XOUW9oVUAdvYS=mgwyLG_JhwUMqrBig@mail.gmail.com>
Subject: Re: [PATCH 1/1] imx: imx9: fixup thermal trips from fuses
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 PHYTEC upstream <upstream@lists.phytec.de>
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

On Thu, Jan 11, 2024 at 9:56=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:
>
> Read i.MX9 CPU temp grade from fuses and fixup thermal trips in Linux
> device-tree accordingly.
>
> Based on commit 0543a1ed2787 ("imx8m: fixup thermal trips")
>
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks.
