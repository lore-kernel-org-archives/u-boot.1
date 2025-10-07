Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2B8CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 11:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D9883F20;
	Tue,  7 Oct 2025 13:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wKuDguWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3DDA83FFD; Tue,  7 Oct 2025 13:27:37 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A025383F1F
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 13:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cgv4j5dr3z9t6Q;
 Tue,  7 Oct 2025 13:27:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759836453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2Tww0HFMf8i55otPC9pILExd7HZdMbxg2+rhe72kRQ=;
 b=wKuDguWie6vtDR0VxJ41LtA6Zys6o40MSkpZdutg+5jnDR3VBwNW/6O9++GIg9KY6/FrTT
 Pcrpy4WMu4ZnZuOOi5eKxgOUBorWqUce6XeilUUeAO7ON8JLlfRWOmc8JtT7SrjFp9Warb
 RXBqkAOGfrVQYoNWeDO6Be1+FGuSWCmGSdZCjRwbWlujjKJAFhklVr+fDYwPgv1I/Fij3c
 Kajewr9WjVWWz0M/bQ4IWjA99t7oweMgbgrDyzLVL7HGH+aSxy7wCunl3PYE/on4Zue3ie
 Y6HeHT3x+lylr7jsxt7IZWyc4lbq7f5V7Ay3Ut3HDmzwi3BFecr3wXbh0fp4lQ==
Message-ID: <c5f7315f-f5f0-48ab-83f4-9472c1c37fd7@mailbox.org>
Date: Tue, 7 Oct 2025 13:27:29 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 00/10] Enable USB and ENETC on i.MX943 EVK
To: Fabio Estevam <festevam@gmail.com>,
 "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Frank Li <Frank.Li@nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
 <CAOMZO5DArO=XT6NjUheyL5-ec-s0WxW9PxTNEBZ6QXvdGVG=9A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAOMZO5DArO=XT6NjUheyL5-ec-s0WxW9PxTNEBZ6QXvdGVG=9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ipgu8y35hzjafsujeyutfnwnituquef4
X-MBO-RS-ID: aab376fdc9d4ba7a589
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

On 10/7/25 1:23 PM, Fabio Estevam wrote:

Hello Fabio,

>> Changes for v1:
>>   - Adding USB2 and USB3 device tree nodes with required PHY and
>>     regulator support.
>>   - Enabling ENETC1 and ENETC2.
>>   - Updating Kconfig and DTSI files to support these interfaces.
>>
>> This series depends on "imx: add i.MX94 support".
> 
> Could you please help review the USB parts of this series?
I don't think I ever received the entire series, can Alice please resend 
it and CC me on ALL the patches ?

Thank you
