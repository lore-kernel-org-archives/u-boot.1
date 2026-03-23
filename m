Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BB4F4613F
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 22:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E0584073;
	Mon, 23 Mar 2026 23:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="jfmGZmQJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B8584207; Mon, 23 Mar 2026 18:34:50 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751808408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 18:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 041A110CD62; Mon, 23 Mar 2026 18:34:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774287287;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=WzPkNrZOvg15K39eeW+p7WA9xP0qtKJ/Q8WccdG8HDw=;
 b=jfmGZmQJ3Jzs2PJ/t9G2+tVJNbYIX8l47vqs5URlZw5IhY9NgZXgGC9ca0HX37Ynu63L2v
 5a33xfyB1VzYVuSXoaWGanbTi41x9notNh8luEwk6pk4z84UuCtje0Qz7VqRrjbSOh0q17
 SE4oJoYh9n+AhVTR2y9BDzQ2+NbYCJcP+Yq3KdUfZ59WSUYwcHmJ0CA3QokL8Hruve4kbh
 KhesSn2j70ZNiWCbnXw5FwsqROZdv6h9oJnYo9VUE+NtT6cCpfv3RFYZ4gf75sDHJCIQWy
 TYiMkLj9uCMl/X1EgQGIZBJDLvHJvmZirLEnXENLrT77y+fTj3RLfLGj87StMw==
Message-ID: <b5b04334-704e-49aa-819d-c6500e82e35f@nabladev.com>
Date: Mon, 23 Mar 2026 18:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: dhelectronics: imx: Use second Ethernet MAC also
 from fuse
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260320102918.4011-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 23 Mar 2026 23:56:21 +0100
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

On 3/20/26 11:29 AM, Christoph Niedermaier wrote:

[...]

> +int dh_imx_get_mac_from_fuse(int dev_id, unsigned char *enetaddr)
>   {
>   	/*
>   	 * If IIM fuses contain valid MAC address, use it.
>   	 * The IIM MAC address fuses are NOT programmed by default.
>   	 */
> -	imx_get_mac_from_fuse(0, enetaddr);
> +	imx_get_mac_from_fuse(dev_id, enetaddr);
dh_stm32 uses the second parameter as the ID, so let's be consistent here.
