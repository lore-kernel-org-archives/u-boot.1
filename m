Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4712D74945
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540AD891E4;
	Tue, 29 Oct 2024 23:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iB/xQhV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CF38920B; Tue, 29 Oct 2024 23:28:40 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B563E891D6
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b150dc7bc0so454426485a.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240915; x=1730845715; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HLwrrOK648GKTGrOfAXadFJeVIt1lVRoeRXymFGQW1s=;
 b=iB/xQhV4Ea0XU86rsIBloOhxAJ/1fK0G6RJLcA2s6jwHCwnZe5Ru/ZU48a9oBbLXQq
 US0U8ZnMdWtRZ8m257JppyBVs+XO4mXTO09xn9k91ClVz1rBakTbBt1aszQ4nJcSGthV
 e1l+oSDDySCXVvPXnEstJyd3Vihyz2iiiQsjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240915; x=1730845715;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLwrrOK648GKTGrOfAXadFJeVIt1lVRoeRXymFGQW1s=;
 b=M2ZP+QwdR7DkKYJdzzdblgcd/j+TGcyButNHjeJC1HyZN/JiM8/pt06Pbw9y2adSJp
 XbNvbPHkdWWHSp4WNFGA34uIQpREcg9kmNA0bhrzKQt2kaeT9lyKTPXIJPZ7+Fub2l2+
 iF3biSho31NvAqTuScUJhKJ+VAGQeTptgNbTGCpC0vAZJbbWWQu9sAWNcCjLJ629nPF3
 PozYCeUGb/79t5AsAX6XPQM2rSsZuEZj05G/7OgtyUjXAQWbg0EcUzIQpSPEHTp8zaJg
 ZfXE8zlQoue8aEmeRDLULsHCxiV5XG4tTTXY5m0FOOcLicB+P0KfZyyZX1gDouoKOJfo
 B+Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzSzbQ++mbUicSgaqANccGmlPHuSdJOVuKaA7wJP/6mf71IeEKVRFmkb/bwFc9XVJnnvVIvSg=@lists.denx.de
X-Gm-Message-State: AOJu0YxDGzHUu+B8a50yaoCLXgR3bnnbb5XpExJwyK5SxD2+7mOtM4G1
 bsGbfw4xnagEKfzuz2P2zOODlV3hblcBfAPsEAclMoX6yJ7wYbZj6zZYDcp66aQ=
X-Google-Smtp-Source: AGHT+IE1LoFiJf0684Q00et4JeMiZOe9DdtghyPTC4KHVYkWqXlrqp3YrZLiQQmFs5Hsw05ngF/BOw==
X-Received: by 2002:a05:620a:1912:b0:7a9:a3f7:ef30 with SMTP id
 af79cd13be357-7b193f3edb0mr1979499785a.45.1730240915677; 
 Tue, 29 Oct 2024 15:28:35 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 BMC-SW@aspeedtech.com, joel@jms.id.au, fr0st61te@gmail.com, 
 clamor95@gmail.com, marek.vasut+renesas@mailbox.org, michal.simek@amd.com, 
 paul.barker.ct@bp.renesas.com, piotr.wojtaszczyk@timesys.com, 
 andre.przywara@arm.com, jim.t90615@gmail.com, kabel@kernel.org, 
 caleb.connolly@linaro.org, sjg@chromium.org, ye.li@nxp.com, 
 pbrobinson@gmail.com, u-boot@lists.denx.de, 
 Billy Tsai <billy_tsai@aspeedtech.com>
In-Reply-To: <20241016085955.314236-1-billy_tsai@aspeedtech.com>
References: <20241016085955.314236-1-billy_tsai@aspeedtech.com>
Subject: Re: [PATCH v1 0/3] Support Aspeed SGPIO controller
Message-Id: <173024091343.2563570.5673175724168163294.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:33 -0600
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

On Wed, 16 Oct 2024 16:59:52 +0800, Billy Tsai wrote:

> AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins, AST2500/AST2400 SoC has 1 SGPIO master interface that
> supports up to 80 pins.
> 
> Billy Tsai (3):
>   gpio: Add Aspeed SGPIO driver
>   ARM: dts: ast2500: Add SGPIO to device tree
>   ARM: dts: ast2600: Add SGPIO to device tree
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


