Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13314CE8D47
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 15:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B20583A6A;
	Fri, 14 Nov 2025 16:35:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pj3EMl00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A4783E83; Fri, 14 Nov 2025 16:35:38 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1A3783623
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 16:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c2846c961fso1489917a34.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763134534; x=1763739334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k31iPHeqZEGPAm/zf6QY1RMHK6+t70dRohkwK7lN2vo=;
 b=Pj3EMl00iydXNplRIfcymn7MlymW/pPjOr7zX5aWc8IbkQrsjURgIrp6yYSuo3XFqU
 h/gHXJRpJ0qPIqKjK9grUU3jp4CfaWtJxxn9SZL35Pr3zkQ2gXlGS2i2hZPMuRisf8qf
 /DmLRzKmZjK6EN3q9Pg3d5CicPRViHjgnXv4Md6ZaVm/RhSoOHoEVRtQm8fawR7Ea38n
 J3/YvW5lqLCm6EnfL8rKGx0hXKs+CLXXT7ZShxClAN1ePreoth64XpBOBcG/eVRa9CGY
 Isjpq+6jr/LNyo0uU8L1slYiEiFKTqOlOqK22ed4iw7VpjX5bEcgHkXHqeO/YDq2noYX
 KrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763134534; x=1763739334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k31iPHeqZEGPAm/zf6QY1RMHK6+t70dRohkwK7lN2vo=;
 b=u0/Fj/B2L8tsOyuX7Z9Y9+2yEaGJm5AMxgPJP4WkOEF3thSKepY8PY6HLh52CT70eU
 n6+XBEf30zxYq9Z5BTzrA8wHppvijBaQscYymaLSnYkFZxV2B2i34whCXup5a+4FtpFK
 BsmK45yIInGSn5+J1n35yIzcV3rKBrdjR0pgNqBR5cNPn64lqPgibP70rhzrc0eJv0nz
 b2brdmFLdMHRHj+YFuZ/qHCImGaN69/+TmrxrpsQyBJIc8p3q3i4W2ZE/3vaq8ndiCrS
 vZmo7NB6qDZbMlPvfqKmAmtmX8FybYYodcUfqQTbdjqRoShIy9BsLkpJfsKzn+Fsx7Ot
 nTuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsy1/3qLs8G7KXu9g8BnZxbKQIMjFRl4P2/oruc0b1VoCcCxfut5oULTHPHkWbcuPbXQjLgKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzVXi4crEyNpYMXYCzz0WJ5miIf3sWWNXg8JyaCsfz+Wa+z4lS0
 NmLz0EKaBIXHZiU25yRSw3n6W3noUEfnBOB5c+jcXsw/3upBZvXkwmLzp2w+RRfQjzk4xA89HWf
 GCm0gG6Of5QFWrCCubP/KrkLLBC08bbg=
X-Gm-Gg: ASbGnctTV08wJXz3tV9uaKfPJSjijQlvo8ztROR6sXjfqZzWNZu1biItxyGvGCDE1/q
 DnsfgoxQT10a+kTh0zcWVBOll4F1+7ABUIzmacugNo4zZDTBJZH+oJmVBR8rYx/H7YlArSSGRXJ
 LfZ2f/Eqr6smt3j3NPJmj6AhJwbXInvcLcgSMqVj5XwkpghPax69tmMIjRxGrPfPdsE24DRzHYq
 kYmdZG+auKuPGh+4cOpNVUHt4OUFZUdo4/dnW8CFVWyWuVhWCYKKsX9m1Ji9g==
X-Google-Smtp-Source: AGHT+IFeFwCgAWubjFvsVWFVqkOBzCbNhaTA60XGtxkZCr1At6dq3cCQ8dxuHM2e1AclN2EJXo1F+ALblZ10OVbQi5U=
X-Received: by 2002:a05:6830:440e:b0:7c5:3e0c:487f with SMTP id
 46e09a7af769-7c74430d334mr2409816a34.9.1763134533006; Fri, 14 Nov 2025
 07:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
In-Reply-To: <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 14 Nov 2025 23:35:21 +0800
X-Gm-Features: AWmQ_bmO5e-eyksjWI7V9TLAda3KsKEOqU0yijQ4c-nJZUjD4vQgaXei83ivImU
Message-ID: <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: Tom Rini <trini@konsulko.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> like Cyclone V, and Arria 10. Our initial assumption was that users
> would primarily use the Altera official release repo, where we have been
> gradually migrating platform devices to the driver model stage by stage,
> including clk driver used in MMC driver.

Tom, with all respect. I don't see those previous patches really improved
nor introduced a proper build environment for supported SoCFPGA series.

Assumption is not considered as a proper way nor correct way to patch things.
Simply removing critical code and breaking other SoCFPGA families is completely
unacceptable.

We are not talking about code improvement nor cleanup.
What the previous patch actually did is simply remove old generation SoCFPGA
codes and w/o coherently coexist old and new generations.

Brian
