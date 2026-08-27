Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B67C61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 01:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90CF0405CC;
	Thu, 27 Aug 2026 01:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nlJPW8SLDw5r; Thu, 27 Aug 2026 01:02:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787792527;
	bh=xbVoQqpVD7axWh8fDUrG0YhETFE/obbWwWns/T0jdws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JtTII3jFyhNxLuRL71h+XGy+cAGOyawYQ1q7VVZ5zlvLrBNH7bn+OrxtwtSxXswir
	 dQbP2P0tEDgq93VfEWYihUefH7IuNuqK+WTbOT0Rj+XOUtYQxReNOiYJYWEos8nC5Q
	 UHWiCPku1wvLxQiedWgNwHbLCCtVbYooBcXMLjreccu1+YUKSM2kgYpxCtuFe1gIcz
	 i8wtdnnGv3Vg99m/cYI4k+lacDotJqVE3KSlA0JNvg5K+x8PquubzEwkVlWSBXy5e5
	 CmqIGQqyzOjlkj0v+VI3wysx6KIDni7h/Za3mdVJNreRvHxWce4VOx4F5iM1/w/fVV
	 tHOCimJ0yVVdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB7E6405A3;
	Thu, 27 Aug 2026 01:02:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 74BB9334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B4D0405A3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id odlHxZ5p8fs8 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 01:02:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=uUXLNbRY
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96EE440596
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:02:04 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f3b01b8996so278235a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787792523; x=1788397323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xbVoQqpVD7axWh8fDUrG0YhETFE/obbWwWns/T0jdws=;
 b=uUXLNbRYFT/3Vp+i76MvXPCF5H+/0pcnDci0PlDydlqA/L0tbMbw00y0mUlNpSyteN
 xp4tXtWkR0a9//BerpxVYLxDpoJHTYmhkhV48JbcryoX+9VRsw+J5pe2JesqdpsB4Org
 0T84mIB6RujdVgFimIPsrZEwToYiTwIWbBjtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787792523; x=1788397323;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xbVoQqpVD7axWh8fDUrG0YhETFE/obbWwWns/T0jdws=;
 b=DIaZI8I4apkn/REWt6y5dYJBg8SMu5AYbr810mDiDBQTFiW0HS6yGJ4mVNVSBLLBfR
 2Ky372t6YV1QM1aVqTk0xyxC7LwzDSTwj7848IGOL7eBDUnyBFHOeB0uTTEH5Ct4EGPy
 KXuS9Ag7daIS24uUpo9oU0KWt2QwPa8aeqEziPeNwLCLMSMBk98yXC6VD0eJ6MxdrP5i
 X1m14gmoBIbY+NhDG2VrxE0MAVrQ7HP04v6MsLqJLjQ7CWgjNkuiq72D9O0UoLxwJ1AQ
 lGZTA7637BDQkllGSvZjY6XW6vuk86TsGFaxWmIYx7KwcRg8GloSsSbq0rO1h2IxP9+j
 N62A==
X-Gm-Message-State: AFuF++ka+Qy2APixyq4pXJ8Hw27AfVgLb6njdkx/3KhHnVCiwDsk8S+q
 4CSM4E307H1EPQdrIGu53vWCo8vlg6CNFv/Kq3xeyZbTpJd2gc/X7EMvCWaVWz2i2ak=
X-Gm-Gg: AR+sD10FHQoD0AziSmv0w0u+g9a6GbRWEtugUK2oYPXxKdZLfFfRMZ7L6s6b6oq7/Ts
 fB7OiqP7DiMDnjCKrlqqHcc+pqugDNy0BmVO9yjnHa3gi/Lbl3TsTRAgBwk6SP/SUdzoweuoOk5
 L2QvtNyB2B5C3s9FY821/iBTiXi7nDdiVmFfVlWN+ZxBNNMFWZruMblIOYiGnB4cQnIEVdwdqpH
 bNJvITBbHEhBk2wjZvGFQF4gbt/TEjGVsndh8rjw9UxGJs+q6eFSrsk/UsWPWFjOfK7/c0EIHJU
 cNpqT83NbzIFc1PwDQ9Q+UNsXnuyDLe5AR9Hbq9TEM16oLmDOCWmv92K7YaLeRlsEdT+xR32Z6l
 gBaFEruqoa08HPc9/KqmL9gmg21VEwNcDL3QAeJLzhSnmcmLF0GqdJQTGNvD0V/2uqOtu9c3zK5
 LlzOfnZkmWdoND8YPYvdf+ipdxp6eVXdbwOs0lirGVsdOYHJH9MgnOWOAJZ0WuphkHL6dZEiJtC
 bTkdIKS8MQhRj5gT5yEdhvGYlWd371iOHi2HX09xpzfLY/I1AfDe2Tu4o1U8yGY9s19O9suDdR2
 ob5fHF9W
X-Received: by 2002:a05:6820:628:b0:6b0:fcdd:2da7 with SMTP id
 006d021491bc7-6b1a0373bc8mr9753479eaf.7.1787792523174; 
 Wed, 26 Aug 2026 18:02:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a268023asm3105705eaf.13.2026.08.26.18.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 18:02:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Wayen Yan <win847@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Argus <argus@byteray.co.uk>
In-Reply-To: <20260729-video-oob-fix-v3-0-21d3412212cf@byteray.co.uk>
References: <20260729-video-oob-fix-v3-0-21d3412212cf@byteray.co.uk>
Subject: Re: [PATCH v3 0/2] video: bmp: fix out-of-bounds write in the RLE8
 decoder
Message-Id: <178779252213.4011819.4932700027433875536.b4-ty@konsulko.com>
Date: Wed, 26 Aug 2026 19:02:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, 29 Jul 2026 18:47:00 +0200, Shahriyar Jalayeri wrote:

> This fixes an out-of-bounds write in the RLE8 BMP decoder and adds a
> regression test.
> 
> video_display_rle8_bitmap() lets the framebuffer cursor drift below the
> start of the framebuffer via repeated End-Of-Line escapes, so a crafted
> image displayed from the splash-screen or PXE-menu path (loaded from
> removable media or over TFTP) writes before the framebuffer. Patch 1
> bounds each run and rejects such an image with -EINVAL; patch 2 adds a DM
> test for it.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] video: bmp: bound RLE8 decode writes to the framebuffer
      commit: 5201e83342d64c2f438ea35158575f28225e752e
[2/2] test: video: add regression test for RLE8 bmp overflow
      commit: 7b98576726e6c2779bdf029e2c42f75e7705dee9
-- 
Tom


