Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A5CC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 20:52:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A631F8211F;
	Fri,  9 May 2025 22:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYFOAQFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39BE082162; Fri,  9 May 2025 22:35:47 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1938210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 22:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=charan6.ram3@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30c3a038acfso1937663a91.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746822942; x=1747427742; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pBPP3E69XcuMxXNTT/6xL2RtZUfzt/XdqvsKCJC5yWE=;
 b=ZYFOAQFkyxCAIOmIts1V4w5ImGODvvgZyuY8npOW33HAn/mxZLfId7Ngg3u1PABZtZ
 Y2ajd6dMULKUtPZE0ScE9tj85MDSF0TaTLdUbvRP8KoNFep/8S9hZVgq7p9UyVMxcX06
 WQS51NVW2EuVVnRxQB7qguRztM+Jn5RB9IbJbxRzJvsD3YRiy6/jLxIUWifynBrYQO+C
 ham/2qqt/fuRcC/iP1CgT6x6A3WFhYzEegx6OE/iIiuMXXTRDOco7tYU+9VCjDfkrPCV
 N0uN4/JMFFy62gZ4X1SiGmxzq49RPT4d/JpljZuUJFIUsooV59X7j4yf2UVDtIXH5V5o
 UJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746822942; x=1747427742;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pBPP3E69XcuMxXNTT/6xL2RtZUfzt/XdqvsKCJC5yWE=;
 b=d8KWNHODTuWZEe+LgDuh+i3n6+4iId7C7fe3Im39dCcMq+LZK9N7TPKat7OpM0x92k
 YLvFRRHiB9h5Ve3SA15E39uYfdAGuAMqrbQcTiLima82sWlBW1gFKhz69SOXoQQDNDHa
 KuxGI/MmGacet5blFY7Qkd6XihCZtuoQvUiTOJNLq8wVxh17fTJfbAhzSxbzWU/PwYce
 0PeDOamm/Quya68XUYWD0NJlm77iRiKHgOrbr2duDm+TA0JTFJioXu4ye1I9Q9Dgl25h
 CtLS6Lc2w8MmXDc9ivOuG3Av4xXu+NujtViBKwMSW12+6lMqQNfbb5z75l05z+d7aoOP
 x3TA==
X-Gm-Message-State: AOJu0Yz3Bd5M5HdUsgd4YEYaz29dyghuj/sgOii32TUuMDrbRIg+7apP
 mwlQycmgf6kWaYZ/649eBYbxS5sfEkX35l3DMjWaCdfYEas1CcJLuPupj03ziKsvXoaj6gHr0nf
 Kt/MKbHs3pJoakQNAd+4HcYhmPemJaPBE
X-Gm-Gg: ASbGncv+MbggZumQh/NaplTOb0sPSWpbCHGygBK/t0YkXcdgWT/FSIFhRtU7OaAoWdX
 bLdTBO3RZPZdnPinHkzpbfuj8iP9cuijdAbG4wPZotjUaIIwqUThxoXjyAL6QwTQbUrHh7kb4Bb
 nqj64ceBT4vyDIT8IWFQks3W/IungtB07Zzr67LfF+io4=
X-Google-Smtp-Source: AGHT+IFviBqAQMjSJ1ACQVkhvUNa5ZA1tnkTKC6b4RVLBKp4xFgREepeU+Qc2UbEvEUec9kivmykMXnpN+xAD1sMs3c=
X-Received: by 2002:a17:90b:380f:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-30c3d628b6emr6446678a91.22.1746822942360; Fri, 09 May 2025
 13:35:42 -0700 (PDT)
MIME-Version: 1.0
From: charan <charan6.ram3@gmail.com>
Date: Sat, 10 May 2025 02:05:30 +0530
X-Gm-Features: ATxdqUFvGmymVeGQZpOVRlFHkAr_crDB1fYcDpESzh74ixrAh5NsjtTytEtVg3g
Message-ID: <CANvmrwH8WUnTvpTTVtJ26OhwmpsdSai6RcgGEmXWLffSno7-4Q@mail.gmail.com>
Subject: USB 3.1 - DWC3 Discussion
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 09 May 2025 22:52:38 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi All

I am new to U-Boot and I am trying to enable USB 3.1 (DWC3) for my board.

However, when I am going through the U-Boot source code, there seems to be
significant duplicate of code between folders, *drivers/usb/host/ *and
*/drivers/usb/dwc3/,
*for example
a) /drivers/usb/dwc3/core.c and /drivers/usb/host/xhci-dwc3.c

Why do we have duplicate code and which folder files should I configure for
my DWC3 controller?

Thanks
Ram
