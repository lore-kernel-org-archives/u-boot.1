Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA5DE77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 19:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8CE8039E;
	Sun,  5 Jan 2025 20:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736104851;
	bh=nN88bHogpcawC8JzvnW1SceX75sqW7XZzUO/RxB1/tA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gf5z9VST2ZMGWvyDIA2zosfqHWXI4T99OA3Ly+l9uH09vcNhGb7HJfcnA8UlQI7hV
	 BknS0GXH941f9lZff29cHpQZoUI6lsbSXkGF9r7KMbMMg9+yAhXB+bJktHq6nmiLgx
	 AgTDDE7u5yYGarZ3xk8Jv7KHrV4x/zmAnhcDRXkZs/BrHzyTkcVf8PmHueOf0yYQCE
	 0S0UElz/uJF+yZLMJ3CyJ7olgYZuqTiN2XUnKO/HPNBMI9GUiz+RBWbjlpftSNZVC/
	 fBs/8cMwVrYzm2sOfoBgjgBEbFoZUpVjzxY4onbuXroRRjqTnh654xGgVmmFHgvXQV
	 +AcuKXTmCUhbQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A868C801E8; Sun,  5 Jan 2025 20:20:49 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FD5E801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 20:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="LiaJYh9L"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C56D2104811FC; Sun,  5 Jan 2025 20:20:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736104846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nN88bHogpcawC8JzvnW1SceX75sqW7XZzUO/RxB1/tA=;
 b=LiaJYh9L271Uyu9Z24aOfAC+rkbXtnOU30/Q4Sx3Syp8tDE8NuCeUXX3WjEcPqzDwB4zgp
 FSr0maEygCRy0jh9rKuF/xO/6uwLAaNqgVZZlsTYtX2M647lftbNHg/7ecQLLuivDIHkUG
 xXdiGwM+gb3Od05oE4O/bRopJ0HZS2ZVsSoNZQSCLUuD8YH63RmoC65w6FFu63pteWXJiq
 GM89XHZ+mGTzQUZTzzGEeZj6E02ExXCsXSYjzfhAEAnNQDBaF7E1bdBA/ZXXbbAmfEo2by
 jywwOKN4WefPBIURVzUe2aWLDoh9zNWA3axa+Ty613RPKqc51XtRB0xe6flM3A==
Message-ID: <9a264f5c-48f6-44a6-bdfd-d3f65be2a65d@denx.de>
Date: Sun, 5 Jan 2025 20:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] usb: dwc2: Clean up with bitfield macros
To: Junhui Liu <junhui.liu@pigmoral.tech>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, seashell11234455@gmail.com, pbrobinson@gmail.com
References: <20250104-dwc2-dev-v3-0-d4b2bc1996e4@pigmoral.tech>
 <20250104-dwc2-dev-v3-4-d4b2bc1996e4@pigmoral.tech>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250104-dwc2-dev-v3-4-d4b2bc1996e4@pigmoral.tech>
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

On 1/4/25 4:37 AM, Junhui Liu wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> Use FIELD_PREP, FIELD_GET, BIT, and GENMASK macros to standardize bit
> manipulation across the DWC2 code, improving readability and
> maintainability without altering functionality.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

Reviewed-by: Marek Vasut <marex@denx.de>
