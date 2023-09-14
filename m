Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83660EEAA50
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 15:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 870AA86963;
	Thu, 14 Sep 2023 17:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1694704613;
	bh=aWsCAny+CIIY4yGBNoEZukwseWCmQwtDyyE7510ILZI=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=lyg3Vm5ozxVEZCJBtFYec3AbdQEgztiWhVnvmPsMd97NiiZRT4jmXAdBRSND24pWp
	 r7CZSPbwgpojZPb407rJRsxk0P3DtXwUNYgJdq9JalzTUdkaQYBJDKHEOW3khNy0oE
	 3PUy9SXYNSKGzt9LakYQVT1C+Od8WqSO8LhEDIRF3mE6qv5eMTgMBY+q1XnVi2of+x
	 y4YdYXqEE+76DFY2aYg6sWLCDK+kHtyFLQTfiIu7KBOMtPfZ1Izo6plRJBDceqoyUX
	 u5uYvz/JVqnWErgIPshnvhKazIWDc6raeJPz1K2QeaMLJpHC46svUwJgBy7MPUUCxX
	 OMIVw+gLy0yXg==
Received: from [192.168.1.107] (87-97-111-83.pool.digikabel.hu [87.97.111.83])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 313A786907;
 Thu, 14 Sep 2023 17:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1694704612;
 bh=aWsCAny+CIIY4yGBNoEZukwseWCmQwtDyyE7510ILZI=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=nbqI/OWPgd26BEAqz8QsGbd1aKHkXC4UYjpHDlwta7VtvGtzXZHLN/r7iTQ5/11KM
 z2vUmV2fgaFwoArChEFE/wxarrHvopdeb0Tk06Sxe02uBFHKHdd826butf/Oe/kH4k
 WMWG9mP8dMAH6bCa7k6/XbfNu97kGOrXoqUN5g2Galv+clwaYi6qPv6amiUE/0rpXE
 +/jiri139n0lKIRsQbrQbGzBZlsl4+GOm1kc1OJfPt+ElH9XU3EeB1TdoWxgMjuglR
 9vBItJ8wtaHDyenf934+2cDVzGOa3Ad8UZ7dEl1YeLH8Oinis6VcdN2FCw/fMk9SgA
 i1h4dnCl80TSA==
Subject: Re: [PATCH] drivers: mediatek: Fix error handling in
 mtk_i2c_do_transfer
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, Tom Rini <trini@konsulko.com>
References: <AM7P191MB06955AC8974FA0226ED937A5DAEDA@AM7P191MB0695.EURP191.PROD.OUTLOOK.COM>
From: Heiko Schocher <hs@denx.de>
Message-ID: <ae5d1c8d-a01a-0986-da4c-b64f755ba090@denx.de>
Date: Thu, 14 Sep 2023 17:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM7P191MB06955AC8974FA0226ED937A5DAEDA@AM7P191MB0695.EURP191.PROD.OUTLOOK.COM>
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

Hello Francois,

On 08.09.23 18:47, Francois Berder wrote:
> Errors were handled only if an I2C transfer timed out
> and received a NACK which is very unlikely. This commit
> changes the condition such that errors are handled if
> an I2C transfer times out or received a NACK.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  drivers/i2c/mtk_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good catch!

Reviewed-by: Heiko Schocher <hs@denx.de>

@Tom: Can this go into the release so late? If so, I can make a
  pull request...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
