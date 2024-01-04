Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95AEC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 16:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 596F787930;
	Thu,  4 Jan 2024 17:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y/lTeFj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156AD879A9; Thu,  4 Jan 2024 16:53:40 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0364287937
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3373a30af67so529490f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704383617; x=1704988417; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3EdByaSOyqAsAc9uGsnAQpBCGoHUyBDSglHBDHMx3xU=;
 b=Y/lTeFj7gQ3XfsXE6xvdgB7S1I4krVuwjPqEhBJWfHCuC8KeAelROJtMOiX9KhLfWP
 rzO5lOXJGmSKEkjWo/zuPQh5lDJIl/ZUOPYcbJTKoAqvv0TQINPF6cJsmFJESHgdrjyr
 D3aONV8d1uOdWOoEGKIbHAsCgG5s9HLC3mfjrjANmDReFAx1B74vFix6E+++QawjPE9z
 TagVf82A+0+iom1aaBYmxxUtuOhQ9+MyJg1uvEoc2wXRoMtBgnvCfrmH6gOSjUEiVE/w
 Wm5kXYi5vICVArDsLWDAm7ZWrx0q5mgbkWcuGGBXNTUnRqPQWkDk6qkg/XtENZTRa9PR
 io8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704383617; x=1704988417;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EdByaSOyqAsAc9uGsnAQpBCGoHUyBDSglHBDHMx3xU=;
 b=a/jRlFmGKJjQgpoIH7JJOF9B8fyI82uKLbXMgsybk92OOmBNMPaMbEhMnoiKRGwpPw
 XRsuOI/CfV5d4kF7toJymoa37B/JkcI5FGEEm8BJz4cTAhDIXcSIgVbZOG51sMnAVMQ+
 0QYLDkg/RO7mwH5PQCS/maQIrPtwArSpmZ2NKuOVDA/+Hsy9BrGvpcMSCkJFvA6Cowye
 VNMt3tpFu/GVydGlQCewDJMAix+5qPrAh96rpp5DCNPMT3z+2r9TucR7xEPBtY36kNdF
 OdY44eyfRbbEutwZsy/KXHaX2tEfFoliUbIBjke/h5N0X0LOBekJHC8y6mlnQEgkTY/O
 EVQg==
X-Gm-Message-State: AOJu0YwRsyMC3+/BZ0verUfRXi5XCTg2i9FB2Y/LOniIFo3xIBXdhmc+
 4X+gJDdIbOCLdz2p5UPHwe0Ujgsx07E=
X-Google-Smtp-Source: AGHT+IGy15KYJvAbFZrFd/NXcN4DRP9edT7wKWftUM/XYJwZP7vBTgQgszqliGY0AYd2pHvlUpsXlA==
X-Received: by 2002:adf:e50b:0:b0:336:c876:a417 with SMTP id
 j11-20020adfe50b000000b00336c876a417mr310125wrm.99.1704383617077; 
 Thu, 04 Jan 2024 07:53:37 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:ddd3:fad7:e5a6:7e01])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a5d4948000000b003367a5b6b69sm32976221wrs.106.2024.01.04.07.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:53:36 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/3] Add imx93-var-som support
In-Reply-To: <CAOMZO5DPuTmvM9_tFDytC4xVENZH_z6Rin5eJ_tHu6Uer2HaAg@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 4 Jan 2024 11:29:06 -0300")
References: <20240104091350.18252-1-othacehe@gnu.org>
 <CAOMZO5DPuTmvM9_tFDytC4xVENZH_z6Rin5eJ_tHu6Uer2HaAg@mail.gmail.com>
Date: Thu, 04 Jan 2024 16:53:35 +0100
Message-ID: <87sf3d14e8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 04 Jan 2024 17:10:51 +0100
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


Hello,

> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/764727
>
> Take a look at the xilinx_zynqmp_virt and imx8mm-cl-iot-gate errors,
> for example.

Due to multi-threaded testing the output is a bit hard to read but I
think that those configs are working fine.

The faulty config seems to be imx93_11x11_[ld]_evk and I can reproduce
the issue locally.

The problem is the following line in mach-imx Makefile:

--8<---------------cut here---------------start------------->8---
u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
	$(Q)mkdir -p $(dir $@)
--8<---------------cut here---------------end--------------->8---

We are expecting CONFIG_IMX_CONTAINER_CFG to be set for all the IMX9
boards which is not the case for the existing IMX9 boards:
imx93_11x11_[ld]_evk.

In v5, I propose to fix that by adding binman support for the
imx93_11x11_[ld]_evk boards. I cannot test that but I expect those
boards to behave the same way as the imx93_var_som.

Thanks,

Mathieu
