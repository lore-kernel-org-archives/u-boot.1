Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB6DC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 13:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D948796E;
	Mon, 29 Jan 2024 14:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C8dYDdHx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="cMN0E8e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C4D087C47; Mon, 29 Jan 2024 14:43:40 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 448F387842
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 14:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TNqJT6nHVz9sV2;
 Mon, 29 Jan 2024 14:43:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706535817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5l/oQ+DqmYoaCnqK0J6BVLfu85tFlZHW69O9BPN7y8=;
 b=C8dYDdHxejcgK/fa0fU1aE98Y1qdwEPS7+Ii9aAvCa70WHvh/1mc/X4xG8lQoZmnWwltDT
 Y3sGYK3jRT9UL8syWLSIIaJQOGaxqkfaHpJRHS1hpN4msyNgVlaUBd5snveUWIgc810kOX
 /sEUWvv1S+zwUIFojuAhizdfyorcz2GotNzJd5N98lm+VRzgpcsXXQSqZRaTbF6jiSBdcu
 +PrWWzvkpaTDd7rflVUKPaVCFJ02/2BCM9/PfY6XoD1Qsmh0XDFP2nGupegqB+EkCMzYDj
 zABm6zRpS1WF3AFk/O6fgPREZeTmXEVnD4TFX7Ptx3bsE9wOgTxSLRvBQDFxQA==
Message-ID: <5890ca1a-7be9-4ff9-a12a-e3f411298d97@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706535816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5l/oQ+DqmYoaCnqK0J6BVLfu85tFlZHW69O9BPN7y8=;
 b=cMN0E8e6kIaa+ubaomU0imKPCJxs95SwE1RlpXULMX/8uLuCDJSTwvhMAq1NdZmQAFr3/n
 UdJdthvyzfEt42oIPNSE/dYNFDq2SINikcxPbrBRa1NWqjuxdy57d7OkP8cS4C0Bes3jdh
 2A60Ya9wFIhmTvXyMQYw6jdmkkZmhNrvcNq4wRQuJBrG+mNP/7vaYhFtQ8HdeiyCkwMzj4
 kN++Zh2IqDT0eFqB3KCqmvLHsKF1ToG4DfP/dSKmnbLCsUksaVRiSTkKni40KXLuIm/KKz
 Dql2x7qTUCeO3odHGx4wKbBWWa+EIQMhG22bLJLaUvGWDkFhQ06aTmu7FGSjfQ==
Date: Mon, 29 Jan 2024 14:43:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/11] mtd: spi: renesas: Add R8A779H0 V4M support
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
 <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
 <CAMty3ZA7sEks59cdQhHCZR+R8fSxHdAtgHUupem=X61KDUALSA@mail.gmail.com>
 <aa6740c9-4568-4469-9790-635d68a08473@mailbox.org>
 <CAMty3ZBBcwt8Ur9v2pyojioJQVXc+m9+NG9z08DOTEMQqFzX5Q@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMty3ZBBcwt8Ur9v2pyojioJQVXc+m9+NG9z08DOTEMQqFzX5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3be31492125c58d6d33
X-MBO-RS-META: 4b9t3h797uxxs7bazyarcwnqipgoerxg
X-Rspamd-Queue-Id: 4TNqJT6nHVz9sV2
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

On 1/29/24 14:30, Jagan Teki wrote:
> On Mon, Jan 29, 2024 at 6:57 PM Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 1/29/24 12:52, Jagan Teki wrote:
>>> On Sun, Jan 28, 2024 at 9:25 PM Marek Vasut
>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>
>>>> From: Hai Pham <hai.pham.ud@renesas.com>
>>>>
>>>> Support RPC SPI on R8A779H0 V4M SoC.
>>>>
>>>> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>>>> ---
>>>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>>>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>> ---
>>>
>>> Applied to u-boot-spi/master
>>
>> I don't think this will build without 06/11 macro addition, so I'll pull
>> this via u-boot-sh tree if that's OK with you ?
>>
>> I could use a RB though .
> 
> Yeah. Got the runner failure. Please proceed to pick this vi -sh

Can you provide an RB ?

Thanks
