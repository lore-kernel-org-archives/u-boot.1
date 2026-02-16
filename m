Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D399BE83829
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8591883CF2;
	Mon, 16 Feb 2026 20:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OvK3WAaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B5A83C72; Mon, 16 Feb 2026 20:39:05 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CBA80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d196a2334fso2834150a34.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270741; x=1771875541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAi6IXD8l0FI241VkKb5dq6Q+7lHltKL3NhdR7XbriM=;
 b=OvK3WAaBwH32PgeQje18X+Ypph4QN0/qTFnwYpN6miqt9o3rRfd1T0dkKQFJk1fUu+
 b71be3GtRWr0Gveo2FlOnCuA8OaZnWXKHNnSKQxaI6qn+Tlc4tA6MIzhigHnCY+ToG1s
 x9h9RSAgjJ6xUcLf4zd9N0xFSnQSycxny1bUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270741; x=1771875541;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAi6IXD8l0FI241VkKb5dq6Q+7lHltKL3NhdR7XbriM=;
 b=glY41j/I1NYYm6Mm8ncpgC1cwkYYHeqdKyGxR37NF6JN2YaTYIjNJTwZ0ESCg+XU2r
 HTXVoEPxcStyv/OcSx7+IKK/Ipu0ZzsuPhwRK03Wy9YveRmtyLOFerovXnHOX9GzL7jl
 KdHqddsELzUL5Te9EzNKvJ5q7FOpfXoh7Ar5r5zwtuRskJH4BTJ1ZnMmAtgJL1l0pyUq
 l1kXEHQTpNaN5u9gOSCIdwNBA9JWDb6a90UlkuUdZLBep1KN1Abg67GR7MtlNsl2Pp3S
 nk58j3k/ON2aAeFVYCy/FPwFq/N3/UE7U+NFDugqMRnMlhlV/HLmdiRn293etnhtoOyE
 eDfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfuZE53F9QX+c5apDDQJkdFSmsRq4K4enwOHjSXNprxlujk8WizTWjYRKiJ/fFbxHeFYXQfus=@lists.denx.de
X-Gm-Message-State: AOJu0YzvUGnuzD37HonbHTHDR18UDvoOgwLVSiCh7ykvT8E7G3tFRyxy
 MKeoGIdVbyCcR1R4iK5h9GNkjFC73wuBlkf+BdGo0Xus6AsegMWvvwHt6bMRYwbEIZRVuDAlCxP
 vFCo9WcI=
X-Gm-Gg: AZuq6aInILrq+16HvWBi68RC3xfokINQqve1Tm+grNPXZtlyYPd0L4xYe6EHCZN6CLl
 IJJXgGDVWy1nyY1nI9zzj4X7FChL1AXQzeXWBIuRbgO/0hzqcuoHzFO85kaU1oBnQQXhVwJdBN3
 vm+j8krafsgt/Pd/JPVLZDI3pQLPnaCKfuwU+nyTvvQJ4i5ZKIE8YTP2e75L+6snSrX9glcUZnd
 SMf9l9hHjoge3Rp9qg8aKw7G4UHosQ+cN4Ky17jemJ+W2meauzujK79vWjFr+ip617YaV0DMI3a
 w0CDkMx08+TF3jG5WOGMrVqUx6NSjGguxUNPh4cGn7NHWiY8uxIf/wgQPKAcWB7zkgRYQCIAooZ
 0kHf4kc/W2/38IV1Q/2H4GmmYTNGxkkK7Ind3eoJzdHuHRRJFqS6U3Xa2Sn0NnuEIBwfLy3qT7w
 DPyxXS15ApFTxF4DzRLULgWk9gtsS6mtsx3Da1Cuq7kX1oK17WPBsqED3ZdenjowtpCstmtCmfc
 Fazy4MvZbaPOn8LUWa3Br9xw+a0LzTuGuLLe+ZbpnSu6owNOA==
X-Received: by 2002:a05:6830:4904:b0:7c6:cd8b:2e5c with SMTP id
 46e09a7af769-7d4cdfb010cmr4847730a34.18.1771270740887; 
 Mon, 16 Feb 2026 11:39:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:39:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
In-Reply-To: <20260211151913.249518-1-hugo@hugovil.com>
References: <20260211151913.249518-1-hugo@hugovil.com>
Subject: Re: [PATCH] cmd: pxe_utils: fix syntax error in comments
Message-Id: <177127074029.2634449.14637909582991344699.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:39:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 11 Feb 2026 10:19:09 -0500, Hugo Villeneuve wrote:

> Add missing "to" so that the sentence makes sense.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: pxe_utils: fix syntax error in comments
      commit: 2ac30d21e459736acb164c363498596872e0bfb3
-- 
Tom


