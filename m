Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ECACCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 21:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20D1983677;
	Thu, 30 Oct 2025 22:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ejJBMNUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB9E0836D1; Thu, 30 Oct 2025 22:21:17 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADAB38334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 22:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c53215c3c8so1580016a34.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761859274; x=1762464074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIoIpXKJWDCCHApEAMgjgNt7NGYGW/Pl++Hn+fORG4A=;
 b=ejJBMNUXecoNAhNuC8bP2cdohQlrjrNVS9GbUNwrMDaIWTGynrVucL1bIFMdj8EjmG
 brbNu1mwVVhgaU4bKT6vrvtD9I/xZDmclK5Wsq71PQ62zNnPnrKjWEubg64Biahz4riR
 FgYwJTIecL5C7/nwixdDz5QVqaiJncKnKY0p4bvPkQ9LMG+eJL2eE6SyPiPlN/FUVHLf
 d7B6fUd0pwTkjZVk4EevgPyLoiR4Od0ABX6RXgqGG0ZX3+3Htqytb91C2Merhw0DUlGc
 2qiasLALhgwcyQjhvutK2c2ny5aXQLDiYDbNF/KAXeMyMLUZv74IOv4UjJcds1z2Ja+N
 a5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761859274; x=1762464074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZIoIpXKJWDCCHApEAMgjgNt7NGYGW/Pl++Hn+fORG4A=;
 b=awMkK1PuZvLwgkks14xOvM7CKX49kx8dWRHPu3Oxvh2tA1Bt1hitA7NP9+167B0DUW
 azavr1uT4M5NmhcHRWFe8BMaMLZEplIf9Sp3vUHrGEZd7Wgr/aYOdqU765Tre/V06PAx
 n+psf0AaqRCJQefJqOW5f88EnC+XcikIqTmVJLklvngtY+D8iJHVYmEq6mfdn4AGnWdN
 DF+eMFuNZYBQFnNlT2EuLcv/XK/Z49nDNAV6HmZr6RhDHG9/Spj+eHsHJ+Js73h4iOQv
 DungaLVd3G2j5yWv3M4AkbkdPn6jkqlusY6yWpV86uMXM3PwlnBpuZlE7Idr72M4g8hi
 VmQQ==
X-Gm-Message-State: AOJu0YyfSFnzSnjFRhcaMtfQ2Jah5xpxGzA9Uj6Qm1VTGviqhgeSxgNZ
 0bhdLw3udpdhO33WKUocDcmKXZdKlqz1nBcEbUBL5c+rkYZThanU646GDwjhIkTymebM78iNWBU
 TLKlY7VAVr3P2BGSQLYzjKHO5OCcBEEP2BQ==
X-Gm-Gg: ASbGncvS3nVyHwGyNdq7R1QnysySMBOLvrMQav0bZaf9AQP8CWUkJGWSKHfEItQeIYI
 5ALiSqw/8vtFU0U9vBSIC4ro/ILX7dlee5gMb3yYVreti3Nneq9RkaaSknLuAqibKghxi9sTsw1
 zcLl6p8hvX3PbLD35oGtqX73tYuqLrZXzeXRWOj+5YFLeshKtwtc81nLiAsCiYm5LQhPREH6jd3
 PIFKTgHHxNudtyxw2fbwxM/zidpzL3tlZ0E8QzmDJR2cGiSbaA3JW/wytPNDBGWXN3cg3CClqfk
 8PV/Gg==
X-Google-Smtp-Source: AGHT+IEtVwD/odxdbLNZzdqw02X0qnZh1S7yuXyIspl2VyozVhzVoz+CgUFrh9eeAgeZ0vInoRtB6cccqCuYdz/5S5s=
X-Received: by 2002:a05:6830:6a14:b0:7a0:239:80a7 with SMTP id
 46e09a7af769-7c6966fbe32mr733413a34.9.1761859274257; Thu, 30 Oct 2025
 14:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251030003359.1023-1-briansune@gmail.com>
 <20251030180940.GY6688@bill-the-cat>
In-Reply-To: <20251030180940.GY6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 31 Oct 2025 05:21:02 +0800
X-Gm-Features: AWmQ_bnEPvN81enYT9EzpQl65x1G0pNnp7g6U68CvPq9E1vthx6L3D7syQ9WAc8
Message-ID: <CAN7C2SC+uJ2OX9WmU7AmUjTZ7O4rWwQY0ueYYvWcUH1GF=fgZw@mail.gmail.com>
Subject: Re: [PATCH v1] Cyclone V Board handsoff script
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> I'm not sure this should live in U-Boot. And if it really needs to be
> hosted by U-Boot and not hosted/maintained by altera somewhere, that
> this is the right place in the tree for it. I assume you run this tool
> on the output of some other tool?

No, this is a build script that is a must and also required on every
clean build.
Those board c files are only good for very one specific board but not
those listed.
And I supposed these scripts will also call on MakeFile after several patches.

These python scripts are used for handoff SoCFPGA project to U-Boot
board folder C files. w/o these scripts the board files are messed up and cannot
boot accordingly. This is why it exist from official after the newer build flow.

Brian
