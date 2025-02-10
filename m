Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A7DC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6491805C2;
	Mon, 10 Feb 2025 14:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1739195124;
	bh=kj2+0i0Cojl7wG299okIVbG6J89Wm+zgWmoE2EO5JT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tbeMfKgeoIJuE80pjk3T0034L0GF9X7FVY6666e0w8EORVE9dfU3Pb44T7RUPEmHS
	 Vrbn2NvNzF9QFChiuRANxx+KxjYoavsIs7jAzfepXoODb41P/wBVuxUuobOimMF3fB
	 ukVeAUzZsgnDCIqQbZc3U6DkMOy/539X0nukygZwS0RgCIjIgFPdOj7ayAnUezPBdY
	 r4QAj0oOWKxQ21cwBwVW8DxqLaxThgHwOWe0vKz+EnIXJOP09jOZ6X7kaP6Gg0huj0
	 Fyb8X8JvW9YQ7SsO0F9hXQm5Q/Dp+oMbI3NeoSLShi9MPSzJeDq+STphjD+Tb/e3MK
	 4tBFRGoFCIcfw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5AA807D6; Mon, 10 Feb 2025 14:45:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90A0F804CF
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iH3FX8vU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EC59D10380105; Mon, 10 Feb 2025 14:45:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1739195120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kj2+0i0Cojl7wG299okIVbG6J89Wm+zgWmoE2EO5JT8=;
 b=iH3FX8vUOh2uYQr2whVajZSi9ADzGxvTLB/VDwmBi+I7N2sVxjQSHHGDG1DP9aPR6B1X5l
 fN81JTuSJYqWRah1P9KPKq1v31ttMNhdh+Pq6KEEHotF8UjkZcia5EwezoPQ6eLX9gzIJx
 uUjQX893QKJ1DqLQoaQjB2nTGtw1C/Kc3kO9S5xtCh/I+0U7iNeivtp/U4OjqdHeAp4ywE
 eEwFOKF7D5xK59LY9IljS+D00/veh6c6IvsDrJdg/WX5wlj8xvR2gQ/1Jt/xYdt6i7Cn+V
 FwgZkxEdYFt8YqIv3CguufL7lK4WL/9w29UNTD10i2bnztQcEGlrHna10MSzBA==
Message-ID: <f1d2068c-b393-4b90-b923-aa51b0972dc3@denx.de>
Date: Mon, 10 Feb 2025 14:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241202074644.5380-1-patrice.chotard@foss.st.com>
 <87zfldnlmw.fsf@baylibre.com>
 <c89e94bf-0ed6-4b3f-9f3b-eee9d30a91df@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c89e94bf-0ed6-4b3f-9f3b-eee9d30a91df@foss.st.com>
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

On 2/10/25 11:28 AM, Patrice CHOTARD wrote:
> Hi Marek

Hi,

> Any chance to get this patch merged in next U-Boot tag 2025.04-rc2 ?
Gadget stuff is on Mattijs desk, please ping me in a few days if he 
doesn't pick it up, I'll do so then. Sorry for the delay.
