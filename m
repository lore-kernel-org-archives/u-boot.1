Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514C9CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 13:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608F7846F8;
	Sat, 30 May 2026 15:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FjSLe+gu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CCD484704; Sat, 30 May 2026 15:27:57 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C11184671
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 15:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gSLd53MFHz9tgG;
 Sat, 30 May 2026 15:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780147673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Be9geY5TrBBEQNz3p3o8kqSRT6+nfQiA11jwAreF4qU=;
 b=FjSLe+guz8x8DD9GgEl3V5X9BCUyIR7F8KvMyov6Lm0lZb5Znr83oz0Po3HM54amqhG16O
 fOegufrEgi9BDDT/fdq5MouU8ydk7NmocgP/TZojW3KjKaRBRoAvFXhh/wIvNNFW+3hAW7
 a0IOWk80dUUcpPhj2uQw/8byD5i9ckizxZUD+mCRXR9o2TTR6vpgRgArUKllcnfwCf+v5f
 ynxcpehxzyarOJlW8OTwagBZbQJLwD9ydvrY42wnbtUafDUX7VBfnxH+flW//KahU9+DTJ
 jlcRyiKz+lnBp0uG1zPMxh9ClbC2g7A9772TzpUsWpL32CWZikTOOyrYWIz02w==
Message-ID: <a6c838a3-f795-4a29-bb0e-89a8b8fb098b@mailbox.org>
Date: Sat, 30 May 2026 12:02:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] dwc3: Fix fastboot re-run failure with flat DTS
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260529-usb-v1-1-be5bcb911f40@oss.qualcomm.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260529-usb-v1-1-be5bcb911f40@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rmbk8rth4okt8fe164kbonwf7ma96c9j
X-MBO-RS-ID: ec9d7225b27e8abfc2f
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

On 5/29/26 2:22 PM, Balaji Selvanathan wrote:
> Problem: The first "run fastboot" works and enumerates on the host.
> Subsequent runs fail, with no USB enumeration observed.
> 
> With flat DTS configurations, the peripheral device inherits
> power-domains from its parent (glue) node, as both reference the
> same DT node. During teardown after "fastboot continue",
> device_remove() of peripheral device invokes dev_power_domain_off(),
> which powers off the shared USB GDSC.
> 
> As a result, the next "run fastboot" fails because the power
> domain is left in an uninitialized state.
> 
> Add DM_FLAG_LEAVE_PD_ON to dwc3_generic_peripheral to prevent
> power domain shutdown during peripheral removal.
It seems the driver does not handle its power domains correctly, 
inhibiting PD control is not a fix, sorry.
