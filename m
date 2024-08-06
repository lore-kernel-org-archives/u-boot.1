Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F96BC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 12:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63B18811A;
	Tue,  6 Aug 2024 14:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f+x0mzqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB76C88A1A; Tue,  6 Aug 2024 14:58:06 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E062A87EED
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52fcdc2f1b6so76654e87.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722949079; x=1723553879; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJxi0UGWh80Umg492JdkFx/V9IKcX1Vjzqb5A1koQAI=;
 b=f+x0mzqZKB9yG+YseudM0xDehXkGH++bCv/q8Guawn4MpniaR6M7SCgpjT3ZSE4DoH
 fFznho6aZp/ZCS8kh+43uMMZWCgwtTk3meq1WH+6P6MrX/3A44XjZcMHnq6Va0959Pza
 DlpIYdwHwVl4hs/TMLkD9PN9SORhKfCwN6nzXjZh1jNZdCDt1HjZc4W6v/4fF4dL9F+o
 yy3Aki0Sv1IGqxTOdelMlbPZl6kSORrVZ5jbwPdowbk/mMxFnEu7BXyKZ/tt7K5g/raL
 VFSazxHWb7/EKyRggBV30zdf179pm0DfWBtFzLpj4g/tHJ2nU+bzGI/jEM13qPN2i447
 En6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949079; x=1723553879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJxi0UGWh80Umg492JdkFx/V9IKcX1Vjzqb5A1koQAI=;
 b=jTzJ/LxF2OCDwl/clBQtIfTJV89B0yReBLkO9jmNv/kbJzSljvaiI9eo1alYdrBlZ7
 E1JNVOrKNg3XuHgrxnXcLU8p8GPbNfc4Bv7td62oeUlnmxnzrAxcQcgsUk195vK1wAOm
 VrW+13LCt4mmb89Aah/x/lJ8fz16ASJ7u/7EvgzDJ0uuQ3tUalpjaYKMAdUEQ8S0alU/
 nVBH6em0HPz4hiHh6EFF20bbmEavRigu0eOA2WYgUYTItGdpK8LNxUuXm1g53dYzbAkx
 5fQ93bGphDUoyFBnqvisG4sQ7Fg/dbI4iBrnJiVK6V3kF7DuVO7AnnCEqtUH9dpoU5dJ
 RT+g==
X-Gm-Message-State: AOJu0Ywbl0aeGhgP6fHytX9KGvuUKqc5ESjbWLxCaJ6w3szwrNh3N+e1
 SM4ryRrcRZUKjJPmm80NXMvXuapPAQyetPqPVe6g6p79CxviI945uqdPjiyXkPAT1BPU93yAHDa
 iYz+nqPCnI6BaeZFkRFeXK1u/oTE=
X-Google-Smtp-Source: AGHT+IF1z0ZG7zlpvD/Wjb/f+SisjOtwNaz1WZGYyJEHXi+iRCsQV5rFSL1CchY6ItCjEi2yZJxhTMsVERxmmgatWx8=
X-Received: by 2002:a05:6512:3da4:b0:52f:c438:883c with SMTP id
 2adb3069b0e04-530bb362e75mr5616790e87.1.1722949078987; Tue, 06 Aug 2024
 05:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240806081131.4065425-1-lukma@denx.de>
In-Reply-To: <20240806081131.4065425-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 6 Aug 2024 09:57:46 -0300
Message-ID: <CAOMZO5BUi3VZ6nJSt1baMmLL0GLWcOzA0QBJFsSQ7W8-7tJ6Lg@mail.gmail.com>
Subject: Re: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
To: Lukasz Majewski <lukma@denx.de>, Teresa Remmet <t.remmet@phytec.de>,
 Benjamin Hahn <b.hahn@phytec.de>, Cem Tenruh <c.tenruh@phytec.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>
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

Hi Lukasz,

On Tue, Aug 6, 2024 at 5:11=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> This command allows easy update on SD card or eMMC of the flash.bin
> generated (with binman) during u-boot build.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> Changes for v2:
> - Remove 'update_mmc_part' variable
> - Change path for hostname
> - Use full version of dhcp command (${loadaddr} added)
>
> Changes for v3:
> - Remove +1 when calculating the size of binary to be written

It looks good to me now.

Teresa/Benjamin/Cem,

Are you happy with this version?

Thanks
