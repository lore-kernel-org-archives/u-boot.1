Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F2C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EEA877B6;
	Thu,  2 Nov 2023 15:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698934056;
	bh=V+zRPRtvPrPtWWcXFdNS+u4UTMSui4AJeduE/JSeM+M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=UUISIF1XBPUOnWnuy/HWZ2Qo5JwZr6mRiHSOOgdpUpETbGmYoN7XV6O7xnUegoT+K
	 0MC+YGgOLCPS9FxSfkClnl8gqDLsvFFPgSg5CZxKnY0vDv7Kxp/ileYxGjVv20SA88
	 YTOR1ZPqbUUWeVLy3HPQSDMBR/UZX+uO/GXg1/uY75TQo1vp2S/2aUCUMR9EnSayA6
	 ibPsfukaNni7I544Kwd5eYLogRjEYXTx1kxyalEu9JXGo/6MDUAH9dEK4jCjYGMNkc
	 3FD4Fy6QMR8pY8n9j4vpM7DVyG2gzWxiFolkdHlMoKQJGB1z+EtY0/OGJAt0/HfXqT
	 sMJZacltn5Dww==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0D8368701E;
 Thu,  2 Nov 2023 15:07:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698934055;
 bh=V+zRPRtvPrPtWWcXFdNS+u4UTMSui4AJeduE/JSeM+M=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=UFwzH336zI9ZFkwBmQdVKRElkxgXQC+/PtQ/jxlswH/3VcW08Id0WQyfEbjY+PgKc
 WiH5iA7gaB8iCYZJnnTluJTWMhE+EsSq5izmn7PMUAHLYnCBxrwg76t87X+wLEtvAm
 JlpNxE1qqeqmooj21BKVz8DsUZEka+YArLrsbalarwAcl8fsUsdzTNXd+JMfR00KDu
 taWUPCVxBPnnOh+Q+OwtLGgvrguCHa8fMWWXkdu+aB2j79WREZdPZ+nUPm5GoC6BXV
 JI79Xi7hRLp4ZoM8PNHUuex/m4aaoG7aqiKvXdALv6kac9hedhhvRlqtfUMDiO3n2c
 KqXiN6305kctQ==
Subject: Re: [PATCH v3 1/3] bootcount: Remove legacy I2C driver
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231031073844.15683-2-pro@denx.de>
 <20231031073844.15683-4-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <9db32944-6b6f-f689-2ed3-1d20f4964097@denx.de>
Date: Thu, 2 Nov 2023 15:07:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231031073844.15683-4-pro@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Philip,

On 31.10.23 08:38, Philip Richard Oberfichtner wrote:
> The legacy I2C bootcounter will hereby be removed and eventually
> be replaced by a driver model implementation in the follow-up commit.
> 
> The legacy driver has the following drawbacks:
> 	- It's not adhering to the driver model
> 	- Settings are grabbed from Kconfig rather than device tree
> 	- i2c_{read,write} are being used instead of dm_i2c_{read,write}
> 
> Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
> ---
> 
> Notes:
>     Changes in v3: none
>     Changes in v2: none
> 
>  drivers/bootcount/Kconfig         | 24 +++--------------
>  drivers/bootcount/Makefile        |  1 -
>  drivers/bootcount/bootcount_i2c.c | 43 -------------------------------
>  3 files changed, 3 insertions(+), 65 deletions(-)
>  delete mode 100644 drivers/bootcount/bootcount_i2c.c

Applied to u-boot-i2c.git master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
