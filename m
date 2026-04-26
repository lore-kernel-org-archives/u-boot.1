Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E705BFF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 16:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E08E840ED;
	Sun, 26 Apr 2026 18:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bMNHAhr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A414B84105; Sun, 26 Apr 2026 18:16:37 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D7A80087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 18:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g3WzL6QX8z9sWM;
 Sun, 26 Apr 2026 18:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777220190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkFfBcokAJdtOGj9qo0YQvJKT9mZwzDkb37EvYteZ50=;
 b=bMNHAhr5Uh4EWoI1A/fysfj5L8qu7XMJnioOAKF6Nx2TlVkwKOrIEdb7s+IRYrMl8bpvYV
 jbTAPHd/+i45yenyptSJgoVMdYPwN+zgjv2MGt7FTbxuECgnM1YPJj+K8XCpYMziEBDESo
 YxxoNPLFNFtY2/v5odi5rLR20tJllQKHgfUJOewevzAMV5ycOtUH9LYWYjrQhlQFJS4+1k
 Tm/1P9CKT/l5tZ6MBeKTjz1w7wg8QiZpt0Tqe6z1EFroBiC0FhOnMzEcTn8P+hiKprtlMQ
 x7+roV/v4Cv/QNxT9Ef3pymbohrOBv1E1NCqSAueN4r49EpNuQ757vtp1aOtiQ==
Message-ID: <db5378da-4ed6-498b-a2dd-cbf9d2a3f66d@mailbox.org>
Date: Sun, 26 Apr 2026 17:53:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/3] usb: gadget: rcar: Add RZ/G2L support and
 lifecycle fixes
To: Michele Bisogno <micbis.openwrt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260426074319.5819-1-micbis.openwrt@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260426074319.5819-1-micbis.openwrt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9b3551058ee4a1dab7f
X-MBO-RS-META: qctyie6famquo959bqcgah19xreoji6u
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

On 4/26/26 9:43 AM, Michele Bisogno wrote:
> This series adds support for the Renesas RZ/G2L (R9A07G044) USBHS
> controller. During development, several lifecycle and resource
> management issues were identified and addressed to satisfy RZ/G2L
> hardware requirements and prevent resource leaks across the driver.
Applied to usb/master, thanks !
