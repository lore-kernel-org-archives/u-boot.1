Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3E3C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 12:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B85D40652;
	Mon,  3 Aug 2026 12:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I_Uu3GYufegC; Mon,  3 Aug 2026 12:16:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 242734063A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785759406;
	bh=LgKak0N9ROCKjO3XxEqlIHvjhHZfad0H9b7qEPn5cMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BHl6AitFLsnLcrYwyF6LBbiz9/RdPxoAvwaFWjOvw5+kwmZNtpEePc9f7aTy+iSU0
	 VwYunoVSCIYP4hmZQm8kmtXfKcQL5JT++uGm2TXhUyy9Tof0o89ytlax+mK8/+3hW0
	 CZchI8vegbypWC1MU8VA5OZozz1GuHn6jd4LowowtcGmHRnA6c9Gbmr+9+8YSc1NOW
	 yxypcq3/CCUpWOGh6irXR1FBFSdlynur590YNiQr6VcNwqEs7veOSbiHkFzKlBLZVz
	 4khgACmJgpJSRfONH6tp66MuTw6BiTxzTlBiKhumly7CgL5s5iNVVkTxACzU97OSE+
	 G329zgb9WRC0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 242734063A;
	Mon,  3 Aug 2026 12:16:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 431F136E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 35620400C1
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:16:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGGaCi_8eB5m for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 12:16:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CBC17400A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBC17400A0
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CBC17400A0
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 12:16:42 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-668432fe416so4105262d50.0
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 05:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785759401; cv=none;
 d=google.com; s=arc-20260327;
 b=bbbtQoV9/GwL6oQYAoC0myS+zex+AhiIWAVzLyJ1kKauYKL0ssT/te3nD9Le2pRARq
 bRr8IEdLID2g+DxuP/PU38O4U9KaG0bhbhRTgv0zk7rOWJlRxcj1fuv2n/X0v2axVQe/
 YL7xrq3j3YEkYLP7KEBz6jmF8sm3FV2bWArCwz1e0at9il6Vg9iB/x9AXA10cxvdzL56
 KeCsNz60du2tQwIDP99urqcmmCV+0yt8hkDC+V5xTrDDL7xPsdvyTeEZn/x9h8Lgf86Y
 npriBfn5wEay5TZ2P9HjvWEce0okkQIqFaCeeUf69XmBcwwlNhLMIloXP5CYsSWviQzD
 +/VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LgKak0N9ROCKjO3XxEqlIHvjhHZfad0H9b7qEPn5cMg=;
 fh=f/vaMyCG5Qv74UFk+AVmTQso3cXkIgLTJex8Yll2TDQ=;
 b=ZwK2KI3TU4q77E9YvTQqYgl/VV5pIT5wOMgXVx2zvkNlxcutz4U1xXS9Ws8DhZt5Wz
 +vAbFqCy9t81oNw6vtP5eEuwVOP5mqmTKxWVL6DCLyH61uv84pFm68FdINkUdRCGhLJp
 7bqS0XtF2HWAHpc5jGSQPjQ231mYRuANF2uoTQLIGqG9GvPZ7PY0iHig6thjl9q/fH1L
 JwNdbsxIBzGTQK8xvtZNNEAhsyl1Eza1KZD7XpIfSC5MZx4/gWBbq9pLDl+/XBfM/iri
 m+RfabNgHEmOQRV3E39/dkQsGsBSDa/oAuJthCwtSN1fItJAsC9t3zopJw+CZQctSCMg
 e1ug==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785759401; x=1786364201;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LgKak0N9ROCKjO3XxEqlIHvjhHZfad0H9b7qEPn5cMg=;
 b=DNu0P0GEg1QSeePfCJinKCJk9MNm+QrWTXjhxw+QxSq6DGUe9SX4vwWisbCw51XDGw
 fJvMEExgwTcdh76jaU6AjIEf5RFI4kDpldoCZGyg0Bm9oN6m2V3GDUIxk4XhmlumU65F
 AZTE/5yB80qgdM145qj5u7cvGopyzAZSZxQNH5EdoZdrewiE2J6kmEcSGpXGEQicBLEL
 zmhE1sHKq3UdBvK0lFhv84TYyp+KqASzpszeqirpBPffljwJwJ3R3GpEudyjKR6mAmEp
 P7/KijAWpO4ptWcW8qCftqSdmA06Qt/+rxYhireeIZc6sWUSj6zQs3JR7yalok5yaXhq
 i9dg==
X-Gm-Message-State: AOJu0YxMKGc9MvWdSW8FqDE+yg4PIOhxlFtU73CUDbPfPT1E2hW/ISCW
 tIMdcNPSJBMIOpddbTfK9jJ+TXgsUhxNTFsjj9u3FAvmVuuTKEAvVKQzJ+z4D2cm7PT+i/tIXIY
 0bjmZ3oQFD7Z3tLGjUM0HFI3LlEqTeTcckaTiD67o/g==
X-Gm-Gg: AR+sD13JKTYxr7ZR8ANRKNX/lCBVArBJcWW00C0NfJOFTyomBmiXr825gAKNgin9mPX
 j5g+fJSnBD/6mTUYMM3S+9OSaQRimTJJi9ukTFH7hNvRinps4yxeeT1rJMYEZULdCxMVc6UpF5l
 7Y2053LN8VlQqM0P9NKTTZldW6sl2WwJO4W9lrGZl/Kt0FFy3wqFjsLNVuLWJO692qnOmGUqDGn
 zvmSDUmixGRW6gdyUYsdsNm4q0x89XjI/AEtRQWyF+9Iy1ADFUuQ9oStdLMAJbLjcSn1qqxMQXv
 WMYyr6/dNeXIMoVAOT0i5/w9nh04K+gt+jRFM+6l2Ija53o3MVfzi7sb+H9/y9Tn9zdy4gtE/wf
 dMaR4AzBm6IhzsBB2iTfO16OWAbGHABG7jO8MEBhKvG4Zj6rcPVt+lJySjGZYmpoqhb8CVGGmBw
 kwu9G2gEpgUT4EceerGHJc+R1lh1ZWfxlYEs/n4LMxpUM8OVCElnChuuTtQq4mxbgOFyUrK+csq
 Ul03GFP0/YlVT5nBVlsbnk4fcFlcUjJhYL/TVUeyBA22jJoMMiRM69B5CVly4gHd96uukC/z/fb
 AjtAb0W8U9Gozp8NB3uAE2lIo2g/jxzHOwlUGuQCsGHk7HDsuEttRj1UnzeSjeWbnfxIgRCPtsn
 gJMd5Mhzpsr5P+NNyUX/Miq12SnJcNbB3DaAQMfrxorU=
X-Received: by 2002:a53:a286:0:b0:664:9736:424d with SMTP id
 956f58d0204a3-6694f2311b9mr10195438d50.48.1785759401185; Mon, 03 Aug 2026
 05:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-3-a3f1f16b53ae@flipper.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Aug 2026 15:16:03 +0300
X-Gm-Features: AUfX_mwoJpKQlySL6XU-TqqHaxCQ3HO3cwTYzOJeYaZ9_DMUUX6IPgLk0fGjZ-U
Message-ID: <CAC_iWj+ak8HWKHob2rr0QCMjewveLYHzN0GzX_AzmwGxBSx8jg@mail.gmail.com>
Subject: Re: [PATCH 3/6] disk: part_mac: Fix stack corruption on devices with
 large blocks
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jacobe Zang <jacobe.zang@wesion.com>, 
 Jagan Teki <jagan@edgeble.ai>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@cherry.de>, Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785759401; x=1786364201;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LgKak0N9ROCKjO3XxEqlIHvjhHZfad0H9b7qEPn5cMg=;
 b=SvQhR84fWPmjOWKSMg7bmwHA9HP+X+aFKpwRGKb+mnbMc0gD83+eHJ57Ic1dhOdPaP
 zu6NEaZKoHrUZgXnRmy16uJ3CgzTus64iPYQDTkqNQwPODaLdDEbrh0vs1m/FAU/QPuP
 n9MKVcr9bPws+HELT5J7pJSz1qir7W0XS3ovl8zRJ5xfkRNC+lX4kO/U9YNjKSK54b/O
 AzsdmZZdJAdYGTAZLa35+ckngnC8JQ7lwNCJXJrBSZVmRCk9UG8ogmHdsa/raR4nKn7O
 pisBFlP/jxJnHYEvExkdHCL/K8dNWruYeOReDRC477WggA/YlVP2/HXPMRCju0q1ZZsa
 gXMA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SvQhR84f
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On Fri, 31 Jul 2026 at 15:40, Alexey Charkov <alchark@flipper.net> wrote:
>
> part_test_mac(), part_print_mac() and part_get_info_mac() each declare a
> single-block buffer sized after the descriptor struct:
>
>         ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
>         ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
>
> Both structs are 512 bytes, but every blk_dread() below them asks for one
> block, which transfers desc->blksz bytes. On a device with 4096-byte
> logical blocks that writes 4096 bytes into a 512-byte on-stack buffer and
> corrupts the stack.

It's 2560b if ISO_PARTITION is enabled, but it's still the same error

>
> part_test_mac() runs on every block device during partition probing, so on
> sandbox with CONFIG_MAC_PARTITION=y this crashes on any access at all to a
> device with large blocks, for instance:
>
>         host bind 0 disk.img 4096
>         part list host 0
>
> Pad the buffers out to the block size with ALLOC_CACHE_ALIGN_BUFFER_PAD(),
> which is what part_efi.c already does for its own block buffers.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  disk/part_mac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/disk/part_mac.c b/disk/part_mac.c
> index dd3ce0be832b..f0afab65d755 100644
> --- a/disk/part_mac.c
> +++ b/disk/part_mac.c
> @@ -37,8 +37,8 @@ static int part_mac_read_pdb(struct blk_desc *desc, int part,
>   */
>  static int part_test_mac(struct blk_desc *desc)
>  {
> -       ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> -       ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
>         ulong i, n;
>
>         if (part_mac_read_ddb(desc, ddesc)) {
> @@ -64,8 +64,8 @@ static int part_test_mac(struct blk_desc *desc)
>  static void part_print_mac(struct blk_desc *desc)
>  {
>         ulong i, n;
> -       ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> -       ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
>         ldiv_t mb, gb;
>
>         if (part_mac_read_ddb(desc, ddesc)) {
> @@ -208,8 +208,8 @@ static int part_mac_read_pdb(struct blk_desc *desc, int part,
>  static int part_get_info_mac(struct blk_desc *desc, int part,
>                              struct disk_partition *info)
>  {
> -       ALLOC_CACHE_ALIGN_BUFFER(mac_driver_desc_t, ddesc, 1);
> -       ALLOC_CACHE_ALIGN_BUFFER(mac_partition_t, mpart, 1);
> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_driver_desc_t, ddesc, 1, desc->blksz);
> +       ALLOC_CACHE_ALIGN_BUFFER_PAD(mac_partition_t, mpart, 1, desc->blksz);
>
>         if (part_mac_read_ddb(desc, ddesc))
>                 return -1;
>
> --
> 2.54.0
>
