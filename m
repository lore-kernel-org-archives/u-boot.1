Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D02F8E499
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 00:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3BF83FC0;
	Fri, 17 Apr 2026 02:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aRB65Hpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB80A8407E; Fri, 17 Apr 2026 02:00:09 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C45C83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 02:00:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9c755b2cdeso19934266b.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776384001; cv=none;
 d=google.com; s=arc-20240605;
 b=YiH6BcbFVpyy3AuWxdlgYMj0l31oUs22uupJ4WzBdnvH949Y79CRjmIwyTY7MJovgQ
 WzAEHb/9D6f4LTAsSGnGIdQm6NA0Jnj5litO/arNW4kkXXx+HIvJj+6BZmCk/kj2VGa/
 Fg92jPvu0YMv45FlgKh/QR3hs7hmp8UbcMCrR3TorjqIJUIARyfMcxdXDsiDshAGXGHI
 484DlXUVJasaKjSppKq06oS3F6C654NYZYLthhTkQFY2JHB/+73cu2BdguzezUykHyNi
 TnugaUlV+k7225xB6zMt7+kjOM3qrC0nXJxZNGFk+CI1CN2qIc/UWUQs86+UEDpLZEOw
 fpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TT5yf1nbaOpW+KnNXd5fLiEBCUUKgHBYh1jMeLbvfCc=;
 fh=yjaNGXPU9vnhuaIfRNRT42k/Y9Z8QC/U5cdfj7g1S8M=;
 b=Ut+iJlJHUGhoC9IfsZ8uC34ZhJWowAhvg93u7GF7R2trHr7FtfswzPLTYbuthODwa8
 ownZHwYzp+ryBIwK1XaxrCb1TOhCZOeZzqg9ay8BgYNixe3X23qhzS72ZayVWGAF/jx5
 HgtX+DWAc4JtPrc92sbCXnx7qSDZappXMuY6l8ehZIbjM+7Za++IpsP6JllOo47xsNnq
 kg/UeuRWGDAt95qBg8XTvAHxgd4LgF9Fgtm1/h6SlaV1PpHA6VANCRjI+GAEMKRnH3Lr
 I6CG0XuewFF0lgPtSEdYBgdzGOJauAhJyufXB92KW/Rbhbe7l2QaJM5trsu6CSPG0Ghx
 xi4g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776384001; x=1776988801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TT5yf1nbaOpW+KnNXd5fLiEBCUUKgHBYh1jMeLbvfCc=;
 b=aRB65HpgnSVn2VXe96gFxnVg8MQm7t4MKGLPwoLOBRLPXNIv6W1Wd4NXm4EQz1l+Bq
 AQRWVNrrU/GUGIWE8keRs3R9JfzlPNe5Wco/bam2lt64E8lcdc5rjRf69X9AWA6oBDgk
 6KtGcx2OJYw09egCEGA7/lqHSz/TejNjvUA3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776384001; x=1776988801;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TT5yf1nbaOpW+KnNXd5fLiEBCUUKgHBYh1jMeLbvfCc=;
 b=sFVuXEPZNqFdMOCDu53sD6Y9R24gpHljTDOY+atB0WE7lDEPVPqXRam5AZ7Pt8sNjB
 GnwBiM16d5vIqi9Tv1D8NeJgFylX4dWb/Ei8/036If5oejp1q0h52yO4M4PWMi5jU/N/
 dI0hrQ1OArnYn+tN3W61vluva5ETb+y4+w1Zaagh376YubpcSHBuu9Fw9MK6Qr+Srv8r
 73UgznsCC2XFF4AM3APMMoC6ktuZdQmkdgDYvysALEfuuUQHUCU32YsbCJGiofYmoM8B
 nExBwt+2NZXKprGVxqah/BBK35g48QmJ89sEMFfHavwOkyMaq6x1WTZFaKWHVPS0C+ay
 RtOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b8O/cSukkBtKo4BtfjnjzEiZqjUChEzRXAvpYiLritFo2QAc3YM1ZKlaDpt0ICxekRU+WFW0=@lists.denx.de
X-Gm-Message-State: AOJu0YwEFTp/6qWHjWi5DRJDImfGbYnq0EOEa+bcmySX++9q/AZYNrbA
 vXjQWkHzoxlJHGuWo3SnUTahinHgEaEEBBnTJ97Mjr2gCyq33GUngfyXz6CLxCICx+Laiuo0DAQ
 IGPmKX+kvzp/WkMr2TusP9tj8LiOMTfv6Ocsdge7r
X-Gm-Gg: AeBDietP1SwvEnsV34ej79c0/bb/7WEyJOdgvfRCsG6Fd2qhU9Jpx3nSqBRZA1ICGEr
 eVjCSIM/7kPHSlr+L3DmDn1kfF0G1suUQ4db+nOzM+B+x14WblKEDDixVQKQrYdIPvvOMo0pPQB
 sg/xYzOj0Y/xBIZ/JGbSjM2luIoGGvuQ/XlXEpTibqYe2+yUHJ5uAjdrLTgZte+EUa/PYnMPJo6
 dr08TIM4RqQES+U3H524SDHAN41C+lmrmDwW1gMqx6pxZmy8EDLdRU5kPcCpvrnI6HaEUdt5vD8
 aQTTZ6j2cx5NNPaKa70O
X-Received: by 2002:a17:906:dc89:b0:b98:6926:13cb with SMTP id
 a640c23a62f3a-ba418b7e13cmr29906366b.9.1776384000645; Thu, 16 Apr 2026
 17:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <97e38b81f2e8f54ec819940d360849e4cf61b875.1776302806.git.daniel@makrotopia.org>
 <CAFLszTgazuTSYbidfn7Q1gEiE1RG2YVkj2Vz9L6fN49QE0bdUA@mail.gmail.com>
 <aeFv-xm5MZ44W3Yn@makrotopia.org>
In-Reply-To: <aeFv-xm5MZ44W3Yn@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 11:59:48 +1200
X-Gm-Features: AQROBzD-mT_vwW25qddApvNGxIZJ4io5jI96sHGc4G5BszXnTly4Nc9ShbglbnM
Message-ID: <CAFLszTh3RD86+wkBv=wOm_-ghQssQuymhrnhPMpXsfY8=dnMeg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] test: boot: add runtime unit test for
 fit_verity_build_cmdline()
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
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

Hi Daniel,

On Fri, 17 Apr 2026 at 11:25, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Fri, Apr 17, 2026 at 07:36:37AM +1200, Simon Glass wrote:
> > Hi Daniel,
> >
> > On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> > > test: boot: add runtime unit test for fit_verity_build_cmdline()
> > >
> > > Add test/boot/fit_verity.c with four tests that construct FIT blobs
> > > in memory and exercise fit_verity_build_cmdline().
> > >
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > >
> > > test/boot/Makefile     |   1 +
> > >  test/boot/fit_verity.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  test/cmd_ut.c          |   2 +
> > >  3 files changed, 305 insertions(+)
> >
> > > diff --git a/test/boot/fit_verity.c b/test/boot/fit_verity.c
> > > @@ -0,0 +1,302 @@
> > > +             ret = fdt_setprop_string(buf, verity_node, "algo", "sha256");
> > > +             val = cpu_to_fdt32(4096);
> > > +             ret = fdt_setprop(buf, verity_node, "data-block-size",
> >
> > Please can you use the FIT_VERITY_*_PROP constants from
> > include/image.h instead of literal strings? See test/image/spl_load.c
> > for an example.
>
> Sure, I'll change that.
>
> I was deliberately not doing it so the test code is as self-contained
> as possible.

That is a good goal in general, yes, but I would hope that no one
would be silly enough to change the constant :-)

Regards,
Simon
