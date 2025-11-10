Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19061CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 05:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2CE283956;
	Mon, 10 Nov 2025 06:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="N5psMYLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A683483956; Mon, 10 Nov 2025 06:58:37 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D05800B6
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 06:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B48E109253; Mon, 10 Nov 2025 06:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762754314;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=K3hW5MzHySSpxCb1sU4uXxOoaQHxSy+Zp9CwZfyqU/g=;
 b=N5psMYLT2x+vlbsKTCVE2y8sNb06fYYUzrSiyVUL49s8AQN7IcNmseu69dMp9PEe1/Cf8N
 5HNL+zVhrQ0/kdkEPWB4X8CKFmt8wLOQy2HtPiD2XtoafC5OTrBpJePUhzmq2/f/+zsCqs
 5Ah742OOatyxdrFCFkh1PLnUP/S220Y5O5YHaA0xgAsszBjswjvP4bvfh7VKwzBvMbLLyF
 VqLRYt3GYecM+pCTN74e0gyIhlS14/GOA486iYtzSAtuvJvaBUwVJXcPTBfCU4se3c63VM
 +3BsjRzSc5lsCBuEUG1lc+koKBs+gxkJ+EVtvPygG9hl08LJDIWEe3luIBIdXA==
Message-ID: <64e1a2eb-2672-c2c6-9c01-8744308f6f87@nabladev.com>
Date: Mon, 10 Nov 2025 06:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] rockchip: i2c: fix illegal I2C START/STOP condition
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Wadim Egorov <w.egorov@phytec.de>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
 <20251107-rk-i2c-illegal-v1-3-3e5fea13a899@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251107-rk-i2c-illegal-v1-3-3e5fea13a899@cherry.de>
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

Hello Quentin,

On 07.11.25 12:39, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> In the last message sent in rockchip_i2c_xfer, the controller is
> disabled (see rk_i2c_disable() in rk_i2c_read()/rk_i2c_write()), then
> the STOP condition is sent (see rk_i2c_send_stop_bit() in
> rockchip_i2c_xfer()) and the controller is disabled once again (see
> rk_i2c_disable() right after).
> 
> The issue is that re-enabling the controller just to send the STOP
> condition doesn't work. When, the controller is disabled, the SCL and
> SDA lanes are not driven anymore and thus enter the idle mode where they
> are kept high by the external HW pull-up. To send a STOP condition, one
> needs to drive the SDA line so that a rising edge happens while SCL is
> high. Experimentally (on PX30 and RK3399), when enabling the controller
> to send a STOP condition after it's been disabled, the controller only
> drives the SDA line to trigger the rising edge for the STOP condition,
> leaving SCL undriven (and thus, high). This means, that because SDA is
> high before this happens and that we need a rising edge, the controller
> drives the SDA line low and then releases it, meaning we trigger a START
> condition followed by a STOP condition:
> 
> SCL
>          _________
> _____...
>          __  _____
> _____...  \/
> SDA
> 	    ^ STOP
> 	  ^ START
> 
> This is illegal in I2C protocol[1]:
> 
>   5. A START condition immediately followed by a STOP condition (void
>      message) is an illegal format. Many devices however are designed to
>      operate properly under this condition.
> 
> My guess is that the I2C controller IP knows that it makes only sense to
> send a STOP condition after a START condition, meaning the controller is
> already driving the SCL line low and neither the device nor controller
> drive the SDA line after the last ACK/NACK as there's no need to, then
> it needs to drive SDA, release SCL to make it high and then release the
> SDA line. However, after it's been disabled, the SCL is already released
> so the controller only essentially drives SDA and then releases it.
> 
> It happens that this seems to be breaking the SE050 Secure Element after
> a few transfers in the middle of a transfer where it starts clock
> stretching the bus forever. It may be related to Errata 3.2[2] but the
> description of the setup isn't an exact match to the current situation.
> 
> It seems to be required to disable the I2C controller between messages
> as the Linux kernel states that "The HW is actually not capable of
> REPEATED START. But we can get the intended effect by resetting its
> internal state and issuing an ordinary START.". Between messages, this
> logic seems fine as I get an Sr (repeated START condition) before
> starting the next message in the transfer without a STOP condition.
> However, we should NOT disable the controller after the last message in
> the transfer otherwise we do this illegal START condition followed by
> the STOP condition, hence the added check.
> 
> [1] https://www.nxp.com/docs/en/user-guide/UM10204.pdf 3.1.10 The target address and R/W bit point 5
> [2] https://www.nxp.com/docs/en/errata/SE050_Erratasheet.pdf
> 
> Fixes: c9fca5ec8849 ("rockchip: i2c: don't sent stop bit after each message")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   drivers/i2c/rk_i2c.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)

Thanks for the detailed explanation!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
