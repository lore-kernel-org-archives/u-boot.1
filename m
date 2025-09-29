Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720B4CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 23:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2C7833E9;
	Tue, 30 Sep 2025 01:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="L+1tQ9Mc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129B2828A2; Tue, 30 Sep 2025 01:09:31 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE758828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 01:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cbH2H0DjDz9tG1;
 Tue, 30 Sep 2025 01:09:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759187367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGsNwADguH+q7Owlm7kLyZSRFJMf1XGL1lumrniF5c0=;
 b=L+1tQ9Mcyv6P4mZye8Bgz3k3cp8n1cKsPdRHcynCzBnbdBK5EKHVYvm1BZA3XzxI0kqkO0
 TJ/rRkZ2QY2GS20FgeUa6RAAkjtg7RgLpzNTjen4Jf/Ty21MpCz/vx4Id4B785z5Rk7QzH
 zCxCf8FKSa0qj/TTZ9W3yDHh6Zlyaam4mDVuxKqLtv8QAV6tqUB+Pv+MIQcfezefqnSEnT
 n3NwtYwwBQTYBS2dP33ptSuohkouWJIf37lvHd6BjWG0KLIElgHRvz5mzPiIW5V3DxbKpy
 niFsRp1CpLSbDig/E9l81IJMEuPq/kaelNvm5Mnwb9lkV4hj1/BdWQq0+tNAJw==
Message-ID: <2063a446-0f61-4d98-8860-461a242662d9@mailbox.org>
Date: Tue, 30 Sep 2025 01:04:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: ehci: exynos: variable node should be signed
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250929-ehci_exynos-v1-1-ca365752de84@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250929-ehci_exynos-v1-1-ca365752de84@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ig5rgo3gfc5gya6a3fqr61aepdp939bb
X-MBO-RS-ID: 5a3293afd6b724f87b8
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

On 9/29/25 6:53 PM, Andrew Goodbody wrote:
> THe variable node is assigned to the return value of a function that
> returns an int. It is tested for being negative and then passed as an
> argument to a function that takes an int. So 'node' should not be
> declared as unsigned. Correct it.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
