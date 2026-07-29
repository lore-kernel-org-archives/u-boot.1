Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D36FC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 11:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD0CE608F0;
	Wed, 29 Jul 2026 11:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fiBvtC1k2kUZ; Wed, 29 Jul 2026 11:53:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 552E3606C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785326027;
	bh=eUrmxZQM2SMzZ4lRLdHqb+Hl8x+rwfcONk28Bvo6Oe0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kiVHaFsKR33uywqoAdN35mjDRrJP0Y4PKZvPosbQJSeefyl1WmyYcVID6b4wGg8ZR
	 wAraHfjBSlPrOe3QXUvREn4d91vPj0kU0EJYLwGbDZVpe9ORrA0Mr1vhZT2drhiNnd
	 smc7INXZa0Khx0enYF7a2DUN5w+nC1nVt6yrz8sXAxLx839uVG0LqwXNMCj9kO2Cc8
	 jJXVotmsBPUpF7LjQNkXb5l0ZK9aGbnS/0oeRPFKM8FByFmx4YJ8k+5BfqghIldgsc
	 cY3Tm0xebfjZwUs7525d/7ZuOyMIf89KwuJLnn28E/IwP7SyT34Lx2XPulJSXP+zGf
	 raYqhm19fe+Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 552E3606C6;
	Wed, 29 Jul 2026 11:53:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AED39490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94F2B8116C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vc_OyhCcKqBf for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 11:53:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C923381122
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C923381122
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C923381122
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:53:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9999B8493F; Wed, 29 Jul 2026 13:53:41 +0200 (CEST)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DC982991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 13:53:38 +0200 (CEST)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-668432fe416so1084913d50.0
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 04:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785326017; cv=none;
 d=google.com; s=arc-20260327;
 b=OaI/yP52oI7aPiUPtkkJghhAxOa4rfDV+e+eQggYzrt/rjHabtpOqmAxpuJlTfXeuS
 CzbWbzk29l1ybFM8VAryujjsJDVSGHa00r7eO2n8PjyxEpiBuyzU88OV9zBtw09tmK9S
 P5f+D40GHdY/Acb/SvOHNZ767BWW8lVMgo75G/UVWT4b+Y0WSoCR9uWh1a7SpV2y63/E
 PnRnaILhLOlYoFT+aQIlQJj1M3OjrSkG2qIdME77gmjzBH5Ox9EcOEFetXDt2+ONqX45
 EwCcMzcvGiJofSaZLKFR4oRJ0flIhZh84v1TkMSAdNntjxZuEuDv89+FlCY3GW9sj5zQ
 szOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eUrmxZQM2SMzZ4lRLdHqb+Hl8x+rwfcONk28Bvo6Oe0=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=b7Uwhe8+2cKEDohY0Fp/SCr2/qzyDM22Vbm4BZB0eXDby0xnHoNu5Z8VgDz/LE82s9
 iSGqfF3kiM2SGuRBwnW722BzWYBATqgO3HipNLv4N5j9dA+gq5/o5UtdrdVhAtFiaV5V
 kWmshAdGPIZxSaXj4FNEh5AFg3LgduVAZdNgpU5xeNZKEpqLKmY8S+HgjDriWWzxiZLj
 4RV/3sgxuZbRSPNr00MA7j0DycZpj500GGzCQwA8kuvuZSmqnW7RiExX0ZW4mN1GHt4x
 K8uV6l4fRgBF4w7N/Pz8CoWZ4oR088XbVdT1P4BNHd+EWhEXLEj/Gp7bmsXu+/zm6hR0
 C+cg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785326017; x=1785930817;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eUrmxZQM2SMzZ4lRLdHqb+Hl8x+rwfcONk28Bvo6Oe0=;
 b=iHGj2YiuM6kkWc0BbWqEuubnAKCfvKTH/e3IrPbyb+39gNWYw84XCkv2PQfE3pDSoY
 zIm209eN9IQQLJB9FKrQ0swuqDYTHicaMCSufVKrVqrVdyxTI6JRfeUvC7RawvIjbkzT
 PXMgJOK/QWa1//aFvwychycoAbJsJS3HRrMbAvf6OyWpMfnZRqDPEFkjwwTaFH8o0ciq
 7OaMQowS+Gt1/8JeF2Gurvb9zv4I84eeANrD0eiCNnv3CPQTxst3KHlqAZl07xg4KGqi
 Rrst8vkRa2rtrYbtOXI7QY2IgsZaujWVB420nm1uNBZ6ni6KTMId21P5nExnAX/TWeRz
 JTbQ==
X-Gm-Message-State: AOJu0Yx9TsIG+UnofQHvGCGTXTgTVvsOjDhqtRM4C/5HSiBcnsTsxdKb
 gfJNF3ajX8caNrbZz6pKN7NjjLasQikM10Rr+HLuHWRwwe7+dBa6NVWfKpsygN4SnExO5+ePJyt
 TPSvUI8J6ybcGzTrooU1KQOiv2qGC8QRfMT3pD4PqDw==
X-Gm-Gg: AR+sD13/XeZGdxJ3/ZDa7ljynDchJwQ2Zck6Gh57EaKNeYEJ07oBGxP1ToqW1kFc9tJ
 XwZRLptOoJtavnBSHsiZ4GtRLGb4z7YcyC/pvWe7Tqy/75oJ3bB+3r9tVqZtOurcsv7odn5/jIp
 RZb8xdxPTQ1qdHacgd7T13UPh1VUgO/VZ64pOeh7U7Kb2LaTskNX3tT2mrStqQbQIcp5TNF67kb
 A4gPTXP0fxEHKJjAtCgqOs0TGJhUjFtkl6LT6mnUWipCETcQftJEiQW4pQtUF0rjYTxERzO4E8f
 CqvMciU59L/4yzXzQuDd31GuidZmWiFU1rgXNoyVf75MLor/6tHWlSDnMc5q4oGBLZCddWa2Fy5
 lTltpVAVouu7ZzIxK6vVLv0CYvflpeqK6BkDOJ3g3W4g3tsT26MlRt11dbAPO8eDhSKhOyl2J8l
 HS6TiKL2akMMakAbREKyzvHOBmpqUi4krbaY/vlFCAgt+xbJ3njTbJ1czKgCIlg9qnvcuMJ5zkv
 nDBN0HutYQYqCxe3dyZxltjFUEa7zWmENPfukxyJkMsJE/12pRbbaKKFtzE08QfJ1b5L6V+Xu3a
 F4XbwPBuHjwduBKDyEtrIUD4W7KgPeks64Ui2+jghdqSxDMS2zrm0MkyoQmTgjzc5DcmHBFOtlm
 uPz/6jDsPQT5yH7XaIMoamXuBZBIudgtTjTupWnMmHPqB1wSkXTHeRNhYh0/eRNL9ZIIunQU+kf
 OtEg==
X-Received: by 2002:a05:690e:b44:b0:668:db:8c35 with SMTP id
 956f58d0204a3-669054a4093mr2733772d50.20.1785326017046; Wed, 29 Jul 2026
 04:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <fb1ccca20dc7ad495fcfad16c7e146500b120981.1783426581.git.michal.simek@amd.com>
 <e00432e5-a700-41be-9aa3-6e544236b8e6@amd.com>
 <CAC_iWjKtQoMDcyBxPgtYiesheXTJ-rngeqWZMyA2RacOc2mwDQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKtQoMDcyBxPgtYiesheXTJ-rngeqWZMyA2RacOc2mwDQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 29 Jul 2026 14:53:01 +0300
X-Gm-Features: AUfX_mzi1UdEoLiljc_e-GFsVAn-zKRtsRegMXafec1Gg4vze8PBeFIQ37lsz20
Message-ID: <CAC_iWjK_1_k_MWvYOAWAS6pe=-waZs0Ht=71Zigt1vEbsE6rJg@mail.gmail.com>
Subject: Re: [PATCH v2] fwu: Make boottime check failures visible
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785326017; x=1785930817; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eUrmxZQM2SMzZ4lRLdHqb+Hl8x+rwfcONk28Bvo6Oe0=;
 b=EWyZouuseF/GqIUoxOLl/HfxhIKqaYJguB73IXcNKkyp9UmqGf7GghHm9bC33aLf92
 oc+mANkBLNMdkXi2FzurNiBt4fSqO25/UE5hl9vl+fMytmR91Cwgn1fGTCV8BPBcBwVs
 f2zkbz8bxd4P/7AE77r6KD4RFRGDcBN8qLvRP7JQ3Qnl0zpdh7VbjBRbadi+Wlp+oqwf
 xDKZ9j6pNxE9rQGQmND9o0mG8tFuKHxhcjy8W0u3XsRmfIUIvBNf2O9dZSzO5I1RnEsV
 koP+qsJJanghz5CEPxhIVLNPbu2SWQC9AAQqlNVG2Ya35zfFAbCiIP8UD7q2MMfNrBeX
 A6Dg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EWyZouus
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ilias.apalodimas@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="EWyZouus"; 
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Does this apply for you on -main?

Cheers
/Ilias

On Tue, 28 Jul 2026 at 15:48, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Michal,
>
> Yea, I'll send a PR tomorrow
>
> Cheers
> /Ilias
>
> On Tue, 28 Jul 2026 at 08:19, Michal Simek <michal.simek@amd.com> wrote:
> >
> > Hi Ilias,
> >
> > On 7/7/26 14:16, Michal Simek wrote:
> > > On systems with FWU enabled but without the required DT changes the
> > > boottime checks fail. The failures are only reported via log_debug()
> > > which is compiled out by default, so the user has no idea what is going
> > > on.
> > >
> > > Use log_err() to make these failures visible.
> > >
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > > - drop fwu: Gracefully handle missing FWU metadata device
> > >
> > >   lib/fwu_updates/fwu.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> > > index 2b11e5da061d..e9bb1b4fc656 100644
> > > --- a/lib/fwu_updates/fwu.c
> > > +++ b/lib/fwu_updates/fwu.c
> > > @@ -759,7 +759,7 @@ static int fwu_boottime_checks(void)
> > >
> > >       ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
> > >       if (ret) {
> > > -             log_debug("Cannot find fwu device\n");
> > > +             log_err("Cannot find fwu device\n");
> > >               return ret;
> > >       }
> > >
> > > @@ -771,7 +771,7 @@ static int fwu_boottime_checks(void)
> > >
> > >       ret = fwu_init();
> > >       if (ret) {
> > > -             log_debug("fwu_init() failed\n");
> > > +             log_err("fwu_init() failed\n");
> > >               return ret;
> > >       }
> > >
> > > ---
> > > base-commit: 313a1a7bb065319dd3d57e9ab6559422771aebae
> > > branch: debian-sent3
> > >
> >
> > Can you please pick up this patch?
> >
> > Thanks,
> > Michal
