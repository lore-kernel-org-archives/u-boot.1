Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F93ACE7AAB
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 10:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04F383EF9;
	Fri, 14 Nov 2025 11:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VFdeuMfk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bq1Xfvcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A105883F39; Fri, 14 Nov 2025 11:36:43 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8165A83EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 11:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d7D8T0zJgz9sl9;
 Fri, 14 Nov 2025 11:36:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763116601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LdujataYPf4Lm5yCwR4nYD2S/xkRW0WszjHlQpWNY4=;
 b=VFdeuMfkYnCeiy4ZmbmKXMrAGD9KrEjwyIhQzL8Ug0Zlh3YEqbUloskSW7Z4JFRqdCsth7
 Ys5bb4vC2a5oc5pzr4t3yPcvXeWRcYTxQPzMtHJjBvK4bt80ahs5q9eAz4M/ha4AZPMbfb
 oWVFdPs95jeIhF54gl3ebIINGHdlImBjFEzBLHRZwIwFcMCWc2n00wsiy0rsRBw4ND44Lo
 PF3q6ApmcQNtCQ/HNxuy/6oy1oepoNYQnGhdR+LS39YlakjB2Gth7LG0WZSErzxzzJk0Jd
 SrNXksVC7Z5fNaxefCVFQpEkRNh/zr97bfm2YZVgP3ZAJdiAoFHo+MzRUs+34A==
Message-ID: <8d5f1351-5ab7-4650-a84c-d8991acc3cf4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763116599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9LdujataYPf4Lm5yCwR4nYD2S/xkRW0WszjHlQpWNY4=;
 b=bq1XfvcmN5+0ImbKwOoErtQkOn5ijULc8za0AO7gKwFHUoxRwzovJXoTuXCH2kSE8LQ1zW
 27E8+wi9Bj7zln/ZJBirrg5JtlQ/Of7Hia7RvSC1f2yip6hJ8MgHL0foSoJNRNs0bMI2zl
 iFBVLccjhOEj7xAkb19KTwQm3TrLmAbtiLEXY1ewy8OvJWavKhXjn7Je0gjJsBXuAfvvfT
 /vK/RvVYrSjDoeBE9Xe08iUI5JfbuzuUoIi4hs54dspLZc7ITRnxwNZ/L/iAYlK61mNyoP
 oDd3wy2HL1XxMhFaeJ25Ty9/yzTyvhjS8K8jA2+MmYRRPpEC5fVl5eRJmfKrYg==
Date: Fri, 14 Nov 2025 11:36:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] board: tbs2910: Disable EFI partition, MP, sysboot, bind
 commands
To: =?UTF-8?Q?S=C3=B6ren_Moch?= <smoch@web.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Tom Rini <trini@konsulko.com>
References: <20251113151858.1072774-1-marek.vasut+renesas@mailbox.org>
 <4298f3c8-5aa6-49d7-a8c8-693590dbdc32@web.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4298f3c8-5aa6-49d7-a8c8-693590dbdc32@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f3a3e4db29c5d6801b4
X-MBO-RS-META: 6171wqnngoujdqqbdcypbz1cbk5zo9kn
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

On 11/14/25 10:53 AM, Sören Moch wrote:
> On 13.11.25 16:18, Marek Vasut wrote:
>> This board is just short of overflowing the size limit, disable
>> support for EFI partition since EFI support is already disabled,
>> and disable a couple of commands which are also likely unused to
>> keep the board below limit.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Thanks for finding additional useful options to reduce code size!
More like use-less options, but can you please at least try whether the 
machine still boots and check whether those options are really not used 
on this system ?

Thank you !
