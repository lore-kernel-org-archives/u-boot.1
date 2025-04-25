Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDC1C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:38:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442A482958;
	Fri, 25 Apr 2025 19:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bmp2NL/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2C782998; Fri, 25 Apr 2025 19:38:34 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233FC8291D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54b0d638e86so2870786e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745602711; x=1746207511; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kt2P0oigHVGQfAOf3OHeJctpfC1hljNKapwAsd1313U=;
 b=Bmp2NL/Vfc0Y9tpZYIj8VP2VYmcHfRR5nmrTwoQajH6FMtryXw+Udgx4+/6bK51uMZ
 Vyg3Xl58iGRim9vw2Q3M+IfjVNUuBAGtw3aDCHdI0SbM8MXYlvi7E+dTShLwaxjEV3aE
 sl+vM8F+iYSUUdmpW4IIq+csgranqbqdbYmJq0ZRGH2i5IlBQYSGxl/Fps0+GEU/Cy+J
 VbhcNQxnswL3NASiKDubZLcArkuMmjS1sU5QaXGKYy3m6kGA82wv0GfN59IzLPTbB5eU
 Rx0Frs3r+H11cmQQ21YnO7BN4S4HJWnHRB5guuoIKyrCVp1BnhW0c6nbqtYOQ8EkTARJ
 UQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745602711; x=1746207511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kt2P0oigHVGQfAOf3OHeJctpfC1hljNKapwAsd1313U=;
 b=CeuRxMdw07FmZvJw8ByNFWKJtT8qEg5XXsRESpdY7158VxQKHEI0u4sNcvR0wN0bzc
 TsR8YvWiYqkIsBqEBUW+PuBkIlb628tsCN72R0fpvJY+G2pKncfa/QjIJrGe8XGKh5M8
 AA64/3f/jz39kJBWv6MW/9UH0MSqmiewcjiPvBLv2xkgvZx4SbbPK09LoQj1+PHNj1od
 O4AXtyZsFWMy5nOqQGW8r86f+dWacYH2UsMMEaxZW1/dhEm5GDXkX5kgg8SFwJ1tbGko
 x86R+PFcM9qmzGs97Ae0CLrcW6pocM0HrVlJuxrNMlynwYqaRszf/7Wpc0MepfZSfZky
 HSzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnBX/L+08AV05btgBGdqktcjS8NqORgw3kkQdtCR+KdqpxeFAtfDn60FUHNC3VPaLIJNEj3Dg=@lists.denx.de
X-Gm-Message-State: AOJu0YxHU/X3NZEcg8f9+IoB/ewPwYNtQ7nymkcNLoQKNomJctkxNILO
 rMa9n6VXERqRfwSSbvrs+LulR1GaatoIpyEpqwRMj3JzCNpG9QfwKQ6izaQsh0jihqW5dUzcDnf
 gF8OlAtRxfF6GUxaLlj/5c23tpoM=
X-Gm-Gg: ASbGnctpvCwNw1AgzQ36uwLyfTQq3xw3qLPuPj49OvJbQ0zut72KSPUHM/fgnykTuhg
 /KLW3kRBr4cgZiKgDt9Kz43s2vCI7WNI4a9Ag8CDkEcZYQIiiboBmXK90gbzXn5NjFtynyPN3oW
 DZIoubmVgblBSJ2btzprj2h/xFZw4nVzrpnC8MG+fgyU3+i/XuN4Nzs0W2xSj0Qy1d
X-Google-Smtp-Source: AGHT+IHFcce659P1A7HAweuHqC02XrXEbL/wpRCmhEhlnhu2AQn57q6o9FL4PWnLtjXFyCqWYTFr+xT7mVQYzCNA8JM=
X-Received: by 2002:a05:6512:2215:b0:544:11cf:10c1 with SMTP id
 2adb3069b0e04-54e8ffdb59fmr121277e87.30.1745602711103; Fri, 25 Apr 2025
 10:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250425135220.1929510-1-festevam@gmail.com>
 <20250425135220.1929510-4-festevam@gmail.com>
 <7519231b-6297-4efc-9d2b-297baa17ac8c@denx.de>
In-Reply-To: <7519231b-6297-4efc-9d2b-297baa17ac8c@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 25 Apr 2025 14:38:19 -0300
X-Gm-Features: ATxdqUHvuED1H4WwrG_vnFxiT8f2YEhS3iNeO-bXq7HyRwi2SpIS2bgpwWEZrOo
Message-ID: <CAOMZO5CvXj7tDpA8HqZytfNcep5YqS3g-b+ZNGcnURUi_jb=cA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: imx8mm: Allow osc_24m to be available in
 SPL
To: Marek Vasut <marex@denx.de>
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Fri, Apr 25, 2025 at 2:16=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> No SPL-specific ifdefs in DT please , sorry but NAK , I already did this
> last year and it was rejected, and that totally makes sense. Just
> include the 32kHz clock source in SPL DT and that's the right fix.

Ok, this works, thanks.
