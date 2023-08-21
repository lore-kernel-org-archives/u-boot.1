Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975B8EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3778702E;
	Mon, 21 Aug 2023 20:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ruabmbua.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ruabmbua.dev header.i=@ruabmbua.dev header.b="kTWv84e1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F55787047; Mon, 21 Aug 2023 20:05:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 654908700F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ruabmbua.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@ruabmbua.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RV0l769PHz9spd;
 Mon, 21 Aug 2023 20:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ruabmbua.dev;
 s=MBO0001; t=1692641139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bhm3q1kPJK4hots24ErGFNUSPKConrO1JeOmIWcqYr0=;
 b=kTWv84e1tqQ1NoAqQY73W2ppQREdpy6//xoDLDtpyrD1MaG+WwDDoBRLYinw9p6CfgUNvB
 8iMm0gX5fQsYn1qy01ZP3Jc9kh3oWKhcoGAdDluLNcz3b6h+FJy4uXqMS5DHVW3GfVV9N+
 FLSyu0P+h5UhtSBAUrf+qlx/cnzzBgXwsuxdCyO0edJYGF8Q0bCWyJlKpBZt/BoeVXvulc
 MBAjTRXcX27Gmw2btnA7WaUoTqiKXJvmrQfDvdTuCtmjfRS08ltABX9TfiL1jNZmqD11eI
 y6evovgkd/LgtHuJ/lxMxjsQGVOqHpJSyiGE+W9q38yCn1jjehK1hpDtnDhilw==
Message-ID: <f72e0a5e-131c-42b1-9a3d-4e443df18b94@ruabmbua.dev>
Date: Mon, 21 Aug 2023 20:05:38 +0200
MIME-Version: 1.0
From: Roland Ruckerbauer <mail@ruabmbua.dev>
Subject: Re: [PATCH v2 1/2] dm: event: add EVT_DM_POST_INIT_R event type
 (resend)
To: Chanho Park <chanho61.park@samsung.com>
Cc: u-boot@lists.denx.de
References: <20230818051103.2427590-1-chanho61.park@samsung.com>
 <CGME20230818052645epcas2p48c419f6e6318ddadb425749319fbc3b8@epcas2p4.samsung.com>
 <20230818051103.2427590-2-chanho61.park@samsung.com>
Content-Language: en-US
In-Reply-To: <20230818051103.2427590-2-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4RV0l769PHz9spd
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

Tested on visionfive2 board, it works. Thanks for taking a look into this.

On 18.08.23 07:11, Chanho Park wrote:
> This patch introduces EVT_DM_POST_INIT_R event type for handling hooks
> after relocation.
>
> Fixes: 55171aedda88 ("dm: Emit the arch_cpu_init_dm() even only before 
> relocation")
> Suggested-by: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Tested-by: Roland Ruckerbauer <mail@ruabmbua.dev>

> ---
> drivers/core/root.c | 6 ++++--
> include/event.h | 1 +
> 2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/core/root.c b/drivers/core/root.c
> index 6775fb0b6575..79d871ab291a 100644
> --- a/drivers/core/root.c
> +++ b/drivers/core/root.c
> @@ -436,8 +436,10 @@ int dm_init_and_scan(bool pre_reloc_only)
> return ret;
> }
> }
> - if (CONFIG_IS_ENABLED(DM_EVENT) && !(gd->flags & GD_FLG_RELOC)) {
> - ret = event_notify_null(EVT_DM_POST_INIT_F);
> + if (CONFIG_IS_ENABLED(DM_EVENT)) {
> + ret = event_notify_null(gd->flags & GD_FLG_RELOC ?
> + EVT_DM_POST_INIT_R :
> + EVT_DM_POST_INIT_F);
> if (ret)
> return log_msg_ret("ev", ret);
> }
> diff --git a/include/event.h b/include/event.h
> index daf44bf8a83b..bb38ba98e73b 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -24,6 +24,7 @@ enum event_t {
> /* Events related to driver model */
> EVT_DM_POST_INIT_F,
> + EVT_DM_POST_INIT_R,
> EVT_DM_PRE_PROBE,
> EVT_DM_POST_PROBE,
> EVT_DM_PRE_REMOVE,
