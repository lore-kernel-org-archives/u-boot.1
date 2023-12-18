Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81920C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C227787E08;
	Mon, 18 Dec 2023 16:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U55LylED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D16887E0A; Mon, 18 Dec 2023 16:01:48 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9838C878E7
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a2340c803c6so172555266b.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911705; x=1703516505; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dyDvb+EKqu0IpR8Xy5KChFcgbjHf/PGKm/vRRwO6mUE=;
 b=U55LylEDdk7o4CbR+mijvfHxI9lJr5cmCORD1KjA2+r9dUpxhQtbsSNOWyPHn9NYm9
 71uBP1kPoqhvuwecm1DX9zTnubRUHkbHKFx8AaYNcWpPFPcCIVyGKVl3yl7olVwkHKAK
 OLxDKEK9yb94R3E9XJZpTETgAo2zmte3fNz5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911705; x=1703516505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dyDvb+EKqu0IpR8Xy5KChFcgbjHf/PGKm/vRRwO6mUE=;
 b=Eg+dAArGu8U6wN1TM11kyN1kaLureEwDBcInD6exocYV8JtlpTzU6sqWblHH10vpbn
 gv5w2og4iBHi+osVo2iX6wg6n6cUwD5zpd+F76Wqg3GowF0gg2J+DWf+9RUqHoZXo0aw
 M8WE0H2Bt182WoNFbzIIh6pq2z40UOrehGCdZ6+FIJ3bUbQkz9sk2uDb+BizAfQ87FwQ
 z+j/CRJN7SYtA3q2xFfNMnCPMlvAnZeikEqOdnfKQVjOQNpw1PABsztale6oOVrJGzoV
 /4+LU/53+8HoE1N3iA7YMJB3QwMa+K76bhyvr3HI5HTVeVtK29x7rT8eCsY2IPdXodpA
 yMSw==
X-Gm-Message-State: AOJu0Yx8cNRysDmKGRUGapjNrmxTj146d69gcR6poMjjJVQqKbnzn0K9
 e3s5B/W1POTBUqoHLIlV2jLnJ2BNN83FqyfLS8uFmQ==
X-Google-Smtp-Source: AGHT+IF5x3ypztqWALl8ZyXLnmhL5AYWdXTznS/nRrTho4VxXTakrMSh8D0Q1xpGanTwEsFxV87StdrF7CfT1TWlHJ4=
X-Received: by 2002:a17:906:10c7:b0:a1c:e980:3c3 with SMTP id
 v7-20020a17090610c700b00a1ce98003c3mr7106350ejv.28.1702911704121; Mon, 18 Dec
 2023 07:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-5-heinrich.schuchardt@canonical.com>
 <CAPnjgZ2=Qd=u7z90nYXRXNUBK6Sdu4iDiBmT00OJMi0FU1_nbA@mail.gmail.com>
 <aff5eac1-3f76-4d3e-92e5-9554c5b6340a@canonical.com>
In-Reply-To: <aff5eac1-3f76-4d3e-92e5-9554c5b6340a@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:31 -0700
Message-ID: <CAPnjgZ1bfAk1f3Y1jy-5K_-waSG328wZSPKbh-2_ELa22Weeow@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] acpi: support 64bit in acpi_find_table for DSDT
 and FACS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Sat, 16 Dec 2023 at 12:21, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 12/16/23 19:45, Simon Glass wrote:
> > On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Use X_DSDT and X_FIRMWARE_CTRL if available.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   lib/acpi/acpi.c | 29 ++++++++++++++++++++++++-----
> >>   1 file changed, 24 insertions(+), 5 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > This could really use a test
>
> I guess we want a test on library level separate from test/dm/acpi.c as
> this test will not be driver model related?

Yes, but it isn't that important. I have been moving DM tests to only
differ in their flags, so I'm not sure there is much difference
anymore.

Regards,
Simon
