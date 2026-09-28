Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF7DCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB4BB406F4;
	Mon, 28 Sep 2026 15:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLiIwm98P9LF; Mon, 28 Sep 2026 15:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 125E7406DB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608496;
	b=Dj0L5Tixu1AT95tYPJPasBayczFRElRA42KLYpb50Ze1P4gwoD9PyZl6ndu0eapGpWGM
	 jlEoGSvTZL/1722kLDBXSixgsh1fZM80+ImoZvk52giWq+JxuXfZ8HOf+i4tkf1ATRNzQ
	 VccJ0wMslRM9tMY6w+jqi7VnWBEZod6HnFnQ5gqwqFrlJKfscvsDS8OKCvVWJWpqLv4RX
	 D03EABizhmbpggJJAjUlrAYPGw5P/l7hvuoCaa/PRYh6Tk9fI+Beel9uShX6Cv7d7F/0J
	 J1MnzoHDak5iiPfIXjXKoyO6YvvXIgi3rUAODnmwOjn2/IhF2er1d63umJTGKqXYwPQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1k0RodSMN04EFXFULbo8EonurNPcZ+Ak3kvOber0UEY=;
	b=hS0k6PE1PfOLy6kJQAhY9sVJqcC9OYQfBmGDsQwjGHklTDi9zuBoTOkquWrEsZDe46Zs
	 krYsEIK7+us8RYLOkMIMTSGBrtcdjd3xFtJN3XO5ZF5LPYf1viPjvXi/74BtlQ2H6rCWI
	 H3AATAHQiK1zixl1r+GjA+X3r/m/VOoCafsshsxglp7grOIukhyt/69O4jIZVWWP1gXUG
	 LJJ2J7AoxJ6tSPTOueEsctSHk1XxJcwS9jkiuHe2lQyaR/4sfGGV64QJC+P8td5ciy+yh
	 kg2nhidprqvJ5KhFYsUXg8IMqTiiDg5PfVpsNWuX5VgZAIkKEvhe9xxHMHz0ZUh7Mxg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790608496;
	bh=1k0RodSMN04EFXFULbo8EonurNPcZ+Ak3kvOber0UEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xjq6bL8gm16eIUkf+pUjxtb1x+ucNAPfrFg2YDoMlmC0rvc5nBRCPTWfPIBiY5XGD
	 yYOuGzepfpvCOdq2FR0K30cneReO8U3mGTG1pDwC48k/mcCmWleyPResISpmWoa/eH
	 YKgzffh1hUtEJB0HLA5jlUop60EGU2Qn6HdiATySVNEsX0L13UiZ4CrXGmygk9bNWS
	 EOMNBQpeHOyvfyiB+fyWgWF2FibDUq2ChT2ZXQwrInUF56rUse4HoWPfiqqmVanKgC
	 5C9/H/vWZCjng/5rkhVOcmGkgaPux2oakUJgdZKGXF5etFM0CDp3X+tAE5/bD60OGv
	 GoIedLGwzXx+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 125E7406DB;
	Mon, 28 Sep 2026 15:14:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74A153A0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 667A5606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bV_STysUD9OM for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:14:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8C070606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608493;
 b=GptXT6H4cJ2PaCSUK0IXHKJ3kFDGJxvZeQq8RaPOFpdypi5AUYYJb29//qmPU1/eFAIp
 39bXNyfu4EK5F91GwzyzO7LYKS0Y5xfBz8Rfb/Kku+ggmcl16BqLgukImkvm0GLOphZRM
 9ptOeGQcmual+bpv5z1nrpxT/H3xAcFn5AVIGus4cHykIQk7DDN8kF9a/iPNAwuKdC137
 lXD+5UhMgZKOebWfI/D/Yi3fgc8v7lTC27IxHT1DiJUOMMixjE2Htz81vLmoeUcU6rIyG
 8TOXUi2l/OWhE8Cv8FiRvT+0TKdQhGd62Hmj6Cn9HTWlxa54kHh9LezM7Lusmv0neQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790608493;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=1k0RodSMN04EFXFULbo8EonurNPcZ+Ak3kvOber0UEY=;
 b=M1rGI9c8JTnnjJRWny1hHFjdFLwkfmjR7dzPUU/rXCz9Q8yakDlSiru8KrpCnnjNoIYQ
 JL3he34g425m2aZPTa5noz6knag4q43OocW+khz6UWgriAdWnsNM18eH7FWXEcmnzm6pJ
 xFDM0E3564uohHWz3GxXqBrVL/SbSN1pBJp089z6WLoKIiNgK9GgJxqHvTuG+PM915jbq
 SARxf7afIyOhJW3/JeIxRn6UeDcDZM0fpz2inN9R8Jht8XIM+u3UulL4GZPbeRwm65qm4
 eYHi/jm6HpW+JDnqb8Uc5RY00tBvxtkXVfhfgu3xS9BkRblwmpVsEirIqIv/lR1qYxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=aLeGNWkf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=aLeGNWkf
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C070606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:14:53 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae90f528fso4563174a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608491; cv=none;
 d=google.com; s=arc-20260327;
 b=qrrrJtEGYtcqpiCKlL+m66nnEJeQdpbEwZfWuXRm9XJru0fLK/8MlT32izgtFc7DqN
 TPRhWhdZ5sqxKShN4RbT4/8Szl5CrJQ3xDCwH4MBgWuJbCZXKx5RGrenbRbz4TP8C5cz
 Uk1Tv+z3EJFWaRQ0VJLGsr72DmChcNSpsD0y+kv9r5VKSo6bp/waLULllJ+Vl8+eRCNp
 B891zsweFnt0udKix2eqr3vvCdYtpbgay6X4gQXSDoThfD7cmKiH7QeGTGCcUjrLY4OX
 s7kN4BUhpw9FYDaxiOmaQHLqEDBwlUbzo1qec5BUQ0oFLC/THSqwvFHTFFjI1/Ny5xKR
 AjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1k0RodSMN04EFXFULbo8EonurNPcZ+Ak3kvOber0UEY=;
 fh=BevGJNW5AOKnfy8O/FowEJJ3Prwfzn1eQzuyArZTRL0=;
 b=QIaXkpPprvmvGZn4KgC8VX2ycqVw02j4cX6xxjzQu8EIs2FEKupFUA5iLXLGtoChxy
 ChY1DOaT5In41hlbFx3jeJabpDp4EiwFQnJ6oC/5LlZXbdYJAmPKy6U5qTio45M2dHfk
 tfWwstqO58k+NmIoLW81KhaCCcrTC/uG7ip8hJ8DkBer5NYo9+wsPAAA9Ju+0ZkZlM0Q
 zMjcLA2Yop5Db9CBGQ54Am0iD3tKPOyH+w/Xji3RzNVgunPFJjfcV6GRmShUkNoKyIWE
 Fby4gwm+SjYcZ//S20i+JMomoWBL3O3x/Hx+VHXvPnl3FdUyJ3Mx1pyRYUoYwXT/UGt9
 Pw/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790608491; x=1791213291;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1k0RodSMN04EFXFULbo8EonurNPcZ+Ak3kvOber0UEY=;
 b=aLeGNWkfA7BAl1S5M0rSqw/LyN+t4xM/uNMslsK7OPQ645nB4PYZNWyq0EoqI14Qcj
 /t5cWbSEhPYEbZBqv1LGPmAw9h4Zj9HUuUu+n/otwjTV5SIRk5vQx13V5oRVdWt4CqAy
 0b1M2qkeAfQMBfnEsfvT9gD/JyQmfxqQ8MjX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608491; x=1791213291;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1k0RodSMN04EFXFULbo8EonurNPcZ+Ak3kvOber0UEY=;
 b=iQYo/ozUUPNX5gmX9ti/eZ77pkieNDy4JuonpZd7xWtBhc9qk1XPf6OE0R2E7wtDc+
 /Fs0k2gRJAvq7ZXkijd35nbfnls7ONfjy3ioODtUNmnoulJPBeAz8mY/Up9A4dyUlDzm
 EdiMQ+RJ44FTFxraMtazLAOaL1ww2tVEo7XsjXwS0smhksT3OpJusIJnmOTPLvybbKI7
 XnGqxiMK0wSeNQbHNl3vIragTdHPhp0y4OcIrVINY+rPU4s2XpVRiluEXM/xhkdy8jwJ
 bA7DTv5EHQiYH25ivD7/hLQAFNEFGSsG3qjnyiAe6QXMM9gbE2N94+dT5UH/JS+ot3Z/
 uWiA==
X-Gm-Message-State: AFq9FYIaNkFzzOXGVFPepNkHdfa/HblEOhjZLxbhwVVOwOKc1/FQdqNc
 sbI3yrN3e1rPiir/BZPvIOZdjlYpJHm1ugT087RqJVZfuQesKhUr3wcu8Gw3MGRxWG066nMZbIl
 6mN5mo2dmZZOVPwAAl0TRZ2GyCqi+WKpm3LsJRAO8
X-Gm-Gg: AYBFou1lozbwVTFIdcmzs4hMVbplPgKGq+AmfKUuDPAuPL3OFoWB6minlhNu8I4aBya
 Q4NEGOaGPwjDWWGORr+YA+5DCfx6tycdZPTZZ8IRSFu6OGLCuxsHa/JrCh0GQHC/oFpbiVMYqY1
 c1oBt4hcYbAwVWYy/dh+fyOgQ0O4YHYGJGC8BqeXJT4u0Ewj0VE7x54kMm4POjx4tMhTtLjc/9+
 h8FTnavl7IJKz6NKNlN82en564DyzVAhP1Y+omXgZkRghoPhe2UHobvHlR38zyPaxXqSHtzH8/h
 PMdwAnsz88LipODWXF8rlhcv9U+BPvVJhCz57b5DKl3Aebd2e6nzsQ==
X-Received: by 2002:a05:6402:a30e:b0:6aa:f02c:dd96 with SMTP id
 4fb4d7f45d1cf-6aaf02ce0a3mr5234777a12.11.1790608491327; Mon, 28 Sep 2026
 08:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787272661.git.daniel@makrotopia.org>
In-Reply-To: <cover.1787272661.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:13:53 -0600
X-Gm-Features: AclHuK8YHK-hGp3W34wCPm__ppxQDgYwQ0XjFQxWZu-qf1HiQ5PbPpqham_6cwQ
Message-ID: <CAFLszTixHT2ZLo92bURLbzbCjyTO1B1SsRkBXhN6FMcBxWhTWg@mail.gmail.com>
Subject: Re: [0/9] boot: add imagemap on-demand image loading from storage
To: daniel@makrotopia.org
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-08-23T19:12:43, Daniel Golle <daniel@makrotopia.org> wrote:

> The first in-tree consumer, a bootmeth for OpenWrt-style FIT firmware, will
> follow as a separate series.

When that comes, will you be able to add a test for the bootmeth?

> boot: fit: support on-demand loading in fit_image_load()

Related: patch 6 adds a struct udevice *imagemap field to both struct
bootm_info and struct bootm_headers, but nothing in this series sets
either outside the tests. The FIT hook is dead code in the built tree.

> On hardware it has been tested end-to-end on a BananaPi R3 (mt7986), booting
> a dm-verity-protected rootfs from every storage path the board exposes

Sounds good.

Regards,
Simon
