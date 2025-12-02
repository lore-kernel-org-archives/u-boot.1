Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C3ED12669
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097DE83EE8;
	Tue,  2 Dec 2025 19:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="w3rfcbTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F67F83EEF; Tue,  2 Dec 2025 19:35:34 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EAC83EE4
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 19:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dLTwf23Bdz9v4c;
 Tue,  2 Dec 2025 19:35:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764700530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6RSeglK9ta4h6wqf9GY2zzT7RacTb1h3tYheLYKXOw=;
 b=w3rfcbTpQbjIS8t7yTgY+Y3A2ASNCrkUbtb9+eHPaCG1Z0bKtoTUBIe3GJ0NtAOUXlRed1
 GHiOTTBue9d9rOsFVbiCXLSzXf+PcfWBr49f0ip9UoGt5TAESzNgotLXCTC6k0Ju/SJs2A
 rMCEpVkEiBfr4qDFx5jmWbWU4LJJFml9RFtLOA53dGCnVDhRx4NjIJAIXKqtlv8shHrrWC
 WgQY7XmzXTkJ3V1PbvtRcNC7UM+LX8iLKC+t06dXZd27aMNjz+NJJLB0tqAzgoAuQuyM5O
 c860FgmxZ34FTwQ1ErAh7w8Q1nJHGh/jUZozo/GB6BDuENRIf4dKmOUZ5mco3g==
Message-ID: <3a4a333a-2b12-4f7b-8f94-41672ca1eab4@mailbox.org>
Date: Tue, 2 Dec 2025 19:35:27 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat> <20251121195512.GE2125796@bill-the-cat>
 <6daeb492-0c5f-433d-b4f5-56ad5ca1704d@mailbox.org>
 <20251202180610.GE303283@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251202180610.GE303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 690b1e4cd8240dcf03c
X-MBO-RS-META: pfjodbes1ai7pzt3m48i6bour6mzmzdu
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

On 12/2/25 7:06 PM, Tom Rini wrote:

Hello Tom,

>> But the question now is, how should we handle this ? These unaligned access
>> functions are there for a reason.
> 
> The historical and short version of why they are there is that a
> platform was passing the kernel a misaligned device tree and the
> assumption was that it was intentional and not a bug, and so dtc put a
> bunch of effort in to working around that. After discussion (in 2019 or
> so) the conclusion from dtc was that they still wanted to keep these
> changes, despite it being a bug that a misaligned tree was passed. I did
> not further press the issue further. So doing a revert, again, is what
> we need to do.

All right, let me wrap this into V2 and send V2 once CI passes.

-- 
Best regards,
Marek Vasut
