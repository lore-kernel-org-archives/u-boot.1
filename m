Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDFED63933
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 12:41:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE3C9896B0;
	Wed, 20 Nov 2024 13:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SPfoLbB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0128489671; Wed, 20 Nov 2024 13:40:58 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAFCA896B0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 13:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa3a79d4d59so334221866b.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 04:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732106454; x=1732711254; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aubYkgD3KEHUfiYfXHTONPN8NxmrkZf0zp4EE35MkZQ=;
 b=SPfoLbB39f81PH0GvlzJION1kKDoHl1LD4ZhaMUrkE11hbr7BUuBc+eFt05McrrUu1
 WvzwRc0VgWf+FdcXS4gvacDqaDUJ8CwDmvmJbS926gJKANhlh1mtj7picjqP1zlAjkg4
 Vnt3/F5zAyBq8JuhY5VVSM+kB9l9vFr4Hufws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732106454; x=1732711254;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aubYkgD3KEHUfiYfXHTONPN8NxmrkZf0zp4EE35MkZQ=;
 b=sJq9hjiKV5W35GBGRMCHmQ+9UnCOQ9S9JIriq2s6d7d0kRy0madI0+qad3YfLj4pX2
 rgIGJ+zqL3KXzSlK9ouOI9VaJb5sppuhQG0HkCNh5WLaZacLhs+n10xvqrHeySSXwYdD
 GumM+v2jRtSUh+QPiR8cp7xiq/RMAAMOGBcEyyo7M/puwnnJP+mOIDJfDbufY0Wg5im+
 wft83MYv8TOPkslAdhojC56ZcOFrMdJB1/QIoDwxvLd7sSh+TfcjGCI2EI/r2ApFZjZ6
 agxacHqkhL/anPY2JvzKcbBuxqEQcOmqR8ZXMcLnVT42jrQxoplA6eqmd7CyRWVj9JDV
 6EGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3z02uKQ4W/ySax4U+5XONrNQNhxc1+atll41mTPzt8rFJkvPMHIz/oJpBI4/RjJ6X1316tIE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgo7OkLTEtg6P8+EE0MjNflSs0J2MmRbQ2ZcsKWKWgnLwbu+7k
 IyNGSh6MzxcHxrsyFnYvFcgnxaDrXXGg5hq+IMJFFIn72rEDFWi8ufss0NP1l3y/W4ofVQCg1B4
 tELN7DKw18MofhM0Ad71x7/Ey7/49aT8S9L/BYlS5n9w7xXQ=
X-Gm-Gg: ASbGncuLVlJwA4FV48EFEOdaY6yqr4LtdPnpU9j68oFsIyOq6G+qr6txMlxIUFbXdfZ
 +hK31LlEQxmE5HrgKmuTUS8ljM/AbJnA=
X-Google-Smtp-Source: AGHT+IEQlDO55L0gLiAsbbS8qJ202c1Wr+3AaR4maOQC5xsgjmn2CIYqOFVmg8ReRRLaIws304ekD4F/Dvxb7jn3ne4=
X-Received: by 2002:a17:906:fe4a:b0:a9a:835b:fc8e with SMTP id
 a640c23a62f3a-aa4dd748bacmr238224066b.54.1732106454450; Wed, 20 Nov 2024
 04:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20241021073749.63-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-1-brian.ruley@gehealthcare.com>
 <20241030080753.129-2-brian.ruley@gehealthcare.com>
 <CAOMZO5CC683+5_xohQw_F0kuiE9mmL2PqjqHk66A1oUXje=oSQ@mail.gmail.com>
 <ZyiGvONusmq03cBO@zoo11.em.health.ge.com>
In-Reply-To: <ZyiGvONusmq03cBO@zoo11.em.health.ge.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 05:40:42 -0700
Message-ID: <CAFLszTj=AfwqRU=ON4psoJR8Rdu=c3RtPzzSKDsX_BoteWHZFw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] binman: expand test coverage to nxp_imx8mcst
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Fabio Estevam <festevam@gmail.com>, ian.ray@gehealthcare.com,
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

Hi Brian,

On Mon, 4 Nov 2024 at 01:33, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> On Wed, Oct 30, 2024 at 09:23:46AM -0300, Fabio Estevam wrote:
> >
> > WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> >
> > Hi Brian,
> >
> > On Wed, Oct 30, 2024 at 5:08???AM Brian Ruley
> > <brian.ruley@gehealthcare.com> wrote:
> > >
> > > Add coverage for IMX8M code siging. Create PKI tree and other assets
> > > required by `cst' using `hab4_pki_tree.sh' script and `srktool' in
> > > `cst_3.4.1' [1].
> > >
> > > [1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW
> > >
> > > Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> > > ---
> > > Changes for v4:
> > > - Rebased on master:
> > >     340_nxp_imx8mcst.dts -> 343_nxp_imx8mcst.dts
> > >     341_nxp_imx8mcst_fast_auth.dts -> 344_nxp_imx8mcst_fast_auth.dts
> >
> > Here is the result when I tried applying and testing this:
> >
> > $ git am ~/Downloads/v4-1-2-binman-nxp_imx8mcst-read-certificates-from-input-path.patch
> > Applying: binman: nxp_imx8mcst: read certificates from input path
> > Applying: binman: expand test coverage to nxp_imx8mcst
> > .git/rebase-apply/patch:206: trailing whitespace.
> >             X509v3 Basic Constraints:
> > .git/rebase-apply/patch:208: trailing whitespace.
> >             Netscape Comment:
> > .git/rebase-apply/patch:210: trailing whitespace.
> >             X509v3 Subject Key Identifier:
> > .git/rebase-apply/patch:212: trailing whitespace.
> >             X509v3 Authority Key Identifier:
> > .git/rebase-apply/patch:333: trailing whitespace.
> >             X509v3 Basic Constraints:
> > warning: squelched 7 whitespace errors
> > warning: 12 lines add whitespace errors.
> >
> >
> > $ ./tools/binman/binman test testNxpImx8mCstFastAuth
> > ======================== Running binman tests ========================
> > E
> > ======================================================================
> > ERROR: testNxpImx8mCstFastAuth (binman.ftest.TestFunctional)
> > Test that binman can sign an iMX8M image using fast authentication
> > ----------------------------------------------------------------------
> > ValueError: Error -11 running 'cst -i
> > /tmp/binman.tf697xr9/nxp.csf-config-txt.nxp-imx8mcst -o
> > /tmp/binman.tf697xr9/nxp.csf-output-blob.nxp-imx8mcst':
> >
> > ----------------------------------------------------------------------
> > Ran 1 test in 1.318s
> >
> > FAILED (errors=1)
> >
> > Any ideas?
>
> Hi Fabio,
>
> Strange, but I don't have a clue. I was able to find the bit of Python
> where things go wrong in my reply to Simon:
>
> > Odd, -11 means that is the resouce is temporarily unavailable, no? I
> > don't see how that could be caused by my changes. I managed to trace it
> > to line 367 in `tools/u_boot_pylib/tools.py`, which takes us to
> > the run_pipe() function in `tools/u_boot_pylib/commands.py`, where we
> > wait on a pipe:
> >
> >    108:    result.return_code = last_pipe.wait()
>
> I also described the environment I was running:
>
> > I've compiled the NXP Code Signing tool myself from version 3.4.1
> > and added that to path. The system I'm running on is:
> >
> >    cat /etc/fedora-release && uname -msrv
> >    Fedora release 40 (Forty)
> >    Linux 6.10.12-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 30 21:38:25 UTC 2024 x86_64
> >
> > Also, prior to running any tests, I've built the `tools-only_defconfig`.
> > I admit that I find the test suites sightly confusing, so I might have
> > missed something.
>
> I can try to run it in different environment to see if I can reproduce
> the issue.

I believe this is something wrong with the tool. This is on Ubuntu 22.04:

$ binman test -X testNxpImx8mCst
======================== Running binman tests ========================
Preserving output dir: /tmp/binman.imy5s98_
Preserving input dir: /tmp/binmant.izmi883v
E
======================================================================
ERROR: binman.ftest.TestFunctional.testNxpImx8mCst (subunit.RemotedTestCase)
binman.ftest.TestFunctional.testNxpImx8mCst
----------------------------------------------------------------------
testtools.testresult.real._StringException: Traceback (most recent call last):
ValueError: Error -11 running 'cst -i
/tmp/binman.imy5s98_/nxp.csf-config-txt.nxp-imx8mcst -o
/tmp/binman.imy5s98_/nxp.csf-output-blob.nxp-imx8mcst':


----------------------------------------------------------------------
Ran 1 test in 0.157s

FAILED (errors=1)

$ cst -i /tmp/binman.imy5s98_/nxp.csf-config-txt.nxp-imx8mcst -o
/tmp/binman.imy5s98_/nxp.csf-output-blob.nxp-imx8mcst
Install SRK
Install CSFK
Segmentation fault

So the tool is segfaulting, for some reason.

Regards,
Simon
