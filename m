Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D41C5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 07:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB6D740A0B;
	Sat, 22 Aug 2026 07:56:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zL-j4JJfJ9rV; Sat, 22 Aug 2026 07:56:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787385384;
	bh=zMhLCS0PEDxeJOzHpqEBFe2emgTipTt2/h3Wh/pgSYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ME3smTtLdK6l/zcWP1JJMSXsc1WCKeyW9PnBYHdi+OZxwRu5ZN6YzY/tYjsHxQDJp
	 3qy+ikA0w+zOOU1NkIANBd5UscwSKRU6J0anjdQG5D4QHBhuarKTSzlYTXFGwfNicp
	 y9Xvu+AphHyiueRxA2HTqAFArUQOdfM1BmlnIn0XcpyTZXK4F7FLbwE3f19H3eJ+Hc
	 nEC93uuE07vGYD5Ru66yar3OV2k5X/QOOEmrGQ1Flj1jfjf/Uf6enp/7/r2KhCcgAd
	 thNjZAK8g1k/6hYMtPYh7Kq+8QjMNazHcWwznb8eonWCvRY48NNrpI9hujsOY2uIZb
	 VuP1rq3frxQ1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79C4D409EC;
	Sat, 22 Aug 2026 07:56:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F1D34B8
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 07:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F868409EC
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 07:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VrUaHUtrace6 for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 07:56:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=vSyDtcpz; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=j7X6NFhu
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9FF4F409E9
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 07:56:19 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hRqHj6CKszKmLw;
 Sat, 22 Aug 2026 09:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787385377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMhLCS0PEDxeJOzHpqEBFe2emgTipTt2/h3Wh/pgSYc=;
 b=vSyDtcpzxFSKDMQkaRhIquysXNmrknxmf1NYV3oxQBOYuudfnMIJAcXFt7TXtIjAAwchgg
 7xL+Nhwz7OvSQWuUBGqw3E20Byy9oqX5wVXKlDAwOU4GC8E//IuKnjHIUE3kJFTLS8FQ3n
 ED/Gq7B7eAjtEFiGv29Y4vzd+UvhCYmFAtvU+Kk3UC4bF4zPLokz88AnmNcIAHarnLoGYX
 1VklfNDkBOUPWdQ+qTRC+1idyefRqY4IidR07jt0Zc2KSJbO9MzpJ3lCGIlxd/nS1t7kSz
 PpJYOgC2c3FUUoxY359NJbJ448Hj0tMyYktgbh/tUGM9cZYcneJ5kpCcGHu3nA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=j7X6NFhu;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a4ff5d24-9da3-44ad-934c-8a8b0caaad42@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787385376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zMhLCS0PEDxeJOzHpqEBFe2emgTipTt2/h3Wh/pgSYc=;
 b=j7X6NFhuRBeVZ7qCOdgPUFCIFwd/krwvrfNxM7eU9407KGJMhAJagbqtpWGi3mC+GyvQqs
 SkwqpriWGZEOAl63JITPhRv429PHydDTNzgY1pjgbeTEOUf+s/Rar3hpskee9FZ6SA1uep
 ePk8WgIKK1H5v/W9yC7v5mC5mdZvmmqN5BYRuk94jOTLtsFTO0a/L+KvLsLJq0CVJrvFH9
 3nO1DVxxiMwldWCFaaLJbYyXOGaLd486pYyQERSPogAEoPKqfPvG2yJxd915ZklCyZUkcw
 BlcKUB++iKtTwQC38KGphwABccdOQY5ytG7NLGXBeDV9v/9DZSkW7yz8etuK3g==
Date: Sat, 22 Aug 2026 06:22:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6 01/87] usb: host: re-import xhci-ext-caps.h from kernel
 v6.16
To: Tom Rini <trini@konsulko.com>, Anders Roxell <anders.roxell@linaro.org>
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-2-anders.roxell@linaro.org>
 <20260821194451.GA3890585@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260821194451.GA3890585@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: escodcxutuxi8esjnr33fzbbatkh9myg
X-MBO-RS-ID: 45d5eb574dac681748e
X-Rspamd-Queue-Id: 4hRqHj6CKszKmLw
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/21/26 9:44 PM, Tom Rini wrote:
> On Fri, Aug 21, 2026 at 10:46:37AM +0200, Anders Roxell wrote:
> 
>> From: Jerome Forissier <jerome.forissier@linaro.org>
>>
>> Import drivers/usb/host/xhci-ext-caps.h from Linux v6.16. The file
>> is needed by the updated DWC3 code.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
> For the current series, the cover letter is missing in lore, and the
> last 3 patches are missing everywhere. I think at this point we should
> split this up as:
> 1. A series that resets the driver, and brings it to v6.16. These
> haven't changed in a few iterations of the current series, aside from
> collecting tags, yes?
> 2. A series that makes it all work again.
> 
> When being merged, both will be required, but this split will I think
> make review and iterations easier for everyone. Also, for the next
> go-round, please drop some of the old email addresses. Thanks.
One more thing -- is there a git tree with the current state of the series ?
