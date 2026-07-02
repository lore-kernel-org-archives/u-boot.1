Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C0DC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 12:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78C284979;
	Thu,  2 Jul 2026 14:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZXjUwbaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA8084994; Thu,  2 Jul 2026 14:01:22 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3657E8496E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 14:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-664c4a04081so1411866d50.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 05:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782993679; cv=none;
 d=google.com; s=arc-20260327;
 b=lcZj7wRSSMgHiLXpcvmC4bv/OH/lH1EvxMHNuJYFQr8dlTHpXjT6teebZ2R8xnP6D8
 OPJ+yt7prknnNwsG7MYc94mli3PO6PTCS+yppLk87mzpZS7ud1DMEMgHn6/SziMFdDy6
 IiVqhikMRWog2gRG83OQyFVaRtae0hK3PgSHvOI6nYdWrjVJXciKGhnOOs0Ni3xB97lJ
 Eff3Ed+2M5VjmRiyf8GxIWzkhq/d3LPEX9zuwPkUifYiDFNxtJny2XOfb/IrgimOmWge
 89TKK1K6Y87FKmmeViYd4LHE+d6gvmgwhif0X71hlzke+M3MN3dOBQ3PRx/mfpZOoLO7
 5bEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VkmyL8gP/nkWLWEdDlbxC72Urzly+5LlDKW8LLha0nE=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=TCHqicVyoGhcgVgYith7irt1UU7AACCUVqga7reo6vSuzDDIMeL/J2AWY9Sxqb+Jh4
 9tTFhsZpqmMGkBNlsmyDEmL72aWZx1ERSdxAsyggTR5O0rwSc1MHHYNXg/z8Dg6jTaI3
 nlo7Pk/aLaFmBVd3X7ZVhNGwpx0BV69GBNehiS2wjipBKE5o2xs5P7leeF3eYR3/1M17
 xGC74wasAPFYddF/4K4wKum0oEQykAXqFXOCA0rQBSpKpub7E1fnMlED2kJ+HrwpXtA0
 6DLK7oWNEjcC9kYdKbYmsmQGRqrt8FHqKNZdo/0jp35TmQqSzo4BsLkqro8Z7SjDma0i
 qJrw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782993679; x=1783598479; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VkmyL8gP/nkWLWEdDlbxC72Urzly+5LlDKW8LLha0nE=;
 b=ZXjUwbaB1DdAfBF+PepzxPZn4zWrKn9kOfJssAkXao9FhalQSWNaayw2mczshe2/6d
 Q4ytihLnWmYRats4lSKW5VL7DqnFmBrNFuTpOT8vGUVYrHnPOv5loUFc5+D8JA4GM2J8
 iKIxXg+sTfdP85d2f96WezSShULF0NC/59krF48u9r4qvmlbrVAUc1wbxvhWC9TDJmG7
 4yOJF2YSbReFiDS2bRf0OvN4VrBdCTHvdGw8KEg473e8cE/NXrIZ0SLiG5hemvQIaaVR
 4sc2Tup0osyA0SD8IKEKjZRZVBwXxjAh+1xOi2KyXjbhrbknuZ3nW5V7XZiyHZWFieMw
 vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993679; x=1783598479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkmyL8gP/nkWLWEdDlbxC72Urzly+5LlDKW8LLha0nE=;
 b=EMGgaV6n0demUWeKTjFEfjzi8AddH/nhF3TcJkgFMb3kQ9tSY/oJ20hxQ9Rm8rTeLB
 3GrqinsJFJf0MjZ15gziVw+515w15DhhLQVJWu8Zs9MKyC7WpEzQ1Nd8z60q99VLsHfM
 wHAzBE1pV7tVZChQfzXwGRZjqtrvf+nhM8PmHr7soiJneK4y0sqTdCZAbHRAR/U9IvON
 ODLa2dh3zKYirt9+z4lN9GA6hie+5E5EdW/U3EHxHY5b5KngiXT0d6wkhObE5BX9WYVV
 z0avu6wZN0y2jhz2VPQ5Z0O+gDwQq+Zltn1RvEgUenXkfnoXAkzKlgJpTUIpNWGB2Ksp
 EceA==
X-Gm-Message-State: AOJu0YysTh9HYJ/HdJMg8B0IeAMijQlUmcIy/TLjnx2G7SJ2JI4XMbDS
 UVqSADRwDAwfZdU+dirmlRo6E33mpEdGK17GEyA4NzzkGgkTQyGbe+ln+hLN9lR+3jTAJ9Y5cSr
 5zasUPgW94Mt30wnjpsp+llEPfFgfId64z1+hkMQyKg==
X-Gm-Gg: AfdE7cnoYDPelda/CGynx5ynV6HAagjcrsokHBkD+FrvRc/2LoY9byxSd81Gsy70pE6
 HHXd4Y0KVmAtRR4GlZZeWFWwMWz1cvo385x65eYOG9sgIpUuYdwNtw30JY4QAuKbyjph+Ll9sI9
 hkVi+SZbje64qbpgH5z2N8f3LMzI+G6vpOm6Hp7C8y3fQ7n81uEi2fA6tFAiabcZK7LDMKHDBkl
 vfe/BHgLeLOhEYMwbKFtl+gG4Rk4FP873P7HGouwWHgZazal3Wx0YSLdXoBF1ksj9jDQtq11H1m
 IKAdcy2RsxwIQq/1ASVSLVon+yxNcoSE7ks/t+F1l0hKfjeY3Wh7xAAtp0vymGH2Nlnbq3q6fSE
 dWgSzQmwpgodMsQgX03C1NVIN063HUB5XGWqtjUdiobZ6Y5IwdgC//xiTAEzCA88Z2DOVCNFW4B
 XmlL9Zv3u0383z5VN7n0+XOWxXDdSgSJClXn6Tml5IMegDSJf5im2Cy304iND+UIjicMYLxT/og
 JqhHcYhLLw9DgMEbmCuFiaQrLxAF9td2Eu86b/iIkxoviA41ewW+MNs5sAgRJZgQIcMZIo1wr53
 PY/IhNxA83zov2Ajx3NnoAuXCFGyE4mcvoFSLazdj1HEA7Kd2OW7TMJqHuMeiyPmIBoBSBk=
X-Received: by 2002:a05:690e:134e:b0:65c:5b88:84a2 with SMTP id
 956f58d0204a3-66521967778mr5792544d50.4.1782993678683; Thu, 02 Jul 2026
 05:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
 <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
 <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
In-Reply-To: <fa17c2ff-866b-40ec-ae10-847f2ff84572@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 15:00:42 +0300
X-Gm-Features: AVVi8CfG4ITiNpOdkcMnCOavYxL2UhlikM4mPbWmVj40Gnx6oPoJyaGtqu-CDGE
Message-ID: <CAC_iWj+VqjpWPDRVGvCYpWMg4hmjeS1YzPBZiMvvQqvRRLe+Vg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 2 Jul 2026 at 14:55, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 7/2/26 12:07, Ilias Apalodimas wrote:
> > Hi Michal
> >
> > On Thu, 2 Jul 2026 at 12:10, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 7/2/26 10:03, Ilias Apalodimas wrote:
> >>> On Thu, 2 Jul 2026 at 10:49, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/2/26 09:41, Ilias Apalodimas wrote:
> >>>>> Hi Michal,
> >>>>>
> >>>>> On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
> >>>>>>
> >>>>>> On systems with FWU enabled but without the required DT changes the FWU
> >>>>>> metadata device is not found and fwu_boottime_checks() returns an error.
> >>>>>> Being an initcall, that non-zero return aborts the boot flow
> >>>>>>
> >>>>>> Return 0 instead so the boot continues. The preceding log_err() still
> >>>>>> tells the user that the FWU device could not be found.
> >>>>>
> >>>>> Won't that affect the board later on? E.g When you do capsule updates,
> >>>>> updating the metadata will fail
> >>>>
> >>>> Do you mean on systems without mdata?
> >>>
> >>> Yes. if the config is enabled it will make the capsule update code
> >>> searching and updating metadata.
> >>
> >> fwu mdata backend is not enabled hence not used. fwu just returns 0 in dump.
> >> Updating metadata will never call any backend.
> >
> > The prints below are just from fwu and efidebug for the ESRT table.
> > Those will work.
> > But what happens if you try to run a capsule update?
> > Eg. efi_capsule_update_firmware() will call
> > fwu_plat_get_update_index() which will fail,. no ?
>
> it fails on fwu_update_checks_pass() before fwu_plat_get_update_index().
>
> versal2> efidebug capsule update -v 0x40000000
> Capsule guid: 6dcbd5ed-e82d-4c44-bda1-7194199ad92a
> Capsule flags: 0x18000
> Capsule header size: 0x1c
> Capsule image size: 0x41434
> FWU checks failed. Cannot start update
> Cannot handle a capsule at 0000000040000000

Ah yes, that ret 0; will never update boottime_check properly.

Thanks
/Ilias
>
> Thanks,
> Michal
>
