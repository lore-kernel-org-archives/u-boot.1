Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F22E65D2E
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 07:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FE148937B;
	Fri, 22 Nov 2024 08:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vyy/1REl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F258897A0; Fri, 22 Nov 2024 08:44:38 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B1CD88D7E
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 08:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-84ff612ca93so680478241.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732261475; x=1732866275; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dUAf7sT/SMX54n62RPOIh/rc2sDmh8phSRI7P5WOn8=;
 b=vyy/1RElYOsG54oOwKQhVJvKZ7QlV47jKkaWY6XbOHKpv/8xVDEs958HkgQXIBn1rO
 oyh4lRSML3vfZN+j/yIUazsFY2T8rBts0q7JKT9ZU98sbNUmikIrCzX0rGU6kvYD1Eo2
 7qJlEb3e5lG1DdAmrO2Xk2YrIKxNK1IIbCnHGiaLMyin3jdwZ7smbtsv/4oe4gIBeeUK
 yO+uHjwsK7NxyAQxQMc8YXii5TBOxBm1IwiU95E/kv8TMP4K0h6VvgQ/w7iVaBXORGbg
 EDG26GmTUSSHzAgEXtG3+amIhUCgG0zX5X5/2RqgWTFVNrGTgjnAxhF/5MlIcZ4a7Iq4
 uuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732261475; x=1732866275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dUAf7sT/SMX54n62RPOIh/rc2sDmh8phSRI7P5WOn8=;
 b=btYBtX3M9WDfEARGOjQApUy5LdfLHJz7V6nklKRbA4gcDbEGGWwFml6A1lT0sd1Nvl
 057I6VbeA98XUi0cmxd0CRTin9DNxdIOViEm9BtI8bShc927irS8bySU5rH64z/q9hfo
 GKl35AwfjNTb5j2kq1YZLRXOHvnxgbXjLXW3BFW9VczT48oMBzK5ZfufvJIhAVaWENig
 8O+A8PBlsyMCFWMulBwomKCKDDtNdQFt9e6gbUAHgUze/1qMZgOyzYpjaSybWmIWP/Re
 SJ1ZPj7w6mhXHfNp2v7DB0y0F3qX9xZQY+Gl4CsaepNCMUM5BHA9nTGJJm5CMcLBUzcv
 Dc4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUaL7kF23CDMMMfhlu8jjOXv1+q3sFI0xvICxA7PzwtTexm1gVpQQ42ILf55ILx/6/2qJcFq8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0icsI/DlU4lBq/JoPVqkzBNDvoJ6K6eNCcsh0iBi3nAtz82BA
 eb+W8aWyIw9yyk8pdxzYFpFc8BsyWCBxuvBbATPC9Gw9zQpIe+Yq5A6pLtp/38cu4w+crcxW9rc
 UrMt+BCNHdmEeBYZv41NRjX7xX6YNEPPwPqwwSQ==
X-Gm-Gg: ASbGncvLK6SJlfs8CK4KElct2idNpaopgpzBWeBVnixnm3oyRYh33LSpEXp7qq0VfAg
 8lonWPW3abvFLj+L0OP0rS+PIVfPdjIYP
X-Google-Smtp-Source: AGHT+IG/YjFhM1pJee+wBFqVM8CqL/sW9cH18Ass2Oo3NYPBfFGs3jWjRJL4dRnapWlNF3+n5HNZfil/RON8WrbWJ/A=
X-Received: by 2002:a05:6102:3ec7:b0:4a3:c9b6:b311 with SMTP id
 ada2fe7eead31-4addcedab68mr2499190137.26.1732261474839; Thu, 21 Nov 2024
 23:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-3-hal.feng@starfivetech.com>
 <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
 <CANV2PTNAqxrPYypHwuDa6Dz5LUO_kzRGV0PzOand-tOo_peMCg@mail.gmail.com>
In-Reply-To: <CANV2PTNAqxrPYypHwuDa6Dz5LUO_kzRGV0PzOand-tOo_peMCg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Nov 2024 13:14:23 +0530
Message-ID: <CAFA6WYPciEc-WJNc73j=C5AoGb5bbQ139p6=m7a_xqCVD4uYSA@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
To: E Shattow <lucent@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
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

On Fri, 22 Nov 2024 at 12:12, E Shattow <lucent@gmail.com> wrote:
>
> On Mon, Nov 18, 2024 at 8:06=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > Hi,
> >
> > On Tue, 19 Nov 2024 at 07:35, Hal Feng <hal.feng@starfivetech.com> wrot=
e:
> > >
> > > Add u-boot features to the U-Boot device tree.
> > >
> >
> > For follow-up work, I would suggest minimizing U-Boot specific DT
> > bits. You can either re-use what's available in upstream DT or push
> > U-Boot specific changes (eg. bootph-* properties etc.) upstream.
> >
> > FWIW:
> >
> > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > -Sumit
>
> Sumit, with the whole series applied this U-Boot specific DT addition
> is confined (with exception of what I comment on below for rx delay
> values on VF2 1.3b) to a single include file. Looking at linux-next
> there is a bit of re-organization since the Framework / DeepComputing
> JH7110 mainboard moved more nodes out of the common file and into
> board specific dts. When upstream dts settles again then there will be
> some more work to update this anyways. Is it any blocker for you now?
>

No, it's not really a blocker for me. Actually it will make life
further easier for the board maintainers in future if they upstream
everything in *-u-boot.dtsi to Linux DT. This will ensure that no more
rework is needed when DT is synced from Linux and rather U-Boot uses
the same DT as Linux does.

-Sumit
