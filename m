Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE52E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 00:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D53804B6;
	Wed,  1 Jan 2025 01:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mQc+a+36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E05803CE; Wed,  1 Jan 2025 01:59:15 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E1080196
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 01:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so80838536d6.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 16:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735693152; x=1736297952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8RXtuLopqu9ieI/jo/f1MU3XtEDfSCYTPUrbkAyMiw=;
 b=mQc+a+36al5ogf+gOWGblwVrvd225wj520CfcJacVoZXesBSuDCz4ss54SfcJTCQeh
 N0I0jqz91e/TLSk7wSuooC7W28MIb1+ESwb9sCDtx44sszf/+xxmCK0xT1Cy0Bmij4VW
 dBAi4nrKGcTyJVHJ+NnrZY6C5JbQ8o8nc8rrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735693152; x=1736297952;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8RXtuLopqu9ieI/jo/f1MU3XtEDfSCYTPUrbkAyMiw=;
 b=n2MXcxiGl1OIRmFRuVKsrFN9+IBYyTZXiK/eiq5K7xwAPowxOc614Qw2JLOzs14kSG
 DBTdZ0CJ55H0Tp1yCzKKbzFYkU+XDJ/60g9AdtK9uQCyBWdkCsPDci04e62/O5H1xZzh
 97LcnUTFVztGte0shKBOVcqRljMv8og3d9BKWZr9l0H0aM/KaJxcRfuQnnIQfc2bRVl/
 iNusGqqo1pSh3MRVD7fMR9JUaRwq+b93ZXyNVQ69MGW3g/zAgt0eAREV6MGgZlbLR+2v
 PjDy6x8GfNImBiBULSkaExyRUvCKjbWz5RpktB/yTJ3tkxCh5sZHBCiY39iuX8KBO/nM
 GtlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWozVq1J1mf4B6YqQH8D+2BL2js1BnFNijjkXvSu6R1PfiwWGZVUkAWSwvFzBkx3s2pkkuohHI=@lists.denx.de
X-Gm-Message-State: AOJu0YwZNusAer7Dicx9IxcLNokDGYtOEvDBrBdrxILPgxV7KGdhNv1i
 HuCfPrkn28hlSTsDjCJmsFdVJjLaXoq+3XoyhbUPAFMgplDmEOKF6M7YCoSutvs=
X-Gm-Gg: ASbGncv+Y2UuWUQXB2hjQ9BV66ENGxobSApY9jnhT8Rma4dR41z2WWiZjS0ttCb/8cL
 mbKQcEElgM214f7h1j/08Gd7aJQIT8er85Wri3DL9d62hcOdeAiu9+U3hrOrTTPvyj5NUdVHgHn
 2oEG6vFux5db2ZqiXD6wz/8LGkpMX8fW1i/GEBpboCtvAze2bZ4Gtdcnu/WeTqZbYSFBvsUHuCg
 tjJp15pwBqhmRNX1vl+a4Cewhyy10UlG8z0l+SFypY4Fd/PhozS2xCt
X-Google-Smtp-Source: AGHT+IHOtzzRzZZOaQci3X+lTwTl531dLBfq7VbJJMk7b9J4sOb8zOy0JdVM7tT0YYN9JRvYFblWow==
X-Received: by 2002:a05:6214:3111:b0:6d4:36ff:4358 with SMTP id
 6a1803df08f44-6dd233571d8mr832874676d6.25.1735693152027; 
 Tue, 31 Dec 2024 16:59:12 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180eacb8sm117147896d6.20.2024.12.31.16.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 16:59:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, Udit Kumar <u-kumar1@ti.com>
Cc: n-francis@ti.com, robertcnelson@gmail.com, u-boot@lists.denx.de, 
 nm@ti.com, sumit.garg@linaro.org, bb@ti.com
In-Reply-To: <20241218055514.3898679-1-u-kumar1@ti.com>
References: <20241218055514.3898679-1-u-kumar1@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j721e-beagleboneai: Move to OF_UPSTREAM
Message-Id: <173569314974.1610380.7748408028572700861.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 18:59:09 -0600
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

On Wed, 18 Dec 2024 11:25:14 +0530, Udit Kumar wrote:

> Move to using OF_UPSTREAM config and thus using the devicetree
> subtree and remove unused device tree files.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


