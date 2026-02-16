Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB501E63F35
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 08:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6C78063E;
	Mon, 16 Feb 2026 09:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="jkUtvBkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBCCF80B98; Mon, 16 Feb 2026 09:03:31 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751E180325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-797d3864d89so2489567b3.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 00:03:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771229008; cv=none;
 d=google.com; s=arc-20240605;
 b=Y9sUHitdnwIrGugqnbYBdHxGS0HxqqcdIL1D/unmTNZyZqH77Rc/Q6MgO7lUl3kMhZ
 sGictItxFgZzsg/V1kTjXhMbptY9Sj/jw/pNB49Hjme3rlAqz/yf+3TVPo1lzkySVt+j
 5rHXGNkZRGxRXs5TS4Q6HvnU2fJQtKivGj/nf3pHWNYgyonmuZw2A0rdmfwp4+Ct9N7n
 HSECsO+xElEzPRRxCt9hMQPPARB+hWhRs3BWlu7LsquqbILIOky5A1oZf6N61REBsbDF
 IO/4rZYQ6tBxHA1Y1V5rSKrFPyzjLm7TYp8W+BHZ6ktEJ2DzJztyqckf7fI9QdK+qPct
 /reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p2sNrTmrm8CFevYmz8CgOF/clFZd9NSOLufk/S3Az94=;
 fh=OG4ThqkPcr29I50rB8KwXdnfXDFmYPTprcDP1eh+5GE=;
 b=fYdM2OIMWGFr2i3eJlHRrGTHKzaNes+bTgquwpgUHl66vhZGcBT+AWI33cn9acqc+a
 F1risjDiFglrrylcC+UoIOUFrBPMqzHsEAJK9qIcktlvz5Ii1bqac5UWKrhI/ixYbT7m
 hudbTqkxkvmgqFQ+HGmv5V+cysLriUlOsNUUFFKBa2K1r6xaweV7DkxLadqG1WY1SH14
 6zh3sybn/sc1y/fL5x+vn7lNwSkvpuQwFPyBNv3Dex6JVVf75ikfUXf3yA39JUEJ/jHv
 uCedgDsAQmgNWc3FjD/xHb7aOa5rKR5pgUqOKnGN01N882jAdUEcI/t7qODjHADHJa5f
 56Jg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1771229008; x=1771833808;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2sNrTmrm8CFevYmz8CgOF/clFZd9NSOLufk/S3Az94=;
 b=jkUtvBkt+M54n3Ivewqb38t+gaUsOq7kr2z/zVSWeMtGlK16ODgJK1cvIQofZpdmkR
 ybnElTJ4Twm9GvVerM4RzVG3siSRiHSq0YG9uoggomL5I6id8qIUzBAAR+CXzQmjtpIc
 uCCWR9h+VWhjkU2TJJuhMgwC/fZCASxpNc0yR4g8nmYdUYMt5WxLs+78HQUaLz9LjsHs
 0/G6fm+dTYXYtiI/ZY89HGH+LelQ3H9qsw/lDM1V2bNYl6SpoMHjjqivNG6DfdSDM2yZ
 8Gwbal7YffDqdTOzUj70Yjs+9cjW5CJgwZo16+MNvWkoSnlfuVEbSsWX/hmUzNg/h2pP
 j/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771229008; x=1771833808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p2sNrTmrm8CFevYmz8CgOF/clFZd9NSOLufk/S3Az94=;
 b=b3Mzg6+X+osF8vQvDVEOzRjfE+SEEJ6hSEGb3JB76dliKDv4U4Qco9wgVUZuT95cRV
 /j2Wpi7LGnXDniendH/p7iFBCHFd2QpUM5PoAJOuOGHOqrHHVSFIWOsaZUCOr8981Bqg
 1JBBfZlSNtK0P1bxoDiZcIY3Jr5cvxAO64Qytoi6JMtZ3/6cALlLSCL0NAzji0d91ueV
 pQ8WNIKGTNyD/f7Q+Cyi9Jo6hf1jWX3hoPIf+xMX0rlcxwZMoU2DUIZOqVSrczOqzTk0
 j/ys3tByxUUBsauPajY0vYgksFdAYzNGxbSFNd/j8B2X30RWCs02Sylx+/HgYbSX73X+
 3vDw==
X-Gm-Message-State: AOJu0YzVc0RpLGxS7ps8IT/uR7OqI4d3xgYmDn2XDROuFF+R0+T+pkRV
 oSqka+zFz7fwB8Rkh+PPJ/TfIhiY7ntbV3TMtAFMgCJqCg/UeprxfHTl0sRDeNXJAXfdCTLUzii
 Gsq7eku5TiV1pPfxt6L6mkirsu4GUDeL20Tqpaxi9sxwdSeH9UGisaw==
X-Gm-Gg: AZuq6aJQQSlZqqYfn/h0iKPDofRxfqaRYS869iiEmGD9UbstSpf5XqqYh+XwSYuHZhT
 0wQVY+u/ohTDapW8ka3DhyaDlOozbpV+nX46zUap09cmgc3+W+h09ljl4nufhq9YK0jiCqG4Cmg
 MVUOq1sROcLVsjRCdEpCUPE3twEMmdP2JXibuh6KCaieMyUA9B9NcgrRc9XZAQsmzE2X30mmv2m
 nMC2Ayfe81skOmMfc7X4exYL/uB/d+rQMC8TGI8Ucmre8Tqw8uVHI+Oga6p5lMk6DS7R4nC4tQI
 biCOJk/CwYa5SzMA7wc=
X-Received: by 2002:a05:690c:9c09:b0:788:247f:3648 with SMTP id
 00721157ae682-797ac654a7emr65965037b3.66.1771229008204; Mon, 16 Feb 2026
 00:03:28 -0800 (PST)
MIME-Version: 1.0
References: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
 <176555459951.1592278.10213529530179974819.b4-ty@linaro.org>
In-Reply-To: <176555459951.1592278.10213529530179974819.b4-ty@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 16 Feb 2026 09:03:17 +0100
X-Gm-Features: AaiRm53e1w50Lk8BCZuERxQ_JIgeBjeClVH4qPRTKynhOaVeDfzAMXdzbBPQf3E
Message-ID: <CAHTX3d+kSNa98KSMk0Sg7kKq5Dj-NXayVJgcCOSU-DptaxeNSg@mail.gmail.com>
Subject: Re: [PATCH] ufs: Disable UTP command timeout in slow mode
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
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

Hi Neil,

p=C3=A1 12. 12. 2025 v 16:50 odes=C3=ADlatel Neil Armstrong
<neil.armstrong@linaro.org> napsal:
>
> Hi,
>
> On Wed, 26 Nov 2025 16:06:41 +0100, Michal Simek wrote:
> > When the UFS controller is operating in slow (PWM) mode,
> > the driver is disabled the timeout for UTP send commands.
> > In high-speed mode, the timeout remains enabled to
> > detect stalled or failed transfers. This change ensures reliable
> > operation in slow mode, where command completion may take longer
> > and timeouts are not required.
> >
> > [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u=
-boot-ufs-next)
>
> [1/1] ufs: Disable UTP command timeout in slow mode
>       https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/868ec1=
f0cb77ecd6cd8ab1d40feb38e238c6f1d2
>

Are you going to send a pull request to Tom to get this to the next branch?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
