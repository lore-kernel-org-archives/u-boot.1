Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D912ACA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 09:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B60480194;
	Mon, 18 Aug 2025 11:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Qpi8ibDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C854803DF; Mon, 18 Aug 2025 11:32:29 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AE9180107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 11:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c56tx0894z9sqQ;
 Mon, 18 Aug 2025 11:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755509545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7rVtP3W+/Xmu+v2OdG8gzcud+cHMvBkgbd/As7dfPE=;
 b=Qpi8ibDQ2/fP2RtJtyk91/fyb6WmPntCm5wsakgspd6h2bmogo7RBUwJMqE3i8z1onxOsZ
 ULA9Yb7rZ56r6Q+3g0fhg/phLQRpabK1MCP/cTj8dh8/p0s8Gov2umJNLeaftfk18+i4V8
 poKPzHbiJSfUrpYP1BlWA9e2qdc6FoYxySIEICpMXRbhR4/mFZs8A9s8tvVWmnKoOwebDF
 7gDKnk01M8Yv114u2L0NoWvm99ZEf46ZdIMOyOz6Ud4fkEBLz0F3iVXtmRAhlqGmyu2QSy
 P/9xXJzFmrOtQXEadSHABB0zP+g5hyT9cmz4F4bzxRK5K2qrpMOFHiQM6GZLYQ==
Message-ID: <ffd1dbbe-15cc-43df-a6f8-7fe02b431b7f@mailbox.org>
Date: Mon, 18 Aug 2025 11:32:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: dwc2: fix reset logic in dwc2_core_reset
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250723170913.1.I20e0e3d5851ea2e4a22b20be372800fe059cc2d1@changeid>
 <a8dad650-96b5-47bb-807d-27f38b0ab34f@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a8dad650-96b5-47bb-807d-27f38b0ab34f@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bsx93w84f938kg48qgmeogxqmrwbpi85
X-MBO-RS-ID: 7cbc1666fcfb73372bf
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

On 8/18/25 9:11 AM, Patrice CHOTARD wrote:
> 
> 
> On 7/23/25 17:09, Patrick Delaunay wrote:
>> Use GUSBCFG_FORCEHOSTMODE to detected the HOST forced mode as it is done
>> in the Linux driver drivers/usb/dwc2/core.c:dwc2_core_reset().
>>
>> The host polling must be executed only if the current mode is host,
>> either due to the force HOST mode (which persists after core reset)
>> or the connector id pin.
>>
>> The GUSBCFG_FORCEDEVMODE bits is used to force the device mode (for
>> example used on STM32MP1x platform) and when it is activated the DWC2 reset
>> failed with the trace:
>> "dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout"
>>
>> Fixes: c5d685b8993c ("usb: dwc2: Unify flush and reset logic with v4.20a support")
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks
