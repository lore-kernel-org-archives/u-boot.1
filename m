Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47140D49780
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B625A8944E;
	Sun,  1 Dec 2024 19:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n7Q2plvN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vk/8Afo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 105CA8946A; Sun,  1 Dec 2024 19:51:26 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7495489442
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 19:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y1bbv21Fkz9sqs;
 Sun,  1 Dec 2024 19:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg5o5cHTMAWPbmMnEnpzE8FdXZW2Q9BuMPHcpruCAWk=;
 b=n7Q2plvNKwxIVbWlB/ppxxd1Ak+96v0c5iXax+Ok/G+uLpx2TlkvPmnBq6MBUc7U9AUu4t
 yEAbM1TVsGw9+0o8qQzTfO2VLLmlD9lf0thbCUkiNBpgx9LpKENNcKS6GRCqcp4zUGavZC
 JDPBLMKMxbRQTaS6zUVxyi5EvBgHmkSi+B+vYCuPZFu6Bg3nfs45/pZFB3eYOslFs7DoMg
 9szOdyfIfMSLsjP1Y/LhJF4q3HhMtz4MFgKALH9uBThEwC9uTbmeJLpZBv88xLeB6of1EA
 JpCfLAe5i4ZimlJddwO2HfOgKKCldyuw+sLEFHq1EyWifxQpS1jUOKlTnRzAZA==
Message-ID: <36028a23-4880-4271-8ff7-3bce92999271@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733079081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg5o5cHTMAWPbmMnEnpzE8FdXZW2Q9BuMPHcpruCAWk=;
 b=Vk/8Afo1ulBXNLECX2kE7jo3A0KiFFk4SOoU4W2tOQKKj+VLM2PPYqUb1NaZ+FL6wDM+ld
 ilB/nWK+ht+MD9LE1bhbqhRW+/ypVy2JD4ip2dDwREUCcc9e2sSLzoMbuONl6tRp+6+SSo
 DDWoFju7BKMcdQy1okC6Dfsg3rlkkJ/Uaj+NOeTR6NMv3u9HVebsfFm1QJ/NSGA0AyEn4+
 yjUFJSZQ3E21fakOlu+M2X8KusxTMV2iuZwZZwbKJfqS89SiulugS3bx2TnByusJVjBAI4
 ukFdQiNAyNwZwzCfc7mKRBY4kvHjeMgsbVkESWzR/3lPx6NzyfJFn079xFY16A==
Date: Sun, 1 Dec 2024 19:49:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] pinctrl: rzg2l: Support 2.5V PVDD for Ethernet
 interfaces
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
References: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8x4edcntefgsznjks75ozom4hafe11gw
X-MBO-RS-ID: a3fad82889f2cb541cb
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

On 11/20/24 10:48 AM, Paul Barker wrote:
> The Ethenet interfaces on the Renesas RZ/G2L SoC family can operate at
> multiple power supply voltages: 3.3V (default value), 2.5V and 1.8V.
> 
> rzg2l_pinconf_set() is extended to support the 2.5V setting, with a
> check to ensure this is only used on Ethernet interfaces as it is not
> supported on the SD & QSPI interfaces.
> 
> While we're modifying rzg2l_pinconf_set(), drop the unnecessary default
> value for pwr_reg as it is set in every branch of the following if
> condition.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
