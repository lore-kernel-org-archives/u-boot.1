Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9810FCD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D0984664;
	Mon,  4 May 2026 19:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mBUj+aAt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FD78466E; Mon,  4 May 2026 19:51:45 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DACAC80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g8TjT1dgCz9tQt;
 Mon,  4 May 2026 19:51:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777917101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/uwbIvY3hUcRwrRrO4RNwsORNg9hnZRBQHYZFVDPikM=;
 b=mBUj+aAtt2VlsajADYXSiDp+w9hsQVOGtV8j42E8yT2UTd7wbfrzOC15JdeX6yhGoCq/le
 PSPNo56p3G3SUfcqMlY38MoWlMz/w8cDF416EAs8LPKaXLV13l5gyEJF6gwRaBW77DhV1Z
 tuQFxn81Or3UzXbG3FXntdLSiJxViWng3CVwMkLdB45BNrXsiUkCMpKn/41gT/PgyeAYC1
 EEwU1JOTHPo1ptUSMiFRZqcVbXAuuaVvhVbmTh3OUTyOusC8MODbBxfj3iv2CBPCxLgTAf
 pn+ZhCd+3b0nAQ4foECj77LiVEzI841J1mRG5NrHbCZU/3K7tLhznxHskUs1XA==
Message-ID: <bf60e83c-8dd0-4703-82ee-ed9cf49a01ee@mailbox.org>
Date: Mon, 4 May 2026 19:51:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] arm64: renesas: Add Cortex-M33 build option to R-Car
 Gen5
To: u-boot@lists.denx.de
Cc: Anshul Dalal <anshuld@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20260427011113.259065-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260427011113.259065-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a7c2c7b4063d31735bd
X-MBO-RS-META: tgmyxx6x3i7syj1mu3abx6pe54cwn1pb
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

On 4/27/26 3:10 AM, Marek Vasut wrote:
> The R-Car Gen5 SoCs contains Cortex-M33, Cortex-R52 and Cortex-A720AE
> cores. Add U-Boot build options for the Cortex-M33 core.
> 
> Since the Cortex-M33 core is a 32bit core, select V8M and ARM64 for
> RCAR64 accordingly. Select TMU timer on the 32bit core, where it is
> used instead of the ARMv8 timer. Adjust TMU timer base address to match
> the address map of the Cortex-M33 core. Disable unused OF_BOARD_SETUP
> as well as unavailable POSITION_INDEPENDENT configuration options.
If there are no objections, I will be picking this up via SH tree shortly.
