Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBE2ECE57A
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 14:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D3188E05;
	Mon,  9 Sep 2024 16:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725892151;
	bh=5L+sEwSMCTmZimOIblZd4LgEDX9LzufwRc7krsLph3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hIzRxaxW/AaeLFu6z/DoBBsQnq6Xv+QhYI5JREszwf/2MIekMa8ddIddXYVIX5zu7
	 o1nMI5CoLHPcFrILe6SXmnQOBBsUEOHVNsYjUmjK9NxUiXzLyKu7p//YdLIc1lEb2R
	 9ksIig5jwudqs/M+r8Hnb0O/soX9zomD4yJK1fTaMX6ZtjcNKrQFy55oCsOl7UG73l
	 8edFuaMhqE4bFXmGp0uZRv1V2hW7AU5rICkYAzcMJDH522cAW6ga3NbFymg8cX4eVK
	 MXRtTGUKgE0W28T84mARIdDSXl0n9xwghQ+ghEKp7Ud4uLR1ozlrbEMsUJ4SYp1BRz
	 U0hJh3ALcRfCA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7620E88C70;
 Mon,  9 Sep 2024 16:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725892151;
 bh=5L+sEwSMCTmZimOIblZd4LgEDX9LzufwRc7krsLph3c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MPZA7gxW+OdJK5KH7dji+38Zkd1ih7Y++W8e7OD/7zLSx8zrsG/y+dwpTEDlpsJqd
 gjk7+v/6qApfAahLkzKQqt75FtUtaBhCMZCgJlK0kHnkR7MN8aTDOqWgPas1sSnFav
 JBbs7VyXidNff/pbaDKjamefdppsWxAb6HU5EGBoCSyelkyC0s6L09enKCpqi3GEUe
 DhdQXkK+97gyLBkw4j7DT6TE38gPqbyby2qEmTIGBCrLTU4DYCrJtUrBhESdH1lhIg
 nlOzxVPQUeuhHhAoGJGXDlDif8265wSS2cxiwagff81ADKureRC6YEFxeIY/PFQ9TL
 /Nw05nAgBLj5A==
Message-ID: <1ffb308b-ee86-4a57-ab4c-7cd7fa572d9f@denx.de>
Date: Mon, 9 Sep 2024 15:59:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/28] drivers: usb: Add generic XHCI
To: Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bmeng.cn@gmail.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
 <20240906072231.2531491-17-patrick.rudolph@9elements.com>
 <20240906161313.GD3879073@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240906161313.GD3879073@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/6/24 6:13 PM, Tom Rini wrote:

>> +/*
>> + * Dummy implementation that can be overwritten by a board
>> + * specific function
>> + */
>> +__weak int board_xhci_enable(fdt_addr_t base)
>> +{
>> +	return 0;
>> +}

Are there any users of this ? If not , please do not add new 
board-specific functions. The HW should configure itself from DT.

Looks good otherwise, thanks .
