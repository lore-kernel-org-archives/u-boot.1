Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1AACDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5805886823;
	Mon, 16 Oct 2023 14:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MmNvUOYP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bXyLdI3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ABD386B71; Mon, 16 Oct 2023 14:55:58 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D47F28667B
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S8HCv1TK7z9tFm;
 Mon, 16 Oct 2023 14:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697460955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn8n4e0J2kTgsGH7smgwUPHMvlLWxi+NMcwyNYuwSho=;
 b=MmNvUOYPzOlkSM8uukOlmafxxEBjz60G/4YL+/XGz0C4shbmFHl4kxt2e8fGinpTW6HB5W
 UvG8hBtmrn7YEdX3wBscHm/VPCHWvH2I3QbhV1w+NP8qLsCgrZBKV5IDQTAKj08BkKdEQ6
 fn2jplKV5oD6KRhwcRu+xvedWJ1YVSGzY+BNm8MTdTQ/1fT4AvIIcFEaTwmUflCcAhVyE4
 EuYtLHAu5LnMP+FJpEQhCkjPeHFRtE90jErmH1eWewaRMyOB/qaL7fRdkqjstUWGAkzqV+
 tvSukgFxyRLDjk4anHyFjLGsHLAMntKTMRmsTbv0Fd8XcCP96q1/x8h3z/UhMw==
Message-ID: <7db1bd25-6e42-4c77-ac68-9f0f9610086a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697460953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bn8n4e0J2kTgsGH7smgwUPHMvlLWxi+NMcwyNYuwSho=;
 b=bXyLdI3+ZbENoqXXBYWI4Ejb32eGy5AU4df1BlLhpJDmlLcEHHyDL5SiBlVFUwsDisQavI
 kaVHPCdRb4kwX1VH5b/guXL2PSzpgIDINPEM1+eO2QQlN6u+81PXaSDntfTWte719J5hZN
 JarufvfTi8QuBi5eR/Mp33TBW1OkaVvzyCYVPVy6Eyx0kkyv9qwvp29kFbLndOQUJ4jJvG
 qY7tMR3VXTKKX7Glxzp9UTgJmMHTRY/B3fclAitkgnpe+0Gn3NI+LOhze03LS2GatVziGt
 HAnITNjcDez5gunrF9TbjviCQSZeCzZrTBakmRKJEW99M2w1fwBimB9kkshwZQ==
Date: Mon, 16 Oct 2023 14:55:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 12/21] serial: sh: Fix error handling
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
 <20231016092543.3833-13-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231016092543.3833-13-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: f1sny8k1tr7rxmwu6owbtt8oyaid6c7o
X-MBO-RS-ID: 77d63ee10fe7d69e43a
X-Rspamd-Queue-Id: 4S8HCv1TK7z9tFm
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

On 10/16/23 11:25, Paul Barker wrote:
> The current SCIF error handling is broken for the RZ/G2L. After a break
> condition has been triggered, the current code is unable to clear the
> error and serial port output never resumes.
> 
> The RZ/G2L datasheet says that most error conditions are cleared by
> resetting the relevant error bits in the FSR & LSR registers to zero.
> To clear framing errors, the invalid data also needs to be read out of
> the receive FIFO.
> 
> After reviewing datasheets for RZ/G2{H,M,N,E}, R-Car Gen4, R-Car Gen3
> and even SH7751 SoCs, it's clear that this is the way to clear errors
> for all of these SoCs.
> 
> While we're here, annotate the handle_error() function with a couple of
> comments as the reads and writes themselves don't immediately make it
> clear what we're doing.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Tested-by: Chris Paterson <chris.paterson2@renesas.com>
> 	# HiHope RZ/G2M board
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 	# R-Car H3 Salvator-XS

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
