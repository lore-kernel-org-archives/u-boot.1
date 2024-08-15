Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6603EC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED80C88C29;
	Thu, 15 Aug 2024 22:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sAB2dCIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514DF88BFC; Thu, 15 Aug 2024 22:33:18 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A85988BFB
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5da440d059eso857285eaf.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723753987; x=1724358787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgG/xMQ8Bk73jYtRtZ3DxO7yubqw1DuHStbFRxu4olM=;
 b=sAB2dCIBVg2bBrf8gSja5HhK7QXjpZByPmQVO05wBmY0z+gWLhqKxx6EDn8LMLtK4S
 utCOv9RsoopYKNHzmbXxcFZxcIrZ6af+sku5Gro0ni9Jhc8bX0v05QO6AqP1vpdHj0Ip
 RM4EuoCnH3ofYTJ8+g0Wm3hm1psQjt1fn4B+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753987; x=1724358787;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgG/xMQ8Bk73jYtRtZ3DxO7yubqw1DuHStbFRxu4olM=;
 b=nOYNHV51CY4zScoT1GjYYy3l+i3+dCDxCCRpgh2r2dCglEBG0DYJTdb30zAexWqjs7
 sVLIKSo8QXZzLr7LIjVgS3fryQho2Iwjx8uTNJScDDBka6Q/B5bhdPx+5pjYNhvOcLaw
 OxCnEPb0LMpN/ulrMEPZJ13P0bBLvbFeS5GfvWiBPDLWac2gjt0uoOxDtbhIMGBDMQmm
 0MfAv1HhRdk9e6DJz9NhW9NjnMU5SrM53y3WsnV4t5vVZQsGaq7UqDGqzjx78ptrExRb
 YOsa8OQQ48pLssCv4yVwfAMaltUpjsVwzyo0fWH7xQKPt7oFFkrLQTR10HN1czj6eIIX
 SWtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFQ/lObvqUf0p2X1Q4sWQUcaYyBMzVhUOxGIBbCNeUgwmalo0WF9tp14JZTP8oTjaqgHjc4lYTCuQLeU7yMQxK8gTIpg==
X-Gm-Message-State: AOJu0YyXpxvaiH7LSto+opfMEQno5lN2b1v/oadqxNOlgl4J4Fbqsmi0
 W5A2X2YPcCVHZXQXpfuy+9v8/oYwZ2zPldM9N6Ed+3+9hCp+ZUH/cFPNMSmsEBWYpiNwcankp7B
 sRHM=
X-Google-Smtp-Source: AGHT+IF1TLaS8CzX9CzePNrHPMQJiTcBKkZoaiLo6PPBeWnGwjhR5MuyF+4cjDJzKeeTmgrI9x0uXw==
X-Received: by 2002:a05:6820:222a:b0:5da:9204:671b with SMTP id
 006d021491bc7-5da98026b3fmr1392638eaf.7.1723753986911; 
 Thu, 15 Aug 2024 13:33:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cdd9dedsm402006eaf.21.2024.08.15.13.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:33:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
References: <20240814124108.2885-1-yasuharu.shibata@gmail.com>
Subject: Re: [PATCH 1/2] sandbox: Enable wget command
Message-Id: <172375398608.3490037.6506766037812613193.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 14:33:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 14 Aug 2024 21:41:06 +0900, Yasuharu Shibata wrote:

> Enable this so that the tests run.
> 
> Fix a few warnings in the code so that CI passes.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


