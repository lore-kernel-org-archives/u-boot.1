Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97946C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0616582BF2;
	Wed, 30 Apr 2025 18:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746032272;
	bh=ouifAjyMNpGwqixS0vmC7EqyAi2xTrNQ/+f6os6epms=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vk071c7YomqiVOgf6mjKuxeCJOK7DMNb0GVX0Y47LHdXqUpx0wQMq4QSrKjMsFWUk
	 txd1dCHFQ8K1edKqQyJjG6oTgDCdgsUP+wCTKttepyzEPSvI2i3keuGkvtUevdDlOP
	 Cs1Cv9bc5Oe4CU61MLYY3N8Uc37ro79aDYAILDd62XuJVKQ8OdcPLXruVZpGsIVPp8
	 mmtm2/uzlOEFpYrxJ2GiUPi7nWwyWlkQO07LzffGFa8aw2ZQSwcdut4bhJlIPPDs8b
	 3RaeC5mSnJNkIDuac3jQo8CH6qoCC6/W606Jza9vxlfePT7mP4T14FUfaOEQ+dWTqu
	 8bxhNlcUyTxoA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1A382BF3; Wed, 30 Apr 2025 18:57:50 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB4F82BB4
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="R75E0qA7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C02AB10269585; 
 Wed, 30 Apr 2025 18:57:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746032267; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ouifAjyMNpGwqixS0vmC7EqyAi2xTrNQ/+f6os6epms=;
 b=R75E0qA7mwA/Z6pKKRgHJol5t5GOLz6bi1Vh5uSMdsfzjc4t1BhOzwDE5mKGoQi33nZ10H
 okRSJyPfm4HhRWk1tfSl1r9waQJYbQf0a0huPmV1bHWPC1sIYS3kwZbTdZ9YaMn+XrLud1
 ENQl5b6vBEsHrQCajjGFCE/DfUUK3oIBjpM3PRpJpGg7X0wUDJyCc5KiIvxRPmnLe2263N
 7KsdaI1qoHp7T+dgxIC3tF0iGtwIN8U6lcMlFq9bAqlQ80U2Znqp2R+I4Au0dWJRCOSfHX
 4w1R83hmAl4UJljxS5J7pMs27LSnd7BZjXa0M4LjxNWLeJNq5DAA5pUQZbPeew==
Message-ID: <19a791c9-19b9-47cd-9444-24846ae5c222@denx.de>
Date: Wed, 30 Apr 2025 18:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>
References: <20250428215930.GI5495@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250428215930.GI5495@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/28/25 11:59 PM, Tom Rini wrote:
  > 
________________________________________________________________________________________________________
> *** CID 550306:  Control flow issues  (DEADCODE)
> /fs/exfat/io.c: 547 in exfat_generic_pwrite()
> 541             int rc;
> 542             cluster_t cluster;
> 543             const char* bufp = buffer;
> 544             off_t lsize, loffset, remainder;
> 545
> 546             if (offset < 0)
>>>>      CID 550306:  Control flow issues  (DEADCODE)
>>>>      Execution cannot reach this statement: "return -22L;".
> 547                     return -EINVAL;
> 548             if (uoffset > node->size)
> 549             {
> 550                     rc = exfat_truncate(ef, node, uoffset, true);
> 551                     if (rc != 0)
> 552                             return rc;

This one is I think false positive, off_t can be signed integer, so the 
check should be in place.

> ** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
> /fs/exfat/io.c: 739 in exfat_fs_opendir()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 550305:  Security best practices violations  (STRING_OVERFLOW)
> /fs/exfat/io.c: 739 in exfat_fs_opendir()
> 733                     return err;
> 734
> 735             dirs = calloc(1, sizeof(*dirs));
> 736             if (!dirs)
> 737                     return -ENOMEM;
> 738
>>>>      CID 550305:  Security best practices violations  (STRING_OVERFLOW)
>>>>      You might overrun the 1024-character fixed-size string
> "dirs->dirname" by copying "filename" without checking the length.
> 739             strcpy(dirs->dirname, filename);
> 740             dirs->offset = -1;
> 741
> 742             *dirsp = &dirs->fs_dirs;
> 743
> 744             return 0;
> 
> ** CID 550304:  Error handling issues  (NEGATIVE_RETURNS)
> /tools/fit_check_sign.c: 98 in main()

Fixed:

https://patchwork.ozlabs.org/project/uboot/patch/20250430164559.27095-1-marex@denx.de/

> ________________________________________________________________________________________________________
> *** CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
> /fs/exfat/utils.c: 146 in exfat_humanize_bytes()
> 140             /* 16 EB (minus 1 byte) is the largest size that can be
> represented by
> 141                uint64_t */
> 142             const char* units[] = {"bytes", "KB", "MB", "GB", "TB",
> "PB", "EB"};
> 143             uint64_t divisor = 1;
> 144             uint64_t temp = 0;
> 145
>>>>      CID 550300:  Integer handling issues  (INTEGER_OVERFLOW)
>>>>      Expression "divisor", overflows the type of "divisor", which is
> type "uint64_t".
> 146             for (i = 0; ; i++, divisor *= 1024)
> 147             {
> 148                     temp = (value + divisor / 2) / divisor;
> 149
> 150                     if (temp == 0)
> 151                             break;
Fixed:

https://patchwork.ozlabs.org/project/uboot/patch/20250430164559.27095-2-marex@denx.de/
