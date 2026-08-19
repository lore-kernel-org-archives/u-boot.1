Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75B7C5DF87
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 10:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C77660627;
	Wed, 19 Aug 2026 10:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QFG_5PozgDBx; Wed, 19 Aug 2026 10:04:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787133850;
	bh=2dJE9UucuK+qo2TrOMOWsns4G/ISkayWKz0JQxumPwM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QgH4HshM0Zx0TQs8tjYtI8m6MWdiDNGR5JLXiodkSRFJXL9NSnTA4QfProoYVj2+M
	 wODuKX0Wu5472kKJwBJhmAH85df10sYcseEkZUTmKAYyJLSoMKx9BWuPCEoITmlXol
	 XVdJxlFFgHKpO1Q8g8KUqSzQub40DZ6hpSOBAIWP/2zNce8ixlUMF2aj2gPw9d1YaS
	 HpqBbCTFbTiF8p0Ryvhp4rPpMFOUezP3TzFQBflpkvhs5yp7TAbxCSzRli19vUMoA/
	 mabkYx2pEXjnftT0WtO82HjXLHsA3I+jrUsmZ6aZjZ3/Dh5EMjBTOOio0YgsKP/NHU
	 pQCmfQqrcRuyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1A806060C;
	Wed, 19 Aug 2026 10:04:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C20A1460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:04:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39BDB40042
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwG6X3-Rl_Ox for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:04:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=VuaDO8Z/
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 333D540077
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:04:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4A00311BA4D; Wed, 19 Aug 2026 12:03:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1787133839;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2dJE9UucuK+qo2TrOMOWsns4G/ISkayWKz0JQxumPwM=;
 b=VuaDO8Z/SXVHr9t1LrUWiepDrabXvx+lycH5Tj6n51ebgo7FwS39QVtC4cAby4xl7vuCU4
 zlGAzXYtKypr3ZtQoANo3hPtmTDsrV0JixMKfd7xuqfO1coS21qdRdivIVcjRMQIdwoPSr
 Y/uUZ3as96tmrb/AYX6C4RF0YyheIIXlceodDKOt7JXn15Zwqpizme4JG673DfA6VoUVce
 8QFeIjIPtoyB3mCzdPwNseqItv6LQsseDRcmOew188bnu0IFhq+qiGXUByBEKrtlSM/MeZ
 dhHCanyXQvXKm6WwHcJ1M3PS8dOVuQwrISyqVhzOz5v5YtwM5oIXZKpocHGdUw==
Message-ID: <51c83040-d16c-4aa7-a3c8-6b04eaa854b7@nabladev.com>
Date: Wed, 19 Aug 2026 12:03:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simona Toaca <simona.toaca@nxp.com>
References: <20260819065804.32156-1-frieder@fris.de>
 <20260819065804.32156-3-frieder@fris.de>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260819065804.32156-3-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 8/19/26 8:58 AM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> In some cases we need to call ddr_init() multiple times to try
> different configurations.
Details please ? What different configurations ? Why ?
