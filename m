Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D32BC54FB3
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 17:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA28881E06;
	Mon,  2 Jun 2025 19:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H3jVN1Gx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A1B181E25; Mon,  2 Jun 2025 19:23:53 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0054280BAE
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 19:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552HNmSG302530;
 Mon, 2 Jun 2025 12:23:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748885028;
 bh=K6ToYn1L3kk2epoPQ0Wvr2S+dn3T5043o46cl4ARSLI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=H3jVN1GxYtQqQwF9aDX8rx4aq2rkNcl584BgNh7kkuHCd5AtwPxlCKVoFBUQnBB4p
 FIWLXFy6ljBMcyRmiX4WT59q3NglZ/OwHF5Ac4VNDpLmHi9U3iTEXH67V2osVry0rk
 Ck7OLhymeigDDfQvyAGPRySdjQqetU3jgIU6qQQc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552HNmYV3021483
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 12:23:48 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 12:23:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 12:23:47 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552HNlwg3284229;
 Mon, 2 Jun 2025 12:23:47 -0500
Message-ID: <4b3e2d64-c2ed-4837-b89d-bbafea3dd034@ti.com>
Date: Mon, 2 Jun 2025 12:23:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tiU2025.01 1/2] binman: openssl: remove unused encryption
 extension
To: Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
 <20250602-am62xsip-v1-1-ae8aa62b4b6e@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250602-am62xsip-v1-1-ae8aa62b4b6e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 6/2/25 11:56 AM, Bryan Brattlof wrote:
> We currently do not have a way for binman to encrypt any component it
> packages. Remove this to avoid any confusion.
> 

 From the subject tag, was this meant to be sent to our internal list for
inclusion in our evil vendor tree only? I think these patches would apply
upstream too so just checking.

For this patch, what is missing now to get binman to start encrypting
these components? I'm thinking it wouldn't take that much extra and
so leaving the comments here would be good to remind us of what we
still need to do.

Andrew

> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   tools/binman/btool/openssl.py | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
> index c6df64c5316d53735fb147858b24185096254ec2..2e128e477bce87568b6d9647bbf2666f9770d732 100644
> --- a/tools/binman/btool/openssl.py
> +++ b/tools/binman/btool/openssl.py
> @@ -198,7 +198,6 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>    1.3.6.1.4.1.294.1.1 = ASN1:SEQUENCE:boot_seq
>    1.3.6.1.4.1.294.1.2 = ASN1:SEQUENCE:image_integrity
>    1.3.6.1.4.1.294.1.3 = ASN1:SEQUENCE:swrv
> -# 1.3.6.1.4.1.294.1.4 = ASN1:SEQUENCE:encryption
>    1.3.6.1.4.1.294.1.8 = ASN1:SEQUENCE:debug
>   
>    [ boot_seq ]
> @@ -215,12 +214,6 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
>    [ swrv ]
>    swrv = INTEGER:{sw_rev}
>   
> -# [ encryption ]
> -# initalVector = FORMAT:HEX,OCT:TEST_IMAGE_ENC_IV
> -# randomString = FORMAT:HEX,OCT:TEST_IMAGE_ENC_RS
> -# iterationCnt = INTEGER:TEST_IMAGE_KEY_DERIVE_INDEX
> -# salt = FORMAT:HEX,OCT:TEST_IMAGE_KEY_DERIVE_SALT
> -
>    [ debug ]
>    debugUID = FORMAT:HEX,OCT:0000000000000000000000000000000000000000000000000000000000000000
>    debugType = INTEGER:4
> 
