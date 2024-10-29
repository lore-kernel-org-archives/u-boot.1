Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F45D74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB90891EF;
	Tue, 29 Oct 2024 23:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X/kjxl5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB0C891AD; Tue, 29 Oct 2024 23:28:31 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDF38919F
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-50da1fceeacso1823701e0c.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240908; x=1730845708; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/+C3qjgyI9lgIIko1BQx6S7MImVTmc7xXLZPMXrIbc=;
 b=X/kjxl5wjYmIUSsnJkrG1Zr94U33AxZQqQdLG1GUK1CfZuEe4tvqSk/HMD6GWCFUS8
 K+iTSWJLEffRp7+VGLw+pBwsyyJ4OLip+9nwPXpqV+yKlMIijWFSBPLdj1K0QEi3a3rB
 ZjtzJiOGYFAcz+AldaSGAYeNyYYzfDFusuF/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240908; x=1730845708;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/+C3qjgyI9lgIIko1BQx6S7MImVTmc7xXLZPMXrIbc=;
 b=Lih89BVHnfO0T/HMAAddQ267rbqPn7yDDDaxRovVms8pE6wTv847Th42lHRlX/idGG
 h+b+v7EJgeYL6f44mHS8UAs8T8iP0HgNYTPt9ZEhsjvj4dFBDhKQvDFmSUzpe0QDfLgs
 GngMTh/w8ycgp8L2IM63sxmk/aUoLOUHLCUzDU8i2vBKjhxtHtOZwpty778qELyyQqjY
 B40uuzVmWX7zAh0/YCmDf/Z2nwbMErHCrWNGKWCIxomXAFbgBndp1uoMEcTprpd49Sce
 7TSyE+DAFZeWyWjgpcy7b1zdCWSuj6G7b0qtCzPX3Q20r5rL50dplC1wTdlSS5qEatyf
 f6fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKevjduwLDC6BaJ7zRtiATjcdo/Wu/GQNlsh+tcdsgHBd4sREpn9pSjXxezKeJ+k/2d/O932Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyaHB3p6SUHp9NnPuDRpYVjysh1ft0ocVv0ZV8dE+kLmkpBMJJK
 VaFMVcrTwimtCbr+1xcyXfXaUNV70rekvPbsVeE4um7vQhc7nowPQ1ng0g2RIdSuAhOMA5MKkfX
 fPBw=
X-Google-Smtp-Source: AGHT+IEQ5Uqop3m1yj6MdEQMFVgDRvm4OGnBX4ueRxAB44cV6FBCBi0lntlC0PEkUqOTNFwdUHIbvQ==
X-Received: by 2002:a05:6122:1796:b0:50a:d1e3:82f7 with SMTP id
 71dfb90a1353d-510150f1a8emr10729193e0c.8.1730240908659; 
 Tue, 29 Oct 2024 15:28:28 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20241026073310.101619-1-ilias.apalodimas@linaro.org>
References: <20241026073310.101619-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] cmd: fat: Make do_fat_size static
Message-Id: <173024090770.2563570.15895381453007838196.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:27 -0600
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

On Sat, 26 Oct 2024 10:33:09 +0300, Ilias Apalodimas wrote:

> This is only used locally,so make it static
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


