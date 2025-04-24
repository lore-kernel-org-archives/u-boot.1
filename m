Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294A2C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F39281E72;
	Thu, 24 Apr 2025 18:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lMYdljDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A82881F0D; Thu, 24 Apr 2025 18:43:47 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE3108003E
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7304efb4b3bso544947a34.0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513022; x=1746117822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IcqsDfnWYgjaTyl6LJjBqdZCOA8do+H2mIwGQk7tw8=;
 b=lMYdljDY2Zm8nudZpF8nSDQV0caKvraviUwtNIpM6jfi83xBreLAtiDEa8yV1odku1
 4d0rQydsKtkDpsW9C1Nbjgc7LxNVdvA+aMToyoQkiyxPLOkmpAwbyVSToRltSAXYh6ig
 zhAalUfESDT2Vw0p4Y0qJAHim9VmURDejq2+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513022; x=1746117822;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IcqsDfnWYgjaTyl6LJjBqdZCOA8do+H2mIwGQk7tw8=;
 b=oAC/FXgYFut4qHy1SEa5zCFA1FU1rRaMoWBNJX35SNwnt3yGQYddgA15buxeQd1Ls5
 dDGP2dVUbvB+QjEwpHA5C510bUGa6EJ0r8KAYagJdm7C4KC/rKzdSoJWci3tDxG4ukF+
 JAGC6PFeK94uvIDf51QDVxgRRUC33LGHmujH83orqqePeRMn8hioV6Lupmf2Uh9jRcPc
 PJRFmqkmcs/Mx3870lFw7JgS9Xkm0y0/dYS8RddlDHqpSMamr4ipJzorlaeWuTrgXAiR
 CgJ2DLy0NwOjWvIcyKK0I1VdY0hOai0GAZFxam5N3xjvmCwI3ngDbbu42VRDOc+jmtw/
 d/Kw==
X-Gm-Message-State: AOJu0YxG6ZakaXhTqtAApyWHQssBJJiWqjgdWO76EmmiLnb12nT1IqSX
 Jw4uuVPn2N9fgGvzQ4CiPNLvz8auLu83NC8Xwx4njN0Bfd3N4nfpdqJt0LJRdJY=
X-Gm-Gg: ASbGncvqAxdKK4lzciE6sBn2bf1W9vkrKH2B7XEpG528zBgGLWwOsdfMRmXLh7L/lmi
 dNW3oIo42WmZX+aiT/v8zg2AGFBTWQGaT+KrW8eVlFnNG+7z8hUI57pQUvJtISnOjWs7+qSxSD7
 1xT/YJnkKnu4d4yiRldkKmvA/fgv7M9xx4aCKpoZbhD2gSY+GQaRa8ap66Ghf3538TphPz2E/f0
 RwUm5wBkccW30qrgmb+NxQqW+dA2TfJ5nVgYNddPMb0irJyQ1C2saOnvWlePrTqNRUFa9dKet+3
 AeksFB+GDCcWq/p2wMm2VRaiU5FKjPsU95HcN/KkYbK/XmZ3hjrGGI/SNUbOXOw9PXJZN9GLo7q
 1
X-Google-Smtp-Source: AGHT+IFXwJ4oyBDcvkj5GGeUvL82E0xDqZIEnyxtPbpMCd8ddNE1VEQjIQj9oaqtjarOjUVaQhuFXQ==
X-Received: by 2002:a05:6830:600f:b0:72b:9316:d596 with SMTP id
 46e09a7af769-7304da4ce47mr2358510a34.3.1745513022609; 
 Thu, 24 Apr 2025 09:43:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250415095028.446254-1-anshuld@ti.com>
References: <20250415095028.446254-1-anshuld@ti.com>
Subject: Re: [PATCH v3] configs: set SPL_TEXT_BASE by default for k3 platforms
Message-Id: <174551302192.4069373.15561249789496004711.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:41 -0600
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

On Tue, 15 Apr 2025 15:20:27 +0530, Anshul Dalal wrote:

> SPL_TEXT_BASE is used as the load address for the main domain SPL on k3
> platforms.
> 
> Since the config value is the same for every board, this patch sets the
> value 0x80080000 as default for all 64-bit ARCH_K3, 0x43c00000 as
> default for the R5 cores and deletes the instances of SPL_TEXT_BASE in
> individual defconfigs.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: set SPL_TEXT_BASE by default for k3 platforms
      commit: 7d8c3fa26c954f575842d739b4e0b9def4eefae6
-- 
Tom


