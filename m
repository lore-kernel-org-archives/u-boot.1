Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB4606A332
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X8/5WGii;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=bB2Oc+Nv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19A2D60739;
	Mon,  9 Nov 2026 07:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5eisIH0s1ZEG; Mon,  9 Nov 2026 07:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A2D360716
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794210930;
	b=SkiPTZ2E+ATGAoHsuGyM3YKdcH0Y0Xdiox9A3G3t0nnM7JLs170B5MIsovwMZIgjD1hW
	 lDLQQmShATSnxx+B3ZW04qMqQqFDkoZXY/r1iJK7ZIq1rmmBbDW3h58l8B7Eu9or2L8tt
	 u/amWleCXcE4gQy0tOwqxJG7WCNmpJb04uFqkxNmWBmarZ9bs5WJmTnjm4j8MZXgtPZI5
	 ekE7JdDGqld4RqXFEkuy/Gbdsztb5lg/3yQTzEnzWGMApJKRB3YExGNZEfFBzsBCQaNcj
	 lSdZ89BQRmWttifx6NJSYIo4SCVwWAdsYz0QENK/rADAOMZvyPZwJjbm75Ag6R4L7qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794210930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BEELy1o/9+NMrfuGetHMynNXcDpQ9UN89j5M4JUUZWw=;
	b=PuPTLDOkincwYJyftxaWBAw50axTPSOTnhs8TOXMLlFoy+tx7Q1JRRqALzrrkIMUxP2f
	 1K1u6LMsqhc3D1kWxR6rUViJkFZy2v7ICZwcfor7dpQBSi9nvIsvvsPO3Yx7//2ODF5GI
	 uIhKR0qkjRC78QoXqXXcG+MVGApAnE4Y/q8m/zT5cGC1eOFQfb7rFVwKYVSKRW81EmYv3
	 zkUEsO2MkPWbJdv840Wyz2KN7l5rcwMwCR9ve0zTBI/owjBmJOWUbHjTQ5uaVwEBVPx3n
	 GA2FvaKbnCCz4fu2PLOEQFtLEYlm1JZx/HAxAr8qTujhKbXBZtpihcInW6r7oY9oBow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794210930;
	bh=BEELy1o/9+NMrfuGetHMynNXcDpQ9UN89j5M4JUUZWw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X8/5WGiiph8LGIs3s9j09k6NveJo7sgRxQvyj/LeUoIDMQbwmeOCT2LJMgGdJ84eO
	 zbavEoyFRpV8lrBdDJWFAYqpogabhWPWZJNALYiD5JWCtgn4x6dmlO4AxxhFIsVVLe
	 iWuTJnxFdYcFn2XBsTZnUmolWRl7dMbz8IcFEyNKfhX+6moSF28oy8QdkKGbE1M581
	 nv3bLqhQdh0Rd9RZs0a4QPVXo7KNTlqN7QxxWpxzEA4AK/Qz/YfJWsAX5d4/2Z9FEW
	 2C3Z+pyfas+P/3U0+uzA70vysYleIvnjM45babskkAVB3dWpc2ng8R+VvAT1XrXQ8P
	 ylgBAjDhoEPYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A2D360716;
	Mon,  9 Nov 2026 07:55:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8884251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D9FC40695
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u9z4ovCFGA2t for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 07:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02A0C40684
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=bB2Oc+Nv
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02A0C40684
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794210924; x=1794815724; i=xypron.glpk@gmx.de;
 bh=BEELy1o/9+NMrfuGetHMynNXcDpQ9UN89j5M4JUUZWw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bB2Oc+Nv6OZK+G/REOiM1WxDg3GMFI+DbMpM6P0lk2wRsz/ts5TWOCmIWyyfj+FF
 s0R5MJFRiyo6GDsVcVKZJle5WgOY70720HOCwZFweTtDOPCeTw66Ch4XDKtGhSceD
 OZ+fZCgRhveA6SCwdItud3xg0Z5q4Vn7Mn4aqBsvesdTsnjLTFI05IEqn/AjIZBi3
 XEFIDXQFDt+rWmagQ0HBzNZVbtRDunTyhU4Q4cxGB7EWHckEiz5JQF2fxHEZ0OY8K
 /Br7+4sB1/e5NoN829Z/P1vTCkv5d1CDPoU7wnV4mkJthncWF0neKVti6stHmJzRb
 wvVcKprE29nU3EzTTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwQT9-1waQ3d0n8H-00sNrx; Mon, 09
 Nov 2026 08:55:24 +0100
Date: Mon, 09 Nov 2026 08:55:21 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>, u-boot@lists.u-boot-project.org
CC: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org
Subject: Re: [PATCH v7 0/6] virtio: Add a virtio RTC driver
User-Agent: Thunderbird for Android
In-Reply-To: <cover.1793836645.git.alan.tseng.cs@gmail.com>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
Message-ID: <7BF67EEA-DB9F-4CCB-A81D-F7621FE1E1CB@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gss+jjWP7pIwynh7vilmzjBhAntWb1xu604aUwgJCtx6QiggGFl
 itIGRiIYb0MRNh3GuRmDpgQi55nG5i2z5lKYaoQuknIfJtAu4LGBApMfyRaVQJM+Y35bV8z
 I2UmfGQcd6FzMdq7rF0sXjD+VnhhuhK9CnMEmQf3rKxqKQPvcO/hRy3qPK7lX8aFDoHKFIm
 2qKrbXCijcC2RFS6aDrqA==
UI-OutboundReport: notjunk:1;M01:P0:3CAiKvpoSQw=;1vI52LoU37uBLH9UL8QmX6UWZ8h
 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
 hE=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 9=2E November 2026 00:34:00 MEZ schrieb Hung-Chun Tseng <alan=2Etseng=2E=
cs@gmail=2Ecom>:
>QEMU v11=2E1=2E0 added a virtio RTC device (virtio-rtc-pci and
>virtio-rtc-device), but U-Boot has no driver for it=2E This series adds
>one, so U-Boot can read the time from it through the RTC uclass=2E
>
>Patch 1 adds the driver, patch 2 updates the virtio documentation and
>patch 3 adds a MAINTAINERS entry=2E Patch 4 lets sandbox tests answer
>virtqueue requests as the device would, which patch 5 uses to test the
>driver=2E Patch 6 documents how to reach the virtio RTC=2E
>
>Changes in v7:
>- Patch 6: drop the claim that QEMU x86 does not enable DM_RTC=2E X86
>  implies DM_RTC, so the driver is already built there (Simon)=2E
>- Cover letter: no longer claim that "date" reads the virtio RTC on
>  any QEMU target, which patch 6 explains is not the case (Simon, v5)=2E
>- Rebase onto main=2E Patches 1-5 are unchanged=2E
>
>Tested with qemu-riscv64_smode_defconfig and RTC_GOLDFISH disabled, on
>QEMU v11=2E1=2E2, which reports a UTC clock, and on QEMU master, which
>reports a smeared UTC clock:

I was not able to set the time with the date command using the prior versi=
on (v6)=2E Is this a deficiency of the virtio RTC  or of the U-Boot impleme=
ntation?

Best regards

Heinrich


>
>- With -device virtio-rtc-pci and with -device virtio-rtc-device,
>  "date" reads the host time and advances between reads=2E
>- Setting the time fails, as the clocks are read-only=2E
>- With no virtio RTC device, "date" fails cleanly with err=3D-19=2E
>
>With qemu-x86_64_defconfig on QEMU v11=2E1=2E2, "dm uclass rtc" shows the
>CMOS RTC at sequence 0 and the virtio RTC at 1; with RTC_MC146818
>disabled, the virtio RTC is sequence 0 and "date" reads it=2E
>
>On sandbox, "ut dm virtio_rtc*" passes=2E
>
>Hung-Chun Tseng (6):
>  virtio: rtc: Add virtio RTC driver
>  doc: virtio: List the supported device types
>  MAINTAINERS: Add entry for virtio RTC
>  virtio: sandbox: Let tests emulate the device side of a virtqueue
>  test: dm: Add tests for the virtio RTC driver
>  doc: virtio: Explain how to reach the virtio RTC
>
> MAINTAINERS                         |   6 +
> arch/sandbox/dts/test=2Edts           |   5 +
> arch/sandbox/include/asm/test=2Eh     |  25 +++
> doc/develop/driver-model/virtio=2Erst |  25 ++-
> drivers/virtio/Kconfig              |  11 +
> drivers/virtio/Makefile             |   1 +
> drivers/virtio/virtio-uclass=2Ec      |   1 +
> drivers/virtio/virtio_rtc=2Ec         | 244 ++++++++++++++++++++++
> drivers/virtio/virtio_sandbox=2Ec     |  15 ++
> include/virtio=2Eh                    |   4 +-
> test/dm/Makefile                    |   1 +
> test/dm/virtio_rtc=2Ec                | 306 ++++++++++++++++++++++++++++
> 12 files changed, 639 insertions(+), 5 deletions(-)
> create mode 100644 drivers/virtio/virtio_rtc=2Ec
> create mode 100644 test/dm/virtio_rtc=2Ec
>

