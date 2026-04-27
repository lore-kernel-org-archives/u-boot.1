Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B6FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 05:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E6C883693;
	Mon, 27 Apr 2026 07:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KdCevvnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2CD7839D9; Mon, 27 Apr 2026 07:28:06 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559D380077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65427236e94so6404443d50.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 22:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777267682; cv=none;
 d=google.com; s=arc-20240605;
 b=BMpZcChEnrPu+jW3GHqBfaD1IINDW3E56r3Q+rz768jJRB0qR48fZSr0NVUjQL/4pW
 uXwufJbqOHOYdZqMyLoV5MejQK23qXg1jXyk0tSWzne4LfgH1Z9g0HCxe/PnoFOO2OpH
 gz1h9iBN/Ebuh8BXTmAD5rgTB9pBQip76rWQpXlZ2U0uLRDSt7l+ju/Pn1y+PragNwAw
 AEDUMpDO3Ny9naEg7mynUK1oCRadBFJWr/Hz4hoX6IYk/ZZO0+oO7r6WdHo0sLKyHNww
 qrHCnIO3BL+i99IWsTF9/Q40F2LZHvoZW01vNYHoyW+mpcYvuycMiArof/L5WQgzsULk
 ChnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3znor5SgIGx8UFkkXCfc4obtG7sN9Y8i0o+7DpPuL8o=;
 fh=2aUzbW5EtNKzL4BdJFR67kmysRyhyYprU9mL/ppi/8I=;
 b=kQ3lhq0uI+aGLJAcdAprxwar0zVsy57/GrSsTtmtOtVEjfWT1f3oarTiodl0B1wj0g
 hDLxj3ERk3NfHPaobDPUxyOv3aWA0ACCSx/joUfDi7ERAHuudr6+0MXvHLGX6+dV7Zmm
 2QFuBeNRFWk0boBEFXIONQsspxCC4nSzQHBNxahyr9GjHhJOudqS38M/8liY0dwse3zU
 akPSFF2/pHTKd0mqEiUOpEC0bErgrZE0eRBfYRqaxywoHUOjPJhtK53EFrP/vpAl1k1z
 /rHVd5sylNQsICN9CLaFN/vwLe+J46cFF30OhMQAFfzsok0cjkJks0Yx0eM8FJCEBExj
 WeqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777267682; x=1777872482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3znor5SgIGx8UFkkXCfc4obtG7sN9Y8i0o+7DpPuL8o=;
 b=KdCevvnIoSOK5D182pt8RqhCah50Z8ojEFRVeZ+Ntp7mK+7+tarPfdUvgsJY8rVV7K
 4G3XO/ZNGjKM+vmVrt2uLU7ruSVWILnmUGNECTwXVwbuviHzB5y7CiNKHzY1a1tIMJnQ
 QOnDjl/8C/c9JaDuYEc3x1WSAZXJrdPe/1f4h115+2lcLo8vXpR576V3FYgHGUWyeZiC
 g6IUhKCHRhcedEYdmj97nyus715HLjA2x5GZme2VdQ7Lnibw6sZ4krmSYzNK5GEgFhhh
 ng19K2SXRpF2FYq1/7Oy/H7KYddgloFKc/pbeKKysA6eRQEqImk75cnF1LXePfbtKv1V
 7GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777267682; x=1777872482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3znor5SgIGx8UFkkXCfc4obtG7sN9Y8i0o+7DpPuL8o=;
 b=c93anQLK8T/tMVJE/x37U2tFdhbqz4jUOwPVOPOeyPmiDxwAu8/CuvEmWSN0t0NRs+
 l8pQTdx+JXrjwsdscZ0mTFsbBznm7v2lzEDwNCeXUmHt97R7dym7aESGzRcieGysMt3M
 R8aklYE5IjnZuVCn1NAroVl0Dm6RssE+tphREmVRrU5ANa1jMz9DHjJsAFyWrBXA7wGT
 Yor7s3bgChbC2s8/HN1I1NAUsuGahflVGop4xX95V5rAFx8dahUI2THxX5xuRLho4RDK
 WvrzPfCxjhRJXAFotnQ0eGuSpXxQEO8k/CzTFIhe5WP6MXSp010hfhCM6UwUJqzuCdfT
 bGMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fBDwBFPnPF7XW1/7C/tvz8TqzgwQXygd+NcwHziAYQmNblWw1F1FfBzI6WamYmICzxC5p3h0=@lists.denx.de
X-Gm-Message-State: AOJu0YySVT24TT6wNwWKtKvzSSBEFOgp+2NyCirnJ45hW2E3Ap2ok0SU
 2ehhM8RW7Cjv6qjgcmWbGzgTn6YAjWklIt1ANEXLR8fj2iL6yfjDuwufJn6FcJA5WQ8UGpDc5ml
 9l4jXIFsNQEg8RXtXm7JGMjl7GV/QBpV8yFWGdHOFNw==
X-Gm-Gg: AeBDiev6FSPhJi4fajG2K/9+kKkUuBKc2STEmuV4d1wXST4iXXNoelDqlQSKEOAWvVK
 iVjO9SXaS67pkIwymy+UwMcirXPAKGvO2ocw9lBbZKLD4E/QOuMLA6b1KbetdpYoeHcJtdiyr3u
 seQf58uAb7vdassXeyJrmsIK3oG9NJXeY31hY5H+WttwjYbZA0Mn1UdTqmMoFWba/MitjiIIQLd
 utAYHsy1V9CAQ7IvVCv6GGzkSDsDyuesmIbhFtHgFJozyh28NOrkwxJQLDgHXvz4uGtgtBbqZJp
 iRRDD5Sey5dbUavetDCcoku6O50ZwgNiJUoU5ddEDYr0ZaFLTueyl/iZe+hm0+h3XKLr8kA4Qs5
 ia+WzUNfFFiFjtz9/UVFSE5K1K7h8e0xDThgfBanmb10+j6k/9vJYJx0/Hbwgx9LCMT5yvaaH3R
 xaQm6HXIo97IyW4aphW09aJWU+TyIup43lTI3XhRWSJwvOgIJwFMY73xb8Bkw+S+d2ud1iXV71w
 9j5W5MQNHhzKzf1PdMmcrlGsknUdbFl10FvQYxPtLhG9QrbO88MVO+IrerpWFfc9EZ05VX0tQYC
 oF/34EjNBtUfzmJ7m4uGscHLDHM1/BiuqQ6hOrjWI0hswe/CIXSXibGMxshKh7k1oS2rVhEgZWR
 oa9yJ30/KLG6LCTpx
X-Received: by 2002:a53:ac87:0:b0:657:a0f4:ac1d with SMTP id
 956f58d0204a3-657a103f063mr7711523d50.12.1777267681948; Sun, 26 Apr 2026
 22:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-4-ilias.apalodimas@linaro.org>
 <a1e1a4ff-55a3-4d3a-9050-7df48071163b@mailbox.org>
In-Reply-To: <a1e1a4ff-55a3-4d3a-9050-7df48071163b@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 Apr 2026 08:27:25 +0300
X-Gm-Features: AQROBzANHmeF2OweHTtFGbZMOEwudcdCVxqcDzAIi7hg3DwsRFn6kCpBDlVJ3Gs
Message-ID: <CAC_iWjJ+i0-9cKvOoDU0tH6hWyYTa0X2z_UEa1Hqa4xu5NpciA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] treewide: move bi_dram[] from bd to gd
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 26 Apr 2026 at 19:24, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
> > Currently, the bi_dram[] information is stored in the board info
> > structure (bd). Because bd is only valid after reserve_board(),
> > dram_init_banksize() must be called late in the initialization process.
> > This limitation is problematic, as it forces us to rely on a variety of
> > bespoke functions to determine board RAM, bank memory sizes, and other
> > early setup requirements.
> >
> > By moving bi_dram[] into the global data (gd)
> The change itself is fine, but the variable name should be updated.
> Doesn't 'bi_dram' literally stand for "board info - dram" ? Since the
> bi_dram is now in gd, it should be called something else, maybe simply
> "dram" ?

Sure, i'll move it to 'dram'

Cheers
/Ilias
