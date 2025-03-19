Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687D5C282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 02:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D5581A10;
	Wed, 19 Mar 2025 03:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="e6ULjSVB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xnaJoYgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8350819AA; Wed, 19 Mar 2025 03:35:33 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2D5815D1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZHXr35DxPz9sl0;
 Wed, 19 Mar 2025 03:35:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryfrNnI3d0mmIv4Fv2zgjoSstM4ofmEwtddoFms4aRs=;
 b=e6ULjSVBrOxv9STa8FSXkpF1g7Muwc3cdfHGiVh4eUAiY0RdyD5+zNmwXYKc1UM0ze8EC5
 GmPfTRhnQAFiso3reBibtm/XL0QUHjVMBuKZ7v1b9ZeueXSSD7rFx3Cn5tYTusanMsC4Jw
 BPhodCG/1w7WUmSEl+rK3mhfXTJxTp795Cq4AO/6vflYil8VaYG1ZYP8TQ+AM9Nxjad/C8
 GpWuSkzAYx2zA+E6LHUUMUS0E2BuGYiSdGqxluVw7zH/20UsjcM/hzl3AwxcGU7C01ac0q
 g3YHIaOzYNS1RU4qfwY71GJDMM3jn/CHiqMeOxOHDU7nxhsoyXLW+0p3Tk6hKQ==
Message-ID: <1fe51000-7903-430b-b8d2-db5db237ab0f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryfrNnI3d0mmIv4Fv2zgjoSstM4ofmEwtddoFms4aRs=;
 b=xnaJoYgwGwykor3MEghbu1p0SUWO1e3KlEfNPJ5CzwKnXWU9HuKO73pOF0q3CTEpUNZfOe
 ywUTmXnrEck46FhrHo2ip7rPBQVxsaSB68gAm1tKfyeoBsCavN6cS17+tXVAAqKJsm0qzX
 bzpUAq6ZSqiJ+VhaVMJFzW7TVgYPbDu1TKBVEemjCxxUE8VI8dqjw062YVT/tNb1GFI6BD
 ZEChXOg57Hg1RgVRiDhdH4VJCD+QVoopB4TSGL1ognLUFKE5F+TYzEMKCHIwfsQdrjKBZI
 fIkLTULkJ355YZVfhhhOz160v9Nxj3SSsBDey9YY7+9w5UaaklHspaMhsrFT6w==
Date: Wed, 19 Mar 2025 03:33:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
 <7ca4a573-c3b5-47b4-b5ee-76288ab6ec0c@mailbox.org>
 <e317a09e-5ff6-47ae-bf9e-252c22b671e5@bp.renesas.com>
 <01975214-2650-4b33-98d1-39827b984e36@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <01975214-2650-4b33-98d1-39827b984e36@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6cb1ce97db1cba2b4e7
X-MBO-RS-META: jcw7z4s1rn6of8x4h7y7mwquwpeaqsgf
X-Rspamd-Queue-Id: 4ZHXr35DxPz9sl0
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

On 3/11/25 9:28 PM, Paul Barker wrote:
> On 08/03/2025 14:54, Paul Barker wrote:
>> On 05/03/2025 20:05, Marek Vasut wrote:
>>> On 3/4/25 5:37 PM, Paul Barker wrote:
>>>
>>> [...]
>>>
>>>> +static int rzg2l_usbphy_ctrl_assert(struct reset_ctl *reset_ctl)
>>>> +{
>>>> +	struct rzg2l_usbphy_ctrl_priv *priv = dev_get_priv(reset_ctl->dev);
>>>> +	u32 val;
>>>> +
>>>> +	val = readl(priv->regs + RESET);
>>>> +	val |= reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;
>>>
>>> u32 val = reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;
>>>
>>>> +	/* If both ports are in reset, we can also place the PLL into reset. */
>>>> +	if ((val & PHY_RESET_MASK) == PHY_RESET_MASK)
>>>> +		val |= RESET_PLLRESET;
>>>
>>> setbits_le32(priv->regs + RESET, val);
> 
> Reviewing this again before I send v2: We need to read the RESET
> register separately to determine whether to set the RESET_PLLRESET bit
> or not. Since we need the separate read, we may as well use writel()
> instead of setbits_le32().
Understood. Thank you for checking.
