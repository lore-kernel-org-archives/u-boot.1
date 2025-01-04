Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA9CE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 23:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9881C800B3;
	Sun,  5 Jan 2025 00:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rJuFqTNT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SepLBzQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02237803DC; Sun,  5 Jan 2025 00:34:19 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24E6800B2
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 00:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YQcGc0f8Yz9sZg;
 Sun,  5 Jan 2025 00:34:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736033656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePzaJKGu/TkXdqGcq1S08sYM4TMZ7RvNqIaCoBJeiWQ=;
 b=rJuFqTNTUQcQhwEV3Ixg3cgSkWQowhpjscl+XxM9gPwALrgdOsEoGZoto7VYhwhNUYJowC
 yndxtbosr0Ihk0g7lBLk/b7sm1CoIQ/eDfcsozmka7Eeawwgny3U11c6FDnlF1Pe23k8h9
 bLFRsvP8VZzgM42gIZLC7x1dyo4U0Q16zAF53sYdQ0mGPtOW+MaTk3gs45MkfXXe9VJgP5
 dFUxx3pfudNjx8hMdD6iIRF72kLBWiAhNJB+KpxsTzcl1iG4XOskkg8psTKQNIvoyQgyBX
 T2uSF9HlwXMrOLbftNN8L7BVu73GBajhmcLNvzohhm8yQhGAzsfuVPEfiwJl0w==
Message-ID: <6ab8da78-e9ca-4a26-b693-e9a7c0a4b5fa@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736033654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePzaJKGu/TkXdqGcq1S08sYM4TMZ7RvNqIaCoBJeiWQ=;
 b=SepLBzQkDyMIjpXHU2vniDBKR7TSlqIA97ki9MzPXFH8ezT78Tjw0ENyLttJVT/8UGtOGR
 GTYqKFaPNAolh23MxM//FNoVQ8JDnQIdIrWL9znahf57kIC2XYHrnQeP9qHrgimfIZ0S09
 wBEfWWvuOCjYHxQLpZKf/ImyijyTTNykMEMRKJQeg+XtrBfUMCWfZTsBwdilD/7KbmwlJa
 iHy9hEIcwLCZTT/KrCEJnMaailkd4Xq798C2A0Fzy0UrDHjo1DtgG+Wb2zCeGs5NcBkR9I
 Te/1hMyAwSlSL3z5iMX9VHPTe6zFovZgUGbrJpbbAfHA0e8KmISQPQmlLXZDPQ==
Date: Sun, 5 Jan 2025 00:34:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] fs: eliminate YAFFS2 implementation
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 "cdhmanning@gmail.com" <cdhmanning@gmail.com>
References: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
 <20250104012443.GW3476@bill-the-cat>
 <CAFLszThsXV_mxaOftCM4K9=t1ziEenFG3NkA_h4wrt2jpLqH+g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszThsXV_mxaOftCM4K9=t1ziEenFG3NkA_h4wrt2jpLqH+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 5ddf2107fbcda18dbd7
X-MBO-RS-META: zowra74ap1qi3e7w7j4qx64apwrs7m9o
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

On 1/4/25 8:31 PM, Simon Glass wrote:
> +cdhmanning@gmail.com
> 
> On Sat, 4 Jan 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sat, Jan 04, 2025 at 01:34:02AM +0100, Heinrich Schuchardt wrote:
>>
>>> Upstream development stopped 2012.
> 
> I believe upstream is at [1] and I still see pull requests, perhaps
> just in maintenance mode.
> 
>>> Linux eliminated YAFFS2 in 2010.
> 
> Do you have a link for the commit, or why that was? I have probably forgotten.
> 
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>
> 
> I don't have any objection to this. I think most boards have migrated
> to MMC and UFS by now. There is at least one board in the tree
> (gurnard) which could have YAFFS2 enabled, but doesn't.
YAFFS2 is flash filesystem, so most systems which still need to use raw 
flash instead switched over to UBI/UBIFS , except for a few which might 
still use JFFS on NOR flashes.
