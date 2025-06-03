Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD7FC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E1782A76;
	Tue,  3 Jun 2025 17:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ufX7eh3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96AFB82A8D; Tue,  3 Jun 2025 17:02:31 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5905B8091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7300069c447so3859582a34.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748962948; x=1749567748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WcXQ7dzsls4wNJ7L4ov9iCxXcWObyNy/2eyhdHeEfpM=;
 b=ufX7eh3V3uK9GGNqnVX9LD4QCfU8kDmz8rseZ2OQgdGVOmrA2ufxEvD7SwO9E5CDt/
 TiUKpaAgbxKax08Tx60kWRiB+F6bpx06DzT/COsbtX8aaq/bG/53+ue8L8fZLlWgt2Z7
 RFkLB87ohwLnzc7NYQ0UVfXhKfB7WC9Ap0ZDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962948; x=1749567748;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WcXQ7dzsls4wNJ7L4ov9iCxXcWObyNy/2eyhdHeEfpM=;
 b=dtfzCGrMFKXnLggn/9fRXBpZ7HmJOsElUhGgRl4RA3n0brcFg52qf8X6s/rdIUjeWB
 N8BbRckZvia+8w7CPLXDB6CCC5uy18iip/C3j9iNSnSyF96D+NDQfj4f2OVLKk2fZD3x
 TC58fKtWnai7V8B8OJYzNlfkhKFi5vmKCfyiUo1Chf9k770htRi2TTlQUKvNz2fO1fqm
 /yFR03pt06D9yc/eW5foDcSH8APxrpaS3VbhihcCkOj+UBcadhR0JWpOtiLS36MoKYsa
 RognLVw6DzChOrWVvV9C5bTdWZlTK65/j+FYto9C4vN/1oKYjJvYxCxIkQGFKI0UAKMn
 tL4g==
X-Gm-Message-State: AOJu0YzhCCBHhlR5muE34FyicgxbpwRVVDWytWE9oBs3G3NFEUnpMF+Z
 yHnUCLZHvzHaBl16JGUwtQJ83apWn221JAwD8Wv5QH5dV4qfv7+0wcWRlVHiVmnNm37b4CxFfeA
 y1Sa1DYA=
X-Gm-Gg: ASbGncsqKGGGf0hnni84HGJBpKzlrJDBPAKN/oUNwW4HIViWdSEPl9tFvuLTQGTpagh
 w4bydyX1UkuxdpP9pgofeoni8V6XznVXuu27aRrBtw47XyXhH49WG5lUf0r5NQ9kPrzjO0QrpcT
 oP8Ufb7fB/1ZW9l+Zn775RBybI+p6w6abE2Gparyf7eeMmfbgpaK/vcJR7s58sBmPhFQtejSuCU
 wu5MhAq7iksAU3J17xtFBnk0v0124vghZ98TVL6vKQCeFa8W0zoN+5gp64PY6bOYmIGJw3RvtpO
 pi/l//n+Dk1hCLhfg+c8NTav+4SjmQomTgiv+db7U39gnr5z24NZPeqyTPll8BSxpuhg8Qv/98e
 a2sDUzQxKl3Y=
X-Google-Smtp-Source: AGHT+IEynjHYy0SAhUBFMzfCP0nwqELHLocqAfMqst+FTo0DJ7ANTUd8xe2FWYuIINjBUutbVfdUCQ==
X-Received: by 2002:a05:6808:3189:b0:401:e5fc:e726 with SMTP id
 5614622812f47-407a66154a7mr7829727b6e.31.1748962948126; 
 Tue, 03 Jun 2025 08:02:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c42c16sm1863229eaf.7.2025.06.03.08.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:02:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
Subject: Re: [PATCH 00/17] Audit include list for include/[a-m]*.h
Message-Id: <174896294644.1467258.17289128694723315601.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 09:02:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 21 May 2025 16:51:05 -0600, Tom Rini wrote:

> Hey all,
> 
> Related to my other series I've posted recently on cleaning up some
> headers, this series here is the result of at least lightly auditing the
> #includes used in include/[a-m]*.h. This ignores subdirectories, as at
> least in part I think the top-level includes we've constructed are the
> most likely places to have some extra transitive include paths. I'm sure
> there's exceptions and I'll likely audit deeper once this first pass is
> done. This only gets as far as "include/m*.h" because I didn't want this
> to get too big. This also sets aside <miiphy.h> and <phy.h>. While
> miiphy.h does not directly need <phy.h> there are *so* many users and I
> think I had half of the tree just about not building when I first tried.
> It might be worth further investigation, but it might just be OK as-is.
> 
> [...]

Applied to u-boot/next, thanks!

[01/17] include/ahci.h: Audit include list
        commit: a510bc2c9a310a6204b4587c8c2c2e0962380e31
[02/17] include/arm_ffa.h: Audit include list
        commit: 6a891bb78cdc0f920bcae700af26f192421f93cd
[03/17] include/bios_emul.h: Audit include list
        commit: 377c75f8c5588126259ff82bd33eaa3090853cb8
[04/17] include/bootflow.h: Audit include list
        commit: 48703b2d6b7c87a523e794a711fe5c0d86f15093
[05/17] include/bootstd.h: Audit include list
        commit: 5bbc8b5c55102145ba06bee4cfa7276f293d9c31
[06/17] include/cadence-nand.h: Audit include list
        commit: 5d14fca77af7f2d4d950e0656329b03b9f5a2525
[07/17] include/cbfs.h: Audit include list
        commit: ef560b42ec1f5db103ca8be8c4532c55ff0151f3
[08/17] include/compiler.h: Audit include list
        commit: cad8e2033332c1693d03fbdcb1c07f788974c2ec
[09/17] include/dfu.h: Audit include list
        commit: 1585d92a05517f5f0278dccb8d0a03012960d790
[10/17] include/dw_hdmi.h: Audit include list
        commit: ddf050a5d6e86fc2c8c4ea9bd47915ed340e412f
[11/17] include/dwmmc.h: Audit include list
        commit: 8f3c64a53535b6bcc7b63a6cf9531a6dfddff5f3
[12/17] include/efi_loader.h, include/efi_tcg2.h: Audit include list
        commit: 40d5f553316eba90a893a58c12c098da74dca335
[13/17] include/fat.h: Audit include list
        commit: 43d76dc7df600b10cbf70753750bf87de098b210
[14/17] include/ide.h: Cleanup usage
        commit: d81b57a3cc881569d18014c0a8806e163066fd77
[15/17] include/mmc.h: Audit include list
        commit: 2cf46de9b6b8463033ba4f9243643d004dc9ea5a
[16/17] include/mtd.h: Cleanup usage
        commit: 2266595bf893edb07331ca8464738e0d4c82c129
[17/17] global: Cleanup usage of "ETH_ALEN"
        commit: 824f8f52a1e44f6d281d3f89f23b3e85824a34fb
-- 
Tom


