Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB63C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B33B6406EE;
	Mon, 10 Aug 2026 22:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ueVaMHCYXKAJ; Mon, 10 Aug 2026 22:13:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80318406AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786400016;
	bh=vzovnpxC6r3pK6PuFry0rRAEm6w77+Iqn3WTAarA2Xg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QHz1MqglrLfj1t7hjwO4OBap4y2HqshQl/ht8UC0TJz/pSa6OhQEaHdelsPikyLXv
	 0ykY1nhZ2kVNc4arMeIgQfIMS/wgCKIJVXcZ/Bo1UK8t/fnuTLLoGOIdRmJr7NI+Qa
	 /NNbbB/u2rVtjHvHhwCcQL2xxNfDOu3MtG5PnmlnQO34FWFqqFpDRvpDeOc9rjcM2H
	 mr/3elzAeao+yN754VvGYyDw7Qk1+K6TnODmjxjC4VIZ4Tqm2lG/MF7o+9K6NkdyUI
	 vwmB0aFjdObUcDI1Pghd/k6DTVDS3smtjN8KxdsplFprVqkZdE0GVu8YqM6LXKg7dZ
	 PRHtpbpMAlv7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80318406AF;
	Mon, 10 Aug 2026 22:13:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FE8C198
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 06A22406AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S6cjOzij2jYM for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:13:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 36DF640692
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36DF640692
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36DF640692
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:13:34 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hJptM5kPYzKryK;
 Tue, 11 Aug 2026 00:13:31 +0200 (CEST)
Message-ID: <6735b4ee-9e38-4ce2-b632-8fa0370ef114@mailbox.org>
Date: Mon, 10 Aug 2026 12:01:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: cfi: Replace env_get_f() with env_get_yesno()
To: Stefan Roese <stefan.roese@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260803231755.374057-1-marek.vasut+renesas@mailbox.org>
 <cfca4027-3c8a-41d6-a8c5-602994df4822@mailbox.org>
Content-Language: en-US
In-Reply-To: <cfca4027-3c8a-41d6-a8c5-602994df4822@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: khfxhndkgt6aen91zf8f98bpfgz54oy3
X-MBO-RS-ID: 0a91373836386cc38a8
X-Rspamd-Queue-Id: 4hJptM5kPYzKryK
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786400011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzovnpxC6r3pK6PuFry0rRAEm6w77+Iqn3WTAarA2Xg=;
 b=KDHIo/pBYwk8x2VI6CtUah8Ihx09jqFn8pvTZ88qdhnVzn0pRvcutz0DOWkNffmmJeTibr
 4eb1w2i8JM6sM7PT+Y5yFnPxa4uofTAFx/8aLfpnauBuOQJuTRPeqqa+SuJ96Ec0I8rp/w
 UkpDblsy2Ra3NJH5STbED1IeZUHtWEaxM9U9VDmly1VzFpBSiS7pNrKQfLszEAQRiu1pRN
 OTmnX2DahiYK25S6HmBtpRa9hqI+c/lxtfWYiUyuKrL3dTiGevjIyCUy4f5Rqq9jKJcrCF
 XH5KUkD/9OSsSI8LlJv3SSYYCfoXFDfvtCTid7hRi+UQWvI1nVKkj4xb5fhTUA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786400010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzovnpxC6r3pK6PuFry0rRAEm6w77+Iqn3WTAarA2Xg=;
 b=IPbiqG68fApTbdNHZKMG400KSDVPLi38sP+TFcsjuYWuaKiK7XHvXPyIEJBKVTC30P19Dg
 imZRsAje+HugVsBHGUbsplnqIhCevmGtGQazlySXfT45uJBP45P7k5SdMtI/ueD6Wdx/a4
 qxO2+qKTQv4VNemIQyz8mL3Nt6dfVuSqfpXJ26wRj/q+T9T2oLAetYJ69JdXYnfKmQ4f/U
 7z5O6CCcNNFsTxmrL6xUAMExuIK7FfapbJTLbIbapTeJVze3HgwRGqKQCWizhz5jYlXpW9
 Wlq/BdFl4Oo2Dl7DNw+XmgPlUh76dH5EZxcZGmuVSGAQPqfK+OInbBcaQUfENw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=KDHIo/pB; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=IPbiqG68
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=IPbiqG68;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/10/26 10:28 AM, Stefan Roese wrote:
> On 8/4/26 01:17, Marek Vasut wrote:
>> Simplify the code, replace env_get_f() with env_get_yesno(). The
>> env_get_yesno() internally calls env_get() which may fall back to
>> env_get_f() if the environment access is not initialized yet.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Stefan Roese <stefan.roese@mailbox.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.u-boot-project.org
> 
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
> 
> @Tom, could you please pull this directly. AFAIU, we did not create
> the cfi-flash custodian repo in the new infrastructure. I don't see a
> real need for it, as CFI flash is just very rarely used nowadays.
HyperFlash is also CFI NOR flash, and that is used at least by Renesas, 
TI and ST, so it isn't quite as dead as it seems.
