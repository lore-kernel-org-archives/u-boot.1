Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7221C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8945780F0B;
	Wed, 22 Jul 2026 12:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7u0cvTxFe_8y; Wed, 22 Jul 2026 12:27:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00AE080EF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784723225;
	bh=fU45nDtODpoymffcPFLG2AYNydDXJNnikElA93/5JiQ=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Kjsb/FYaM20IXuIaPsd7DZc7BwJEshI56U8Q5hOigsedo7d5SI8VC71i4ZQJLksJg
	 N2bhlY51nS74Y3jOVwQWmcj3/m87TmwXdhuwcUcvic5bq5B3Pk+JklxGigkz/b4qwj
	 gK/BXm4+yXRzw45rc8j+mzMvw8ZpOoPCrnV/48K6D6DJgYrjVksudjlAXaiuOy+wHc
	 UiCK3h1JfP88s4elZPXU0Wz0mgKpV4cosNby5u7L/9lcucSNzLZ3lusU0RVOq30g4o
	 wvRxW5Zz5lK/khchFYxTyhy5ScqrncKmg6aphjFQCbyMFM3iqtjBOtq9OrAMzNtgi8
	 jbrHP5DKo9wfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00AE080EF2;
	Wed, 22 Jul 2026 12:27:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6618442A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:27:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63D514015A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S2qsxZOSA-MS for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:27:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9D8C940095
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D8C940095
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D8C940095
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:27:03 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-902e4af2d9dso64487756d6.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784723222; cv=none;
 d=google.com; s=arc-20260327;
 b=ehXhIanDDzSHmRQLr3SX7OPpAHW10DoHFR8vttDehO9Qy62eqGf2kNgSg5FVxiiKuR
 8cxofpE4B1tFxg8+6WHLGAp3vH6Lpokpt9ayf3UIjTGRQ5tJc0n3qdFOv+LgXq7UnkjO
 GsjU4Cf07TRqiDYLy7yraxcuHEZJXZy8okg1WqExnQOI/99rydt+xf3gd/ZDhsuqPNn+
 nXv8RSdtJ1meGi8Q4TNToe8sUC1FvqlpiI0iB1VyF1mRZRrLX4qBQloXzMC17vjgSJ/0
 gX0ElGBfNeY/jY7QUMIA6a2yzcTmIfMdCfStRNLOVXY0WrYTXotWXDQoHZUHfou6/zwk
 EZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fU45nDtODpoymffcPFLG2AYNydDXJNnikElA93/5JiQ=;
 fh=3ud2E9D69tjVAySKG83SrK48vAZRyH9ejBQxVTxKn1g=;
 b=RCCzUUOasA25iyADumeINNFEfETHYRs2rvyPkvjHY5xR1sHEKQf0VuPSrok7BWO2LN
 XQNjZi+3II70wDVXRWt1SFMCvrg7/Jg0EE08LDqQITyoBMkvtLFMWzFyPoX+0o3d7bO9
 94bANBgXkX1RDCfVWPqVM6OtleBJcnBJmc3Qz9Zj4RWLMn78QMUhQj/a8mxKgsdAWq6s
 rLRDzPK+QDnALenDg783Oc9BLtLuYow+Bej60PRyifqU3pp7K9L9W2J5T4+IOzQLaCP7
 wEvDmcoFmqIqX/+w5iFlSK1lO8Oocsr9ovLwhxo6pnz0olabNmCaRqSaaKqzvZfmpJvn
 xqgw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784723222; x=1785328022;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fU45nDtODpoymffcPFLG2AYNydDXJNnikElA93/5JiQ=;
 b=WGZ81+CEQMf0phsEVKSf/PXXPjtgsG6+qyIfzcEXZq5XwwwnVnNnVaZ6e4fDHtiwr0
 /IqWKd6Q4sodT0I/CgwSdt6zNLEX2lu02IkepJXsfAeh1IdfTIN45/o6YkO2RzQ7etAk
 zNYgeD3B5VsAXx5/1V/mDto//+qoeV6Eou5a4mOVguKCYS/bPJ2muKipNy83fsIMcARQ
 qQdRcg/i8x8glz8psb2wnarvlrFDa9gQ3qmC1ShhGBOcx0mj3J2xj5zV0CFyndreCjWW
 1P4/bn3N7rIvkllIKURGzfWLAPiFdya098FN/vGZPUzCEoQoy6d42lkOb+c08aBG/S/h
 8uJw==
X-Gm-Message-State: AOJu0YxLAYX1APBOX1yWUMBAj3LE+hENQtVactv6QMFT+zNdWMIQB4po
 T4SaMrtFBHh9HSTpi0diCeORMu52ALuxKmKm06nUcFFahfkBUyKRCyHKE7HcbkoC9pvn8ej0f3S
 mHz6q3ZaH3pWIc4qUe6EMLh6Y78xow+Q=
X-Gm-Gg: AR+sD11GsSjYr4/tcKnffzSTND3WfIfFbKqi+y0y6anysioUfNtbwg5Nz2MNm3CLvf/
 Bd1DXs2aEVauwE1LNyMdm6FPBfqzud927+RASM6hyBTtEiTMH9rO56bhwQ2zKOStFCy1OB8Xv2A
 sEInxKmQ2JYbYNq8YKq4cTGl5FoWY7geeP4mDEkIXqjGBDSY+v/1HlMdKvnLv/TGOlal+jW3qhB
 yJAY35yVEqeFhzp5COcOAz74oVlD9ChHqwWE7jF1VT6Zfyd6yfp558DHYM6/1ciykc7VTjdx4Rf
 zZrSGMQsKXA7bZQlQXdPXjqorHhrWcELgW1fQwajqjWo8rAY5kz0PDnaQU2GKBGuWkenpRuRri0
 0Dh5e0pJuajFQaeDq5K+6c4LZRJs+Jrqeai/kVcIqwUfFcW9tMjD6no2c
X-Received: by 2002:a05:6214:4015:b0:8e8:d95b:f22e with SMTP id
 6a1803df08f44-907b9c291a8mr45111546d6.32.1784723222281; Wed, 22 Jul 2026
 05:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <6c05c5dd87fc1e53a4d4328d3b6ab70f7b49af32.1784722525.git.michal.simek@amd.com>
In-Reply-To: <6c05c5dd87fc1e53a4d4328d3b6ab70f7b49af32.1784722525.git.michal.simek@amd.com>
Date: Wed, 22 Jul 2026 13:26:49 +0100
X-Gm-Features: AUfX_mx5QM_Cn9X4WCZnzcPJOpwyL03F3ndgx8QDdgFqG3t2Hdu3pE_Dm4T3vqI
Message-ID: <CALeDE9O2oBcbuYVmy-iF49QjwzKsAW7DJzHhr3L1V8pi7vFarA@mail.gmail.com>
Subject: Re: [PATCH] xilinx: Enable CMD_NFS for Zynq and Kria platforms
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784723222; x=1785328022;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fU45nDtODpoymffcPFLG2AYNydDXJNnikElA93/5JiQ=;
 b=eRTX7RxlpI1A6k+93FFt8bJjhte5iV+QS6Gd4kmdJoKPPwZLTm4pm9G6S0YCnnaEHH
 EeXqVsXUlNsXssLCZ47g8Sun4lXITJIJeNvpJMvWVgRBSpXBL/GHs68GbCAfGYm0aW2l
 rGq1Q975XF4YhsDFs+hGw7w3Q288o5/vzCDtbA9eI+/pKFaRU5GVNlWEuPVUzv4yZ6sj
 oJnBVM29iTrYwG8eeXs0xGJKooJp3GeMM4tlbYFZdfG7x0o2XzhEV4RSb6NCKxaFDSEf
 kiphnnLj7joTgbV+711iM84yL4ZSJhwYUyn742z7AS+ui9iKAzj+9xwpV+Z8CXy57OTb
 R0MQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eRTX7Rxl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 at 13:15, Michal Simek via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
>
> Enable CMD_NFS for Zynq and Kria platforms to have it available by default.

How useful is this these days? From memory it's NFSv2 and that's
mostly dead everywhere.

> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  configs/xilinx_zynq_virt_defconfig   | 1 +
>  configs/xilinx_zynqmp_kria_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_virt_defconfig
> index 30ffe28298a0..b7ef9407dcdb 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -69,6 +69,7 @@ CONFIG_CMD_MTD=y
>  CONFIG_CMD_NAND_LOCK_UNLOCK=y
>  CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_USB=y
> +CONFIG_CMD_NFS=y
>  CONFIG_CMD_SNTP=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index ba4fdb9d657a..877e6c7f474e 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -82,6 +82,7 @@ CONFIG_CMD_SDRAM=y
>  CONFIG_CMD_SF_TEST=y
>  CONFIG_CMD_SPI=y
>  CONFIG_CMD_USB=y
> +CONFIG_CMD_NFS=y
>  CONFIG_CMD_SNTP=y
>  CONFIG_WGET_HTTPS=y
>  CONFIG_CMD_BMP=y
> ---
> base-commit: da4b763f29446ca22856e0f681076e5d27268c05
> branch: debian-sent3
>
> --
> 2.43.0
>
