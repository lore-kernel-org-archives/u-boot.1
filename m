Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54A0C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 14:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334C78144A;
	Mon,  9 Jun 2025 16:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZARgmQsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FF18144A; Mon,  9 Jun 2025 16:38:00 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F4189826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 16:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-735b2699d5dso2439863a34.0
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749479875; x=1750084675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5HAbQBMigFlUCY4HZpmnnWY67u9UtHP0mGXEkgS8x0=;
 b=ZARgmQsWXS6+AHKNuNFujtoD3UG+A3Z9yj50ZiX7BMHKvTxC0qgDB3xw3rdgftRds3
 6xuQM4h+24mgkCH3Hi/XvGseoLX8mumB08dDEPHh2rFYvrbSlnvtnHXwl5E7pQZKo0nz
 +RnlmsLS1qCYrBCGOWjRAo8x1taJjIsF8DsVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749479875; x=1750084675;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5HAbQBMigFlUCY4HZpmnnWY67u9UtHP0mGXEkgS8x0=;
 b=QjWzJOaQw1lDXlmTfo2EUXkiMVXynmsrs4UNZ68Qs5YkhMmleluvjmehNeI14M7BDf
 7SERt7flO3GzJ1+jguLERIuH0iizaJ27wgKtPD8zUFQgCxp6yGSO4lqSKwp2fuw4lsxw
 ZnbLkJro0ZJMQq1oDFQYXwa3BAItTmZD66W2btL5sQG/6Ko1euusVfojDAFFl9sLREyI
 tWyLcNP/X2IwUT32JqHaMIifDVrMS4e2zpjWjXoN/RULtnv02RImrv4fJDeJVe5BBw01
 BYE2Zjtare4D0z6wGrEu9FhJzRQEXggZCcHqft6g0ONAQ4reHXH6XMV1weVHD9aRprrH
 TO/g==
X-Gm-Message-State: AOJu0Yx5N5AD75DT5IK38SGcBF7LIMDWnQiL4PCGqoWS9df11+0CSkzY
 kBqlcJWfh54azFsI22xMWOuwoj/IinLmCQi92Xb5L38HLGEHB7CbqIeXBFP/q3GAgI6kPGRpvsG
 7fyPeqK4=
X-Gm-Gg: ASbGnctuYoyHRqfmh9ua5hlcW5/L9x3Xv8LyHKguLaKblvZi9ACL2JxOMND7CwYiMVJ
 utiVycg+EJRpssMKkre0ZglOd+stpm82AWjI54IRfZ7SL6Npq56LHR4AnqiL9TgRug6d+fWilCK
 5C9kvF7gtv/ip68yzkupYLnXY4YvOTTfVbt8TTbqPkPASNbhB40U2E4CflGWWS1Ef0h5zM3EGYP
 kYbTPN9Bt1ug+vAFuYUEeUhS/3g0lu/05CU2XBDxY4CN2kW/icCV9Ul2oNLKz9CpZvjO5Tc+7fQ
 SwlfxHOAp3RRj7mWYu5RybV5SM8IdExyUxXiPgeZ5EVC/0vWhQ1CY01ED/L5HV/ARHzcaoybh3t
 GVbVZ3mplgm4=
X-Google-Smtp-Source: AGHT+IEQtqB1i5EvQSFoea0+TcJxOvNpznNCcBSo1VnNDJhzmN8C87Tajmia+lMC0/A96xvYE9FTOA==
X-Received: by 2002:a05:6830:dc1:b0:72c:32a7:8830 with SMTP id
 46e09a7af769-73888edb2b5mr10152956a34.26.1749479875633; 
 Mon, 09 Jun 2025 07:37:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7388a06e8fesm1591948a34.55.2025.06.09.07.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 07:37:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250608041536.329837-1-kever.yang@rock-chips.com>
References: <20250608041536.329837-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20250606
Message-Id: <174947987473.3695250.13259021213696036928.b4-ty@konsulko.com>
Date: Mon, 09 Jun 2025 08:37:54 -0600
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

On Sun, 08 Jun 2025 12:15:36 +0800, Kever Yang wrote:

> Please pull the updates for rockchip platform:
> - Allow to silent TPL/SPL debug console;
> - enable exFAT support for Theobroma boards;
> - Fix SD power initialization in SPL for rk3399-nanopi4
> 
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/26117
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


