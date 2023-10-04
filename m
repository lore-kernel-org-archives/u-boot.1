Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA225E7B604
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 12:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C65187526;
	Wed,  4 Oct 2023 14:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qFvFx4LU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545F286EB3; Wed,  4 Oct 2023 14:28:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D12187526
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 14:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0v9v31WYz9spn;
 Wed,  4 Oct 2023 14:28:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696422515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aqlm4gtdxnqk1y+ecgRRnxy/+7cyT62/JXSjz28inw0=;
 b=qFvFx4LUnLH53cmoBoXEOFv1l2sTlgw53ia2gt7a2enCBQ1sqlkrEMy/MrNzjeeUjO/sA0
 BY+px0sOBUeG08SoxiCJEE/01rxeHwgeuoIZKJUMTc5kJhrsW6LkO4kIls4X0ymOzra7gU
 AXUP3vd1BDBVcZROUdznMo7lgBq5L6zRwZzxt+I4frrjy4MXuZadK1AIGZf4wK3kQPcePc
 b80yQW8LOmSeCCvfmHMUVXz1WjM3yXRQHTciGbH4Yu1huQQJUXrPYWw9HsLKjV6cFhpUnR
 LGTQ7U0cFc7WtA7I4nRMCMcrqxZUoeuwQFfLAxpkMARdlK/GNTE6meXAyqxsgA==
Message-ID: <20c58ee4-a453-4fa2-a850-52e62e06124d@mailbox.org>
Date: Wed, 4 Oct 2023 14:28:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 13/16] arm: rmobile: Add CPU detection for RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-14-paul.barker.ct@bp.renesas.com>
 <af43734f-e901-3261-1a26-094b5c84583f@mailbox.org>
 <b66f6888-2789-40f6-2ae5-8abe81e03474@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b66f6888-2789-40f6-2ae5-8abe81e03474@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bc7a50fb4c66e68f68f
X-MBO-RS-META: zmp7tpb43xtztpqrzqjcw1g8qei7f3pf
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

On 10/4/23 11:05, Paul Barker wrote:
> On 03/10/2023 14:28, Marek Vasut wrote:
>> On 9/20/23 14:42, Paul Barker wrote:
>>> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
>>> devicetree blob to the bootloader as an argument in the same was
>>
>> same way (typo)
>>
>>> previous R-Car gen3/gen4 SoCs.
>>
>> Gen3 / Gen4
>>
>>> This blob contains a compatible string
>>> which can be used to identify the particular SoC we are running on.
>>
>> Why not read the PRR ?
> 
> Reading the DEVID & PRR registers is not sufficient to tell the SoCs apart.
> 
>  From page 204 of the datasheet (R01UH0914EJ0130 Rev.1.30) regarding the
> DEVID register:
> 
> "Note: RZ/G2L and RZ/G2LC are the same value.
> If identification between G2L and G2LC is needed, read the value of
> address H’0_1186_1178.
> The value is below.
> H’0000_0000: RZ/G2L
> H’0000_0001: RZ/G2LC"
> 
> Address 0x11861178 is in the OTP region which can only be read from the
> secure world (i.e. TrustedFirmware). So we have to rely on
> TrustedFirmware to determine the SoC and pass this information to u-boot
> via an fdt blob.

This ^ really should go into the commit message :)
