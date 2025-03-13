Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ED5C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E8B80FF7;
	Thu, 13 Mar 2025 20:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtjJEd3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE208168B; Thu, 13 Mar 2025 20:57:21 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0EA80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54991d85f99so2547611e87.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741895838; x=1742500638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fA/buzX9YgKRpz6z7c+A6VJvDKMKYwV96ExLuotm0UM=;
 b=RtjJEd3oj9rTra9K/yplXYrEcDSIWnoHZkKvbJgnwEaFE13YZjmHw9Y/UPbHvy9zKF
 O1DaV3dJF6fKhTu8VTB+uUEXi34jU0e+wabYXuID4SnTdy66evuIitQY93NXTBlYpqR+
 XFfn1/huBw329TWbIbByE052DsUzxfOPM+EJRj3h5NcbaGOc5Y18KANzUGVK8/BLpFji
 h5Tg+PlY3O9ofQP8igIqexQbpoNg95lahAYi0bX5Fihh3mDOTLNAAjXa8SqLJ+s3HLXL
 YU5sZ7lqaMUxJzDBo2spvPBjUf4Cn9Wh5hkwZ6BsCK5xz8/BL+3IRurMWQ5ViA64rOGj
 pK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741895838; x=1742500638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fA/buzX9YgKRpz6z7c+A6VJvDKMKYwV96ExLuotm0UM=;
 b=ZOQk7GQQk0HIergwqzP5BLBPlXQLau9OEvay9zXMowrWr6XyXSAZl2lfZBFan4LL0v
 VTKWYmmDpCY6ITP7pJv1p6nc5FIszgukWw22Qi5/97I4Xi7Vv0RjWLH0W3O6p7tPBtCj
 p4DRUzB6EsS0z4xhSkoTbLlrVKKbmselhBYjg7jlqXuIZ2MN9NdHz30fQYABJGt3gq0F
 /oCJIpw/prEfUZzJ6Ai62mus3GQCgmEENx01CGpOg/rR2IJN2ez+EGiYI6eAOKbkCb2v
 vC+oNrhzD2Z9rbLdR46DKS+JAa90WLN7ZA9I1UO4TP7fkkTkrnXr6zIk2P5iXNOamfTI
 WbLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN69hExXV7sdbsRRDqsUmS3DrRuiExQZnUWAenEfR1LvY+CVkXhzGhEpUGozLBFt7co+aKgFI=@lists.denx.de
X-Gm-Message-State: AOJu0YxGpLSn5kh7ZtSo6/H/G6c4u7ovWyzSXDc0NjtN08je3HiOgBP1
 jIvXUZc7K23ZqBaLdqPeLZ7cbTGJpv/7WVhg9z7rT8gw6cC2J2UKAiVM9VPqAgpPUbDZPYAfApd
 pWdL3dJ+l1yd3Rm8hnzUSmWtjoMo=
X-Gm-Gg: ASbGncu+2qyboVTVtFVqYfGWRh4wqctMpJ3+htsGmSxbhY94DW7vsc+vxF0JC6KXy1q
 HdQBxajM8YbLv7Lv9rwsoolx0w12J6qbFXzCz3G3Gvk7L65zlwnLjqnxqj143NcBW1mC2NVUFdC
 Cpe9ATfTzTXqNjVHcUzfL2byYPWg1De3RizRWJRbAL1Go2AB3pa6pSDlDOAw==
X-Google-Smtp-Source: AGHT+IGVai3N/VrKR02kxkykN0prVaiVLTTwyysZjxA6Zsx7cxTTYu/yxM8XeNa1DLfKWUxLNcZPyKPLS4ZL2j9DiZ8=
X-Received: by 2002:a05:6512:2247:b0:545:2a9a:aa02 with SMTP id
 2adb3069b0e04-549ba41c627mr1664809e87.19.1741895838028; Thu, 13 Mar 2025
 12:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250304065740.2732356-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250304065740.2732356-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Mar 2025 16:57:06 -0300
X-Gm-Features: AQ5f1JpYz4oiFfyQYksBIk4y0eLVCXGTUNjWINa8cICZM6VdyZpU6bV_oIY0AWU
Message-ID: <CAOMZO5CiSmD4z+e2gR1Nem7nOAprZt60iqnzJMf_0WzS=qPKsQ@mail.gmail.com>
Subject: Re: [PATCH v2] mailbox: add i.MX Messaging Unit (MU) driver
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: trini@konsulko.com, sbabic@denx.de, uboot-imx@nxp.com, lukma@denx.de, 
 seanga2@gmail.com, sjg@chromium.org, alpernebiyasak@gmail.com, marex@denx.de, 
 u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
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

On Tue, Mar 4, 2025 at 3:58=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> This patch provides a driver for i.MX Messaging Unit (MU) using the
> commom mailbox framework.
>
> This is ported from Linux (v6.12.8) driver
> drivers/mailbox/imx-mailbox.c. Its commit SHA is:
> 39d7d6177f0c ("mailbox: imx: use device name in interrupt name")
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>

Applied to u-boot-imx/next, thanks.
