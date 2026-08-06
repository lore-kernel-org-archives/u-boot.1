Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E48C55174
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 00:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6116E607FE;
	Thu,  6 Aug 2026 00:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cg3WeRgFLXhg; Thu,  6 Aug 2026 00:53:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D354606E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785977597;
	bh=gjFYRyoNG/EsxO+wXB+65+YEyJDHQ3OtcpKsTky/OY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SqKbLSWX77L/UIXQk62x39QHCaxJV7ZFOHdjjfDwlrNL8t8PhsTxtOXeCVmYdN6FC
	 RxRfblHqHhXl/1rHmmJp8bg5w3plrvUu9klxfffKpPkNp5L3bCBQDVFxHPcQdeHf58
	 entgQnOImAzhruLKVYJW8+uKob+caBr9eayiAfGwTfd4ZbB51Kq6q/8OD9vDKjfKmV
	 joW4stXlPx4bh9WijPw2jTORLm4E/0P+qvtHat6wrVn+xUulja6yAV/2VNLCCKd8yG
	 UHukfVaswSZ0zR/WpFYb25PjbxY0rXSISJRNsQYVMLRNlGx6MeSTxS0UaeayNqP5NA
	 gz3/FQqAN9bCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D354606E6;
	Thu,  6 Aug 2026 00:53:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEF25392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 00:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A0F9C606E6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 00:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UoKlfGxteuyC for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 00:53:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AEE5460657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEE5460657
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEE5460657
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 00:53:14 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so2432236a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 17:53:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785977592; cv=none;
 d=google.com; s=arc-20260327;
 b=Q6T5rsMOs+5qDhDhfxHXzZdJZ55uqW17MVpFIF6kvX+j4UdzC8R2HAtPQCdZBDdBhS
 EeGV97eCwpDr+vP6A4WWNBEkii/DKzkyVHjLXiT9n0UEYdQJDArhb7YOOv8O6e9hT18t
 OVEvd4nGIwAFhW03Sm1dqvn3v4K0y+hK92NqVFdGqEYODwfs3MsNIcgunx49uJ/IQpEs
 AwHBRScev5YnkEXLIa0l/Y2/njGQFqkvtsnLMFGijGONees5BHYvxiWGcou6VFFc83NB
 ya6ClDe0xi2Rfkjb67l6v1x85lBUgp68cNwsvCYjljSOHMxuFIuF/diPfaJNUKsw+rb8
 kEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gjFYRyoNG/EsxO+wXB+65+YEyJDHQ3OtcpKsTky/OY0=;
 fh=6vrxFiHTpMVqMrB7zhgLECcF+aCWJa85hfZ0R47mqGo=;
 b=V5QrZpeFGHDkBs/ye4xb419xfiCH3l4o3KlZFCZrJRP9XqXje1QAY8jH13doGUXmWp
 DzTteF5kwmmhysKYVctdLw8ufcO3obIB+MTgRLXg9pug0Vq6RnAJlQ1v3A2b7iKlZn0p
 7YHUj2JMrwIGBF/zc3/2toBvRl9eyjxauu1tzzE6GHH6lUAFmdufQkYZ1y+h69P7LWeS
 i6xns8Gcn8DMsJCFR90VLLqptLC2Y7ufuhpiGEgiswatl2TuQ1mI7mL3sSWbQjVnBscH
 Ce8gVKO5Zi5gP5IvnI4WvkE18K9SW98IYq6jxY13NSjFGE5y+e5v9XV3oLvLlmGqJYtc
 Ve/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785977592; x=1786582392;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gjFYRyoNG/EsxO+wXB+65+YEyJDHQ3OtcpKsTky/OY0=;
 b=lhVQG7SCqo3bsaK7Il1Ka1dj7hy7pxBewc5FOnUHEkh6E315ICeetloZbhhGYUBOqi
 9L/CJ9qneXK6TpjVflMh4mePuCac5rtTibkEgG4/TuXBi8KmfMZbAGWvlmRvdNkinhF3
 +P/Hez+qm9rGkpqUbkBR6x82qObfD6hUuSFWStYhXJ3VcNJGXqO2lyTRmJPJzumufJGq
 EM2oAXNAQXTL+6b5o2+plL+/UiND3nE6QLrMvOcfA8i3UFOXXBtXISmw91zGxwmzn3mq
 41AFwP/hi6GkR4n1tx9ry5WUAC/M6ov3P9GIMDwLfKQzDszGzD3E3SKIQPT/OMEXyXaK
 ZwhQ==
X-Gm-Message-State: AOJu0Yz9uVHjKZRaQiU7KyfKXKhQdCdlQ2eaXxVqm8OMLah7X+/BBHJZ
 dl7PefxIr7QtLE5H3gLQLP3Dg7SA4y7WykpVpxEl0sZa7nEHzRbsenQcvbmZAGHGtWVW5IRNjS6
 fgI6g+cPZVFqO8WOZyyOXHnxUqh0fm8vtsUp1wOyBEu5vbEigSkM=
X-Gm-Gg: AR+sD13D3T2SkrqRrs8J45CbvofzEpcl4XHDEFZ4nNGnGj+/mNe1vxjD6Frh9tSFFs5
 Kvk1/1BTt5TASgJflMv7cgx1c767GKzzeHY9/FRQd/3D7zYdvW8AfMFmUZjSsYRn/B9+cj1XxPQ
 xhZSergvfhN0JXCGqiKFdFmmtE9AQWqS8WVdRD1CxaXNLmpZnwt8xKwfN8nq6ngnwZfmov81LMI
 5I0M/CUPEXULRPRYBaTNGAUlSUCMYSj+ZefT3y2QEowrS3fmg1xe7E/29tncLVVGql9T+OqqSFR
 C35vQu24h37PeVJvph/P8igziWvTDhTi/F2Gt7WV/ZXYTS/pfJPsaA==
X-Received: by 2002:a05:6402:28c4:b0:698:ad13:2a62 with SMTP id
 4fb4d7f45d1cf-6a14f09a6e6mr6088956a12.6.1785977592531; Wed, 05 Aug 2026
 17:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Aug 2026 18:53:01 -0600
X-Gm-Features: AUfX_mxj6mg3e4pKvwyVt9GgpCGV0ptA0i9X4sfXEfAnSQve0CRNM4-d_qvJm1o
Message-ID: <CAFLszTjKpeJZZ=6Nv31zKh6QQ6-9s72dZTGQiG7wiwNg+Ws8dA@mail.gmail.com>
Subject: Re: [0/5] lib: resync lib/div64.c and <linux/math64.h> with Linux v7.1
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785977592; x=1786582392;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gjFYRyoNG/EsxO+wXB+65+YEyJDHQ3OtcpKsTky/OY0=;
 b=iU2CbVUbAr3qR5FE85n/ZK+RhFuGiIOM82DkEB3VSn5R1wrmZKofy0p0cTCIcdH1+T
 lNPiS6oQyevHtM/Y15lzFxUQlXmuMO7xrua66P5UERHpBhuLGj49JGXCmPeebZZYiYBx
 08N6KDvrXeioHDDAUr8noqzmd5CLRb3l30gi0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iU2CbVUb
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

On 2026-07-30T18:40:37, Alexey Charkov <alchark@flipper.net> wrote:

> While auditing the header, two bugs turned up in lib/div64.c, so this
> series starts with those. Both are 32-bit only:

Thanks for looking at this!

> - div64_u64() and div64_u64_rem() shifted by 1 + fls(high) instead of
>   fls(high), losing a bit of the divisor. Linux fixed this in 2019, while
>   U-Boot never picked it up.

Since patch 1 has such a nice reproducer, how about adding a small
self-test under test/lib/ for div64_u64() and div64_s64() as part of
this series? It would guard against future regressions on 32-bit and
give the sync patches some cover. A handful of the
divisor-just-above-2^32 cases plus the div64_s64() truncation case
would be plenty.

Regards,
Simon
