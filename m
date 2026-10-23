Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01759606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WJCCLqAH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hO5LKXf5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3A1D80CE8;
	Fri, 23 Oct 2026 01:14:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zxWg3kBJkeg; Fri, 23 Oct 2026 01:14:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0430580E0F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792718089;
	b=jd4GuegKm1/Tf8LutrUivcucxcXdRQZer1vIySpff2d7xdY9rTbWdbdLzRWPFhyziAQ7
	 NItm+1L+CUCThz/xCqXu8vTNh3B6VvcYQ3s5evYmEVVpCuUvzTvseXU0iB/+aSobiSFUT
	 VWnOXfh9DPgL967cozL/mQBcuU4DQa0UcDGZorXxWmrcOb1G6I+IZ0nR86BlMo00HxPML
	 L+KWgTDeuJAqCJ0RrRBO5e04GV7uPfwwmcRZzFT+qg1S3NCdZFkujwP1NpeJWPZD5RFLl
	 NPK7UFr5ZAaUDHYnLvOOJ0hznnlB9SACF1LAynNtcM5Ta3gNvnVYZCIRzq9pO4sSH1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792718089;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v0yMU6DirtcH0UC7/0NVzAGaSItimMD+68W+IIMjZi0=;
	b=TEDNUmCuPixwVygKiXTWNIsmG+pSp8aj/xG/iG9PU4mDyQWmW6k7EIeDD5u7RBPUuUuP
	 0e4MffuiMz9lyCjwQFdqyLYjK/3BgsvbOnkAiKDa3ANVtipoFXveP2/qs2VUg/yL+U/JQ
	 jYfs2hi7hoW3+l7sfK3M79wWoCKmmdkiw39zmwi0e3q1ije4MQ6N+wgeGNpK5yvucARLq
	 ESqVPpuEYbFSrWTTRw5d9xhB2Gf3SjBYbJ6XVyyNSPGtFmJV1pS26zMI3m2oEQ4VGqE5n
	 9eU00ILzOxNfjiwu8q+ZGZqAH3fDsopUb2Uc+XraEUTa0H5pp+5/mCitXXbbClFM/GA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792718089;
	bh=v0yMU6DirtcH0UC7/0NVzAGaSItimMD+68W+IIMjZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WJCCLqAHkMKjQsPSc+a0//h1yiIk71Wrdl6s2yFbRncrjuZTqWvJvYX4tgI0KIBQt
	 T+oXpgHAkUPZnRGmD/ykrFSvEiZsIg8GJTCMm0y4iBKM7F4M8qlfoTWNfHmw4HG2B9
	 KurHMzaZTk3IN0w9YMTbL28WOdaqWQLQTwICX2efZuA4TRfYoJ6zoTisJ9VGvhm2zN
	 5fH0DXE1/OxC/GD/4xWF/aQ4QuiNagU5DqMGPMYw6lKh0F/j3Sgx1TWnpyJioEvl3d
	 KD7oPpmlSefYiFhwGSexPk4l2IY3NASUQXyCDROyBhwYVJKu1/+XV8hYUqAVgQ4POV
	 6iuxPkd6oDvyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0430580E0F;
	Fri, 23 Oct 2026 01:14:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD5A44D1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2E1660650
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtUo-v5n-Z5W for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 01:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DA51B6064B
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792718087;
 b=szy76cbKmnDSKsbO64UNJmk8N10QoNeciT/UpbXiaPLLFBzzYOLmisSUIVTl0PSnHk1s
 lYwI9uSkTztDc0PiCrZj7wN+Nwuz+NiWv/xYooVGQI5mRG9SEHAMJeUCeFC5+iBuHlrey
 QOvmAZOgq59jy4Fm1iyPQlZCgSeTIvNRGA5iqL2ZazWEUi1cUGKB6vNwLN1wgSpdmr04o
 4TNBFMHLgGT2UHMoF40W9WsG5XhEpwMhezIxo+speMafggpA4YodJl8DlScI1+F9YwILP
 vrt9lOv86sYGIUR41+ZZdkHe5CBxI9C9O/uXqbq5o0wkQnuROYGQP9Hs5Aky6tfTZBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792718087;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=v0yMU6DirtcH0UC7/0NVzAGaSItimMD+68W+IIMjZi0=;
 b=jQmxhKwS67TquyPvSzWjxespnT3dTNiXM5g1dqcPXInCc73DYGOQ5IN2A6zjytIfnEy8
 9wMIY8E+TMxCSyXEYTaz4a5KF7asTb9+YyFnf+8cssSYSVl4O3Qam8LrvGyIO56Ex3vj6
 RJXpawL5CbxL++bVnTqnIqY+5ZYQ3z1zbz3hxR+VmXSPix2+/ib+OiZqAH+6qBnBQGM6V
 bbr9CHvs/bLUsggY0tOyM2n0saFQooLSQ4CTmiFqFzFtXJa35KGeQnn2CYCvueTNNso30
 UyFYqkRlaK13OpkQgyYzk319TfKz6uCruh4NgZ2En624f9YCJTG62BSSG89dxN5lZYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hO5LKXf5; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hO5LKXf5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA51B6064B
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:14:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4502640203;
 Fri, 23 Oct 2026 01:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6181F01825;
 Fri, 23 Oct 2026 01:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792718086;
 bh=v0yMU6DirtcH0UC7/0NVzAGaSItimMD+68W+IIMjZi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hO5LKXf56DOlu9H2t38+CGJ6a8bOlDAl3RDbPAp8Ep+u40Kkq70KEN9ZBkOFKphZH
 suNieoXFg4MWiyINIweSrxVwjY3FDVXiTl9OWYieSJ5j77utdFZRpfk3QUhYqJYoPm
 Lm1CpSEmqnVxsUxX6lBHwYsiZX/M0v3t/DavxtfAku2vVdtpljiLh269DIa/Tx+Epb
 n/X+iYKq54mM/zD1IUlzQTMfDPWH4MZz5T6ccLfJHUWuwh7fcj0WmkULKFpiej+IiS
 v7c2u+cRRGrmBQ/IljqDFNDx888mJPDEMthkegtVhhiKyFQ6pGr6zgZKm8cO+cpr66
 WwmE9gn14Zj6A==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Subject: Re: [PATCH v3 0/2] Enable SPI NOR flash for SpacemiT K3 in main app
Date: Fri, 23 Oct 2026 01:14:42 +0000
Message-ID: <179271801881.298275.17221480711795989513.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022103907.1415045-1-e@freeshell.de>
References: <20261022103907.1415045-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 22 Oct 2026 03:38:51 -0700, E Shattow wrote:
> Enable SPI Flash command, mtd part names and locations, and store U-Boot
> environment in SPI NOR flash. Selected for Winbond and GigaDevice parts.
> 
> Changes since v2:
> - use Linux v7.3 fsl_qspi_get_name() typical result for mtdparts layout
>   name; this is done for compatibility in the non-default configuration
>   of matching cmdline mtdparts mtd-id when Linux MTD_OF_PARTS is disabled
> 
> [...]

Applied, thanks!

[1/2] configs: spacemit: k3: enable spi nor flash in main app
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/f2b91ab4a84f0e6262f5f925b513344e1c236e1d
[2/2] configs: spacemit: k3: enable mtdparts in main app
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/9cefa267d999750e8415da1df5da9c9e22b47871

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
