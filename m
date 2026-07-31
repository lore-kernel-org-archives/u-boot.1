Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67F4C5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED128411F2;
	Fri, 31 Jul 2026 19:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rF1Wnrttyb4m; Fri, 31 Jul 2026 19:40:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5088B411C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785526853;
	bh=QuqJdYJbkuTyeK62MKHxszHHPIkw90mqOQfEgg49dnk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HuPF+VWVG1AE1tcq/pAH4FC3qaApUNqtPSrgJojxAzwbYp6C63JOTlPWrPFBzAYvD
	 DR8NdIX8hq+ZrzV9+YiikwQJCaxyzC/h4HVTNRKIusvoPKvmY245yCpIkEHK5kBlcD
	 Pr6Xu/8d1ix5PbV5Rc+nJPk1z77ukfjUKbeeB3J4rld5zrX87EzdW3BJjYTIqD2KS8
	 6a/7izU/xHRd3o90Nvcdj0G0QvAs4j0UE94AKNeBb4+jUKtQ8byZUQnADfl01wKbdi
	 hOMNzMyN8IrLeba1ZNiG2ysnbrms2WmyQbIBuLO/+XhGheBg4SGBeL9S+h9tHXN2Uz
	 VuXE9s03fUChQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5088B411C4;
	Fri, 31 Jul 2026 19:40:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E518637F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CBCCD80D56
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNO-gCG29tym for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:40:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 070FD80BEA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 070FD80BEA
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 070FD80BEA
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:48 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so924892a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526848; x=1786131648;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QuqJdYJbkuTyeK62MKHxszHHPIkw90mqOQfEgg49dnk=;
 b=LpN4hgDpFHe5ePb/zoNpoJcIeQg8amwWi9ATKdh7fuq7rAuJ0FbkMtF7s4UycLbmOM
 2rsOM321y2N0c0zyinsOpkr/ajYsBQR1KwrRFOhovLap374dSmj1wI9a0uCG021Rzmi2
 /GrQKhH97QyD9GjF1LZcnn+PMwfYZAw1oenVjOfOZPn+OfKqrmNnb52gewn39qvA3CzH
 aBYstc/mjHLu9TsJtZUBqc7qbgNoFVoMCeXzIN46vVAYCf2G/eFjZiLAQlVGTvje3QCa
 JCw2ido4ywbqEmwZCkGiIolq0M1Ef5nyoid2hSpzMOcQLZfY+n7v2gw3rmSH2apF4Ps1
 Pd3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqD7mdTq7IZJuDSuDDe+EH9p19r9gbnZY50jm1YZoDMkTahk8169ie53dMtdqPpYRYKC2dPgAM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzc7CVVJHhehCANwXG/fD5pHwvMrWJl7Y6xqmUIXbvYv6HStjmw
 vs3gjOw0VhKFS3MDz2WwCkZkoFbkNsFrXlzC/i8RLnE0vvvhVP8C1oWR3sG4TVTGPTU=
X-Gm-Gg: AR+sD102/iKFTyxPoxw9cGprAQ97W5Rxe3oI97ke5NZ24ylHvd7RIjZmTE0XB82NdDu
 Qi1l+s7p4cPjLb/Ze+/bYwbo2nkPynE9Iyrqsredk9/Ekw6AduscQQW480GrtcxcYGsyFqSWjdu
 vPmGBw5fdSJgPL/ChMdObGA0q2xwfi1FIv9zsMkUDfCXGLnZs9GRJYeSZpuKvMzJSWh8wVi49Se
 3lSYSbhJU/SoMTLn5PA+/UcdbiRDlBOiwYI8SzSsibmMXwri+p4kA5HCYYCZ+U8bWrifCLS/Xaf
 ifAoPZqA044yitXK8K9oWBUyQbAIMaMpLitdyY7qeXafqS1f2q561SDRV5u39xIq/M4SLBb3uj+
 CrJcfksvLy6diRwX5Ak80i1uW+0mvDDCmWUsEPRo90ekt/LyUXnebfePcltpJjaCVJca+cJlZN0
 YrrO9Tu7Zd65Se2d2YY6w0285aCPSWoEXGL9tW07M1OBfxE5SrKgNrz74t7gkVNHEF8FT/e0bVJ
 KQ4ORsYfPjCGPQElIDoxfgo1drksiek0cD0axX9uYkKGpuBrTbuVLNiORJBb6sf6+bZE+Q5JdQJ
 XopU1csmHre3w8g3CKM=
X-Received: by 2002:a05:6830:4489:b0:7e9:cddb:142a with SMTP id
 46e09a7af769-7f196bd63a9mr2329342a34.7.1785526847953; 
 Fri, 31 Jul 2026 12:40:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18eda635bsm1465662a34.12.2026.07.31.12.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:40:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Aristo Chen <aristo.chen@canonical.com>, Scott Moser <smoser@brickies.net>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <cd57797a-bc4f-4909-972a-228570fb841d@gmx.de>
References: <cd57797a-bc4f-4909-972a-228570fb841d@gmx.de>
Subject: Re: Pull request efi-2026-10-rc2-2
Message-Id: <178552684700.2534773.17305717759321479873.b4-ty@konsulko.com>
Date: Fri, 31 Jul 2026 13:40:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785526848; x=1786131648;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QuqJdYJbkuTyeK62MKHxszHHPIkw90mqOQfEgg49dnk=;
 b=GqWaAzjMLUBYsGqHTsrbN8muF/WpKth0UDcG69Qszsyt8iuN2zLIq3+3xUQdb9QYMK
 flm7j1t8oFxw7PzdY4FSYmmx2Fg5RbOGZou9zArpGwv5h7mQKGYYfNOFaimJV1PWbEmF
 ZyHG9U0nJRxYAX58RgX7VNfsNQQJf5WKL0mhs=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=GqWaAzjM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Fri, 31 Jul 2026 16:22:04 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 100e12ea78c73071b9710f08b32fd4590019266f:
> 
>    Merge tag 'mmc-for-2026.10-rc2' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc (2026-07-30
> 08:50:13 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


