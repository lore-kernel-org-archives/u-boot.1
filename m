Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86656C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA6C7875DE;
	Tue, 21 Nov 2023 16:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="2gTofCTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FAA875DE; Tue, 21 Nov 2023 16:44:19 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AAD7875F0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5caa401f151so20831907b3.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 07:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1700581453; x=1701186253;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsP7crdD/YUryl3F2svE16X8TPheJf6yp3C3JfgaHkk=;
 b=2gTofCTQl761rwJ89sTCMNSXLQLCwUylzQgA+kWq4CwgrphL3NpmQzfoB/oMZvygpD
 r1g2tLBm2aBEPqGuBLiweV5SspqBsGEYopEo3vSCOUaYIMXYGrXiUeqZMDgOebrtq5g4
 UZkKvhKHhONT2AmRIFOBu/vRW4jP4YKX6lk4oO3bUtitsZJQDcSC0nnrA5aizPjAiSZB
 9qqkcDiaMV5a679WdBxlhFIhoyw97VCBU6dHixa2b+2Rd6i4Qx4Y0vGmrqq9B4wBbpok
 jyik2hLp0nFKYNGaiOZrZSO4BBVRQlHZj2cUjsV5FosDNi/ATm33GOAkvabBhKDaFPXQ
 eYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700581453; x=1701186253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GsP7crdD/YUryl3F2svE16X8TPheJf6yp3C3JfgaHkk=;
 b=N4Dx6tXuA00pASgaUWRpSi6iWLLhq/KIAmKWIEJN6R9/2NYkepHEqqSoq0gkzsyYCs
 yyHmdEBUnESBKDN6Lc21T9PCm6CUoONmPmu81DwZ2HeyJO2qMGVyU4yAcDLf6Bu7GWNz
 Ks21ozmXZYkBXkNJQbtY/icXDnaLrM4ayV5u45tIPHJtr2DgzGWCExUiCtuv/caVB3L9
 ym06HDQDXgQ1dC4YRSlgyio4vgCfgLhLtxJQ7Og/+YDnm+TRew7sQ4LXm5Bq9vIRR3J/
 CwGVMhLzwJ0LSpMVoov8C/He0ZAt+HkxK8L+NI27UvYKL+h3vaYSCh9PsxMLXIGuwMDQ
 ZbZQ==
X-Gm-Message-State: AOJu0YyRFVWLa0/ezy8+nwVCCiZ/Y60C3xn4GAQsbiJj2yCEyCybhwUO
 nm5NA5ypNRg9MAVc7oAK98y+x9kwcIZSN/oHkgTYmA==
X-Google-Smtp-Source: AGHT+IHsCoBCjo9uOy4YK9a8G2QNkg0vy4vwDWSpv6B7DJImIFgnMsHU+Uv7RGwvNmQpiB7WXu3rQSFtkoRntIWiPfI=
X-Received: by 2002:a05:690c:3102:b0:5cb:4925:d8c6 with SMTP id
 fb2-20020a05690c310200b005cb4925d8c6mr3812127ywb.38.1700581452939; Tue, 21
 Nov 2023 07:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20231118184426.2808502-1-jaredbaur@fastmail.com>
 <20231118184426.2808502-2-jaredbaur@fastmail.com>
In-Reply-To: <20231118184426.2808502-2-jaredbaur@fastmail.com>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 21 Nov 2023 16:44:01 +0100
Message-ID: <CAHTX3dKv5HMVsy+y64E2xhHuVNRApsUzb+qQH1ztRYTEwycXCA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Write upper-case BOOT.BIN to zynqmp MMC
To: Jared Baur <jaredbaur@fastmail.com>, Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de
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

so 18. 11. 2023 v 19:47 odes=C3=ADlatel Jared Baur <jaredbaur@fastmail.com>=
 napsal:
>
> The zynqmp bootrom will not boot from an SD card with a fat32 fileystem
> with a lowercase boot.bin file on it. This means that using DFU to
> update the boot.bin file will render the device unusable since it is not
> written in upper-case.

Fat 32 is case-insensitive and case-preserving. It doesn't really
matter if you have boot.bin or BOOT.BIN on SD.
Bootrom doesn't really care about it.
I tested it on zcu102 with boot.bin and BOOT.BIN and both cases are
working for me.

Can you look at the partition type via fdisk?

Thanks,
Michal
