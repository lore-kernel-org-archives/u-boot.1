Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDB6C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D56C3880D5;
	Thu, 28 Mar 2024 08:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE31880D6; Thu, 28 Mar 2024 08:13:06 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71691880C0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42S7Cmkn056569;
 Thu, 28 Mar 2024 15:12:48 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 15:12:45 +0800
Date: Thu, 28 Mar 2024 15:12:43 +0800
From: Leo Liang <ycliang@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: <u-boot@lists.denx.de>, Conor Dooley <conor.dooley@microchip.com>, "Rick
 Chen" <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v1 2/2] riscv: support extension probing using riscv,
 isa-extensions
Message-ID: <ZgUYa-YT7PQY2QBa@swlinux02>
References: <20240318151604.865025-2-conor@kernel.org>
 <20240318151604.865025-4-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318151604.865025-4-conor@kernel.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42S7Cmkn056569
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

On Mon, Mar 18, 2024 at 03:16:03PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A new property has been added, with an extensive rationale at [1], that
> can be used in place of "riscv,isa" to indicate what extensions are
> supported by a given platform that is a list of strings rather than a
> single string. There are some differences between the new property,
> "riscv,isa-extensions" and the incumbent "riscv,isa" - chief among them
> for the sake of parsing being the list of strings, as opposed to a
> string. Another advantage is strictly defined meanings for each string
> in a dt-binding, rather than deriving meaning from RVI standards. This
> will likely to some divergence over time, but U-Boot's current use of
> extension detection is very limited - there are just four callsites of
> supports_extension() in mainline U-Boot.
> 
> These checks are limited to two checks for FPU support and two checks
> for "s" and "u". "s" and "u" are not supported by the new property, but
> they were also not permitted in "riscv,isa". These checks are only
> meaningful (or run) in M-Mode, in which case supports_extension() does
> not parse the devicetree anyway.
> 
> Add support for the new property in U-Boot, prioritising it, before
> falling back to the, now deprecated, "riscv,isa" property if it is not
> present.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I moved the kernel devicetrees to use the new properties, I'd do the
> same here, but I'd rather just move things to use dt-rebasing instead,
> where possible.
> ---
>  arch/riscv/cpu/cpu.c | 56 +++++++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 21 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
