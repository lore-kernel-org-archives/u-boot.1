Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC46DC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18D5980FA7;
	Thu, 17 Sep 2026 12:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3u0wTZvm_wSG; Thu, 17 Sep 2026 12:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4C9E280FA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789648564;
	b=jPGQulonzlQWfS4W2/G/8eQUD6tRAnRZdV5h5+EIf9NTBrezw9VZgdGALhHRWT3roY1v
	 rRclO6Q6GeNNoPxs4gjaCAb5cTk83L7M+5QzidkbspdwrZV+YeVkGhhctKLzA+CLx7lLd
	 VcokSAHgGDMXxtdh27xMd99XFOw7Wk5yhizMznepqWcwSiFvfBw+k/bLkoXzhb2xZ9fGA
	 mb+NXjIPVV8OMRAIARioSrAuuK3iDQm+GLW6N4w48KNGDhKql3IXrtslcT8vIWgEBLGqi
	 D9d4N4W9KuE+bHe2wZc2E90BD39lqcC9LIPywBcanff4mfC2jiI0/twTSXH6AdW77vQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789648564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ob2bDehGGUMnpr8GTAS7pls6AI8KBLGrd8rtJ+U7jIg=;
	b=LVrjsMediOJC68+iDko5f5hTbmzR/+JvE+PS+a9fZmp64AbscpDIOpf08Sw1hGn8Hem9
	 9GnJwHP1Ik5Ek4Y0hZyZSgCYEiYyM86nODobzcofcg0BC8mu2cGyLhrO/PkNikY/6+AMY
	 TELHd91Y/ZohNS4VcK7itm/jCk4QztS4x1I9x1YxKmJt7u/g1xJkQx5l6jfzEazZSZEWX
	 +q4nLbbOHss93Y/DUojdEmDLEuaMxBVEUrHPV9vGjHBuatOvHSxQgVi9eEjSrOCzvIrBT
	 xd4SXPCtKzXzLyUZQhNiImLrusBGsTgpgKDQJmZhbG8N5/iWnj4hUCoqjtYIcRKOmcw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789648564;
	bh=ob2bDehGGUMnpr8GTAS7pls6AI8KBLGrd8rtJ+U7jIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RGHfPY5idEXvPhu9EvdenfoY50DYXyOU8Vgwb+JG6MdeALdyD/1EUisy8HBAvVGMO
	 sFkDrd9XN1ozQlzbLsRchAauYz+Hv59txYFzb3GGSpWHTUnCPCHPWRFNIuSBkQTXac
	 KzpTcgDY8Xhio15b4DBGqKOMvD7hbM/6GE6XQvC5BZi4X46p9wSNem3wn+NVOmeVs9
	 /fGgnucZJgj0K8GcEJ4vyvxFQNgy9s8bJZ4OcLZERcvbDu1sq6Me9kNiBWVpUVXgwy
	 s7/T4NVgFdN9thfb2mxYvVUuaEMMCh3sqao6zCxZh0q5rX3N4Z3c6v20vCCf2MWnJk
	 T7hXo0p75MY5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C9E280FA2;
	Thu, 17 Sep 2026 12:36:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CA7629B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 87DE6407E9
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rsdXVHhlS857 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 803DE407D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789648561;
 b=ft7BvuVSC+AIuEdYE2ifY5OTc2oq6SLYBz8ImKPwLYlqJ0Sf5bUp7jTAiC0NWXwEQwmN
 hTNojz0h8HxULoUJJr5ofXrO7cSHK+He9KRppWWDVTRDEYud2bptXEZr746e8RCSUfVXT
 nC5ikJLDpGeqBue7pwbFhj65iFNqxMVw/9zE9XdOPOW4nufTCt2RE6/Vv2bVdYFTxwXzK
 Cg+gCbZntkj0+k4g53eJvy1KftfHumnvi8tYdL8za9NRC6hpNl2r0BLp1/jQzCB021DEa
 CwgY1nabsyAP6eDwmGdDlXJhss8DbDccrgIwiSU6zY8eQk7VL/19h5LyOwmzjLEqlnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789648561;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=ob2bDehGGUMnpr8GTAS7pls6AI8KBLGrd8rtJ+U7jIg=;
 b=DuTo47g9XVInPD9U0rorQEhXRfwB7aEQ5e/6w53LKmBSSiWjd3gRKIthbD2tBD2xR9ZM
 tAxtFotTxHgEEsAaQ7GQKX0EV4lGGDaFBycrkI+IHdtkGCtuhdOjMWBjsBpBBD/8P0VPr
 0Y5bSpiUlyN2Ia2G6LEenrp5gfEPG+yd3AHGKAXKxIGEfSDdOYg1biSTRENlxeu2TjFPe
 MtNnu9uTSu61/Wzel8Z+4QoRmt1e8dPBn06DuwaQjYT9Lrs449lrL5ooGYglLPrfQvXbs
 pRCxkJ9MNX/fXRp05z8RZcDwi3R7mR465aRVlPv17mse63MImFslh+9yMcZDUAkq6/Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FLSKoNaR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FLSKoNaR
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 803DE407D4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:36:00 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-670f572e814so447552d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789648560; cv=none;
 d=google.com; s=arc-20260327;
 b=P5xn0VfHvgUFLucHY1Ii4osVHPWgS79R6B2lUmA0jZgXWSJfusJyY/8jT1/U+2HFGZ
 vgAjxDM1baINQHOFeL9v3VbNpn4XDuBMAG2FeOtqZqozrHJjK3nFYcvrJ+MlL/6ln+50
 +zhlCuLjKOtUwNpgCsWS08rDhLIcgXd5StsuYPZKi2ggjZh5C4gYPA8z+g/Kt5ABuhZ7
 kZnklzUqt7eaYfDFUw8YrY0QvwSy2tpbXZ8TjHcsLhNzRzpjvFyifQ4uziGvBQgVntZC
 cuRc2Z025SnEvny37T/JKI83jQojH/kHzkmE+Ywv2V/Sphb2lwyvLe0HmFe6MmdxmD3p
 VNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ob2bDehGGUMnpr8GTAS7pls6AI8KBLGrd8rtJ+U7jIg=;
 fh=SgX3lzKXsL5uOHPUteg8m8HKJkb5mKF9KCqOub2vpgM=;
 b=PY7Wxp0L6ipiwmBUbfUe4FmDknNHzkfa8vK+u0nIJ1xszr9nJxzZCQhz2vSiNUbCmH
 s2vvChCMkwG0Q8UrXE9tdX9DE5td2bWckxkBWgLBCAqTGhdiqmtj3S1t/BB6+hPsPj6S
 uAlezg/4Q6RjV3TmS89vuzeWpc0QJfTQfh5XzRvnahA9qSjIZV+PPNWQQO3CNQ/luQ28
 x3ul7mwOikwQhUsnX72Jqdx7CN97kCcRisKhT/mfm6Yo1XhX8x4UHfs+5hAdQlxPrSwJ
 RTI9SylheBI2AwwZQbV2J0pKH9/LXrQppz16ACylroc+wJCqckb53wthhFrPblS8kB+P
 +4Gg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789648560; x=1790253360;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ob2bDehGGUMnpr8GTAS7pls6AI8KBLGrd8rtJ+U7jIg=;
 b=FLSKoNaRUoom2Nihyy0uog6iuIzt+vo7/NuoytRLsBsQjr2Fc9VX2wjHt/rQxnKooH
 WEtofan8hHFZQzuE4RArVJC8WVbm+mn/4hcSVBjR/PMUtnRIFYLd1XMP2zqIH85gA3W+
 ExTfKHDNYkssshbNMeJiTU+IkCJubeZYhaMPH2toQiPzEtiDHOwtV75yY5MQ6PYEJVUm
 GyIyVmnhRyU7t09LIh+BLDS55T4fG6HTTDx1kJb/cxx2kY94GuUG0FeM1/2jQp8B4kXY
 IOKo8+g5eSkgnNoqCRBX7rUVZlSRgAN4SBaiwoFvO008Ngeb35gtPrx7LdQAZexCVlpB
 bpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648560; x=1790253360;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ob2bDehGGUMnpr8GTAS7pls6AI8KBLGrd8rtJ+U7jIg=;
 b=M69eH+8UkvPcOdZxAUpIrvAwB6lrGYZ2QtKLRJxyNBbH6OXbQ6Rk1vbgak3v1DxwLP
 i4dCuB/rteBi3UJBJg8CfBGxLTuUtBlzBC9OeTXzTpA0CtZW6PG6GgLsKHfLGJr6J8z5
 R4eMYmP5TFknOYFhpjrbSHTYsDT/Gf9tTo35UpPpzqAy/uJPvzENli931b9vs3ZecuDh
 ybxbCYNLas3VpSN0JHpQ910cHqUyGHStwxCOF0VXO/NHP72Bx00xcWK05qxnruApe2e5
 IY/NcJB7vpJ2Due+fhMYSCxocV+rY5RRsmvEM2r3WrVxf56sKiklAPfv30eV10YR07u1
 HJVA==
X-Gm-Message-State: AFuF++m+F4m6JSNhXNNOK/bg1t8RRBtktY5ikpjlHaKjWDyg571HvAcG
 YQKEX6EaZwIK0R/w6L2lZRgj5n2nErXukz1d4Y0umUle9Ux+xYQ+sQFEutuy/FHIBzna0PHoLJ4
 hcpmVYxvKbq8gJNwrmikyyMqLHGLMEg4UyYQSll2cig==
X-Gm-Gg: AYBFou1gSXlex24gOBUBvM/dfF8ZJfPyEF/GKdLxszISclofHpdnqOI0qbMkOiuT88i
 fLJ00ALT2ttUWIXDfTh8tYhNugVOT7OLy1SKFO5YHgDLb83xUzvzaCMNcP6IEJpgDHhWLxyhLYo
 teGLzHS660CQOoJqrDgbi42hTtuLQMafM4vxQi+km1bSm5XqfCpyYb8vDHQiS7uBebYlChasaJU
 Ij4l/avu3Z98X+POGRZaT/R6OrPDXl/fvTE8DjZuBNf3HGMcUQ+1k3CP19Vn+fl30LYpo7nCF16
 6N8nldNKb7nE5LDZdxQROh+Eetbr/cGPaxe5mPMM5LaaI5M6tKo6mrim3fUzws2CHGsG3VTmNPg
 rc1kAxJR8UN7dbKauq444o0zLsOGanLFOmI2FENZOhWPExWTEJ97iZwijP9ntsVMQYfGSeGKg/n
 Di9MRJFiRcsnfQRv5SQD8OKkjlzUrW6mTyjtGdoCeELJRMIDj26byMW3s0yoeekcSqz6o3l57XC
 SAn/MmXKo9qo+TWCpajD3R7FtzALQXoZ+cdAm6J+88medtndRFgjQNkB93bACUxrtEiGuplUYAL
 fFOJf5DIXoTzca9GrfD1qW0VpXVcuPHJj5nNb16dEccRkzEJvuvFuqcJ8/naiPOrgnxZucoE/uK
 gR6YB6BOdfTErf6GJ0GDS1jbhw3r/HARA/6x1CfZDY+ecGGSMKTFW
X-Received: by 2002:a05:690e:134a:b0:671:58f2:738 with SMTP id
 956f58d0204a3-671702fd08cmr801233d50.5.1789648559623; Thu, 17 Sep 2026
 05:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <05f13f7b9b886c7ea0b826fae352a59cf07b63eb.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJEy9mp5OutQdN=A+_ewnLXWzPAYwxN+ipoHPAK_eG8gw@mail.gmail.com>
 <597738c7-4912-4fdf-a86e-956b392059ca@siemens.com>
In-Reply-To: <597738c7-4912-4fdf-a86e-956b392059ca@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 14:35:23 +0200
X-Gm-Features: AcwNN1UWP2SKX3w6fFbT5vzOalnVunmCDKLUUon8-jpjMEnHnh7zQmt7whEdrd0
Message-ID: <CAC_iWjLJB6U+=VXs=cYG0z9YutGbscoB9xhcTfts3MvxV9NEsQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mmc: Call back to optee after a successful mmc_init
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hey Jan

On Thu, 17 Sept 2026 at 13:32, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 17.09.26 12:24, Ilias Apalodimas wrote:
> > On Thu, 10 Sept 2026 at 08:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> This is needed to that OP-TEE can re-enumerate services which need RPMB
> >> access that may have become available now.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> >> ---
> >> CC: Peng Fan <peng.fan@nxp.com>
> >> CC: Jaehoon Chung <jh80.chung@samsung.com>
> >> ---
> >>  drivers/mmc/mmc.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> >> index 670e92ee12b..2463e50cd3c 100644
> >> --- a/drivers/mmc/mmc.c
> >> +++ b/drivers/mmc/mmc.c
> >> @@ -27,6 +27,7 @@
> >>  #include <linux/list.h>
> >>  #include <linux/printk.h>
> >>  #include <div64.h>
> >> +#include <tee/optee.h>
> >>  #include "mmc_private.h"
> >>
> >>  #define DEFAULT_CMD6_TIMEOUT_MS  500
> >> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
> >>                                 mmc->cfg->name);
> >>         }
> >>
> >> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
> >
> > This is only used in used in U-Boot proper right? We don't have
> > SPL/TPL symbols for RPMB support, so IS_ENABLED() is better
> >
>
> Can change that. Can send a v5, unless this is something that could be
> fixed up on merge.

I am goign through patch #3. If that's ok I can fix this up during the merge.

>
> For my understanding: Would that be for clarity purposes, or is there a
> practical advantage of limiting the check?

Clarity, CONFIG_IS_ENABLED() checks for both TPL/SPL symbols as well,
but we dont have any of these in SPL.

Cheers
/Ilias
>
> Thanks,
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
