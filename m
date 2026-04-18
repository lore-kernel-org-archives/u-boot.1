Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2012BF99C6E
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 00:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73C583FF5;
	Sat, 18 Apr 2026 02:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T+JIMEOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6F98405A; Sat, 18 Apr 2026 02:47:45 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F436839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 02:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so218239166b.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776473261; cv=none;
 d=google.com; s=arc-20240605;
 b=jkv7yMBCKJj9bXzsZTqt8d29/VO3BuvjPYPoqit5/AGmBW6byVFB9/3cimGCoxgLHl
 bVvTmc/55V5maHErmCvCsaJfGacedgjBn2drMWdYTsMudNCM82fWVhwEGvb8sFhwITSE
 HUtwxI2Ww23OmopWU1FhT3agpY8QS+atfUdh5HhtLNqF+SCBnHuIzicIZSuoxiIKZ/5E
 6V6cyw/Bh0yFtilkFAL/jpjLPNvAbmXHpN2klgL1ytssAgYzurggFPwNa/ySh0JmjqqC
 LubHKEuVE9nOt3CM5xamwyjtiVhNq0BNi2pU/1nBvaQ12P+uAPkXWN3PtEw+RNGIytSE
 Dolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jrtBJ3WqVlEc9M9sm4W/o/UD7yQBZiEwt3l5bSu2agY=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=ZzKixpUQooVRW9P2u+ESswhInWr1TEIYT/DzuONUXcnHKY6N/yFVupdy00RM0hmwWK
 RQTnGhxz9w+q8AIZ6/9776BgTX3e5YC2NaDqy2TfeOFS76o9dpY8hsOcbIISPpD+6ias
 XxXigTv78jjZ74O0ItIpDWxrELc4VZhU2GU6Zve/PyQjkq2Q8tHb2Sdt/xDcjVyiBmvT
 7ojKVNTJOMCIOYgPq1rOz2gZrRLbjnole4m7LpFz4ptaBp0fknTpQ+kdYS7NMuMQKOG2
 ZnxbPOGUFPrqteXORU/Zhr3YvdVFHmNCdsTX8gNLsaan/f9ihpFPd6/Qdk5hf0fGgfW8
 pTVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776473261; x=1777078061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jrtBJ3WqVlEc9M9sm4W/o/UD7yQBZiEwt3l5bSu2agY=;
 b=T+JIMEOP0kldhRwYNilx6nXLzN/dEN+5XiLpTmKRYmwu+UjgfTLAI02Ep4/2IpF7RM
 bULc72JRblperlyt5wn4SCJ35lKqNNURjF4mHDEyfngAephtyQ/FBjmjpf2S6x+ymf4W
 ZK87swpNcOJEdzQ3wL1/+bX1yoJGPbm4ideBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776473261; x=1777078061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrtBJ3WqVlEc9M9sm4W/o/UD7yQBZiEwt3l5bSu2agY=;
 b=AATcHlbnq9PEQYyePY3ldLA3Yt+8YQ5tXGrv1bBx4ls+lZ6sej+lF1SHmh+qEReQra
 JC2xFzVRJf3gBx5g80Ac+XXPlY294qFXmJbT/Ul6BjDF2T5CirABE3+EEapU7fqAcGqa
 sEUGMW0VwkczdNK7L1M89K9ExK1OaZpIr8ZrrdsUXO5BlD1D6ZiHl6/bJUFrnnLzkkLH
 shdUkjdtHfCsY8v0sHODSG1RS5O7ACDYdf9TsgtmME/ikyXZabl9dbkOYAbuD73BzRsQ
 wqGNhAh4XctzmktAD3LlULy4Kn6kIjwzApDKnm5zgkXFiuu0GMFOBwo3+0ATZvflaSIS
 /GbA==
X-Gm-Message-State: AOJu0Yx5DLTKQJ3rf+RtPdEFdBZja0AmEjFXPPsgpDGU3E0hCye9h6qP
 T8orJ2USBOjxkWmgXGnMo2qbYoji5uItPO4RwKuwVfapLOrgLlziWcEzXNGrhP1PFfJ7ZeBrIVs
 zsjtoLrZW+2KFtivcFZ9Ptfm+l9VNrOr3szjgc3Pjh07gtZyFqkhsUg==
X-Gm-Gg: AeBDietAo39PNbl8K2GxbkjijykmEo6zt/sdpzqoQJ7dotUsOPiWE0Ynqj0oS/9YpmU
 7YalY0/U6y6CSjlqffTmOAdb1RM5jAX8cFLqQ2PO7KSHEX+DKrCh6URiR0gwrxo3MmkRnfCSMhL
 TyVcgiWna3Uqb8/09bmZTR+pN0pW+ZvGBDJhzlbCn6aC6F+5Lc6pSkRaQP5OVTAPuR0JRRMebKF
 RFrQDBnl4D0FO9WBVwZD2bqg1T/Nj04fqSKSHjAP7ETvhVPcjfi9lFfMd9NijwmKdmLOQ6CMPYK
 nuFQyhZ9l9pUZtxlNMtr
X-Received: by 2002:a17:907:6e8d:b0:b9d:9a98:e664 with SMTP id
 a640c23a62f3a-ba41945a155mr304487366b.18.1776473261073; Fri, 17 Apr 2026
 17:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <ba4fd0352a7e9a38c0cddaa3056a926cf9715631.1776392312.git.weijie.gao@mediatek.com>
In-Reply-To: <ba4fd0352a7e9a38c0cddaa3056a926cf9715631.1776392312.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Apr 2026 12:47:28 +1200
X-Gm-Features: AQROBzBtDQo8EZHIYhM3PJhLV5X6dy33aMmStnpIKPLHl4Z1Lo5yzSyKS35rm0I
Message-ID: <CAFLszTi3KR_juVymVmfpqw1NvvrPVipfa6-bZjsdX6NpxBFbyg@mail.gmail.com>
Subject: Re: [PATCH 3/3] env: ubi: add support to create environment volume if
 it does not exist
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-17T02:35:14, Weijie Gao <weijie.gao@mediatek.com> wrote:
> env: ubi: add support to create environment volume if it does not exist
>
> Add an option to allow environment volume being auto created if not
> exist.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> env/Kconfig |  6 ++++++
>  env/ubi.c   | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)

Could you beef up the Kconfig help text for ENV_UBI_VOLUME_CREATE -
e.g. mention when users might want to enable this, such as on first
boot of a fresh device where the UBI partition exists but no volumes
have been created yet.

> diff --git a/env/ubi.c b/env/ubi.c
> @@ -105,6 +105,18 @@ static int env_ubi_save(void)
> +int __weak env_ubi_volume_create(const char *volume)
> +{
> +     struct ubi_volume *vol;
> +
> +     vol = ubi_find_volume((char *)volume);

Does this function need to be weak?

ubi_find_volume() prints "Volume %s not found!" when the volume does
not exist. Since the whole point of this function is to handle missing
volumes, this message will appear every time auto-creation is used.
Please can you either add a quiet variant of ubi_find_volume(), or
suppress the message here?

> diff --git a/env/ubi.c b/env/ubi.c
> @@ -134,6 +146,11 @@ static int env_ubi_load(void)
> +     if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
> +             env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
> +             env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
> +     }

The return value from env_ubi_volume_create() is not checked. If
volume creation fails (e.g. no space left), the subsequent
ubi_volume_read() will also fail, but the error message will not
indicate the underlying problem. Please can you check the return value
and print an appropriate message if creation fails?

Regards,
Simon
