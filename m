Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDB2D3B9BE
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD03083D0D;
	Wed, 10 Dec 2025 18:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JzYVYe8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DE9E83D00; Wed, 10 Dec 2025 18:12:56 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A73A83AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 18:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3e89d226c3aso2171fac.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765386773; x=1765991573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7X6WVDAaUw6X44NjMRdMwejJGvAysY6w0obUqeIMz+k=;
 b=JzYVYe8T0efMwqVZpo05/GuByCVf9F8qUuiidHiPmInAjgR/lSa68odIQPBXcol4vP
 1IvNQubFTWmU0aAT+AMsGeeKayy5RU/2W3O3GWL+c5tggU5JPWiLTM2p3hSpIhjpt8fy
 bF3QZoc9Rcwq8V/7ZvX3qYhjCiMbhZ6mef6LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765386773; x=1765991573;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7X6WVDAaUw6X44NjMRdMwejJGvAysY6w0obUqeIMz+k=;
 b=A378TbmtTwlsIC315kc5pEKY8iwnvDUx+5oioUmb9Y9BxC+aJRG78LMCe9UduoCVTp
 sB0jrxzKlcvujKt8xZ2Fv2c8dFLWeL7YV/UVJzpqC2OPwGcMKGpSx8RDtSb4QbnUCuWT
 uy4JNwq9biyBBdSzx5PCx6WXBj3Y+1tcjJ62I4mC4w4Ct4Bll5ug7oqzIQhg2MfaSZK5
 VwnQ4muui4lZRzI+dlHLZNiGcs6DSh3G+F1iQb6gWXdwu73qC/obAg9ZGSUJFHFLtFLR
 JDtlrBOBnQh9zVLfOZ3iR6yCPfpICjU7Y9wjsvcipzpWfD8TJd0pzJsvKmhGHiSP9BhR
 cBig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfpKJ640tuClgX/PUuTv/w8PCuZ4A10PID1QjOfJXHJLH4Cf/oihlQ5aFkBM7DVF3VAzUxwW8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9UAHd2OuY18a6qXKRVDqtSYsGfuNrCG0v9jdjVr6Xef8BhCs5
 dX/zsance6ekU99Yt4V4ss/LNe9+SkL4W+lqBFk7T26LK8D7rezPDnebRW30r6GAu38=
X-Gm-Gg: ASbGncvaV3lC+uFmw0OG0kcMhZNQPoWhdo42KNrISzoA7wbgvexZEAebC5EbELRQDrk
 qUQ9S5aMGPpwM6OcgvMgGOy3WIPFJYsVOqjadZ29zqPpqQ38LsouAkve4VFeLFH8vOuc9PD80x5
 lbFfLrHAruMtyuBw7RVTQmTZt3bLc7z14FagcQmEHKNNOmYC93h3Ix8iPU5H8A59We9FM4alE0j
 MF8OBf1fRCuKn72zgrRNeHjElCg43NYj9s++2b1fvY56lCR7Zu1zm0dKwqxmw57JydnzkUFSfQB
 4o4/BGjSKMwFOFPGDcv5Wb/0dJ1qhsQ62PE1qFpvViEsD2JsKboGxWVmwgjpoEsImpMqO96FCWL
 7kPU4lORyC3qxVaibd9al2GZzKJDT4NJkXxtqvEi8zVqCDUFM6/sA05bH+aCXeBY/qsIgZC2CIa
 DmhRE4OMMysm+99TdWuO1pAv+vp6REJzsxtAD1vJfByOLyRdY4
X-Google-Smtp-Source: AGHT+IHbgY9RcXKKfRs8/9CxnTUVZNDR+nWxjr4lmFi/9a7SrlJ9b6qYVYD+ga1zbCKd6VZF8VPcqw==
X-Received: by 2002:a05:6820:2187:b0:659:9a49:8e89 with SMTP id
 006d021491bc7-65b2ac6e3f1mr1899702eaf.13.1765386772923; 
 Wed, 10 Dec 2025 09:12:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b3480fb94sm34528eaf.11.2025.12.10.09.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 09:12:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20251209223238.415022-1-heinrich.schuchardt@canonical.com>
References: <20251209223238.415022-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] tools: use setuptools 78.1.1
Message-Id: <176538677227.3321367.4632274519160252742.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 11:12:52 -0600
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

On Tue, 09 Dec 2025 23:32:38 +0100, Heinrich Schuchardt wrote:

> CVE-2025-47273 describes a path traversal vulnerability.
> 
> 

Applied to u-boot/master, thanks!

[1/1] tools: use setuptools 78.1.1
      commit: ff80e95fed188ec3d4001129445e414c9c811beb
-- 
Tom


