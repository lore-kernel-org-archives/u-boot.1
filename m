Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ECEC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 07:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 683DC80CBA;
	Wed, 16 Sep 2026 07:41:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OR0ZxO9FsxAu; Wed, 16 Sep 2026 07:41:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 834A880D16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789544470;
	b=SWTvaMm0qsVIQXBY94vmQfBqH5ZwuCgq/IcGMaulMEKA7d93jLhNz7rUgTpiL4kNOKRB
	 KjYBuXztHo9V6vlNYIizTHvTxbDtGar8qfeFGdvxGKdU9nDXA/Oq1FKdvevi+AFZRyPHH
	 u3kmDVrYJqen21ssx9XyU6UXOzqnn4p+QXxQR5JeyrAiPcCyVG1zd64/9NLXxYH6RqiPD
	 J+OhI+12NRPHeN5c0T0PF/nSJwJNKz5QYC8dRe7TKQmiAPSuy+YlJY8mOH/PiSjkjobuI
	 8420lUeQYFcuSUDFIWbRyPmm3BAv7uqtM05NiggTjD1hnBpjMG8aeGPiPXDWkn0PJmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789544470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t6qHq7AZkkLu6zE1eHi6l9ubTj/jGUtw6e9G8rh21+w=;
	b=OYdHgah6a53fHOEzc3FDf3DXwOEiQXhWugfrEI520PL9iYBrznEx4qvUve+xRwDGj3Dz
	 fCk+t0J9yOWidutE9PUM3a+72RpYBy3xijiKfsyrzi0rN+tQgRYCaJEaEC2oEaLszAJ6f
	 eRC5kCn/2GBl4RsrBKGD1zp1Xypa48YcdVzMjIzBtYMpSFWZZH9IXgkaENmnERlRBWHkl
	 nELDAj2/C6aa7mbfspqWpg4fR/HYt9Zh5Pf6D4KkoZ5gH1CtWz3QnVMMnKAOEKWHHBO4E
	 yyKyFstBcRdFaTgkPNTgbgvOA4tXFFUxrvL05vQhQFtnmFBOsVKZoIaU9/opZAR0oDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789544470;
	bh=t6qHq7AZkkLu6zE1eHi6l9ubTj/jGUtw6e9G8rh21+w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MrrB9pllRIMkpi7vqM5qWO9192+dOjmKe+4DSX0OqDI1TjLQHBmn1VCvwLSc232Ms
	 iK5bFVC2s9Dui/brarH9ANqdsIzFwdHObL+4+860ersKun8OwTrqM1HOSdAI+8EKUY
	 Fa/QEZA19qaHgsNTGCkqmv3enhrg3BtyYw3RGQDxYnDDY5+1ANEsTSJin7IblJU+Im
	 44L1YKLuyJj2z9bMiqXn8hjdyzdZQcAf6ovEjP8/Tg2ZPTjF7x63X7QkdFLbmCt9qF
	 uE7CZs5H9yqXOXUXLks5sZSYY1nXmETvf1w+SrUPtCWMGVYAMygsn7WGf4tlt32Lti
	 9dw4P1fQDBKOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 834A880D16;
	Wed, 16 Sep 2026 07:41:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F358422
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 55278607C7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TDJ3xSKqI3s for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 07:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5C16C607CB
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789544468;
 b=T1eO/NRqe9ef1kCUlW/f/SuPEIOyK2/E/qqpg5zvBf5iPSK92H4q2kvavo4vOUT1BK61
 xAKPBFOWNwPNmG9hr9HUHpr3tmTnN0vnz5lHZQbUOP7fmMG3SKd+Zo7cK+sTB3Awu8F5g
 IBD4OVGJNLf/xIhRtYqlUhzjpHvvzGL7JwndKIvXZSpHlIuTRMQGBXmpsqRFl9p62RHHL
 VLJTWS/8xuiQDGpyMrTXeUuPEew/meDZo59NnYfuopoXSMUTTx/g7IXKv14lXXJ0X72Zg
 ra6jjadHVavjivJ280wAv1bApu3wo2xqUIzUAFhsDwF+MTLkit1Y296UQcLh87aXWZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789544468;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type;
 bh=t6qHq7AZkkLu6zE1eHi6l9ubTj/jGUtw6e9G8rh21+w=;
 b=qJPGQkfLKxYnFPmX6KpG6TvxuA/PiQUNd9LMTq9ts/1KvlE4jkE5igs+N9ULwmj0gNH9
 99m62neebPS2ryTjNcpsTTdDGvXcZEd1sbjG9/gT3adfJUdNTFQWtyj3MlJdiWorZg46m
 3omDC8meSNNzzJzjx2AOBd70P7pDVt2pyT9OlAh2nSOuE7oVTA6wkA00wq/fb0GtcJR8r
 ehxuVnW3O+dAN1yz64twfl6ztbcFt+Ied5zLwW7g1sJuhSUh0Ki16ueNEe3h43RgWzodH
 YuXo8F+oMNPhXAiRLVU9hPP3e3VjkuDhbubpqwslH0ZgIMxwBhpnCDiEEsY1zuegUEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qs7fE0jw; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Qs7fE0jw
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C16C607CB
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 07:41:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C716C6020C;
 Wed, 16 Sep 2026 07:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A021F00893;
 Wed, 16 Sep 2026 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789544465;
 bh=t6qHq7AZkkLu6zE1eHi6l9ubTj/jGUtw6e9G8rh21+w=;
 h=From:To:Cc:Subject:Date;
 b=Qs7fE0jwU1owY3Ihl+6dUEsQVPDaDEnoAIDlxCkdHUUd0mPhW9BLJnIiKFi3cgNTs
 /hEFV81ued/pyx+GeDk0eedEQX3NYken0E/sUXkgscUAgtrQ5o1tD7p9c9E6E01I4A
 AfLGaek7BMyD0+89BV45iGIekav4LBOr7yrQYymTa1grg+hrrSnIifJnFdUzbreeLX
 ievAc1rFmpzh+cnJicdy4q1ADqlk6+02EmuwqWzgkqNcXLjAl41FDnGYplZV9SpZS/
 jhtAyx3pI/b1VeSvf7tL9hunubJXoPsQOYp66dKvfNr1106ViC7Q8HubXh9LgRbUCj
 mVFZSg/61BxTw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Naveen Kumar Chaudhary
 <naveen.osdev@gmail.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [GIT PULL] Please pull u-boot-dfu-20260914 into main
Date: Wed, 16 Sep 2026 09:41:03 +0200
Message-ID: <xhkdb8q511w4w.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Here is a PR for main with the following fixes:

Android:
* avb: fix missing break in avb_set_state() switch

DFU:
* dfu: mtd: probe before get_mtd_device_nm()

CI:
* https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/pipelines/1275

Thanks,
Mattijs

The following changes since commit b4ac71db13a33c4e6532c60a781ddf34b7f4375a:

  Prepare v2026.10-rc4 (2026-09-07 14:08:25 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20260914

for you to fetch changes up to 0802a621ffe504742458af95ffa79e161047a148:

  avb: fix missing break in avb_set_state() switch (2026-09-09 11:04:09 +0200)

----------------------------------------------------------------
u-boot-dfu-20260914

Android:
* avb: fix missing break in avb_set_state() switch

DFU:
* dfu: mtd: probe before get_mtd_device_nm()

----------------------------------------------------------------
Naveen Kumar Chaudhary (1):
      avb: fix missing break in avb_set_state() switch

Ralph Siemsen (1):
      dfu: mtd: probe before get_mtd_device_nm()

 common/avb_verify.c   | 1 +
 drivers/dfu/dfu_mtd.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

