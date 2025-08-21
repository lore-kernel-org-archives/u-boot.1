Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F826CA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 21:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8785F81FEE;
	Thu, 21 Aug 2025 23:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BC0cDuub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2D882B20; Thu, 21 Aug 2025 23:00:34 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F91B80EE5
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 23:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-74381df8cf1so515637a34.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755810029; x=1756414829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXJobWLT1TjeRArYFbjwgq3GQxjdz5zXJSkVFYDEjbU=;
 b=BC0cDuubQr3cdVGNmHhCTr292LWY/dLc2nHWEV+/vgyW7tAXnabhaCAjg8ntb4FDDT
 4otPW4lgYr08ajSQjwuF+XqDqgXITRssgBUEpE9HTOyJRHyQZPAu2ZL1BG6vjQXo1jl2
 TVGHvqmu181e3IKrd7h7RFgoQoBLbxTTaSlnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755810029; x=1756414829;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXJobWLT1TjeRArYFbjwgq3GQxjdz5zXJSkVFYDEjbU=;
 b=lFqLFo/SBM01Q8NEVilS+wlCnBQ6sFYwiPWeWeY110s/N9GNHuQJTiCJLz4BQV9A2E
 C9VyIJWZkjEq+34clpGtodAPvHuToqmF5ZC2dfTXL+vG7/nU4IwcmzCMXHqtL+7/K6Gd
 W6+ZmovuT9cC9Qem+G796PEal3/xcPK3Mug9cwlRmoNgPd1QZfFubCjqQVUv6iEA1Lfi
 NxhwGm51NrX94UuU+DuN3UWGBlHp/CfZYWi8+SNP9vVFSvklWq3hLyOi6dFTfo1uWTf3
 zOcimiD5PE5WD1T/mvd6RYuG9/iUVjzy3vmd3Se5+q4uNET5Tkylu0XOtaQLnLcQEnhv
 8Onw==
X-Gm-Message-State: AOJu0Yw/M9cLTTp6lXq3/i32mTmYGJHQ6feExbbBVmSxt26kzdB2e96k
 vCc7uV9Ej+s/AfiUVtI5c2KvS0tmsXiNBdjRrADam3AOdTAylM9vZRbi5HlvI4663B4=
X-Gm-Gg: ASbGnctHDZ4HaVztVVnZKTnxJPC9a36PUByqFp6sy63MlKJWvCKX2mvlM+cExvWLycb
 bm2MBFQWSq55AqFb1ZUJmtuW1CFcGg97A7PrHh47c3lw8HvNU/bnoleRYQPwp0hHVt8FJrB7Tjp
 /L2gNt6nIs4O8futB0NbJp3aEE0dFWBunkQRQYJ18D1sFvnOHvhUA/FPhPJmRP39TqqU1gOG8Tr
 s3IbCbVs7OBDHAXbK9G8x/by/dAiBGkR4LMOL+acl+lpH/+4gPNfjUQUQpyXF4oJOqcWX/sL1df
 9a4PpX8twaR9wx/j0pu8QBNdyO9fcZ0J3pFbVPYthErEMguNVOmK6BWAQh7H34OcPcKtIoTP0sl
 tAes9wCev9iVolu5QIfdSQ47Z5rLHzbLEBTJf9Wd44h7HOguZzldOnwk=
X-Google-Smtp-Source: AGHT+IHzuI5SF2pXZx4hLG4A8KLdolKRdgqxudvOuShbOq2kmR42yaBzUdqKNnUDg13pEzP3mZwNOA==
X-Received: by 2002:a05:6830:4890:b0:741:c0a9:9494 with SMTP id
 46e09a7af769-74500a5b6bemr507409a34.17.1755810028868; 
 Thu, 21 Aug 2025 14:00:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-744e06a845esm1631957a34.20.2025.08.21.14.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 14:00:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Simon Glass <sjg@chromium.org>, adsp-linux@analog.com
In-Reply-To: <20250814152733.2514599-1-philip@philipmolloy.com>
References: <20250814152733.2514599-1-philip@philipmolloy.com>
Subject: Re: [PATCH v2] mach-sc5xx: generate U-Boot proper in ADI ldr
 format
Message-Id: <175581002748.928164.16873234591986258474.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 15:00:27 -0600
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

On Thu, 14 Aug 2025 13:28:13 +0000, Philip Molloy wrote:

> Generating an ldr boot stream containing U-Boot Proper was never added
> to U-Boot because it is done by the ADI Yocto layer. Add it to U-Boot to
> support projects that do not use that layer.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mach-sc5xx: generate U-Boot proper in ADI ldr format
      commit: 55014ce40e29fc4a8d5ec146b02ea0c660b03087
-- 
Tom


