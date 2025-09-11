Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF28FCAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 697408334F;
	Thu, 11 Sep 2025 14:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gEqJHLsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAD4833AD; Thu, 11 Sep 2025 14:36:38 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 910FB83327
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 14:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cMxrL3n7Vz9tHg;
 Thu, 11 Sep 2025 14:36:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757594194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5Ro5HeRgLEmqWFbeUgrkGF0v6gxps0PFqikmfrFcRw=;
 b=gEqJHLsjWICgy50RnbRyfFXEkCex1wuTHKQDMgHFmTxB5AA39sauRiDWb1cNakj1ECabNM
 uuUkt+Nf64TJWOh8vBaOc3WQcD+gWSJH3tS5QYvMP2PQAm7Gg/0sT/qohadQkOUeRNDs1Z
 N4wr0durRnq0yuzi6jDqOApFXdf4kguMIjnt4YBKxle4EifzB6oNi9u7E/vYNDhT/mou0G
 k431u73lzBZe+avK/oAnJe+49r49MXKLbQENcEH7S3RsNtGWev5R8eoprl8gbwxZ24/quJ
 /3HSjxT8Z4ccqLdA9rPUV8pqfC+elalZ1Fn+hPvgBsG/9cMCoXs397QBNrNMpQ==
Message-ID: <d6e47f7f-7f26-4c5f-bcdd-eed49e3fa706@mailbox.org>
Date: Thu, 11 Sep 2025 14:36:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mtd: spi: Add ISSI QSPI to lightweight SPI flash stack
To: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250828063638.30278-1-nareshkumar.ravulapalli@altera.com>
 <1e597315-bc7b-49dc-968f-4e5ef1d5f43b@mailbox.org>
 <1d7e28de-7580-404f-814c-9bb171230c00@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1d7e28de-7580-404f-814c-9bb171230c00@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: b79k6z5fh1t5gi3uw8gxw46zgomfkojx
X-MBO-RS-ID: 3d140c05465eca9d129
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

On 9/11/25 7:41 AM, Ravulapalli, Naresh Kumar wrote:

Hi,

>> On 8/28/25 8:36 AM, Naresh Kumar Ravulapalli wrote:
>>> Add support for reading data or images from ISSI QSPI flash.
>> Which part does this implement/fix/.. ? Details please.
> 
> We are just adding ISSI QSPI to be supported by SPI NOR tiny; just like 
> Macronix and Winbond ones are supported in this file.
> 
>>
>> Is there a matching kernel patch ?
> 
> No, I didn't find any matching one.
How does this work in Linux ?

Is a kernel patch necessary ?

Is a patch for the full U-Boot SPI NOR stack necessary?
