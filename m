Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A26CDE008
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 10:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2768084704;
	Thu, 25 Jun 2026 12:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kaH2+Y4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50A9E847C8; Thu, 25 Jun 2026 12:59:47 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9158460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 12:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c0e124d2a21so311351166b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 03:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782385184; cv=none;
 d=google.com; s=arc-20260327;
 b=Q3jauoypxFWekoZ6EINRbN1fCHTksOmf3ZroeeCPIBmGAtqdVJdiGK6QAQ5X+il0XD
 6PbbGkzfPo3Ib/IV6xROgwBauxnCF9FDmfMq5Z92mWTSHvbvjaiizxxIVk0SMqaYtVI+
 Qu9zYhLdOkcLgp2Sz+MxNUlyAb1VhhNORXQq8/MlR91mMcxqYZRzunMjsVspWp26Yinr
 Dotc61UA/X5g/LSVKPmB/QYZGJB9QJxdgubae0fv6Ce4/NHdaMG25JxwKExj3ALrJ3p7
 HJyAwJs4BanPO2B+9bNFCZAY+8m/JZ5flV7V3oqHwnt/qxo5ofk9RZyW+l8QIZ17sQhl
 QmAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pXkp355kceNM7oojIcZG04TFFhoheflJoAg5BoCr3ho=;
 fh=nJxZUcDMXWWwoHUYNNSxOqeOihIBvChUkYuXuDks9t4=;
 b=sFwAuSb8h/wD5hE+j5rF+HCVRUPO2mjf8y2mvftkAzqh6QV6SrPH9Yp9FEBA/kRJmk
 yzI8SpHWcUIUeSGrKVCxU9+1Bu6F1QWslPgGkwZvMIZlhUe/jTJn7nt9365dwp2vtLrE
 elor6oWQ6MHPp/x4VLgVlgUH7vxzgixMjroTj91vx2VG2ugUoBEC77sfU5EoMP6uQ6q1
 Fp8W/fRxWC1USCJT5PlGUQgD13nxg44rDQTJ4zTg7/EAe2dsI9xoLSXQ8B9P9tjdQMDQ
 ns/J8XOKOpchbnIm1ACGSMH2l3wG/A3aBYBxPyMTwqxk1ZelJFxxnI0tL0hNY00ITfsv
 +qlg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782385184; x=1782989984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pXkp355kceNM7oojIcZG04TFFhoheflJoAg5BoCr3ho=;
 b=kaH2+Y4l93PjINGAjH17ymORZZvVVg91+XLYGotHtzJUW9ddmgczI4CtAmDSgFeDSu
 AMgBLXMMH+ugZC8lpemT+1gdxRAivb5DSRtkqDu3NL3MViQVMYllfcUPA2doXxEqhQKV
 i1HU6sY+x4wtFKFtLN+lAzZMD4NsefYncxoGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782385184; x=1782989984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXkp355kceNM7oojIcZG04TFFhoheflJoAg5BoCr3ho=;
 b=VAvGclxJQz99kQAYbRtlhzbUEbT52l2I68f3oDBLSIxysc4I1ro2nvlDLsm0bzZqem
 mxcF7t6iVL728lwpVeYcySaPfO2i9DIM83j54pOgELekmFSOGf1YufkOF/CggHcMZVIS
 WdiW7dB0Ka4ktJaU8VSfKncVOjrNGjF9S76Fy7wJmAitHkxglTiIKEqoRUiwYtxaia5T
 z2ubXEkE1v+gnFPPTooInRh5hafVncy2y2j7PB6gw1r4X4hJpCXGYIuwJ1gCWY5LEHWs
 GVgRAkCwYzOb9stDAYZug3qJndDMFGFn/uE4ZYspbqcrnBAxccvXm61QAk4XPp6mYylq
 E1zQ==
X-Gm-Message-State: AOJu0Yy6yVBTej1W1iDf8iCuOJ9zGJ/MrLkoBHEeXlMh3v0FHaRx7DNV
 Nxov8nQhj/OJflcl6+WjC7icsE6w4eTK5CwpIl20VVgVzsIlhxSSWi771zQ0ak1SBBE8QzsLaR4
 03QfsjCB59KA4G8eVrJzvC+EzAfyMQBf1rU1h23fqNcXBIj+/zQnyOg==
X-Gm-Gg: AfdE7cniPxRBJ7wgBeE0O5r4BYOz8V+rtSBtfjETyEood8PkZ70AB4dbXwKE16bt2V5
 lKJSGHsnRAE9dv70E8aCpa+W0aI7Ezug5w2XmJjoA4XGAUf/u1roAX8s4ky9LBpuhz7LXiHkl17
 eMi9T/h82U9CWa49N5cXW6bsql5/mnidTPa9o2X+EGi576ooO7EQTc2osdaC+g6VAbhBDRd0ObM
 dqwyg0/M/HHI+8OrpCT4QWXeP6cBDa0Lu/LAleUibq4Q/t87vBuTEh26WEIesdxDXPVS8bNyg==
X-Received: by 2002:a17:907:9713:b0:c08:c6ca:411d with SMTP id
 a640c23a62f3a-c1205eadd73mr135785866b.25.1782385184374; Thu, 25 Jun 2026
 03:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
In-Reply-To: <20260619-riscv-full-fit-image-support-v1-0-c6477cf4f410@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 11:59:32 +0100
X-Gm-Features: AVVi8CfWsOXnnoFbRBPgy4hYFKSYByQNw2pwEb1FkA5Iuuh23xUtU2bidSyAT_Y
Message-ID: <CAFLszTjR1xm+LZV3Ys++sdc-1viQgx_jAvT5JTP=sSyL1WyssQ@mail.gmail.com>
Subject: Re: [RFC,
 0/2] RISC-V SPL: fix OpenSBI FIT loading and OS entry point retrieval
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.denx.de
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

Hi Nikita,

On 2026-06-19T12:52:56, Nikita Shubin <nikita.shubin@maquefel.me> wrote:

> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

Please fill in the b4 EDITME placeholders so reviewers can see what
changed since v1.

> Question is - if Full FIT wasn't tested with RISC-V U-Boot SPL or i am
> doing something wrong ?

I suspect you are right - SPL_LOAD_FIT_FULL is rarely enabled and most
RISC-V boards use the non-FULL FIT path. Thanks for looking into it.

The series is missing test coverage. See test/image/ and the SPL
sandbox tests; OpenSBI loadable handling should grow a regression
test, otherwise this will silently break again. Please can you add
one, or say in the cover letter why it is not feasible.

On the design - stashing uboot_addr and kernel_addr in spl_image_info
as a side channel from spl_load_fit_image() to spl_invoke_opensbi()
works, but feels indirect. The real bug is that spl_invoke_opensbi()
looks in the wrong FDT (the OS DTB rather than the FIT). Would it be
cleaner to keep a pointer to the FIT itself around for this lookup,
rather than caching addresses by OS type? What do you think?

Regards,
Simon
