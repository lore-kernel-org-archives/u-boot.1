Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C72C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB2584660;
	Thu,  7 Aug 2025 18:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (3072-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="d0Q0d2kp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16CD84661; Thu,  7 Aug 2025 18:47:15 +0200 (CEST)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617F8845EC
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 21A5D240027
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:47:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
 s=1984.ea087b; t=1754585233;
 bh=V9gFpJGA0KBM8MiH+eNruAL4zNP5eteEv2Aclqv0UbI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=d0Q0d2kpYjsHj2Cs8zY1udyayKJDfiIoGIOAv0a69t4LXeFvEfNuceAe2HqcQ06tA
 tN+nGsIGnUpRHjlKfJwrzr38k2w2wOm66149CfVdsy8ruLtZle07N6Hjiz6W5cnT6t
 qioJI4+XN8LYmyrwcmP7VydjogBdjIdFuzGVpJ0DmK4hYiuWAHkh3VAszLoB3pX1hI
 GvS7B+awefvn+iWbtBcQzhOB1vId5SPWpDrW6IbpLdv33wY6zNieC/GQjj/uw5CPZi
 guUF9L0oLWJG2+IVE9hMZx71GBRidQbY66QM5UI3eH8/zQ0KCJBmV+ZPqshvBfZ4Sb
 Xg06ffoczXSPWH6c3x7zHYHAmo8mrZszylBr6a0xGPir3JKwQrPPUdg+0uaWNI8N55
 Vwfc7GzrBdVj70BgorB8Pwyt44Nf5jzzU3Ax3EbSACWvfPwo0+NB+cogVHytpXzgRj
 artrXgxkV8IRpjgKdK8Kabe8KFN2rXhmFvUrDcKJTq4CeaSldN8
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4byY3h3Nfjz9rxV;
 Thu,  7 Aug 2025 18:47:12 +0200 (CEST)
Message-ID: <3f5e1587-0f18-afa1-67ed-b260feffdf2d@posteo.net>
Date: Thu, 07 Aug 2025 16:47:12 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] pinctrl: nexell: Cannot test unsigned to be negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
Content-Language: en-US, de-DE
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Andrew,

thanks a lot for fixing this Bug :-)

Regards
Stefan

On 07.08.25 11:16, Andrew Goodbody wrote:
> In s5pxx18_pinctrl_set_state testing count to be negative will always
> fail as count is unsigned despite receiving the return value of a
> function that returns an int. Change count and idx to be of type int to
> allow the test to work as expected and remove the need for any implicit
> casts. Also change pin to be u32 which is what all called functions
> expect.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/pinctrl/nexell/pinctrl-s5pxx18.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> index e7d0994f29e..a6ae5764fbc 100644
> --- a/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> +++ b/drivers/pinctrl/nexell/pinctrl-s5pxx18.c
> @@ -130,7 +130,8 @@ static int is_pin_alive(const char *name)
>   static int s5pxx18_pinctrl_set_state(struct udevice *dev,
>   				     struct udevice *config)
>   {
> -	unsigned int count, idx, pin;
> +	u32 pin;
> +	int count, idx;
>   	unsigned int pinfunc, pinpud, pindrv;
>   	unsigned long reg;
>   	const char *name;
> 
> ---
> base-commit: 3526f990b77fca1c933f1d8b24eb9385010a05bf
> change-id: 20250807-pinctrl_nexell-bc6669ff52e9
> 
> Best regards,
