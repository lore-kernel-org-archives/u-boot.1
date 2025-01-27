Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE65C0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 23:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31C38187B;
	Tue, 28 Jan 2025 00:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738020175;
	bh=fw97KcnGS5kepJgklpOxbCjdYDeYtqs35L5NXo/oImM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=em7PJU3QZxM89LUAOUd2Oi0MODGiRpg4Zo4nDXpBOP1+1tx/I49jXGTGs8JF/xXnr
	 UaevgcVIYSa7XuxZXaNqZ9XVO9Xu4dE085FHqhrLimoooy5D/Ni6ipibkuFronNaMA
	 0Rb3qocE52L6kmmR/c+Db4Sios7aq3HqUP3tmPUJ8h9RNgWAdl0bOiWJsuBTvvjCJW
	 NJ6XZ4pFSI3o6GxPPHZrGjxQTSkgaNGYjvYVQ5m3DeYsaXIHBqmHgynE5T3YvgpupQ
	 PUpmFeXnfStowg38BG6kNZj+bPa+mM+BgECr2/oV856e334wJCHDJK1ZgJGdWXGM1W
	 p+4G45I2Qq6mA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316208186D; Tue, 28 Jan 2025 00:22:53 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1537A8187B
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 00:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="IlzzYeev"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7C9F103802C0; Tue, 28 Jan 2025 00:22:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738020170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw97KcnGS5kepJgklpOxbCjdYDeYtqs35L5NXo/oImM=;
 b=IlzzYeevSEEBznlOqzagilFvjwOlMWNc8q2st0UQRT0HsZ4HIob21i4RAzVyvSxymZzyOl
 9AylkxxdK+ORPgoCcxGrnA+cTsqrGLZzR1AKOg9ocwwcw0eXfXd3fWqi+XZRdnM6KGUvU2
 +iwAo/A+O5GrfrVc8KPDsc78J7UBPI94mDNeSMV1zo2bc6ho2b/r8wkArC6Nogi/f/QRCs
 WM0TgsQhAgFZOEhVHFBV4awvcShncofArfp2LjrTxpX4y/ev1Ym+xNYJvMUX4t0Wsd+npI
 c8e7xQzAcQp+UPKoCQbs5ZjlmEq8ADmA3XheRKUyML4JJoyNRB1hKqVSQMVPkQ==
Message-ID: <1733bfa4-ac28-40a7-b9c1-5f72347666f2@denx.de>
Date: Tue, 28 Jan 2025 00:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: Fix NULLPTR dereference when serial# is unset
To: Michael <michaelsunn101@gmail.com>
Cc: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>,
 Lukasz Majewski <l.majewski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
References: <20250127210741.820819-1-michaelsunn101@gmail.com>
 <ff8c7554-a03b-4423-8692-13c7c278095e@denx.de>
 <CAH40Y2icS-vuHc1E2DCCQ3Jd-37hLnHk0vdrbnbG3oj+izy4JQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAH40Y2icS-vuHc1E2DCCQ3Jd-37hLnHk0vdrbnbG3oj+izy4JQ@mail.gmail.com>
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

On 1/28/25 12:12 AM, Michael wrote:
> The problem can be reproduced with U-Boot's sandbox with the default config.
> Then, run the following commands at the shell:
> Hit any key to stop autoboot:  0
> => env set serial# test
> => env default -f serial#
> at which point the program will crash.
Maybe the fix needs to be one level higher ?

diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index 631969b3405..f2540eb6ded 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -207,7 +207,8 @@ void g_dnl_clear_detach(void)
  static int on_serialno(const char *name, const char *value, enum 
env_op op,
                 int flags)
  {
-       g_dnl_set_serialnumber((char *)value);
+       if (value)
+               g_dnl_set_serialnumber((char *)value);
         return 0;
  }
  U_BOOT_ENV_CALLBACK(serialno, on_serialno);
