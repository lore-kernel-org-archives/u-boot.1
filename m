Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC01E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 14:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD138061B;
	Thu,  9 Jan 2025 15:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C86Lf7wv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A65980619; Thu,  9 Jan 2025 15:11:03 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D9B80657
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 15:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso168284366b.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736431859; x=1737036659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nHMjVx+85cTWxzjlsy2GU4FgKQC7cRvSLO1SM8RZ23c=;
 b=C86Lf7wvb7cKTId0rMUt3sNNegIB+5U1BIa+KcOo898xP0NhJM76EMwkZBA8ogjQEQ
 RXSmt785Q3ura7CifxeWT4R8ql7AsNjhHVzJfAwQJ9FJbL8Ei91FMBvaPDtnt4mEO955
 ZAnSVHQjWDHVxcBHqAByTce09QkrI7diDzcpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736431859; x=1737036659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nHMjVx+85cTWxzjlsy2GU4FgKQC7cRvSLO1SM8RZ23c=;
 b=Wpm/dMZKYjcQXYV/imSFemWQPRBzceRACde/ykAiZtEJXLWsuF7+VbN1p9ypfdSRbp
 fojPucncCIAsxBaQ1Kzf5K8jytyqScC1GcS8Ajnh0mmpbno5QT0WRmVcbA2NI7IToezX
 5AKP61yOEWAH6WavEGzkdvrl4KSZ4tXkevm/LFXmFOJgGNxc0iLbgKDMLpx/Kzw0Oqst
 CrPNNKmTfDcgchg8nMsZlNk/MEpBtMUVDetx/nbZgoEZcoorHG5gR+rLZh3T3EvgEeVl
 gxvOgZSt0XvCodFyMwtoTcnx04yj4AGXmzwgNpolDsBSFYaOSk1xV9ZyjIgnOrdnIXmn
 fSsQ==
X-Gm-Message-State: AOJu0Yy8niujwX54MEOm7Cs3AW5Xd6A8tW7SJ7OtbJa+PYZzoY0d8GUf
 dFtQb30diTH6HGVE0uuZeB0RF3ov+oHxb1Fu1IVN8X0l86pNuYHZL4ETWPeIVJKazz5GY/4nkbe
 I8IS8UXNfSGu4uCksGMwgYkW4B/lhgj3tBVL6f1vp5sIMZBO0jg==
X-Gm-Gg: ASbGncv1PHl9gsJt4QNvdGq4e3O0Ss055AT+B47VZl6lMPkHSpj18qHljHLfOmXrFsu
 GUjyxPDy35NIVXB9ARkJvhi3ArBNNuNYRPs7st9E=
X-Google-Smtp-Source: AGHT+IEDHX0evKCA3c+cYlDShzYH+0A/brDnEpxQyfcnI0o8udXS8d3voQGc7OOzbJhhBOg1ZADcBQXvQ3iCX/bbXIg=
X-Received: by 2002:a17:906:6a19:b0:a9e:d4a9:2c28 with SMTP id
 a640c23a62f3a-ab2abc920abmr683718766b.53.1736431859327; Thu, 09 Jan 2025
 06:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
In-Reply-To: <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 07:10:47 -0700
X-Gm-Features: AbW1kvYI0BCdMS02cV-n0OEcwSCVvM-zbg8F0zO3pl_CZ05X5gShKXKA5MwDLew
Message-ID: <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Tue, 7 Jan 2025 at 04:24, Marek Vasut <marex@denx.de> wrote:
>
> On 1/7/25 4:50 AM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Mon, 6 Jan 2025 at 13:51, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 1/6/25 3:38 PM, Simon Glass wrote:
> >>
> >> [...]
> >>
> >>> I wonder if the cst needs to be updated (binman tool -f cst)? At
> >>> present it is using apt-get and has:
> >>>
> >>> $ dpkg -l imx-code-signing-tool
> >>> Desired=Unknown/Install/Remove/Purge/Hold
> >>> | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> >>> |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> >>> ||/ Name                  Version             Architecture Description
> >>> +++-=====================-===================-============-===================================
> >>> ii  imx-code-signing-tool 3.3.1+dfsg-2ubuntu1 amd64        code
> >>> signing tool for i.MX platform
> >> Perhaps. Can you suggest a fix ?
> >>
> >> I am also unsure how to get the CST test to 100%.
> >>
> >> I still don't fully understand what exactly are these tests testing or
> >> whether they are even valid.
> >
> > Well, if I could run the test and have it pass (like presumably you
> > do) then I could suggest something. Could you point me to a cst binary
> > which works for you and makes your tests pass?
> CST 3.4.0 from debian/testing works with real hardware.

Unfortunately after much messing around I cannot install this on my
machine (jammy). I do plan to upgrade to Noble at some point. But we
cannot rely on people having a particular distro to build U-Boot
images. That is what 'binman tool' is supposed to fix.

I got the package source and tried that. The build instructions use
docker, which I have not mastered. The container needs curl but does
not have it.

I was able to build it from source code without docker. Is there a
public source-code repo somewhere, so Binman could build it?

Anyway, with this patch applied and the new cst:

$ binman test testNxpImx8MCSTSPL
======================== Running binman tests ========================
E
======================================================================
ERROR: binman.ftest.TestFunctional.testNxpImx8MCSTSPL (subunit.RemotedTestCase)
binman.ftest.TestFunctional.testNxpImx8MCSTSPL
----------------------------------------------------------------------
testtools.testresult.real._StringException: Traceback (most recent call last):
ValueError: Error 1 running 'cst -i
/tmp/binman.t45m9_fv/nxp.csf-config-txt.nxp-imx8mcst -o
/tmp/binman.t45m9_fv/nxp.csf-output-blob.nxp-imx8mcst': File not
present SRK_1_2_3_4_table.bin


----------------------------------------------------------------------
Ran 1 test in 0.151s

FAILED (errors=1)

So where is the SRK_1_2_3_4_table.bin file?

Regards,
Simon
