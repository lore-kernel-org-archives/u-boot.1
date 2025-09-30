Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C03CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 23:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D601C807C0;
	Wed,  1 Oct 2025 01:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EITIPYfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B984A81D6A; Wed,  1 Oct 2025 01:45:00 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C686802C1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 01:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-42d7b620348so10634805ab.0
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759275897; x=1759880697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZh5fZ7/oCzCgpuWjpgk1lAleITdQtmH/Qlf6gLcrYI=;
 b=EITIPYfiQcQZ6is+OYeYE7qgXPBjwUF6IqqoVRJOIleKuMpnHN8vjDrUUi38t8vvFv
 Vupwk5byip+rJVWpNAibw3sSQKYza30mthY5VJKRhesvEclGE+Q7LgVqLbSb3OP0YdO/
 3tq7T5r6TbebmMXZ6DFTTcdT/U7VLv6MVmCbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759275897; x=1759880697;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZh5fZ7/oCzCgpuWjpgk1lAleITdQtmH/Qlf6gLcrYI=;
 b=PC2alsi9VL3VWMfoEym6DjhYYqAyWzS6acpq3NaX2ygNqo10YdXURTIdBiI5JOKGbW
 kQqj0UV8WB21Vhqg+mCVyVKNPxk2KyU5rE7dCuDljr6GmWPqU9QH23jcziA3LzT+bjPw
 Reqvf3y5y8FS4Y38gZt/Eu/lD2lfAJOBBdM2gkmkUmBEkSU9rnYtmjxZNeft5W0DRnlr
 DkHCHVBSjmeALwP4WdqWLntR3Y6B1vetBg8leagwFIJeYe5b9R8SttSSNVB6Q88VXOx2
 p++OtvCYH/S987PX0HT8JMZkic7o8LwDfGwVTnBdR05RZceOGzzCWFS3RNukNYGaqYpc
 hVKA==
X-Gm-Message-State: AOJu0YxIxa919OdLW6cukDqtv/Abwcig5yZXqTvNrQip/Kq/RHWXKU7h
 Ay+vJFDT9TUBo7jRNi0N8ObTxDBNa2M5v6vtkYx4FFCK/myEt2qqZnCzmOrShi/1egc6cH9V64R
 xkn/3B7k=
X-Gm-Gg: ASbGncsGwl8NvMVBVlLoyvpucUh2Oxa842eVnY3dHs0r29DwzhvF7IJwh/eMwZd+egT
 mzlETq820lo2AMtLGraQBmmMKlVrHdjW1h4HhGOgf+4EV6wGehAqTE4U9QOQni2ymgxaHoS3Scy
 nOKvCWAC8xNU4epZ4A2V9HeiEEdKahnf9QbwX7fGx+aWZM6+s7E/Y/nHuOLYLQPGJVa9Z2kFBNU
 +1LvmH8jG7RJEVKmI4hf5/Jbi07KWBTUWafXh4PTBtP29X7pS3AtNVwl9jtt/Pk884/pbeashTS
 05LXlOLNeOOcbEpaBV8KIOK9Z9imzK+sqxwOJby4UtFgYDzGxr4kojuA6WjoxMyRyHO5MsPYMI/
 TMCTZRfgh5BWKI98niCO2WnSFlPPlPl/HX81ndXPw0EyR5h7Gv4tWWUQx2bk/95mj+ZY7WnyTWh
 tPvBVv0G1dD+AbbQ==
X-Google-Smtp-Source: AGHT+IG34H95Yl7PEmfX49gf58zZUjcYnaPJZe/0KFKyXiSLK6S+Odq6tneid0uVceaXSoQOBqblWw==
X-Received: by 2002:a05:6e02:178f:b0:429:6c5a:61df with SMTP id
 e9e14a558f8ab-42d816011edmr26693235ab.3.1759275897081; 
 Tue, 30 Sep 2025 16:44:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-429184c5025sm45845675ab.34.2025.09.30.16.44.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 16:44:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
In-Reply-To: <26087b6d-9b3c-4bee-9af9-a204577a39ee@foss.st.com>
References: <26087b6d-9b3c-4bee-9af9-a204577a39ee@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2025.10 =
 u-boot-stm32-20250930
Message-Id: <175927589563.2084143.11713380643914909855.b4-ty@konsulko.com>
Date: Tue, 30 Sep 2025 17:44:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 30 Sep 2025 18:43:10 +0200, Patrice CHOTARD wrote:

> Last minute PR for v2025.10 release
> 
> Please pull the STM32 related patches for u-boot/master, v2025.10 = u-boot-stm32-20250930
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27776
> 
> Thanks
> Patrice
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


