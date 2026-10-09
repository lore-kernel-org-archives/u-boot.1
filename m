Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24698CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFB6760872;
	Fri,  9 Oct 2026 07:13:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VnpOyyMjr2eA; Fri,  9 Oct 2026 07:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37B0F6082C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529990;
	b=CW5lhtcmVSdQ4p0X8pYsxhFEVhCQnK0R0R7zKqWdrIir/Ba8Jw6JAhsslf494rnorvUu
	 wAhzePyOrcf5727phJQNSIS1hx6fKZVAyyH9qmZPFnmMfNXsDX+9aYvzd4QO4GMOCG6Kl
	 2okyNa/M5R2E8hPcKdtseZ1WFYV2Gs5Vyw34heck94JKLrPvbTxfgQaibKwtu9alsTzbM
	 yh6hmQfxsJlYmWew6TJleAvKkp+k2jakDZYeT5iM57niDH0L5KTeA6trAKwRQxDesqVNO
	 6kRiV806SwX/Q6JyXt3JUvEWPKPDfhlsZLDjmKpvDEmc/W9uNddRiAhE+z7xMJob/zA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m1EVPdVQoq8S6VwUP6BYOBQDL1JgRhZN3gRpz5xibRU=;
	b=YO84d0nCs9jp2/e4YSM+HqKPV6LiPCZLeTDu3cGfTynIgmPLWNpu/W2L0MARqPMI+L6k
	 PHezhkng5lBelQ0imHQrdOsfgaPOM9U4hKfBH6/PrS0VoCN1ePl/Cdvo2spO1ccTXZH/t
	 Dj2IktYo/nfZd0rzq7kHm3amIAnVEGYzDaA8SgTPynEy+FQvR76WtFt48A2tmrW6n2nP8
	 mGnoSSs12tUMBRZPmbM4qw40vhRnEb9ftWJMilubZy9QCrh/rcM76nxSWfk8qltFcNCto
	 RBdd3Qdf1gRK5y905T+E4p2Pd6I8NLdCQptGGxsYDd6WFp5j0jva58EkslgTyo6Dt6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=fukaae4Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529990;
	bh=m1EVPdVQoq8S6VwUP6BYOBQDL1JgRhZN3gRpz5xibRU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XpwMfiVxXk0bZA+W5KpBCyzfyzAz98onR7uThelLbC89y9ccm5tjCH2g3WYwa4RX7
	 xbzZ2Nb4lbnQU5S9x+GsSIQSv1ncPri1nRYwI+5u1amCliuTI9HHh65MFD22LlkyLe
	 /2z6ya1hM9gq57i+yzyXnAXYVFXXmSu8GUQyCUydbZMZlXILg+y1/Sp1Fc3paNDruV
	 TgZkmwHdZPFH3IE7RUNUdD9LCkmUNFyz4jmOGFc7QsR3NYUbxIWPJwNfoV43SPVG18
	 gJ/A8TymGiipGiBcS/Y+BrhUgG2RlYIV6YNi588yTUhvVzQ/+L/7ah5L1/9R+zZiVy
	 ODoCpjpmGQmmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B0F6082C;
	Fri,  9 Oct 2026 07:13:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B2961A6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7CAE06082C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z_TVj1eAZQ_0 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DCEA606F3
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791529988;
 b=GwZMMlzkNoK40CFC4PV2YJdp0Hz6ETp50ElEMvsqRMFrwczMzNPb2krHFGgEdQjKZgoC
 ErLWhivgYSrg7/ByYfjneRtyLO0XsK1UQ4zWF9TC7TypAXwtI98FQCbzI2oCOCErEoEHk
 QgrRHVB/JFy856k+0sdF8z/Q+Ml1wcCjT9iTrSdGG4teVa3NygoRtI5DWPTkecvTM0zUa
 /umzrutKoPabOQs42jSTiWMzTHK618S0CGWVy0Zx1VwK8lNe3r8dXIQydPpfVseCAuu1g
 wuhSfYo1DM0DvTjNv7LAY/0G7OTnrVrG9De1WaSa4eHivGeDVpgxQ53rM25V2Sb2vrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529988;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=m1EVPdVQoq8S6VwUP6BYOBQDL1JgRhZN3gRpz5xibRU=;
 b=isLmIpnG+95B0U2TjtBPjECsJStHzF0Xo1BgubBtzMQHPmfLkVsbvl0rQpXr7A2zEHCb
 /ih+p3ZLkgwA8My1Zc9YODOfqnG9fX2RQapn4IY9kRMSksCf4QiqzWsoAPPmVaPyquCw+
 KS+m2sM7C5ZvHRUBoYMMsAT97ls+INrzsmFxdkyR+ZLKStLmNtnTOkLMOK0zSj3widqCp
 7VOqb+TgzxZf+OnA6sjY+0k/ksYsSd9qzVsfT2lgnUblN8Y6IfumRlD8+ZWj3E9n3hU5Z
 3lg1Vf8bUNik1axom1Ml44eiZjWif5JUrCpdVLSHxgTcqShyiS4+42PTJlC1Ueyjgjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=fukaae4Z; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=fukaae4Z
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DCEA606F3
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:13:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A31A5105AAE; Fri, 09 Oct 2026 09:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791529978;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=m1EVPdVQoq8S6VwUP6BYOBQDL1JgRhZN3gRpz5xibRU=;
 b=fukaae4ZUL7Jmuxf6H+zQrvuIX+OxWQi6ShKJGaCyiCwTnEFMwHDP6vt9QmjrgrrsibfX/
 DF/p8eGfxbqXGjuEMT5YWSivDlMzilQe2uCq/lYNueKUsrV8LypjusUp4hYfZrouMJ+lbU
 z2q3aSaeaDDYtqf15d7KXDFeKyTMkXkOm3Tglaiy9qiSCKfpjJmf6ae6NNufW2/5GGu4Wo
 2vc4T29kg94TIbF1nNq04GLVBex1QXm1duBrRoiCcveC6uewFzOrxARSn0xZ8hRJ6HFkTm
 Izz/Z4raJD6z0Tsht4yg7Z332lvWpcQJ9aI5WyZkUW7gyDIu1gk+w707dL6Cpw==
Message-ID: <4724f20a-93e0-8757-f6bd-ab1290fdb2ea@nabladev.com>
Date: Fri, 9 Oct 2026 09:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/5] mtd: Microchip 23LCV1024 SPI SRAM
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, Anshul Dalal
 <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>,
 Cole Munz <Munzzyy1@proton.me>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
References: <20261004040657.3156402-1-hs@nabladev.com>
 <CAFLszTj+VejVp7CmsBedH6TmT9PC59H1b1CnxWyfN6is4yz=_w@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAFLszTj+VejVp7CmsBedH6TmT9PC59H1b1CnxWyfN6is4yz=_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Simon,

On 09.10.26 09:10, Simon Glass wrote:
> Hi Heiko,
> 
> On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> 
>> The driver sits in UCLASS_MTD, the way the SPI NAND driver does, so
>> the device is reached through the mtd command.
> 
> Thanks for reworking this. Moving to UCLASS_MTD and dropping the erase
> makes the series much cleaner.

Thanks!

I will take a look on all your comments soon. Many thanks for your time!

bye,
Heiko
> 
> Regards,
> Simon
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
