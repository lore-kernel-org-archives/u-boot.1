Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80135CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 01:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB0776065A;
	Sun, 18 Oct 2026 01:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n1iK7DfqbpL4; Sun, 18 Oct 2026 01:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1193A60641
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792285531;
	b=LPNncGKwsORGGNp6ZPuGBAi4I9PTJ4UhJJ2veA1VeiP9ahvJffKhaMRQS08Hb5veAzlN
	 dO8gB2+tY+DefASbuLAhe5o3hXMmZCmQ4O8IACGBVM3s54MtHY/CPnhKyE0QkELIf+gmq
	 DhnflwmzjoltzczLAS0lNzXkVJUJv6PSq5+Gce69+aHXIdjpPOn7k4UAYviwbjrdoKcTn
	 y12iPlBmFsLhF3r8zxVz6FoUCDSCxBMXJZKT/TqQXSrgdhGaHQMXVFLkqLtI2p7AnXgIl
	 gKVkOWRQXAB7G38gw7DAo050GA4jELaV7ufT6KQQa5XQzLyaY0IIfxrlGgHyXl3JARQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792285531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ajcaPO6N54N1XY/3BKEhdJAzj3fe4okhxGKbcequhgk=;
	b=XSGweH4YSuIc5Soh4FAOYSzpCxmAVjbOqhBtcmVhIuBuqltDKGAg20ctHzU6U7Kllfd9
	 GkIO9CLKq573YzShR5RqBLnN5hufX1RpZesk5Nc0wTT7nNGIAmZej0cyITsqVbpI23srR
	 azgvSOvpjkRQ5rBMzB4CX6Iyplx33ro4W/l2bcS/f7r33LvD7G3kJenvC9Lok6ySPJAOb
	 BrTHLIQ3DM/1SJqCGpwKtx407Y3D89GO8eCvQX3VGe0nZ24wyW+23HwCOWJf0hgrImiBI
	 goik5oiU+HspR+8VgE8xTt4e3GXH9p5wNtVrCMe7zJOc5N32UnTBeGmvG6A17apHGOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792285531;
	bh=ajcaPO6N54N1XY/3BKEhdJAzj3fe4okhxGKbcequhgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hr6uEdIhZgv4JZwgQvuJTvp955JlUF1CgZE+JaiII/8g3lL/QK8nAf4Q3erAw/Oo3
	 atrlmUIkNpwWt5XDLZUdM8WTGMoSgsiZ2F9mO0ah4y+DZmU0r5ag5argrbAtmnJG9/
	 lYhKPAwtpkdb/Yu3vYMP/9xmJo/yZ4LtEReOjtBN+JV6w174PauV+wxM2hJjEdn/lf
	 ofHbvlwiV6l8yBw1H9OCXqddwzZzPs2rkhD2RSXG1gLY59ZXHJCCZgCAwNPgZ77KFn
	 rReockSVxbiNfvIMk3wwIo06zGhC8H9CwN4i9egMjNVNkUpwBewYutVQPBTM1xaUM0
	 IyTZX99iBL4ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1193A60641;
	Sun, 18 Oct 2026 01:05:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6492A1AB
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61AD140845
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUbp7Yaw3rBB for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 01:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B4B440844
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792285528;
 b=Wg0allw4Ro0LMwEfLdv1notM0olymXHYpHVMwewAu3t/qMPNHiV+SyCdpk3lADyU6ZSQ
 MHYdFbAOb/lu3VPCngIZJ8QzpcTI4NkYqgDfGVsWBlXKVVmo1EfoNpD3qNeGbk1JZzsvV
 8TNccu5b8W+yLKx6quRlqPOITdXlQk3WgCdvxU8UB7WQdPiAa5NMCWSyXGz1dWMJ7kkbU
 0kk9IdDPFp/IJxgsS/o7z2UI4z1f0RGV11a7I6zc4a1cvxYfT+Jr1PVUYLAqAUQEFKxt0
 LfQqRj1fLVcHvz70dHGCBkDOlTQOSt3rQFdXN/xJuHnTLP7EWnv7Pv5Gx9qvCJWDr1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792285528;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ajcaPO6N54N1XY/3BKEhdJAzj3fe4okhxGKbcequhgk=;
 b=RdEbAh0FCd1zAArYf1K1lZ56YzHO3gmZKhAL5j/RGJkCZonMwDGwZAT9xY93bg2uJzCX
 WVgXqbgzYrBxN3FO8NgmkLQwnKD5kJ4RLKbGobFd6MTsxNukVI1x1/lItTv1SqFATwsI5
 v2OFXYDZyeZT1XkDCDAg+NfAESALnhubg32ZVBVm2Mxb2FuIXR71ptt1ifjqA2HW3Evjo
 tRhLNae6Gd7s+eGbl95eSj4oYL5lCfhae83PZKf0ObT3xatDmgnW6/hilSac0hgsCHVT5
 bZlKB6yPCS0ZrKV9f7e95sEQZHCt19wtiBa7Ar9Z4khCcBZHydPJZzBzS24+sdc3KvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OyBMMNSf; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OyBMMNSf
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B4B440844
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:05:28 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so638738a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792285527; x=1792890327;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ajcaPO6N54N1XY/3BKEhdJAzj3fe4okhxGKbcequhgk=;
 b=OyBMMNSfosd/hYs4py/yozDNhUZlt+zgLy5UfW4zZ7x4TMlov74gaWwasO8fvW436r
 UichzKeGCOF4KKxRw3MGnnMub60b0hfU/XKIRYIroB+uQV9LepYr+Sl5ImsW3y0A8K+W
 GUl/hlsHqN/9zksYSM+aQxZTO4mLzmJXLSL3+LAxopvULFwz2Rq2OOBaLvMRnMl9kTBa
 X7EbrutCtObC5ylhvaYlS+AURul4qSarZr+PRkp93WToStxtQkHgEZaasrDx0I1eBqiO
 wjWSJaDWvF5RQc9Igr88W88ggWE3MjlhcJ/dvRnOczVUHvYktiq9S8zPbGP5wyTt85zM
 rhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792285527; x=1792890327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ajcaPO6N54N1XY/3BKEhdJAzj3fe4okhxGKbcequhgk=;
 b=GIpNxrPOerszyy2Dl2BIC8rOifgLwP5yk2ZvoJI/fx6DQ4C1zHrKWL9Ov/5t8dmVod
 ooVqDjfXY1CscXU+5OKof0D+DV2b5ylriIMSG7FTSz/iJF0TwQlHO9y+JCRqqEXz8ckr
 q6CHn6H4KhhOpfVvCS88MQU6IMLG0l5R9WYfvIZ91mBbuhrn02Uz+Gwk+d7uu+5o3p+9
 IDvUWt4XNG72nTwDACdxOIY9vYVY/1E7aYyx4eP37TFcZMRX7B3cO7oVaDMUA0uNtz8d
 SLjIg05qWcZvKxKbxbhjb6pou5ag5I0j+kWy/gOhiLJFvej3i4YPViZmbY47C6TwpIvk
 G2vw==
X-Gm-Message-State: AFq9FYIWYSipxMKZnswY6G6nW9tWjw7p4/HSRfWUpwNpjAtNWYA0Vbt5
 GjKG+mjQRJNyVCj3pZ1hNjwGuXwBMDMN5cQLhTLyJcexsY9QUKCA7nIV
X-Gm-Gg: AYBFou24+38PoL/P0QBc+SFU3DQThVYTcAxrEOCkdzLHoAY+8wa4ipBmRlL94kW1ASu
 2mt5atwc8g9rDxNBfo1nqBCX6pqAttacEN1glzV91r9GYCQk+N8Is3+XWiEb2pI1eQ+tMWQEjkF
 FvvLhOIVPMdn8C458OknbDOBEBJEX2n0UZL8106L/RGxf6YnytlM7SlbmW2fLZujmE6sTWn8CUl
 UDPPmOn8IAc71C3kMFdUN2bmVhbvPPsiRR7wl8+tY4YF6KamyeHoC03SblQ9CDbMVAGlbC1Gvp/
 O8gyZ/JLu4DBHA9oDi5t0ZdEaRm0+DuIedE7KXd/rlvU6+GaJqW5HH5fMVJ2EHEt/Ly3FCkc+Y0
 NZy7H0EiuLGAYAS2g/6qhTnU7ZSccsB4440zf/3HyVxxPl+Ho2u77H6yQ2Zfv4jF695zkVd1LOu
 dogQiWibdrO44zs86bpWKzdUf3W2ByDA5WjK5Nh/IkIIFrWaddeoqqkbeTe7SGwB2S0Vn3QdlNC
 fbXuXYxU/ZFvon68s9nEE7bEIt3SqM1TB/0MylmPirXoqhAnwvMDgc25sib2i+4bjTZqKNT+lpW
 /fo5FONKgNUWByL+40ExAlCa66J4FIzkdFjmlq9T6Yxy8hga6EGqIg==
X-Received: by 2002:a17:90b:5610:b0:3ab:189b:6985 with SMTP id
 98e67ed59e1d1-3acef4fb852mr3036601a91.35.1792285527474; 
 Sat, 17 Oct 2026 18:05:27 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc49c263asm9567288a91.17.2026.10.17.18.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 18:05:26 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com, trini@konsulko.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v3 1/5] virtio: rtc: Add virtio RTC driver
Date: Sun, 18 Oct 2026 09:05:20 +0800
Message-ID: <20261018010522.1324982-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atPHSR9xEbKuIuV5@google.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
 <20261017184622.3925389-2-alan.tseng.cs@gmail.com>
 <atPHSR9xEbKuIuV5@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Sun, Oct 18, 2026 at 03:06:49AM +0800, Kuan-Wei Chiu wrote:
> On Sun, Oct 18, 2026 at 02:46:18AM +0800, Hung-Chun Tseng wrote:
> > Linux registers an RTC class device only for such a clock and skips
> > VIRTIO_RTC_CLOCK_UTC and VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED, which may
> > step on leap seconds. QEMU, however, exposes a single clock of type
> > VIRTIO_RTC_CLOCK_UTC, so following Linux strictly would leave U-Boot
>
> This could confuse people who are looking at the current upstream qemu
> code, since my patch [1] has already been merged into the qemu main
> branch.
>
> [1]: https://lore.kernel.org/qemu-devel/20260831190612.369235-1-visitorckw@gmail.com/

Thanks, I missed that your patch is already in QEMU master, and it
matches the UTC plus smeared UTC case you pointed out on v2. v11.1.2,
which I tested with, still reports VIRTIO_RTC_CLOCK_UTC, so I'd like to
keep the fallback for released versions, but I'll reword the commit
message to say that newer QEMU reports a smeared clock and the driver
picks it directly.
