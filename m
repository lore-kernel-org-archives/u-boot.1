Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09565CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 16:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC32D84AFA;
	Thu,  7 May 2026 18:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ig8wkkjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1179B84ADD; Thu,  7 May 2026 18:03:01 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A64484A75
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 18:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gBH8c1Ntdz9v0h;
 Thu,  7 May 2026 18:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778169776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOm2wYSBItAXJUY8/uFahUV2rFh9AgF217Fky78rwFA=;
 b=ig8wkkjFpCScoYwsEMlrB4KckWx49Lh1/O6aUdY1O9jZjJCEIMCzACBSe65dIcP+muX0Nn
 8fuGs0a9+REAgIfi/bmynZDMRc3RR+/Po4lNsK4YrNZq3beIdATVrLANir/ZWatGMQgMtN
 LeD3cWm96hpQJSz2MjN+YwBVBhVILWZOhX0TmL3lHxvrdsbEeDFpPqcmE1VElHIKiF1IcG
 NHu7c5u9mPk1TrmKyYOE6jj5Cfx1pOp9AsXULYm4LZooolUe4+jKJv/xl1K7j1v6jxZ1qg
 XLh3uSYZkN2A30tmYZWWesxuXaxhHgOk8yB/UNoyuIV6UpLCN+SDhIQ5Z1q6zw==
Message-ID: <8957e4ff-ee00-402a-948d-6b4a618aa7df@mailbox.org>
Date: Thu, 7 May 2026 14:47:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Chris Morgan <macromorgan@hotmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>
References: <20260507-usb-v2-1-3958b8732553@oss.qualcomm.com>
 <87ik8zd2wb.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87ik8zd2wb.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tio7sg6xquah4cyn33ihhniighrh5cjr
X-MBO-RS-ID: 79492c67965f7cb52a1
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

On 5/7/26 10:45 AM, Mattijs Korpershoek wrote:
> Hi Balaji,
> 
> Thank you for the patch.
> 
> On Thu, May 07, 2026 at 10:06, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
> 
>> The dwc3_free_one_event_buffer() function incorrectly called free()
>> on event buffer structures allocated with devm_kzalloc(). This
>> caused heap corruption and a synchronous abort when exiting
>> fastboot mode via "fastboot continue".
>>
>> Device-managed memory is automatically freed when the device is
>> removed, so manual deallocation causes the heap allocator to access
>> corrupted metadata.
>>
>> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event buffer cleanup")
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
> Marek, I'm assuming you will pick this up.
> If you want me to take it instead, let me know.
I'll pick up V3 once the nitpick is addressed.
