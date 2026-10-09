Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2761CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 14:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B078811E3;
	Fri,  9 Oct 2026 14:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cgOPK9iofOOM; Fri,  9 Oct 2026 14:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B53D3812A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791557932;
	b=FUCX1yMLLjTbQ+xRzxYDAIQmSxDNAB2Xe9a/GCeOmTu71nPCbDdLvn2y7vBWe9MmyTH4
	 qHNEvH5o/oZ+v4GS0M0E0FYIHJcEgNYBaNygKRZHiWe06RLAeNW/FwMfxoVADG6TRAfmX
	 Od7Lx6dBTtXztcWFDWBBsOdPDbjuX+ZV6lBSdkXASwKCw+8Nmj3Qe0hI0fdD/+ofMu//v
	 cqEcGA+jgM81GjZ432pi4RKV3SJ0hyKt6cbxKoDxPWrm5N8Et00ZLmAisg29oroMQjoHF
	 JJEd6jUhsoNNROTkxJjAx5AO+KzoMKNSdQAAuKy0RsgOVZvbJN8NSbW2xvTc96FZaOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791557932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bwYogZ25tlNg5otLmPgVvTct+CGKSawESnlAXzElysM=;
	b=II6tfIWOxp0LDflhz05BCXRxZ5pKDk8l4faTit2mml5jso3gO6AK9EuuD9MYIoVYhhPG
	 Jvbs/d0zrzQrsVV98l2z7xLnsSi2zuyXagjjsO3kfBrCX8yZxQ5gJFV2N9BhsLBp4EvOl
	 3i81KBTVSEfaGtNwJfNx25giLoZt+wrl1dpyKJ32KqcGxbef4QWMvAvvqliOMzZz5kXxX
	 2ywxNJtbV3NfjF8NsuTaAIGXZkb+nZVayEx9jw+cBzypYoC4EcNQsHYqxkq3xRKuE328E
	 sN4PujYB0ux4CkBFGR5X6iGt24o4ZmUjOzcS9KnNtLm0EcZJgd03fGwSF6Qc1LB8uNg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791557932;
	bh=bwYogZ25tlNg5otLmPgVvTct+CGKSawESnlAXzElysM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D4FBrbgc+CLoGZRKyy7ENZC44djTwf5K5LMBZ4YS2E7h7ktT9YfyZRWSe181MLbv1
	 kjJ9tVxbbsXrzrvPQ2tthyW+3H30ExT+C9CsOSQywh+nDNJ9R7Jis0OXTX3GFcrL/B
	 XWoAugBhZY0RcewbIwwuIu+rDYb+4rX3ew/lRpE2PHk06R/YAMQakW0pfp1be08fXQ
	 xijBb9dWB3a7l1vXlwzX9l8dloQBc6jSvPEefuUUmT2YRp4+52RYsmcWgiod03MNL7
	 S6b5uqs6sojURNUcYisuDeciExYQWKLdsHKgwAjxxh6ZsMeLMNjO+Aex9BW7+g7o44
	 bEyqPqihQnBOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B53D3812A8;
	Fri,  9 Oct 2026 14:58:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BC25356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09FE340944
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rvZxh48Ab2-V for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 14:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3758540932
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791557930;
 b=jqEvkwPdX7jBv9yLJxOF9MkaWEl5GVkBHfexIcbk0E7yPzFYFN590AfkotzD8laJmAtc
 yuOQauNSr/w9VAksB2pXWjcBhOdxKwVJkRbpDQUkmNriYJk09pqBc7CAeswgZUFWFQIOj
 HbZKc5xt2pnN4BAk38wPR+tKhg8PgdDfNhxWKp2VdS061QV97Y6LKTUY/TRvRbWFLRSZN
 L1l8bVo91T2F7INWv2TzsfZ/Q0xdY1O4QwuPIA/KB8dLs9avTZzKXsLiGs5I5629RTEpu
 d7+muc6LJSU+krfihAjOOYqQSedwYbRoR1DpdzJdieG4LSZHWxYNeTxN1khlw7J8eTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791557930;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=bwYogZ25tlNg5otLmPgVvTct+CGKSawESnlAXzElysM=;
 b=nkE7RtXZgT3VdpPMdrdiHd2f7LMHvhywkn8Ld8V2PdVmS0LFh2M+owEpvIU+NcmHckbE
 cFTE3UPfXp10BNu+DJW18ADj4fV6GxfEtnyJMzS+lZnaqn6OoQ/TaiQRqWm3pJrCyq8Ty
 /vh4eRwmGQCbJ2hUITpqx9HzRaLfOGyaofdQ66Bg7drzlWxdykCJN97DY1UhgtdST7nZC
 xGAZ7BAoWSZHdWs2cp7J2SaXgh9PEZs5u/GMS8PenrVFD79DT2JjmfEYYInt3LZ/qhsDH
 5mrwfcjCEUM7/CHvxxrdzNSOqz9W7+cJ9dpB/qq8EhBQs4BNTt5M2bnbmO1u0nYuLxQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="my/la8bS"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=my/la8bS
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3758540932
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 14:58:49 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-3550c917fd3so677003eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 07:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791557929; x=1792162729;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bwYogZ25tlNg5otLmPgVvTct+CGKSawESnlAXzElysM=;
 b=my/la8bSZf+gX41Ve5CW5ar/beDoarxp/teL+IU3ezn8rZy5v7lBDPGNxuqpSCTNP0
 1SLZlV0tKTbnt3HPFqpRdI8drr7PgL4Dlrt8LeOGUpjQQ5kpA46iRWASWMAXpm7hbJpr
 2BlaIDfrUf5hAakm8/AHTN2q8qeStakpjs5qzx1FNm8PlPuJr9Av4BwuZDVBgJ2tW+YH
 0POmVlBfgh+JzGeiZ2c5j+Mtu3uocN6d9Gf4onvO93+949OZP6TGqwuMo7fyVmkCFkt4
 8YpEkPsguXejTCAouT4Hpm6nySolx0URcXwmavb+VsR8kKz+NKLrseRZMrgYb8T696K6
 Utlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791557929; x=1792162729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bwYogZ25tlNg5otLmPgVvTct+CGKSawESnlAXzElysM=;
 b=fL25GZPvosGSuOKalMSsxaPELjsiOgW+ARJKxH5KIiAPtA0ENam/9jMzWjUm1gvG84
 SlknIpl2jrrAVQ52U+tjUl+NkBgbSSouCfDWiMVyCs7hsRAnq15px3io2byEhJJj9lwB
 JdhY0NHxHnSUeLGABlZb1qUNA718dLkPM2y2LUvE2SiTsfCmji8/X1lX/pzsyjOL3XKD
 6UHWJGNOpqf0X1H5dgi5aZyEJMH+FXsrroGO4uN2vA9bhCmzAqdhNj3tgZtOmdRizPL/
 hfCZX3R4U9pvSPXWBmiV4siv+0LglRuH/3pgtfjDq3D3KUvzCnP4VdYw/CHPosFuNDAy
 kolw==
X-Gm-Message-State: AFq9FYKSvrYHZAc9mBQ5ALjyI18arVOuiMysrLi56HvruwOp9AB8JKHI
 y1I3r6tf3PPMSLljL4977UEA15oOKtwkHR+qjuw7RjYHMbFSQyVUKefk9HFiA+ohdOM=
X-Gm-Gg: AYBFou1BuTOPjGABmtCeBHlfpOEgOSl66hgU2n6t9zrTFYirQFpMrvd4vTJhDJz6Q/T
 fuEfV9FaiZZLIG3jBHD5ai7utz3tNawpmZ2ZNcND7Mnb+6rL48l3V9dJDnGtXIThvowUVJ8s3/1
 kSrmZk+eRJYpVVUlwKp1Qb+Uhgy3pRA3eJI9qdS+eSTdXDR5uvBlLyvSoFumWSPIE44xQhqr65G
 ji3nzXhjPH6Cp1hvPhxhwwJZ3+oH+x4A317MIJmZekSI086U7ojnqxW3tHSCagkk4HPLdLcDEee
 Zd04l/iBGqtEz765So/yQn1IR9Fw1uIYBlmycvg8hs45qZSQrgrfsEXWn8hIKoH039dsGf/tZ+k
 /7Gs/b5niHlRyi3FNr59C5CwJKn6fHYrgCPGg8e4JLL6qBmSEHTauUXNTaXiq082JR3l5VjgyFQ
 5t1ULQTOh8Iy5LPZjRJrbs5GTZ1cz6pUxLU6xiHO5vo/lNvsABsrbwuPOw7DBEPfYGCVYrVgGz1
 fva/qAbqynOOfBoPI5bparxvFUcBaR/h0bqFw==
X-Received: by 2002:a05:7300:8803:b0:353:7b46:4819 with SMTP id
 5a478bee46e88-3537e032905mr3395058eec.8.1791557928419; 
 Fri, 09 Oct 2026 07:58:48 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7126892eec.13.2026.10.09.07.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:58:47 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Fri, 09 Oct 2026 11:58:22 -0300
Subject: [PATCH v2 1/3] board: sophgo: milkv_duo: add environment for
 standard boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-milkv-duo-bootstd-v2-1-c4679e726d10@baylibre.com>
References: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
In-Reply-To: <20261009-milkv-duo-bootstd-v2-0-c4679e726d10@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
X-Mailer: b4 0.16.0
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

Add the load addresses needed by standard boot. They must fit in the
64MB of DRAM:

  kernel_addr_r       0x80200000  (16MB)
  kernel_comp_addr_r  0x81200000  (16MB)
  fdt_addr_r          0x82200000
  scriptaddr          0x82300000
  pxefile_addr_r      0x82400000
  ramdisk_addr_r      0x82500000

Reviewed-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 board/sophgo/milkv_duo/milkv_duo.env | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/sophgo/milkv_duo/milkv_duo.env b/board/sophgo/milkv_duo/milkv_duo.env
new file mode 100644
index 00000000000..38b972c7b57
--- /dev/null
+++ b/board/sophgo/milkv_duo/milkv_duo.env
@@ -0,0 +1,8 @@
+fdt_addr_r=0x82200000
+fdtfile=DEFAULT_DEVICE_TREE.dtb
+kernel_addr_r=0x80200000
+kernel_comp_addr_r=0x81200000
+kernel_comp_size=0x1000000
+pxefile_addr_r=0x82400000
+ramdisk_addr_r=0x82500000
+scriptaddr=0x82300000

-- 
2.53.0

