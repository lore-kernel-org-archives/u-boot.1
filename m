Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A88C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 17:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196EE810F4;
	Tue, 18 Mar 2025 18:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ouz5yiSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69886819B1; Tue, 18 Mar 2025 18:02:48 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884D981B52
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224171d6826so17925105ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742317363; x=1742922163; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AIoL0h1mknQq5z+wGL0q3S82zx9roi+4PGH3A6Lfg+0=;
 b=ouz5yiSLiWXpMHXjxWZSuQX+X1mY7DiFecJ3d9yMpo6qcry6eRpuJrX4HOH02YV9r4
 K2pAID0ki2idG//PrF6oxJVKbnjz+YKsrF6B9trhNk0yshcKEqlLnjb2DVbtflF76LiL
 1zG647upAVKQNqdjp+SpXEs16ywf2qKywFYE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742317363; x=1742922163;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AIoL0h1mknQq5z+wGL0q3S82zx9roi+4PGH3A6Lfg+0=;
 b=gLNoUauuvNA/Sc8a7Ajpzyy95F5KJZ/6zTAV+lA5DB+KLCy8AP7jzbWdOJwgNWhNFh
 UkdJQbYCSPC+TKVPXtXvyo98FOkuKJlKTK5yx3JApW4X6dPSDaJpve6pXnodLbO4VpaL
 NzRsl/Y5PS4Ql9Lfzcx40bwVnYsPcL8jTHr2fpGndyzQUwpdAjqfNDzTFcuCUM9xfh8Y
 lZGvs1iCM2/xEJ371cfjZa9wabuhKePGgUqCeU5X6TdvJIpItkD9LqkT5S9u1SFoC5b4
 r2nL0hlh+ctD1xwBZtx6GRtZjvXNPUZYVcfIFCkvuj+YADO8zXAlXKJQZkjI9nWyv46D
 aGZQ==
X-Gm-Message-State: AOJu0YwDJpleVwJ6sGsiRxolADV3upceBpvQtSrg+rzPiw9tI961o35a
 GpnII/MTuUzyJnTTIGP6Wjw95bzEFoxmIxEBJVipuJIm/OZYoI316v5S1hgxs7XUaw8GuXbpvAz
 Z
X-Gm-Gg: ASbGncv6f7Rfelz5npnv4RczLlqc7W5aQvxOEtWVm9dV9l3NN8a78L87yDF9RgXn6M2
 eJV6cIIIZmHacFOn4tFvu0NgbChbYbNpgF/gdADZQaqPWje+4O7dPx1bvrtjO/thJfbIWdjhD6d
 eRm8UfqsC2CAL+rLX0ExruRRVe+CMnUrI+b/p4ZhroMJab9tt+/iu4Wii5Bjh3b1+ibqAmXuirB
 8O9iaYMFuEssYwFDP5Shj8EpQxy1lEB42jYW/zJgSUNDSg//uie46uB702SZ2rMlaPxcYMdQGVj
 ozKHHkxYFkJrXWUOgnv4jD7qQcsbS6sBo+uDG+GyHC/H
X-Google-Smtp-Source: AGHT+IHxW+BKsWZhNeXBuQqw/9OfQS/zLpNmjG1NVGysagMA8Kkj1IWga6FwubRMcVCFBkEBjStitw==
X-Received: by 2002:a17:902:cec3:b0:21f:c67:a68a with SMTP id
 d9443c01a7336-225e0ac91ecmr232958755ad.31.1742317362811; 
 Tue, 18 Mar 2025 10:02:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4e0dsm97501595ad.221.2025.03.18.10.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 10:02:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250227192723.406066-1-sjg@chromium.org>
References: <20250227192723.406066-1-sjg@chromium.org>
Subject: Re: [PATCH] qconfig: Correct unhashable-type error with --scan-source
Message-Id: <174231736185.1761706.177939189506575347.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 11:02:41 -0600
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

On Thu, 27 Feb 2025 12:27:19 -0700, Simon Glass wrote:

> This gives an error with newer Python version, so fix it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] qconfig: Correct unhashable-type error with --scan-source
      commit: 301c2ab729447b0f7c602e054c3f22a5a9df1b24
-- 
Tom


