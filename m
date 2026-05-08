Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A08CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9BC884DBB;
	Fri,  8 May 2026 19:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ITbaBGdd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A909A84DBF; Fri,  8 May 2026 19:50:05 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B316784CE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bc47a96d3bbso306667066b.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778262602; cv=none;
 d=google.com; s=arc-20240605;
 b=DNna8Dg7v2PfK78wRO46PxHg2yj4PQ5efRhip7J8PCGXK5p8WdHCijx+QAdh2Tgedz
 uvPm6VX54ptve/cPkRmHoekBmWwQD4AvuHrSbhJSCqUL+euxBxVf36KqfRj1AKN6qnx6
 3Y/AML8EfofWJO2MDQWdzTW/QuqXz/IrPOpcgUZ+CR0i8g29R4ohT/9UmdWyf1zirH+o
 p0lv25pi/AI3zhHfTMTDO/L9TiozGpvD34P3v9bin/ChvAzifRFqvSdxggCfyo4IwpRT
 MS4mtPUjZBEoqshEG3TCaH/s8KGBrj4cfUUxTmUleHmDg6+zC6cQ5fQf9Tpuaa2M9X65
 DeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/bu5OyaFP3jdvMwDWFktPLAcMVsC4cR6fjVq3U1r7PY=;
 fh=i9TuoQdvRbVIn2UPEHNNC4PoYN0x8wYN83oS/pJLOns=;
 b=NlzGvDx0UQBG2bcw0EXs0OLR5or2FOlsdyuz02k2GH67+PlV1+TctfSAAlZSOF6AOt
 8LaRqdhYQ9FzAeTMHIMFhp9arbhMszGKak8fHXiXna0TgRKYa1Df/71ur6nVS1lSMNmN
 ijxBwMDnHGXpmyPSetWBZkWx0E+PFbn2/7EK1NMNaKnk98B27KR7PFiWyM4WhcYSTKV0
 ZV5vZMZC5VWwurTQE9M2J3UNOCulB9ow5Ea54XNUjCi1T2e834+FpaRehtj9maFdKU31
 ZXE3FVuhRlRUXjzGp1z2lw6lqNNhOEya5DvFqm+UrfhPSv9ZvswDsD/TNn2RGpfb6z9i
 gd3Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778262602; x=1778867402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/bu5OyaFP3jdvMwDWFktPLAcMVsC4cR6fjVq3U1r7PY=;
 b=ITbaBGddJuDmMbmc9TRoms+yIKxOMCN8Fu6O71kCtqcncjM8U0fxIzjXwpsphI9f9u
 6g7JVDhLrRvTGsceeec8alA0AAjLQoyjebNGYRAHkblfOuKZFgYnbvXEpywkZgVmWfsn
 pyRixicEU+C0ipRgD40ljjUzqN7AzYt2khFpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778262602; x=1778867402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bu5OyaFP3jdvMwDWFktPLAcMVsC4cR6fjVq3U1r7PY=;
 b=ZLBvcGgCSRhOC3W0ODRpBModa9kmLeqsnnbNQuYzenKbvT2DOq1Qggj99kUpKiA6tI
 +UKIEFbpIwZnXhOKlouvqMeCfUe3OCXXR+COJbx57aHPvWUHR9HqWHF7uKOY3LTJfnSb
 NhY8Mh4X0lgmv052sWp6NBDoxVSZPKz31aH31d8+iqytkGB6RmgguA9erMcXT/b4e6+P
 o/GSrtPmTZv7LBikBio1HaxtLAv8N31D0llYZ66lHEQT2xG06dnKdu4x6/aTYxgcRBuv
 zGJrtHu92fHWn/n5hojLWezjB+lI3JRFTvu12iLZyG/VtNWUXZTFCiK8vv+fiNAeufQo
 /TnQ==
X-Gm-Message-State: AOJu0Yzhv2c0CDJ/thqGnDuRdVyKuGNIuoLiaafamasnOz29p/7YSwlj
 IXS0SHLhr8oPVYOt6PrYnAUm8MLCo490A7rUyjEsaUrRKwOFc9KhPG+U7VdahlRzJIXtx1AEr2P
 Cy971CTLGfgKATfzZCOE0x+LpFE+rncSJ/4xv1jyl
X-Gm-Gg: AeBDiet2i/yr0usA+luObXDGXV9zlAL2LUWkD0HAJoskoyzrlDHiB3ujGsi7IWusEF0
 Ia+8pc+R2VEnGrGppSNQFm+swKC3CPj/5rfGxOyIaBWSVQZrzu+xoxQLyQ6wOdLaaC7/18iQbMH
 8APPS+TPNF0kBbEiS6Lo09dax/LVJlLLZwcY3AfDaHcR7/L129vpp5hw3Cp67UUlECuupXSA2+Y
 TQyuvnIBRvAWxH8ZSrhugu9wIjYa92XRLZzrDnXEGVIFXQWYh4p+sj6tEEW8jMWVZlAQTkBb0m1
 V2uUag==
X-Received: by 2002:a17:907:1c01:b0:bc4:f44f:e145 with SMTP id
 a640c23a62f3a-bc56b82fa60mr762178966b.16.1778262601604; Fri, 08 May 2026
 10:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508122247.512862-11-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 11:49:46 -0600
X-Gm-Features: AVHnY4IADt-PeI-9Nw5xkw5KF1-gXqcdGHA4bff38NU0NmSVMl5SA375Uc6jv1o
Message-ID: <CAFLszTgNJe27rZiu+vh7ywMtbwFnqZfeCKm_a2FExWHx+3efZg@mail.gmail.com>
Subject: Re: [PATCH 11/14] power: domain: sandbox: Staticize and constify
 driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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

On 2026-05-08T12:22:01, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> power: domain: sandbox: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/power/domain/sandbox-power-domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
