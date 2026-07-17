Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41E8C44515
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 19:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473A9807C4;
	Fri, 17 Jul 2026 21:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LAi6Tmxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9E58341A; Fri, 17 Jul 2026 21:20:57 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BE180517
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 21:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-80814edb536so51044657b3.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 12:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784316051; cv=none;
 d=google.com; s=arc-20260327;
 b=n5iaaFZfcskyZClK3+oReDnXA1e1UktAjZVC9SUusqDQPpUX8Vjd6AYM8dFbJpCoRH
 TptZtrLlpuBuTutZ1smLa5JMQra87JQQMwWjzozWBmu+R45Z2fCR6W4geYpzQ+SedJSH
 7sUsjIX0VSCS3UTVD2PL3RMcNRP+wWhSjCEEU689b1Xt3WykHWCrhUuqeQRfdMXz4v7j
 mPV1kbkZIyFaa6qgB0gimED/3qz35c4mHsBnR80fIPwOQh5Se5yGEU3u6paiIzDqojEH
 A+31SALsgvzBRpcEAt1FVDZw0s1J2LF+QR9YUd4w4ps3NdMWMxYFbZn0veBqsPrPXBAn
 S3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PbqsAbWLIQRdq1BiUOwyKGOlNUogsJ4kG4DEQ0PqgIs=;
 fh=Ftkd5Rs+kMVeiQJrUd+QrrAOIVOKbqzVSyXv8OyUx5A=;
 b=nxEZdWYlHsZHYb0SoaGNu5qKb/9vGrsXOpyHmpNj6BgVBr/CNnDDZLe3+rSP4KDbTJ
 hmJG0QnQuBBMfecOCiE7dYaG7ByfQrvObmJoOnW1nFhTnJsiHpHp0qGBkUe8SAMDQLB2
 yDk69wD7BQ6H0NkgfaNuu8LDLMD7o8IFImBxSOsE8j14h5vG0VJgyT9QelIcqqafBKbt
 C+khCNhPP5aSVphUi+QuLHgpS5FO3HUSh+TdJxVjxXA5dkUzv00NlIMEgXX/2Pr5eCGa
 +k87HlgSmEg33qpcNqG3UDCK12Z8TUlWhiHhFzg9jtcjh/ss3bXzsGiDlvDsXu8BX5gt
 roUg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784316051; x=1784920851; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PbqsAbWLIQRdq1BiUOwyKGOlNUogsJ4kG4DEQ0PqgIs=;
 b=LAi6Tmxl3F2x4bWahG/tj9YyYEo+/vmOZl2wBiDgSOGk82KvqajePCOoBBtfaJmU3A
 kghHfvAmi3OSaKpYAyVoYv82mvzFbjU6CKEp18q4OAUNbQiHX/hwPrYczv83pOh4pGo6
 33QbIS3HxAADMTfghSYvIvtTn9iq4V5H7qNp0dbkMGxZjSLUmGWQXyL2bIjiaZZnrJVy
 /KLd1LOJDCqLJ++pqen2+dTNQ0qLoLYqW7H7o3oibE+Jux7EbNDkiaL87AguAS6nfECe
 YC37sWZmYRwYOBo2ksQqM9QuyLjbLbpOPYrmPh1dhBPyuOv9UFYxZhTNBCcXrevzryuG
 TSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784316051; x=1784920851;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PbqsAbWLIQRdq1BiUOwyKGOlNUogsJ4kG4DEQ0PqgIs=;
 b=AuEvAbc3Tut+yqZQSvX5dZ0DMzsBM1cjSA7GWkwvW3vcb4mIZch1X9P5mKYgwQpvXD
 +d1wuBcWsQac/8/6hZLkmw3Psecu1WX/OKYXVRsVyi0QEaOJ1jSEdMGID37YyJ48P7Kl
 XkKtNDvqMMXXgGEFe8xDorMSMsE/Y0lcUWzg7ytFqW2hrBH9G0xhb6vUDtG1YIvUtI5D
 A9KrPD0tgMYcVr8reQS/9aUGJeMCOpMZ+R+fwIbjQXid9NmwvQDgEou/kGwGBV8yjepM
 OT0RTFH9kK6RIZL9i223hK38pEaASA81BFuMMXrkwK4smjyTjyKUrTUZLBoQ77nAcW2d
 wF3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr98B0B92624HZ6hi7MqtFam/+TFyrEGgqh8NfOrs4V9FQSggPjqCIA9G6d9LIzCk94uP3q6jI=@lists.denx.de
X-Gm-Message-State: AOJu0YzsyPv/zsrBe+DsI+Csx/OrooT7hSZnZHadApeodR5v3eApRgKj
 5wZURr013RyMvRc9iJvBD4krItVrcci/XKC4h400lOsvis9aMjtwiqVkiOWMRMBNX1B8sLAYPvy
 fnfTeQiLLr8/t7kYZ7pdiNC/p1GW/uCLcC3EGge0b6w==
X-Gm-Gg: AfdE7cmMJeMV1SkRPIohVvJIGHPJcv9J45p0IN22AAhUI/CLLVSJAz9a4LRrXCj1kCG
 4urAYSAiUtKotn/dWikuUmfHT4f2u+ms2zVOCHjVrJgq+d7P/3XBSaPPOs57ZpkpYd5JxSOZrQq
 jjWOUE+Sc1NNIv0EU35qcGHmOUFeMCO2Zbl2bFh6/+TbTGID4RATVWUSk5sB3yAN9RPzUNiBAGl
 UO32pW4IPcQ9/FA32LX3ufleJ1dDaVeKgJ8ia9tZGlEophT/zpyUEmsJbIoDXTkrocKqvxk+Cnz
 VNIQ/QZ8dO2qJCpdp0IWQiO7D7ysnIL3wxVEKxyMHiCr3ayUnxQJInbkioRijA1txYV+QQJTEKh
 SicYf+oGEZL7zaSy4N5YQ/n9jvPc8usbnHuXgkQ88I+69EhdgsVFImmKKa6I1zqB3ZVhilSZv0V
 6JBXIUerkp1rHkL08b22c3WgkrT2OMO4ivFsh9N96/yJLzgtV+Gxc8hOC9zAk5kjT3iJojOjbT6
 D4v7Inm8xPPxuhC0pHB3uIdgDEzRO1zaFpf81XOuNvThc41k24LtBktzLsAPxd9gsqUl2lQrkqj
 tPVjzdhry9BJeXZK8/GbwJ/spKORElojpLrSRnK3w2eBBPSsfvJP6d8r8K9ONQ==
X-Received: by 2002:a05:690c:4484:b0:81e:f102:aa02 with SMTP id
 00721157ae682-81ef25e1749mr13509577b3.41.1784316050831; Fri, 17 Jul 2026
 12:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-1-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWj+VQyO1Zy+mPqcQJY91aEFsrwXFT4dbObejar0fDpCaSg@mail.gmail.com>
 <a4b3eeed-0789-4bec-b29f-d13e3e3b3016@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
In-Reply-To: <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 17 Jul 2026 22:20:14 +0300
X-Gm-Features: AUfX_my_iCaEROOAwVIm0kCHzWBFLvdyNNJNT3nhdgAK02RMz_26Hjt-yrW2y1k
Message-ID: <CAC_iWjLojim-XKOT0VVJMqp6YvaeEpxJtnLsiCmtJae9T4nK0w@mail.gmail.com>
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
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

Hi Balaji,

On Fri, 17 Jul 2026 at 20:16, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> Hi Casey, Ilias, Simon,
>
> On 5/26/2026 7:05 PM, Casey Connolly wrote:
> > Hi Balaji,
> >
> > On 25/05/2026 13:24, Balaji Selvanathan wrote:
> >> Hi Ilias,
> >>
> >> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
> >>> [...]
> >>>
> >>>>>> To support multi-image RAW capsules, we would need to:
> >>>>>>
> >>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
> >>>>> There's an equivalent tool in EDKII that can produce a capsule with
> >>>>> multiple payloads. There were also patches posted for mkeficapsule,
> >>>>> but need some minor tweaks to merge them
> >>>> Can you please point me those patches? I did a search myself, but
> >>>> couldnt find those patches.
> >>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
> >>> sughosh.ganu@linaro.org/
> >> This patch you mentioned here can create capsule with only one payload=
;
> >> means for multiple binaries we need to create multiple capsules. I hav=
e
> >> also asked the person who made this series to respin, but havent heard
> >> back from him.
> >  From a quick look it seems like it would be fairly straightforward to
> > extend mkeficapsule to support multiple images, the capsule header has
> > an item_offset_list[] array with offsets to each image, today we just
> > write 1 but it shouldn't be too much of a challenge to put a loop in
> > here and extend the argument parsing.
> >
> > Given that we a) already use raw capsules and b) they are part of the
> > EFI spec, I'm gonna try and save us all some time and just put my foot
> > down here. A single raw EFI capsule file can already support updating
> > multiple images, U-Boot already has all of the machinery for it with th=
e
> > exception of mkeficapsule but I expect that's something you can tackle.
> >
> > The upside to this is that you will be able to build capsule files for
> > updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
> Thanks for the detailed feedback.
>
> We agree =E2=80=94 we'll drop the FIT capsule approach and move forward w=
ith RAW
> capsules.
>
> Here's the plan:
>
> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series [1]
> to support generating multi-image capsules from a config
>    file, so we can build a single capsule covering all the partitions we
> need to update.

Thanks, that would be useful.
Keep the on different patchsets though. You can still add the capsule
update machinery and use the EDKII capsule generation tool.
I.e, you don't have to wait for mkeficapsule patches to go in, before
your board code does.

> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
> supports a single firmware image (U-Boot itself) via a
>    single-entry fw_images[] array. We'll move to a SoC-specific,
> multi-entry fw_images[] array (defined per board, e.g.
>    board/qualcomm/<board>/fw_images.c), so a single capsule update flow
> can cover multiple firmware components =E2=80=94 each with its own
>    ESRT entry and FMP image_index =E2=80=94 instead of just U-Boot.
>
> Will send an updated series once the mkeficapsule and qcom capsule
> update changes are in shape.

Thanks!
/Ilias
>
> [1]
> https://lore.kernel.org/u-boot/20240419065542.1160527-1-sughosh.ganu@lina=
ro.org/
>
> Regards,
> Balaji
> >
> > Kind regards,
