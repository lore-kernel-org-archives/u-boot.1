Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37BAE6B25B
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 22:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D773483E88;
	Mon, 22 Dec 2025 23:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zjf4GZbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B311883EC0; Mon, 22 Dec 2025 23:09:34 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7677983E83
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 23:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so6241921a12.0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766441372; x=1767046172; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MokJxSRKIxBGnot4ShOk7FsG70rnTY+0lB3tJBJB37Q=;
 b=Zjf4GZbHNtuHldy+lbtL50u5CbOK+Ml1JfxDG1zdIxxIgsiGdQYbfQEZNGXwFQ/zRY
 fdEAuQv6Q4N5NIkICNltpgg3Px4Ocl4bT5MLWPs/oVJ1MDoCgHAiKaBBV3+a0qthi5oE
 qMHP23vtyIWiYQ6+pgmXqmzmCt27ZLlcc4omNItQ7o/C2WYKKnmZCXi52gUdjPplf3AZ
 dfGBz59Tvg3h1a4trL46w/cp67VeYhK2f6JBmq4yGKWOxwJwuPn0Y84h3Io3YACa1fcw
 9E17ifBntJElYdf7kPcsmYTUk/Bw4uTKqoeGm2q3TMsc7frjh2h2XaLROgIP4gFVAz55
 EA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766441372; x=1767046172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MokJxSRKIxBGnot4ShOk7FsG70rnTY+0lB3tJBJB37Q=;
 b=UClzbvRn5Z+Pt3RbrA02mw7Wl/MNw39AZ8Eq+4SmAaCUFV9lhMrAEIJneGZZcCXufD
 b5U6JFIm2GlUN+6fb7ePcOfK3OXgAlBfX0cAxjtwCje1oJ1kdLZL8n7Po5ikgIahNLpn
 OWRs4WtMih8MogiZ1TyT5gUQjOBiPxHVFgSIuHZiohd8/PuOQpbojXpA7AQUE6bwSzsZ
 ZKyVpD00/iRmkGCkmQGfUIH75ZV4MP5YHIrUBjvlpi9bVynOh0lE2ApzvVRIAlyAHE56
 tqXwZx+f5bWHk+dfwyPLsZo8nMAGXLHybqpgdB6dlf30uszzt9YOiBgkBhnEJqHPuXp/
 l6TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCv8wc20NQSutVFo2sx+HDpBlmRnGg3alLpuQw7WgvPHxdYDob+09zImcrWpudGhARQpNa23E=@lists.denx.de
X-Gm-Message-State: AOJu0YxfmFS53QhUOU3PV/AiKTdnUncCwzYOm+MHsNzdQfCWvLBPv7W0
 4bTUdFHScDXUsqI4DVmQLxzKQnKS8XYMpkx59xVnR90/iUwRS/2qPesw8xpkZcxJDHehvBraFL4
 UMcSsrkEhV+4t4VjV9vxHC2eTn1jBBOw=
X-Gm-Gg: AY/fxX4X9YNsTPCA1r90llgpI/0AW3rchnSAW+FVOw3rBQ30JNlIGh1KiGe2nr5DjjP
 HZLPW9ZeZDtFQI5luhljUHV1ETpL5BHFuIn0vj8s2eEYxjxL7T/uD4K/CDJwSDbYEqqxQoJUTqB
 jSOB3lxBWB7vz4yUH8J6MIDfvp1+scawMZxwa1GGWckr/gAWAjyv59TxRHUVnWwHOrP3jZ/fJJ8
 8lVM0yDr23MyS4N42V5D2gJ0TXVRkkaFeFVuVQPBvKZvKxyZZv1a+DATpminlMqBuaVg8VDmOCZ
 TobkYa4=
X-Google-Smtp-Source: AGHT+IGN0bEEpWwQNmwvLnsDywvK59oTVueNvBQU7VWL2hUDrecdWFTVHt7NFQOQwCa/T3Sf3Bd0d9zibLqean6Cqv0=
X-Received: by 2002:a05:6402:280b:b0:640:a9b1:870b with SMTP id
 4fb4d7f45d1cf-64b8e94e16fmr12004844a12.14.1766441371752; Mon, 22 Dec 2025
 14:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20251222090105.2275585-1-balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251222090105.2275585-1-balaji.selvanathan@oss.qualcomm.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 22 Dec 2025 14:09:20 -0800
X-Gm-Features: AQt7F2rHa1xtP07wR444rLrrhLydR5NnegdLBtQ7QOg9MtQQInxLHhurJ9oApOQ
Message-ID: <CAJaLiFzTZkb5OLGBnjs_B=Z617MAGmu8pWEbZJCgcVT6tnBypg@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: scsi: fix double decrement of block count in
 64-bit LBA path
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com, 
 casey.connolly@linaro.org, andrew.goodbody@linaro.org, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de
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

On Mon, Dec 22, 2025 at 1:01=E2=80=AFAM Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> The scsi_read function incorrectly decrements the block count twice
> when handling large disks that trigger the CONFIG_SYS_64BIT_LBA code
> path (reads beyond block 268,435,455). The variable 'blks' was being
> decremented both inside the 64-bit LBA block and after the successful
> scsi_exec() call, causing incorrect block count tracking and data
> abort errors on large capacity disks.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Tested-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

> ---
> v2:
> - No changes from v1; just a resend
> - Link to v1: https://lore.kernel.org/u-boot/20251222042533.2024310-1-bal=
aji.selvanathan@oss.qualcomm.com/
> ---
>  drivers/scsi/scsi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index b414d022f3f..8fe6b38a8c7 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -220,7 +220,6 @@ static ulong scsi_read(struct udevice *dev, lbaint_t =
blknr, lbaint_t blkcnt,
>                         pccb->datalen =3D block_dev->blksz * blocks;
>                         scsi_setup_read16(pccb, start, blocks);
>                         start +=3D blocks;
> -                       blks -=3D blocks;
>                 } else
>  #endif
>                 if (blks > max_blks) {
> --
> 2.34.1
>
