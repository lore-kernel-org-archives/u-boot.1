Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6541CD116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 08:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D607E838A5;
	Mon,  1 Dec 2025 09:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k59ashBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FC56809A5; Mon,  1 Dec 2025 09:44:45 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746DB809A5
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 09:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-656b0bd47b8so605189eaf.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 00:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764578682; x=1765183482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0VtJZwGAsbcwAgP8+ou/EKu7eEZ3xHrocbnYxZrUVb0=;
 b=k59ashBPB/pFyXY0v+U5D+v3wL5yyKGBNIzHEPYK/PbVhOJEJbgQPIk3e6UlPgZvun
 lG74isdyydMGvAXWT6W7vVIzuspWQppfzEyQ2oEe2cTc/sqs4l54QA045/b10bKtbhaA
 6KXgPAPWENvhjjW5Wl1r9ncTJOV8MawaXHX25rjZlDG6gouCJ+Ug/BJr5jSAWLJiQblD
 kSscLof7wPp3tlHrdQGsiMe8UobxfMgdBIFRrzIQWDXFXFK1r1Z3khikg3evdROs6fxw
 isAecRnFKEm3YcXGZMWtcwWK/m5XtH71XHPLL/O0Nv580V3JF/Quj6NcjL/cPaaTHiS3
 WljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764578682; x=1765183482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VtJZwGAsbcwAgP8+ou/EKu7eEZ3xHrocbnYxZrUVb0=;
 b=OB7zGm5gWjSdwM2fnLEv935YYKWXSwrp9+Xwl8Gk+e4qUolYFJYvwAmYMuPhCrZ8e5
 XQmJM0Tb4TBhnfp4NWELGBqdrjqUNTFIrN3mymoVMvGlhgHv9wgA17l6BJzh8TibneXT
 /xeYL7rwd0BW/8XlEGZ7qmdgZxJqSDjZebIQ9K+R8lo80IBYeJDLMEZjihQh59xT652P
 yAARwHPdRBLQpgiHvFqXwFyaiGXGuAc21kTPv7PRrU+uUBBptoO+heQXVxq3gjX9brmq
 Qaj9zHLqwzsl8301K4bE5dpqdLEhujl5CjZ22jzzhs23hWTtdnDyg0elRDHmljOsVPqJ
 pKVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUdf/W+Tw63B4PSn21k2882IrbmdIxeepSIAMdVofMuYoYX57zSjeIsDyPjaAAb8o9p2sKrJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YxJM5O5rrPvjW6AudehnXZKpXwCA1jNY4AXB2IOrJVRDxP3CJI2
 NUicJvoFQYt+YBAwmW1LXXmRBjY7YEklJSkPHqVUSEgWRp1WUtnkM9M4GW+ax87WfyCy8HnS55w
 ibbJa/dNur1RpQnpQmGDkSQzawtr4ONI=
X-Gm-Gg: ASbGncvjJbYdprvNW3Z0uNwRjPHjTmAmL1/SV0DZRyeDeU/nwgzHr4J3mi0RKFRgyFl
 n8ExH4yvqpBZH5NRFaBslhIeTwi9vH0hyEDx9cEePcEwg/6H6GCsQ57cR2LVjBZQBwhbESb/T9i
 abiUPBePWjQMjDSRTuxxEGU34h/V0R1wGPRxbXnEfV9Y4Um4Jem31rQ6BhmvUWhAvDMCou1tA1e
 KVHChF1m44BLx9v/YD8GIMmJqQOLrD3OGeO6d7kCCkgx47W9haf8iGSpJuGjrRM0Q9uME9d
X-Google-Smtp-Source: AGHT+IFFo+GRvQuzdZ166nJzmr4VGCFy4YpGzPTehqgsm3B/22iHR0Hnvu3u+yrSJoOGjls1zAHKF8bOfMbgDLUzvu0=
X-Received: by 2002:a05:6830:67a1:b0:758:5a29:cba0 with SMTP id
 46e09a7af769-7c7990ae795mr16786123a34.33.1764578682087; Mon, 01 Dec 2025
 00:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20251119111653.456-1-briansune@gmail.com>
 <fcb799fb-4eba-4155-aa0c-46b5279b7171@altera.com>
 <a2600334-a459-4063-a76c-cd14b8698356@altera.com>
In-Reply-To: <a2600334-a459-4063-a76c-cd14b8698356@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 1 Dec 2025 16:44:31 +0800
X-Gm-Features: AWmQ_blxRDMWgz0aqGARYMQHm32VNjC0dyIs_bszgrjx0SYVbQw-BSIDmtul5ak
Message-ID: <CAN7C2SA0x2nZt234oZ-jw5w8nA3zU-=ry0G1Qk8znTRqwdsvaA@mail.gmail.com>
Subject: Re: [PATCH v8] Add optimized Makefile support for SoCFPGA handoff
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi T.F.

> Could you please resend the patch in clean git format-patch (mbox)
> format so that I can apply and submit for PR.

I send it as V9.

Brian
