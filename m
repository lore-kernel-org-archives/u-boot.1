Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDEDC531CC
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 20:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28E4660AA5;
	Thu, 23 Jul 2026 20:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_vk91FHa3dx; Thu, 23 Jul 2026 20:41:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58EF660AB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784839306;
	bh=1sGD75Zgbcjt4HBLCC0KvMOWseUdd2ELfXEIf1kwqlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iUXjIRaUdThaXFCMieOmMj97aojImuk79OhyKK0VyAV1dUujVb/5fwcQRsCR8nNxV
	 Cj7AtkHxp/bUXtyyEQ7JjH2sNwpJi4r/oJQnaA3yWBLG7ISwsHU1Xt+4kmuGAb1s9k
	 MnwCOcdw4PN5db06+akJ+2Qp8DyYJwXS3pt2QyWhV+StDVLPyWERUPqCsFh+jUJCx0
	 IAEOwcmTSXcBv45KIvJU5Q45PtttAsmyCOaAhOQOAKbDt2PCtlQHUxBimUfCT80BFv
	 0EijBHKBzt2epwMHSdu/xmMHanad0TsnURJn8tphUXqFhcYaPf9/KgKSpvZFBmMnhH
	 nIe1llcq8Xrtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58EF660AB3;
	Thu, 23 Jul 2026 20:41:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3906A429
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1EB4760AB3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lMBiVnhxyGif for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 20:41:44 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D504660AA5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D504660AA5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D504660AA5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 20:41:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D0F80287; Thu, 23 Jul 2026 22:41:41 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB3AC800AE
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 22:41:37 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso7495465e9.0
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 13:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784839297; x=1785444097;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1sGD75Zgbcjt4HBLCC0KvMOWseUdd2ELfXEIf1kwqlg=;
 b=ojlVZCGpw4pHNy7YCAPLNXKkLLKIYWItVNdDhKp5pY9hqNltAlShdvpA6JnXzOdSWU
 nr6EC0wYZAS3Du9vu7ajjTokgIFRbrqr4yrxHqW8W7bi1LbxCB/oiuaKtdlVm0gDw3cO
 LVSrhuzHXADVecm+iNI8QPwBB64L0xElt+MxM95fRfBcB+oKU4E1W7tueD/4E/HfGn7Z
 dGNQpRb5kbfYve9G2e14HJ6cIbs9CFuHFfGlDLZnZwdiAZeXQHNs15TRxJ6X28MNFT1p
 epbg+Ac+2hM0LvsahSauwZ6YKxI0uyk4yR7PCRdflpr0mELcATB0Zbtj5ONWPaVrusVp
 Gckg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFtN/qM2nJ+tLxLhM4iM5r7Y6Y0DnEHGsEmCc0RlsfWcWHQuJtaUSlE6FnhMmbGN2w0JYKfBw=@lists.denx.de
X-Gm-Message-State: AOJu0YweygPKTzOzwtWiCHced2yYXCLDt0Vf8xmGYRrNiH7UJiMaHwiZ
 W3ufra7Pj2dkG+snWgYC7Mro2PSeTL43PuBTIQHhKlSALxyWNengRzej
X-Gm-Gg: AR+sD10Lt1NTBVB33CL9ftQn4X9MR3r/HB2Ea/8C/jMTpQoogaIOJy5obplPrTf59wG
 bpMT1f4dhdx63jkjD7rcDkwcwX81WYxOg92sfpEblP+uCYdqrE+oDJYLcbrMou8TrZ+Edeer5G/
 FbUXZozB6cF/VTVU6hVGf9QPBTEA1w9OSbx5+qoQ4hsVfJxaw2xKRfHn9Q21/YFz3yNrRivDUMS
 YOxK+REFLicw/oaoWiGOp1x31iH/dFNofcQMse8iKnUZ9bEtlbjQCFMpWXZ7UG6/YamKa+cPQnN
 iCrqpTmXrJ7BiKd3oNNi+iKYv7EAyP2B3VuV0TVPNL/8yCSKVutk1kUB9IY6Lshy7TAvSlXZmWa
 GwiojPj+S/gxLqaRr2VJ8LCkrPv40M1+IvFhQu2EfGA1/0ljN1XVKaxmC22CHNBdvfoyIe2JSfF
 8ZwGRCSN2ajbJu5KysR8nplrZmw5fnJZXSoT9RW7a/gUNdGeTxVziW6qu99ks=
X-Received: by 2002:a05:600c:2d8a:b0:493:f318:3bc6 with SMTP id
 5b1f17b1804b1-49573c9d709mr34909005e9.13.1784839296843; 
 Thu, 23 Jul 2026 13:41:36 -0700 (PDT)
Received: from [192.168.68.84] (host-87-5-153-198.retail.telecomitalia.it.
 [87.5.153.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfa79d3sm5792195e9.2.2026.07.23.13.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 13:41:36 -0700 (PDT)
Message-ID: <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
Date: Thu, 23 Jul 2026 22:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
 <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784839297; x=1785444097; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1sGD75Zgbcjt4HBLCC0KvMOWseUdd2ELfXEIf1kwqlg=;
 b=GhC/dLcDQRReYHT1X1p1DkEwSDN72syRptjD06ELxTjzemYE1+v5Gjl+o4aXdJWK3X
 WVclaTQP0CNaA2UnadVGVHY21ogMKITyM8gqk5Hl/isHFaVssBrz3iAT4nuyRL7CbMYg
 yiiq0Gxc201/1QUo8wkYSa+H9SvayUDcd7HWSD692xicUyffAy6DJkKFKFPyXWl0356B
 C3E5P9qf2FAVMqF7unQs2K9JRsG0DSNG1c4Qpf+cgESt54PYsneGmFhGUZeN1HalqhIH
 Q7KQ9ixRDOdSoyMn5aTmq+vBBbGD6Hb6YH/X4SbDwUa5XFr+qRx+AeGKp0cm7fa+8tPr
 IAAg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=GhC/dLcD
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ghidoliemanuele@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="GhC/dLcD"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/23/26 20:35, Marek Vasut wrote:
> On 7/23/26 4:53 PM, Emanuele Ghidoli wrote:
> 
> Hello everyone,
> 
>> I found that Colibri iMX7 no longer boots when commit 9c1b13b3fd27
>> ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
>> is applied. Nothing is printed on the serial.
>>
>> I bisected the issue: booting the parent commit works fine, and
>> reverting this patch on top of current main also restores
>> boot. It's not yet obvious to me what in this change causes the
>> regression.
>>
>> Would it make sense to revert it until the root cause is found?
> 
> Give Patrice a bit of time to analyze the problem.
> 

Hello,

after the regression, get_timer_us() is called on every cyclic_run() call,
even when the cyclic list is empty. On imx7 this happens earlier than before,
when the timer has not yet been initialized: get_timer_us() calls get_tbclk(),
whose value is zero, and uses it as a divisor in tick_to_time_us(), leading to
a division by zero.

I would fix this by ensuring get_tbclk() returns at least 1 on imx7, but we
could hide bugs in this way. However, this bug could also be present on other
architectures, so I would just guard against entering the cyclic loop by
checking whether the list is empty before doing anything else, so
get_timer_us() is called "at the same point in time" as before.
Something like:
if (hlist_empty(cyclic_get_list())) {
	gd->flags &= ~GD_FLG_CYCLIC_RUNNING;
	return;
}

Kind regards,
Emanuele
