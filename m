Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606011061B08
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 21:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B5E683CE3;
	Mon, 30 Mar 2026 23:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JLb8dw4r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iHUquRrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A03283EB3; Mon, 30 Mar 2026 23:07:44 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB4880212
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 23:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fl3jm5t18z9tpX;
 Mon, 30 Mar 2026 23:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774904860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AllQrW+KKfZSW9G7MI/LHqDshizenrrUULPdMkL3X48=;
 b=JLb8dw4rabrBdsFIV5zTWW5m5rB8fLBhAZaj9Dqfsd3u28kqnX0b+zmS9mH2o17kGi/uKe
 yy6YqwufD0mieVHdMJlynVM0GvEe+B6/gjU4VQ07qBgqyRVdpk/S94jpcyOLsXMHY9za0X
 z0+bvBDaWYjtYWyzPK0C43tpunLohW2mO7DUTC9uZgVFceckoZNs4nw8Zi/uF57a6W9+Y8
 U5khVwWT6w6GtE9sMUIDRjWWzmkzE6+gbWE7kyi3OJnFget1Xboj03Hbd491s9HuGhNV+s
 Bxy1tjHHZpd5YIycwjEeZdTBMv9xdT8pqeosWs/EvIKrXuxhXs5L95XyNIiNQw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=iHUquRrs;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e56eb040-bf5c-4ded-b9fb-5b003da6bd74@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774904859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AllQrW+KKfZSW9G7MI/LHqDshizenrrUULPdMkL3X48=;
 b=iHUquRrsLPPO+CLlPwP/CW+ufaJa8W98+HevFp4UWUhLIuKtcMLsxRCqZFwEfAovMietSj
 fGHmefHzhGw5y1pIrx8FDS7FF04KRMLGGIFcPuw8lRwNdMZsRnglr4tqPckInqHCYr7a22
 g2/Z9NnAsg8INUswxCGPF5lqDoM3idbpGmjn3av0+orT1W3IviISvz0uuKPgq+rP7eY7V5
 NUKewWUeue2egtG6xrLqrXOGpfvuZoRP9g6V+fKrbKX/OPi9E3L0uS0WUD9QZjK5bDCIq1
 IGtIZp21PJAJTkeOJ4YQ4nHKgfHY/kqwKCYYd7qC8Om7a/m7dO39j6EqhyPi7Q==
Date: Mon, 30 Mar 2026 19:20:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ufs: core: Fix heap corruption due to out of bounds write
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
References: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
 <384346b6-e798-45d9-b490-67d8cb6b6751@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <384346b6-e798-45d9-b490-67d8cb6b6751@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cebca33a825268afab6
X-MBO-RS-META: f9zrx1bz5e3wy4dec1irmooynt1z5fwd
X-Rspamd-Queue-Id: 4fl3jm5t18z9tpX
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

On 3/30/26 10:03 AM, Neil Armstrong wrote:

[...]

>> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
>> index 81fd431f951..6a51f337e47 100644
>> --- a/drivers/ufs/ufs-uclass.c
>> +++ b/drivers/ufs/ufs-uclass.c
>> @@ -1751,7 +1751,15 @@ static int ufshcd_read_string_desc(struct 
>> ufs_hba *hba, int desc_index,
>>               goto out;
>>           }
>> -        buff_ascii = kmalloc(ascii_len, GFP_KERNEL);
> 
> I think the whole function is a mess, I think we would rewrite with 
> something like this:
> 
> ...
> int max_len;
> int ascii_len;
> 
> max_len = (desc_len - QUERY_DESC_HDR_SIZE) * 2 + 1;
> buff_ascii = kmalloc(max_len, GFP_KERNEL);
> 
> ascii_len = utf16_to_utf8(buff_ascii,
>          (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], max_len);
> ...
> 
> So we stop having random len, and use the _real_ len returned by 
> utf16_to_utf8.
Maybe we should port the utf16s_to_utf8s() from Linux instead ?
