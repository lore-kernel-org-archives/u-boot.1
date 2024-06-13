Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534DDC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 07:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24AC881A9;
	Thu, 13 Jun 2024 09:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RjOWR+Vx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A4D881A9; Thu, 13 Jun 2024 09:51:30 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD2787EBD
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 09:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1718265086; x=1720857086;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9K2vFwnBTMbJvgrB3+fnhefbRXr2q52rT4lmb/iN4dc=;
 b=RjOWR+VxzJzVe4NT3LCkKdqgGUTS/ZjyliWY6MIgQ3Fl2oYO7N+Ez0/ewr8o+/wX
 txoVth80cHTIktHFgGvu9hxZCDIHKAxGM3Z6CQXIFc2RAypksCW/vcDCvhemqI+y
 ZtXvftfm4vVZ1rC4CdL7CbCKtVyFQ2FcIw6cZDmC5yc=;
X-AuditID: ac14000a-03e52700000021bc-74-666aa4fe15ad
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3B.2F.08636.EF4AA666;
 Thu, 13 Jun 2024 09:51:26 +0200 (CEST)
Received: from [192.168.10.3] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 13 Jun
 2024 09:51:26 +0200
Message-ID: <c636e0ec-2047-408e-9511-29e9e19a438e@phytec.de>
Date: Thu, 13 Jun 2024 09:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] doc: board: phytec: phycore-am62x: Fix Link to
 Documentation
To: Daniel Schultz <d.schultz@phytec.de>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <upstream@lists.phytec.de>
References: <20240612161639.2660205-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240612161639.2660205-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWyRpKBR/ffkqw0g41fLSymTtrMbvF2bye7
 Rfc7dQdmj1cHVrF7nL2zg9Gjv7uFNYA5issmJTUnsyy1SN8ugStjxp78giaOijlrN7A0MD5n
 62Lk5JAQMJF48nQnexcjF4eQwBImiX1T/zNDOHcZJRa9vssCUsUrYCPR3vubFcRmEVCV2PCi
 mR0iLihxcuYTsBpRAXmJ+7dmgMWFBcIlfm+YBGaLCJRI7Jh/mRnEFhKwkrh0dTFYPbOAuMSt
 J/OZQGw2AXWJOxu+gc3nFLCWePL2GhNEjYXE4jcH2SFseYntb+dAzZGXeHFpOQvEB/IS0869
 ZoawQyW2ftnONIFRaBaS82YhWTcLydhZSMYuYGRZxSiUm5mcnVqUma1XkFFZkpqsl5K6iREU
 6iIMXDsY++Z4HGJk4mA8xCjBwawkwjtrYVaaEG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGp
 QgLpiSWp2ampBalFMFkmDk6pBsa4GWtspPerr44/dti0x1j35/4/Et2/1DbyHfwybcLZ25fj
 v3QIt02cfmpmcNakuv3vypWuJu2p+q6mVrR9/zcmr89qFWrbRKJmrO1Q3Wx2Zs4nD5fdt6U2
 dtbZ5ATHrzTiay5WO26z/b/DcdZnOVlRbqm9bbM/mtULZInEdIcGx5t8lti+1keJpTgj0VCL
 uag4EQBQSxBsYwIAAA==
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



Am 12.06.24 um 18:16 schrieb Daniel Schultz:
> We moved our documentation to another hoster and therefore the URL
> changed. Point to the latest documentation instead of release versions
> to not link out-dated documentation.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

For all three patches,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   doc/board/phytec/phycore-am62x.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
> index bc6d5246694..681ac536125 100644
> --- a/doc/board/phytec/phycore-am62x.rst
> +++ b/doc/board/phytec/phycore-am62x.rst
> @@ -155,4 +155,4 @@ Further Information
>   -------------------
>   
>   Please see :doc:`../ti/am62x_sk` chapter for further AM62 SoC related documentation
> -and https://docs.phytec.com/phycore-am62x for vendor documentation.
> +and https://docs.phytec.com/projects/yocto-phycore-am62x/en/latest/ for vendor documentation.
