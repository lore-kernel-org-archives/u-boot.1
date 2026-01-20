Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0786ECA5FA6
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8937283A8D;
	Tue, 20 Jan 2026 17:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GRMUHKnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B57683B21; Tue, 20 Jan 2026 17:18:00 +0100 (CET)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D270C83A9F
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 17:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-45c83c49213so3632395b6e.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768925876; x=1769530676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJpMtNewBKrtGxFQzLpxwMiDdtjd5j/2UEf7bv0+TcE=;
 b=GRMUHKnNrycqqTyrPDJORcapkOmQW/58uXm5JHKPEa4C1gyIweqSiAn9aegoNIV3Rr
 tmfFxPWIEu/Hl3///n3vxEbJyIRsEmAvfUioyOftQA9sdQNqnTRy/hQNxb3OF4xke93U
 H+bLMtdS1f8cER7RMRCaI4s7p5FkuG04Yft3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768925876; x=1769530676;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hJpMtNewBKrtGxFQzLpxwMiDdtjd5j/2UEf7bv0+TcE=;
 b=SGnVyTn3pJo67wvbHeODXORdcOGx2eQ4Hbc9e59AUM4RfvCvVmWQj1yM73D115a+Gy
 6HpfZBqx+X4frnRf64ElKE5d36YYqX1q/22wrilmDXirEG8mwhf/zxFzJ4LHM31GTg2f
 Gw/6vbxVT419OhdM7wz5pD5nIITOJ+pi4NtVVLlg/hUXuuJb2+FrgdFogMiRVY13kbUh
 IpzwnAgCUxrPuQ2pjpCl9LX7995n6Rj4uvv9rNFXnpUbt1ZH+lwuj6iWx0urGTQdfip9
 NpDlJusmx6u5SjssoKsqY5ShEbTOTdfNjsVo4A4e4NdSHlkY6pDtf9mhwQe8wk8E6msH
 L6Yw==
X-Gm-Message-State: AOJu0Yz1FF2KB5bDPOnTeKUc3pmGrudozheRJ29YMtyJ0jVK6MQA5U3o
 Vsamo4N/BWV0LakWsB85hIxx2AuVAqhA9TxaoVPjfsgAuEeI9owAAsp0ToAgW3Ve8lf1x6UcyYr
 khsMt4SU=
X-Gm-Gg: AY/fxX6BRQRRn9TZjWFJIfxa8eiz5Y+PCfUydDVLMuGPhVIHlBKgdX8Gck66R7FsbiE
 zE308AiM44rufx+syh/Mxgavh+3FNUISCfFL4oUyLBCoI5Ox5TXS5BoW9zwTPcqhcNf29cbwKta
 amaCc1JNM0InwXBMhK+/0DFLzpEx2Ah0uLjg6A8Tc6joj3115xgG3TKRw48vjlUHBka0w6Kk2YQ
 8KghsYLtxJz/ss90QyjlbBT+a67bsdseXzvgkvyzVB49f9vUc3r0Wy+ZdM+SgLnaI3UxcdFq9z9
 aTVtJp+Qje34Bid7LC3h0r8ZjR9HlG0tuP7crZoimiTyjH41NW+Yyk54XBi6pXnd0o9OeEW7uzN
 JQ+LgzMCIMr3bBW2WSxp3N7xl9WRDrJB4Sg9CzAXDVcOWgXVmjrK+NsDUyhYoZH2EXEjswF+xLd
 9sQ3j6anTkV7qydEZhbKrfWUqeVD7q+N142CXHnHFedQtJ9JijwWW2LL0+8KTfZwZGuM+o/LSkk
 oIDaIvtreIKnLKiim5IzlQtiKb/LiPNxpN2PQ==
X-Received: by 2002:a05:6808:c1a8:b0:45c:9973:c539 with SMTP id
 5614622812f47-45c9bfd2106mr6036231b6e.26.1768925876550; 
 Tue, 20 Jan 2026 08:17:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28efefsm8613552a34.14.2026.01.20.08.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 08:17:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Manjae Cho <manjae.cho@samsung.com>, Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <177fa1c7-edaa-4693-8f3b-c3ceabc3d563@gmx.de>
References: <177fa1c7-edaa-4693-8f3b-c3ceabc3d563@gmx.de>
Subject: Re: Pull request efi-2026-04-rc1-2
Message-Id: <176892587549.422914.15059919746380332316.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 10:17:55 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 20 Jan 2026 15:01:25 +0100, Heinrich Schuchardt wrote:

> I now removed your patches about the development process as some
> comments came up.
> 
> The following changes since commit 6b2d05748cf3cd6ba417a96c00602b0122e10af6:
> 
>    Merge tag 'u-boot-imx-master-20260117' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-01-17 22:29:24
> -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


