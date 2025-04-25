Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE907C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 08:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220D9809D4;
	Fri, 25 Apr 2025 10:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59AA8810EB; Fri, 25 Apr 2025 10:32:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006938059A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 10:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 53P8WTdT095019
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 25 Apr 2025 16:32:29 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 16:32:29 +0800
Date: Fri, 25 Apr 2025 16:32:26 +0800
From: Leo Liang <ycliang@andestech.com>
To: E Shattow <e@freeshell.de>
CC: Minda Chen <minda.chen@starfivetech.com>, Hal Feng
 <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] board: starfive: visionfive2: Order board detection
 logic to match config
Message-ID: <aAtImll9tZbxlH8k@swlinux02>
References: <20250422064925.635394-1-e@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250422064925.635394-1-e@freeshell.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 53P8WTdT095019
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

On Mon, Apr 21, 2025 at 11:49:17PM -0700, E Shattow wrote:
> Refactor inside-out EEPROM-checking logic to better match the board-seeking
> callback and ordered list of targets from starfive_visionfive2_config since
> the JH7110 OF_UPSTREAM migration.
> 
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  board/starfive/visionfive2/spl.c | 40 ++++++++++++++------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
