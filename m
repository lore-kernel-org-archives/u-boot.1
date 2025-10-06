Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C89CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 12:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4EB835D0;
	Mon,  6 Oct 2025 14:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NAoTR2wB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="to62U8II";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F3A98365E; Mon,  6 Oct 2025 14:06:22 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B7C4802C1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 14:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cgHzw26SWz9sss;
 Mon,  6 Oct 2025 14:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759752380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2jV+yCw0nlQF7KSet/hURKnFkU2OfZnuig64JJU+yM=;
 b=NAoTR2wBJY727rPOy9rgokeeGWoQCwLr6UCCrsvVLBiXjlz1VgreBpMErs6A5fpje8+xre
 tIDNpR65T7lFVt63FYI96y7lH9ooyYhyG0069cjwZ08Wa/quNKRUH0k/V5cAzIE4vzmmcU
 YqxLjYB2esuYE81i95CQyZRvWOcL3dATSKq0r9kkJPpK/uSGp+pUFbSRfUC8Ke96USj+0W
 KlE3+21T3tt6lcPO8Cp6aZlwxTX/mcn7fjGChEQSz9UcvCNAJfJ7JQVZvfDEtG1uMcXj+B
 Ey+wQME62Ne721ACWNWMZAWf1DirP402TCxmuNvNNBaPCdjYi6D6oFk0DClQ1Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=to62U8II;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <bbf07b05-f842-493f-acf0-5d1f08be26d1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759752378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2jV+yCw0nlQF7KSet/hURKnFkU2OfZnuig64JJU+yM=;
 b=to62U8II7MQaDEPGqyJAF71mop2cBSBw5dWmQLw2agrgLXINo+mPfzzxa556sWFI8Mtf4k
 gPzy8ug2xlKi65Ab9oHguyLAKZUJJhM7Y704vXOTAOVw5yXKp8MSOXwItXAdtd+bySmapM
 GgAVrUyAlGhOkdHsQYgsufK7zxbi+HGISByCHvJpIwNwrKhZpYT88Fc2NxC6Dh7gffPpsq
 O5jEoOXs4nwWtwINfbYuqWsKNqWhJ3D7+WHVCShPDU1ZpN1JK5ZQeWDxMtP3bMpkaBmlqh
 g0pP2pme7Jb1Dgk3WKXjDtXGCpYhrzWr+kqQtPR99bkWc9zyyt9xtfT/XQ0/XQ==
Date: Mon, 6 Oct 2025 14:06:14 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v1, 1/1] net: phy: add paged PHY register accessors
To: "Lucien.Jheng" <lucienzx159@gmail.com>, jerome.forissier@linaro.org,
 skylake.huang@mediatek.com, s-vadapalli@ti.com,
 paul.barker.ct@bp.renesas.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006044405.30376-1-lucienzx159@gmail.com>
 <4fa8531c-e6c2-4a3a-b284-86c5bdd94530@mailbox.org>
 <251a26cf-fef4-4d20-a278-881ca31ddb97@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <251a26cf-fef4-4d20-a278-881ca31ddb97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hhxtzqamhdpid7ofx7js61pdmdrmk1jg
X-MBO-RS-ID: de01faaec14e4e21ec8
X-Rspamd-Queue-Id: 4cgHzw26SWz9sss
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

On 10/6/25 1:59 PM, Lucien.Jheng wrote:

Hi,

> Marek Vasut 於 2025/10/6 下午 04:18 寫道:
>> On 10/6/25 6:44 AM, Lucien.Jheng wrote:
>>> Synchronize paged PHY helpers with Linux v4.16.
>>
>> Why such an old version , current LTS is 6.12 ?
>>
> I just meant to say that this patch was initially included in this 
> commit. I'll adjust the wording here.
> 
> For the next version, I will write the commit message: "Synchronize 
> paged PHY helpers with Linux v6.16."

If you are synchronizing the headers with 6.16 fully (btw. 6.17 is out) 
then sure. If you are pulling in single patch from older kernel version, 
then refer to that kernel version. (I am a bit tired today, I hope it 
makes sense)

>>> linux commit
>>> COMMIT 78ffc4acceff48522b92d8fbf8f4a0ffe78838b2
>>> TITLE: net-phy-add-paged-phy-register-accessors.patch
>>
>> Please use the standard abbreviated format with 12+ letters SHA and 
>> commit subject -- example: e37de002fac3 ("Prepare v2025.07")
>>
> OK, got it.
>> [...]


-- 
Best regards,
Marek Vasut
