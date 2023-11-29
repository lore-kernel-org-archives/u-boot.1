Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F56DC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 20:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8650868AE;
	Wed, 29 Nov 2023 21:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WjRQaAHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C81869F7; Wed, 29 Nov 2023 21:08:28 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACE2E86564
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 21:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=phanbagiabao2001@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50bbfad8758so287407e87.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 12:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701288506; x=1701893306; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ppCldqjQIpKKi1eXYnxkBToa+qvRq//tCreprxAiavw=;
 b=WjRQaAHLUaGErA02iYRcwdarrpvwJZr/Tk10OpmWykDOPT5SU5bBoVJvzVRGHx8goP
 wHJADAM5KcPe6xD3v5R2izhAx0zIU88/LVn+IhSkWD9e1Ib9+oG5YmqXefiJiaIrM1gz
 nnZ24lesQxRMeoeWwbsv+JQHKICI90HdxI4DF8ADxxumDX+WwGpzWdAqUZJM8oH1GBbX
 5Kt5PIus0SJnNiBgAuNV/GkgIYq17X0xIxuxKPIEebL0QIt6Xw5jT6Hm4vtjy2RVFSMz
 VgPqB1Thp1KzyvI4Tn8gMA/bYurgmLK2NMmnUbbShqXTCIG2QRsRAy2WKKdr5LLPEnAI
 hQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701288506; x=1701893306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppCldqjQIpKKi1eXYnxkBToa+qvRq//tCreprxAiavw=;
 b=qNtvD8JrlHEQNAjfPhh6MWsQydZoqqVFdVmqiM1N5njNx9fysmFxY9VbhJpqOnoUwE
 FwGxlfq1EwzkkfsXuVTs1pUK8wPGkxO9mNMMXeD/Y3+bVANs3ZtZdodx/NKE4kaDrlf3
 WWgt27d5nosoKohc7047VcA5e5WfTl8PJbKEXGSSTybcYRC1zc5FKFY+DyWJJGR/V/Nn
 6+th84HBf/6xQX2gBuCGY3cVtEyTZjl+TXKDlD3v9GqTkqxUXyDRcdh2QCEFLJymTpXo
 7VwuE/7YXWrMI4m86+R1qhQDO9xHYbWd1fkr7qS89Hg+Q3PI5y1YoQb1ikkr0k5lN8kH
 htdw==
X-Gm-Message-State: AOJu0YwkrWz1GJ70KCgjmSL2DdCPmXwnYE6Px5MNxQ3GL1SzXUxLQE+Z
 rPVPe8v5mKFQJ1ecKDzjVoDpRbQZ1SZy1fK1fRk=
X-Google-Smtp-Source: AGHT+IHY8Ecp4GhzCO3v97Yy3PhE4xbfJCP99OYbvAxsBrmhdcbZhBpzOcTCsDNxdh21NP0SNFm6aFsvCxF/F81237g=
X-Received: by 2002:a05:6512:696:b0:50b:c7aa:1fb4 with SMTP id
 t22-20020a056512069600b0050bc7aa1fb4mr2143833lfe.4.1701288505610; Wed, 29 Nov
 2023 12:08:25 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
 <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
In-Reply-To: <CAPnjgZ2JUCWjr35yL6pb2XSEs7659A1Sjh4CgQ6B=vXCLhRvtA@mail.gmail.com>
From: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>
Date: Wed, 29 Nov 2023 21:08:14 +0100
Message-ID: <CAK9R8u8zM15A-r1wEy059KViGkrV_VOtSEo6anHAkXZsXiqF_Q@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Simon Glass <sjg@chromium.org>, xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de, andy.shevchenko@gmail.com, trini@konsulko.com
X-Mailman-Approved-At: Wed, 29 Nov 2023 21:10:48 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

>
> Sort-of...the refactoring to allow ACPI tables on ARM is completed,
> but I don't think any U-Boot board uses this.

Can you give me the link to this topic? I can not find it. I think that if
U-Boot can not use this, EDK2 may be a solution.

Firstly I wonder why you want ACPI?

For this question, the aim of the ACPI table in my project is to *configure
the HW platform* replacing device tree type files currently used.


Le mer. 29 nov. 2023 =C3=A0 20:28, Simon Glass <sjg@chromium.org> a =C3=A9c=
rit :

> +Heinrich Schuchardt
>
> Hi,
>
> On Wed, 29 Nov 2023 at 08:29, Ba Gia Bao Phan
> <phanbagiabao2001@gmail.com> wrote:
> >
> > Hello everyone,
> >
> > I am a trainee at STMicroelectronics France. I am working on a project
> "Setting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex=
-A
> . The objective of my project is to add a way of booting (with ACPI)
> besides Device Tree available on STM32MPU.
> >
> > I found that ACPI was enabled on some x86 platforms but I don't know
> whether it was set up on ARM or not. I found a PATCH that discussed
> Enabling ACPI booting on ARM with Raspberry Pi 4 but I don't know if it
> functioned or not. Did anyone here succeed in setting up ACPI on ARM by
> U-boot?
>
> Sort-of...the refactoring to allow ACPI tables on ARM is completed,
> but I don't think any U-Boot board uses this.
>
> >
> > What are the differences between x86 and ARM platforms when enabling
> ACPI? The architecture of my board STM32PMU is ARM so can I apply the
> technique used on platform x86 for my board?
>
> Firstly I wonder why you want ACPI?
>
> Secondly, if you have the tables somewhere it should be easy enough to
> build them, building on the series you pointed to. Heinrich is
> interested in this, I think. I can help with advice. I have been
> toying with going back to that rpi series but have not done so yet.
>
> Regards,
> Simon
>


--=20
PHAN Ba Gia Bao
Etudiant en 5A STI - INSA Centre Val de Loire
