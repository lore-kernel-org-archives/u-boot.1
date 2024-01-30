Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC73FC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:52:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3749C87C9B;
	Tue, 30 Jan 2024 14:52:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZYCpYAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D284E87D7E; Tue, 30 Jan 2024 14:37:25 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEEAD878BA
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40eccf4a91dso43023115e9.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706621843; x=1707226643; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5Ack783egp9x4TxGq6I9mg96QpFF8uTpk0zEMZHnPQ=;
 b=hZYCpYAkRETrPIXH4JHRcR8A/oAyZg7f3SNKvCtOaoVLM71eKQSkeVnEzJqiLXzgBs
 DHvcylpy008/dDKBnKW3x50lcYWuyWudLKiLY7JSkxMVKE7YkwqYt7xnPTBqnlcgqsc5
 WeMbe8NkR/EReVRgjkgygF/Z4xi9RCKMNZx3Q/BUdpAWCFySqPEhJxMLK52uKyOuIAvZ
 lARaQG7jHoWCBa0r1Ixn/zyp0RcSlgT2xJtMQxZew/TNKBgOSQl83rfEG0g8Bu68PZqE
 8JycAQjdoj72UIhXzeNbvPOCqvnb8hYNuqcv5gIfLK+dGFRwux/gR2j3masd93p42yZY
 KCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706621843; x=1707226643;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5Ack783egp9x4TxGq6I9mg96QpFF8uTpk0zEMZHnPQ=;
 b=GBMfSSncRcAXoI6wv3zB0W/3pTP5XCjQ1HThXM+DzdgRKs6wNUvO7NHYJ7iZPnctdd
 i5qxPZhT2WN8hKCeXV+i62XgKevjhQmltpjhqDcBQ88goipj6wWJvjhCa5A7VDOEC38j
 /AlXThCumxsfvfhJP/fwsVjsejnFgHtvis0Lyc8zEGblmF/GFV9EkdgbG1XGNhSjnDVY
 FKdneK2wh3iIL2aAc8CZQGeTSF3uT5Qr8Z8WEVLyQmPj43CZz9Ae1rdrBZM64MXcidwB
 Jrw0QR3EDG0xdymI0zrdtS+HKn54Cg2YhYGKGIJ6SdKOR094vIMaimez8dkv/XsTd6Jt
 4RcQ==
X-Gm-Message-State: AOJu0Yzu7CmxXvKiqB1fIbD/PfX172qeOZSWYzYKWpbQVQhvpPYfaDRh
 WrXAM7twHSd13OUnLwurQiesh+z65R77oUkZlkfqiHBi2fNjAlfM
X-Google-Smtp-Source: AGHT+IHqOgHW05nBM4bkckNbDEpRX70yz7Zn2LBJs54VxHLYRDod09FzcgJOWqT6sgKf7GSP7fqEqw==
X-Received: by 2002:a05:600c:1c10:b0:40e:6ba0:de3b with SMTP id
 j16-20020a05600c1c1000b0040e6ba0de3bmr7400592wms.0.1706621843210; 
 Tue, 30 Jan 2024 05:37:23 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:22ec:c777:d01d:1ccd])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600016c900b0033aedb71269sm5427359wrf.88.2024.01.30.05.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 05:37:22 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,  "NXP i . MX
 U-Boot Team" <uboot-imx@nxp.com>,  Christoph Stoidner
 <c.stoidner@phytec.de>,  Wadim Egorov <w.egorov@phytec.de>,  Yannic Moog
 <Y.Moog@phytec.de>,  u-boot@lists.denx.de,  upstream@lists.phytec.de
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add
 phyBOARD-Segin-i.MX93 support
In-Reply-To: <21b0d615-e5fd-4f44-aea3-ee4236ff9a0c@norik.com> (Primoz Fiser's
 message of "Tue, 30 Jan 2024 14:06:35 +0100")
References: <20240125164503.32097-1-othacehe@gnu.org>
 <9f20708a-eefb-4a27-a413-8a9f5a472788@norik.com>
 <878r472m2n.fsf@gmail.com>
 <99d704dc-8133-45e1-a346-ab1d05d5fb7b@norik.com>
 <874jev2dgp.fsf@gmail.com>
 <21b0d615-e5fd-4f44-aea3-ee4236ff9a0c@norik.com>
Date: Tue, 30 Jan 2024 14:37:21 +0100
Message-ID: <87h6iv3pta.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 30 Jan 2024 14:52:16 +0100
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


> I am based on latest master 6faba41927bd (tag: v2024.04-rc1)

That was it. I rebased from 043ca8c8a9b to 6faba41927bd and I now have
the same behaviour as you. I cannot find which commit fixed the
situation in that interval though.

Preparing the v4,

Thanks,

Mathieu
