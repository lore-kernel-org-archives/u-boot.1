Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328EEC7113B
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 07:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDE486562;
	Thu, 24 Aug 2023 09:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="j/MGk1ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5823086565; Thu, 24 Aug 2023 09:35:16 +0200 (CEST)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1488F86554
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 09:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 1BFC2A04;
 Thu, 24 Aug 2023 09:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1692862510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4KGxkBBCMK6bsKz7x2kalN2rBYq+FM2nS0KweQvzS8M=;
 b=j/MGk1ewv8KNtX1nYq1+pb2gdSDk7Zx7yvj77d90POpdcOoWG2wpbc06WngtveHKIonGxv
 zBQJo13wvVFkIMwWZy2xI1jZiAkTRZT3j5xL8nFFZ0qD4i5LlbeR9b5h//hWrgv3Usmu9R
 wn30jMDz9MeQJjtKEm7BHnJRPDu+rFTPcj2kOmJQdiau5zOJ1yT+GPK9MKpgjRz293Ci4I
 pGP5vDTuHRwVxQ3pWvFykG6Vq9nhm5ErTMPlbi3RhdFsI0ONjin9OODsMjlkPczQJ3Ow9g
 wV8aO0CMozaNRbnqRgrtFGtxGzFvVS+XFVihd54pJySrWe7RvlG4uwPnbRSNLw==
MIME-Version: 1.0
Date: Thu, 24 Aug 2023 09:35:09 +0200
From: Michael Walle <michael@walle.cc>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 5/6] kontron_sl28: Use u-boot-update.bin instead of
 u-boot.update
In-Reply-To: <20230824030304.1555547-6-sjg@chromium.org>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <20230824030304.1555547-6-sjg@chromium.org>
Message-ID: <ef160d20e37f85f0bdcb145a11a7ae69@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Am 2023-08-24 05:02, schrieb Simon Glass:
> A '.update' extension is not allowed anymore, so change it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Looks good to me, as it is just an intermediate binary.

Acked-by: Michael Walle <michael@walle.cc>
