Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F52C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD0A88408;
	Sat, 27 Apr 2024 16:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aYIimd+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12B788402; Sat, 27 Apr 2024 16:11:15 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902788827F
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78f0593f45dso214458685a.2
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227072; x=1714831872; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TQbPstxHEBCZMgWBIzpvuuxrTnbHQnvgV+AW4XmtaSE=;
 b=aYIimd+hSbkyGOWcEca+RqGiWPxD+XPoKXi6f0YXDYiNZ68RmzR7dJWdyqJ6JIVkh2
 ldRRP/tldVsyLBeoGC6uCuW4Lese/VMQbNBn3Oeh5Hha9Kp2wiGMof5xGjblKc0vBQcP
 2o+hyNzkk0U4bzpTHR2ZmmTgit7BLinLLnMhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227072; x=1714831872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TQbPstxHEBCZMgWBIzpvuuxrTnbHQnvgV+AW4XmtaSE=;
 b=Qeuavmd4/oA2dNymL6WNp+T5w4itx+lF17ZRYMwGJ5vJeu7fiArHUjtcrstI7Wx11a
 XxfvA77fe1PGKAXnJlzVCSY67DBTYXA3mYAnSM0OLt2f5co8BC498ne4YhjcBlCtx/Zi
 nE+JHkZ02IdnF15JwfYyf4/YuuybHn/QQe20UJH0sGkDCyjEyELdeQipfO99J6Pbrn/T
 VLgwbZjSqJl8HomvBoe0/khmMVKN/qV92rQKoa8yZld1LQ1wblzG/qYpK4xDFNBRFVwi
 4G6DWImzjpm7zhdA8ip/nKegOICGUyxav4eeJGn9zziiic+fCkRHzkT1OWSL37M5T4EF
 EgNg==
X-Gm-Message-State: AOJu0Yz+Gtvpd4fRLQdSPqpymvPfOd6XSm7bQwf49Gkz/FQZRAARiPH0
 dDTEYlczrXCBO1x8bFiDlwPqcg7JYH85PMrna/P0DGwKgecJW0qBNYi/KiX0IXpi3hGWH6efcFs
 +4U/WDg==
X-Google-Smtp-Source: AGHT+IE7IUztulTexdseR4Noxxzyp0wmCeTwjbjXbaaHrhVLvV8czzUMznpl/Q/nuWenrcaHFOXrFQ==
X-Received: by 2002:a05:620a:5224:b0:790:83af:9897 with SMTP id
 dc36-20020a05620a522400b0079083af9897mr5640664qkb.9.1714227071865; 
 Sat, 27 Apr 2024 07:11:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 00/18] Remove <common.h> from a number of places
Date: Sat, 27 Apr 2024 08:10:48 -0600
Message-Id: <20240427141106.3406000-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This series is the next step in winding down usage of <common.h> in
order to be able to then remove it. This covers not quite 25% of the
remaining users of the file. Of what is left, it's either arch/arm/,
board/ or drivers/ code. I am likely to start tackling arch/arm/ next,
and depending on how exactly I break that down I may try and cover some
board/ code as well (for example, tackle arch/arm/mach-omap/ and
arch/arm/mach-k3 and board/ti/ (and then the other vendors too..) in one
commit.

-- 
Tom


