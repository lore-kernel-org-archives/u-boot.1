Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53DAC4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3EC86EF1;
	Wed, 10 Jan 2024 13:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NzXo7gNj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FD986D2E; Wed, 10 Jan 2024 13:31:20 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3885870B5;
 Wed, 10 Jan 2024 13:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-28bbe484bc0so920667a91.1; 
 Wed, 10 Jan 2024 04:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704889876; x=1705494676; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T36dLWCiyrx+sSpiXUNNFdckMW3PfF6G27hpmvrNOUs=;
 b=NzXo7gNjDVHYcj/ZG53SiBtQ7Rl1BnoIGPI+hnqShIhsckcnoB+PrfuGTWTvuML7Kj
 2evAtTrog4nSJlCwhqSCi6QY3VdDZXQRmcd2pwcWkBvdkurHP42TcgjKaUPBjA20RhRv
 3dTSL309yEB7TIvVhCDWy7VQ/K/xOfn1DB35csKE+GwNPlIpVVnBSci+fEYwLAVehjlW
 m/8fTBe0wKbHeKUVPCqfQfZmP8GSlhG7XgzUIvCiD5ivD04Pv34aK60zcg+jXoIA1ct9
 uuNzFFjpP+PwilD3aVC/AKTaD/HsSi1AS01iZuG9J5TnT3UmLT6P2euUAm+t/JXPCfl1
 zHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704889876; x=1705494676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T36dLWCiyrx+sSpiXUNNFdckMW3PfF6G27hpmvrNOUs=;
 b=HvHw+KKZfByZ1L2fS9AaLgiTMWtfoeJr0sAdBLIUxS881dVP2A8aOKkc2YM8sU6mzW
 kVXoVf+96rbIx/cJ4bqVZx1pvYEm25x7OsIQOwveuY2+hQ5t9m7hSFs/p43MOBNHPxRC
 DeYjCQRDmhyrMiLghWP1iYJQATnX+i7cxMGmA9MfX2gtK1wVIWpPJenklPuaiF582WKc
 H/29HMdPSg2RYmyqqYayOoriHDfWckcII5+hDvxnrdHxKuoDxDvrOfwdI3JtZOQTRUp5
 STlbqIPM94jyp3zkc3aQtneX+Bd3ftzsj4y59oFVDA6AM3Mb9gDOA4NwpQJKKrWgI8WW
 TntQ==
X-Gm-Message-State: AOJu0YyUNWBFt2ZJng7BxN4csMXbtdHUcHbthQqU4vWO95qfNTJKEHGU
 D4l5F0TPc9vYc5J9noHdv8i8OdSX6xYLAMWVmoM=
X-Google-Smtp-Source: AGHT+IH7KVVFV0dTh/AF6R8FHwDmdB9tPTI5Is8JonGKIDgDmJSK5YLFwPJhwSTyR7hJH9RtSt05dF07wgOMnUVcOy8=
X-Received: by 2002:a17:90a:e396:b0:28c:ee93:7575 with SMTP id
 b22-20020a17090ae39600b0028cee937575mr1476644pjz.1.1704889876204; Wed, 10 Jan
 2024 04:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <20240110103547.719757-8-sumit.garg@linaro.org>
In-Reply-To: <20240110103547.719757-8-sumit.garg@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 10 Jan 2024 09:31:05 -0300
Message-ID: <CAOMZO5BLev2quLZcOABQ9zow2hRHO61e5NY2WKBpH-YJNvBV7Q@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] doc: devicetree: Align documentation to use
 Kconfig options
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
 mark.kettenis@xs4all.nl
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

On Wed, Jan 10, 2024 at 7:37=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:

>  History
>  -------
>
> -U-Boot configuration was previous done using CONFIG options in the board
> +U-Boot configuration was previous done using Kconfig options in the boar=
d
>  config file. This eventually got out of hand with nearly 10,000 options.

It seems that the original text should be preserved here.
