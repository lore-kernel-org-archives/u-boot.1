Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23583C61DFD
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 20:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0814C80AC7;
	Mon, 31 Aug 2026 20:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MY7Z22c_wnoa; Mon, 31 Aug 2026 20:46:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788209208;
	bh=1mL8tWFL+Q2SKP9dkYpWMmvHRg9rK5yWvemZ8d4syEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dyrWRu913EtLKPRe0r8osRub/Xh9/s1ea6+zxDbqs8tGuKlfeXuxIkwts1D4e80ru
	 FEY/KEd0k8p7iR84TjAWd8WlP2UrhuSK4ulaFoPcKIGcfx/s0EoaLPHH0KgkymldTD
	 lXbI9IvtI0gLz3H6HKtc/x1ubfC1NZk5JW7fVhNwgsls13zzDkfTyanB5kaIoFNvQ5
	 yuNKFYYNymMAAcRYQ//uy5uUy828LHBXytoP1PHIko0bG8ZzaqST3IjE0kB0prkClN
	 4CR8xbaIO3niVwqtKtGIX98VkiDJDgD/ZgJfz70zIkRI67KB3BEgHUGTC7EfngQDZG
	 NxsWbh87CsLGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E7A180AAA;
	Mon, 31 Aug 2026 20:46:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B5C12AA
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:46:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81A934050D
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:46:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6XDy394mt1eP for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 20:46:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=UW+9V251
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7681440508
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:46:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6EE8A11B3FB; Mon, 31 Aug 2026 22:46:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1788209199;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1mL8tWFL+Q2SKP9dkYpWMmvHRg9rK5yWvemZ8d4syEM=;
 b=UW+9V251H6yULG5UQd5GSp2AGbjo8nxUjTZLrlwQ/ZNLmKNQ+K/79unZznHLhzBayAG+61
 DwyIMMYz9MED0W0cE7CR9cNetieBnDp4V51bPnHLIV1F2QqRMpPomjzVSxPkGGD0qAQe38
 DZTij6blTmoVvMtW80fjtEtfuV6Xg+Ze2KAsZO+wUT/IbtQKvPExRAjnLkavELxJQMR/w+
 Ni+iNoFnmJQGsbe30heW0A58WM9qBznBkIFIXqSWslxfdoFDa3bG0nL6Z5nQzuU2T7xXeo
 /OXqs9izEGv+LceqFxsUFFRafL7IYIG+XRCcszdk82UV5+q4SOSl00tSGkzWkg==
Message-ID: <75a0155a-df60-4abf-900b-4966a6424c92@nabladev.com>
Date: Mon, 31 Aug 2026 20:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] net: fsl_enetc: Add 1G SGMII mode support for
 i.MX95
To: alice.guo@oss.nxp.com, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20260831-imx95-v1-0-a5e482080196@nxp.com>
 <20260831-imx95-v1-3-a5e482080196@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260831-imx95-v1-3-a5e482080196@nxp.com>
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

On 8/31/26 9:46 AM, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add 1G SGMII mode configuration for i.MX95 platform in ENETC driver.
> 
> Note that 10/100 mode is not supported.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>
