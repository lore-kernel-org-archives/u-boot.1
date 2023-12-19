Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49135C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 13:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F8E87282;
	Tue, 19 Dec 2023 14:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="X9yYHFUU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 253198752B; Tue, 19 Dec 2023 14:39:08 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FCAC871CC
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 14:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 044D7A13E8;
 Tue, 19 Dec 2023 14:39:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=mail; bh=PYDF6pWKn6RBcgBlAXHy
 692IiZus+0Nl1w+yib3VAzQ=; b=X9yYHFUUlgplscpx9K6D/1M9fGHQGlwtMLZt
 0dw6gv3sSiHfAyn6RxkMLHUe/zhCo75AZeav5W1af04CyZB+F2lsnooXH1xNEybf
 g7JuN54ZhuYeYscnGlbEg85qSgLZ6Ut7aPoWkFzkkWsgupTyLfkDLBUk/z7klt5r
 EeAVk8GT7hbs0jR1TpQT3AJk/IceItLIEYDKsL/NZB1fhRCiINpO19IuW08kAoTA
 Ej+cGWxiQkR+rEtjU5YgxSrXd5/IvtA5bXQg42d2EDSLvUNFk82DkBCVqYN7DyOd
 r4fAIAOdXQPg6Ye+pqUnid1JhUmkbABlWYiecivcjKCYwCL+jJxLJ0GK0aU7NIic
 3p45pEt8HxKkNKee58psDQK1d7zP2bD9rNtUtg1g1Dsk9Ey/qTqhvlCfFQtbXTnU
 Ngg4aOBNQgzan9eEdvpzorrR+Q2qUTS+2rTiHlbMn00Y3Ws04fE9ONIbAOjqfRtV
 Mr7OWZYtyB9N12pTunI86OZjqvExucorjnijv1tmvuM17qZNZwVFDEDmPP+eRVrW
 l+BZiXrd+hkl9Mc4qgPl8V4DP7z/kKWK7ebLjZvMQMXdsV3tavyIOREEyJIOTwD3
 e0nl4hzE7KYmnSVnoHE5t9BGQipTJzSpVYktX8AWrFF9qg77trVEx8z+64OZ1q21
 uSUEgnw=
Message-ID: <7069b019-cc2b-46fa-b293-034e9dbbc698@prolan.hu>
Date: Tue, 19 Dec 2023 14:38:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: rsa: Print detailed error info in rsa_engine_init()
 on engine resolution failure
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, Haijun Qin
 <qinhaijun@eswincomputing.com>
References: <20231214165416.35354-1-csokas.bence@prolan.hu>
 <20231214175402.GN2513409@bill-the-cat>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20231214175402.GN2513409@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.254.7.28]
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A29CE70385C6D7C66
X-Mailman-Approved-At: Tue, 19 Dec 2023 14:42:46 +0100
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

Thank you. Just one question: When can we expect it to be applied?

2023. 12. 14. 18:54 keltezéssel, Tom Rini írta:
> On Thu, Dec 14, 2023 at 05:54:17PM +0100, Csókás Bence wrote:
> 
>> Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 

Bence

