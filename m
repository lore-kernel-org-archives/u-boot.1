Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4322FCAC5BB
	for <u-boot@archiver.kernel.org>; Sat,  4 Oct 2025 20:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B3F283666;
	Sat,  4 Oct 2025 22:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Whh4XM1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AFD0834D4; Sat,  4 Oct 2025 22:48:27 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58022834D4
 for <u-boot@lists.denx.de>; Sat,  4 Oct 2025 22:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-91179e3fe34so174068639f.1
 for <u-boot@lists.denx.de>; Sat, 04 Oct 2025 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759610904; x=1760215704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a//hSec1bYs8L5fIK6yEMdtYLOH191Yw0/lqy/4fxmc=;
 b=Whh4XM1tSU9ScV2mKD+re+zl6ml3nMRFt68UnzK/jtBfxlDmgUk9FAdEAKjqjxJ47E
 ysAQZ4/MncfYlP2KQS+xlRHarzix9uue5Q5mFUg0zyBQTbgA822dN7MQIdD0LnaLzPj7
 awr6hloOX71LecU329dAivbMucXK6vv0ylfqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759610904; x=1760215704;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a//hSec1bYs8L5fIK6yEMdtYLOH191Yw0/lqy/4fxmc=;
 b=hZiAowngFhNl2HlybMWsrNo6xLIZpN1csquiEL8sO5+zB6pUfywHZijgdvC0zc70ZR
 2r1JHSCX3ALtKCieQtKtG+xzmB3LIXo/SLMflV0ObYgAhKZROA44wj+BHRrpd7w9nZh3
 wIbEw6/ojf8kt9Z1Fs0olDR6PHnwJcGBJ2JWMmqUeXKRVwVk0qx7jqk0uCO2wCQ3qmrX
 9XV/DTIlabL3AsppVL5KSwVu7Hot6oiyEwaHg+ayc2fWklTGIpo6c8mPoIBpeJX9pcG3
 KFLOv1h5+id+8PI+TNUXah1GolpVlQ8dyjCP6C6CbTAm8Q5j5IJh2Aob9O9yBD3cPtFe
 rM2A==
X-Gm-Message-State: AOJu0Yxz6ALSqyG4Z5MjK2wPYtzZt4QlFRqgDpQnVBLsQc48Xb1mVycp
 XzELC/3QUn7tKi1/WVXNgZ7W6r0YNQBZf3dgCgO2IF/SwdpIGbD4p2l1GnUg1cbtsg/nke413hj
 OpsKMEaA=
X-Gm-Gg: ASbGnctkTXzR/rO3y1BkJPCMBBd+lWjprZB8Y7IdomTwgivkzaWPEkP6e0/pgg3Qida
 A0YA8wvlQTx2ogs+0PqhCM4YkySDlTmnp+0OaxDis2ofCOiNYOVpMBweEyZXQ4sQYZHRLWGVaml
 FO/+CUvKu23Ju1i1MYnih4MKSk1yhOAxP83lFT8qXODfgJFtHbuoTbT9PZch267FQRtIz9veNDC
 QSzNH2cX+GOp//1tvjPXcEH4mmoZanFZleopTy3TM+zhqbJM8VWEHDVlGKOhW7MHzoSBqgk81/A
 OJQpDGqiXTjSDHhS7EzNBiB05T5tTPG9f7dQgwRx4aIYYhb88VfxXcZTWkgzVdXsUsW/mUyuckA
 iiWKRH4jP7lgYtgUYwarMwQHjR0XGPiX/637MgfajPh1C80dq1GMX2WgVnnQcWWhAK+q2kvz3ba
 oGlgRMmzHl
X-Google-Smtp-Source: AGHT+IFcXugP0IPMT0pAtbFYubH2+klYYvwarShdQOwIaaUf3y0VF8U6oqPoshLWV+N0hnh0y+YPKQ==
X-Received: by 2002:a05:6602:27d2:b0:91b:605f:1f0f with SMTP id
 ca18e2360f4ac-93b968bed16mr1035502839f.2.1759610904079; 
 Sat, 04 Oct 2025 13:48:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-93a88961d74sm321145039f.22.2025.10.04.13.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 13:48:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, yegorslists@googlemail.com
Cc: lukma@denx.de, seanga2@gmail.com
In-Reply-To: <20250922132700.4180174-1-yegorslists@googlemail.com>
References: <20250922132700.4180174-1-yegorslists@googlemail.com>
Subject: Re: [PATCH] clk: ti: fix K3 clock driver help texts
Message-Id: <175961090286.3677446.7866815314560835265.b4-ty@konsulko.com>
Date: Sat, 04 Oct 2025 14:48:22 -0600
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

On Mon, 22 Sep 2025 15:27:00 +0200, yegorslists@googlemail.com wrote:

> Add "in SPL" to the SPL related driver help texts.
> 
> 

Applied to u-boot/master, thanks!

[1/1] clk: ti: fix K3 clock driver help texts
      commit: c23688d0533db87c533e415be7809b435080c7e4
-- 
Tom


