Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050EEE7718B
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 00:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F708036D;
	Sat, 28 Dec 2024 01:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RlhXonrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1155D8036E; Sat, 28 Dec 2024 01:51:04 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D934780362
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 01:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b8618be68bso597290585a.3
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 16:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735347061; x=1735951861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzNsvmQ08to05VdZBVJxn5u98nWYYoiTNOcPOnwcvyE=;
 b=RlhXonrGljMP21odQ924fCirfst4aT7JvQMDSeZvKK2Qc82TJmA7BwSpEO7FWFEEd6
 svC8zrOgVQ7GFuaTY/KAlbFpvl1LlHzl8B1MYtNFkq42MVZl+d9mF2BRzG8sbgkqgGLf
 uci/REnFuON4Qf5XdInE/L1b8CXiXmSNHj9ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735347061; x=1735951861;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzNsvmQ08to05VdZBVJxn5u98nWYYoiTNOcPOnwcvyE=;
 b=Ysh/JkLdzYVa1/RJGDfTeDS5NrJYukLtpy6WVr4VntQ6h1VoGPi+i0fAWMrPzM1/g+
 PzlG3qH1yC44OeLG4me0s8nMWL9cqChpP5c0tsDIOdu1PWFOWzk3B/wjofx+T/AeQX74
 3pgkazo2Hmi2RWnLzqB+bw0j4oCnvmY8OrcjCO5fYhQ5x/vlWj/0Bb2pb4EkCC2oTRAx
 KliRHmIyZFSwpdPGmQvyEc2xM8M8V3gglBhOi+EGFos0WOR2/BdcHfYpogWbefAqVk5m
 fiB1c+Awwq+wFZKoj5hGGAQTCdYOKUI663E8JS15MNXc+Wt5Cf6yB3TXVp8k27ZFlH//
 LoRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUluYDMjzlNBny9bmPz/E4FoZRvRlWKnDUg5rWJYlMxHUdcSNVGSmytkjnDbLep3pYqsvRVCWE=@lists.denx.de
X-Gm-Message-State: AOJu0YxVopLBCcocVDxfjjkGc9KWjNforT5266s1FVE4QfMVO9nDaxEV
 oWRnTTWG6rUbcLQ089kq9+728CEV3vsX7NqW45bBsmsh4YTCJojZMvnz9Skdn8M=
X-Gm-Gg: ASbGnctxpUs54u1Ww26onMIUkvrG/bQvd5S6cZYlcL10eF+jTh7aREgR+Pye6xnAEKe
 v8PQKoucB+FtRqz06icBxjaseR7kG7nr+UX62IcZaJoKNWQ+S0MKCrtQAF1GkKfws8vAKy+swAn
 KQN2hFZFQt2tGHfrJOqfA0BUwDayQ1MktXrrrmfyasYEc09S0ZjolMOJPMUEpdTp9QuHU3D2LI0
 5gB3ZvRIpj4I7Lhi2SskWMWGqYd66hqQczrSe8i/KsinTH4Gcz3QSbP
X-Google-Smtp-Source: AGHT+IHTD9r2ukvxAJTbW2Tn0pZqMR9lJMWTVuHftEfyXbXU6V8y4yWDPM99dd/9WZj7g/tZotJO6g==
X-Received: by 2002:a05:620a:4054:b0:7b6:ea91:d886 with SMTP id
 af79cd13be357-7b9ba7ecb08mr3460561185a.39.1735347060770; 
 Fri, 27 Dec 2024 16:51:00 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478d9esm743669485a.77.2024.12.27.16.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 16:50:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
In-Reply-To: <20241227185051.2455906-1-tharvey@gateworks.com>
References: <20241227185051.2455906-1-tharvey@gateworks.com>
Subject: Re: [PATCH] board: gateworks: venice: rename GW7905 to GW7500
Message-Id: <173534705869.3688152.3630574107176995468.b4-ty@konsulko.com>
Date: Fri, 27 Dec 2024 18:50:58 -0600
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

On Fri, 27 Dec 2024 10:50:51 -0800, Tim Harvey wrote:

> The GW7905 was renamed to GW7500 before release. Change the various
> names in the dt files and references.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


