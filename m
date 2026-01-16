Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B73ED4A5E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 01:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868B980325;
	Fri, 16 Jan 2026 02:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59BC780325; Fri, 16 Jan 2026 02:29:18 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C7080077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 60G1S2e1083654
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 16 Jan 2026 09:28:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 09:28:02 +0800
Date: Fri, 16 Jan 2026 09:27:59 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Rick Chen <rick@andestech.com>
Subject: Re: [PATCH 08/10] riscv: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <aWmUHzFeByWHEyy5@swlinux02>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-9-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260115222828.3931345-9-trini@konsulko.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 60G1S2e1083654
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

On Thu, Jan 15, 2026 at 04:19:38PM -0600, Tom Rini wrote:
> [EXTERNAL MAIL]
> 
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Aligns the final section before _end (for U-Boot) or _image_binary_end
>   (for xPL phases) by 8-bytes by adding '. = ALIGN(8);' to the final
>   section before the symbol.
> - Remove a now-spurious  '. = ALIGN(x);' statement that was intended to
>   provide the above alignments.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>   aligned we fail to link (and explain why).
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Leo <ycliang@andestech.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Rick Chen <rick@andestech.com>
> ---
>  arch/riscv/cpu/u-boot-spl.lds | 4 ++++
>  arch/riscv/cpu/u-boot.lds     | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
