Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2621C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 14:57:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0123F87DC1;
	Thu,  7 Mar 2024 15:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KO10Tl4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2A087CFF; Thu,  7 Mar 2024 15:02:47 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 257D48332E
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 15:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=barteleerdekens@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so13203791fa.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 06:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709820161; x=1710424961; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=suEHRMBAcYK6etRYH3gRs9LjJM+JiePS4hX+oMIwVbc=;
 b=KO10Tl4DuxepMfbvKWwop+56ybUQuyA/0nSnYXAkm0FiHGpG4Yc+d06SdCR0MSlPKB
 GDnoDhTyeEhagWMDNbN9nNE3onIauwx6GW1VPzI0yY2Riq8nAVkluE7FhJlTL8uyz5fb
 CUC7bhCRUjN26BlbAf4B2W5DXHiWHQdSr5d4XMkJpqCOeX8rUNe8d8LblyMnUg4MbJQw
 rizx+4ZBDWczU67kdTwlEAGyJ1SUv8sd53Zb6rteY5eQ6WQRZVqFKCsO3YKYqtCsyXTF
 YgMl2S79MWCt0ifaTxXEkCgRiCcyEgZqlV0K5mUGo4Zhh7HO9uaIyTuua/yQ60FF8n4v
 atQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709820161; x=1710424961;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=suEHRMBAcYK6etRYH3gRs9LjJM+JiePS4hX+oMIwVbc=;
 b=pXG6CvLDNjUswCGiVZm2HPJgvObpyl27zltyWNlHCp90wEsDVYDJDb7qJgCK/u+Kil
 n5QxUkRP0T9whqKCI4OS/G4p4NWH9QibVDbocbf3nJ/W1UP8pnxu7vYCDsTiR4KsHSts
 xCke9KkJ+IVq+ieGr6bxpE3Sw2Ec3sn5zSAr9+9DJQ5HaFLFaDtJcX5z6Jm5x6ZT1N/H
 Z3jM7/N3jz+WDjyFurQUxqPLYtzm6mDxGpd8dwMxJQ0RVqu9H3eiBzp2LEWAesbHNot6
 qZ80h4vJbpGU2vsWsKzrobOcPJ4kv7ZzSimNOqzcYB5QWNymD8F/SkHOEZr9/J7oq2AV
 Gr3w==
X-Gm-Message-State: AOJu0Yz5pETJFIWPiQZHWXAvctiH+pi7J08PowzkGUjQ/ti5o2ErTgEv
 wxg27PRwLM7gGV6nlmE9FFlZB65CGiUTh/7xzCADNacKbCU0/utRW07k82Z8E3gG8Xnp805YbPy
 dlogHjy+tqNXrYQIySOOzc1OAGFbGWAgkSvY=
X-Google-Smtp-Source: AGHT+IGzjLHs+W+E6bVoozH0MnDvdiBvBCWtdyfVpw/lW4+Z93erdfCZjrREbxHPBqH7ANIFiMxt7VqfDy2huXDlK5o=
X-Received: by 2002:a2e:b8ca:0:b0:2d3:3e81:a1f8 with SMTP id
 s10-20020a2eb8ca000000b002d33e81a1f8mr1789309ljp.21.1709820160912; Thu, 07
 Mar 2024 06:02:40 -0800 (PST)
MIME-Version: 1.0
From: Bartel Eerdekens <barteleerdekens@gmail.com>
Date: Thu, 7 Mar 2024 15:02:14 +0100
Message-ID: <CACkjgw80c4eY183Gn-d27tTduKoqqKcUDK=_8mz5-iR06z_9+g@mail.gmail.com>
Subject: Re: [PATCH] mips: implement __udivdi3
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 07 Mar 2024 15:55:57 +0100
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

Could this be merged?

Tested here, and solves my mips32 build of squashfs in u-boot.
