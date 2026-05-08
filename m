Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA2CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E0984DD6;
	Fri,  8 May 2026 20:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LZiwYoYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6C884DD7; Fri,  8 May 2026 20:01:05 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290A284DC4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c7980c060cfso1054926a12.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263261; cv=none;
 d=google.com; s=arc-20240605;
 b=HpuYslbCRI6x5U8dcU2PMVO11T/NuVIBd0Fo6fRAneMROp0pivnuy4cyscapS10TWE
 t8qZobl1OH4ReJz64BcrcVLA/vNsmM3uc7/vXHZ9PBdbrVaT5KHGdVGew80cxEl2xRh/
 whsV9K8aKBoB63RATRzYeSm2bH43yy2eAf3Bbo+6SflBLMeCArrKPOZyPApRmDI0c/y2
 4kP+zY9hmgzlxIl5TigLsC9U/m73TX6+ymNaVworkt5iG6a+8bTz6r8rrgvJ6vWtRUhT
 h4lrVQ3LoNBOE4O11W8rzsD6r1ppUexfjcdS7np7DzXoRA03EZ7/7dsfqm0T6WP4AP1m
 2nQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y9pNsLyJPFURZjKRCJqD65pqH9X6WRptxhD192JdvU0=;
 fh=rBwdhT2aLjL/xgYh1d55/iIlAaYJDptg/zakKmkj50U=;
 b=SXaLkttZ3YumBjgO/tM1XxNEUyssF2rWPJb6gO/cIBLcZqvFmXJDprO53734OqcrPe
 kf760+RLekMJNTdA97+1+fDPFOjX+mVRvggY1IcHQ9PY/vo51KWh2+akGz1SFvB8FyV3
 rZHhQo1QeyxSlfJ1us2TUx7vGadQMtMB0OUmtklNv9jqC4rp9G0AfMxdq4WA8IWydrNn
 D64m3oGq9qi4W9COfy8XL0RO0NONwIN5UfAiSXHBInRIMsMEl9OPLMdSp1hgL2O1lcIz
 q6pvELalSueuYsD6pkaKcEe28pvfdsvUIwQBQu/8QeFH2ByU26Yt0Dg2BnmIr0hvU4VG
 0pqA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778263261; x=1778868061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y9pNsLyJPFURZjKRCJqD65pqH9X6WRptxhD192JdvU0=;
 b=LZiwYoYrDYaiIDUn4NtcbFsCHUvNcBlbi+NMbXlYTSjYG2meStep4nNl4TvIqsPmAz
 0j6Wb3/xE3NxsHB4obpmNNrsHgX6GQWH+R6sM0TBi9X1pUhxFdZlELbjXG7bIhrx8cHv
 T65NhmZBfYkbhy7og5X1Hs1gIeIHxcS7JG/54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263261; x=1778868061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9pNsLyJPFURZjKRCJqD65pqH9X6WRptxhD192JdvU0=;
 b=YbrHXt3cNTO/6SLJSmmIIaMe2lR2bcdo0/WIG4akQDNGwVDX6Q/X7XScHHP5MMZi3D
 fzFFCCsehkFO6ya9twMikt2BYIAJRQf6R58lpwESwTbpulIX4Y9YXOyYNA5PBioWRYBW
 WJzC3BXNNNr0P2uknOO/UdFrBITS1XInN2ISmXKlDUpqOdgWL7H77O+27UOO8ws8Ojmi
 zQb4InkqvGYGLquF3LXKmzp4ePDG71gW1rO29N0OQuo8rpqqKqmTTfLu965vwTDeOSzn
 zRsXX+HKnEkEEk9EnAVwsFo58/p2vOrj9QaUYywuIhhm8BRTfPakjAqQJ+FPI6eG3bl3
 B+8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GDIcIpmx/p1mBhhbQ5QtcmDR2qKqfOBes+BRtefpZB1JQLUpWwGedXH3L1779qtun2P1+ei8=@lists.denx.de
X-Gm-Message-State: AOJu0YzEQkl15w9Il7aeMZu4/E24vZ30UhtOpbme+nLryJ3CscfJBx9y
 wEKGb/T5/x1fU1HgCRD1SI47Hf6HI+GHE+K0mtVffFE3x93344G9s+k2m8iG+jkX7P7ZmgOAuBe
 sisNwTQWykd3SIQiSoruaYXhZqQ2B0nPP/hY71k8i
X-Gm-Gg: AeBDievpfsTp/V0hN8Cc61DsmNn1x/bU2gN+fHWMBahvTRes2FWhjwhaMl5Mw0c2JUt
 oIQwKvkRVZetVfKApwT+mPR+PV9CwOIcWDa91jV1qeCr+tjSoskGh/S/SrvXAfkmWHKe+ovZ893
 441rxWWb9Tlfjh5qmqh2b8k9OS9sNMnV6n+vEqrP/f0sY1Pm6t1P8zp+Qp+urw/lsTTi3fEFnt2
 INhn+DVT7qFi7N9R2dkxOI+0zNxWr0rONvSqMAyGWU7vVGfYSmbvBGcHG+IRsy45WvZ2rTygk8q
 X38RVQ==
X-Received: by 2002:a05:6a21:328b:b0:39b:f026:6f8e with SMTP id
 adf61e73a8af0-3aab16eb247mr4700786637.34.1778263261586; Fri, 08 May 2026
 11:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-5-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260508084834.45637-5-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:00:45 -0600
X-Gm-Features: AVHnY4JeqARHceuYcEBPNxHQt9So35J0E9YKbDY57_0lj05QszD8k4QYObsShUo
Message-ID: <CAFLszThq-VrJ5H6GmkgGiNN79wCc09gZ3bgcjxKcUWy+vEEiKA@mail.gmail.com>
Subject: Re: [PATCH 4/6] sysinfo: add IDs for RAM size and variant
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Nora,

On 2026-05-08T08:48:28, Feilke, Alexander
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: add IDs for RAM size and variant
>
> The interpretation of the RAM variant is board-specific. Still
> add it as a generic ID, so it can be exposed to RAM drivers.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> include/sysinfo.h | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/include/sysinfo.h b/include/sysinfo.h
> @@ -161,6 +161,9 @@ enum sysinfo_id {
>       SYSID_PRIOR_STAGE_VERSION,
>       SYSID_PRIOR_STAGE_DATE,
>
> +     SYSID_RAM_SIZE,
> +     SYSID_RAM_VARIANT,
> +

Please document the units, e.g. SYSID_BOARD_RAM_SIZE_MB encodes the
unit in the name.

Regards,
Simon
