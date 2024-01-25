Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43043C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 19:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D49876A7;
	Thu, 25 Jan 2024 20:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="Ezcm8NZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C229887A2A; Thu, 25 Jan 2024 20:46:45 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF600875FC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 20:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so76727745e9.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 11:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1706212003; x=1706816803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSLLgchAL/UHCkGHG1cHVvoPF0FdrJ70tqOB6sUrsRk=;
 b=Ezcm8NZriT4hyoBItWdqSRNwc9YLlRBEL8ZmS2ama5vzZVPPX96ChMV3+C9xBDWEEM
 sm+NeSJJtKAGlqAHrq29kRCFKK52276yqsGtd1bDvdw1F3bStpkzdBDjoW+DRKlXsLCz
 D8ij24QxlzJQkqlvkltxa6mFseHjigdesBe1CB5d1zT7Y4yQ82sqE7L09pwuINzpax9l
 tkkKZgM6b/2imCUVppnhtmzJQMDPuR3TW1TcWrVf6xCEdUcrz0V7e0nf2v7mQGGrHWL4
 t4KQwjwvqMxKRFl+moggedU2qsI+6ZJpw+wZmhOqlMl8R5bpM32OmP+3+7nqtzO7RMIn
 6Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706212003; x=1706816803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSLLgchAL/UHCkGHG1cHVvoPF0FdrJ70tqOB6sUrsRk=;
 b=KTstAaBIGXQEc+a+e4yp3TV5FLSuK88iN8gWCFM6XToyCAQASPdEN/4JFQp2I4MtWr
 G0zqJMCvOicXh7EhcRymib7XXqMHPi/qr/VM8kEHJvgreX06Gmdc88TaDnTKVpsoIyFo
 NgvbBFG2YTmPJ4zS9W+Dkzo8+4hzFAuI37xuDvDVsd7JgRB385jb9DPdU1OdSUAA2O0p
 YT6RPpn2nRO7vWqZmwAtVDzVB2zVRCaXfgXSNbuKEzfa7JtbGO3a+WmSbQfoTAfx06S4
 EVbNNiHnoHpVhCKsC7WsYvSvr4pUpPcZh/OY5jihyKOq9oxTkvyzCPVXMNAndMtSEZY2
 k5Jw==
X-Gm-Message-State: AOJu0YxuzvCD7qCbr+9jRsQiciwakxOAYf1ogMK4VtU5Tl3tM1rYrd3A
 ONq/AobwTqpY+D2APuuB8WvzzzjulouexLPTAZZCo1jz/96mg2qdP0MciOxq0no=
X-Google-Smtp-Source: AGHT+IGL3BrPHxQIbHBIGG2ApwrKL8Q4HdRawuvIqJMGOB1VXrCLvtCfkwEkXD9HqQnn5o2OCw3MaQ==
X-Received: by 2002:a5d:6303:0:b0:337:9b58:6b8d with SMTP id
 i3-20020a5d6303000000b003379b586b8dmr163819wru.112.1706212003014; 
 Thu, 25 Jan 2024 11:46:43 -0800 (PST)
Received: from arlinux.conclusive.pl (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 v16-20020adfedd0000000b00339230623dasm15711094wro.71.2024.01.25.11.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 11:46:42 -0800 (PST)
From: Artur Rojek <artur@conclusive.pl>
To: peng.fan@nxp.com
Cc: artur@conclusive.pl, jakub@conclusive.pl, radoslaw.adamczyk@conclusive.pl,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de,
 uboot-imx@nxp.com, wojciech@conclusive.pl
Subject: Re: [PATCH v3 0/3] Conclusive WHLE-LS1 support (was: Conclusive
 WHLE-LS1046A support)
Date: Thu, 25 Jan 2024 20:44:23 +0100
Message-ID: <20240125194423.194649-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128103457.45802-1-artur@conclusive.pl>
References: <20231128103457.45802-1-artur@conclusive.pl>
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

Pinging to have this series reviewed.

Regards,
Artur
