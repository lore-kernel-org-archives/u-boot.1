Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E989C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 20:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDE6760665;
	Mon, 31 Aug 2026 20:46:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9SvPKPGtKDt; Mon, 31 Aug 2026 20:46:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788209201;
	bh=88XOvn5RwzUfvSD/DTYCrXwqk9A2IJxpMV/ppXxUKzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ke9Ip2iIZ9Q/5/t/T7zEvq/H3IB/3FTkqPDg1m/+MoRcAiuINFtmyrAUef4GSy0ug
	 GxFsUJkLdH6Ig0txilKx2ARZzJ7jf/86MNG2z6PAA77qNds7brJqIzBpATKYCcZFVw
	 T12aflQHB3Jf45JYrQ5hYCt4MhfbioJESM8tDIFwiIqMWMdIFJCdTA8kxmbuZKf+lW
	 BAZqIDGA8MGPm+beJQcKOLyvWZw9/AtootKbRlNdNnhxO29YoNm/f+6MMRyiHAmyDE
	 zbzZFU1H3uXQQZ3xvNPLS1jGBhUuzm2zhwvMtJKRfhdwNZXEKU8JpyZwoBcVdQky+f
	 0nmF+yCD0JO5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDBC660634;
	Mon, 31 Aug 2026 20:46:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E5AD265
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 576F560634
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7swKlmPevsTg for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 20:46:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=hAyYrxpk
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85B75605C7
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 20:46:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2E27C11C867; Mon, 31 Aug 2026 22:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1788209190;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=88XOvn5RwzUfvSD/DTYCrXwqk9A2IJxpMV/ppXxUKzI=;
 b=hAyYrxpkYkCnCQkDcYGDmJkXEDA70/egSe6XXtzWF5Lt8Sw9G9Zwdp4lDwcKs7B12rmVnL
 0cIQWVyzFIN2wEIjJ7kEK43ivHmoUHjyRFfoJrDRH3T6kTRLWlDJ9hGa7wBjhOsMeTLo1a
 2QEMyT6QUCU5tQ9QaZSC8qqKMY1zKhzYiNvAflOehaVKqLRJwJrfRdqjeSXCdBfimTYKds
 D34DptYvD0NFbq2D0BoGW/aWkiQhfdmCIQDdKeoL4yRdrWW8a1Aq58RBHr3XbwixVU2asI
 3ECY2kOLCuxi9+zL8Tx4ZDFVCQRF0km8whSpH82Pa5wcsInK1d8yRkGXgYK4jg==
Message-ID: <99ef03ed-ca82-4b81-9ab9-a791c31fc808@nabladev.com>
Date: Mon, 31 Aug 2026 20:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] net: fsl_enetc_xpcs_phy: Add SGMII 1G support for
 i.MX95 Ethernet PHY Wrapper
To: alice.guo@oss.nxp.com, u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20260831-imx95-v1-0-a5e482080196@nxp.com>
 <20260831-imx95-v1-2-a5e482080196@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260831-imx95-v1-2-a5e482080196@nxp.com>
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
> Add support for initializing the i.MX95 ENET_PHY to 1G SGMII mode. The
> initialization sequence is implemented according to i.MX95 Reference
> Manual Revision: 5 (2026-03-30).
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>
