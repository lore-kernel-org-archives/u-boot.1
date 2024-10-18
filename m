Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283ACD3C541
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E158917D;
	Fri, 18 Oct 2024 03:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G4ae+ice";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E6B89155; Fri, 18 Oct 2024 03:57:49 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBD4890A9
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a9c3a4e809so128622485a.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729216666; x=1729821466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pdjt0baJf1QAUk0Ya6Mbgjij1Az9/XA+QE6BaS5IO0Y=;
 b=G4ae+iceNQP7JZxHYBEfSwfcmN9/J6awhzLZZy7InriFz5XSdRWjDG70kPgVzPe+eM
 UnK4FQyMuDc47fKAk+1+OH4hdDbZ/2K6++3xqA8Gvh5jPhw6eeo20ZyupqFnTKPbv7SX
 g16vLOkUe82qU8GCM+otjmcCgh5xiotpPshes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216666; x=1729821466;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pdjt0baJf1QAUk0Ya6Mbgjij1Az9/XA+QE6BaS5IO0Y=;
 b=d9GlYd1LOutkj1lJQShbDI7A8CN71YLnTxFpZpMY2UGg3DiltGPewfml38WtrWWuXj
 kYZHKaF+bOxVhRrDCEt2Y38KJ4NrR9q437W7/mtakVfqjy56MkJvJ0dugLxw17Zt9AER
 Z/UtnHmtGNsMThnwkov8K27OzsaVAR74Z18ljWY+hGa5OlV0keTmWOVWJrwe5gfxTfuZ
 MvE4K/sSAmZHVOsZsEUl069Nk3Id1ngBgdL/wOYoqy1yHaxhHMKi5w9OaWSWrl+4+N+O
 F9970LN9xr4I99kyBq4BmRSIOkOnQrcNUFKzoxWXld825s79G+tSN7Vuif4hcSF0QrD/
 xxMw==
X-Gm-Message-State: AOJu0YyRSFfZJcql/17prILDjLlRkneneMFTHhNtNJC8Z71V5mwnmq1z
 /IS8BGcII/JAtvxWzLt1ZjsgTf6PuIYzIla1C3dkciYHz18zw2W7CgOc8XUzRP7OaIexFOAJamA
 65dQ=
X-Google-Smtp-Source: AGHT+IFFvli5at94GIcuhpWd4myvDnxk9pDkBteQphdoWoQlqhr8+gsmcmHWS3tbCivkJLdKa/JMnQ==
X-Received: by 2002:a05:6214:4808:b0:6cb:eabb:13d3 with SMTP id
 6a1803df08f44-6cde16175ddmr16576116d6.36.1729216666430; 
 Thu, 17 Oct 2024 18:57:46 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366ac3sm2332156d6.113.2024.10.17.18.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 18:57:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bhavya Kapoor <b-kapoor@ti.com>
Cc: afd@ti.com, rogerq@kernel.org, emanuele.ghidoli@toradex.com, 
 hnagalla@ti.com, a-nandan@ti.com, bb@ti.com
In-Reply-To: <20241007110709.3335579-1-b-kapoor@ti.com>
References: <20241007110709.3335579-1-b-kapoor@ti.com>
Subject: Re: [PATCH] arm: mach-k3: j784s4: Add clk and power support for
 wkup_uart
Message-Id: <172921666423.1016776.4995773459606441026.b4-ty@konsulko.com>
Date: Thu, 17 Oct 2024 19:57:44 -0600
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

On Mon, 07 Oct 2024 16:37:09 +0530, Bhavya Kapoor wrote:

> Add clk and device data which can be used by wkup_uart driver
> to configure clocks and PSC.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


