Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E05D12D53
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 20:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D7988EC4;
	Sun, 10 Nov 2024 21:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hFAYGX4d";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ij3lPtiP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A638088E1C; Sun, 10 Nov 2024 21:56:44 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493FC8918C
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 21:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XmlN96jhyz9sdG;
 Sun, 10 Nov 2024 21:56:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731272202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCVtLMgZzNIRM5oTU/7F4PztCW/P4o9zOtJTeIvApd8=;
 b=hFAYGX4d3KkDjgughbTZbYrT41Q0uJ/2ybHlr8WhEbR+i9F0F2xyR+Vi4gUEoyVCmBNZqg
 /mgVGr24VkJTo8pcXfBC3UuOQKrSc/drZ++UOVD+ph5TulstBNzCAz41jyyZ6yGeGeeets
 SGTLY6azkIbUUzcYi1tIt8Vu5q59S+mSF1dy9GXtx11VLWjxard2xTG9ziHr9ziPof+8dU
 Y2fvBHIMfWpdMQFvltIMcFP93Fiim/7syhmYdIKGtokawYWukdBiCh9IhrTdCKCG8pYQ3/
 TAfMDj8R0AEOE2d/RW5VXed1DTt3hBqookNfE2pFvmzJBRetQ4H60b7uqYQEmw==
Message-ID: <567cf742-5285-4689-b34f-90bdd7150d48@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1731272199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCVtLMgZzNIRM5oTU/7F4PztCW/P4o9zOtJTeIvApd8=;
 b=Ij3lPtiPUvf/WgYiDrdjsbwnyDeuywBI0PjQUDSlvRztQDndhU5Hu8Hyl3mzOzipKd+1P5
 lk8cyJo0QOFeoJGVe41Dq/GNkwsPV5BUvrIywxpO4YYwPieMIG4BbeFjN4NtmXamEhVuGH
 6y7VnbO6+zke7EPHzpqGLwvon1j2dCFhVTod7T/cNdww/TOQNbrM8QNKIvS/rjYRZXJVUd
 Tx3vsy4xBPXdr5djV+gT+pWWbDFZ8E8lQKgp0jm3tgz6jymc+8mZrNCyo3hDotpR1mEysH
 ANkOl6xaiMO/II81Ww3selcVSY7DKRZdsFXOZjHj6aA6aRvWlO+eHYaUkGA8sA==
Date: Sun, 10 Nov 2024 19:34:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 06/14] net: phy: ksz90x1: Handle ksz9131 LED errata
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-7-paul.barker.ct@bp.renesas.com>
 <ff3ff3f4-c7b1-4a8b-9a0a-0153404bc56b@mailbox.org>
 <9357db88-c9f3-4864-a8e1-61a83954f09b@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9357db88-c9f3-4864-a8e1-61a83954f09b@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: a4xiqdk36zs7d7dzsfuhxmb9diw1y5g5
X-MBO-RS-ID: d79f04015d72618c316
X-Rspamd-Queue-Id: 4XmlN96jhyz9sdG
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

On 10/28/24 9:47 AM, Paul Barker wrote:
> On 27/10/2024 16:18, Marek Vasut wrote:
>> On 10/24/24 5:24 PM, Paul Barker wrote:
>>> Micrel KSZ9131 PHY LED behavior is not correct when configured in
>>> Individual Mode, LED1 (Activity LED) is in the ON state when there is
>>> no-link.
>>>
>>> Workaround this by setting bit 9 of register 0x1e after verifying that
>>> the LED configuration is Individual Mode.
>>>
>>> This issue is described in KSZ9131RNX Silicon Errata DS80000693B [*]
>>> and according to that it will not be corrected in a future silicon
>>> revision.
>>>
>>> [*] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9131RNX-Silicon-Errata-and-Data-Sheet-Clarification-80000863B.pdf
>>>
>>> Based on commit 0316c7e66bbd in the Linux kernel.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>    drivers/net/phy/micrel_ksz90x1.c | 24 ++++++++++++++++++++++++
>>>    1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
>>> index c48ae6e88f30..4f99b115a3c7 100644
>>> --- a/drivers/net/phy/micrel_ksz90x1.c
>>> +++ b/drivers/net/phy/micrel_ksz90x1.c
>>> @@ -436,6 +436,26 @@ static int ksz9131_config_rgmii_delay(struct phy_device *phydev)
>>>    	return ret;
>>>    }
>>>    
>>> +/* Silicon Errata DS80000693B
>>> + *
>>> + * When LEDs are configured in Individual Mode, LED1 is ON in a no-link
>>> + * condition. Workaround is to set register 0x1e, bit 9, this way LED1 behaves
>>> + * according to the datasheet (off if there is no link).
>>> + */
>>> +static int ksz9131_led_errata(struct phy_device *phydev)
>>> +{
>>> +	int reg;
>>> +
>>> +	reg = phy_read_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG, 0);
>>> +	if (reg < 0)
>>> +		return reg;
>>> +
>>> +	if (!(reg & BIT(4)))
>> It would be good to have symbolic names for these BIT()s , please add
>> some #define ... macros .
> 
> I can add symbolic names for the values used above
> (KSZ9131RN_COMMON_CTRL=0 and KSZ9131RN_COMMON_CTRL_LED_MODE=BIT(4)).
> 
> The arguments used in the following phy_set_bits() call are a bit
> trickier - all the errata document says is "Register 0x1E (30d), bit 9
> must be set to 1". The Linux kernel commit adding this workaround
> doesn't have any symbolic names either.
Maybe also send a kernel patch ?
