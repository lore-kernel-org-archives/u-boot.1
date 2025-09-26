Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73480CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 07:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF7A82998;
	Fri, 26 Sep 2025 09:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828B982AE1; Fri, 26 Sep 2025 09:51:59 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56098206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58Q7pQCI020395
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 26 Sep 2025 15:51:26 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 15:51:26 +0800
Date: Fri, 26 Sep 2025 15:51:22 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, "Chia-Wei,
 Wang" <chiawei_wang@aspeedtech.com>,
 Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>,
 E Shattow <e@freeshell.de>
Subject: Re: [PATCH] Revert "riscv: Add a Zalrsc-only alternative for
 synchronization in start.S"
Message-ID: <aNZF-ncCfjp3DS7z@swlinux02>
References: <20250925160148.21624-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250925160148.21624-1-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58Q7pQCI020395
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

On Thu, Sep 25, 2025 at 04:01:48PM +0000, Yao Zi wrote:
> [EXTERNAL MAIL]
> 
> This reverts commit a681cfecb4346107212f377e2075f6eb1bdc6a2b.
> 
> It has been reported that the commit causes boot regression for SPL on
> StarFive VisionFive 2 or compatible boards. Inspecting the code, I did
> spot one logic error for deciding whether Zaamo or Zalrsc is used, and
> it's still unclear what exactly causes the regression, let's revert it
> for now.
> 
> Reported-by: E Shattow <e@freeshell.de>
> Link: https://lore.kernel.org/u-boot/1871663e-b918-4351-9e9e-97f9a4c73733@freeshell.de/
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
> 
> The original series causing the problem[1] contains 3 patches, and I
> think it should be enough to revert the change of start.S only, since
> the others touch no code, and should be relatively safe. I'll fix the
> reverted change up and get it work on VisionFive 2 when I got my new
> board. Sorry for the inconvenience.
> 
> [1]: https://lore.kernel.org/u-boot/20250902081932.21103-1-ziyao@disroot.org/
> 
>  arch/riscv/cpu/start.S | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>
