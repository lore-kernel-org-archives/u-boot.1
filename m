Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BF3C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 18:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A8887D2F;
	Sun, 24 Mar 2024 19:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G0tPIQrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA7A875FA; Sun, 24 Mar 2024 19:01:38 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BC4387DD8
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 19:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29f8b407610so216352a91.1
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711303295; x=1711908095; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1LVuf0hgPNSYzPbX9+B5o6h+3r4ZaZ8DhJyIpL1Jytk=;
 b=G0tPIQrvZOqJwsEhFNou3+OMtTXssVjWMr4Y0jkhI8q0sICcQu6GOnn6o2e+SeBhfO
 EsfGhpgJVT4MqEc7VmwrmO6CAgotF8814uTpMmSSMQdfZ+tH18H8TrSPJJU0xrZR5ZDG
 Fobw5uXPqwGhAUGzaSynUx0RZsoUC+nORVjoz4ZVzfrSJeDhKEtal762+TagHl5Yhuxj
 7ZmrcBTcE0mT8A4j1+LNFsOs4ishBd/9mvduxT94OUr5wWJsoCFG9ioOERbE6ry/Spvx
 5Deq/Pb43H2KGticH9lV1nhv6cRVxdqTjYuKc+Xl3hcNerkIS+4DKd6gXA9mgOrSI8zF
 caZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711303295; x=1711908095;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LVuf0hgPNSYzPbX9+B5o6h+3r4ZaZ8DhJyIpL1Jytk=;
 b=sM/Setw9YvJBUfeMLGg9rUS2E1CS0d8yXeDFur9PX60P9K4UtU8wtiQgZWekfxOTxY
 mkgnxj7G6UY92ldqbPrCdyaRMnrtWlVbkIzhBedJi77ZGmnJr4Hz3JOtOuUfzH4SWXRU
 bdIxTmkloSDVeR3YlLkpQfdIIOkbbggJ2PAxUnfrxQtNrWG+rQAXz0ZSLAawNwsufEKM
 xraHWdfHgvvkPjmAXsDnAkyYODqu0U0E7rMxYC0cTaPdGDfWC68wSGLOIAJjkXays9aM
 rGY/KJNXw4XEBo8DF0moKOrVbzSurrutuVEox2Q3U0jztzFpLClW1WMkPXehpnMm8hAh
 YoIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOv7MQUe6AlXiywVmMtjwxC4cY/cB8tzzvAgojRLtjxgIOJ9YzItVhPCWfxKV+vQQOXjKueZaMyuPrHe4VGuQlEVduEg==
X-Gm-Message-State: AOJu0Yxv5dtWLEpgiFp9afgIxwLAjSGElRmyaItpWcITFUlI2k652SCt
 glHJGesM1Lcqmf2sEuoUhjoofyBHb8/Ouq4/KGU/UI0k6JdNTDBgGWofsiGSqDP2B4+oaQgLw8y
 ay0qOKkIakX8Kfi/N4hmGGnTTthcBbTHw5J0=
X-Google-Smtp-Source: AGHT+IHu5PE4QPeQ5kfGULM1/lvXy9q1hFQeVHfnDnyJ/phzt8d+VNrL3ETfgrB5Bsf9EHjavHgKsb1qxm5CTH/EyvA=
X-Received: by 2002:a17:90a:9f8b:b0:29e:b9c:d062 with SMTP id
 o11-20020a17090a9f8b00b0029e0b9cd062mr4252619pjp.3.1711303294919; Sun, 24 Mar
 2024 11:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240322-phycore_mx8mp_netboot_fixes-v1-1-33d992343fc0@phytec.de>
In-Reply-To: <20240322-phycore_mx8mp_netboot_fixes-v1-1-33d992343fc0@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 24 Mar 2024 15:01:23 -0300
Message-ID: <CAOMZO5CQ6WqPYZ6+B0uXekcjzQbdPanX9J_3poqUELraOhgPew@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: phycore_imx8mp.env fix netboot issues
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 22, 2024 at 9:55=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> The "run netargs" command should come later in the "netboot" command
> order when using dhcp since it sets the server and client ip addresses.
> The previous order led to misconfigured kernel boot params and thus
> kernel panic when serverip was not manually set.
> Further, following Linux FHS 3.0, change the nfsroot default directory
> to /srv/nfs.
>
> Fixes: 60f64bec414e ("board: phytec: phycore_imx8mp: Add fec support")
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Applied to u-boot-imx/next, thanks.
