Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A2C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 06:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1B083189;
	Tue, 12 Aug 2025 08:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE36E8318E; Tue, 12 Aug 2025 08:00:58 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971FE8317B
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 57C60G6G096312
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 12 Aug 2025 14:00:16 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 14:00:16 +0800
Date: Tue, 12 Aug 2025 14:00:13 +0800
From: Leo Liang <ycliang@andestech.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
CC: <rick@andestech.com>, <u-boot@lists.denx.de>, Sam Grove <sgrove@mips.com>, 
 Chao-ying Fu <cfu@mips.com>, Mukunda Aprameya <maprameya@mips.com>, "Umesh
 Kalappa" <ukalappa@mips.com>, Djordje Todorovic
 <djordje.todorovic@htecgroup.com>, Mallikarjuna Gouda <mgouda@mips.com>,
 Vaibhav Chauthmal <vchauthmal@mips.com>,
 Swapnil Agrawal <sagrawal@mips.com>, <felix.chong@codethink.co.uk>
Subject: Re: [PATCH] arch/riscv/lib: update memmove and memcpy for big-endian
Message-ID: <aJrYbRn8UOAhit2Y@swlinux02>
References: <20250807164933.40564-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807164933.40564-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57C60G6G096312
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

On Thu, Aug 07, 2025 at 05:49:33PM +0100, Ben Dooks wrote:
> Change the shift patterns for the unaligned memory move and copy code
> to deal with big-endian by definign macros to change the shfit left and
> right to go the opposite way.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/riscv/lib/memcpy.S  | 12 ++++++++++--
>  arch/riscv/lib/memmove.S | 12 ++++++++++--
>  2 files changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
