Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708C0C7EE33
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3894882C65;
	Fri, 27 Jun 2025 00:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sALJuMnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD4482E34; Fri, 27 Jun 2025 00:15:51 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C1782B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40b1c099511so950170b6e.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750976146; x=1751580946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVWTwDF3OjB0KvLla/LYUNVqg+cMn56F+wb0FjLfbJg=;
 b=sALJuMnTAjFj9abd4rlSTlw0Z1x7UCZ2pcMJFIcruCIhNmJKxIjwa8haKoMpOKb6Lw
 DajulLV3sAQD4VLPTHAzDo8IKPMoJlhA+X3929ThnNUncCzKXys5Es2oB+xWn8ce+rf4
 Sv+1ipVw52zre8FVY4iq388x1DKoVknnBxoZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976146; x=1751580946;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVWTwDF3OjB0KvLla/LYUNVqg+cMn56F+wb0FjLfbJg=;
 b=n3JnTGykzX7Ld6uMyV35ps/7gBewhVISjmzzF8JyfBuMKMSnOkfwpFQzJvcdYrtq5l
 848cGh1bjIra9Y8M33Jsqk7HflETtFENh/SSFd8QLOciGdfPMazba7VE4Bb4hSqfeExq
 nvaAmlKP/MEsU5ES6Mv8oW2tK1Jye0ZlCGrJMYV5n8Ocf/lN+KFt189F2SpKiUvnYTzB
 pgRIs8erIAfYZwuR2US/BuOHClPnMvlA2g7anLpIuG0lCS8UPNOi53IvSw9DwrwJe0v8
 HPaCMeMEY10p/TTBBj1bnvh3Mt6u1ALdpuylhW8s4Q2OjpFgAY3wcACLDZKKKXg++xmz
 E58A==
X-Gm-Message-State: AOJu0Yz5ovUF3CoFYJ84+eIFfyke3xECQ6cSK/+B1yiDmHfTh26ccj/s
 VoXI3maUKs8D8OedYQrZ4b71pyoZMWZgcl6vjCITFI6strb6gmBbV86sFnJzEDq4PEjesh9yxv4
 aeDO9koE=
X-Gm-Gg: ASbGnctUBYOkBRndXZbJl3tH3IDUtmtM+6QQhxeia439sy50ZwdYlU5oZy5cgf8KnzS
 IvQhQVfmi7sLTFxvWArK2sdzjAMdertlxuUbL+4TytxyBPojaTkB8zMV0RgYAsilPCRm5Fwq1jX
 QXEfr35+UQaXI+cKULQmfSj2sy/IrIuLzPtFOkNbSV45baEfLW2tMtiXSXMopJdQ44xwRBAGsaZ
 WH3h58xWs6foEQgUowXD8IfiuXlTTzp6R6tFEtbjPV2G9ydG1rK2M2PnGmraDY9Cr82zlNZs59I
 1p3f8InA1Hsr45tfK4RcR0ME9ScZsDQQI3cqf4/wjHQQc8JtdvxrS0wy6HpAm9dEAZRO2d+tBOK
 VCDoAUZof77aO3jb9ECWjMQ==
X-Google-Smtp-Source: AGHT+IE91PRi2tEoViPRbB7pa43JM3VVb0fJVgDmMYzEs7xL7lmPTJlc33irDJhrwUkeim4LSKdOWQ==
X-Received: by 2002:a05:6808:309c:b0:40b:11ef:e955 with SMTP id
 5614622812f47-40b345539abmr615007b6e.17.1750976145618; 
 Thu, 26 Jun 2025 15:15:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32289ce3sm129676b6e.6.2025.06.26.15.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:15:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?=E7=89=9B_=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Cc: Yao Zi <ziyao@disroot.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>
In-Reply-To: <SY7P282MB5675687EA430C83D458678F89F77A@SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM>
References: <SY7P282MB5675687EA430C83D458678F89F77A@SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM>
Subject: Re: [PATCH, v2] bootm: Pass SMP core ID and DTB address for
 ELF-formatted kernels
Message-Id: <175097614463.1909185.14337060950188828845.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 16:15:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 13 Jun 2025 01:45:28 +0000, 牛 志宏 wrote:

> When booting RISC-V ELF-formatted kernel images (IH_TYPE_KERNEL + IH_OS_ELF),
> explicitly pass SMP hart ID (via a0/argc) and DTB address (via a1/argv)
> to comply with modern SMP-enabled kernels' boot protocol requirements.
> See https://www.kernel.org/doc/html/latest/arch/riscv/boot.html#register-state
> 
> 

Applied to u-boot/next, thanks!

[1/1] bootm: Pass SMP core ID and DTB address for ELF-formatted kernels
      commit: 7fd2795a4b824643bd04513891fbd5e23101ec8c
-- 
Tom


