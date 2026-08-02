Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A996C55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 16:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A818160603;
	Sun,  2 Aug 2026 16:22:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNnG1WESGbxb; Sun,  2 Aug 2026 16:22:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C84336061B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785687741;
	bh=IrvFt8rHz19mflcNvl6SeRxIKG6I/9DrGD52Y/jJqh4=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wZZCRay2x8IJmhIF9ZiKX9az2gLngHmKFdJZRyMbqdCfGw1XHDZx/YTT3hsqLwq+X
	 7GU0t8Ns2Y+l2o6dXIMhexTdZUZ8g/idtIDZ8NEJHchD9F2kIs5eP0K/G4GQqbFJ6c
	 QY0gGnASA6jJ/G0dMDebOFsq4YabLQ+Y75EzXGPqGbp2umxpmGzceG011aaMbZMgTo
	 2PnF8G6n+EGrycmbSCMWZnzPINzpzLWES4RPYIU4EuHUNaHi0Mo+cOH8GiBAL0fbm/
	 hEYBL3GEvvotK1eNFDXBHfqu6LpbN4I0/V3VMYu8JrdiSxv1ct9TGku4Kmiuf1o6xf
	 dDJ7GzPHdJYzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C84336061B;
	Sun,  2 Aug 2026 16:22:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 429D33B9
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 16:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 284CB80C86
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 16:22:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q5lFpA8eyUQI for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 16:22:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 65F1E80C85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65F1E80C85
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 65F1E80C85
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 16:22:19 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-8efbafa1bacso13638306d6.1
 for <u-boot@lists.u-boot-project.org>; Sun, 02 Aug 2026 09:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785687738; cv=none;
 d=google.com; s=arc-20260327;
 b=GDuWXi+BCIPwZlnF+S4bC+utjRJHPLXBfsTsQLJmH2OtyYM3d6cExTMfMC7nTgObs+
 5YInXb1B17MmJvG2xnMydGfr5WwJBAdPB//cSGBs/zTn5IVWUD9J99N/GXp2Q31Zfs2X
 3L07L8K4Cmeede90TiUe+4VrDekiJPan2jeIX9RhX2Y/hCktYJmYBBV8HcmR4qzVX3WT
 0nmcN+GTF5Z6YINONqsZEgd4Hm8rJ8P5NZIEuTT3TBwnzq10rYhRavxPUicwWCcEh5/N
 cMLNe+OR9irJ/1bPddHyVXeR9uc/pVQKu6tQCxhy2nkhR+PFSftxaK26cp5uNpu53PoS
 rLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=IrvFt8rHz19mflcNvl6SeRxIKG6I/9DrGD52Y/jJqh4=;
 fh=YKcYbQWKYn6rcxtm1Y0X35mC3Thwmq6ZT+J6e5OxolA=;
 b=V2Yw25fr5T4O2cGmSNqyZKQKaqvPMuOb/P7nXStU+IzAYU4oSFeDzI9qAstsWIggSv
 +oFoS2uoK1vP+tdP9DdrExHvm6Gu59V0mzE8CMr/l9Y/FO9QC8lBz0lyHR0wZzqSwTS1
 E4sun77ccRPrq7ndDMpcoRpdIctSk7Z+gzn5+NTBm8UwShMzfwnULGBNizvCnkSKSAFk
 zKxaVve2Z6//4EvYXLEkBFbty394h6/WTFkERw7FWaexwNkgdscD6VN+wplPryuFPdeF
 pO+k3WmgzluYivl8JUNo9XZuVWabGhK2vSsblkNbaS7YNUnIdTpTgd0NyOBcHqVxKFAX
 PHnQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785687738; x=1786292538;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IrvFt8rHz19mflcNvl6SeRxIKG6I/9DrGD52Y/jJqh4=;
 b=h8fUzhpQ8yzrwmB4+ba8cSMTxhsH/m1oBNzJbWdrSeQsLVuua5EKq/cVg5f0NdBXk7
 Sq6GkSWEe5zAnKthA+wU/IE+bPm5n4F8kwzPyfUn8MksYHsZhyqSo8Rjq30dc5kQUuj/
 0QdnS9VU36caZA082byOMlqZuRNCBybnYrQ8bjRYliJFJBMVK5X2RhTWV1V9lJs+Q2X+
 Y1JfJdrUebLKXE16orptl2lvy2g1xywjPnLRScQLJfpKGFwSwf08UBBUEAIUWo+qNMo8
 TTg9PFm3MWV65AwpZCGBF6yC3eigscAQTpoxzn8e9/YU8dCor6+QGyTADRvf8yXqPdFn
 tRMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpwi1WHaOFgfmyZ1mmLOVaCCDt7exwMgz2YVZnVzhWYbGNG6ytuRIBKalxZZiRZlcd3vWQg2oE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwuAEJ/OUGJTVYPt4jIqpiwVe7rKJWv6TFtGx1+i+rdtSZryBt/
 k4/9XbUnqlzV1p4/WOJLoAgS3LRtr4QIuXb3BDxsoVdX4dK9BcW0dCnc0v7F41jKYdEgDHS4VWs
 tBeq67QMfFrpqBO4hKvOwyo03ah1ul1Epv73U
X-Gm-Gg: AR+sD11E9ct2gEV1ry2J/y/n5ONfnCaYh7N2m1KBvYe76bj8XxR3ZWawMn2l5AcA8/i
 xwd25DtibSvyaxxVtgI+Gb2mPDOUcbMYVNmeSAt85N60ACKnWDCh6bS6RKvm8OEMTTomblMPia8
 rCYMx9sQZnutyFHKgPlIgNdL6hpQpqrXXkmPdETTKvkkLBy0Y1VhNE5hnTJ9VTW9VDf50qcSp4k
 T6H3Ei2RmkJT0ry4FypTbLeEmo8MKCRkBxyLeRtPkqhrKuQTPH5dJOJ5oSKKuZgQz6QUgzWiDGZ
 36qBjIoJf07adKNOsEooIlTjm+8JJ0Qldb7GaY+J5IA8cxl5BnjGPCtH9Y5eWWr07+SKXxl7AE4
 NtnHVftL+OWJ/b1SDldwEiltyXVt4TIm1rLiMZmxuI3Ho2+S52rQ1XABYDA50/WCxStNaUag/5e
 LrFsUeyOpJmqMXICx0KDZIrs6LYySt4M+F3JZ8P6I=
X-Received: by 2002:a05:6214:2e4a:b0:8f2:1663:abe9 with SMTP id
 6a1803df08f44-90849602f41mr157423766d6.19.1785687737901; Sun, 02 Aug 2026
 09:22:17 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 2 Aug 2026 17:22:04 +0100
X-Gm-Features: AUfX_mwImCVprRQ0IiD-NCBAKjcSHwBpNOINPkrAMe1OjMHJG54h4sV8F-bEltQ
Message-ID: <CALeDE9PU9taVrDUYxr5XyXHQ7-EW3i797mGsQOX+tJ9gFf9TXA@mail.gmail.com>
Subject: Pull request: rpi-2026.10 rc1
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785687738; x=1786292538;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IrvFt8rHz19mflcNvl6SeRxIKG6I/9DrGD52Y/jJqh4=;
 b=N7pelG0m18eb/P/W+ErZI8XgXlXPSpSDOiygvP93RxqHTatz+0u8sYTBg3CXgvAR2T
 roohgnJix4+evktgK8YzZ7RgFn1i8c+PC5vULfYNLa00uof1gt2MSbpOaIAGy/Qr2xPw
 7ZLuiZPou2IfnhL9VfzT0YOcno6abolBpcCxB08bsmfO2KX0J7RBseufgIJjUnybRJgw
 I30N1YPy68Pj2eiqkOTT2664FsdZBZ3vLqbZ9ZR/LnDHY7DzgmjQSjJKrn3tGjC+4sT3
 pfJz3JUgM7THvHw452svWMnRbgRNm/cocMr0kkg4Hq9AoaY8EuagjFJ2zOClsSETr9tZ
 9c3A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=N7pelG0m
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

Please pull the updates for the Raspberry Pi.

Updates for RPi 2026.10:

- configs: enable NVMe
- test: Add a unit test in phys_to_bus for dynamically created device nodes
- core: Skip parent device nodes without a DT reference when looking
for dma-ranges

The following changes since commit:
5c215cb75c3723cbf77c36cbac3e60b001721c79

https://git.u-boot-project.org/u-boot/custodians/u-boot-raspberrypi
tags/rpi-2026.10-rc1
