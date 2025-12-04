Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8563D2CDE4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE22484194;
	Fri,  5 Dec 2025 00:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J5qm5SUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A9B84144; Fri,  5 Dec 2025 00:10:35 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B27084057
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso1685822a34.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889832; x=1765494632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ERxERwBmKnVdfg4/ftutoXewG7BGte71wDkI8st7ckQ=;
 b=J5qm5SUgaqvx2ZTC1bJlHF64juNjV9tMFJZkNavSBw3m8LM4KrzAP21kphdjIFjUHm
 L6hI9fPQCN/Mv6MCNdXhCyjCMzCdTUX/jg8euEoQ9eQps6DrLvZa2yiW0oayb/QgJfXL
 YSGQVu6jO7PQma69zrdsEPvg2qoOg4efOP1yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889832; x=1765494632;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ERxERwBmKnVdfg4/ftutoXewG7BGte71wDkI8st7ckQ=;
 b=GaRZF+qpcjNGIOXwV9poYzkjz3Tw2JIzWXvmZcmi95njnWo0cPs36vatcOgFZGWKeZ
 E3aKO2CydCYBfStlWQO86Ry7vekHZnhz82YnAuUsPUI9+ng0pWTIV4QIJ39D0Fqa/Pq5
 Ob7wF6CFmjP5mIfGepIx9LWXdjbkauQL43VEn9ZzBmCsyyGyP18Z1SsJd8BvLfCrPAmm
 RbkAns6IVQISLxf/cxBHuu4MiI7NpKM3UqJFBksY4aQ7GO4ts/JDa7MsQ2SA+yr7SU11
 BKW12qaBPQd7HWAlFOwgnk1kvwQ5SnoBHItvo9uAgKjC2jECgHzAvY5TdYkoyX7Q03g7
 qjow==
X-Gm-Message-State: AOJu0Yw9F2Qy66e97LxcnRFMeMyPkV6egcZSYrO1GA3cj4msQ8N71Er6
 +ZsrQcTG4zGMJp0xEykgP/O+/vpjvPb8aFpZ79bTZzmShTg2PQ9C0Awsbm6VttTjd4ekX6BECXO
 +ghRRpqQ=
X-Gm-Gg: ASbGnctOUOJMc8psjYqbEy/goW5HoE4VJDPXyY94y+xA1OmmHGLAd4NvByYFqDCHYdr
 4CXzxiMsri4BAyDLbNCMTKRzj57Qd5jGj7TWPaFGCWM22fry2U8X21i0c4Xy7aQ7t0Kd2XRfGLg
 n5n16rv9x9SFCi5lwzFYdInhJs2+eNOqlBPeIaGVBYj5gp0igNOhsMHt8JkRHqrgYM5tH5SWYwV
 Ei6mzVMu7VcKeG1WkSUtJh7U7KT2lK7xzmyKjrE7flXYXrcGh+2a+xv2vgHBoMlJQuYbgfznCKz
 2mX50dgMHYxs/Vaz4yW8tXunozu1dqDLFzU4efJ9QrX1EBIT1emE3EoM+aJBPCWbynWpCDWUK8X
 gFuoOV9GBwy/c6Y86hjpHTVpZGLPlmmzg/XghlF8mwWUiQOags7gNqcahNPllKMh0BmJftfT1dW
 cOJPmSRA2yblDRssl8zS1H5y6AdU7c4m6AjQK3DJTVe03gKDuF
X-Google-Smtp-Source: AGHT+IFv3csAgPy7XRLpARvY6WV+vMH88PnDGMd1JsgI7tI0MxlULyyAVjblhic5uQb6Tv+NxRaFpA==
X-Received: by 2002:a05:6830:12d7:b0:785:6792:4b3 with SMTP id
 46e09a7af769-7c957c597e8mr2532888a34.10.1764889832121; 
 Thu, 04 Dec 2025 15:10:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251119145516.843145-1-trini@konsulko.com>
References: <20251119145516.843145-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: Remove remainder of xpress board code
Message-Id: <176488983116.2091996.17827460852064277260.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:31 -0600
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

On Wed, 19 Nov 2025 08:55:15 -0600, Tom Rini wrote:

> When this platform was removed the config header file was missed. Remove
> that now.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: Remove remainder of xpress board code
      commit: 231de856cb75b7e11b0c506d4674d96bebbef1a1
-- 
Tom


