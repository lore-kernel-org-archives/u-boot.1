Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB9DC4452B
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 01:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4DD14056B;
	Wed, 22 Jul 2026 01:22:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K0KPZzeX4lMG; Wed, 22 Jul 2026 01:22:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0722B4070E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784683356;
	bh=rZnlKbgdn21raTmKYYXR0VvaOdIpKascIyqHJUv6qmc=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QNtfieqJoGEhVU0ldH+csed6OGbscwwRWZd4IMaitGk82TB4u5QRgtUEP72Vit0wY
	 4dbuFLLMInOe4Uf1SctDGU4MysBpJgypcAwvcowYwxeQc/SPjQdmSPWFzDMYVTGCvU
	 1Dbjx/7034ZTZYYRRWsawt6jqLKUDLitvjwxx6ieAcRKNE13HA/rJ1t5ssaUWgOt/Y
	 okTTi4mNpT2K/UNMdTRyLmebGXBjJFxX16xXnPCW6it/iSb4CldbUBUpWhoNBeIfVo
	 wEP//zMIXcJtvgE3YaddTbIOtNFbAihbeziGK94CXGzlB5hIdgaQJU1uNUJGUSbQIR
	 z2+bOoofHA2Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0722B4070E;
	Wed, 22 Jul 2026 01:22:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8884710A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:22:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E21680E7C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:22:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D7j7VxX153Ay for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 01:22:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5AA7680E60
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AA7680E60
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AA7680E60
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:22:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FCC848BA; Wed, 22 Jul 2026 03:22:31 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C9784659
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 03:22:29 +0200 (CEST)
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5b0117d49dcso11013130e87.3
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 18:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784683349; cv=none;
 d=google.com; s=arc-20260327;
 b=EUeA+ANZQSVIEkzPD11XKXJqErebEysl9ARBarw4uTTywAUYo5psL5YcXZC0g+RjpH
 wF589aY1da8Be50eUVXLfdB/MEMzIC9wDtJut7TWqcClyI4e0j7mKXef2GCR2OodBLDG
 O/MAq/OJ35tGPK3VSAYRVxwK8PEOfKnt4SyECq88qW7p2kY0fGN19W9tfzzk1ApvBH8+
 EyECn98vHUxSLaSu7CoOsy38/ZWt4vgnIxEjyRMhe+2dKuCRQH+KaKKbnRzlAr7mKPBn
 XZf0n6aKvjUA8THVPhxN+gS6z/ANsHdewA+ERonEqmtly8DuPtUB0yoLfMJroq9gZrT+
 pEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rZnlKbgdn21raTmKYYXR0VvaOdIpKascIyqHJUv6qmc=;
 fh=wnVpA2nSRGe4gaDOBU3WArayGaMW7xRCmJSo0glc0jg=;
 b=HAkQO6uMT3n+eBHhtBn3LtEgKXojA91HtsH1YEN1WslzpEC5taA4cdrtPZ/fJEmGjJ
 NKLsLTABFPYX1UGGGhdOTb9UHAXarpm+PdVhyPB+0HNDiME4rTn7iq+ZR5ZKkjsViTa4
 2yyiQi1kzMQvqsPJCX5258M09MbeV+fkWnqWE7qJGG49Z0f0SSEnfYlXegIRClUX5aFX
 mJZ8gG3PDIJXAgW1p1l5oQH8bI/6QH5iTZH8bMFt0u5rKYCmNX2nOmdmDfA3MSuNeRzZ
 IOCfcEXjyDsHZImsd3hmCoqcySQ1CQ6CLnQo3HqMfZt2V3UmCgTgopf/cfdhQ9LRy+b9
 Isjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784683349; x=1785288149;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rZnlKbgdn21raTmKYYXR0VvaOdIpKascIyqHJUv6qmc=;
 b=n62dsls3031ubOfttMLlr2+F897qqUvKUaIKYnbIcZNeggM4qbn2zDIoxxgiT3cY9i
 xI2TuX1K3Uu1XdJaPURPDeKquIdnNcX4rJ6oEKocZzV/8B/EORI51Se9UA1zjTkz/LuF
 QwcB+nqlV4TH+wL83L4EYNpjyyqAqrtoQ9FnxNKJ1OPQrNGFU3qnhJQY3wknZkQgoZ34
 MRIKzEWMhdnFbygBatLy1dgFIPS+QYzN12vO//yK55Udk/lX8SEUYMXVd/sJIXxWItWE
 zeDkrrHLHPvz13DWlDjqMsUpFbgmF5RtzKmkwcNjHsl52RzIadIvTho2+5mpwEBWOFE3
 PFQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrX/bYbLBi/oEGeLxSryPW52mWnYDQHVz781tGVBthphtKCWBdT5cUJMYlcJ+KG1yDVBMvhgGw=@lists.denx.de
X-Gm-Message-State: AOJu0YynUxibcRPEailnmMLjeP+2BLWMhTTvMsnfpeI0xRDX9DBeW4hd
 9/AaiOvV5N1r1AbPCr93UTrr0kIoZQVvU8LitArl+L2GdJNqBVMY0cctPBEF/7Y8jxpVaA7LBiF
 Pr9DdABQP8ttEa5Z1KOuSt2kJ8vE9dRE=
X-Gm-Gg: AR+sD13phiUUQU1ovLDzBaZ5LEFXgU2EsWPSU9GGtB6H5AOQZ4gzw1owywCNmM+v7rh
 rA7HrijvWhmVKwlaDtGsLODCVJ/Agq3igYoTYTwr7huUklDFs8LAMWcdFgGH2iUmDU93oL4W7qR
 /cfHDUJxdTP/Z4RHCEOwVdngKWlgjx55LmctFT0lJS0sg2YTSCqrG6Qolr1DPnqxeFEMvodwVQH
 deBvevQQphBQfx3RVyZCuVwdq6p1eNTw1f40D8rNFPrIVLvzp6LdFkw4NE8vllj7o3fC1TIm0ad
 s/4CtQUnX/jzles2Xs1Luzxiw7mMIOGHcHsQoQozXRiEXRiGJHkHCJVm9Vst
X-Received: by 2002:a05:6512:6d0:b0:5b0:1359:3dd4 with SMTP id
 2adb3069b0e04-5b28f8471b5mr4867927e87.5.1784683348562; Tue, 21 Jul 2026
 18:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260701175800.40141-1-festevam@gmail.com>
 <57e549ad-4472-4aff-bbe1-c2ad181bf8b1@cherry.de>
In-Reply-To: <57e549ad-4472-4aff-bbe1-c2ad181bf8b1@cherry.de>
Date: Tue, 21 Jul 2026 22:22:16 -0300
X-Gm-Features: AUfX_mwpXMtX0tglUh2pPgLKdfcsl0SodJz_LT5BMt_RFaKMmF-GwR69HQcD_lk
Message-ID: <CAOMZO5Dt_kCyAW5L3Kh+HZ4gZArhSv-Duajm62SwD9S_GrNS2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] roc-pc-rk3399: Enable redundant SPI flash
 environment
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: kever.yang@rock-chips.com, djw@t-chip.com.cn, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784683349; x=1785288149; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rZnlKbgdn21raTmKYYXR0VvaOdIpKascIyqHJUv6qmc=;
 b=lVMkPNfs3iLitJWn4NTisBEaVWuv4UNYFpYiCh348HOUcILZ0VGPfSyrJ5kv8Rzh9w
 agnJOuP/GwjKlo4sUwpBTtioveHZiIA18iz6zJmycihN52AyktUT+Wq4yL+oPWlmQen1
 t1qW66QHDWPQ/Uk7E7dyBwGkS8f7XhjL/ePBfsFBGK1IKQuCu6R3uCYEQMts9Fic09w4
 tFkIyqOsQUrAt5Jd9dhyuVCwtGT0x0WqqHZT5y2jRpsG3pdKSsndkR2UMxPDfvzCm6Nh
 /+vm8vlrcYTNtPJgCsqNCpiOFABZZFZQOORXdznLeBYZGn8wueSM/G/KiD6uR3VOigVG
 bRfQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lVMkPNfs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lVMkPNfs"; 
 dkim-atps=neutral
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
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On Mon, Jul 20, 2026 at 2:57=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:

> Where is this layout defined?
>
> Considering the env size is 0x1000, the same as the erase block size of
> the SPI NOR flash you add support for in patch 3... I would have
> imagined to simply use 0x3f7000 (or 0x3f9000) (or have them aligned with
> the ones you are trying to use for the ROC-PC-RK3588S, which is 0x40000).

There is no separately defined SPI NOR layout; my commit message was
misleading in that regard.

CONFIG_ENV_SECT_SIZE is 0x1000, but CONFIG_ENV_SIZE is 0x8000.

Therefore, each environment copy occupies 32 KiB rather than 4 KiB.
The existing environment starts at 0x3f8000 and occupies
0x3f8000=E2=80=930x3fffff.

To preserve the existing environment location as the redundant copy, I
placed the primary copy immediately before it at 0x3f0000. This gives
two adjacent, non-overlapping 32 KiB regions, both aligned to the 4
KiB erase-sector size.

I will reword the commit message to describe this explicitly and
remove the reference to an =E2=80=9Cexisting SPI NOR layout.=E2=80=9D
