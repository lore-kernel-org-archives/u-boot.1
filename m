Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A51CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 21:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826BA8393C;
	Fri,  5 Sep 2025 23:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EQZGOFVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA8C83942; Fri,  5 Sep 2025 23:53:30 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C42F83885
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 23:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-55f7ad815ceso2885938e87.3
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 14:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757109208; x=1757714008; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Db3UdhF75jvXFbWknXGaQgPV8QOv36wfoS5ErEFSlZE=;
 b=EQZGOFVFiDTaZwoB8FTskCVDmEzY3h4btomvDuzLEy4cUMkSH/2W8OBZWbKZrKviXE
 fE5iklwNwVvoBw8nI3Cxd2qBHkv+7gionwXelsblnAXmSxkY/cIFas0KasVqZZHyimC2
 wsuoNe5oLD4BqdHw8wHKiWX9rCtSyqZ14pSAUA8eNhcs3k5u0IoP7vYbRVqYdP/vApVq
 M5mEGSYreAKG0NwW6EyrAEMFXi+DjFa8CErQq0YQ6XWd0Z7Dlx3Pq2pGIUD+Daalmt/3
 Tnif6e6kAZWCcaUFbhrrd73wHyDHRs+eiXTa/2xOeFCcymbDp/H1KllziinqXmYozcHU
 bXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757109208; x=1757714008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Db3UdhF75jvXFbWknXGaQgPV8QOv36wfoS5ErEFSlZE=;
 b=jaLZvz6RsVst/tEwxpdECoOkvOLALXn/tRJaDpmbSotTPK7uRQTJoTHWJvDFYiHHsI
 DAQDwDstfT91EskZ0PHQnxMnN1MI5yQHXktNdvy0ywIlcTpw1yU/H7Xu1nJLSOLdws+4
 bVDZiSI2yq57ohinilmPKPjB+exTNzZ4GeA3w70sitT2BtZzkke8qlGi8ugJ/vzpvXUN
 o1Gkhko+3zKyyEHEH3GPFbk0rMVPvlAG5r3mxCTxH08wcny/syO/0rDLXq+toCxk3jdq
 ZbTZ+7Xu5lnXiSWl0VKeljyCRvel4s2uxU3PDzTphn8s45eUG1EeWREjhqQtlbfxRLXm
 AmXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbDuhKDQYbLkkNjeNJ3F6R8JZM8v1ifUatYN6gnwV/Cp/+/HaEZS96NZaskiZi/ggL1h+HHGI=@lists.denx.de
X-Gm-Message-State: AOJu0YzeNJX1Onh8XrgKQUX4EakNUZ9+YE1IdeVNG0wLcFsqJGyTSXxu
 JMwBUmY7DCiGeXqLT0ngf1+rwf3Wito2RyMInhPvRqb8TVpdSJbCbRcjyNPR2LnCIplIMbWjLz5
 sy4CpT7X5baTkXD/tPDWymyn0ERNc3dI=
X-Gm-Gg: ASbGncvmXxXDxwr2jc6XDP0OeaoJLq5TcEWmvf+rSoHCSI51KCa7Q+3QS19Zbv/ZpuK
 hrCPnl8UbCn44ibiep0uLBkatgNJRx/FAR52iTzI86/aoDG6rTMOquV2x5F5NYPONF5lSF+dkf+
 3tlDPjWNfzlRXp7x2P14MR/SdV4cUbxsu92tYUfN74LI4Lk/GE/5nDh5ylsOZ6m0V0tM5qM70JQ
 +p5GeTHDh8h3UgH4AEaFfSA2EiSjA2i8DpGNkE=
X-Google-Smtp-Source: AGHT+IGlH2BZ4bcCCVOxXbO3pv/U09PFl+jKwLYQXtT0FzsI9oHGmQD+/s8nDzpfZsrquStT2iYFEPiwQemIdqF6S4M=
X-Received: by 2002:a05:6512:e9b:b0:55c:d62b:d0fc with SMTP id
 2adb3069b0e04-5625f62abcfmr86686e87.10.1757109207328; Fri, 05 Sep 2025
 14:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
 <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
In-Reply-To: <20250818-imx95-v1-1-f68a19fe30b6@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Sep 2025 18:53:16 -0300
X-Gm-Features: Ac12FXzWuUPmVPekBgvC0lOJJ_zcI2WbQLZ_7aKgN3JUdhfijBTGjDwM5bq__5Y
Message-ID: <CAOMZO5C=ROcrsS256shQNP4Dfz9ca_55tT1hQNHUM=kOrxnVUg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] binman: add a new entry type to support .bin file
 generation for the i.MX95 platform
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>,
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

On Wed, Aug 27, 2025 at 4:06=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> To support passing specific commands defined in enum imx8image_cmd to
> the imx8image_copy_image() function, this patch introduces a new entry
> type nxp-imx9image. This entry generates a plain text data file
> containing the relevant commands, enabling flexible configuration during
> image creation.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

I'm getting CI failures:

+/binman/m33-oei-ddrfw/oei-m33-ddr (oei-m33-ddr.bin):
+/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem (lpddr5_imem_v202409.bin):
+/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem (lpddr5_dmem_v202409.bin):
+/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb
(lpddr5_imem_qb_v202409.bin):
+/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb
(lpddr5_dmem_qb_v202409.bin):
+Image 'm33-oei-ddrfw' has faked external blobs and is non-functional:
oei-m33-ddr.bin lpddr5_imem_v202409.bin lpddr5_dmem_v202409.bin
lpddr5_imem_qb_v202409.bin lpddr5_dmem_qb_v202409.bin
+binman: Error 1 running 'mkimage -d ./imx9image.imx-boot.spl -n
./spl/u-boot-spl.cfgout -T imx8image ./imx9image-out.imx-boot.spl':
Fail open first container file mx95b0-ahab-container.img
+make[1]: *** [Makefile:1339: .binman_stamp] Error 1
+make: *** [Makefile:198: sub-make] Error 2
+binman: Error 1 running 'mkimage -d ./imx9image.imx-boot.spl -n
./spl/u-boot-spl.cfgout -T imx8image ./imx9image-out.imx-boot.spl':
Fail open first container file mx95a0-ahab-container.img

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1238965

To reinforce what I asked you before: for v5, please make sure that
you send me a link showing that CI has passed.
