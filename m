Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309A7C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D038E887F6;
	Sat, 20 Jul 2024 14:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I4KgUKpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE4488675; Sat, 20 Jul 2024 14:36:17 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01EC887F6
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so21522546d6.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478972; x=1722083772; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xf/zQwXFSV3kA1yjOKv+D+plZr6snh/5zWnFeRAfte4=;
 b=I4KgUKpHcIGvIgoLinJGYAy3+CH67u16mTGw+w7P6SRh8ZYKW/QtRP+XxYhEf1+sCc
 POsRS69A2QVUCJ5C9t2QTLz8O1dkI77uMnNvzEOE5v7EHbsntHIzA/GUm2dWqlmih5je
 ZXsMlXxglk7OVoDqTOGuZaR7BCKo2SfgakXfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478972; x=1722083772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xf/zQwXFSV3kA1yjOKv+D+plZr6snh/5zWnFeRAfte4=;
 b=aYUj8Ki9O5S/FoYJUgBRSyik2+DoAJpx7F9rB6DrldVDkars+UAQl3GZptyUDkJjoS
 2hYOcH42dDI6vW1fHQeZEhsdAqHAUwDIcv5iABYPC8WfvGt7fha8xZx6vBvVBcuS11FQ
 toFs2ow1N9GkTUlZSFN4kXT2j+BvFiCJOpLcvw83yU2pML7WSJwa7kIo3rxjbHp1Dxek
 gVUm4mSnwtrgBaRWCjetvOT0LV7VrFOaMKI38NHwI4E9T1KcGqZ6CUiRcY1jjpkJfVQI
 7nHQrdW46D4/Ogs7M0cWlEcNjdHfuw7J+jeqscjh84fwc+3gzacSYcFRxtLyJX/IpDoG
 f+HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYsUaZc8VzHhkO+YFtwncwDLulCnPuvJTdO+l4O2D1d/2dyy0OaBr5OrZE8nCcqZuSyp7OTxOAfStwARsU9eR6r3bEDg==
X-Gm-Message-State: AOJu0Ywsp4UU4u9Bpj4mOaKXl27gRsYCOFZd7zrvXOHVRF8aJofSAcVf
 N46fmnPkMBAbsuBWzl/Zinu6eSRVWNB2cBHnPH/8En2qvRVqYjPpPHzDalDseyBWfc2yCnwizca
 QNXpvxakgP8KyxH60Zx0QD/fZlS9EFa/3px8T
X-Google-Smtp-Source: AGHT+IEP7SCY7e43EPkKDAI8nJw+1a1NTSzkeErXjVkA4b3Cl9lC0Z4C5rYMrvpuPgWGUQX/yNOOOc00/EYvjiXpjeA=
X-Received: by 2002:a05:6214:f6d:b0:6b5:81ac:6b84 with SMTP id
 6a1803df08f44-6b95b4fea50mr39675986d6.14.1721478972636; Sat, 20 Jul 2024
 05:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-6-0c948a25d018@linaro.org>
 <CAFLszTgz-SOFR+aV7f45+pfByLztAYU1kvFPZof665=QwjjoPQ@mail.gmail.com>
 <c1f036a4-a080-428f-84fd-c44f968d44bf@linaro.org>
 <CAFLszTj-1Pok7mJRGfR5fV20JMp5Hoe0r+4=p0S=NwtxQ0Gdgg@mail.gmail.com>
 <893fc8be-e4aa-46a1-9dd7-774a7f8faa69@linaro.org>
 <CAFLszTgYdSdPv5AhCOZBx0fh1292KAtZ9KBxTE3DVW5PnP6+oA@mail.gmail.com>
 <73e4df07-274e-4ceb-9d80-a3b54cc1e960@linaro.org>
In-Reply-To: <73e4df07-274e-4ceb-9d80-a3b54cc1e960@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:01 +0100
Message-ID: <CAFLszTjbRHtWHQgozHwr+Vytce1bLVx0iUuPGdx_EynQwgmi_g@mail.gmail.com>
Subject: Re: [PATCH v6 06/24] soc: qcom: cmd-db: adjust probe for U-Boot
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Fri, 19 Jul 2024 at 20:45, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 19/07/2024 17:04, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Tue, 16 Jul 2024 at 08:16, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 16/07/2024 09:04, Simon Glass wrote:
> >>> Hi Caleb,
> >>>
> >>> On Mon, 15 Jul 2024 at 22:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 15/07/2024 13:39, Simon Glass wrote:
> >>>>> On Mon, 15 Jul 2024 at 11:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>>>>>
> >>>>>> Integrate cmd-db into the U-Boot driver model.
> >>>>>>
> >>>>>> This is just a wrapper around an in-memory database, so we just need to
> >>>>>> get the address and validate that cmd-db is there.
> >>>>>>
> >>>>>> Since cmd_db_header will be stored in the .data section we can skip
> >>>>>> bind if it's already set.
> >>>>>>
> >>>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> >>>>>> ---
> >>>>>> To: Simon Glass <sjg@chromium.org>
> >>>>>> ---
> >>>>>>     drivers/soc/qcom/cmd-db.c | 72 +++++++++++++++--------------------------------
> >>>>>>     include/soc/qcom/cmd-db.h |  3 --
> >>>>>>     2 files changed, 23 insertions(+), 52 deletions(-)
> >>>>>>
> >>>>>
> >>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
> >>>>
> >>>> Thanks
> >>>>>
> >>>>> BTW, this is a MISC driver. Does it implement the read() operation?
> >>>>
> >>>> No, the API (as defined in the header file) takes a string and returns a
> >>>> database entry. cmd-db users don't have an easily available handle to
> >>>> the node / udevice regardless.
> >>>
> >>> OK. The closest thing might be UCLASS_SYSINFO, but it is designed for
> >>> inside U-Boot and uses an int instead of a string for lookup.
> >>
> >> Right, I don't think we'll be able to find a more optimum solution here.
> >
> > OK
> >
> >>>
> >>> Could you use the devicetree for this information? What sort of info is it?
> >>
> >> It maps resource names (e.g. "ldoa1" - the LDO1 regulator on PMIC A) to
> >> the address of the resource on the RPMh co-processor.
> >>
> >> We need to support existing (upstream) devicetree, since this has
> >> already been around for many years.
> >
> > OK., Has this problem been resolved in more recent platforms?
>
> What problem?

Well it sounds like the board is using some sort of firmware service
to obtain configuration when it should be using the devicetree. Is
that right?

Regards,
Simon
