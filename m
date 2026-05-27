Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E877CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2E64846BD;
	Wed, 27 May 2026 06:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GBM+9z40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190928470E; Wed, 27 May 2026 06:41:59 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BDB80433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68707d88626so1011107a12.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779856916; cv=none;
 d=google.com; s=arc-20240605;
 b=gyv6mD6PitJAjdpZIuITS2ah/4nod+SBjm1dYRvTugvJ3aYG92DWn+oMSJtgXIC+E6
 1+vNsnssmos9hHTDUgbOpqFfJ3uHT4hIfjoMnvyff8k7F6h6tcyI+sZNtxj0x1c6qNgb
 8fmN1GDGt4fMacEpU2ncusm3WG5/w1/x7V8PnU8hN7jkf7h7JfdHySq5nQolIdqwefN5
 2zKWxooQ184cGFFQVZo3hn+qO38c+TSNDcMw+Iu8IphOFWXZMfeH+67boTsRCaHPaUF/
 U+VU1WLCDDQwa4xnmqatVpf0VOKLFuBxUs2YRV+Up/Z9j3Vj6YGCq5pKO1GOw+IZ0ost
 EXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+KC7+XHMdca61ZCJEcEPN4L5HrxFqAVSopcG1FFGCRs=;
 fh=6RH5P0FCppt2OmYognj2cnigE8IYWKkoEY1Na75/oYc=;
 b=RWz0C11PDZ3ZDyfJqrF0nngB52iyQGM6ujLjtQ2WMO3V95f9OOq1mC96i4RO8767oS
 fHML5zQk4XH+pvjeZfFVnjVB7AdmkGC/oSHLCQWVuaxQhuSTW5d0q1bJV8Fr6DkxXe7z
 SMk00GVg13hhCLAD9XK/UZ0qXO5Km2Bc24u4MkWoyD9E1fCRSIQMXAK8x9A2N1BbacWd
 EqN2/sM3Rp7WFSUn46iHWOM+PVTsVxhqCeFdy+qhqcs0Xo5R8YAYmFBpGRpAYC3DiVv2
 jp5GBlmYRCQY59frMpkmxIr60CILQb5F48YieWe/DsP4Of6YWUNBCnJlKqYOAYF8fCYf
 diMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779856916; x=1780461716; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+KC7+XHMdca61ZCJEcEPN4L5HrxFqAVSopcG1FFGCRs=;
 b=GBM+9z40lh/obxeo0FRlqqfY4J0fFen1AAac6HQQeOnHcxD0g+vc7sHm/tXYkPfOIn
 cDW/0uY0zE8XTa8HyoLRUEaonKfFt2WnJ7u+5BMUsY4VSVj2tgqNK07gVf8pFFE2JfTy
 y81Ps7RHyCOm6FMAun9yKhH5smpkHmJ3ZxFps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779856916; x=1780461716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KC7+XHMdca61ZCJEcEPN4L5HrxFqAVSopcG1FFGCRs=;
 b=sOKn9kJpaKMqa9qhPCdr9MqC9e8s6uwSuKu75nuz1+8tjaaz70rmHzwBKyEe4WwB+u
 S//V040v7+tpXibAcL5QLfdu6QdOlHubaiQEf4UR12i/Ps8cSzqeLb5P91NgDe6ybMZZ
 kL8oFE87seCyY4oODMmWxoPlRmE7QXMtoEPUwFNakEP1AgkQcmneLqjZ2PROiq7LNlMj
 WAO8DQIFmHOgHFe/KlFYfdocXqeBYUkq2Vc1oKv/Vuvgz6OhZXmPixkgViOfNaGsYV8W
 19lxCiDcGpB0BO4EoobPGo3hEebSL0ijnmg9BKVQLCLV0HQ/cDT8LHwrV1oT0gpDXgPI
 ffEQ==
X-Gm-Message-State: AOJu0YyLFa5b653wH8hzBiY7hzhQpmtJFDFuTIMcoT9OW6PSRUUOLe9Z
 a1dbQrGnX4CMJsvEZVN9KrcenbNiVlJ8vivz9M5iCLxHCea6IRPRlEMp5L64hjOefNPcExOsFXw
 IoTLa8x173WLLyFmadTiKVmN3diZ2kpLkYvRGd9x6
X-Gm-Gg: Acq92OGps2YB16+saAYvtqY7hAqASO60KQYYsRT4VK8bZ7TDkU/E5/WzYhd1+bjaJYx
 eyVvrllg2ucD7nRsswW2nzqQz7Tur6Ja7FMm6hhFt6dpRE1ADssLeO8Zya0dxsdh9sUup/DzD46
 MtxehW4/4iSnTtgYDX6F+Zrvk/DFbm0mvjuAq9QgvcKmRfpoxWV/EZn9irCKi8w0liJjUG69gL8
 ztMRsJQOqY35/y2xnJ3Kn3VJnE47RmZm54E4R3aqSGS9aUyrkeGAD9k8VMNQYIdQdae28TB/OIk
 iSfEXA==
X-Received: by 2002:a17:907:9729:b0:bd0:df77:98bb with SMTP id
 a640c23a62f3a-bdd22a3c8b4mr1207832066b.9.1779856916550; Tue, 26 May 2026
 21:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260519225458.5587-1-ravi@prevas.dk>
 <20260519225458.5587-4-ravi@prevas.dk>
 <CAFLszTgin=mUdzdxypMXrA867JFeesYE=fbO+-B+=Ce=X+iMLw@mail.gmail.com>
 <878q95g99b.fsf@prevas.dk>
In-Reply-To: <878q95g99b.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:41:44 -0500
X-Gm-Features: AVHnY4L9miflSWjRu-oS7J4vME5pV53-NR2lRcfZiaa02oUY3boUyFhcNhQKtiY
Message-ID: <CAFLszTh228mhXyOuhmd_Xa1uqrP9cVaxsMg2P4uQKJyn=V5xeg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test: hook up test of allowing control DTB to act
 as FIT image
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Rasmus,

On Tue, 26 May 2026 at 15:18, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi Rasmus,
> >
> > On 2026-05-19T22:54:57, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >> test: hook up test of allowing control DTB to act as FIT image
> >>
> >> Add a test demonstrating how one can embed various scripts in the
> >> control DTB.
> >>
> >> Verify that the source command can be used with ${fdtcontroladdr} by
> >> itself (invoking the default script), and with :<node-name>
> >> suffix. Also check that the scripts themselves can invoke 'sibling'
> >> scripts.
> >>
> >> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> >>
> >> arch/sandbox/dts/sandbox-boot.sh      |  2 ++
> >>  arch/sandbox/dts/sandbox-inner.sh     |  4 ++++
> >>  arch/sandbox/dts/sandbox-outer.sh     |  4 ++++
> >>  arch/sandbox/dts/sandbox_scripts.dtsi | 24 ++++++++++++++++++++++++
> >>  configs/sandbox_defconfig             |  2 ++
> >>  test/py/tests/test_source.py          | 18 ++++++++++++++++++
> >>  6 files changed, 54 insertions(+)
> >
> >> diff --git a/test/py/tests/test_source.py b/test/py/tests/test_source.py
> >> @@ -9,6 +9,7 @@ import utils
> >>  @pytest.mark.buildconfigspec('cmd_echo')
> >>  @pytest.mark.buildconfigspec('cmd_source')
> >>  @pytest.mark.buildconfigspec('fit')
> >> +@pytest.mark.buildconfigspec('control_dtb_as_fit')
> >>  def test_source(ubman):
> >
> > buildconfigspec markers are ANDed in conftest.py, so the entire
> > pre-existing test_source is now skipped on any sandbox build that has
> > FIT but not CONTROL_DTB_AS_FIT - so silently losing coverage of the
> > original source tests.
> >
> > Please split the new assertions into a second function, say
> > test_source_control_dtb, with the extra marker on its own. That also
> > makes the new functionality independently selectable.
>
> Yes, I did consider doing that, and I must admit I'm not really sure why
> I ended up not doing it. Will redo.
>
> Is it worth it adding another function marked with
> @pytest.mark.notbuildconfigspec('control_dtb_as_fit') and checking that
> 'source ${fdtcontroladdr}' always fails in that case?

The seems like a good idea to me.

Regards,
Simon
