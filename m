Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F4DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 21:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF978772C;
	Wed,  1 Nov 2023 22:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LttlwPMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A3787753; Wed,  1 Nov 2023 22:03:36 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90B487683
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 22:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778a20df8c3so11204585a.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698872610; x=1699477410; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSliDwvn5MojJDqOoEBKgvlgc9Q469mNKfcPEpBlxoM=;
 b=LttlwPMGB3oyrH1n/OBGCDVb/tF3YYJKVMauWfeN2pLU5Izr2D2ggbdDrkA0ugwZRq
 l1VahNu8FBRRnU8fom90VvXNXkgkpQP3/KnRP1nopW9mrbqzn1fpO/+CgWvGW9yM0Znh
 1kaWaPESw62ubVcUuMt3TLobmDHj648q8JOISxQWLr9pod9b9ZmvV19+AzMObFekDpqy
 MitIp24ypHLaaV6XwgdWmmtUpDjfErnrXSYe+YJqvgb3CNfzmvwi5W8740pj2inQPeXF
 HNNoulQIZJ2s2MAgwjcyHbVmWknHGRw1RskxSGaboWqy9Mdyx4cbKn5DztYVPQHxaAdD
 zbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698872610; x=1699477410;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RSliDwvn5MojJDqOoEBKgvlgc9Q469mNKfcPEpBlxoM=;
 b=ZeVORwqD50d1+9XqDhg0I0ioTNruhxHK+++sLZTFnU+VV1rjxpAg9GViL96025KJMN
 NjtbADt8gWZO2faX/MgzxOAIe/jFikypsM2wecTJNOdc3/+Q15/EvjqVyUrhS9PNSudv
 Fhs0Sob7qlH3dp+LVsj43C3M7FEgbkMJzJ4CUMiLH1V0fbxU2b0kuk418QywAzJ+d9Bq
 MEGVAbCfizcPvXLUUc2P5XVRM1wPDO38GUXxOjYNAMSCj4BRIv8T1i9DusrUUR87Xsze
 6yQR68J7xm/im1ZN0scsN2FRjNyn0M6BjCsWZxyZEbtmdbBaxWm6Huo6iHuFRKMKaGvD
 YFPQ==
X-Gm-Message-State: AOJu0Yy+xYjiWFCGJgwS6i/lKgU4lOXXvC6fb9D4elRMfyktGUoH/vVW
 PMQ47zpOuJJpw/0OPXlumU4=
X-Google-Smtp-Source: AGHT+IFmK7hosJzRLHB4mUCssgROLcBArkjWKHh647PwcWLiOXo47FB0XVDleVnM+P3GmPWhYqkzrw==
X-Received: by 2002:a05:6214:624:b0:671:560f:32fa with SMTP id
 a4-20020a056214062400b00671560f32famr13991902qvx.40.1698872610394; 
 Wed, 01 Nov 2023 14:03:30 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 c11-20020ac86e8b000000b0041519614354sm1724453qtv.7.2023.11.01.14.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 14:03:30 -0700 (PDT)
Message-ID: <1244a946-5e87-d470-ae66-0e56c5cbd36d@gmail.com>
Date: Wed, 1 Nov 2023 17:03:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Yang Xiwen <forbidden405@outlook.com>, Maksim Kiselev
 <bigunclemax@gmail.com>, Jim Liu <jim.t90615@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>
From: Sean Anderson <seanga2@gmail.com>
Subject: [GIT PULL] CLock changes for 2024.01-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

The following changes since commit fb428b61819444b9337075f49c72f326f5d12085:

   Merge branch '2023-10-24-assorted-general-fixes-and-updates' (2023-10-24 19:12:21 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-clk.git tags/clk-2024.01-rc2

for you to fetch changes up to c4b52fda6924e92c6745351f32c4cafc36034170:

   clk: also handle ENOENT in *_optional functions (2023-11-01 15:14:51 -0400)

----------------------------------------------------------------
Clock changes for 2024.01-rc2

This contains several fixes for the clock core.

----------------------------------------------------------------
Eugen Hristev (1):
       clk: fix count parameter type for clk_release_all

Maksim Kiselev (1):
       clk: use private clk struct in CLK_CCF's enable/disable functions

Nathan Barrett-Morrison (1):
       drivers: clk: Adjust temp var data type to properly match that of struct clk_ops

Yang Xiwen (1):
       clk: also handle ENOENT in *_optional functions

  drivers/clk/clk-uclass.c | 13 +++++++------
  include/clk.h            | 12 +++++++-----
  2 files changed, 14 insertions(+), 11 deletions(-)
