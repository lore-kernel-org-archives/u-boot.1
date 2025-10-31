Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE62CCFA02
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CBA83A8E;
	Fri, 31 Oct 2025 18:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uLL2mYEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE5183A97; Fri, 31 Oct 2025 18:51:40 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8888883A8A
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c531b9a45bso798833a34.0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761933097; x=1762537897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N8FoZ0+mMshEq/5utXgsXuUWPKcl4W0sX4b593mDhqY=;
 b=uLL2mYExifNMfaIiHfgRA8QlJtetQyqwd4YlsMnIR/kUeticKNiMoMD/5t8t1J8CS6
 VVPYTZ4r3BZc1lMq9r/g2UEBUvbULJ0NcAzQJa41HYOqIy0qtCo0fIrLRkbnatCG4iFZ
 9EmlsmNuvOmZghyDFD/MJj0dpfhelj8C+16n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761933097; x=1762537897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8FoZ0+mMshEq/5utXgsXuUWPKcl4W0sX4b593mDhqY=;
 b=pSzqkPHRvlv5h3SA2neEk3Uv74FmtFA47TmBXkYddq0OZxo2VdVX9hfdM6hXJVoQ27
 cGCINb1j3F3sgj+d0K3oyBTRSOTDUzHWciRl/qto2ibLSFjSR0KhVzpdv5Uux3zeoKrf
 bUYzKpOyBdVRK3pg1IZue1bgySEQDZWNp4PZ6d2C6zxjybUzEPQsvB8Zu9UisqSblIGu
 2ohaaunakzTHPXvp2RDfDHRdrppPqQjrAhnfGEA7VS1gnLEv8v3WKbOSvJISv9eK6KL6
 nF+WdUDZmKBDX1AeHaNfbm8EtqK/RVb8O73Ie0e3amjWFQcKdU+cPgPJWO5WiXVIBQi/
 qUmw==
X-Gm-Message-State: AOJu0YwrKefSA6KcL9g5WBkt3KwXHuAUf9UuCTpLVpj7INzcCzu7MkZS
 ennoM5t3fKvcRZbYlmXncey+lQWiSCY9fMId4JwpxT4XnI90X2Hnl+1uso/ZhVnQW4OGtIkUBXm
 HUY1NxIUS8Q==
X-Gm-Gg: ASbGnctshYUitT0+lQQwjAj5FJ5VsT4hW0CbLm4KLiw7SJpQ9B2ObjJly6ivY0FwxrD
 wHGaoUw+GCnBXfakz47d9xC4yhWxzRVFgX6mPx21KIc7EYuiStxPEcUj6lQt1Z8h8xMKOoh7T1Z
 jDztgxzQj5NgDvdGbi3b4cENGRQ7KsyI6Etj3IbasW3VawoBszCqRNXkBcLW6cZnvYj1/+SZY+r
 cJ5zyyzgebIpfG3hu8FcRX5yFMiUT1Iy4FITdvIU6Z8R9GWPG0S7tJc7b0BLGQgrBLWCgh4qHf3
 UWgkFsF+YGDLm0wokIsm1HQdYncDnuaAgkDS6XMFHXjFtRcE81GKUqHeW/WQ0hoI+Wdm1Fmf7Vk
 K59tZoZ+xpIJsmIXH6wOFJBhMpvRw9F+oETSUVkxttInX25nANOgR5xb4AfcpiOk5uOPQtXmlo9
 MGHQlWFEGAO8rYokR6IkiRHbCC47ZghC/Q7Ei8osJYd60TE1oH
X-Google-Smtp-Source: AGHT+IG4zclBTtRViaqFYE7FVjBeaLihMQlJfYXXLTCUd1jakFHr9Swf3sx7o4hw3GAxXqf6NMFm+w==
X-Received: by 2002:a05:6830:2106:b0:7bc:164c:58b2 with SMTP id
 46e09a7af769-7c69670d4fdmr3256409a34.12.1761933097256; 
 Fri, 31 Oct 2025 10:51:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c699c40d68sm704626a34.15.2025.10.31.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 10:51:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, yegorslists@googlemail.com
In-Reply-To: <20251023175408.272070-1-yegorslists@googlemail.com>
References: <20251023175408.272070-1-yegorslists@googlemail.com>
Subject: Re: [PATCH] bus: ti-sysc: select CLK driver
Message-Id: <176193309580.3953260.12669772277268275375.b4-ty@konsulko.com>
Date: Fri, 31 Oct 2025 11:51:35 -0600
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

On Thu, 23 Oct 2025 19:54:08 +0200, yegorslists@googlemail.com wrote:

> ti-sysc.c includes clk.h and requires its functionality to
> manage clocks.
> 
> 

Applied to u-boot/master, thanks!

[1/1] bus: ti-sysc: select CLK driver
      commit: 2ab70b3b488c9ee1f9686f27334668fa63c12e6f
-- 
Tom


