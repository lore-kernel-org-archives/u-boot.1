Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F36C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83348403A9;
	Thu,  6 Aug 2026 13:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfbfvXUQz-rD; Thu,  6 Aug 2026 13:23:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D7F9405AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022598;
	bh=fMSB8vj0wMd2ILw1oOE9IO1sow654wqDuzLJbz6Qf7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Br0ha1QpXqwMKwcmdQDHEhLQ+b5AXgdShari4FORwAhHpB1Q+5xxWm14OkfMH+Zd9
	 5uUHqEuZy2u9EBSdBNcO1Apzw3YL2h/SkBoyFaqhjDK7X3cs3IJyzXCC6RWlGVUAAV
	 59/lB2znS8XciH6+VMzumdHO6R5nHS3Ezhh/fwlHfRNz0iX+wYqoRr3GFryoS8eTfz
	 DnlFl0Pg/K7xE+iSsZFWBsjCLqvBo/N77EP2sQW5bFqs56lGn7GjxGjeJVwKakPyrT
	 5CSY2877ddmVdWcMClWotazIZpOMAvLBzUHmoJkKuztOo1BbyXe2D5t1F6IDTw20Y4
	 d5QgEPl/XtRjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D7F9405AD;
	Thu,  6 Aug 2026 13:23:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23901282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 214E860763
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0bdKsQp4ueCg for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:23:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4AA73605EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AA73605EB
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4AA73605EB
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:23:15 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso3117675a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786022593; cv=none;
 d=google.com; s=arc-20260327;
 b=rgcN9/VgjVvaYATFsgc18eTTUWLHSlqCRGbkwHwSY5ci5RME5WCkDPmtoqTUQyXpkY
 NNVlizhd0bIJdnNX+kUNkt0Ye3KQp0BE6vWTI3UZWN5ugb+iWr6yKKuuF+72ar1/B4EO
 fO7yj/gNzZFtMFWbiJW9bgQ9DSw3dtRhVhK7mI39MAjPP5U3chh0yxr48d6n2Jkg6IU7
 jovYk7A17+3TSKR3yADOe/yVdLchB6at/8aD4V0BpIdGInRHvJ4qEgXx9OxuRVpkJndb
 REhLMKfIkoIJcG3LK+ncHwbC/RgNhTWb8WE9dAgC2ne87psdIKBWuS6wj3Lx+wOjDeTv
 Fd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fMSB8vj0wMd2ILw1oOE9IO1sow654wqDuzLJbz6Qf7M=;
 fh=glD4piGlNxos0EA+GWLb7GfG3JXAKCSur0VU4kkUAHk=;
 b=GdxDvG3kYkr2oU2HZ02V4Mzpg/pMUe2Xz/p2Yai3vXIkP7hsG3lVtfhCqC8aVXjdtZ
 L5RFFsuxJCidxJQtLQ3LMcmK937+xHs7qJlcIggvdZMCRUr3ziaionO8TVmwODpOTUDs
 n2tGFjaDI93J0Izf7Ce6erXz+h4MLaYDaQSlP7a8UfQqMGC6VKywE0RNcec+GPJgAKJK
 sk7ohXKH4rnfxxmfYWNi7CD7y6YYSUnpWYbiaKRSGVuxsRM7gtc4cSjVZYdWO58LuwBF
 vBQJ6pCz/sz4dTp6h0suOnv8gXlRE642xYlJc19G+FF3zJCT2UyO5KFfuAUyDjSVjn8W
 A+FQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022593; x=1786627393;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fMSB8vj0wMd2ILw1oOE9IO1sow654wqDuzLJbz6Qf7M=;
 b=daLwf2+hsMoArhnwdzEOuy43MZh2EUpeKWXhbR7I4bD8UtAEWUtmcHWW9g9BHEFCf/
 iZp6SVatimxlzSwiMHeTXKGo1LTn9kIxSa8PmGnhs1Z0R8a2gswbdB9/CaKpnMPouHCm
 LHIZLsJBeOZnJ09JEvEvkUkxeQiwb67B9iuKwHMcVGG+WYGrZRpIiZmlnifOxzOtntG2
 x9zb9cUlQlGTQu3u91gJkVoXB5IeIhh+a2D/2WEWIrk4SAItWIct9GKXkA2UFUsOkEe7
 Fj+2CsowzY3NlqH3NpIDnvBTdPYzIjbuLEl5FsL1Pim3NQVgdrnENc4FKsR4FN+Bi5BD
 K17Q==
X-Gm-Message-State: AOJu0YyNp0c8hwd8CqTZEWlvbN7aRg6PNJCEe0h3i/Wu8M5OY+CrWyUY
 Wb0sPMxLQE5RIhU6wMdwxgHu2v45TaAMj6PtE9tQHFBK1bGo8JV3+NmNO6vDWTob1rFHtj4n8Iy
 vl1LPDyBbbw7Sr7frPE/Sk8/jYoKqSadEIeKYZ3TR
X-Gm-Gg: AR+sD10HXVN34OvHAuuk5cD87xTTVfWdS7XAIQXkY7bjNFfi35LdibGFpI/FHTpWEuP
 jf9zeTudrR/27ISML2/zHkw8IjZJpVeqgrv/w8tuKGsQGad1mLIoceI4ilu565WXJKy1WT8FNrz
 hsWb3fSCemDGL4A/exQPQZZNgKRYyLbOcQHqLQ2ihiyzEZEDrDxsOZXGxdjCU4xtqo8m216XroA
 Od1EVDEYnih2rSmYu/VkG4fVt66y72t5hZ4pmVexD8hVmD3RZDbb9SlfFDk3DZaqgt9sSFqUGNb
 RdeA9wcIpWIZHlvSgMNPcqjs2zDiUvFZmatxvFcEW7nQ
X-Received: by 2002:a05:6402:518f:b0:6a1:8ec3:766d with SMTP id
 4fb4d7f45d1cf-6a1b4bad1f5mr718953a12.19.1786022593177; Thu, 06 Aug 2026
 06:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260806103720.1026454-1-aristo.chen@canonical.com>
 <20260806103720.1026454-2-aristo.chen@canonical.com>
In-Reply-To: <20260806103720.1026454-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 07:22:58 -0600
X-Gm-Features: AUfX_mzAQfTssZ3sTHF_9dtqmyEGlbSpLRi7Renq9ElANmVtNaTaRhOckelyzv4
Message-ID: <CAFLszTiGOfixhO=dO7XtF8yXF4bXRnYghHZx1n6y39UpwhKKXw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite
 decompression
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786022593; x=1786627393;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fMSB8vj0wMd2ILw1oOE9IO1sow654wqDuzLJbz6Qf7M=;
 b=XpYJPiCkOtY/0lpbKqbtR1Mb1549aAkP1hORHkiedbHqrbaeUaEaEIZ2Cml7W55A1c
 QZ/41TbKF77ni8A/NTOlfVBSJ9+nbbft92DOVHQycWLHi1G+fShmT2ZTDP4kxqtxxsgP
 xQmL5JspO/IK3OMb0BbRHHFj7ZQzpbLl6clYE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XpYJPiCk
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

On 2026-08-06T10:36:59, Aristo Chen <aristo.chen@canonical.com> wrote:
> gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite decompression
>
> The chunked decompression loop in gzwrite() treats any inflate()
> return value other than Z_OK and Z_STREAM_END as a fatal error. When
> the current input chunk happens to be exhausted at exactly the same
> time as the write buffer fills up, the inner loop calls inflate()
> again with avail_in == 0. No forward progress is possible in that
> state, so inflate() returns Z_BUF_ERROR and gzwrite() bails out:
>
>   Error: inflate() returned -5
>
> Per the zlib documentation, Z_BUF_ERROR is not fatal and only means
> that no progress was possible; the call should be repeated once more
> input is available. The reference implementation in zlib
> examples/zpipe.c continues in this exact situation.
>
> The failure is data dependent: it needs a stream position where the
> consumed input and produced output line up with both the chunk and
> the write buffer boundary at once, and the inflate side must have no
> buffered output. That is most likely with incompressible input, where
> deflate emits stored blocks and inflate holds no lookahead bits. This
> is how dm_test_cmd_zip_gzwrite occasionally fails in sandbox64 CI on
> random data with gzwrite_chunk = SZ_1M + 1, stopping at a multiple of
> the 1 MiB write buffer:
>
>   12582912/16777216
>   Error: inflate() returned -5
>
> Detect this case and let the outer loop refill the input chunk
> instead of failing.
>
> On sandbox64, the random data dm_test_cmd_zip_gzwrite test failed
> 17 out of 2000 runs (about 1 percent) without this fix, every time
> with the same signature as the CI flake, and passed 2000 out of 2000
> runs with it.
>
> Fixes: 58e523fedf48 ("gunzip: Implement chunked decompression")
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> lib/gunzip.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
