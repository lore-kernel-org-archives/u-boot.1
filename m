Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8184C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 20:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C57640859;
	Fri, 28 Aug 2026 20:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tOB8GObQcyt0; Fri, 28 Aug 2026 20:29:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787948960;
	bh=IWomUJVirFSIL4qORdFfhIZR0J3InPc02hPNhK8/GH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0EqNrO6ym/jsaY8Pv4Bh+K3HRN9rf1nbfuYK3Y/SpS1HBWusGGN0CvuC+okAFoG6
	 JC4+772RxhX1M233SfYf3aKEimwizwvVE57pn0kqa0wwLv83X9uYEqDdmF5Hq+Fgbp
	 UiJS8ETW+5H7mzBjRjRHSUaZKpQEu5YPRN6GnZVmdRge41Xgn4StVAoFVa1w0qiS46
	 Xn2oiWcSLnZ7KIUDANHqdxYXhTRka3JOFPA+XxstsE853ZVrcRzYG2NsF//WvQty5p
	 ZTvzAaCVYcdp9+i4nf6O2HoEkQFDzo3VpwTHtFv77Br5dMrXJ8C4D8fGSQlFgveoZH
	 eSUzYvEIv8R8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9490740A20;
	Fri, 28 Aug 2026 20:29:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5802423E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5604440856
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qsZcTzLPR2-n for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 20:29:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PSO45lJh
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92E3E4086A
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 20:29:16 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-48a0ca07c38so1626223b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787948955; x=1788553755;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IWomUJVirFSIL4qORdFfhIZR0J3InPc02hPNhK8/GH8=;
 b=PSO45lJh+dkhw2HgH0teqHYaJ7KmQnd08PzdT/GznhIynnQULC6wBlj63D8HkLXrfa
 7MgT57v7lVQfnA/n68mV1M6ac+xfUp5CCk4Z3+Gus8lfVW4O9sXmFxAsz/il9F2OPmZp
 xLJlpH/zH+4lY4Fn5RpAQmWR6vWuIHa5ehz7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787948955; x=1788553755;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IWomUJVirFSIL4qORdFfhIZR0J3InPc02hPNhK8/GH8=;
 b=VZEftkEEGTdph0zFPv5YgJrShLTH4ahZZwhyS1DlZ8kz+y2naisDLzz2NxW8meixRC
 lCoq6t4rOfQQH1c/CG0nJgrKr69YNHLte2ZH60cD2x5ZaW9LDS6C+6NQy0FdjwpwyoOQ
 iG39shtwHDRxqL89Pu0GOOQRHVZegwasB34E4k7CaLZxG2NbMo37J9K8FvXmgUcNy+eT
 rwLO/8KrNeKv961vdPqT5k7pevloLOXpy6+kqXXCUhsyyCEZ1325DlTu8RKftZqc+Yvg
 We1ExSFaWQOD92WmPtd0XgyOwPtXRqAgS4uDCAuls9q9To5Sq3k1eMUMziv1GW9ZEzlR
 RRLQ==
X-Gm-Message-State: AFuF++l7ALDBFEYPo4vbjWaMw54Eep5fMHiT84Tkt1QKaVbnP1czU8ZE
 mwRwj5j8QpbBWchKeLZlV3xXbG70KFloT1zhWW4jCZGazUKab6UJ3nMAoYgCh0JgYn8=
X-Gm-Gg: AR+sD12xGy2uVd8ZkfSDYEziKiFWcINJReN9gP+37X+ZBWd+ta/ILKSBvlr03c2vFVQ
 XPlUUbTJYIuDGfNlm3tfDktXr37aiI9ZSCSjog1a433tPECGpw8yMYlBWvrJnmB8eqoKvq0OzBJ
 0NacaR3Mvjrm4SGgQClHMFBhoh3RO8n6bJz9uJ+eI+WFWt37936IpjZNEH+bQnITmUPdxWvyY8C
 5V9o5B9nqSj5mq3bkSlb9CiYrvlB9vkTtzL9BAPvTmsrMVeqfe//yzsqD1bu8NEWyMxH3WyAtcG
 5MVEHweDp6IELSr6pXW0eRwBnI8NSAF+mpKezLca3/6JWzk1PuRJD5LDobjXg+v+5FUd+XQd7Pi
 TCkfvzagz+htclf3/QTuFqQtBu2lvfa3wY6LL3bhfmcZ0F+wzUl3M0ZuYUgIK8L9pNZ3mYvK0aS
 WhYm2nlIBL5LFA2tmF9hXR/IL7tbsAGuoTSUfjcU7v2NARoV0O7pNlKxqhlD0hMUEPwVHLs+RBJ
 a/e8uq8SDuhy0md9/Pdk30cVBdL0jkovBqEUxWFbflh2iU9me7+IpiMEjY2+UBsG3n30J3spYBU
 sPME27qH
X-Received: by 2002:a05:6808:13c5:b0:4b2:8d9e:de11 with SMTP id
 5614622812f47-4b3983a15femr10927015b6e.19.1787948955084; 
 Fri, 28 Aug 2026 13:29:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995b83sm2100578b6e.12.2026.08.28.13.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 13:29:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, 
 Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
Subject: Re: (subset) [PATCH 1/2] MAINTAINERS: Use proper Orphan status marking
Message-Id: <178794895408.264202.4358718026780563788.b4-ty@konsulko.com>
Date: Fri, 28 Aug 2026 14:29:14 -0600
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

On Mon, 24 Aug 2026 10:32:51 +0200, Michal Simek wrote:

> Orphaned is not correct status based on description.
> s/Orphaned/Orphan/g
> 
> 

Applied to u-boot/main, thanks!

[1/2] MAINTAINERS: Use proper Orphan status marking
      commit: 65305d0e450580e611eb13bc5079e34dcbd35964
-- 
Tom


