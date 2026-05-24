Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE1ECD4F54
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 23:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E259883FF5;
	Mon, 25 May 2026 01:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BrVQ/C0R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2288404D; Mon, 25 May 2026 01:37:21 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE3983EF9
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 01:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6F68A114148; Mon, 25 May 2026 01:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779665838;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=gkXGm3cepH4dqbERA+4J6KyEXxvn2kPuNCXz0S4gfUY=;
 b=BrVQ/C0RrfC2mqhJN4hgjFZwyycwK2xHZ1IwWCtiK7G3JXtb52UjzJIJxbULxXZ5Ar7AQk
 fykTMQ8q2HVDN6vzR2w4X5WHtxpFZ8BGQlqHO+8n2AeS+hC/ylr9lQCvXaG5dFbGmVafaD
 PbZLSEaB1sH1a7uQIRhg19ncTL/yQ6ofDn0uyCDIKJM3z3kac7Qw6i17WqAkZOXGiBqhX9
 RetQDxwpucit/Lwq92+LXtpdbCb7nILhCe+bmHuHNmlB92h/avIF7uZYfehlkSrUF9ClPv
 DMJ/Vj/LkAic9npW/HNaYvuMSLTD9SVqMSvdY99jW1dAdWNGQNmxP5FGst5QIg==
Message-ID: <cfa42674-8349-445e-aa10-ba92b6a9eaaf@nabladev.com>
Date: Sun, 24 May 2026 18:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] binman: add CST backend selection for i.MX8M signing
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260504190531.103295-1-marex@nabladev.com>
 <CAFLszTg+Ak2oZmYo4qy9T8kXpM=Mk1Vv0+dUucW7-xi9MX-Duw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <CAFLszTg+Ak2oZmYo4qy9T8kXpM=Mk1Vv0+dUucW7-xi9MX-Duw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/7/26 5:31 PM, Simon Glass wrote:
> Hi Marek,
> 
> On 2026-05-04T19:04:59, Marek Vasut <marex@nabladev.com> wrote:
>> binman: add CST backend selection for i.MX8M signing
>>
>> Add support for setting the CST backend, both via DT property and
>> CST_BACKEND environment variable. The CST currently supports two
>> backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
>> CST tool is invoked without any -b parameter. Keep 'ssl' backend
>> as the default, but explicitly pass it via the '-b' parameter,
>> unless the user selects 'pkcs11' via either method.
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>>
>> doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 +++++++++++++++++----------
>>   tools/binman/etype/nxp_imx8mcst.py            | 19 ++++++++++++++++-
>>   2 files changed, 37 insertions(+), 12 deletions(-)
> 
>> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
>> @@ -90,6 +97,10 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>> +        self.backend = os.getenv(
>> +            'CST_BACKEND', fdt_util.GetString(self._node, 'nxp,cst-backend',
>> +                                              'ssl'))
>> +
> 
> Please add a binman test covering this new feature - see
> testNxpImx8mCSTFastAuth in ftest.py and the vendor/nxp_imx8_csf*.dts
> fixtures. The missing coverage line for me is 177 (cst_backend =
> "pkcs11" )

The pkcs11 option requires a HSM, how do you propose to test that ?
