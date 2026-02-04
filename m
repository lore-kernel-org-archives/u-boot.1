Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C28E8B383
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C94E83E57;
	Wed,  4 Feb 2026 01:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ocXau+fq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F8683BC8; Wed,  4 Feb 2026 01:23:07 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE2B183E57
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b8845cb5862so975832066b.3
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164585; cv=none;
 d=google.com; s=arc-20240605;
 b=JCCatZcOqcQ9/2l+sB05qbMyi8syrOdV5cNNkgoM/Y2TtrY2FZd5xvTUSXuiZzwZoW
 zyevLTA2oOFLeqMZvwE3pwNBjxpD0s08gBviDrTkrzZizQJ7xysdGj8c5BS7wPWM9grf
 RTg7t7Tw3AFc9hY7Fe59f8jnH5eZQT8fIlWFajmYbxhdOexdJ8lGEMj9bIe7uU4F+LIZ
 186ruzXkHcFd+Us0zxk54z77jvWjK9TkRK3XYq+0+G3bVhf1xPJQJnGGX69210WWyj9Z
 vhanL8amXANbl9YbPlCfK5TdmyUFmRq5ymM4ltaYlNfG1n9uEqTYOXBR4/U6yauRw/YJ
 BiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o07RK7mg13gbsRWKNHWPktbIu0d1BD+xWTWXmdi2ZyA=;
 fh=SoDKoky7H+/WdZ4nBr1SQVWopsNEYlCZeXlzPeLFj/k=;
 b=XFK+HU0PuTeUSdA1q89Y2OsWJUM5re6IlVpjwQjaefvHbfD1Z880EDUCxoTu4ZxeBP
 QqxyYGFL6ZoDlz0+mLrYnNH+1j3wVsu68KW8hZ2bCtOk5zHMLw3+keVhLm2yJiRO80Gt
 FTbWl+DdelBpjQWhM02pq/hdxC3d8NJjlVhl8CKw0JH7VB9XaIakJwqyoImPuZN5Ehbp
 mNLF4qPVZu2rcNuSldwayK0Oc0fyHQ/UD1z7IhMCQo/8ZTB+e3hJFK5VDEKIk1gb1YKo
 fNgTIRhV3pMrUWfP3w+00ds4VlIabs2c4YZWEVClu//ktxx2h/w0V4O/N6psCAxKmcY/
 dO4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164585; x=1770769385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o07RK7mg13gbsRWKNHWPktbIu0d1BD+xWTWXmdi2ZyA=;
 b=ocXau+fqtHOqLgaoU0S7Oxozv4Rh6ej8aiZpMHSY6scVwtZ3X7Bm6CWUueuJiOl1f2
 9gTNQbB9imorQYHps7mM5s2vo16wXxmQGyAINFNlrxfKTKGvuY16teOMU+V3orjo+CQn
 7U+XIA0MJJNZTH3tKbDMjJEH1z2cmMYAE8gf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164585; x=1770769385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o07RK7mg13gbsRWKNHWPktbIu0d1BD+xWTWXmdi2ZyA=;
 b=ZKDH8BPq/+F8nknETjbBvGatpL+awirAIhvLvLhJHkRkyE+X4A/Yt4O+Git8E6zC8w
 aHDONNiF9HLNcvx4ZgU0RBSsBhBkMRm5rxXV2VJ1dm38yte5TTwWliMGUJifAgOCPFk9
 ZH/FL6xMOGW0BYmUPbApnHGiyyV4BM7La24921zKSZCV1M/AgIdYr1xzy4pt50xk4cys
 ztPyVl3xzRT1JVOVwXxZGyFtBZ3iBEsgbwTLM69VMg3vD6XOcbuXk1rOC0poFJ2+2EH1
 xD4rc867wQDUCGvOxV15vRTVV5yTDNY49LU8r5pLYQ8609lEHUBEJ2n+bwSNFWlTxb76
 lRTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfhq6YNmZeb/VXfi1J+FQxW/reivuSvTWNQ0B2DrYJ7Gjg1Hcz3wo1bxypaK77s16moVv3+KI=@lists.denx.de
X-Gm-Message-State: AOJu0YzWsno4y0N6MkP3sfx3y5KguqQvx6r8uW4l+14nwN0/ioLpEI+a
 ltpUivyQpM8174xWUTeJ8XwyMcYLDTxUUnB59/8IK2aejvLxinvo58J2fqYBSWV+RGdj+SrZD0M
 rpp4SfAMKb0uzTrm7Qcoq7F6wFdUKNLoBH2oRWws0
X-Gm-Gg: AZuq6aILIxryJlX21PpQ6PeuvQJ2SDgiAg6ElmR1ufmZ1cPwNDzBvM1vTWxdRnTsAO4
 p4YoW/INS3Ae41A3G2OyQhAOEP6tBOf+M/T0AbDAHpMf00ylr9UI9N2F4fS+MriF452lsN5r/37
 IYB35+LOOShx0K06vbZzM0pCOAA2OuU8W5Bw7ausPHCwtUv/x3HwSzUoVS+eLUp1wzpKDltfEBi
 9Nd62X4+HL1IHRm+O01kJWd1WHbPxVFyayIeup81WkqPEXmYVepyZ2eGeuR5bX3HG2mHExU
X-Received: by 2002:a17:907:7b9a:b0:b8d:e79c:906d with SMTP id
 a640c23a62f3a-b8e9f410525mr87032966b.52.1770164585164; Tue, 03 Feb 2026
 16:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
In-Reply-To: <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:23:05 +1300
X-Gm-Features: AZwV_Qj77dZg9j9kKn3zZp0JqacZ5eBCpQPcqUr6YBOXtScgzKVdbPGM_0jk4Sk
Message-ID: <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, 
 ilias.apalodimas@linaro.org, me@samcday.com, aswin.murugan@oss.qualcomm.com, 
 clamor95@gmail.com, michal.simek@amd.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

Hi Varadarajan,

On Tue, 27 Jan 2026 at 17:18, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> On Mon, Jan 26, 2026 at 06:15:34PM +1300, Simon Glass wrote:
> > Hi,
> >
> > On Wed, 21 Jan 2026 at 19:39, Varadarajan Narayanan
> > <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > >
> > > Add a 'request_arg' op to struct sysreset_ops to enable sysreset drivers
> > > to receive arguments given to the 'reset' command. Process the
> > > request_arg() op before the usual request() op.
> > >
> > > Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
> > > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > ---
> > > v6: Wrap this functionality inside CONFIG_SYSRESET_CMD_RESET_ARGS
> > > ---
> > >  drivers/sysreset/Kconfig           |  8 +++++++
> > >  drivers/sysreset/sysreset-uclass.c | 37 ++++++++++++++++++++++++++++++
> > >  include/sysreset.h                 | 18 +++++++++++++++
> > >  3 files changed, 63 insertions(+)
> > >
> > > diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> > > index 0181f6cd581..6fb0ca81dc6 100644
> > > --- a/drivers/sysreset/Kconfig
> > > +++ b/drivers/sysreset/Kconfig
> > > @@ -49,6 +49,14 @@ config SYSRESET_CMD_RESET
> > >         help
> > >           Enable sysreset implementation of the reset command.
> > >
> > > +config SYSRESET_CMD_RESET_ARGS
> > > +       bool "Enable reset command to take arguments"
> > > +       help
> > > +         Pass on the arguments received by the 'reset' command to the
> > > +         sysreset driver(s). The sysreset driver(s) may make use of the
> > > +         additional arguments for implementing arch/board specific
> > > +         functionality.
> > > +
> >
> > I haven't been following this, but what sort of args are you planning to pass?
>
> As of now, an argument to indicate reboot to emergency download mode.

So how about adding a struct in sysreset.h where you can include a
flag word and create a single flag for your case? We should be able to
handle reset without the cmdline being enabled.

There are other cases where this would be useful, e.g. an EFI app
rebooting into setup boot.

Regards,
Simon
