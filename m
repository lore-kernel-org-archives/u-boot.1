Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1936C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 01:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55EC383979;
	Thu, 10 Apr 2025 03:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aKJWHUWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D93838BA; Thu, 10 Apr 2025 03:46:22 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516C783957
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7272f9b4132so256558a34.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 18:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744249579; x=1744854379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfhRTbRN0spieALbKma7tRzEd4rDPaLY092tyBhTo3Y=;
 b=aKJWHUWgfXp7nf0ZPW9XZSnzBt1tQYSAx75WvAFrKrJsTn+5DwXA3MAVVxgz6moyQH
 LUdLQ0qObFGFjpgeGtDY902pRSEXQquCuyBsusOBRxVOZyi5m78B78iO9Wyzjy9xZWo0
 3YWu+tXS93rIn/gMJHpJgidBhg1H7OSiQsI9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744249579; x=1744854379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfhRTbRN0spieALbKma7tRzEd4rDPaLY092tyBhTo3Y=;
 b=MeTWen7ji2GOCHgrpMEjC5o2vS4I1TqsTjvbXNWci4fvvveyGz+JMyz5Pop5P4L8PN
 iU7Hgz3qcvrh0GDi4bk5PiQwPRzN9kMUiGjWCp6hZ6kvx/bwrNYiZLREP4zM013yfekj
 BuYx8XdqPmgoFRmgM+I/g1JgQjBZPNDOI5s4kreNBHaYc1PPhNuI29k1Hz2Nb+w5WxTk
 B/dXC3m2iGVXgUf8pj6H9TEvFTHTLHiZJJ2tCSQhz0DrP0hFkWTycU5xckpxR1epXio5
 6nVGOAnIDy5ZQh3d163T+EbNQkgmTP1i0j6Rt8P/Y39EJ3DeSqizdIfHLqu5yxiSfwce
 pboA==
X-Gm-Message-State: AOJu0YztbnSZZZDnyuY2kmdSXZd9EE3tNI4lzX0rnzbYa8BUp6w6jH1e
 rN0rxWhTF5Du8ym9E1RHh0x4kpH7DtKmk4PCjGJd2U6ZIct5cWBcg/1tUOnF7TE=
X-Gm-Gg: ASbGncsSelpsvhq1F1ydigiGMs57lEueGO0/ZCqrdO359pHxO08b9JjRU9s5P3KJ1iq
 tjLWWxtP9djVu2oFGinc67CKHypDd4esHfsr3WeMrBoZbGNWJXBtas/d8eidC+IOZXBnX8htb3h
 trLmnKbVKJ2FVlzIIftXuyrgr0S+CnTw5v0lIBGWC8Jc5UXxU/yfTSqks83JYFy27mwLewA6t7Q
 MDcZk9V9xWCcdMMGCXrdWTVTRWjdqKuQBab/Jtd6Ble0wKg4BBSSVGpQEkkraznMrZgawBgS4+A
 og4ZhEeJvR5euBgX28ckN3/AN2udgyXkIMzhEBPC35W5EAC14ovH/3L80YG1fzmxfYJBEZWf8EH
 g
X-Google-Smtp-Source: AGHT+IGsQ9huiMlJQ1TdQWkE+PY1vZol8sXOvU5BJzskGcPwa4xrUz2qgOUL6AjC1m+GVMvDGzxIdw==
X-Received: by 2002:a05:6830:3981:b0:72b:9e3b:82be with SMTP id
 46e09a7af769-72e7cd61a09mr241799a34.7.1744249579057; 
 Wed, 09 Apr 2025 18:46:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd3764sm474569fac.31.2025.04.09.18.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 18:46:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Marek Vasut <marex@denx.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Simon Glass <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250320190147.1050427-1-cniedermaier@dh-electronics.com>
References: <20250320190147.1050427-1-cniedermaier@dh-electronics.com>
Subject: Re: [PATCH V2] tiny-printf: Improve %X formatting
Message-Id: <174424957794.1824423.3029252947913754207.b4-ty@konsulko.com>
Date: Wed, 09 Apr 2025 19:46:17 -0600
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

On Thu, 20 Mar 2025 20:01:47 +0100, Christoph Niedermaier wrote:

> If tiny printf is used with 0x%08X (upper case X) the output is
> always 0x00000000. It could be confusing if upper case instead
> of lower case is used intentionally or accidentally because the
> actual value is not output. To avoid this confusion, treat output
> of %X as %x. As a compromise for tiny printf, the hex value is
> then output correctly, but in lower case. This is done to keep it
> tiny printf small.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tiny-printf: Improve %X formatting
      commit: 51b8679b94ea22ffb91925cf56df1950fd4b0e12
-- 
Tom


