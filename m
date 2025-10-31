Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E5DCCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 18:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F1383AAB;
	Fri, 31 Oct 2025 19:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xdrkxmM+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FtXU/+sx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA8F783AAC; Fri, 31 Oct 2025 19:33:21 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E6E83AA4
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 19:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cyqNv1wygz9t2M;
 Fri, 31 Oct 2025 19:33:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761935599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nOFe0uxr5ZGDNuAWxcFC3mfhQJv4gJ90QdoVP6Pfxc=;
 b=xdrkxmM+XsQqJDbQ5OabC4MbdIFbKKTdos61rl1v1A/DWerB/f1AQiEIkVi2dN4pTVGl2p
 btzoxyz4dUIIAXUSsEaxwQvDd30KAhB8txgTDcgvTsW9rwAVV5OCm6dGbfZmVoNBmcCWXX
 ZqiAXInS9Fp2hGwChf3YJDT+KMVuH6uHA2RGDJYty7YFuxHKZdK7jtRVYacprrcUeCHqmw
 d2v6bGmfhwg42vIBgGuontLEHPYbovmkhzcJr685GiJ4bXLqDFPdEmma7YS6tBLkOuISYi
 XrpG8thXQ96Dgjy7OgTRdOcpxbEBmnN9b0EXGOprtV0H5s8KCg8+nD8dTRAjkg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="FtXU/+sx";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <304efeca-2529-4241-a9fe-7f305f8b430c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761935597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nOFe0uxr5ZGDNuAWxcFC3mfhQJv4gJ90QdoVP6Pfxc=;
 b=FtXU/+sxdioZ5ykg39x9pXuEwMCipXeX+ztmn9jCR2lzFrKuPM4ZBdQ6i54uceuIansIXx
 cyYXqM9ro84o2LBfxS3PwlU2wFm4aJJlizYOSHNljSkZsg0zktRWe55tSemkWP+dskToS9
 Tqnf12YCdZCGL2XjH93dg8FtS7/T+LVAj0ARKmCu5JBaGAwRHd+lWDELShxJU0O9cHYJMO
 RB1puLSTAgXAbgKDyd5/BCHZDiliax7rlzl/Cyos50F8hd2hNqPI4Io/dI0NOR7n25glyM
 NKmDV51KYpt3GCFSXAnH6syrzZ+U/OKDhp1vtfhcj29Y4JDMUK8Q/lUDFYyr0g==
Date: Fri, 31 Oct 2025 19:33:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/5] net: phy: aquantia: refresh format
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-2-root@infi.wang>
 <ac552ba3-832c-4cfb-aa39-c80949df7900@mailbox.org>
 <C2649793-C878-4906-BDF4-0410DA9F12A2@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <C2649793-C878-4906-BDF4-0410DA9F12A2@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tbqqmuiugmj3kw8nzgyoue199chz16c6
X-MBO-RS-ID: b3cd3e6686113ce09a2
X-Rspamd-Queue-Id: 4cyqNv1wygz9t2M
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

On 10/31/25 6:21 PM, Beiyan Yun wrote:
> 
> 
>> On 31 Oct 2025, at 11:51 PM, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 10/31/25 4:21 PM, Beiyan Yun wrote:
>>> Refresh format using clang-format.
>>> Signed-off-by: Beiyan Yun <root@infi.wang>
>>> ---
>>> Changes in v4:
>>> - New
>>>   drivers/net/phy/aquantia.c | 159 +++++++++++++++++--------------------
>>>   1 file changed, 75 insertions(+), 84 deletions(-)
>>> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
>>> index 903fcd667f6..439c4c48bdc 100644
>>> --- a/drivers/net/phy/aquantia.c
>>> +++ b/drivers/net/phy/aquantia.c
>>> @@ -18,28 +18,28 @@
>>>   #include <asm/byteorder.h>
>>>   #include <fs.h>
>>>   -#define AQUNTIA_10G_CTL		0x20
>>> -#define AQUNTIA_VENDOR_P1	0xc400
>>> +#define AQUNTIA_10G_CTL 0x20
>>> +#define AQUNTIA_VENDOR_P1 0xc400
>>>   -#define AQUNTIA_SPEED_LSB_MASK	0x2000
>>> -#define AQUNTIA_SPEED_MSB_MASK	0x40
>>> +#define AQUNTIA_SPEED_LSB_MASK 0x2000
>>> +#define AQUNTIA_SPEED_MSB_MASK 0x40
>> #define<space>MACRO<tab>0xvalue
>>
>> is perfectly fine format.
> 
> Agree, until clang-format has become the default.
This change makes readability worse, no matter what formatting tool is 
the current recommendation.
