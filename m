Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F01C47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C66B3877EC;
	Mon, 22 Jan 2024 01:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l9hsA8wB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C4XAj0HX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28AB08773F; Mon, 22 Jan 2024 01:34:22 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 099F28783F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TJB6z3Vbzz9t7Y;
 Mon, 22 Jan 2024 01:34:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbYUukwRkrDXw/5xPN6MCqT6vaya3GvTAa9P6sgVP78=;
 b=l9hsA8wBx2yhJ29jDOm5zgPyoTeGZ1iAERSebK0h13ZGEBdMAxf84PvmokNWgf/TV/Wgxr
 WvoijCVuPjKwXC7jPqns19OG59XsUQGv+c9lEJSQEFyxiv+OaQs4focXPxeHAv9xTAyHgp
 dKi7z2bD9tk5klPT6BUydg2BtMOhfon7PyqKW8rAjKPV2Qdk8QLuruCbjfGZECQVFQobD0
 mN0UShQbJ/FUR/BWH8u2cyYBxpHhUJN1D8DURwP1j28S+4IYDtHq7bqAJRwnck31/M3bvM
 kEr5uQV7X+E9o3+jaxPXCTQP6oUWVtuJpsFbw2ArS4Jg0HBF1BHOXCJiFCChJg==
Message-ID: <b1dbb66e-d95b-4706-8da4-f1874fa67eba@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705883657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbYUukwRkrDXw/5xPN6MCqT6vaya3GvTAa9P6sgVP78=;
 b=C4XAj0HXrTDn+jhszyZp8xKxKsHfgprKdR2+bqodOi/12kkU6hl6+uAvGiN7JxHEaz2yGT
 vbSXh2w5D9AAK1ixrCPRMvb7/EyXQgscRugg5gIR/pv00GfjMVGOd4bTnzCdxGNK2JIaMR
 4y4utOz7FRo0UxOhXFEUHU/CHZQC41fGSAq5XtYKS9hU86AbmhsTTGEVeSJwmQ95u55vHx
 bnkPJh9nhHpzTpmFQY3hce3AQbgpCS6c3yvZmWWHzrkZQaXrC7lhDAM5p3vsvsWmNHnqhn
 YC29IQ4TMlUHBVoo+x/p1RPEd8hlfiFDLrXI3+Swk0p2UvVY8kdl31QhwEUt6Q==
Date: Mon, 22 Jan 2024 01:34:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 10/11] ARM: dts: renesas: Add Renesas Gray Hawk boards
 support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
 <20240121174340.279465-10-marek.vasut+renesas@mailbox.org>
 <4d295794-48a5-4457-a21c-540c694a0da4@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4d295794-48a5-4457-a21c-540c694a0da4@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4c390ba7cd3af1cb504
X-MBO-RS-META: 1fyx6cwqjsonwtsmh1byp36yn8iw3imw
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

On 1/21/24 21:46, Paul Barker wrote:
> On 21/01/2024 17:41, Marek Vasut wrote:
>> From: Hai Pham <hai.pham.ud@renesas.com>
>>
>> Initial support for the Renesas Gray Hawk CPU and BreakOut boards.
>>
>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>> ---
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>   arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi      | 165 ++++++++++++++++++
>>   arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi  |  15 ++
>>   arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi |  15 ++
>>   arch/arm/dts/r8a779h0-gray-hawk.dts           |  25 +++
>>   4 files changed, 220 insertions(+)
>>   create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-cpu.dtsi
>>   create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-csi-dsi.dtsi
>>   create mode 100644 arch/arm/dts/r8a779h0-gray-hawk-ethernet.dtsi
>>   create mode 100644 arch/arm/dts/r8a779h0-gray-hawk.dts
> 
> Is this a sync from the Linux kernel? If so we should say which commit
> the dts/dtsi files are taken from.

It is not, not yet anyway. Once the DTs land in next, I will sync them in.
