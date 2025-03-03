Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2DEC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 20:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C231F8118B;
	Mon,  3 Mar 2025 21:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aeC8qrRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EED5B8121A; Mon,  3 Mar 2025 21:19:45 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B04008118B
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 21:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6fd719f9e0dso13430627b3.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741033182; x=1741637982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pZ8CYyUiDD/CUyhp8QoQaiNOfTalGqtzGyi6AjN6Gcw=;
 b=aeC8qrRYELn0/vI/nJKB43gjDqVMIWgi8nT9ZGrIpCpkR2NcKaZJ7TQ6IsSbz6gjib
 8UAt8t6LRS23C/0fuxFAydyg/XmBdhU1I82VUKs5wi/+0NXZYSAijs+eyh3eW23+4dt/
 Uir2F0Wn3Vprstbboqs0Frs2DW82+INQzZ6HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741033182; x=1741637982;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZ8CYyUiDD/CUyhp8QoQaiNOfTalGqtzGyi6AjN6Gcw=;
 b=dFgfuZxBN8NbOqxmP8hNeT6nMNxIHgpVjHtTA0+cGmktv7WidjNgZzBSBHReWN237d
 tRfZvmiEpnc9F/1tdkep7Ty6Oj2/nzB5jTY1gGoJDeDKl/qegePE6FSdWLkPZL/opRkY
 fl/SdYk7bncbH+IIfkZfa4l+M3OXRBWZ0WsI5wpMwU+ex1JnCR8RT2CyY89/xa0ff3zo
 WC7XYOLbgKiOm/m/UDt+gNSN2Q5odVYCp1+6qciQH/i3J/RmhonvnDM44oBqaFVmGV2n
 Esr3KSbb6CLGDBxUTM0PT0r2XVYFCFYfj6Kp/EJaR25UXnWile6s7RRifJzO49/RpOjL
 O79w==
X-Gm-Message-State: AOJu0YzvfPTV4e4LYNsaSqnJVo0D7XYH2drgwTcQ2EudtE1rRAn4csud
 5CLLz14idX62YOn13ypN6B+PgRzEwvaw/N5gVP3lpA+EtBRH/dhZzJ+pElBID8I=
X-Gm-Gg: ASbGncsvIKtAnL6XDJViRmz7U24F/W9C7V1BUHMWGIMgOoPtEXMuGMqWCKdvGNDFC74
 nfeETf7AAWEqQTWOzw+y7XSZlOisYH21Xul4EvI4t0WH6EmCGCaqstpieeFeMRbaEe5G06F+vNe
 XWeE72ducRU3ILpgTYl2li6CKMnsawq8cxI3qJHFlzC2t7Nxxab8AIuzlwozyBpACIuRzNmtnjs
 o9xotDLgviZxkdnnjpMKGjlf8Z5+b1p897o6rUTcF3z9X0r3ZA/Zh2m/XEUNbLQqLkE7DQmPlNu
 11TqqiM21TN9fOEHxSihcAkZcBeZic/etcQvuJz3Vw==
X-Google-Smtp-Source: AGHT+IEUpTYL/eS0Jod+/Tzsh6LJlPjYrIGHc7fQLYuBXyKD2xAeT8W6VwqetZLpv3yish/NVPDjlA==
X-Received: by 2002:a05:690c:7248:b0:6fd:44a2:da51 with SMTP id
 00721157ae682-6fd4a0301bbmr195193937b3.8.1741033182589; 
 Mon, 03 Mar 2025 12:19:42 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca0ef34sm21389077b3.6.2025.03.03.12.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 12:19:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250221204329.677953-1-sjg@chromium.org>
References: <20250221204329.677953-1-sjg@chromium.org>
Subject: Re: [u-boot-test-hooks PATCH 1/2] labgrid-sjg: Add kea lab
Message-Id: <174103318121.1518351.12606067838273903975.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 14:19:41 -0600
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

On Fri, 21 Feb 2025 13:43:01 -0700, Simon Glass wrote:

> Add the current state of the kea lab as an example to others.
> 
> This includes 48 boards, not all of which work.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


