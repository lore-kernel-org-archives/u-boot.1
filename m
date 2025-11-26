Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228A8D10F58
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 14:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 839D084239;
	Wed, 26 Nov 2025 15:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YBKIo9cx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eZoqts49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB5C08423C; Wed, 26 Nov 2025 15:24:50 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9E484201
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 15:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dGhf76VJSz9v0b;
 Wed, 26 Nov 2025 15:24:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764167087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnKgi6s5M0EySTYIRL8ItysX/mgMvZ8HRjAOBMG4zlw=;
 b=YBKIo9cxrMD7zVGyYuEN9uDpI0y1Dxn9iat9TS+NDO/hWZoaV9PcXiOf3mFiH0xei+TeRJ
 WU4n7b976syswWIy4OFIDqiZ82nsAf30oJ6+Vg9Pp+ChZlk2KyVBZzGWMY89rtgersfgRT
 V28BBV8F7tojQrvYgJDJnufc7jSxxynEIeH/QoEjvgALNgR8fuJ0zFXBphfzETaXd6t2XO
 d/Mgq+xoIaC2k5nnbpFZbObOzbWIKIB3QhyMsHFOxuhfPXjAga2faHkBC5gZz4/QhQ12bS
 kSTserhwu6NdBIFB41E3H9P7piaYDqEuxJnx5m06VAkkXaY8/OZujeISL+ncSw==
Message-ID: <7e2b90c8-b814-4027-a7ad-9a0a5e747557@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764167086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnKgi6s5M0EySTYIRL8ItysX/mgMvZ8HRjAOBMG4zlw=;
 b=eZoqts49rM01O3iMsQ2a7nUrlcJOCDq+iQkdBEi6Gcv6a0X08rdcYiR2S6u9qlc/19BGjh
 bmOi7N/N6RcxX/1z8Qnd47/J6cKCF3GWtpAG6r7wjIBD2HrSWTn0D5EsoFPnLHqaaux0zK
 7TF/QhL+66dFZLwl3vX1yffiglWC0wMYfyFIG8Dv2zaULgzedltZD8LaDPA4ibNi4ZOQvX
 vwscLLtXVsqlwvDyBmKmtjkYGqOMjY2WJELI018sziuzLs65oCWr85v5hpTT8v2vq7gReS
 VnVCTYwMCt/hVrDXudqhadkSed4Z+zf6YAuzXxUTCY204J0+PJMU0ijwlyEPjQ==
Date: Wed, 26 Nov 2025 15:24:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/2] net: phy: aquantia: Switch to generic firmware
 loader
To: Jerome Forissier <jerome.forissier@linaro.org>, Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Zi Yao <ziyao@disroot.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>
References: <20251101123401.110681-1-root@infi.wang>
 <4D63D655-F67F-4FC7-B02F-653BF49754EB@infi.wang>
 <59b26617-ea1d-4a65-a474-de16399f8205@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <59b26617-ea1d-4a65-a474-de16399f8205@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d5f2aa4c045c1b86ca7
X-MBO-RS-META: 4phok8ni87g4oah6xj57qsxw7ppb3jf1
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

On 11/26/25 3:22 PM, Jerome Forissier wrote:
> Hi Yun,
> 
> On 11/15/25 08:48, Beiyan Yun wrote:
>> Hi all,
>>
>> Gentle ping. Any comments on this patch?
> 
> Since there is no comment I will pick it up and move it to my net-next queue.

Ideally the driver should use one firmware loader, not both.
