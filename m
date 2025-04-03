Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BFAC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E698E81FEE;
	Thu,  3 Apr 2025 14:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kohlschutter.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kohlschuetter-com.20230601.gappssmtp.com header.i=@kohlschuetter-com.20230601.gappssmtp.com header.b="T+giOSbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C849482012; Thu,  3 Apr 2025 14:46:34 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE8B81F69
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 14:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=kohlschutter.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian@kohlschuetter.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso3659504a12.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 05:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kohlschuetter-com.20230601.gappssmtp.com; s=20230601; t=1743684392;
 x=1744289192; darn=lists.denx.de; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4lTSc7u2z6y/k3zmXFYFTNl+ofhXP/iS01TXXMeBrQ=;
 b=T+giOSbjstR5WQRkT2UAUfZIOeQwupkxUYErayE73q6pxhY12EPGPfgpXErmTmr8sf
 f2CtdxJrcYhD2z8J5rpR56DatZQQs5mkf2eLKdTYBZRnZ42xxk4kVN/Gmk/g441PFZLe
 4EDDfT3lAyq7zSP4lH99MGTiH7DcR9ZKIVZu+vACn5gqLDugiNS1oTyNvGEaTm6B+HTB
 Mn/DmraY6apSML3SqpLdtVP4og6myYo0ZID8XfuKtGnOU9zePaXT8FeJeRrXf5uLIT3K
 QIuaY4V0HntPpYaQ3+Z57Yz7ncnO6wQ9fdDIaEh8GDkJa9flGwFRImcSzs2XG3x07vp3
 YFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743684392; x=1744289192;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4lTSc7u2z6y/k3zmXFYFTNl+ofhXP/iS01TXXMeBrQ=;
 b=Sf9hUCkC12WkOhX3XQhfDZBZuXlPRVGcxNr/QG15YFx/UdSJEk8INLOovZtra4Z7ek
 XoRxgv79p6ZuH+Nm/mnvSpNamTCGgtf/GIr23/zMovnniaS+yYRqAg+JzhQRvRKtKu+D
 KEdi+rBkUc27dmLhzJg+JYhTohJki4XgXv8LcI6DeA7YfOe3lczkFSsBqoOz16lpFNxD
 IMaHqHu9wG+LBimQidaBI/2ZgZO9pv0109ZiDSgjwIrOMj9o2RdD2RzqFFdZEwi1mDwh
 9+56Cya5ZDtkRIrT8TVJAFTjNDY7cdfS+oO/EXLwMPUlZ8u2rrQw3z830plQJHwWzMXa
 5Ekw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+h/iAcQdD+BPG5muxnD+BgFlLmfQVx3tW78DDCciUGytlfvqNft9Qc2HlwiNYNj2b8uHaZGo=@lists.denx.de
X-Gm-Message-State: AOJu0YyfvoKsWjEmXj/BJoJMi+MY3sHYUxZnfmKYUrQsHgVG2LD+kWFH
 /nVY63nt3bJXr9fXkztu6T4WRnyICSNtA/Ozq9GZHe9E/iLxogjRXQDK+B9nH+w=
X-Gm-Gg: ASbGnctsyieHTtHROyYI/2X2/88RfwUz/xqqkhscudzWB+4PS2MQdSwF2zhiJsW7dyb
 bQ7/FKu1tfMbxg/JXr92db/TfwsgHG23pPHsPYVVoeJ9zzA2PlJThLy0v+3DhT0lVymn6JQgGKA
 Ff33yIU9uWO3j+iAAsGK0Gcquuqy5GVelGMrKNP41Zt9TfLyTWyGLAZMwRBEYpQUCoy7iEhbrdl
 g9kQu2q/WGipCrr9GO3EMqrwAFOr/IB+cNKV06EEbDbNkBI22LbT/xTP6NKC5kQuzGNWQ4krnV+
 AgAB3PUSaVCcpjFPjdt1qFpPOEk9o6Ou1GAZiKljhWcDn4ChKt0GUM2QywbmbhGko+Ne
X-Google-Smtp-Source: AGHT+IFWM8aj5sBKilaZhLK5GvfTvfBVv3WZi4zSwk1LjOPl0j5uBRjG43BTF+rn/3x2x3O8mzNyaQ==
X-Received: by 2002:a17:906:c10b:b0:ac2:7ce7:cd2b with SMTP id
 a640c23a62f3a-ac7b6b3ac9dmr366531766b.2.1743684391818; 
 Thu, 03 Apr 2025 05:46:31 -0700 (PDT)
Received: from smtpclient.apple ([91.64.76.218])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013ebe9sm88419366b.99.2025.04.03.05.46.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Apr 2025 05:46:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: =?utf-8?Q?Re=3A_U-Boot_interferes_with_initrd_binary_=E2=80=94_Re?=
 =?utf-8?Q?vert_=22efi=3A_Correct_smbios-table_installation=22_=3F?=
From: =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
In-Reply-To: <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
Date: Thu, 3 Apr 2025 14:46:30 +0200
Cc: Michael Brown <mcb30@ipxe.org>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
 <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
To: Simon Glass <sjg@chromium.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
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

Hi Simon,

> On 1. Apr 2025, at 17:51, Simon Glass <sjg@chromium.org> wrote:
>>=20
>> but I don't know precisely what these various functions are supposed =
to
>> do, and I can't find any path that leads from any of these to =
eth_halt().
>>=20
>> Is it possible that U-Boot is failing to call eth_halt() in response =
to
>> ExitBootServices(), and is therefore leaving the network device =
active
>> and performing DMA while the kernel starts up?
>=20
> The dm_remove_devices_active() is supposed to handle this, but it is
> possible that one of the drivers lacks a remove() method.

for what it's worth, this is happening on both ODROID N2+ =
(meson8b-dwmac) as well as NanoPI R4S (rk_gmac-dwmac).

I also don't understand why reverting =
06ef8089f876b6dabf56caba31a05c003f03c629 "fixes" this behavior. Does it =
mean that any memalign / malloc may cause this?
Also, how can this failure mode be detected and prevented in code?

I really don't fancy the thought of remote code injection into Linux =
initrd by spoofing Ethernet packages, but it really looks like a =
possibility.

Thanks,
Christian

