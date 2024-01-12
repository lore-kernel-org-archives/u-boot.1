Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF02C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED2D87937;
	Fri, 12 Jan 2024 22:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WJdBcvzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 261A18798C; Fri, 12 Jan 2024 22:01:02 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C416E87021
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28bbe484bc0so1439282a91.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705093258; x=1705698058; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2dfdM+EMxluENSJronKYjz4PChAOZ+qOHyn5R5jkDs=;
 b=WJdBcvzGmXLVslYGzHTkebJnMhTsZi8nCstyjeGB2QQaXrPPiPZd5W1aE/nuMzcZ83
 hFG4H3kcCNWazT48ALtz4rWLsZfR8fRY/rRSQlJXfDj/VjF4JVdBlDPIGc0BybRzv9LA
 kXlS8eH4mQ40j9O0ozUGhuXupxYPweLK9L40GY2FRrsw1tTi4/IJZZr5tcdd6j6Cc9jk
 KBfB5VtCJtIgew86bG+gYvVGjBXm939XyqKc79xji+ZluFpV5EujuA2QErsE6Dq5g2Yt
 zPYbUM2HZakV2uHT7ZBWrtAPib17yYebBfw1E0So5CrTokJiKEgPazEqYbeGgU4aJDNC
 ZZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705093258; x=1705698058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2dfdM+EMxluENSJronKYjz4PChAOZ+qOHyn5R5jkDs=;
 b=JX7BCXUMBHyH2tZHRPG/vKoogR3eZbhr4g9bD1yCiE/h+DofJvS71JdUkTdonVuAmL
 ByJefQqxHjtbH1S2BcP0qehLVMIF2EknerRPZgNuPYICByoddHQAqQTohlzRMASMRpM5
 OsA8hU3M9aWkqY8YehLmlzUoNvWtZy3u/nWPW6kgP1ReQ0+Vo0AStNy2cUkZRG2k3R+n
 bM9DJjxhN4VQuA/AVXb0A0Zw2xaHXU5vG0xnwi9R8YFN2XyH50hWAp66T+cL8D1Furjk
 1EO9EOdBNBB4VSR/pN41MZw9zz6rj6GCIzHqq/Snzin2Vq1HOXiP2Fqz8/t5zp/PuS9S
 1pmw==
X-Gm-Message-State: AOJu0Yx8uKFYmUZQmRm0gkaYRDxpUGix9cw+JOldgVxiXZnzSyzkFxtS
 rFA9+LsdALPCD8pFtfhh7G2aDFPRtmyJoZyeTK8=
X-Google-Smtp-Source: AGHT+IHy+gaQZ9ibn6qNFTMeT+ScakK8RP3EWXKllzXTQyhYqY9QsOoJETYQ4TtV5bgBYVemC+Xz51yi67RW3jPIc00=
X-Received: by 2002:a17:90a:ad8b:b0:28e:1609:88e4 with SMTP id
 s11-20020a17090aad8b00b0028e160988e4mr1951170pjq.3.1705093258133; Fri, 12 Jan
 2024 13:00:58 -0800 (PST)
MIME-Version: 1.0
References: <20240112160148.2376535-1-lukma@denx.de>
In-Reply-To: <20240112160148.2376535-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2024 18:00:47 -0300
Message-ID: <CAOMZO5Bh_9ZDhJi9TCEeJrT=_wS_x0_gN3qjMa8Q3UPdsOxUwA@mail.gmail.com>
Subject: Re: [PATCH] defconfig: xea: Change default spi-nor memory bus to 2
 (single binary)
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Fri, Jan 12, 2024 at 1:02=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wro=
te:
>
> After the re-sync with Linux kernel (v6.0) of the XEA DTS
> (SHA1: 7d08ddd09b75e7a3c103cc0d0d3ed700287f268e) the alias
> for SPI bus, to which SPI-NOR  memory is connected, has changed from
> 'spi3' to 'spi2'.
>
> To be in sync with current u-boot's xea dts, the default bus number
> (which allows running 'sf probe' without any extra parameters given)
> has been adjusted.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied, thanks.
