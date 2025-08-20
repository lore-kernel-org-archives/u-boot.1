Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB69ACA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 20:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341FA81FEE;
	Wed, 20 Aug 2025 22:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LytO5JhJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SnmJfpNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1368E82E34; Wed, 20 Aug 2025 22:47:18 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D49801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 22:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c6dmg5scdz9tmM;
 Wed, 20 Aug 2025 22:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755722835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWMdzzgPEhfSa3WBRseZA1A65t72FGPn6ovtPJv+ySE=;
 b=LytO5JhJ/gjNEFohUwtT6Rr4K1vo/xhzz28j2kEJom359LfTgBoOYLqkvmi0NtSI8inT/N
 VM+Fy7F5Dc7yYEVzUTBah9NArwFAwyv1lSpFoLxlHGHx4tdeUXQDMKTif/fm3yZNrYCg8D
 XPxsqDfo3+CN2Y/ow/kstMsiknyN1GC4i//PoUV1gNN0OmLI9/4j78xiFLBQYe1jmcHIGl
 UPRAaEe9HDm9TXCmp8jmbGhfoPE1iwdhits+JeFWhy7h3cKvQI5rjU/3eCJczZovdfhFRO
 WtgZIHVCOyTsYRwZ1xJy/CXdoqT6PsXOdbtL9tQWu+NQ2MioZO3mnnctP7gXbg==
Message-ID: <9545a60b-d4df-4458-8011-5b879e17800c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755722834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWMdzzgPEhfSa3WBRseZA1A65t72FGPn6ovtPJv+ySE=;
 b=SnmJfpNiBDo8ASVNPHa8VIJhxJg4QaBvpyUiaRxcUJ9AayThQfFuD+NY7Az9HOoUd7ZSp7
 pJ3Fzo81udnX0VaJxuueQZ2fkOVAe/aBYuAg9pjRflqu6yW7E4ft6anCN7CoiFai9y1GRG
 dBIIEz2Ms3lj+DSBzsa08drjwuYrh+DNXMGu3usDT3R2ozwLc8p8uV25CkL/wpFs9TAHYo
 iyCCiUih/VXxvTk5AyJ5jcKk2Ysgc9U/JT3cCYzxY1XdxueZEvaWcoz7p3Oa3yFkXGCD1Z
 JKEmwCijGNsWAnclAhtAjW0kkbPDczRLOGkcChOhH3ifwSTVpH3s9Plzy6zuqA==
Date: Wed, 20 Aug 2025 22:47:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ram: renesas: dbsc5: Fix off by 1 errors
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250808-ram_renesas-v1-1-c417163a2a38@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250808-ram_renesas-v1-1-c417163a2a38@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b942684e479982d2e3d
X-MBO-RS-META: a3zawfhhkujptdbwj8fhemt7ejhf9tz9
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

On 8/8/25 1:32 PM, Andrew Goodbody wrote:
> In dbsc5_read_vref_training the arrays dvw_min_byte0_table and
> dvw_min_byte1_table have 128 elements per channel. The variable
> vref_stop_index is limited to be a maximum of 128. This means that the
> index used to access the arrays must use a test of '< vref_stop_index'
> rather than '<= vref_stop_index' in order to prevent out of bounds
> accesses to the arrays.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
This is a real nice find, thank you.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
