Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0031CC88E53
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 18:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F53460628;
	Fri, 11 Sep 2026 18:59:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbIUesxIxxvA; Fri, 11 Sep 2026 18:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 76D9460618
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789153159;
	b=dl8toHyukDuuXLJY2eJLWvW7RPu2HaxjrVuzCePtCxiabme6BhP5ewtGNO54up3iEDdU
	 WkZpnsLXw719VlVQj7hkadVyMWJRhg7b/USTZgxUZaLbYdB+KLc+Q5/3PdtNUOYh5StMV
	 Gm0V85PXjrBGHUvePOCDSYkVwjIu0NguvppnjJT9DQsPVTHc0qdV81ISaa7yffxmhqOEn
	 JQcJ2xDN53SOU2EDSnp0TXqoIRON+kLnCAnmwzr/hOrhuYTFeWFo47onVSzpVBaqNVc57
	 QTHPlg8p5v5ybjWEMcaUYeBxrG5CXznokII89kkrM20L+dR0NQwzLGqhDY2iUAhvyHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789153159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fMEeMijPoY3OJ2sYSrmGHLblyUnioJsgs8/MOu2ebyQ=;
	b=lhkxao6T61wak91XuH8k7pKQocPjdo6Ls0nm/0LQbDi77bypnAph8G1hYso+ylyaocOV
	 ScpKdClK4LDFkjFw4qaICW0tV7q4DtJaqrXKNG238KQ3IhiC9bJ57rNtFOFRaURB7kYZ8
	 faX4tXHrvr1LOdkKKadbNBZ5jgHJdnD0DAFkOuZpsijdcnC7gToGkyLxMsEzZqcnUwK3k
	 Mb09YamP0BxLrc/yFd6vgj3SllOA4S+ZBDv4Ym429F+/Rb+EdTKzp7cJW/MPUdCybr/LY
	 c/87CRhIIlnWwtMewhRr6+TU3PdELpM4JVqn2AmQyEATboJgmnUOKF6idqlDPsoIsJQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=v6aLMrx5;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=xPpz3a0n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789153159;
	bh=fMEeMijPoY3OJ2sYSrmGHLblyUnioJsgs8/MOu2ebyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UVqOlF/Qn/4W0beLBC1Ih8TlDcKG17js940odBxkZqI7N5gqKKrPrluqGraD1IiXp
	 9B2Ikm+8nSiqPqnSd/8WVscvj1PnhRXH+hsRQ2AAJgXgvSCPjngS50rKI3pNVcOMCm
	 /hsSAlT4UI1b7KWOuBm9/PLFKnjcxRZSe1Dxn9EpqwmQrs6GwFDh74t88F6EIDvZRk
	 wvfT1Cbky5IsUVwOJgzFXXAUDic7qkd0zcWzefQNCWmXAWAbM0FIK/9cXKeGlWeKvd
	 8WDB5Hk8Iz371SH26VPd97zPzAsc7OecHMcYGsUjdw3xjkif/6aXlCz7+ENL+pnOPW
	 amCues0Yx2cbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76D9460618;
	Fri, 11 Sep 2026 18:59:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 241B03AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0972460618
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihse_UfY3WvA for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 18:59:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1961660617
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789153157;
 b=e/Hu4Cr1D4DOPG5xVIx2vueGhagn9fYcX1Jh0+4QVF20NSBi5ZxsBZBfS4Rfdh3TIFi3
 0eNoFM+g/WVl7aTs+uOFqNUpuScaPxUaAGaf8wSAcEkujwtFbXjjhsm+gwZoKU1PIaHeB
 b/WPvUHgiPf6o2QWFydpeiilQYw3C3bj/IU+8OFS7sWf+71PZJegqBr+G6sJ9mqkBxVnP
 yuZ9hZwxtWxDflTbeAZCOzLgns0CloCqHFa7zj+2+DJisJU7SMaUR7qkg0266lo9lt5gZ
 f71IGEKPt5O8BmLZ7GyYBZqiEqDqAmr7PsiVK4c9SWsxO9aXtux5VUZ9d5naYYA4y/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789153157;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID:X-Rspamd-Queue-Id;
 bh=fMEeMijPoY3OJ2sYSrmGHLblyUnioJsgs8/MOu2ebyQ=;
 b=MAi9VEm1+wScPXxqAIHiRmXSwMp36tgol/n4xHkweDygLUHIciMBqjKLyVwZtCCy+RBh
 j0WrIh6GRcQ08ME9SEsvnAHPvO0/9UVyXHFrm4qYT2BRniJwNo8ojJ4ZlDTHTkyMEC8FB
 UM8xf1RFAsDNAcwEv8RdfFCKLpwcQHDBHgRK/A6DiBsY4yJjL/KVfpDjXWD185GYz+lh8
 KTkL1lG9g19z70trvGjEQ5Ii51vG/WYn16fVhs8SL8xUxQjXQOhvVHjssH1AscW9pHqx1
 2d6cPH3LNA8VuWWj35ZcdtQVybFqw/eFIIQZuj7ijUBpUrl1I7BeIJKJG2bMUwuzcvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=v6aLMrx5; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=xPpz3a0n; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=v6aLMrx5; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=xPpz3a0n
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1961660617
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 18:59:16 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hhP3Q3HNZzKn8g;
 Fri, 11 Sep 2026 20:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789153154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMEeMijPoY3OJ2sYSrmGHLblyUnioJsgs8/MOu2ebyQ=;
 b=v6aLMrx5f2WwiMCmUqdVBhjXQ8hVN6lWKFPWSLCSFjHDhdmh5wiLLs9zr6tBKXMLLZx2k0
 qoueL6F3R8psUt4gn2+5jaqe3vYaUTQ4cBcLgv/s/c2nSJw/wqDDks7szhfU+ZFowcAogF
 0DorBP7Zy+MP0Cjef0RC9pky2+ZkHyNnp5dcRBF61b+Qu6XVQHZgJ4o1DyK42NQG9yf6Ra
 alWWnDjZe3fQk9dK8EFy0ptPIu71ZkF9bQihr1m10eq4OqCEw08TLxVAw55e+IFc2WN4o9
 nyKiQ+Odyx6iyIBOufNeGTPKdkqNx6yS729UMy5E6e6vD8c4i56jch9AEbPxdw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xPpz3a0n;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a4899438-5010-4314-97c9-82ee72fb9e74@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1789153153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMEeMijPoY3OJ2sYSrmGHLblyUnioJsgs8/MOu2ebyQ=;
 b=xPpz3a0nZxRlcwevtaWmHxJnK/MkEHGemvRDfYhYYd9kRvbMlnPVfCkPeOkxHZGfRCBZ0Q
 6snnALx2dvQMhGnQp7zdyO0veFxHlk51RQLZ3PfzLK+vGMi2OKdvuXmnZRrZVW2H9/3BKs
 sIfaUxyrxdCTBpH3AIWFA1PR5eL1NPrLY65M5LGcm+4ZijEeLI9nW0yitKhsGsdzFjvsED
 hzD+tbicDeDZ87Cx1b5i2dad/CcSHhy6BMe3TSMuIbzD5yVViE5fI4ka5eLyB+JKDvi8lv
 IGRnERANp+bhWPICvrWi7CqUo0TdDAvtlDIoQS9HOl+wD9VikSDG8BfQ2znH6g==
Date: Fri, 11 Sep 2026 20:59:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] common: Add command line parsing utilities
To: Tom Rini <trini@konsulko.com>
Cc: phodina <petr.hodina@protonmail.com>, u-boot@lists.u-boot-project.org,
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Alexey Charkov <alchark@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Anshul Dalal
 <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Heidelberg <david@ixit.cz>, Petr Pavlata <petr@acrux.cz>
References: <20260911-b4-android-bootargs-carryover-v1-0-6ebb43da3df0@protonmail.com>
 <20260911-b4-android-bootargs-carryover-v1-1-6ebb43da3df0@protonmail.com>
 <17753947-74ac-4b42-8d94-436e7984e062@mailbox.org>
 <U6YrT3S_BQGuySCLDPjwnTxE9bvcH4uMX9vLfz5D0b32Kumb7X-TVcYowyUHmESFKNVU8jSLlDPqYQI9Y6owcWFWAicWEhCrB7lL4J1z6JE=@protonmail.com>
 <49a1bcfe-1aec-465d-b138-52b6803ce9c0@mailbox.org>
 <20260911185345.GT1764417@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260911185345.GT1764417@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: q84155dwyo5n3rinq4oyg5jpp9i7egou
X-MBO-RS-ID: 118c7798774544d75f3
X-Rspamd-Queue-Id: 4hhP3Q3HNZzKn8g
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

On 9/11/26 8:53 PM, Tom Rini wrote:
> On Fri, Sep 11, 2026 at 08:46:30PM +0200, Marek Vasut wrote:
>> On 9/11/26 8:39 PM, phodina wrote:
>>> On Friday, September 11th, 2026 at 8:30 PM, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>>
>>>> On 9/11/26 8:18 PM, Petr Hodina via B4 Relay wrote:
>>>>> From: Petr Hodina <petr.hodina@protonmail.com>
>>>>>
>>>>> Add a new utility library for parsing command line parameters in
>>>>> key=value format.
>>>> Is this reinventing environment or UPL ?
>>>>
>>>
>>> The target is a chainloaded environment. In this case u-boot running on Android devices where you unfortunately don't have the possibility to use UPL.
>>>
>>> As stated above it's purpose is to simplify the operations on the command line arguments from the previous stage and pass them to the next.
>>>
>>> Typical example is to remove the skip initramfs or extract the value for the panel to pick the right dtb (not part of this patch series)
>>
>> Is this something you could do in an U-Boot script using setexpr sub/gsub
>> instead ?
> 
> Yes, I would like to see how this gets used in implementation too, as
> I'm wondering if we shouldn't just be also saving off something like
> "prev_bl_bootargs" and leaving the rest to the board code to deal with.
> Maybe we should also add the android-specific helpers in a new file
> under an Android-related Kconfig as well.
If this is key=value pairs that get passed in in some chunk of memory, 
can 'env import' help here ?
