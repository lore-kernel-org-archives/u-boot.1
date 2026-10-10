Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16FACA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 12:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85A8681359;
	Sat, 10 Oct 2026 12:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZolQGKdRts16; Sat, 10 Oct 2026 12:21:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8ACC581329
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634881;
	b=eMLaWpEA4R3UKJtPLOKP6YvK0YUBCZa1LJ5ElDEMH36KIa0ZdV9TMryYgfxeTWoLxvt0
	 u9qwAmHsX4Ym91/crt4L61rG3Jkugsbw9y7u/wjRzJsvxw7N2i/ZRHabNw2pWV0X78sfe
	 VOK1kaNu/RHpzOmyZV8qIYdy/QjxCK38Xo/tji6FZUgxqzUFWjH09eiy6djatSb6BOaqL
	 DoZ1UPywC06yRO8JZONmQrFCj6RiwUFvr3GPE921l1YVDYiTby65ea1ola0PeAYtiBH/R
	 1hAlDrDoB39nIbp1JZnms6Dj+/JambVrBUlCQwwg0WTSTyKzfXk2krgqWu/WOZlX4WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:DKIM2-Signature:
	 X-DKIM2-Info:Message-Instance:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8lStNNkLAXUfx0Qk3vJLrMRYLaCj8dnR4qwFp1vdHhU=;
	b=bdx3lRz5z852fvI8jvAoh+j3xsNxbhMJJC9d7MkUaX51h9GUEcQOzqpt85brxsa76eyT
	 unMEugDVK9jI1cqdgWawWeUIdW9oS5VeK6SMiMQcJ/ht5Ubbh7CzHeH6JJjn2bY8mtGTO
	 8izHg0Vp6qJHvJ4oEI6JgpPrt67+4wBTTwAjLcI46PY1OShUoAD+9N121Pbpu7VwqqsMW
	 yv++mVvNiU0YyDUHaLNrSXKK6MLv680N3ABXAARP9J6g3i0YoN8LGYd5RsgfGqX38YKoL
	 MZjKtSBHnG55X8l6RGhPxCDa2zJUjMq8NyBY/xOPzThPSL1i0EXUwP/dyKw2GYIvgNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791634881;
	bh=8lStNNkLAXUfx0Qk3vJLrMRYLaCj8dnR4qwFp1vdHhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J2PtXIUswoSLcU38gPR+NdC+DgG4kEQr6BXCn8TwTxalVUXJbGJBaEGnOG09uXEJO
	 BeKHCoiJaybNbSKzeNBHH35peY+ELESZUdlOUegsIKz6CSpTN5o+LirdM5hxN8gfk/
	 3RUAWCKJ4950dQ/NsNUvVXQkSMWfimXhNnraJfIjGCf6lHTNeHh/5luW8RGla6uLFJ
	 P93tC2niSCefAkiSlUxcmTTcEp/opzsOY5Ikiqp6/LPYtRRVOcOD8Q0gDyINmWXZwO
	 ylgPRi+huLdldmguH4l7cJns1ciau/3qRtPq5jBSku6YgGCiQ69RGn8qJWsjASr6di
	 RT3HPdcePB0Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ACC581329;
	Sat, 10 Oct 2026 12:21:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18F799D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 085DD4095F
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UUeAUss1VnL8 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:21:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C98640952
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634876;
 b=TCZvElaBX/f3zlTL0cQakxqz6B9OK25z1CY+ITBxhccmsKGPm7eGRdXTRnPD441ywyC5
 QoidSWRt15vuJlIA34VIHrZo5RcR2vR95HsuIKQ2EHlqmX9jYHhRlLPN+1XrtHECDJI9q
 ttng2e0ewws1/d0hWjGUPRm8pvqlwigtFGQUEWIA+i2pFkHol03gUbt7KhQEpBGNXJvF2
 Es1+kUwF+THHGWuV5BvyIJTXobwXzp1ieGw0+z4ra5QPHAmoKu6SPjJGftkx7a+WmGvOX
 jW8oR/0sCwRI5WHMENkrgtyBzPjwIuqVW+JztNBxthH9741B671yDXeqoe3BCHvJ77Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634876;
 h=Received-SPF:Received:Received:DKIM-Signature:DKIM-Signature:
 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=8lStNNkLAXUfx0Qk3vJLrMRYLaCj8dnR4qwFp1vdHhU=;
 b=BM7T4d07xk+1IJBLlhz7/IOeb704ctB4LO5DZw0aH87mA7UTo05NpGQQmC5VgLEA1idT
 OUEBkBW/HeLZzpizc+NjUgA3g5IpjPiUSrzjAg9Ec82s1X6odbSXaULk9r7bCI4D0/nZJ
 K9wakCRH05+VX9SoyXu6r4gZVCWVKX47wVs471dpZnrJrdYu29o92KDRidr/qpDXn4G2o
 4LbRZJ5yL4xSUnG9KlG0r497+O1nnKwOxyetySQcsJ/NB5k5B0Bw16caZ6fua81F9JEIB
 acDx+N2VLDIDAO8Lwb/uvC92zdshdt/+sZVf8QwZaoupSTQrG08opLAdqPVSZ/FdrPQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=jannau.net;
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm3 header.b=mxga2DRP; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=NTeFiTut; 
 arc=none smtp.remote-ip=202.12.124.148
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.148;
 helo=fout-b5-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm3 header.b=mxga2DRP; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=NTeFiTut
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C98640952
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:14 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 0BAED1D000ED
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:14:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sat, 10 Oct 2026 08:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1791634458;
 x=1791720858; bh=8lStNNkLAXUfx0Qk3vJLrMRYLaCj8dnR4qwFp1vdHhU=; b=
 mxga2DRPMNU2+75hBsLUq5sRR2wUb2eJJm0E4WAI9NVv1LoDU8ckhgUzjmjKkbWR
 KVMSGpRtGyzMlHdOJ2all0HzJaCKMhOqco50uJF7mwHKhvl5nlExkySsBuGzC+MQ
 /fRnw4wcYc1bmqgcBcpHLvepUp58rLMUp3zCtcOOoAqTbFSXwe/z3i+dXHb39Kce
 uHOgb9Y1XZaBMsXWXU3r675Zqwy2kftgOtuj2v9E/aRS7vU2EGA9CSOviYYgenpg
 dzv4fcOIoaqdH/nOsk/XH1mtstAmNzcHilcwQCdNhE2Muj2SALS2ZYEsvq2C7ivo
 Q17BXWElH/7/Mlx0vSzt2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791634458; x=
 1791720858; bh=8lStNNkLAXUfx0Qk3vJLrMRYLaCj8dnR4qwFp1vdHhU=; b=N
 TeFiTut/wfJ7HeoSN4tAL4jRKJFo1cyFGKpW8hkNtyug199O/5tns1730MQOXD0E
 EAXWClY8Q9mql3WKVZ0yT9bygMZGq6yRj5KY1NT7qPwpUqQUYCqOBQ/8dHVuUgro
 JjiDBiaepTFk206wTFLkS/+e9kXwd189cvIHOa8c6PnWquhCATRDGxhABIPml29d
 oQKshPGQDOSBdXfugyTIZb60ZDgEagkRU/JwGBE+AaDfAHsy099yIxBCUrDO19XE
 RoQWqhjhkCSAK9uJ19LmI3h4QC27aYBRbPiA+krN8TlRENY9/LURV6S14fa5FY1T
 ruv/3DeHPd/d10MLSJ8Ow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791634458; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm3:rsa-sha256:GkngSv0CkLECutK4oBZoHHEzlBww4xp1nMupvpQAHr2kNdn
 khuRGky5ifOngh9IvwUQJuWS4kAGkKolyeiINhkAKBYXKDf/w1gRwRHOlbenBVaW
 WuUeK5ORE8dYuIR/tWplQ3D/CaIzDuKV8RKRsHmAZBR+EargRzF/FYJu2KNHv0+Z
 yxKGsDfc4EIriQzCIcfmi/wCW20tV+lnJ4tx24ncq7dB4gA+7XaHEQTd037/X3NF
 0xpF8FdquOnPYRkTCWBAIbX6a3eLFE77u5eG3GgweH3Yh80V5X5qot+weicVKBib
 FUjGCFtEhXFkgVbfNyyeIzJSIE99Yj9TJb8pZuw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:awWpgZhrFpBup8cKHeu/HlU2r1A2vvsESuj07BunT5g=:vcrEBnU6ijzpBzqutisMQ5dC4rYwFPRG9N9wVJH7Cpg=;
X-ME-Sender: <xms:GizKaqSLVlYWzraOe1Vd5_TcLYnzEOOv58gZE7AThQ3lCM0_RbbXXw>
 <xme:GizKapzqZ-yQLRKkiuKzLa44eAVVqUxRj8YbaU8WnImKEYK2OL5CyCuuEP2OMfOqB
 4EzDTe77AWbYyTwfeQNno2rFAB9Jk7HLmOtA0LF1h0SqEGcTQW18x4z>
X-ME-Received: <xmr:GizKaueaFb2Y6EVCmHIykBAVZrR8DnHbdhbzSJ9d5Hlu0otMohmngq7vX3hTwha5UKFX_w7mehWHshkycpq8P7fcmsl4sLJcuHdNog>
X-ME-Proxy-Cause: dmFkZTFqpbXI6Y3+CoqfhNPZi+DG5Qw8jkDyXnjv8Zl/hcPn3S78Zk6eoCtECVWjb8Y2mP
 PIW0cluxF5Sc6nA8ZXBbZHx8G7ibOOE8hxiBeWn6zFftUvVf/TcCNPG9UjdVl7tkgXlBTM
 LIHFh5/qAXUQUGnZjrmiiLHT6Mhx9NZvwa2FwbUQYPStfkEM5s3u9Gz4n73nwucxxl+Vrk
 0OjGShLCaE1QK0a/CZkhOjweGMDOC/NfzcH4E1RuSEKg9vyf3c3eEfXLFETICuYPbtU3Nm
 g7JoKw89k6iDnZDjcXV42ma1zlizScl/jHbpW4kCJPOna53gfhZsymwqsPRvp8WnWwvddS
 h8s3NavUQnx0e/VpFjzmMfC20uSw3oapD0J5PvkfwvJF9/xguGwNcPldu9btJKh8yU/FmS
 U9X+jkO6jKloxMiV1WMC+kOcHqX+GenLHViPsW39Y3D/2cNj6U020KeLQO+zk+frUXc2Uk
 d4fob9fVYqbkjJrZh5GrxX6f/aBEg6o8iibc5Y/en9zHOzPRcpL8+GaVmUbSCgMT0Yd+kl
 oqdKY5KvjVV5xtkqUGZNHGrnJiD/0gd4MVAwuKxu9aWJxF3aHiIPvwcC2dQqJHn9qIQQZp
 m3wASuHYv/nJy6uKPK897AlO/SUPMFEGz57jEka/8gGOMfmlAb5/TKNXQA8g
X-ME-Proxy: <xmx:GizKakN8Cut1KaBnTd1aovZxalHaQbDDNJZWW_iRTqYlqEtw69dWJQ>
 <xmx:GizKahtroqlrr9TH9o88AFJk7NCsJbPnCqrsmMWOtZL96rMAHGgHEQ>
 <xmx:GizKatC8-X_m8WWklhxyxTNgl90q1CflaLEHTWHRYF6t5NkgMzOJYg>
 <xmx:GizKaoYZ1tP2BLsWhZguQmwbI53y6utNVKF_YUpy0_K9JZVmGRP9_g>
 <xmx:GizKaiDve0j9E7h8GZw2K5xNdxzsRV04iDMsJ5--nEVFplmgtbl3Yf5Q>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 08:14:17 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 10 Oct 2026 14:13:58 +0200
Subject: [PATCH 2/3] arm: apple: Add Apple M3 Pro and Max (t603[014]) support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-t603x-support-v1-2-ca529f301a62@jannau.net>
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
In-Reply-To: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4492; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=vcrEBnU6ijzpBzqutisMQ5dC4rYwFPRG9N9wVJH7Cpg=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxTOgKhMcHnFv8+VW96d8H6tVPFPzJ9++W98pP31DJ+h
 RN3L52W6yhlYRDjYpAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjCRxTmMDFt2vXvkVJ/zxybf
 /38481ODaJUrr8U/8piLGJ3T62WoeM3wP1pgu51eg/8N68db9Rx13a6uXPhw06b9lrP+ancvKCu
 SYAIA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Apple's M3 Pro (t6030) and Max (t6031 and t6034) SoCs are similar to
their M1 and M2 predecessors. The MMIO blocks have been extended but
M3 Pro and M3 Max still share the same overall layout although they
aren't as similar as M1/M2 Pro and Max.
Most of u-boot's existing drivers are compatible with the hardware and
M3 Pro and Max device trees will carry "apple,t8103-*" as fallback
compatible strings. Only apple-atcphy-reset will use a new compatible
due to USB4 and DisplayPort changes relevant to the Linux driver.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/mach-apple/board.c | 97 +++++++++++++++++++++++++++++++++++++++++++++
 doc/board/apple/m1.rst      |  6 +++
 2 files changed, 103 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index e74a5a76919a..bd0c69fcb512 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -750,6 +750,99 @@ static struct mm_region t8122_mem_map[] = {
 	}
 };
 
+/* Apple M3 Pro and Max */
+
+static struct mm_region t6030_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x300000000,
+		.phys = 0x300000000,
+		.size = 3UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC0 */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC1 */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC2 */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC3 */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
 struct mm_region *mem_map;
 
 int board_init(void)
@@ -799,6 +892,10 @@ void build_mem_map(void)
 		mem_map = t6022_mem_map;
 	else if (of_machine_is_compatible("apple,t8122"))
 		mem_map = t8122_mem_map;
+	else if (of_machine_is_compatible("apple,t6030") ||
+		 of_machine_is_compatible("apple,t6031") ||
+		 of_machine_is_compatible("apple,t6034"))
+		mem_map = t6030_mem_map;
 	else
 		panic("Unsupported SoC\n");
 
diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 4ed275f7ea8c..002f4926ed5e 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -16,6 +16,8 @@ the following SoCs work:
  - Apple M2 Pro SoC (t6020)
  - Apple M2 Max SoC (t6021)
  - Apple M2 Ultra SoC (t6022)
+ - Apple M3 Pro SoC (t6030)
+ - Apple M3 Max SoC (t6031 and t6034)
 
 On these SoCs the following hardware is supported:
 
@@ -87,3 +89,7 @@ supported SoCs.
      - 0x2a1200000
    * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
      - 0x39b200000
+   * - M3 Pro (t6030)
+     - 0x289200000
+   * - M3 Max/Ultra (t6031/t6034/t6032)
+     - 0x391200000

-- 
2.55.0

