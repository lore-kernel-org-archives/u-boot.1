Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38792CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 03:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C6283965;
	Tue, 28 Oct 2025 04:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xCLoV+Zg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C/yKz5Fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D260F83968; Tue, 28 Oct 2025 04:40:36 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0107D8391C
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 04:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwbk95FTXz9tTX;
 Tue, 28 Oct 2025 04:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CiJod/M1boTTikuwo/ANhq8uGDLqDUlTawI8t8V+ok=;
 b=xCLoV+ZgjRwlDhb1G+2fe2tRmOPcM7hn0PWbZDyVBeblKhfigI3hB5XXUu5RziBuXd2ctu
 FkGrgitycUkimVcM4n6GE3V5BA/Le7CmQt8SsRgyUe7Y8nl6A/4j1OoKVE7Iz6zyO1gGWe
 kCQ/ydZ63fZmZJI2YvXzymg8CIMJCz5RJ4Js5wQ6lSgK4LbrF4nwbr6SFGa/INebEsSxJO
 I08LMQIPo2wTB/wHs8KV7+iQsIzFtTpsuQxEkL3QgDQn+DYUv4ufZu3HV+97wS+Cjiai8B
 27dxYkjMnv96NyBwVIIgyzeUsfjLGNLsFFc/FCjFKyGmq9rZ7AJzB8q4oIepFA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="C/yKz5Fj";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <20ee9a4e-9d66-4507-9c88-6efacef85297@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761622831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CiJod/M1boTTikuwo/ANhq8uGDLqDUlTawI8t8V+ok=;
 b=C/yKz5Fjj7UTQWEv6SRTHJTMzHsS9WnbSQv5MIXzmYaszGtnQRKmtch+bl9cCLClI14HVi
 OKJn9+XTOA+8XttF+3C4oiVPz+/cce4GL1Y9AbTv7KaibVH65wVr5e0H9tI6rfg+OeFenU
 uStwMYiFzRQBcrV3KUxnjX7uywkmU3VIeW3A+OUetIvgYKVBVf5DUuMW5NWcIdexezSXR5
 aDskwknu0MlmkjEa5rO8XiYxUQfXL7sC3AYvzmgUze4nfvdtBch8sPQUhPupDWuO7bwiYf
 xDoW+nBkSrQPa7rT0rmucPMDoWFc/FRPVKjYXJtrTieEuTO9sGWLURG+YSwi4g==
Date: Tue, 28 Oct 2025 04:40:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mtd: spi-nor-ids: Reformat the table
To: Vlim <vlim@gigadevice.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
References: <20251028004729.119349-1-marek.vasut+renesas@mailbox.org>
 <SI6PR06MB7813347A75CE48B5924DF36EBBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <SI6PR06MB7813347A75CE48B5924DF36EBBFDA@SI6PR06MB7813.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 801a3bca5b02487c702
X-MBO-RS-META: ob96ih8p41e1i9zamebb8j8aochzhbyc
X-Rspamd-Queue-Id: 4cwbk95FTXz9tTX
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

On 10/28/25 3:03 AM, Vlim wrote:
> Thanks, Marek,

Hello Victor,

> Can I follow this format.
> Should I change all part numbers so that they are all with the same format?

What kind of change do you have in mind ?

I think the gigadevice part numbers look very much reasonable already.

> Also, is it a good idea if I change the order of the part number so that I can group part #s by product family?

Sure, the table is not sorted exactly alphabetically. If sorting by 
product family makes more sense for GD, let's do that.

[...]
