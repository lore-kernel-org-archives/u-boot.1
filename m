Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CBECCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41467839E2;
	Fri, 31 Oct 2025 16:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hlxpo/Rs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sVnQHG+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58AE839E4; Fri, 31 Oct 2025 16:53:35 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4C083971
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cylrY56GSz9tKD;
 Fri, 31 Oct 2025 16:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761926013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mPwVpI7VT4qp+tqumbiN5dB20Ytv6qYzQIAEW1/ftU=;
 b=Hlxpo/RsTQ7z9wmrJh7XSEpjXihG/rn5S8P7dNiC93aEtjP+PgUP8w5Ygl11iOBBL/MyBK
 owE1xpf6RCR2eZRGPK80ReKbV/1Fucl0j+wxMFEX+i3IIV/1ggmnzEZf3HUEQCRggbj5Zm
 kjK+jE1Ouc66cdLF+TVoGM5fy0inZnvsHilQxAwMjlG+S4UAgRIHIpORvT+ykKt7Y/Z7XK
 uXC2MKMKzJbDuoheooskZiyqzmyUdPL0EwLcGOt4AvqQNUGpe8xYBQ21hZHnyLrtIMjnrI
 9Xg/uLXZeKV5NVxkWwU0FcMBUZxN+uxonKevxulaRMSuG28IMNW1+tgYVXHL5Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=sVnQHG+Q;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <6ca0b758-ac2b-46a5-a06a-5ef5ae676f00@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761926011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mPwVpI7VT4qp+tqumbiN5dB20Ytv6qYzQIAEW1/ftU=;
 b=sVnQHG+QrmoFBNHyHMtzVq0bB3Ps+Iygp8jllVIOYka81wXuwlQxC6yayvqcMXWZ16m7Ne
 uBah3zC5EwRhC/wMfRmMKUNTtBhrPdnVj3bZ52g3HJCQaBbqVzxENc9WqK+nmr2RTdoFLX
 f4T0oGeewZfvoM+I7tABxq/GkGzn8urVLYgXOJPxgoUYftwUl/YDk+jjKBQEg/5IrCR4TK
 30BS75NroqgpnsoU0LGsg9sSNgigAHonnbb3cawEHahKYC4O6Z/NYDhAnCzJiglGbkJy4i
 tN0Wmk8ahYNj/Iwf/1RI52UJ7LkPc7WLNvki14kdtDbSh/siJaYApUohY7E3Fw==
Date: Fri, 31 Oct 2025 16:53:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/5] doc: bindings: use upstream bindings for aquantia
 phy
To: Beiyan Yun <root@infi.wang>, u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-3-root@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251031152348.60571-3-root@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3t5mgsakou6ok6s9tzbfuif51tmz67jx
X-MBO-RS-ID: 38f6a5f82a36875a42e
X-Rspamd-Queue-Id: 4cylrY56GSz9tKD
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

On 10/31/25 4:21 PM, Beiyan Yun wrote:
> Prepare for the switch to upstream bindings and generic firmware loader,
> remove reference to upstreamed bindings, also add a firmware-name example.
> 
> Signed-off-by: Beiyan Yun <root@infi.wang>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - New
> 
>   doc/device-tree-bindings/net/aquantia-phy.txt | 15 +++------------
Upstream bindings are in YAML format:

Documentation/devicetree/bindings/net/marvell,aquantia.yaml

How come these bindings here are in text format ?
