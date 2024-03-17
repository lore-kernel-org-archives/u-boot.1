Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812FEC54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 17:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB6487D7C;
	Sun, 17 Mar 2024 18:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x5FuuBrY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="duDDrmI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CA6887F3D; Sun, 17 Mar 2024 18:10:42 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F62D87E87
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 18:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TyPdC3N1bz9sc8;
 Sun, 17 Mar 2024 18:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAo2f1Em1psC6S/6x4rq7lXZvT+r4TG3kFMj0vap5w0=;
 b=x5FuuBrYIE5AaUD3RIqSqaG+kJYVuW2VwkzHADdjxNMitpYtThgSBDzNq3OYC+7WbhS8d8
 bPYLdPydIozqLqk1p0R+XntU0RdqXMh91NAF3wpfMEmfWaeHWM0KjYDm5tawNg/ec358Ve
 SkkBJy3smLGPgr8JzDQywOdD0uJo8eOoHZ93C7HB8+bJSZBXEzFujlM5Bc1eULsSjTOwv9
 g1oFgXobVk2quam2VQ0uIrsO/NEcILmAs/G7XAP7B0W+H+u31tkyWYrKm0tZ9JgOCyN2Th
 +u3ALqhBnu1NU4Nnpj5W87q8as6fYSB5ipaBYNLcNW6i3AWhbJgVXi5rus3iDw==
Message-ID: <f2b76d00-6cbe-418c-b895-01911951bd25@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710695437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAo2f1Em1psC6S/6x4rq7lXZvT+r4TG3kFMj0vap5w0=;
 b=duDDrmI/fLVzTvYdl9rbf9V1F/lAHGF6UVLkgCwD5EIWyPLmATm4KFUyGLop+LvKxIlHlW
 lNcsvOKjFQP39x1rzeg6wtWtJpx45i1aswVOhFZO9LW4hLbrMWbbIvy9LmQewovlySZ5tZ
 pwqiS/7E+j3RWm/HhvwYaBg61C15nlykkYdr6aqUKoOWSkpysaBjeFkshAGGFmCetBFRXC
 7JiC5GGXnm8RA57cD06YBohru0pUiWeaLvryws5cCJOenp02RrYkTKbdLMI+a4wh5zVgoT
 qSrs0LKP64NtPr9dvxXILTcU2kstTF+oEOf6g2UIVoLz4ELE3J7dw0GOJLtsYQ==
Date: Sun, 17 Mar 2024 18:05:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] boot: fdt: Drop lmb_alloc*() typecasts
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <20240317061730.654893-2-marek.vasut+renesas@mailbox.org>
 <20240317112645.GF9082@pendragon.ideasonboard.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240317112645.GF9082@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e6a5d04676577413aeb
X-MBO-RS-META: npkzkf6qnec9bi5oazq5qnowfpafag6s
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

On 3/17/24 12:26 PM, Laurent Pinchart wrote:
> Hi Marek,
> 
> Thank you for the patch.
> 
> On Sun, Mar 17, 2024 at 07:16:30AM +0100, Marek Vasut wrote:
>> The lmb_alloc_base() returns phys_addr_t , map_sysmem() accepts
>> phys_addr_t as first parameter. Declare $addr as phys_addr_t and
> 
> s/$addr/addr/ ?
> 
>> get rid of the casts.
>>
>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> ---
>>   boot/image-fdt.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
>> index c2571b22244..c37442c9130 100644
>> --- a/boot/image-fdt.c
>> +++ b/boot/image-fdt.c
>> @@ -162,6 +162,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>>   	void	*of_start = NULL;
>>   	phys_addr_t start, size, usable;
>>   	char	*fdt_high;
>> +	phys_addr_t addr;
>>   	phys_addr_t low;
>>   	phys_size_t mapsize;
>>   	ulong	of_len = 0;
>> @@ -186,7 +187,6 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>>   	fdt_high = env_get("fdt_high");
>>   	if (fdt_high) {
>>   		ulong desired_addr = hextoul(fdt_high, NULL);
>> -		ulong addr;
> 
> I would keep addr declared here. With that,

I already replied to Heinrich on both parts, let's continue the 
discussion there.
