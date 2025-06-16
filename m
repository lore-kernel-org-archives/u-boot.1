Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535A3C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 21:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACCAD82B18;
	Mon, 16 Jun 2025 23:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bce1pjdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E98CA8006D; Mon, 16 Jun 2025 23:25:00 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D647382C4D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 23:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73a01a7bee7so1485530a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750109097; x=1750713897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqTDVOg3d7JP3o3CJCgz6eedg4gkl54ddxkdoPiJlXA=;
 b=bce1pjdcu+uj2poAm/sevYxIJa1S2aU4oSSjQSx4kyYfS+/eS6mCKc4WXZnTZ5LJ9f
 jtfXWqzuxCgW95nYQ5hPa52MLW8NkEynU8+r6NH7qZqQ8NnvoysSzXOZMLw5vNo67Bzs
 whi9tu55KswKy5zg8A3wgsxGoaN7DEfzTcdxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750109097; x=1750713897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqTDVOg3d7JP3o3CJCgz6eedg4gkl54ddxkdoPiJlXA=;
 b=YdWJUiGewFUWPhPufXuAXeH8YXHotUDmKgD++1BlSM7//oIkqc8LKb3q8jobTS0nP9
 KgA4hKD1OjqS0OwphA64XdDKaAwz+D1DMhwySJmuJ3kVJ0w0UBFT+vhdf+sW1B7EKnHU
 1uXTuzO673kiqvXqBXTZUyjfXcReNdXHIwNwr9P4HOPHSJ4i+gt3UKTNs1wdQzIzr7Sq
 uBdgwoUppiK4nDV1C0VlZZY0Ax6AaGTmtQoCys+EjKn500qxK25E35prbOe7ENGMdy+c
 kd0yaJG43ogw9zF218/rKQkYcBWaq7E4ilSlsK2l4cZ4tuO0KTY7/zOLpV5MLpcWYAcR
 5PLQ==
X-Gm-Message-State: AOJu0YyE7VlM4JBqqjD+zljBQIIppetdk3GqXiUM7JTAIsXiUwmEKN0w
 xoOHdC/b6exRKbG7JcSapCQO9EbswjfAyRv/yrZknpmysl9sHJ3XqBCW5y1Gq/j/tdY=
X-Gm-Gg: ASbGncsUsby8gfi2VZ772egyx3gThxHbrjiwb6h+T4rTosoAQ0spiY9yG/JpAnsbQd5
 wlQv4gdy5mU5L5Cf+HyI90dKhSEctGzk+lSf9CaVahA8B5ClVLpwwzC+ZDq3GRVdSSwoWkHcbdY
 Of+HmoNCgDarYx7D/XGHfUnGZ5CQ/6b2SRfyh5094Mgd9vuYQGMS0LnbVUXcB+HgYZxVB3uUTof
 BTTXnE5GG+H1a9qOtuRUT3/p6ShBUFJtigsmrDFrEWRNC9E6tkS4j7cCjnIyZzSVq6zpptFJlCX
 v/bo9PbPqoY3rJNvBvSl939kdfFn71Rlrt4DtjHzhPvOo0Q7C1mpfbVMVolTwWu6wKVTqCAMyS9
 yOHsnRw1kYqDlNVCdzNUCPHxdty+nmOTb
X-Google-Smtp-Source: AGHT+IFnVW9nsAK5PhSc8cCLw8L8kllDU75lV7kv7mBVfYnCGKiltHn+GgJ1tg3PcsSv6g7m/emlZA==
X-Received: by 2002:a05:6830:418d:b0:735:b053:912 with SMTP id
 46e09a7af769-73a36266440mr7120285a34.4.1750109097590; 
 Mon, 16 Jun 2025 14:24:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a284fea9fsm1337766a34.36.2025.06.16.14.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 14:24:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Ivan Pang <ipman@amazon.com>
In-Reply-To: <87zfe7ga1b.fsf@kernel.org>
References: <87zfe7ga1b.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250616 into master
Message-Id: <175010909609.1300018.10909583950972445054.b4-ty@konsulko.com>
Date: Mon, 16 Jun 2025 15:24:56 -0600
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

On Mon, 16 Jun 2025 14:12:32 +0200, Mattijs Korpershoek wrote:

> Please find the following fixes for master:
> 
> Usb gadget:
> - Fix ti_musb driver in gadget mode (with DM_USB_GADGET)
> 
> DFU:
> - mmc/scsi backends when using 10 or more partitions
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


