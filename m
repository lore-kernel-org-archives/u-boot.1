Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAA7CE8E94
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 16:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D0C88FA7;
	Thu, 24 Oct 2024 18:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WbuZkD3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6AAE88FA5; Thu, 24 Oct 2024 18:55:21 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8390C88FB7
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 18:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99ea294480so76016966b.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729788919; x=1730393719; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUfdZGKBJaEKelZGKhF8emrs8rftWH5Wq7rX7jV1pFI=;
 b=WbuZkD3YpeTCrbZW+93TADgBxDQNo6m2n760ew9M50dfJiTTy1lb0YFNY88VNtxRJh
 Ow6OGR7UVZ1hhi2Pzm4qdQJ16fjlhN71zYZCIYty13Sy7hmmKU0lHfsWZR0I4CPCAL6G
 zh203iJ+CbnQxp3uMR4HqGbRMgdvn5QcbS6j3lnwjwTmZrzgEImem37fK/AaPJM5oSk3
 bjvT+jElvDdsf4de32ISyw/9eU/QLMXRPfAqdjYfvIGlbcHghNQy9EnRA/MbX+SDh8H1
 8uyvAbOOlX7+tFHQEAIjB69UzfHunlqebCY7bXCXkLsw7wn87+Pp0YeFFziMdMYncRr+
 H2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788919; x=1730393719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUfdZGKBJaEKelZGKhF8emrs8rftWH5Wq7rX7jV1pFI=;
 b=BeaDZkV60HZ/e6f6quMWFcetKKtXw2E5BJlKjKm1v0ulNSJG0m+E8522VXVlM+FqIB
 WwSXwRJp9b6mCs4KfvBsDh4FsCYAJRwzlfOGc0MXli70yaC9y0+/syyRtX1QE/4JgVfq
 +/ZUNwDWPKc5sDDvdCRMmTwN20EsoTkmOWubgrgZuC2P0/8QnCUfNbZkZhZ8RZCTBH6l
 LSo1bmyYDruAVCMY7+42LkHCYwy52fzOTepPF0r+zTuSXCo+PSysOU2RCjOz7whHd1JY
 NlCzKcj+WJpZ5fFteAxpI+sLb6D5Z8yFhL8siodpZxAnltH/gH0/yIJkkFWTP2vBmzld
 Hv0g==
X-Gm-Message-State: AOJu0YwaiwGDDlHUVNTQ9YQp8dlsoe0H0bJx4XexTBOtBGxPunrMepIH
 Za3j426tjQ2lDlIbty9PpUFdPPDllvKkdEQDt/ZlPRMjQFv9vM4b3NOUsLGKana4xZ+xvxIJ3BT
 npt/ACDyQVJ4btsHnhyATNGv8+qf0qVju
X-Google-Smtp-Source: AGHT+IHbtZISkaVebe1AS1MuToGguXw838GbdNErlErnaKevqg8j5Y2zRWNk0Nx7ABVY81ujauQB4roZTnTa1lUwBII=
X-Received: by 2002:a05:6402:3493:b0:5c9:1beb:b971 with SMTP id
 4fb4d7f45d1cf-5cb8b267fd5mr6820472a12.24.1729788918607; Thu, 24 Oct 2024
 09:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <AS4PR08MB8167C4DB165AF2FB28C0751DC04D2@AS4PR08MB8167.eurprd08.prod.outlook.com>
 <CALeDE9OCPGb9PK9evm=8bQyV9fWHrHd0TuOA6BSufT5mZLiX9g@mail.gmail.com>
 <AS4PR08MB816759780973DAA85256D034C04E2@AS4PR08MB8167.eurprd08.prod.outlook.com>
In-Reply-To: <AS4PR08MB816759780973DAA85256D034C04E2@AS4PR08MB8167.eurprd08.prod.outlook.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Oct 2024 17:55:07 +0100
Message-ID: <CALeDE9PiYk0Wyza8iSXZqAPjmK9F01zN4iq3FSprTV34U1Zfgw@mail.gmail.com>
Subject: Re: EXT: Re: Patch for 2018 u-boot : Fix "EHCI timed out on TD -
 token=XXXX" error on ehci-hcd
To: Kumar Girish <girish.kumar@al-enterprise.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Kumar,

> Thanks Peter for your help and suggestions
> This is for marvel Alleycat-5x which has armv8.
> Upgrade is not allowed without the approval.

I suggest you reach out to the Marvel team them and ask them for a fix.

> Regards,
> Girish
>
> -----Original Message-----
> From: Peter Robinson <pbrobinson@gmail.com>
> Sent: Thursday, October 24, 2024 2:07 PM
> To: Kumar Girish <girish.kumar@al-enterprise.com>
> Cc: u-boot@lists.denx.de
> Subject: EXT: Re: Patch for 2018 u-boot : Fix "EHCI timed out on TD - tok=
en=3DXXXX" error on ehci-hcd
>
>
> ** External email - Please consider with caution **
>
>
> Hi Kumar,
>
> > I see the error ""scanning bus 1 for devices... EHCI timed out on TD - =
token=3D0x80008d80"
>
> You don't mention any details of the device.
>
> > From the denx site, I found the below patch. But it is for 2016 and
> > 2017 u-boot version
> > https://lists.denx.de/pipermail/u-boot/2020-March/401784.html
>
> So the patch looks to be sent in 2020 so I'm not sure that's correct, and=
 looking at the thread the problem the patch is trying to address were fixe=
d another way and the referenced fixes landed in late 2019.
>
> > Could you please provide me the patch which can be applied on 2018
> > u-boot Thank you for your support.
>
> Is there a reason you can't use a newer U-Boot? The latest is 2024.10.
> Have you tried that? Looking at the thread I suspect the problem is fixed=
 in a version later than late 2019.
>
> Generally the U-Boot community is happy to help with problems but it's no=
t a free patch consulting house. Generally you're expected to try the lates=
t release and see if the problem still exists there, if for some reason you=
 can't move to the latest version, because it's a vendor tree for example, =
you're likely better to go to the vendor that owns the SDK for assistance, =
else there's a number of great companies that offer paid consulting for U-B=
oot.
>
> Peter
