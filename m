Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D90C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 21:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA97086994;
	Tue, 15 Aug 2023 23:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WBVSj7tC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jYtfYBEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 482F686994; Tue, 15 Aug 2023 23:01:46 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C19BB86852
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 23:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RQNx33pJkz9sWm;
 Tue, 15 Aug 2023 23:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqT1okwntPFwsg8y7v5ODsWJUSNinMM+VAhAFT9dCrA=;
 b=WBVSj7tC5yGisJ/U/oyDyboOJrZXtFlwxbGlYm1wDg1ZBp23Ws4dduPHaPRva9nKK32m8F
 ClJAZ7KH4zYhnxp9a79J3NMci2RssVC6pSXb2PL3Z0KTP8d4Its8C6PAXF8IW8yA0ZbAqU
 JJseVzluB/tzukJ/vdVhpAULyABe04zxEyGCRhlCd4VtKWMaflt/tm/nk8Ox5cqwad9WN4
 HyuRyyW6TAhwXrx2UwYAckmX26KButjm3cdfu8uzZsjrsnZQEfZ+121fnwzhDC4vQ+mLX5
 9RHt/4Sih+EKurp2XQRy6XfIeHX0skYy12DfLYtnrc38+qyPlGwtzfTnACmHvA==
Message-ID: <020474d5-bd1a-9231-af72-0e6cf1da66e6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692133301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqT1okwntPFwsg8y7v5ODsWJUSNinMM+VAhAFT9dCrA=;
 b=jYtfYBEaNaE80eyLPf0rx2z4tS6lTIudgmz1Ws8NoIJgPjIvQhsVPB+Mjwe/aVQPJ4fo8r
 EGIDIj1QWGWCM3uEPCnT5/CJmOYg31ddXmr8BrgZeoy/OhMI9SD6WwqZghwol56mSwK5Td
 d8zCTpwV9enQq9AwvMVNVuqkGef5wxuVFM7Z1JhtEsKcqOcxl9o1yWj4TF8LjfCJ6udQDl
 d6iTZ0KlllbcpFtR/wEd/wloj1U/w3/ZQB4bPs73haEulWTMjq4HOMkUT8MtpkBpwRqANa
 TOW+5uLFBXTscJLhluJihL/WuCFW0p4+gcCUk42iDaHNED9CJlIzmCXPc77mQQ==
Date: Tue, 15 Aug 2023 22:46:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 17/17] MAINTAINERS: Update UFS maintainer
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com,
 "vigneshr@ti.com" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-18-bhupesh.sharma@linaro.org>
 <d4b2b0f9-6231-6087-a06f-df7f059a80e5@mailbox.org>
 <CAH=2Ntw_4sJYy_ehbQ2ZL6GMd6bbFcAO9pJBWRrmqMjKNehSwg@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAH=2Ntw_4sJYy_ehbQ2ZL6GMd6bbFcAO9pJBWRrmqMjKNehSwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 906f3a64fa510dec927
X-MBO-RS-META: bnerzk5ue4bf1wmyududkx3wihcsb4qg
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

On 8/15/23 19:48, Bhupesh Sharma wrote:
> On Tue, 15 Aug 2023 at 04:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 8/14/23 23:54, Bhupesh Sharma wrote:
>>> Since Faiz Abbas's email ID is no longer valid,
>>> drop him from UFS Maintainer list.
>>>
>>> Since I am using the UFS framework now extensively
>>> on Qualcomm Snapdragon SoCs, so proposing myself as
>>> the new UFS maintainer.
>>>
>>> I have also been sending out u-boot UFS fixes in the
>>> recent past.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>
>> I believe TI is working on something here, so please coordinate with them.
> 
> Ok, well I haven't seen any reply to my earlier UFS fix related emails
> from TI, so I thought maybe no one is actively looking into this area.
> But I would love to hear from TI on the same..

This is why I CCed Vignesh and Nishanth , coordinate with them.

> Anyways since I will be working on the Qualcomm UFS glue layer going
> forward, I can propose to either be a UFS maintainer or a reviewer for
> now to make sure that the subsystem patches are reviewed and tested .


