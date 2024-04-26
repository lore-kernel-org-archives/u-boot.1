Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20D7C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 01:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59C389094;
	Fri, 26 Apr 2024 03:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fU7kAkZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19B92882AC; Fri, 26 Apr 2024 03:36:07 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8410C89094
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 03:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-de59ec28b08so198100276.3
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 18:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714095361; x=1714700161; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkzHoBnFQuBpK8dhprSooHu2z62vBTA8VoLiebB94g4=;
 b=fU7kAkZHphQ1T0/eP3xR94lnivSZJty9KByxditzYALccunwRPusZptakfxhJwySh9
 hUrFFc+BlM9+mHWt9uIVpD1YpXOuu4Vm3AH+6kA4sMXuGsgyIqSTg0Sf33k8SBEpTsE5
 c1IllPtI9wBS4mGG2eVrG311DJtoFbMaDOgaCsmghwJUjRD6wZpV5LGekZwXJWqeLjWa
 hKPs4qd+mDM79IEIR/dl2R+wHvGe2JZcAzZsvGMGX9neUReyHBcWcZ3+ALcVngqDH7/8
 /bH8xzg2LWUrOF16VdJY86wfwkrJtV90KBd2hSgcceBIbDOjqxqMLpBdiTz7Yxy0TBAH
 amAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714095361; x=1714700161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkzHoBnFQuBpK8dhprSooHu2z62vBTA8VoLiebB94g4=;
 b=l2ndebJcv0VtMdyJ/b8YmXLUoes4Frs+dDjPqpzoe+EbaNRmomsTlC6qNVjYptWlbN
 DmhYLwSibxvXwyi9SdWltaLbe96J/MDE7KYAnhstQlOKRzz7ZpNu3FO2Ltsj8i1ziPir
 9M723W8w23rR0rEm60jAfSG29j6M+shZi+DqWuQ2q7+HEokZfYQgjoXqbt+pt/PX3m9g
 4Ssc3+JbO+0gsmtDG9eKHmx3dHLw0t1hswXln96FRACrMIMKEvqapMBoHxZ3Ly7tULQb
 RQohE2ToQwrYRT77hZ+gNy59GQjHk9DOmD62h86ENeLgqE2NOQIsdyHaj0kNzsgc3ZQ/
 q/eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbgjaTTiOwXPOYaal7RnRk6Cm25MoMC1tlm95zvZ4g8lJLwMRx50pSmh65HvD5FuV7DtUjaZIIsyuqH19X/EyiONwSQw==
X-Gm-Message-State: AOJu0YwqNafkvWFuc6ffkPxNnWkmnpYhtUMenn3VZqdYjs3t/P5o0YRF
 085J9dLbwgdO2P8dfOrCmsK1l3p37q+Lr2SH3r3uOhGTkUJylqyxyQ85RiZrbFUhT7Gi4w3z+Lf
 5zVGSbp/K47SAlGEstGslgm9ML6Q=
X-Google-Smtp-Source: AGHT+IFBt72jg1quwX5cMWT+70LKpNNP5hks0YaXIdxkMAr4a66sS2S/DW6KvXTs107J6SfuLXwt4BItBgcjJqGy79o=
X-Received: by 2002:a25:aa6f:0:b0:de4:be6:6449 with SMTP id
 s102-20020a25aa6f000000b00de40be66449mr1407202ybi.4.1714095361124; Thu, 25
 Apr 2024 18:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240426001419.1210364-1-tharvey@gateworks.com>
In-Reply-To: <20240426001419.1210364-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Apr 2024 22:35:49 -0300
Message-ID: <CAOMZO5DYtWRxmBH9n5W362ajx8VRxmwwD7xEJ7hv-kAFbrKkMA@mail.gmail.com>
Subject: Re: [PATCH] cmd: mmc: allow use of hardware parittion names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

Hi Tim,

On Thu, Apr 25, 2024 at 9:14=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> eMMC devices have hardware partitions such as user, boot0, and boot1.
> Allow these names to be displayed when reading the mmc PARTITION_CONFIG
> field via 'mmc partconf'. Additionally allow a name to be specified when
> setting the PARTITION_CONFIG.
>
> Before:
> u-boot=3D> mmc partconf 2 1 1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x2
> PARTITION_ACCESS: 0x0
>
> After:
> u-boot=3D> mmc partconf 2 1 1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x1 (boot0)
> PARTITION_ACCESS: 0x0
> u-boot=3D> mmc partconf 2 1 boot1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x2 (boot1)
> PARTITION_ACCESS: 0x0

This is a nice improvement:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
