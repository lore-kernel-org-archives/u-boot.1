Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2930C4345F
	for <u-boot@archiver.kernel.org>; Sun, 21 Apr 2024 20:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E53882EB;
	Sun, 21 Apr 2024 22:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713732334;
	bh=spvyxva8oJhJ+GdBfLF4oS0gG33cfR9eSyc/jIb9nJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kPtGOe025Op8ZYvSdWD4TuvysdtwbtM4hKgWu2sXX7XDfCb1VFANZYwBkYyoJTxiS
	 HXlo8kBExfw0adhS/G0bcpPt7HO0WCifLE5sh4Rzq5dh+KcTE5CLGnSlJTu5p3hK2j
	 5O0lVI0U8PTTRqWX6QMzmKwdn74ybyNCULHjia2jR7uR0Z0X8wZyx2JCPKFAMb59uO
	 QWHMD2MN2xxofyOtlOxgDD/YhxVbWwVF+rOLz71xI9TXHl+y48c1JtzA0pDtRts7Ce
	 jxK0M/m5RM872+a9wfBOkwFfgEZwrIdJVySJrZ1QAqzyvMZ9GMriiMrsTGSWjEmjcj
	 5chwP6tld/W3Q==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2A988882DA;
 Sun, 21 Apr 2024 22:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713732332;
 bh=spvyxva8oJhJ+GdBfLF4oS0gG33cfR9eSyc/jIb9nJ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bsky8MZrKeBBy0HGDEiRoHYC2cs2xPdjTdV8/oBgjUk4FkCUhdQQhozBA1xTlwRJw
 WqHNjSE/yHbHIPmeYzLPIGI+DyRxgavKCxvL1D0DSe8zQ8/hh9DFzERNZTyZnRobKN
 iStfVLltjbPi9kChwhDgTd7UQB6ZimXPt9RgTlkYn04i4KdKsvZIv+x1gcNWBT61xu
 bziW6eEcZ4N9iMo/Asfyyzv2AK7PR0+xBF2Qzwsq2JaXdpaCUtQLaQK3gfe2OKEMhq
 cmM8tUsgzg/OWj27bnck7er4LL7bgvK91tRIxVOMbKzXd4B5LEpGOQ7Pq/AGwPjeMD
 L0/tRd4bn+UqQ==
Message-ID: <9793571e-fdb1-41d5-b967-948dabe9bc4a@denx.de>
Date: Sun, 21 Apr 2024 22:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: support USB 3.1 controllers
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
References: <20240411160527.835767-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240411160527.835767-1-caleb.connolly@linaro.org>
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

On 4/11/24 6:05 PM, Caleb Connolly wrote:
> The revision is different for these, add the additional check as in
> xhci-dwc3 core_init code.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Is there a matching Linux kernel patch , or does Linux do some other check ?
