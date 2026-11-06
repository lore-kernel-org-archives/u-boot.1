Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B9606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eg1FlNnn;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=IDv6dKbR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEC28408D4;
	Fri,  6 Nov 2026 18:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eJTx0lHBXpVr; Fri,  6 Nov 2026 18:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 11E4D407BC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988416;
	b=XUUx1IEASQOG8mNT1oVUx51Vbf1BtM8tPBZfAOpSAcxOFx44LvefgIIcB69IQpo0sOa3
	 ZlT+A0M+tLxrRhgFIHRcMLOU20h+F8eKv3Wf678Lco+DjBKiJ7r19Sz437NWyRovx1QFO
	 KPWTVkf6VR3lby7FCFsyNABBBsD64jhkaKJGCm6kMuV28xjxFueek8nFzB9g3caA0D1mg
	 1flPb56NlRLkUrZe6OgE315oRUKKyyxCn5nxI0WDiuMuMc+3vEVyZTIEOc7kEi+Nb55HC
	 d5tVEeK3D3h2yqc5y8uhCyt5t1e37zmGyNlnLufx1ahWNUXPS+WzGZN/YiiQx0mCmkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XNGrvCSA0nCG/aw5gVjrnBRvxyTRhYElJVAtRM9RwqQ=;
	b=E1MfV/0Dfe8pFKLRqDem2Fqubxtx1gKwsUALjVeq72GTYXNB7+JIyGFKpx3F96TViHol
	 B1av6jLzsTDg2pD3J8tCFPuBm1i1GgZaTzYa1XBd3CFcAygIbB8ahtgNdRvioGVE+wW+L
	 1HYmn9Sl4P/OSHYUmFmIXPs6J15lSgENylSGCuLYjRr8opaZ2/zmPEVZ6TI5ztpqc8YrB
	 jUU18HQkCYhgNhI3qHiR3xHiSWWTbbgA2on5134bhDn/pRZXsXJ++T5+JEm6cKl2GxRyS
	 RV0J6UIlXMf4byZZAqdXZi/PiAMMae9NsfIAAc24J93aaakUxANj8H5Sr9Wb0IW686g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988416;
	bh=XNGrvCSA0nCG/aw5gVjrnBRvxyTRhYElJVAtRM9RwqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eg1FlNnnN64n/I7TGTVN+mtS6nSo8K6v30JuSY7X5ECiOdDI3R9jP5vAVjov9JJvF
	 V/seI1Xm0GqCM6onX00DVYAyYFyYrw+J11+8wiJyiMaj2EFjuQVW10Al3/3uBWK1iE
	 lQjs4FhzWp5weCXf68Z4kFHD9UbC9Lh7lL3H4jjNYs1X3178yy8nDGlzJfA/FusXu+
	 QhUo5RENZ9AastoC2zO6b7KWs26RcyrMa3CnvtDrPeWdJAJSuDHL1wvuGyjNd7YSfL
	 799R4MnCZch1+ZnGBLp05Pkky97i0U7df5Obj7iiAXIPKbSp4Tpd9cvzLufyOkYQNR
	 9wbvsFNbqgM8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11E4D407BC;
	Fri,  6 Nov 2026 18:06:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF2B82AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCAF1403D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bifQTxL3SUG for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0AB1F401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=IDv6dKbR
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AB1F401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:06:53 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 46e09a7af769-821a4a69647so572912a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 10:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793988413; x=1794593213;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XNGrvCSA0nCG/aw5gVjrnBRvxyTRhYElJVAtRM9RwqQ=;
 b=IDv6dKbRwQSR2wxrYw1YnwyAG367LtLoEtYz1E+9TwlZM2dsj74EHRd5DZyBMtFzwo
 mqwDhczegIl4XneH68dtkONyZtMj0zxDWpHNz841DP6CtzAUqNZHJwqpiLDWrsP1+LGu
 uC6xcO5Xp3Q2fBDvZqIIMYBKhuUF4917nQNjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793988413; x=1794593213;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XNGrvCSA0nCG/aw5gVjrnBRvxyTRhYElJVAtRM9RwqQ=;
 b=dk0y1Q3nDGtAJWltly7W1bRSfesvfDX0SMEXMUSsNklKwO26ec+JFv7HzLE1B24gG4
 X12Yqm71QUsR4aeDYxABRl/P0LL5zGqVWyxC3sVsDGMrkqQCovZ7+iOmFHqp6iZ6T8DU
 D47SYcKVTNnX+ZKAlquramNl3/9/ezUpcbAe1t0NrTKsHpHMl2em47AkvjmE2q8PttMH
 uSvrwpV3VXe+1g3yY75VfJyf+z92+lIQHxptWaH9YZ1ffJc1kRhO02m4GhKxvs4jG5EU
 PTvLtnQSIMiy1Epls/OfcONztyTwUeChrYGEDyz6j5Wcz5LeqrLlYcmG6CDhNEf3qvng
 4vJg==
X-Gm-Message-State: APuU4Z8CyO/cKFhpZqF54t6BdnBFF3mmmouIbTizSCAuPvp6/tb/QH14
 b71iVkOgkHe0VNmfuA6YC2kwSfwAZiTCp3n5AWBHjy+B2WBAxAyfgnP+wIFAoe8S8B0=
X-Gm-Gg: AYBFou1tR/2T60ZHj/imTk8HGw7urKrFqfOJBs8zqy8xzEFWBFA7E734cZkRlCMk8BO
 Ieqiw+fDGg4MtIoGd1jaoLqzUaPNdgMkKFqLadWUT4bdA6osYjvHN9aQYPv/TwByhRFlm4MTJaW
 3LYlhO648k5SHb3cMdomwpWCUAbE5Pey5mdK5GIUW0RqrDzXUc/IywjliZvX1gs6gTxcjTGl+A/
 +6O41c6Ca3YZU15EZe77pW2wUjaT49uSDrccRGyOfddQFqxtloo/vTXME/RgdRO/YSP/i64AnI3
 P0cZU6QSgjcY6S357oVO4FNqQQw3yZ/4xPjpSVJszpQyDYpc+ni1AN2bDQiJgxdTYuyNEQ5Mdvh
 n1uHa3Pn8oGsUIVULliZGa0TtCq47puJkX4ITzsaB+vSxct/I+cZxWEzGTauL5xTz7wxM/Yi7Ir
 hpLS1+dpLyKhE3+Y4OdJ1cFWCEHIMu9nL0ytkZFAvb/21HEdcmhmcLp6HGO83g2/xTzcSvCSROl
 JaI6fKrDmIogYJEiPyHtP9gQ9SUg/72MifTfC46wavW8XY6M4LvJE5bMosIfl43wUbJk4Yv4qBp
 3Eri7xPIhEbtDFInCiO4N5YV6tCwiDMHsQolHJWeRwzl8Y/jbwPw8gI02XPO99bTz8Kf0TEq3d9
 F6TLCAuUPhiS2XGrPLQoLrSyz0U9SUYv1Hq3IwiiOMIwpNpRvWhJ4sFdzbVI5ywhxjbSF7F6hYS
 Xzig4g3SerEiPPHzNUhrmjJmIigfr/VQ==
X-Received: by 2002:a05:6830:2315:b0:843:cc20:9d07 with SMTP id
 46e09a7af769-85f1d03b0d5mr3454145a34.16.1793988412868; 
 Fri, 06 Nov 2026 10:06:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de8f066sm2440889a34.23.2026.11.06.10.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 10:06:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <544a283d-2fde-454e-9240-af6f05f09d9d@monstr.eu>
References: <544a283d-2fde-454e-9240-af6f05f09d9d@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx/fpga patches for v2027.01-rc2
Message-Id: <179398841177.3737874.18321139313383689753.b4-ty@konsulko.com>
Date: Fri, 06 Nov 2026 12:06:51 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 11:07:59 +0100, Michal Simek wrote:

> please pull these changes to your tree. I have run CI yesterday
> https://git.u-boot-project.org/u-boot/custodians/u-boot-amd/-/pipelines/1833
> without any issue.
> But I found that one patch wasn't taken via b4 that's why I have rebased it on
> the latest&greatest and pushed it.
> 
> There are also some SPI changes pending but they should go to next version
> because we are going to rc2 and I would like others to test them on their boards.
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


