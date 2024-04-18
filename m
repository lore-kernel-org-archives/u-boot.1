Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F0C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28996885A7;
	Thu, 18 Apr 2024 05:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZOOQJtFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78B798855E; Thu, 18 Apr 2024 05:40:19 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0903E8855A
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78f05e56cb3so24260685a.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411616; x=1714016416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D09qtatBf0a4fXIIWXvwa08qynkYGI/1VcS4oWARxd4=;
 b=ZOOQJtFBDZ2VKHf3yjQzbwEG8PHy1OqG+uvc5PZ1mhsdHtre6inQgApmJlkSFjHjlp
 O06Z6RxUnAWp1rsEdayW+AS4vwtIK2slyzdfWbtUNyC4cs7p47rXMA7+6ZwQhJdMc9aG
 BTcBSOd3VO/XB4WRFWCgKZbAC9lS8DcsfhN+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411616; x=1714016416;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D09qtatBf0a4fXIIWXvwa08qynkYGI/1VcS4oWARxd4=;
 b=R/1K6MTx4jvAX8w31d/XLmkO/ylI+0+oPeTKBSRhPGV1hN1CBCgiXP8smTgMtik9iO
 2tlwpJXifDmovkRRWGECxH5DtlCCtrD5Igl5Rl+K+rerB7eO5XDRYkDzljaru0l18hSi
 em9bwySo2MJuUn6gNct99/Kc1NkhOma2OBG/HoowHQUfpcWHvz3H9Wdz0BWHdIS8LrT1
 1zU2aolGeHKfzxncXkbFE/YJntr48k5jYUNC6BvhCcg+zRdM8tWtUTB6pmP+tb1u4WsC
 gZ1IdvTaWiZCzzuR/JMtBrQ1Ef6Cs9ldNWMXrhlnWMdYsoGe5vC77CzF9c0906JX8VOS
 A7xw==
X-Gm-Message-State: AOJu0YyCSXGMiuLV3abX6+WRfHxlDN7ZwdX76rnON4cf2fDxCgm796zo
 qhzhnLUSok45SBUQMeQ+39vgOwecJgVSUA6kYysjdVTZ3qA/OHOr8PaRU3qHGvo=
X-Google-Smtp-Source: AGHT+IFzQKT5hZ2WPFSrLNhBtSJF4DR/ikvfRq9mPxR43ijorsw6gpjTM1LSPRh3BbQftaX23i7/Yw==
X-Received: by 2002:a05:620a:5597:b0:78f:a04:d43a with SMTP id
 vq23-20020a05620a559700b0078f0a04d43amr1126196qkn.8.1713411616012; 
 Wed, 17 Apr 2024 20:40:16 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com, 
 Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240410055437.3439213-1-JJLIU0@nuvoton.com>
References: <20240410055437.3439213-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] configs: arbel: Use generic timer and npcm reset driver
Message-Id: <171341161486.1250683.10107159036377931704.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:14 -0600
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

On Wed, 10 Apr 2024 13:54:37 +0800, Jim Liu wrote:

> Modify defconfig to use generic timer and npcm reset driver
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


