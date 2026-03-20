Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743FC1093172
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 03:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A89383F9B;
	Fri, 20 Mar 2026 04:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JX9AGciE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85FFC83FA4; Fri, 20 Mar 2026 04:59:13 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B159C83D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 04:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fcTMf04Lyz9tk9;
 Fri, 20 Mar 2026 04:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773979150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/t+0Vusft5xteW/0IKj4auGzmo4E2Ue6C0sMJDJzEs=;
 b=JX9AGciEsstRTF7lOlFqEoaYAHGLaR5axOkJdju9kPQMDJt873BKcPCJjjFTzPiWHm9PzP
 qnTGkme4ikoFzQEeRsedf9cX86pWGbnwTb7erTmsCx4KOLei+3qsddlYsWQMpoG0t1bml9
 6CmB+hnbjYeukLWMDdDWzSQ6dO1Z9bN2S0T3rSrqGmiyrxARXZ86443yY02Hn8B39iChti
 O4SsRciy3zUupzE4DvYPGt0GdelZsi0xrUH1EsVLmBe3ABMtEvfItrS6hU4jZd1y0jTnGO
 8FvDDSapLtVZcYg/Hj+IMXJfdt2FbjxY6PCjIinDdxdDUXKTVrwSfCVGQb1S7w==
Message-ID: <11128ed2-a53d-4286-84cc-dc5c6d932405@mailbox.org>
Date: Fri, 20 Mar 2026 04:58:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
 <20260318012557.GF502704@bill-the-cat>
 <34a0c151-f8ff-4b91-92b3-d6f63097440e@mailbox.org>
 <20260319134128.GP502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260319134128.GP502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cec1c0eb15926e33627
X-MBO-RS-META: ootn1sjonhrruu7t46hq7w9yim7gf5hz
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

On 3/19/26 2:41 PM, Tom Rini wrote:

[...]

>>> So I think the answer is if you fire up menuconfig, and turn off
>>> RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGULATOR and
>>> then enable RESET_RZG2L_USBPHY_CTRL things will become mad because
>>> RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but we don't
>>> have DM_REGULATOR.
>> How is it possible to enable RESET_RZG2L_USBPHY_CTRL without enabling its
>> dependencies ? This is what I do not understand.
> 
> The way I said in the part you quoted? If you don't like the way I'm
> solving the problem with the dependency graph here please propose an
> alternate. But it is possible to encounter this problem, or randconfig
> wouldn't expose it.
What I do not understand is, how is it possible to enable Kconfig symbol 
without enabling its dependencies. Is that a bug in Kconfig ?
