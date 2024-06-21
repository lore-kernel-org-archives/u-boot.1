Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6756C2BA1A
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 15:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EDE88551;
	Fri, 21 Jun 2024 17:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718983572;
	bh=RwzvYDcOKr/N+nx+obmdHUeR+9g4X20PImjP0TSKAYE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jTZki0jaInUkAGEgjpyz6rMPFDtDPjQ4aXlb7wzDPH8+Ctnc1PtUTtHyyb2tntp44
	 iHXVA2/aglN4m31XZ0cMWVMDBzOaSYrX2mcDVa63eixGuqINHZWjfnVNwQ6xgIS+r0
	 DMOIF8sfjCrljI7vNAKgKERoK/qLHQBB5tZKZxxT2s2H1br8bZn6+Rw/wYXnlqjFuo
	 BK0rKJK/p84dJTeXaQufmJ/yeJlGjwFudctNYS9qHNpIstuyWrePia3EzfrfbBtLHR
	 GImscnCZ6/HX5/x68rGtV00rwK8ZqSdmUCw/+aLnynnRSSrtYx/P57wW/uAuAIKSN9
	 nuKdtQcnbu+1A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8443488027;
 Fri, 21 Jun 2024 17:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718983571;
 bh=RwzvYDcOKr/N+nx+obmdHUeR+9g4X20PImjP0TSKAYE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=EzdNSVyx7DeedSvI+hqBq97+k+5ECFuQGrkn172ZVd9OATVlvNLREosmFIHs+uoDR
 bsJp4FLTJv42eMtF3lubF+NsrvCw4fw/E08cGsaztRz02FVDBkKkWrcqtTr43FnWyU
 N5RF87tfVx27n8bTB6mndbIaZo3vx2yNN3yzMGX4DdbhTLY5dTbc3AalPRmh5OpaP9
 B50jfdHQc6BS5dHqc8D/D3AFmwEJrRPiQq1M+t4AkRl5ffZ8SuZTyKgsZpdGODNTu8
 zK6uYN6EXTqL0+hNNjfNlE4gVyXn8fAO998f2h6eaxVt5jXuLa/tLhEGikMHq0hdEp
 XUG+BZhwLu45A==
Message-ID: <aba27158-0301-45b1-833d-ab84081b6242@denx.de>
Date: Fri, 21 Jun 2024 16:17:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>, sbabic@denx.de,
 festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com,
 ye.li@nxp.com, eduard@lionizers.com, fedor.ross@ifm.com,
 rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de, elena.popa@nxp.com,
 tharvey@gateworks.com, sjg@chromium.org, vitor.soares@toradex.com,
 u-boot@lists.denx.de, martijn.de.gouw@prodrive-technologies.com
References: <20240621130626.729666-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240621130626.729666-1-paul.geurts@prodrive-technologies.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/21/24 3:06 PM, Paul Geurts wrote:
> The decision on whether HAB is enabled is solely based on the SEC_CONFIG
> fuse. The HAB FIELD_RETURN feature is able to permanently disable HAB on
> a CPU, after which it is able to boot unsigned firmware. U-Boot however
> does not take into account the FIELD_RETURN mode, and refuses to boot
> unsigned software when the feature is enabled.
> 
> Also take the FIELD_RETURN fuse into account when deciding whether HAB
> is enabled. When The FIELD_RETURN fuse is blown, HAB is not enabled.
> 
> Tested on i.MX8M Mini, i.MX8M Plus, i.MX8M Nano and i.MX6ULL

The purpose of the field return fuse is to unlock a system when it is 
returned to factory, right ?

Can the system be re-locked afterward too ?
