Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661C4C54E60
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 17:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2AA87F4F;
	Thu, 14 Mar 2024 18:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QqVtkiBs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SkRH8OfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0518087F4E; Thu, 14 Mar 2024 18:37:30 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEBD987E30
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 18:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TwZMV4YFwz9smh;
 Thu, 14 Mar 2024 18:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710437846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/pD6UTbJIe76IJVygIQ1oHqMSNFUyVCcdof4mokT/c=;
 b=QqVtkiBsIKn01jVytAhdK3o6sK3FGGEgo79rWGVgiqguOOhoAuylSp5bLXaRD5iMwEqZzx
 xpBKSggW0sxzchO+o1XtyMhOvqfv3X+8lCyTYqaXKXiRDDYxvjPkKAm74DucR4rdo6c/3O
 8boeQvTGfHA/8USQspMiu0wZBpBb33mkl8oZ8DgVFqki+YIVzeKzhbO8KeHArkHreBMJzl
 Oj4vKIGDzpOi6OgdTUBymSdHuFpsRS4gr12U5eLrPYQoqhyzuLvGCW9sclXEdtfNZNVUCr
 QTGHp5nVAu59S1OaO3hIUIL4S789cEoC76tOySD1K7sOTn6qen5SyUL08k4dgw==
Message-ID: <237bf0f6-a4bd-4295-98d1-1b9efb8db317@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710437844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/pD6UTbJIe76IJVygIQ1oHqMSNFUyVCcdof4mokT/c=;
 b=SkRH8OfGO/F0/wn8++7BtwvXHYmxAfyeBLsDR8OmCLrR5fQkx6NJjJyf3cbvRdaminlWpG
 h+jJmelwYp2Jpd/stzuIgIR3RU8oWmS2XsCQRGtKyb3qrW64Roookb543xZoU/xCA/Dq5o
 t5jmby+/vDWxMvuRob8nN7hiec3dN2Cw1blaOlClBJzxS+/oYAC/oj7xD+I1EJgPZMPCA6
 82ZIRtRwFth7qqf+qLKAmVGbqULjUiakC3gHqWCy0saWVnAY/w03Gz7W2Don8XETYHeF2y
 1JxGyA8niXIJ55U9oB7MWmHE3W+CpInK4A9KTeM4R8y4a4/rueysK2WgO9XwqA==
Date: Thu, 14 Mar 2024 18:37:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] rockchip: Add a board_gen_ethaddr() function
Content-Language: en-US
To: Detlev Casanova <detlev.casanova@collabora.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>
References: <20240314144403.491850-1-detlev.casanova@collabora.com>
 <20240314144403.491850-3-detlev.casanova@collabora.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240314144403.491850-3-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: gsquh61pykb8fifdchs9qt4y4gc6c45a
X-MBO-RS-ID: 4440186624b791be65b
X-Rspamd-Queue-Id: 4TwZMV4YFwz9smh
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

On 3/14/24 3:43 PM, Detlev Casanova wrote:
> Set the MAC address based on the CPU ID only if the ethernet device has
> no ROM or DT address set.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

More of a general design question -- how much of this can be done in MAC 
driver specific .read_rom_hwaddr callback ?
