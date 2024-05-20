Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9017EC25B78
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 23:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9953B88306;
	Tue, 21 May 2024 01:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="PKXOUq/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151A8882FE; Tue, 21 May 2024 01:26:02 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76CAB886D0
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 01:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Envelope-To: sumit.garg@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1716247556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BM37E3OHyijhvZA2sFZ8vFHZNOys/Pb/2VgK11Mk4zc=;
 b=PKXOUq/QtuKtUHfhTJzKDb+fOcg6o4syo/D7D5Fq3ZFb02m1UysYUQzaVvpiw/vcb113EN
 Vx3Z2PJLwAakt+op/hDgxaL8iCZ+kxB12q0/Jnmo2UdvCLluRPaI8sc1G1NG2kCgI34ulH
 YoAFNpHknSnymsBvHDCeiAPe8T0vkUXyaQTMPe1k4HL/tRx7dLu4mQ1oWzhAwOQWZ7dkTv
 eCnz2XqrwBUacSs8EVUp5Eh7qm0ez8SzTqzHYja9UfWPgWSSOdt9pSReDdoh1az5wl77X4
 I/2ZaV8g3U8J8VA6oiq84DnwUS7pCBAIcULQaCqBKvHxRwHRAAnh/92usit8cg==
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: lukma@denx.de
X-Envelope-To: seanga2@gmail.com
X-Envelope-To: trini@konsulko.com
X-Envelope-To: rick@andestech.com
X-Envelope-To: ycliang@andestech.com
X-Envelope-To: u-boot@lists.denx.de
Date: Tue, 21 May 2024 09:24:48 +1000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH FOR TESTING ONLY RFC 4/4] sunxi-d1s-t113: Add D1 and T113
 PWM node
Message-ID: <ZkvbwFie9r3lh9cq@titan>
References: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
 <20240518-pwm_d1-v1-4-311fc5fe2248@jookia.org>
 <CAFA6WYOhb1ke8+ZzFL11RM9Znz9v7NUkf7zQVP-MKAXVeH9Nag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYOhb1ke8+ZzFL11RM9Znz9v7NUkf7zQVP-MKAXVeH9Nag@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Mon, May 20, 2024 at 03:58:12PM +0530, Sumit Garg wrote:
> This change shouldn't be needed for your testing purposes too. It only
> comes into picture once you enable OF_UPSTREAM. BTW, DT source files
> in dts/upstream are strictly following/syncing against Linux kernel DT
> sources. So all the custom U-Boot specific DT stuff belongs to
> arch/${ARCH}/dts/.
> 
> -Sumit

Hi,

I use OF_UPSTREAM.

John.
