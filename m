Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F752E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E811805C5;
	Sun,  5 Jan 2025 23:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115145;
	bh=7usAJaOkQh+CGKkRQbnH5pVMt+92/giel8lM0lkcBdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y0BaeZORcUVdFKfd6EdcaOjmy3CSsFjFBPrm23yhkRLIUjTm7CkREbooF0hgzuX47
	 rnWeRpbQ4RRv7qujGxVWb+uBMu/fT3aWf1s/6/l6fB7GGDaLEK2lElsseLHSqFcboL
	 YaDbfeNYjegwcw1s3NnZe3oD3YgCFzEzHV+xKayqilj29ptiHjQGrVGzY4Ne/3oRfD
	 5cwQdxkoxhrYynb3vfihdjgEzRpBLkBD3cFycasMNoljcYNb1Gb7h3z0vaw1zIobfP
	 F7xYSq3lr1kPZmJ8jir7AdJJmeWZZ33TtNaNIz4LyUNCq/V33bBw1woq7+w1773NGt
	 /wmdA756HSjeg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4C8805C5; Sun,  5 Jan 2025 23:12:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D01801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DwFv+diO"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5E62101ECBB3; Sun,  5 Jan 2025 23:12:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7usAJaOkQh+CGKkRQbnH5pVMt+92/giel8lM0lkcBdo=;
 b=DwFv+diOnIJSa+e+x/vkh5FitnRk7UHLTR6915H/fBzO712fVvVGzhfubbudR3ZN40IPIV
 JBpzNWnShVPunC0kx6z1DKcbGrjfOH5PDkNfK5P9RpJf5HlWEB8oqaXvez465CmV2GRlFR
 ept1y6PL1jxMCkbeq1c8xkomynFKRNXtcB5/ra6Hr5q7Lj3NkSClN84XC10CX1jt3K0Lo7
 4smyhKFwRXfIOTdFZPUe/SmHiDk6FJZiZ9M6JRbdjiMo6weMghzHq2DMClSG8ArtmWUR1v
 EKeJqX744eyjXUxAgtgARqihb2jyUJ9jJi6ST+pMItG9HgwZtu5a9HACUypUvg==
Message-ID: <529cf75f-5e89-451d-acd4-942cfc91799b@denx.de>
Date: Sun, 5 Jan 2025 22:43:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/17] imx9: scmi: soc: Override h_spl_load_read with
 trampoline buffer
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-11-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> When SPL loading image to secure region, for example, ATF and tee to
> DDR secure region. Because the USDHC controller is non-secure master,
> it can't access this region and will cause loading issue.
> 
> So override h_spl_load_read to use a trampoline buffer in nonsecure
> region, then use CPU to copy the image from trampoline buffer to
> destination secure region.
Can the attacker intercept this and rewrite the soon-to-be-secure-only 
software with something that would later allow them to take over the 
system ? For example, could the attacker flip some secure-test bit in 
the TEE while it is in non-secure DRAM and before it is copied in the 
secure location, and make TEE accept privileged SMC operations from any 
unprivileged software ?
