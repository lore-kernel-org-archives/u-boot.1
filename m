Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E1E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB2A88039E;
	Sun,  5 Jan 2025 23:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115123;
	bh=uKbsjrXKFXu2JUBqz2YHEeMGDRkzmMcE+mHKxzepVG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nuGIWCPNpFbT3zv2LrsDiMW27hGPGQoo3L3nDP5gzMNZN+kHe4O/d40SFfuNvZMM1
	 cTIovoaobxEZCyRENyeHoP7s+cJnb26H+Jysyst35qtJHJOUBJ767Kvgumz98x4x7P
	 mcHtfvH8GSsDVwGPSQskzUBSvFG5y18k+3XVZe/U/JW5LINylIQ+PytyEe3jZEI1TL
	 5qvEFHSzdsXLHyWapVmwKWch6fNTkG148anr+xTqXOgbSB3iYiCysBqR3EFnejqs2D
	 5KLi8fGchTotavVpybqi36Im5mdFF4JJSPsf8WceNVMh1DHrvvJLP00xgKw1b10FxM
	 qZW99/54fKOSg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD7F88036D; Sun,  5 Jan 2025 23:12:01 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8634801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SlZs4uHj"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A50F101ECBAD; Sun,  5 Jan 2025 23:11:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKbsjrXKFXu2JUBqz2YHEeMGDRkzmMcE+mHKxzepVG8=;
 b=SlZs4uHjTEOEwePMZJP9D//lePMKfVGV4Oa/U/fV/j5Q6FA0S1OrL9pJyKfkGW94l+Yi91
 woBQjCcI3dWxWRlsAvy4y8ROTAD48YMqGbz6W6Vtu/wetI6ExMoEpRD9d5T3pRG6u3HiJu
 RC3yCDE8rhrUCxYlloCeOQ1ZGDFVbc34ti3t3DVzTE2zbFhZUduWlJ2mRFVDWinvQB/Wkk
 lyVyu+iN4VO5Mumzjb2Zk4vCjLQ4WPd3Yz1Ap/7szDfeWrpYi/5enbNmPo5J40nH59HCwp
 8uIW3BaEOVcw8plWEfUcb4WJJ+dwyRI4r5wXvQ0DViCK+Trbm9Z6W5C+YjR52w==
Message-ID: <22f8e29b-1372-4384-a5d4-5316c1f4f160@denx.de>
Date: Sun, 5 Jan 2025 21:56:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/17] mailbox: add i.MX95 Messaging Unit (MU) driver
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
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
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 Messaging Unit (MU) enables 2 processors on a chip to communicate
> and coordinate by passing messages (e.g. frame information, event
> notices and requests) through the MU interface. This patch provides a
> driver for i.MX95 MU using the common mailbox framework. Currently, SCMI
> exchanges on i.MX95 uses a mailbox transport with SMT format, and the
> hardware used is this MU.
Is this ported from Linux ? If so, as of which mainline Linux kernel 
commit ?

Can you add older iMX SoC support while adding this driver ? It seems 
imx6..imx95 MU IP look very similar.
