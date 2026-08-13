Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EBEC5CFDB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 20:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F085F8143D;
	Thu, 13 Aug 2026 20:29:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-_TYwXfKfxQ; Thu, 13 Aug 2026 20:29:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25F5B81434
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786652944;
	bh=4nE7QEwJN99iCM7GYP3L0FY6Ns2nKhb4qxHfn9xitZs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oxEDX4S4HMp9Rt5xc5cJDhJF4HFl9PHq2ebHyzwn2uky7auOyrNgGrXMmiZxWtttT
	 ui/303Hne9fHU4tDo+OoAFTRT1mfpX6I70C0NSClNP9LrH2vQ1gkO/vVh8BEfkPodL
	 gt39vpKNtel3YSY8qcQaLnyEBK8RoFROvqPlDfCtp1kOu12KACcftZsvD7wWWpH/eL
	 I+cFMGQ6E66W7LI/TVa0eld3YSQi3DnFBpxm3vCmlMtilt1Fr+GXFQ5cxUpHWD+gfe
	 GN7QW6zfQw1AsGBfrzOLyJB0LITu3jZS2tkpahYsVLheR+LWZZh5h1MUiFY4IoWVMR
	 bekV0Kg0hjJtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25F5B81434;
	Thu, 13 Aug 2026 20:29:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CEF45198
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEF638142B
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:29:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jbrBJpETLuJW for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 20:29:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BB03C81358
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB03C81358
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cHu7EQn0
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB03C81358
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 20:29:01 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso162762a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786652940; x=1787257740;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4nE7QEwJN99iCM7GYP3L0FY6Ns2nKhb4qxHfn9xitZs=;
 b=cHu7EQn0tRCNdvJXIjPmb0EZIhf+55eTjvRBORh+YnnoRf1jCQdUsPwW4wyx7w2WOD
 CA2eIRRuGfprb0BZnif+SrC+Pa7kfVNk0Mnj1+wVkMcRNgrJ/5YsfpWXOfJ4Igyiyy5y
 ZSBcvZBGYzzydBQlP8hlnto3w9xMNKEhPIj4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786652940; x=1787257740;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4nE7QEwJN99iCM7GYP3L0FY6Ns2nKhb4qxHfn9xitZs=;
 b=CZuKLqr2Ynfo0yUO3XLdAndj4juknz1JqSf9xSs1/xZnKqxVuTh5OdJAyitVcU34pC
 Atp31Zez84KShopCcdqph/fDmKcQWDnWG9WEtw5H2/jOpYsWB1XgCmDzLCvIsRSQs9M6
 UArXlGYNGJJoDJ7quzWu6xrXwTdM3KdStX+GpKkQdyuJU9ujXbMPGaR3niDBykGU0Vo7
 COPCQhWnraYiyvCWuelKLjY7QvMArHSYoALfBEwGbIkuaqaFNPe0kpVANGGBOUqwtPfy
 ZuvKtZBIIdF/SPepndexCXgHMmKQU7BH+qsO59LvrCN0Y5E0Wa9qx7dVn1Z2fEjIL30K
 QvkA==
X-Gm-Message-State: AOJu0YwhbZMi738/cS5nscLN2US53cEgQBoQewPMNZGe9PMGU0m8zwY+
 DwOiacMQX+cMgcMnmsHj1jQT/IIzOJntMDHXYLFS/R7pJ6zsHbZsyAx6nNLPsAvLhgc=
X-Gm-Gg: AR+sD120BVD8RvdMwEJ2GF0uJ6dl5P29Q3jFdR1n5+WNZkOe5GTTTvABGoF14O7PSev
 VCZ6bcjLecba5NoxtxUxqgf65HQES7p905sD/oyOgMEeNi6H2D8qzVm+rddmG0walPvBlRx5Lf1
 e1ScPpKHHpZnigyNtLh8b+lBaauf9gcOiYRkDgGiYOQmT2KKgaPiBIWZ1Ndjh4jP41blPZBD4gO
 +TkFxcA8Xj12pDVD+Seo1AFeomILSXG9EvT9NfhfZE5gRm1FCGh/jBtvHZ1ahlmqX1fadoycHCs
 9xbb+LcRBCQ2LFZu1tV+dmelrKrhpoVcrkszfpvz4XzmMKKLWX0u2YUCMwiWY1E458eB5WdzGwy
 ULEWZjh7Hr4ZGuGVvOcRcFAHF1ZbgB46NxIYm2uyeR1Xd6sdrNO1WDdnqwhKCINkNnfeNclYha3
 7d71tKCWYW2SNEN09GJJuYWTvTljv1Ciyhf9hZKanqISQy10lt94KmYvAuj80lW7fx+hfe8t6jE
 UAokW5VL3HY4UwFLZqcmQ6by9Wh03KOV4p5HFJRUCzTX04vIuAHquIVv2WEZLlb2BkdqYsQ3Dpo
 iGWDf/tQ
X-Received: by 2002:a05:6820:4ccb:b0:6aa:de55:1351 with SMTP id
 006d021491bc7-6b0d6931636mr946399eaf.33.1786652940607; 
 Thu, 13 Aug 2026 13:29:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e8f96010fsm534033fac.7.2026.08.13.13.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 13:29:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260813165822.343623-1-u-boot@0leil.net>
References: <20260813165822.343623-1-u-boot@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2027.01-20260813 into next
Message-Id: <178665293997.3647751.2713652871344987857.b4-ty@konsulko.com>
Date: Thu, 13 Aug 2026 14:28:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 13 Aug 2026 18:58:01 +0200, Quentin Schulz wrote:

> CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/975
> 
> The following changes since commit 5a92645e1f9020d24d19e03fff2ae63f30080770:
> 
>   Merge patch series "Add eMMC support for Axiado SCM3005 board" (2026-08-11 14:55:40 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


