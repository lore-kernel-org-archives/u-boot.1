Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF5EC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 20:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33136877AF;
	Thu,  7 Mar 2024 21:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWR+OC9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF0D87D26; Thu,  7 Mar 2024 21:28:36 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7D686D73
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 21:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29a7be74fd7so153328a91.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709843313; x=1710448113; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tARv4Y3BhKAWWyeRwBLwfdEuaz+VHCAWW7qPZTLVYPg=;
 b=iWR+OC9cNFwI7T17c5J8L8agvRF/hGurGgSn/bvldgou40XEcwxDoLqjsbNgRv6YjG
 tr+N5G75//8r6VFlvuteI+VrKpSYOqV2FRvXbiYe4DujIDVj/EEiPSfRQhI+8bsvqgmI
 J657jeTcLP8Vrwpo5v2VMzKo7wTgpUz6BjAN3DCBuV30Q+KfMch4krHJz052++Kl7ZRX
 M3JH7m5QwoY6FllUIDHammQMU1kOAjr54qcKWGr0Fd4Z9mfr2LX3jDKLvknHHLKccbAA
 qJZYjP6mwbDWPML5rEGd1ppQ9PDuHb7ff5Qlpk6minM71pJ3msTjwzuqylUo+fIwyZTy
 Kivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709843313; x=1710448113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tARv4Y3BhKAWWyeRwBLwfdEuaz+VHCAWW7qPZTLVYPg=;
 b=ZtHYqbLP6rCP233Z+ebTsn2HfIRSmrqYwwBOzhMF6gd6kfExlI/lI1KSWwcYSaaDVD
 Q8U6WE9L3YkOxWmi/iiB+8l9dQmVDVCa0A/k9AwxCvLhl96jcBeFr70oxoOOPbbJgdGj
 dMG2yOzJGrUDz4EEOBERfpXSFJyQqSPMVtY8WQs5dLKM9GYEM7SXLO+5KNVQqY/+sJfp
 psNe4ttnVUi4rYBnFyodU/VwNKKXCT4p328jUcHyKtl4UjFY3+ik9NkdN7EOf6IZ6Vnw
 SxF/7nxv6wsnIA7VJIQjkxtO9vFXFu6SPxdnFKnNDNFG+iObmqeXm05J4dm6aUD2sTba
 WBeg==
X-Gm-Message-State: AOJu0YwXHYa23WQTSkGXLY14wGpb2ngNKILYedwdn3zu2SBA28k4lh4z
 +QGxtWa39UIfxDpqk2XYbl9JCE/foGoKSRqZ1H3StbXeBh5kzWjqxFk8yItCqVEpBzDZo5qSzQD
 g7b7wzJpnVF5E48goV4yLl4+KFqg=
X-Google-Smtp-Source: AGHT+IGJHcAdFNbU0j5azgiJx2nd2UfB+sHoXE0jKrCZGgDy7fwrGf933xSPzzLC6eQyunLUJMsi/XreyMBYmCp0xH4=
X-Received: by 2002:a17:90b:890:b0:29b:a375:347e with SMTP id
 bj16-20020a17090b089000b0029ba375347emr1565684pjb.4.1709843312841; Thu, 07
 Mar 2024 12:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20240307115859.22198-1-aford173@gmail.com>
In-Reply-To: <20240307115859.22198-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Mar 2024 17:28:21 -0300
Message-ID: <CAOMZO5CSphRcY23hyiDFkbkj8NrL1ohbU-GhOVXPxcuNhZZr0Q@mail.gmail.com>
Subject: Re: [PATCH] configs: imx8mp_beacon: Fall back to using TF-A
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

Hi Adam,

On Thu, Mar 7, 2024 at 8:59=E2=80=AFAM Adam Ford <aford173@gmail.com> wrote=
:
>
> When the board was originally added, it enabled some features which
> allowed it to bypass Trusted Firmware, but as the feature set of
> Linux grew and more features became available, the U-Boot config
> options which bypassed TF-A caused issues, so it needs to return
> to the standard operating mode of using TF-A or the system no
> longer boots.
>
> Fixes: ab53bd43dbde ("arm64: imx: Add support for imx8mp-beacon-kit")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

I will queue it as a fix soon.
