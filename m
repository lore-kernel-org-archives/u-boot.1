Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB0C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D69F0606ED;
	Mon, 20 Jul 2026 18:05:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETBH0iBEFjjT; Mon, 20 Jul 2026 18:05:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4371C6069C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570710;
	bh=QGy58yrvWeUhzUrjBOowTOL/rOZaquqLiydKW7bU+c8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dW5BeqOE5+DR6muzESROWuhQlkJT4/CflbpVmGJF0GZmEUqGygEaMqm3wQ211vN1S
	 ludbrcZrf5NeLxUoQZYsPFti3pU7ZafT1lh/CH60yVXAsIm1+aAjI/zm5If1uHqkmO
	 r3OaYGWziCatSk1dWZr6gURvvOTuEBo5HeZdGS0oLfZyWTWvvHMShHqs4TaNTvgLu/
	 Az9IKLFJpIXwAAArVqWWqSv3HnmBvPBa5MCjwtpGf30KoHBd3qzboXfRxfC93uEvRT
	 G0nm5Cr4K4VMnrYj7Nos5GoUC7N6a3ye9GDqwjVda6kGrHL8NwCcvxqXdm1ehP0X2c
	 FO+cwx2+nGBAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4371C6069C;
	Mon, 20 Jul 2026 18:05:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A207313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BF2E40015
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2MdLnStuWDjo for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:05:08 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8F7CB40081
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F7CB40081
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F7CB40081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:05:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05534842FC; Mon, 20 Jul 2026 20:05:06 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA26980433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:05:03 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so724382566b.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784570703; cv=none;
 d=google.com; s=arc-20260327;
 b=QYQ8eITmXwIU0ZFjw3GwuBcPopwgk92CDWCeb+fB7NY4kevlFIn5DWvyzrTNHdUnP1
 s+xJgjcCOc2ZUkAWTl7u0aSZik393Fa3dUbq9oOK16KLYyvlLdvZxoaw9tlRvJnBpcZK
 r7w3uLwpkTwlsKbds1t/qGWfem9qfQyHhahFSj/+e6/obshuyV0+8UzdydV3oDoyoS5y
 VAIr7lsFWXLjgfwKBnOYf580mfszh2yvSxaDzkDKQiAuZg8j83W6C+0+bIMiNlpXbxMM
 pKWgYiPj5MDhV3PJry/zGnTBPQXIS61RaiNvJ+9DF6hC8MfKgqAui2LW3I9tcA7Bk9eI
 bEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QGy58yrvWeUhzUrjBOowTOL/rOZaquqLiydKW7bU+c8=;
 fh=S5IsS0p2q/mDhy6CofKU3XdI4SX18ALJnocWEeQR4Xw=;
 b=RLM8tWDBah6voDFapHtHBZEj2/HnRbM+NI0aBOjUnbCa9nDdbS6zpMBkCOXfecYi6q
 35XQR4lNhaRtmrCJ/fFzwhjWdosnUveKnArN0r9NSWXjwcb0K+r3RosokTQ33+dd9Adn
 GkVjsp1pQCCamoSubHNAlUqt52wO4ed/lNm2n40mAwCmAoIa3wqo3UXltj9H1vpjNcHT
 8vTKR8qQVykItezb1kaf876SWojm5kVhl+XYeSEwV1Ka8NgMu4iuZkjQ6+4WUSeewFPh
 3VhKUfaIOZILzvaQoGOiL+WMLXvXILf2CtnaWQPM5X9DvKK424RC4a5w0f3Q7TMsaT6n
 zAKQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784570703; x=1785175503;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QGy58yrvWeUhzUrjBOowTOL/rOZaquqLiydKW7bU+c8=;
 b=SesJflX6N2+fJuA34KlBLHXXJn8qx1n7v4DFiUD0xAnEUmud2XjCl9APtCMMxEXHKm
 MY0u2w8AeJgZtUKqUxtDrStNP5lAr4/jw/FrbY4FSb2yFlpz4kBOYFlFix5ZTO7/wlZQ
 qaAy1wGrtT8apCqcPVdlxP1QH0iqWDpKJ3QV6EGt1yCnqOwJFQPpLIycbD2XTa1Jn6HS
 NKsgnH5UZ205STcHc491KZHSpfQeI1U3RH4tQ/aokTGmGej1lO5O2Hxcw3FkLrWv4yE3
 RPpUrxllOn5a8iIo0ddTnIyqRTmz5WTvEK/7AN8XhAWX3frFWkweNDMdA4IBqxJRDqLf
 EgyA==
X-Gm-Message-State: AOJu0YxfndAjGh3hY94ndXtI0mHkAJHL8oDuZoNxAKyV1krojDXWpZcf
 4RCnP9pxKa8hn8mntVn3Jx6Kofb9JMZ5EgTcguf2fBJX3VCZ+tfDmtFFOUzHLtf3PGdk2bGXA7X
 ybFwRNtH+p2nWEIGEJT+tjzJXHPz8GlblWRsgyfOd
X-Gm-Gg: AfdE7cnS+iwI7zRXXZW+jZaNI/9lMEZ75gGOsqTGbVc28V4NRvUu5ubScYrnoBwA7BY
 RDA8d8I8DiC3KWz8DDZI9kqJNLFJJXYJinN1oC0LWLMZsKN3Mx2IkA2gkWRIdHbw1Deiizmbyu8
 9xJJeHrUwIhLdDETA3kJ8iKjmp0REPPeJGRLgpquGuj92M+4dL/vFKrazQHv5ZKXe7da1D8Rb+W
 EfX4cjzzy9yCyxTCNTBwqJyN0hbJIJdOrzRnREjGpzZNOdodnVZrVDLgg+RcqWiT51OY64=
X-Received: by 2002:a17:906:f584:b0:c15:ee17:47a with SMTP id
 a640c23a62f3a-c16922d7b1fmr1024458866b.15.1784570703121; Mon, 20 Jul 2026
 11:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-1-9d23aa08f674@flipper.net>
In-Reply-To: <20260713-rk3576-boost-v1-1-9d23aa08f674@flipper.net>
Date: Mon, 20 Jul 2026 12:04:48 -0600
X-Gm-Features: AUfX_my6kqv_FSXsF5uySrnBKKpbIatsbUv6AB6utUSpG22W0oGjrTFM0fPjiQQ
Message-ID: <CAFLszTgWpej8Z+OhmsYWQoH+61BkddKzotSvdhDYLqsOG9kt9Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] rockchip: mkimage: Split size_and_off and
 size_and_nimage
To: alchark@flipper.net
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784570703; x=1785175503; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QGy58yrvWeUhzUrjBOowTOL/rOZaquqLiydKW7bU+c8=;
 b=mQDbqdFYO9f0V9Tt7QP01CgxClMyywlAtTgOdiKkv3qgAwCUxYll7Wpo6RtYlh27aT
 Tr5synjSucxhCIVUA+/kPdd3w8hpPQfpXmGnSXEVPPcn5T2PReHTSxi3B6VzrHNDlk4o
 9zMtQQF40gBSL5GQvKymBGwgrdKT9Z/urVgLU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mQDbqdFY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="mQDbqdFY";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 2026-07-13T10:02:41, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: mkimage: Split size_and_off and size_and_nimage
>
> Split 32-bit size_and_off and size_and_nimage fields of the v2 image
> format header into their own 16-bit size, offset and num_images fields.
>
> Set num_images based on number of images passed by the datafile
> parameter and size based on the offset to the hash field to fix using a
> single init data file and no boot data file for the v2 image format.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> tools/rkcommon.c | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> @@ -370,6 +373,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
> +     hdr->num_images = cpu_to_le16(i);
> +     hdr->size = cpu_to_le16(offsetof(typeof(*hdr), hash) / sizeof(uint32_t));

With the split fields the offset of hash works out to 1536 bytes, i.e.
384 words, matching the old hardcoded value, so this is a nice cleanup.
It does rely on struct header0_info_v2 having no padding - fine today
since all fields are naturally aligned, but a static assert that the
struct is 2048 bytes would guard against someone reordering the fields
later. What do you think?

Regards,
Simon
