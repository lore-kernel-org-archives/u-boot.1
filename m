Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D72BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 11:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935B28667B;
	Mon, 16 Oct 2023 13:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oa7tAF3L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37FC48667B; Mon, 16 Oct 2023 13:36:21 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC55586823
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 13:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GBaELV008435;
 Mon, 16 Oct 2023 06:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697456174;
 bh=i1nIlmQpWTiWLZIhnYmUHZ+tuCBygPviZ+KxG99eMos=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=oa7tAF3L1rWx11lTSF0cjocPRm538GLjfqA2eJCJWN7iXgFIbXeTwWT5hpooRlpQo
 upcmd5n6kYKT47Nc8VBLXmSrqCNaeOt5ACE0uJz3xhlfstmrF7EqVrm6/ee2eaCPxx
 atEqMpTYq64N4WeK+/2xZ4/SmnmFkSGF68uYOX6A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GBaEWK015434
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 06:36:14 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 06:36:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 06:36:13 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GBaAVK006970;
 Mon, 16 Oct 2023 06:36:11 -0500
Message-ID: <b1d5604f-93ef-4ece-b359-c6f7365476f8@ti.com>
Date: Mon, 16 Oct 2023 17:06:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] binman: Reset missing bintools after testing
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>
References: <20231014204033.3077052-1-sjg@chromium.org>
 <20231014204033.3077052-2-sjg@chromium.org>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231014204033.3077052-2-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Simon

On 15/10/23 02:10, Simon Glass wrote:
> For tests which fake bintools being missing, we need to reset the list
> afterwards, to ensure that future tests do not also see the bintools as
> missing.
> 
> Reset the list when processing is complete.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/control.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index c6d3205b8c25..2f00279232b8 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -858,6 +858,8 @@ def Binman(args):
>                   data = state.GetFdtForEtype('u-boot-dtb').GetContents()
>                   elf.UpdateFile(*elf_params, data)
>   
> +            bintool.Bintool.set_missing_list(None)
> +
>               # This can only be True if -M is provided, since otherwise binman
>               # would have raised an error already
>               if invalid:

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
