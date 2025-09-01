Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FE5CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E42C833E9;
	Mon,  1 Sep 2025 08:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="axJ6nAGB";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CKCkg7bw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E68838AA; Mon,  1 Sep 2025 08:10:41 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65006833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1756707039; x=1788243039;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=jgKqet3aMaydwRJX9R2cGtm136EdWHgiJUvI2pNmNwA=;
 b=axJ6nAGBr6xCSFgTjkDNtQS2CvodP2xe6H0RQMaO07OTCSJvshP6R+EK
 uVsZXyY+ATHGwnY59Bm+xIuq5iNbGlP4PUr7VeoUsgBHJg7aQQT+6JDma
 DPQh6OfLCNJwIj3KELKpoGi08pD1HYybEOOKF8+qB3HvyaMBEcGfkY8me
 36r50EUt6cXD/x9raLX7591aTLT4rwxXiA0R6Dpx03tbhK2pVntkD1NGT
 7SG90L+qSDmmD0ra3AtpFXM14YNTwklzWvoQINo8zc6cQBtfHNw39ptJn
 nYB8WlWczzXTNb0ivMdsV0OoLhLKUEINdx71NYvbHtW5MpLgfCd6yFp3H Q==;
X-CSE-ConnectionGUID: iprRSsXBQza/KPLHIri4lw==
X-CSE-MsgGUID: uegQ0qcTTs6A4NkyRzL33Q==
X-IronPort-AV: E=Sophos;i="6.18,225,1751234400"; d="scan'208";a="45997717"
X-URL-LookUp-ScanningError: 1
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 01 Sep 2025 08:10:37 +0200
X-CheckPoint: {68B538DD-34-9821D066-F5C64F68}
X-MAIL-CPID: 37A4E22FED801978B2636470C1E4B3F7_2
X-Control-Analysis: str=0001.0A002116.68B53911.0053, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED88C1613D9; Mon,  1 Sep 2025 08:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1756707033;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=jgKqet3aMaydwRJX9R2cGtm136EdWHgiJUvI2pNmNwA=;
 b=CKCkg7bwPmz5sJj54VJzw/zou8/WTVx8qclWlkXy27c+FtzX3Yq3yeyfXWpy+0xCnXnNch
 ZQn/SsuH2hBM0cWx/P0PHwCl4o2ANft0tm80OSuP4xrzwU5SXqydVbAnPWxyYAN5YOBpe3
 WoISPl5lbb3F6TRbhx8Ee9XqMVxEqdWPPpomjHCc+YAP3l3lqYewNr61J83b2MGGVCz62p
 JAfGQC/FcI0As5fOp7OLFBM3Kby7XiaWs/A+ZaM/vTn0kCS/VDqE5K/N+NQ1FFnh17qbib
 7xLCGVnHVx54tI9FXT64SZ9Ql4fryldB8xXgaSLt6m7JgBJa+gOIMIRtox7lIQ==
Message-ID: <8ae341fe-3018-4256-bd6c-af5425f9f416@ew.tq-group.com>
Date: Mon, 1 Sep 2025 08:09:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] tools: zynqmp_psu_init_minimize.sh: Switch to
 clang-format
To: Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
References: <20250829233951.547352-1-javier.tia@linaro.org>
 <20250829233951.547352-5-javier.tia@linaro.org>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20250829233951.547352-5-javier.tia@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 30.08.25 um 01:39 schrieb Javier Tia:

> Replace the use of scripts/Lindent with clang-format in
> zynqmp_psu_init_minimize.sh. This change is made to align with the rest
> of the codebase that uses clang-format for code formatting. This ensures
> consistency across all scripts in terms of code style and formatting.
> 
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>   tools/zynqmp_psu_init_minimize.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/zynqmp_psu_init_minimize.sh b/tools/zynqmp_psu_init_minimize.sh
> index 5c8b73703bf..f8b729ebc97 100755
> --- a/tools/zynqmp_psu_init_minimize.sh
> +++ b/tools/zynqmp_psu_init_minimize.sh
> @@ -82,7 +82,7 @@ for i in $FUNCS_TO_REMOVE; do
>   sed -i "/$i/,/^}$/d" ${OUT}
>   done
>   
> -scripts/Lindent ${OUT}
> +clang-format -i -style=file ${OUT}
>   
>   # Prepend 'static' to internal functions
>   sed -i 's/^.*data(void)$/static &/g' ${OUT}

This Commit must be made before
[PATCH v1 2/4] Lindent: Remove wrapper around indent tool

First switch to clang-format and then delete scripts/Lindent.

Best regards,
Max

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

