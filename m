Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D23EF94CB7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C760883AC5;
	Wed, 22 Apr 2026 03:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YUjiVVaH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nG87wYWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE2B84198; Wed, 22 Apr 2026 03:46:31 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BDE783936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g0hsJ4VVFz9tHp;
 Wed, 22 Apr 2026 03:46:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776822388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eG0laiE8v0ujUj3G5RwutwXWo9QvT2usYKP0foALOQw=;
 b=YUjiVVaHC39grL0CyQelnPlsvIp6lmBBdLYckxv9kNTddKaDroCl51A3AXoq4iiAAKmpZd
 I+OTGlo0UUrHTAHmwtyk7YmfMGr9CNA3FqCsvIW4eUwosTOAbVFH3I8V1AeqVUz7aVxymW
 aj8srsG8KZMmnzJmsBOhAC8qGXlqUajB9sNLYaQRHZopMJXkV/wVOLeMjfu0OT6j/me2+J
 sKip/8z43fAergnfM4LJYqAclA2Tj1NDtl9qb8wLNTh3BbgpumdK5Pjw950rsUQ7t3tZDj
 5hAtqAlFIHw+mtHn0PBxSNnWmJbm+UWX/s2kuZOl1W5sk3aCGY/VKZaUZ/YQ4Q==
Message-ID: <1f18aeee-ca36-4ec3-af50-d3ebe49c2a4f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776822387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eG0laiE8v0ujUj3G5RwutwXWo9QvT2usYKP0foALOQw=;
 b=nG87wYWgO5EQo76b8Tf4BbbCCtSE1AXec1XZ+nRGxlYS2ut0rMgATlP7NRlxhxHxFcgxXE
 RvXcxQooCAjWTofup80eF7My0PPkCdNi0yU6vB0DXXAjSskeZLVxT3E1hhEzMbwZWULU3t
 miBBEt7dxHvVIVdbEsyGss46pYGVUec2LinyPeaRPn8VHsH1XwMnsQ/UxshWPnzmmpY8ye
 PQkb+Jqr97rSLCWOTFZvdmeH93431GVpfmiwpvD9FNw1veAvy27ymY/U4WRJ6fv8HiOaJp
 oY7/A18G/Fe0xfTTy0RJrWUKIu/8PiE30kaxlUUTOET0AeYaxPqwbqm0EMvLaw==
Date: Wed, 22 Apr 2026 03:44:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
To: Simon Glass <sjg@chromium.org>
Cc: marek.vasut+renesas@mailbox.org, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260420012348.400492-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg+nfKGCaHGz6-GHoQ+KntLYYdUTZqfYGpBdsvLSW9FZQ@mail.gmail.com>
 <0c112980-e5db-4acc-97df-c1097c41112b@mailbox.org>
 <CAFLszTgV6L=G2-MpBgYh3h=4QM0r0V-aLueS3zUgTCTx3YmcpA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTgV6L=G2-MpBgYh3h=4QM0r0V-aLueS3zUgTCTx3YmcpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fos49pixju5zinwyhiptogtjoj53hef3
X-MBO-RS-ID: 5d93993e7f2c9ed1880
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

On 4/22/26 3:15 AM, Simon Glass wrote:
> Hi Marek,
> 
> On Tue, 21 Apr 2026 at 12:48, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 4/20/26 6:14 AM, Simon Glass wrote:
>>> On 2026-04-20T01:23:26, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
>>>> kbuild: Respect CONFIG_SYS_DTC_PAD_BYTES after fdtgrep
>>>>
>>>> The fdtgrep command will reduce the DT to minimum size, thus eliminating
>>>> the extra padding configured via CONFIG_SYS_DTC_PAD_BYTES. Reinstate the
>>>> extra padding by running the output DTB from fdtgrep through DTC with the
>>>> -p CONFIG_SYS_DTC_PAD_BYTES flag again in case CONFIG_SYS_DTC_PAD_BYTES
>>>> is not zero.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>
>>>> scripts/Makefile.lib | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>
>> Is this something which can be added into fdtgrep itself btw ?
> 
> Yes I'm sure that would be possible: perhaps a flag to maintain the
> same padding as it finds in the input file.
We can not determine the padding from the input DTB file itself, so the 
option would have to take a padding parameter. But I wonder if it makes 
sense to grow fdtgrep this way, or whether using dtc to reinstate the 
padding is better.
