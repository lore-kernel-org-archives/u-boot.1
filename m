Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA88C27C44
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 12:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6FA884B5;
	Tue, 28 May 2024 14:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z1ggP52y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40596884B5; Tue, 28 May 2024 14:58:58 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DDD38841D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2bde4d15867so151986a91.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 05:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716901134; x=1717505934; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohsdDmp2tNKfQVcnUDENW9lxmBzGNu4KqVN9hryHbVg=;
 b=Z1ggP52y4Xkrq7mb2qsGVlJXCX7W5zVly1crpNc3tvpN1ZIouJFWQJpaS0wy28fF8Y
 JvpMTrsF0TVRPkq+vGoP6+lctjxNTc2HejbQnpswy+aZudvdVjdmqsRpDGQ0BTYREHaO
 Owita89yZcls4Be9rI4gjtMqFSSQ0HV+Jll76H77R1S1vWkVHpf1lX7FCVHDzdzn0VMv
 XkcBEDT3wlrHiGtULvxWbBXUPNJR9HJvb0HnWHs+/fLWm2JiC+kcZ2APJIJ1xnsg7pPf
 tXNdp1keF0LsTHfstwGPG3i6KNBIR3qjLfm6fI8bUwFSz1eFoNVoTpP5Cigw4au6MP0p
 ngSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716901134; x=1717505934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohsdDmp2tNKfQVcnUDENW9lxmBzGNu4KqVN9hryHbVg=;
 b=hlK+MkB1NMQVKjODcvuqsxchTjQ+crs/sUJeGI/F9qLAK+TT1ZJR+BHSzWcqP1B7s/
 5vDdNtZTpfF20l6rWN36ugyPd7bY65mMtKVmj+6LLZGL1NziRinJ237z0FO/YmhmOzh9
 DZdUCVSepx3HQz2RUnUo6FgePpgrXqLtVxuWong+6MQt9k4bohDKULE6eZRcz1mnq/2j
 uXbvKagvx767W6ZIKnbRkTGz9NOp9MqIqxeh+OGv2W9/2YClAcK1hFWSiHr17y0x+zQN
 J+6+CN+ZV5yiDN2ilqUr3KUwg5ti5fh6OvMkcAtCQpQq1LdzrWYfcJ1NMA6wnIGfwJ48
 xB/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1R5zB6WvhpEak2GYVFzGvZ8e28NrIcNd9r0t+6bIyXL3V6hPuxZGSbBiwxogSQY8A5JKnG0Ahz+8SHbTXBy2UZDqbNA==
X-Gm-Message-State: AOJu0YycRfz1zuRkJhsvcogYcQVxetN3CyROg06l2MVTyIUT+SMND7wQ
 79IXfHQyXdsX2AxNMllFX+o0E+Ukmy69mkZvlM/dbkjGvFq+fpCopakZN3UbQSP7pmq4EqIi8hl
 jqoeL0ORtA7QzsSIKor+s6PhZ8Dg=
X-Google-Smtp-Source: AGHT+IGaEJ+K4BzMp3/VCCc3bvyFZmjmR3p7qqpavvgwxHEXKeYQH9CSZUQfg2KmgjQ5yPe069xLZ+7GHMynMQL5j3E=
X-Received: by 2002:a17:90b:3110:b0:2bd:8b85:d7ca with SMTP id
 98e67ed59e1d1-2bf5e0a753emr11548968a91.0.1716901134488; Tue, 28 May 2024
 05:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-phytec_imx8_of_upstream-v1-0-c884c1ddca5f@phytec.de>
 <20240528-phytec_imx8_of_upstream-v1-1-c884c1ddca5f@phytec.de>
In-Reply-To: <20240528-phytec_imx8_of_upstream-v1-1-c884c1ddca5f@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 May 2024 09:58:43 -0300
Message-ID: <CAOMZO5DvUsaYnwp32ykEuGMHxMwfPbkozj4oH20DoJCgG7cz6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: imx8mm-phycore: move to OF_UPSTREAM
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
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

Hi Yannic,

On Tue, May 28, 2024 at 8:25=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> The PHYCORE_IMX8MM is used by the phyBOARD-Polis and the
> phyGATE-Tauri-L. Migrate both boards to OF_UPSTREAM. Linux kernel device
> trees for both boards can be used as is, corresponding U-Boot device
> tree files are removed. U-Boot tweaks are kept unchanged.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
