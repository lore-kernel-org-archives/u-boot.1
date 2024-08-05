Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5381C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 13:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027AD8897E;
	Mon,  5 Aug 2024 15:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHmZVRJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB578892B; Mon,  5 Aug 2024 15:43:23 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C748891A
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 15:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bisson.gary@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f15e48f35bso35759791fa.0
 for <u-boot@lists.denx.de>; Mon, 05 Aug 2024 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722865400; x=1723470200; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mJDlNuHFcaUr3p+3HPqh3GlbALe4H/zLxIqNPEB2kTA=;
 b=LHmZVRJsFnGnxdz4hi6RjBCALq060GK7ssONi9gJhGoK8lJhb8BcsmP7yckJeS/8He
 4bEgdMhsN+mtEoed8VbhsYG23WoBtwsAbyLpXuAbUE730cHCJtVcK7dIEN209LUlzV/B
 m/9eeYb0iNRw7632dKkqcnCSppQsSMfjgE/qmPCIyo+2HmlfPZ/7HF2/N/KCoe9Y0T2/
 o/d70BONbMuPg1XmnJ7L+VFOexDREcZVwq/p2xrHMWuc+psSYSEaHCQkj5CDCTANiBu4
 MS0cdMwITnzHbD6lG0qAfFHvc1l8ynxGaz44z+06/3WLUzt68TUiChX63ZJYAP0kgWts
 CNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722865400; x=1723470200;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mJDlNuHFcaUr3p+3HPqh3GlbALe4H/zLxIqNPEB2kTA=;
 b=SwHe9bvTp7/ZzQ9Z9mnHV3ykqgT1zrTX0BnHuWrEiTDMfgXMFavxUTq0KCEkCAdxE6
 2kY/cl8v02nbP7XDNuNIt0aucngD8Q1rt3n5H0Etp3Ya04o3P672uDYlVZAw+bqlBlaW
 iWy9BDp1zwDU79cSszSoJ1Oxs8iFt5cmjXWJ0i5/XB8vbqQ7zbrxETh1vjuwODRV6E/p
 R07u6sa4RHzunRsRCiBeFqMbpnTp7iM2mZoUlfUAk/3F8SR/bqnp4UozMDDmqFbTjGtQ
 /aCS9mn9EXCoVUwkdf1hs9yvChITHclC3iKzYsdgAdQUbEPmgxRbK60HU82Nb206+r6B
 TWNw==
X-Gm-Message-State: AOJu0YwuJqGDEk5XWeyPL0zGewlM6iv6ezTz6ycnszLDzlICv5ugjScR
 4NLEJKWoO6ihfv8RsOxrEMlYe/ONsT6v88dShB5l7CitGChvpoZ/
X-Google-Smtp-Source: AGHT+IHX22UpI9uBGWil6r+NVUROYtTBB8yLV26ZODsjtwMWycndctnl3N6p0sYymUk0uygGQVw0Lg==
X-Received: by 2002:a2e:95c1:0:b0:2ef:1edc:3b6a with SMTP id
 38308e7fff4ca-2f15aab0a32mr76164971fa.21.1722865399876; 
 Mon, 05 Aug 2024 06:43:19 -0700 (PDT)
Received: from p1g2 (128-78-204-97.abo.bbox.fr. [128.78.204.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb97fbasm201498685e9.41.2024.08.05.06.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 06:43:19 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:43:17 +0200
From: Gary Bisson <bisson.gary@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 uboot-imx@nxp.com
Subject: Re: [PATCH 0/5] imx: imx8ulp: add binman support
Message-ID: <ZrDW9bwKuJr80E9Z@p1g2>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <CAOMZO5CrAfxg5993jm+yDGgJUC6x10Cq-onHY5ref-BDc2sKZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CrAfxg5993jm+yDGgJUC6x10Cq-onHY5ref-BDc2sKZQ@mail.gmail.com>
X-Mailman-Approved-At: Mon, 05 Aug 2024 15:54:59 +0200
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

Hi Fabio,

On Mon, Aug 05, 2024 at 10:31:34AM -0300, Fabio Estevam wrote:
> Hi Gary,
> 
> On Mon, Aug 5, 2024 at 9:43 AM Gary Bisson <bisson.gary@gmail.com> wrote:
> 
> > Gary Bisson (5):
> >   tools: imx8image: fix soc variable for ULP
> >   tools: imx8image: add upower image support
> >   spl: binman: Disable u_boot_any symbols for i.MX 8ULP boards
> >   mach-imx: Add i.MX 8ULP binman support
> >   imx8ulp_evk: enable binman support
> 
> Thanks for adding imx8ulp binman support.
> 
> One thing that is missing is a doc/board/nxp/imx8ulp_evk.rst that lists
> the required firmware files to build and boot the board.
> 
> Could you please add it?

Sure, I'll add it and send a V2 by tomorrow (hopefully today).

Regards,
Gary
