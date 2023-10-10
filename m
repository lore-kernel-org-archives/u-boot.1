Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01448CD80B7
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 11:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95BC886B82;
	Tue, 10 Oct 2023 13:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJB0CBPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0671864A7; Tue, 10 Oct 2023 04:18:25 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D456386489
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 04:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-564b6276941so3788568a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696904300; x=1697509100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9folgvi1B7MAmwHvR7F3QZ+At8YZk3pMqD4wU3pLXE=;
 b=eJB0CBPKH9+b5+wbEN/06VLQ85bx2+yeVLWWEd/OmgturLaysSVe+FjN4/Xgt4/PXA
 mt4Idb+yHrRg4m8uMPjfC3sTl7OtymrTDKYk1rxNljRS3ns4uKXD/ALorqa9QCHsQy3y
 aiXgrDtlOozpJCGc1JVw/3Xm6KN9G5zEqZBpU5TJyrAsIPK0aoWvmoHnxbKxWX1uuxF9
 aYudRNPpsXNZJrXR1n5JMmu+DD0RO//Qo2hc689/7m4QLtCqpJ86OAesGsW+DywbxUNI
 O3QgS0ZKIp3zuLmj60DV2SdWGGAFFtbRsGTagudbacgOSx9lhUWsy3haduQuaz9D3fvC
 jN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696904300; x=1697509100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9folgvi1B7MAmwHvR7F3QZ+At8YZk3pMqD4wU3pLXE=;
 b=wGySdcc/otjsRbFCWAJfCXHdRU8sOxQQZoaUhTD8XGTAbSCjsIjYYeBK2i/4EXRIpE
 4ofcTVGxDKxULVOKl9CIpinYAt+lgwIvBVOf7qthDNzHyiSBzRyeB1cDu14+pUogc6IJ
 LlT25u5NKx4yGMOzJxWwUCfzgriz9wRKc3QtrXKG/2iymuUSno8Tlg4e9n51xBgYVRr+
 uM8LeRn20KYT3GKJIpRGUpoZQlYxiXyd/ftE8rV8MzHpHhPbqn/TGNKy7S3pMIX/xHKs
 +sLyipE8UbR2YLV+O6kFFeIlR1K+eD+h4lnS5KPVApLix33PxCz4Z6goIFMWsRrXVjLu
 ZZJw==
X-Gm-Message-State: AOJu0YxzGb6DY3JoEQbB8XsPefeLbPsbs0MIyfSC/lHNumDj6jKon5GW
 s90sD9gq5WGIBs70TejTMqs=
X-Google-Smtp-Source: AGHT+IEgDPwe1al8nA+kcVnQ/xI6BsKnIahlLaMTVaUst8iHdxowLHUQAweux0mfFRLhJ+XfGgokBg==
X-Received: by 2002:a05:6a20:7343:b0:14c:3218:c1bd with SMTP id
 v3-20020a056a20734300b0014c3218c1bdmr19759907pzc.11.1696904299763; 
 Mon, 09 Oct 2023 19:18:19 -0700 (PDT)
Received: from joaog-nb.. ([152.249.60.243]) by smtp.gmail.com with ESMTPSA id
 w18-20020a170902e89200b001b9c960ffeasm54340plg.47.2023.10.09.19.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 19:18:19 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
X-Google-Original-From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
To: jmcosta944@gmail.com
Cc: Y.Moog@phytec.de, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>
Subject: Re: Port gen_compile_commands.py from Linux to U-Boot
Date: Mon,  9 Oct 2023 23:17:56 -0300
Message-Id: <20231010021756.34200-1-joao.goncalves@toradex.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001100036.34936-1-jmcosta944@gmail.com>
References: <20231001100036.34936-1-jmcosta944@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Oct 2023 13:53:33 +0200
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

>Hello U-Boot community,

>I'm submitting a patch series that ports the gen_compile_commands.py
>script from the Linux kernel's sources to U-Boot. This script, originally
>located in scripts/clang-tools/gen_compile_commands.py, enables the
>generation of compile_commands.json file for improved code navigation
>and analysis. The series consists of the initial script import, the
>necessary modifications for U-Boot compatibility, and finally some
>documentation.

Tested-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
