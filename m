Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A4606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QHmLHvxs;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=EbcFHNEp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6073B60677;
	Wed, 28 Oct 2026 07:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Y-517GhxJqV; Wed, 28 Oct 2026 07:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 712066065C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793172957;
	b=qIxSuebpNkzz/jNHksI1PAg2CmMP5fmSguRdArVhej7JBLoRi8JReViv2ocfmuYgPn7G
	 VI/nNWcfGDRpywW6xyA4Nc8sny7bhpkFb9OUMAycEOVVF4UAWxYFUSE8rjXVwmGR3P8wk
	 +FFCcEBOe3L3CnRepcdBH+2rDE5yRsQpstN4+KQnUZ5UVEAO0rajJst7YWF+fsej+IpTa
	 ZnvfkFr1DdQvCSrQYPo+UiNq8RWI55mKRcEHDJsNwJAoDA+6wfrbuXUzcQf+oPn9rBsne
	 ONHkpDTwx8ZEsIcTImwPYoiuuNPOmFbCAG1PlhRzOBRO6n5Ew1sOJWzOZaKvNmLgzXg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793172957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=P055YNO8rO5ZDCwmIBRoCom1DQrTfIu/boVMzOXI9nY=;
	b=f0D+dNuOn5UH9+T7xdrlJJWM4HbeZmC1A70NAgAMEu7KdVHDIySShMKuDgqKKo7NEIWv
	 XPOgnM47EwvkCk9ohlwWL+WN4zL9WqbH468h8Ace8sa2ArZO5iTuUY2BgjfSiaq3W8BbV
	 TVcS9yRzeul1n5urYQreCcSuS7QBvNwsB+ZOQ5lkWpFoMFfeffat1b70lm/e5c94Nxlgl
	 8lR/zI8urA95obekuUfyZ/sTx8N0jcmWrpBoYDmjXG0hBlXykAJyjCpEX2wVYER5pBZum
	 h192aepxNFQ+f/pi0MfBD4Eygkit2kinzZ/QKtHTstQHLG4pAQWqMNx3VW730LmAv/g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793172957;
	bh=P055YNO8rO5ZDCwmIBRoCom1DQrTfIu/boVMzOXI9nY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QHmLHvxs1PqyaB6XNQzZ7rTaDqaTnWC/QVpclFkREEolenwhvfISJKn8K2A6+qPFW
	 QIq7I6Ykh46j/wIdu+UsAADmpbMwWhBGWlerVFUshhBSqo0WKOzZOMJO0u0uHZ3s0p
	 P2D7n6NiR/m0uqD2nOaf/YBSKWWrtGRbhOHOCi9amsFUjjPDTjZElDvJD5qOiCWyJ4
	 /afXspUn9rOtBDKiGj8832WsjYfhC0AYqYdCOUFu4NNvSS+WC0lmLT50/LyMOmm7ru
	 4q2UxDbmlcUjkR1PvUUTrWwitnh8ONFb7lAtWFs+sDrxiB0nyeBZbhSpXRGukYYtKf
	 gGZKFaE9Y81Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 712066065C;
	Wed, 28 Oct 2026 07:35:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F1947D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E39A9400BB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCTf3ot0pfkX for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:35:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F5014009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793172955;
 b=dtH+4yVnKvpNG75mnCQksJP+zhuFpV9dsvytGayulynSXgJXv8h9Pjx4OyPmG5AQg/bB
 gt/AZAw2IB1F8BkLcjC5lypSRNIDSZBcsdfc0lzLNtis0Msp05R8p1oMgLJCXx/X46Y+O
 OSYRF9Px44dPOcQL/4CVHkjxmNGCMTuVRJXGF0HmthLcB3w5aIDp2EC+/Q7GLPLJTwTkg
 kJ62jIHSv2qJP4FYZW7nMTWLMzqulQ5WTRDOce4Yglrv82UMhlRFcCLIGK3qwy5utQqjX
 +X9xFa9mb18M0USdLnz9sz7HOli2mhTNk6Z9xeZB+eAy8fXRqrv2DGAx5tbf4KNa6GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793172955;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=P055YNO8rO5ZDCwmIBRoCom1DQrTfIu/boVMzOXI9nY=;
 b=UX/ln90FcNNn6FDV727YaInHjdcaWn9ear+xU23mm3AzCIxF3+1OTA0AehXXmV5uc86D
 9Cqbj/0EwZO0Qk/rBSODrHHw/hBEhKpUCY75deLe/CyqooG5msPwgn3n8EkpBJnkDOTQG
 E3JjlOtHEK/ohbY3mP0RBxnGtK4KPYMl0xZ0/AWDqksW6gKKyduRYLp+CS2ujH6ylmJyh
 xpT/T2vo72MGM8tDly5i5b95GoTF1PFF+000NMbvuC5pEhpY/MbReAAd/GbGt2tSyxVVN
 0M+S3b/wmqvy7uyKouLzmDebomqy9b3UxHslZoHLpLdBQcAo6ctLmxcM7o2FxFuErSg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EbcFHNEp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=EbcFHNEp
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F5014009D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:35:54 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so1133659a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793172952; cv=none;
 d=google.com; s=arc-20260327;
 b=Nrtqn7ySLXuSfWYXzihpMXzXsPXAcS3uopwX5X2W0SanlEnuvpxaKR1RwuWMG1EOhZ
 1sdjw6XTHDyZP00jCqOrT36+MHhvYEfj/O4lEAokbK/g3X19vLZpSSg5Hm62IaQp6fAw
 ed1timd+uKiV0VAjwm/f0t+noW5eCv8fOCBqIBp7XYtsru9pTjb5442tx07FkcNeMPGh
 +o3nRIQnYnVgjAp/2D+yZ85Z1K+X2irbC4fJYayNRmCOG6cQrbZZSjGgjaExrqtNrlRM
 Sg30Vzm0lRxkYZgxwcErKdUPyquK/zwnzYK7yTMqFMYyY337uFYYbjz6eTEyUqZreYSz
 YJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=P055YNO8rO5ZDCwmIBRoCom1DQrTfIu/boVMzOXI9nY=;
 fh=Yq/PKX3tRE1MVADjRoc16zl5WJQ8FuXCBbvoZa7nMko=;
 b=Z8MPYBffENrhlXITrcY1T47UAcwonLOrFGXm0Ke72uhP5QohBv9vCYRQSoQzBPTidE
 GScV1uinmJBqXpQ0Q+e5BNuvIxvSKUrO4PdhesZZ+2SyIYjPaMjFVu9w+kiu0+vjSX9Y
 hf8ZKGie5U7UgJuqfIGEH8mnHySSasKv68wQcaofG6r3EDvkDq8o9ZRfvGd8zVaD3Ib1
 4PAFmxNQBJ5XQtziCJTPC4MdcPYjuYb5aE6o25CI5mHQJqxQ59POd2xePM3HNq465YOt
 U9R89krYI49m2VhNBn/fQspZJnXPyf/FHjMSHVO5w4teZrzJrazkUBGX3vLmBltU1mGo
 /r8Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793172952; x=1793777752;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P055YNO8rO5ZDCwmIBRoCom1DQrTfIu/boVMzOXI9nY=;
 b=EbcFHNEpgvudw/noiDXh0LIbJy/rDPptRRNNRAIEsdKYqII2FVDSuc0tH4AJCpn5pK
 wFYyCgUB94pawQt5jgH16pvNJyshCMHzlIkaUHXmFNGjA/WwvpcPnI4ISPUqeWDnGg2l
 zyJSnTCCXaEVSCO0IfVhxJ5TTkN9Wtl3/NH9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793172952; x=1793777752;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P055YNO8rO5ZDCwmIBRoCom1DQrTfIu/boVMzOXI9nY=;
 b=oq1UyI8/njoOmr5z99vMTlTZhIlslVIJdlxVyjC/5V8OEIPrLAwaFrqOM+zQc14ZQ8
 Hzb9h9RZDvmky/n2xdgXEoFml8QxBmrNw39e8XOciVgw6u+j7+nO4fbklGFa0JTd8529
 KCbOQ2bqTJw2F76NjMmJ0F1+mr7hfW3KVkX3LCpWvX89QE4+cOTa7PmA/Ltl2A5oCK7A
 fW1H82ZDhAdeJHkhbGjJfOw2av6KcSCAMtO46QmnaVqmubJcv0mGhSZpKDoXMBzyh5Xm
 b6EJUFPL7xpmikSNDL+SW5I+wUSPAPMH9S4cq0JF6iwFvuJbR2197+k841lcqY8wP0O8
 R1gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxqu2xExpOdwEOM+F8Nf4v9LBJiEVnKgZU4fZx7FTTaklskw+30byLG5Uxl3a45Dj+BJ2489oo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKT3nDiUggcvnO0Q/fCsiE3kT/aMMHSQvmmVjDIaVWevwutdD4E
 CMXf6HuzUQCIkRzzQtoGDEEqz7rxvOftm+jrlnVNyJCMVFFfPc475+Ci7+dhGlETS1zmU8Sq92a
 RRs2LFfnjT7lpnzi2gA8oVUO4inx6qsKkiw9PSWFD
X-Gm-Gg: AYBFou3FXyksUJ6Q278xHd0vFTXwd9RFqKCGDsdVBu8R9Ct84p+Sq8ZA1UH6mIG6eT3
 gKEXXMi8QIDnzMdXj0ddkB17Oh3XfPB2/ZYBmdr4i8UYBbQZ83hIHOb7MDOFJvb828lUqmzQuL/
 te42FO+wjlV/mSnHuNibKDdoFHulxzHgw4gdxSDCZ3zZroCuVovCjcsH8bms4aE2QDNzSYbx7I6
 wVuee5ezeejMM/U9qUoPOzaaG1/9wvKZFROpSfcVq2Vfqdjgac5mgjtKToGwanIkyyBo87sRNRq
 VvwZppfA+511Ahzc1TZaMAv/FzxIxzRZzBgTEO03G0SNLUKmqpDTWoMFW3W8jk4EDe8U9DUwc+N
 Vd8kk64puAUmg7JrvTgAxxU0ptGoQ75AuxP6g
X-Received: by 2002:a05:6402:270a:b0:6b3:f12d:c6 with SMTP id
 4fb4d7f45d1cf-6b49cbf6db0mr863132a12.23.1793172952448; Wed, 28 Oct 2026
 00:35:52 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:35:50 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 00:22:31 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027143845.1246876-1-oss.patchbox@gmail.com>
References: <20261027143845.1246876-1-oss.patchbox@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 00:35:50 -0700
X-Gm-Features: AclHuK9buXulpij7aOCJLxTmeXncA0QCMW-ageNa5vsylswhdhK6KBGIrUjSBxY
Message-ID: <CAFLszTiAeyEDR=pJfAbyBuD+2XEET1Lv61n3QB2WYYi4ZbYPHA@mail.gmail.com>
Subject: Re: [PATCH] clk: Do not disable clocks when clk_get_bulk() fails
To: oss.patchbox@gmail.com
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27T14:38:42, Yuho Choi <oss.patchbox@gmail.com> wrote:
> clk: Do not disable clocks when clk_get_bulk() fails
>
> clk_get_bulk() looks up the clocks of a device one by one. If the
> lookup of one clock fails, it calls clk_release_all() on the clocks
> already looked up before returning the error. clk_release_all() calls
> clk_disable() on each of them, although clk_get_bulk() never enabled
> them.
>
> With CLK_CCF, clocks registered by id are reference counted. The extra
> clk_disable() is ignored while nobody has the clock enabled, but if
> another device has enabled it, it drops that device's reference and,
> if that was the last one, turns the clock off. Without CLK_CCF, and
> for CCF clocks that are not registered by id, clk_disable() calls the
> provider's disable op directly. A device whose clocks property names a
> clock that cannot be looked up, e.g. because its provider is not
> enabled, can therefore turn off clocks listed before it that firmware
> or another device relies on.
>
> There is no release operation for a clock that has only been looked
> up: clk_free() had become a no-op and was removed in
> commit c9309f40a683 ("treewide: Remove clk_free"). Therefore,
> clk_release_all() does not undo the lookup, it only disables the clocks.
> Return the error directly, and reset bulk->count so that the bulk is
> left empty and a later clk_disable_bulk() or clk_release_bulk() on it
> does nothing.
>
> Fixes: a855be87da49 ("clk: Add get/enable/disable/release for a bulk of clocks")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
>
>  drivers/clk/clk-uclass.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
