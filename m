Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CE7FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10898394E;
	Mon,  4 May 2026 14:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N/6jSN17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4FBB83EF9; Mon,  4 May 2026 14:06:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 697AF80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-baa8c78ac7fso542929866b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896364; cv=none;
 d=google.com; s=arc-20240605;
 b=KoWyhTJzuQap8KdBcoANPIL1HTYN/CFBmGffXNWagkOzRExJ9KKkSXdzrIdELpXX1+
 DJDoqAaP529ztUHDwi+MNZM4yfYVXgco0/iRZDmwAW0yNe0qEPzuZj9IxdKCmhAZJ9sC
 T9Yp+6jtlhHXdr6kVlX6Zok3w5XWq+0s+hbdibV6HdyGnGcXPqOW49mvtjsdBN/Fa1S4
 O8xVE/q0RcCQn+sFnJ6SkXPJANoDRUk4/Rv3e7WfzF4NXAp9KFFGtgr5vInNBYHtm4Ct
 K1pjb6eHSsx8HLS5OgqnCgHl5FJ/agiHfjmZ2ooExCXr3ACLKqGIvJmz5dwLGtHeF7T4
 nD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RigSv9D1T5Iz5jWIoOMHuuCGSFuDrDVOSC+wyJNVaBM=;
 fh=ntz0lAR1NzUPX54m6kpUdu9FMFEOHJeCMyRx8/spC14=;
 b=aI1x2HgwtWqDOZNEVukNCQMSKxfbNhCR7Xg25b9OgW+uAYm9NsYw3KaOoeO6WmwMj0
 ijDW7Ad0ENY1TnEJC4BI7HUCh64HJPxuoTC58y3AJbnVmaxoUN9gRWDNDC5bQ3k2jYpS
 R9JZW0mHMt+pcFo9BHOedM1yDDkWGUwJnCZg1ymZfZgKiRH1VeG/t60ZRSJ/AhnVFXx8
 3zxJ1llPs2+OUakMxCYJ9CqZpjSkx+5kNelFMPyViGpfFc7Xbq0ZGX8ptBJaoY5IzwLf
 A9ChHfeGWRGhI9+mNZNQYybhzVeQrz8l1pB/yh3ws9d3aPsCeISUVJFeQrCM5Nm1su6S
 HmcA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896364; x=1778501164; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RigSv9D1T5Iz5jWIoOMHuuCGSFuDrDVOSC+wyJNVaBM=;
 b=N/6jSN17IVDlS+5ZoOQpph0b6xGKe4xTltDmcdi9d3AnOWOwPdmij0EW6TQeIt35OE
 joIhjUMlpffti/vfrmsMdJcUKtZBAzRf1k5ql8Ety5I9gMjoMDRVVR+Gs/n/PQGs9iVp
 x5rhIK/BTNbZHbGYKOdp2WgDradD7uJT4nhco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896364; x=1778501164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RigSv9D1T5Iz5jWIoOMHuuCGSFuDrDVOSC+wyJNVaBM=;
 b=of6WzbUMD4GeUjDXWi25DGJYfg5svqC3IH4D2eDkx90pQ3hW+qItc0BHaO4R25d65W
 iWk49z/QpRYXuuLx+KrBq5YU4Nc2UMD/HK+ISbXAznW+Cylwzv1h8xvZiFh8QtojAbmE
 67PT8wS+oCarvOKVhela2wZdSijGcK/TcF+91VeHm64X41YSX4Dn7xX+e6yUcXX8JEVd
 mGAE6GWxqhxiwqi2d806rRVzvy0JDcFi04ES6I6r/eKr8q6EziNUbfmklckxw/GE/Nap
 RAokOet+qbpO9bmtppOhfaeneMknVdDck+o7m4fJUbxnM0VGabhEJ7PWaLXdoL0GYFMf
 ZmKg==
X-Gm-Message-State: AOJu0YyKw5ZY8vZVjj2vn0omtCz5EAFjPzf6u2wDHnkfUJwy373yxdcW
 y55L3n+vHzDCNkBR1hGzUooyR3F3tjC2sK858+L07KdSLiHa7nNWkkSSJGTVJdMIBqqokE1lyvI
 AjD7sX7oyTf5l++SZfXeQqYk7k4G+biJYYmbG8n1f
X-Gm-Gg: AeBDietCgOehE+XAnoB0D1CIBCWy6upyYDd/dJl+EScGciaS0bEB9bHJPzhJ4ktG/oc
 ZMzTxjOLa/W22Ah2sxYRnkwguJp265zFcqhAlGQplRNqUYxDgRfQ/YWeA5ZocStR4BfOzVgV/5z
 hugTct72A9awX0HxnrFqomXuV3v4oiRJjDLPw7/vG7YrCAqXau3YsIS7O9qsznG6JUcbRHJvNkP
 yjsfmUmV9ooMUojDb6d+UJF229X6gLWIf3WmrUnHu3+N6xO+5TM+wMmPSBijR8Sv2jrvx0tnaFd
 czGshDnyhbZuvnOH
X-Received: by 2002:a17:906:dc95:b0:bc3:51c:5b75 with SMTP id
 a640c23a62f3a-bc3051cb017mr104467166b.17.1777896364348; Mon, 04 May 2026
 05:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
 <20260428-ufetch-net-v1-1-5d58c7618239@cherry.de>
In-Reply-To: <20260428-ufetch-net-v1-1-5d58c7618239@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:05:51 -0600
X-Gm-Features: AVHnY4IfAniuFTXowUyF4qf1o3jBEniIOTeM4sBT8wnl_NCgqF-gcmLv1c0-_hE
Message-ID: <CAFLszTgEkbsWn6VZ0K1y3ysqEN=v18WMFhPh3=j-J8bC=4KhbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cmd: ufetch: show net feature when NET_LWIP is
 selected
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
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

On 2026-04-28T10:56:03, Quentin Schulz <foss+uboot@0leil.net> wrote:
> cmd: ufetch: show net feature when NET_LWIP is selected
>
> We've had a new lwIP networking stack for a couple of years already, so
> let's show there is a 'net' feature if it's selected. Since NET_LEGACY
> || NET_LWIP is the same as NET, let's check on NET.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Closes: https://lore.kernel.org/u-boot/CAFLszTgZC1FGy8965pHiG-u=FhrguftRv41ghQ_Qb_RRXx6tyg@mail.gmail.com/
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> cmd/ufetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
