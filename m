Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CDCC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 19:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0055487CF1;
	Fri, 22 Mar 2024 20:32:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mbOAnYnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB8587CAC; Fri, 22 Mar 2024 20:32:03 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D1F87CF1
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 20:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e09a7735ecso1389395ad.0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711135918; x=1711740718; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnRJR6JUFqpKrrivR2lpHtNaNNUM4ytZwRhFDQQxOeY=;
 b=mbOAnYnjqO/8Ar79T+Te7GOn2CSmvM1xDBNaC0SjebEZ2V+eviqhdPcccqm82qOGrb
 pUEezZLUqxC5rJDtpOv0fEmp/8roBT4/D62ndwC8adan+3cGKjDnFoxK0qvZnhg2Xb+C
 V4xSmMbDh/22oQnPz/eDY20iVEp26OZbZd/Y9JElcU4hWCiRsC/DDVLxeGz7OBK0gC76
 PVhK/Tcm1LQku3d518sYqoxK+PRSH2ljd+dcLxc8ugC8Bo4VrbXuyjgB8D5Gxxamysw5
 LjjwMlj94OSWWizsnRNbT4mjdORSSUozmIFsR1E53ugfvML4QU/g4Kllyl3FLHPUkEK3
 S5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711135918; x=1711740718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnRJR6JUFqpKrrivR2lpHtNaNNUM4ytZwRhFDQQxOeY=;
 b=UGjhQWL8nkAr3yJTDK/O0Gx1NHPVl/UdI0HPk5fOejdfyWCA0kMa0orgFDWH0jhhuW
 hOAsr9CJvaSOYmvLYgRXCNWe92bnXCf2sOsPRYK307ei5L5SUMP4+4tTDTGghbykrS1h
 Wv4JhlMm16rP2OXhe++yC7wsitso34FCKFdT1h0sKzT951MBQuDBgP4oU1wkQxRgFvEB
 IMts/O2otT35XLwGhCtR99+T9UbKDj3YctmYG0yORF+DJMNXE73OlVXRtZOOZ/X3kg3D
 qE/C9drgpvHHfFXAhdqbpQIR29CoumY9tUNyj1dZdAkM+qcvAwdmqXLdwPVF7h45jcnF
 KTdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIfFKXQUx+u2xeWy+CJHiZtL/55jK6aqDmPPx3IeYNuSRCwMOGqy4+DF31HaBf6cAfA3E0Jg8BlZH4l3HFsulLDa11SA==
X-Gm-Message-State: AOJu0YydhaeZyEZIUA/wwBDuatPSdy7sqZlTyBCFSuMrU/1iR3qk95mK
 1ZickdWYAypqLqaMv6K1XzurP/gV2vZUvmYAdkbnBYm58sxxsnMALCRy39HObnlUxQwZ3cge4SL
 Ba7y8BnCDP1LiWljiW0Sx2i4dM9R1uD4Y
X-Google-Smtp-Source: AGHT+IFGIbbbHJTuVHz6mCvJ1zzsMS6/jGePgButaC0FwuucZwmsa4d5AFawGru22UIyOlQw3dMcxrN0BSZYVIGTzBc=
X-Received: by 2002:a17:90a:6285:b0:29b:780c:c671 with SMTP id
 d5-20020a17090a628500b0029b780cc671mr636007pjj.0.1711135918363; Fri, 22 Mar
 2024 12:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
 <86o7bazheg.wl-maz@kernel.org>
 <qnca6it6fh6pznsvm33rwa3pf6ushtkpvyui6fds43fcdjxcz5@66tiqctl7arc>
 <CAOMZO5CNgJUbDGdyP4tS7YBXPqcmyT+FkhaF+phbR64grA2i0g@mail.gmail.com>
 <yltha7mziq43ke7kas433zlvxamri2p7h2p7oos3x4dexk2oct@gfhscvngsjcw>
In-Reply-To: <yltha7mziq43ke7kas433zlvxamri2p7h2p7oos3x4dexk2oct@gfhscvngsjcw>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Mar 2024 16:31:45 -0300
Message-ID: <CAOMZO5Cy9tu_kWDmZZjHa0PAH9+RjHrQKHMwqCPe7fFvj=W6wA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Marc Zyngier <maz@kernel.org>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@denx.de>
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

Hi Tom,

On Tue, Mar 19, 2024 at 9:39=E2=80=AFAM Pierre-Cl=C3=A9ment Tosi <ptosi@goo=
gle.com> wrote:

> For most AArch64 U-Boot ports (including the i.MX family), the answer is =
trivial
> because they use the arch code i.e. setup_all_pgtables(). However, as
> fsl-layerscape re-implements mmu_setup(), it had to be looked at separate=
ly,
> hence my question, which you answered above.

As Pierre's explanation addresses Marc's concern,
do you think this can go to 2024.01 to fix the boot regression on imx8qxp/8=
qm?

Thanks
