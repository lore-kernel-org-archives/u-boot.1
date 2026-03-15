Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3501F3026D
	for <u-boot@archiver.kernel.org>; Sun, 15 Mar 2026 14:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 432688442B;
	Sun, 15 Mar 2026 15:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dnd4lx3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41E988442E; Sun, 15 Mar 2026 14:55:26 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194108442A
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 14:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-829b2019b39so1944578b3a.3
 for <u-boot@lists.denx.de>; Sun, 15 Mar 2026 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773582922; x=1774187722; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39YWkYrHSYiznV7EsYb4cu1zSYrBGpuBHATnII9raww=;
 b=Dnd4lx3WXzdQWXwLNHrI87JTn5Q20MXC5Y87jhCN/ekE3qYnmljBl9yiWeEamuSMTB
 VApM1tBli32JgOoPo+laFq/IJLtp94lKh8baQ+x5DGbmtdleDsqL2gEaWTwZvc0LFjuc
 pSOi4gfwiuCx9qQk5aMPMZdfEoWpEOmtJGtAFFW2oL15CpWJluqx7YPyfIunYDBvXe9+
 Qd297T8JyuVW98+OeobObsy1Vnc/wAKByLglMhabCVnjgqGUAk6pEDvE5w6VT/oy89lX
 lzSLZzbWrTVS5969MQwTV1MgK4eAkC5v7LnsdR5un++O7HqniEesGlt48znP6jhMJ9Tw
 Y74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773582922; x=1774187722;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39YWkYrHSYiznV7EsYb4cu1zSYrBGpuBHATnII9raww=;
 b=Nod6cnFLhtjJuzfSu410nXojcrizVr9/4d+G4OV4afyD48C88tVi8wHWWp1RMdvtjn
 MSD36snMeFQHaHQ4ohFk1lIznBQyZyupSSgfhHQb26ckSJLi3qpXTCRF6d42qdcWC5s3
 q5oKlac9656F2dmYJUvtChxlPWAUUf6jp8obx1i4+7/zCykJj9DOhWm2Wgzjxvn5HQRY
 I1GQ7vkyYVKvrnddoTMKwEfnVl8/DerSNY0FM0ljrXikje+o7EjvwSGEr+ma5OCNb/Zz
 PbTp5ShZT45eggOFX4UdOsbYKLb+kgcup1zM0/vbiRiKWYNMlX5mnNEbQSuZen1K/LSE
 feDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeAl0GF9m7vwR3g0zqhU1F2lR4ZE9GZxTDP1sQw3/GXE0+xVFpAIk1zA4PA4viZNga8md8H/4=@lists.denx.de
X-Gm-Message-State: AOJu0YxmjnQE8Oz19ZswtRDYTUEKJfwEFEqKvU30/VWUeFuNfmbCOEya
 UxyV+rRkEey6jXlfzOPbMioKOtvs2gqRUv0+TGlUq6InntSm3dXEx4cRDQPonA==
X-Gm-Gg: ATEYQzzuxResTEgm22ikxpM94cOL8sk9RZI4HzCbdEBtlClc3hYgspQLHL4aqx9b8ci
 LClNyUi0b2PVGIgQVwk9mmHhX8JADHOP9xp7Acwhw+cl5Lajqk+qYHP1yQdBXSlqBlA71d2a8uO
 PmbrgCTOW+wF/diU5iLaFvKYqc4t4GqiNxARh8E/BaKtzicblYKwhjWGd7+9UhkOO5vGPCh44wI
 R7p+udYYyQ3/clRQKxu3NuK7Ft3LqPZ/pnE5oqUZfZusj9BVSK6/1WcvySR0KT4qfMQMHdVxC50
 y8qz9UnuYDBVufGcuvl02Ggxp86B2QmooyvfZ94j7HR88BV2A2IunsI676pSAiHqa80bNpSSMQU
 ZXhdWCRqdjPda1mvu+GSC/Xd+ZhOVo4nEjIjuD5l1wni0O98IYrOTr2JUqKFhuJs6rfxkvVoNp7
 HtEpQjPZg6h72t9GYN2b6CMpjxnuKHoo1aa530amSfC62hWgHZxNM8q4Zd6p9lzwbncp/uXLDGR
 3cVRPiT2m8=
X-Received: by 2002:a05:6a00:138e:b0:823:ad3:4ff4 with SMTP id
 d2e1a72fcca58-82a198b84ddmr9045543b3a.37.1773582922535; 
 Sun, 15 Mar 2026 06:55:22 -0700 (PDT)
Received: from [192.168.0.2] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a15b44f61sm8094110b3a.7.2026.03.15.06.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2026 06:55:22 -0700 (PDT)
Message-ID: <cfce88f9-d78e-4cce-93f8-d5f4f67b1322@gmail.com>
Date: Sun, 15 Mar 2026 21:55:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] phy: add common PHY properties support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com, kabel@kernel.org,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de
References: <20260308140614.50489-1-lucienzx159@gmail.com>
 <20260308140614.50489-2-lucienzx159@gmail.com>
 <20260310083200.cbcedg4gj5jlgqso@skbuf>
 <06373536-c45c-439e-9876-69276055e565@gmail.com>
 <20260310174042.lotpfwz3tszyn7er@skbuf>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260310174042.lotpfwz3tszyn7er@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 15 Mar 2026 15:44:33 +0100
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


Vladimir Oltean 於 2026/3/11 上午 01:40 寫道:
> On Wed, Mar 11, 2026 at 12:21:45AM +0800, Lucien.Jheng wrote:
>> I haven't used KUnit before
> Enable CONFIG_KUNIT and CONFIG_PHY_COMMON_PROPS_TEST in the .config,
> build and boot the resulting kernel. The tests will run at boot time and
> appear in dmesg.

Thank you for your sharing.

I will try to run KUnit test.

