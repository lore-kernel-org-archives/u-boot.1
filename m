Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219DEC10F13
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 10:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C11387A47;
	Thu, 14 Dec 2023 11:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LyUdSsFm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1464B87A4C; Thu, 14 Dec 2023 11:32:20 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A0087A35
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 11:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28b1481f601so35675a91.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 02:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702549936; x=1703154736; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5vU2XMTk7CRW+Mb+MJUFMR5+S0dQKsGpZ2eJxVwIJM=;
 b=LyUdSsFmhjPHBpghDPgdVX35pgyZemLpQxEKgcINTyxFA89ufSnQqLDQs/8VU7N5f5
 FhpjoYvv+MH8LyW4V1CKuNzVHE6hj+O5MFCmKN16CQOO8WNxK52sU2WOfN1/VPqhgFCO
 HIDc81SFLb5ac5jUNFZKGkGm0L65CzDnMNZUCqmNuPlLEl10Epd6aQ3N8RhNljSC150a
 3ej4NCYW9KcRLJWcmdmq9uBtZx8cvqAErB2NnGCjuLARZP1UckUYVB00OoFwDE2NSPtI
 nlSMJbgJm7rHKc9TG9P8LT/mZOvIhww1z4bLclSZjT2pkJGjlm357xz+tU0uA3L1VMFa
 fZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702549936; x=1703154736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5vU2XMTk7CRW+Mb+MJUFMR5+S0dQKsGpZ2eJxVwIJM=;
 b=pdzNc6Hh8yIV3OIfrn6ULpHDnJ1FlbfK5bw3IcuLCCJxc6nHXQ0r3cpsavuX8KIl7E
 tnMQkeyEC5U68XsH0BCiwIR29X6AfyMJZgaVG/ikravJEbBo5gPm/gFFIz3/z2PcE5Rl
 J1TZLGINIsSRscE3dNMYQyfQIm5ghFFouJBfzHWBKEhfshGK/UMu3MKT1KA8lV4W6K1t
 gDz/rmrq9UdHDKYqQnk1ssFVHJZ41q0QRUT163uJ8IgM3PSY78nXHXfETXc9VBJWu9h7
 E4AiuIRC5L77srN+p29RHWBLNO8unDaavK2BVTc3mcP7kJ80SxcvNSKp6sy6jOyLC10l
 Rpxw==
X-Gm-Message-State: AOJu0YzFZIgFAqQgLUVUM7imqCV2kZzeAS5VoLgf/XFl1VXmIjvcsd8P
 k2Cj5k6odYfsvZBGXUlFjuxCZD/2YetjGKbzbFo=
X-Google-Smtp-Source: AGHT+IGUo5f1tbs7fU7FYBHYo3nqcRf7BUPJkIhMPqJ0ObfMSXG4wrhteuf7HMeB0bRZx1fINn7AMQng8z4Pc9sL5IM=
X-Received: by 2002:a17:90b:1055:b0:28a:f2f2:331f with SMTP id
 gq21-20020a17090b105500b0028af2f2331fmr3181803pjb.4.1702549936179; Thu, 14
 Dec 2023 02:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20231104163243.117404-1-marex@denx.de>
In-Reply-To: <20231104163243.117404-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 07:32:04 -0300
Message-ID: <CAOMZO5Dd8C3KVUTJHr+oT3sTHUzMZ8Sod2dH6oO8wNuNvimXoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: imx6: Enable TCP, IPv6, wget on DH i.MX6 DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Sat, Nov 4, 2023 at 1:32=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable support for TCP protocol, wget, and IPv6 on this platform.
> The former two allow users download payload into the U-Boot from
> a web server, which may be more convenient or easier to set up
> than TFTP server. The later is enabled to future proof the IP
> stack on this platform.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx next, thanks.
