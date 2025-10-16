Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4CACCD185
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 00:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0297F833F6;
	Thu, 16 Oct 2025 02:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="ME8TxjXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C8B8357F; Thu, 16 Oct 2025 02:00:41 +0200 (CEST)
Received: from mout.mail.com (mout.mail.com [74.208.4.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E512829E7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 02:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1760572835; x=1761177635; i=sinan@writeme.com;
 bh=RXbXYIxt12g2WHs8cbI1BccLMfeEP1NFJs7sA+rjJuM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ME8TxjXJBxV5oDjhtA+JbvjrvAD6xhXpxae4q3TFbf94iXvbc6wl6xa9ke7nii1m
 +sblRP8soLfNQ9uNDk1UyKjUdFdMP6V1sQzjTekG6D10BTy8AH4M3ySM6+z/11NUf
 lUiPbDqikesW4SNQ2FyPpz5UbAOBFHYL/o84LAoH0/5sn6/1DvV03ob9ywVn//9gj
 Ixv/4/Hp33V1Pt9r/6ikvhI3p1qyPB787ky1NaHtUPCsKPMn5z0RMA0gsPc+1wOd+
 2n1l9xWInhWIK5XbEycmBwYbFuN3B+PgC8QFBt79ZVYhabO21FYFG80dLZ8YIP2Pw
 2XChep7WI5bDO2cXAw==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus003
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0MDRU3-1uzVi21BTJ-00HMc3;
 Thu, 16 Oct 2025 02:00:35 +0200
Message-ID: <5b6c23df-1b90-4ff7-80b9-e68f6e08f242@writeme.com>
Date: Wed, 15 Oct 2025 20:00:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Uboot upgrade from 2016 to 2020
To: Tom Rini <trini@konsulko.com>,
 "Manea, Alexandru (Alexandru)" <amanea@avaya.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
 <20251015221933.GW6113@bill-the-cat>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <20251015221933.GW6113@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bObAOxwNe/ZauHa5FeP4WY6R4u8MfYVayVlHOSuwcSGDTcCFPH+
 JJfQ8BVhInjPGMypZ2NLyxmj98Nchs94AsPEaQXscrxz7729JzX0qK6/Z8VZhSXVt/NNnYj
 7nVSqmRBak6WINsJopk7GRfdYgJdu2JVRNEy6LtalrYztEraeqo9NmXWHNBtUit4Zr1sIxx
 /mTQ1nrU2beDfJJgOHFEQ==
UI-OutboundReport: notjunk:1;M01:P0:d3ggSJ8z8e4=;wbc+DJStBzMUjHf0en4iGNY44VP
 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
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

Hi Alexandru

On 2025-10-15 18:19, Tom Rini wrote:
> On Tue, Oct 14, 2025 at 10:21:37AM +0000, Manea, Alexandru (Alexandru) w=
rote:
>=20
>> Hi,
>>
>> I have an issue with upgrading our sources to use the 2020.04 uboot rat=
her than the one working now on our system which is 2016.
>> After adding all our board changes, I can see the SPL loading and setti=
ng DDR and TLB entries but once it tries to jump to uboot from mmc_boot() =
it hangs and I can't get to see anything...has anyone encountered this? Is=
 there something I can do to make sure uboot is actually being jumped to o=
r why the hang? I've set the offsets to go to the _start_e500: instruction=
s like the old uboot. I can share the traces I have if needed. Looking for=
ward to an answer.
>=20
> There might have been some issue with certain PowerPC platforms
> introduced after the v2016.xx releases and fixed later than v2020.04,
> and git log might help. Of course, it would be better still if you could
> move to current mainline and then help with PowerPC maintenance, as we
> do need more people helping there. Thanks.
>=20


Which board is this for ?

=2D- sinan
