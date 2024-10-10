Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963F2CFC5E2
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 17:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBE58911E;
	Thu, 10 Oct 2024 19:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hiWAZayh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75F289170; Thu, 10 Oct 2024 19:09:59 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D5188FEC
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 19:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b117fab020so42087285a.1
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728580197; x=1729184997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzlOG0uj5LDRBRg6ZOajAlfgip/Cq5G7LarbF21cMt4=;
 b=hiWAZayhoj7wzouS2mQvL1C5jMAy2xVBP/kdGCpWfaTVlTrauEGK5RUijdSxkQxx2+
 TkUwgSAT+Wt4q3aQYnxBGStSPBS6sQy78sGXmKdAuHhmi2kDc3AsgKNBaKMYotObvrEa
 hTy0AHkkLGjUNhTwbbyPzX0mYMdWbDS8ylOp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728580197; x=1729184997;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzlOG0uj5LDRBRg6ZOajAlfgip/Cq5G7LarbF21cMt4=;
 b=pD4r3cBSpJXXhmBLYbrWPAimqyl5USwvap1Dkqpck/xELQF3mLwr6xE7LrqL8AMY/a
 sE2Zx+lpouNiMgDph0T3UZ+tcC0KEW3wlLnxqfQuAzwhw8E4+Y9LSPz/NA2BHF4q2Pe/
 KdfPtgGBzCBTERFoDYZ9QV1dalL+L5n/RSLSh7fOYjUv8SfjjeLcanlOcXxGVZ9qR4sa
 nQQCsV/hhtTHBg+OrLh03mt3cyKBC8GYJ43lTjQ8ORM6hlx0eSHStfj2OcDKmFuYd/X7
 NQ/xyogjWLWtzeAK79+SErLiVvYWsm1uAD9r31n5OipEw9fAXDfg5xil7hv2quXpiD0j
 jZJg==
X-Gm-Message-State: AOJu0YzbUN8a+6OXtqsZu9SOJr7WdprR88CyRHhASxEtslZmHEpvKX0G
 nVmFNNguDUXX9Y3MzvUW+NOJkALuqUy2t+z0/cCGLjmWh5F0ZlI286wgZRvhNFc=
X-Google-Smtp-Source: AGHT+IFeEkGr3KJSSVRPRp/1TlbMog0I4PYZoJl88qCYK1VfyCN8FtKkp0zonV2OxOLH9LhnTxynSQ==
X-Received: by 2002:a05:620a:4709:b0:7af:c632:dac0 with SMTP id
 af79cd13be357-7b11961998dmr111771885a.50.1728580196805; 
 Thu, 10 Oct 2024 10:09:56 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b114956069sm60577185a.74.2024.10.10.10.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 10:09:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>, 
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, 
 Teik Heng Chong <teik.heng.chong@intel.com>, Vignesh R <vigneshr@ti.com>
In-Reply-To: <20240906211022.193224-1-marex@denx.de>
References: <20240906211022.193224-1-marex@denx.de>
Subject: Re: [PATCH] mtd: spi-nor-ids: Deduplicate mx25u25635f entry
Message-Id: <172858019461.3696879.1075772767290978660.b4-ty@konsulko.com>
Date: Thu, 10 Oct 2024 11:09:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 06 Sep 2024 23:10:10 +0200, Marek Vasut wrote:

> The mx25u25635f entry exists twice in spi_nor_ids, remove the less
> complete variant of the entry and keep only one copy of it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


