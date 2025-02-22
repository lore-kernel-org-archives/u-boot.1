Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01D8C021B2
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 13:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2DCB80F56;
	Sat, 22 Feb 2025 14:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="foBMxF7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B074E806FE; Sat, 22 Feb 2025 13:41:43 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E89F801B0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 13:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ahmed.kilany71@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-471f88518c8so17144521cf.0
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 04:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740228100; x=1740832900; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IrG/5yctKa2sU83VX54+DmW8OxkjrGQP412Mmu+Vu08=;
 b=foBMxF7oMowVdZBlpjIrToqX5R9MwsL1hXycQ3eD8pZJ01bJu7h4czIvCbDVKwTdkm
 dfuxgqVH/BG5wBBzFcX7BAge8YiWX34r8c3SiSHOV5hxT9yq/Z98eNIu//ZnZTSILDwN
 pVOJBg8sSoDEuFU9k4QGOtY4GcZcIDwuO4V365n6BzU/FdU5YI2Anf2pn3oEcv2rYGvC
 EkeGMTjH4HnwT5IPUWeebtxr4ODfdJAEeWdhKAeWbS6RMpUGNSldZHgd7Iy2pLhl7bUI
 0MQu99uGCj50AoyVZjKCid6pO8AL1bE3kxAnmjPMzjeu3xDHlcEs1/M4n7aDkRjky9Gl
 /4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740228100; x=1740832900;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IrG/5yctKa2sU83VX54+DmW8OxkjrGQP412Mmu+Vu08=;
 b=bSZVMCC1VgojrdZkcoA8UvKYafg/cqbOlV3zZezC6aiSAM2Mawk+IGvcCX1smUHQwG
 GTwr/MU95P4IZHYhZkyFnvJw5fRb0FVQGum5qo4Y1kmvcl/30UH5bpBywIvVYuyxGrXx
 uiRlFOtwRX47EyuLXjMyaZmkAMZBNKZ/cY2Z/uouKOgLJ0MspI1fy0bhDRr0QS1It+JE
 Z1IARCIetaLB7Gs1ofcpXdqjxMjyzldN59b2H/5V7JvDubfxXvKuBbkj1RcQpsrVeGe/
 iygFX0EFhmjGMEauWkOIHMyZG4U57lCXiok6uA+7Yf/XChHBG/wZBwQKtfjyyJE++9dm
 s6bA==
X-Gm-Message-State: AOJu0YxpM4fblwabT1pkXwqYgqU/F+RZzUUJaLzES7kDWlcO2yy9Vfi4
 5MDfBFnTJhGIUr2C5CsOGN2umZ6jrcgjmzv01to88aa4r0bRgNA8/ZKpprfg/1SGPfI2ClpCUYX
 t9H2+bhH3Z/Ck5WZN5uN1ZaZtQREb7oK0jis=
X-Gm-Gg: ASbGnctInK5ChWaG4uX4euK2Q5s3F8sspNpTgrOcQNvXawEIlSL53WStxryCFubcdkZ
 p3kuji5gMsuO1kwsVojcE73oF2gWfxdYm8ndcbqcfS01JrG15ii4tqNEYxTb9bqcxAIFyjLestl
 PPI+3KMVAj
X-Google-Smtp-Source: AGHT+IF5yYhbouHDqjoTt6Inui2uzwQ8onvP7lgSyb+GFDzrmsaVjpGbFSVRt1BKmw7ZswKQVPjSe5xcyHcCkMroPUM=
X-Received: by 2002:ac8:5fc4:0:b0:471:fee7:9610 with SMTP id
 d75a77b69052e-472228c2cabmr82137881cf.12.1740228100124; Sat, 22 Feb 2025
 04:41:40 -0800 (PST)
MIME-Version: 1.0
From: Ahmed Kilany <ahmed.kilany71@gmail.com>
Date: Sat, 22 Feb 2025 14:41:28 +0200
X-Gm-Features: AWEUYZmr1qZyQi_B7L7NrIy56lVF13NklwJQ-lE2Z5V8DhYMVShumOCJwrN0R5Q
Message-ID: <CACdGk=1ODgZmkzPPDFCbWXrWOkg6e-UREdWPSUnLbT=Q2Grqiw@mail.gmail.com>
Subject: Incorrect include path in cmd/setexpr.c
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 22 Feb 2025 14:14:11 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello U-Boot developers,

I have noticed an issue in the file `cmd/setexpr.c` at line 13. The include
path currently has:`#include <ctype.h>`
It should be changed to: `#include <linux/ctype.h>`
Thank you.
Best regards
Ahmed Kilany
