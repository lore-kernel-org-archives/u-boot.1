Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF9DD6CFAB
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 23:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1519083B63;
	Fri, 23 Jan 2026 00:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ZrA15Kl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A9C83B55; Thu, 22 Jan 2026 23:47:04 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6F18397D
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 23:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simon.glass@canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1BB383FD12
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 22:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1769122017;
 bh=eHurXUS0ruouKiyptPI40QB2ri7ZzQya7uPip7A60wA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ZrA15Kl3OfJyKIQxsNdhlhM/XLIKa7t/TOmQJKxqkUXO+xDLRyB6amtMa/ovV/dmz
 u6k3zphaJ5HaF0FCJO3hy2SI/E8nE49eZIEmiiOYJCHd3uwVZVUBBmwiHGYeUTevTr
 /IrrbIr+PBavz9SHP85SMYS/m5qnKrypD+f2Al/XIL+/f5AW4/TN7ePmAAKKPDjXgX
 syBot+Vnb646KK5ZiF3yvYdH3yQUwIvebxNLZNL8u0A2wcfxp3XUNyuLeXbYsRJ01m
 JgBnfiVDC2IRhdj/dUoyt8G6R8H45go1wOvJ77WLblWLR6aI8egJ5zcq2AK6eJDUjW
 aFLPeWUF6xvX675zUuUnBkUbYxDF9DysaBf6mkEVeW9KEKae06McRkSs0NLZBo4qrC
 RMuuWsiS+g7bORLcWf3TDNix4ZqKMikWFPW8OXPwxbBAfQ2QWUYz1iCHfvK68jFRgl
 p2Mp3Sg1N6MbM3/11Ch322v7vU+xv/u+UiMw3Bs1BoXzghPF/JblFSXdUgMPi31QRk
 tkt2lh3AthX3/Sa5j2GjSVULuJb63ConvkRcx2JpnuofBSL/G4mtlYLVV8xZ4xuZVc
 tjzFaWxcjjPX6wqnGi5WFAZxKnTt/cJKZQ4utYGp0w0po4U58dffi8EZGWzumhve9C
 J2UEs6cZqnY7+JWblOPf+mE8=
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50146430e1dso37367411cf.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769122016; cv=none;
 d=google.com; s=arc-20240605;
 b=babykTm8igpQyJa5ghY8U1u5sTKw/02i1l3DDlDHR+QR2JmZzGNoCr5lHoKPnVFYG6
 KUAdeGA25lJYn9u4zlGEXy5CDutZJQoXsEnWZ+JpLplmlQzmgltdA8zUNCOwb97d3hZV
 06VoVSKc2jSW07a5YNwd17+5OP68Ftl/6xBhus+cOeHG7zscAj4HEZ8DafPHFjS7GJhc
 SV8ppHkdAxF377fJ/ANDZgy7NTkixl1fDMEfTVsDmsBQr2SAJ+vkLuSLa2Mksh8I7KFv
 duWestpiodBsPY2kXdx8DtJQfU4xY7I4EUwbTkNoPPP6rHegMqSLQWbWb6R3RI2TAvsF
 NaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=eHurXUS0ruouKiyptPI40QB2ri7ZzQya7uPip7A60wA=;
 fh=d00/0ZyBQd0gpIUMhbDVk7NDEKCcAXV0wzDr3lFDacM=;
 b=fV0LBPjooLgirCi3gRbGqhUaDHiGsw6fs9Mm+nIsUZSopV7iUwBRs6NQ7cWCYfjB9O
 gMSuTBQTjvkPkpq80swmbgQN8ZK03HnWKZ9NklRXs0nBL8Vr949PL7ALMyiqP37qHZPh
 aismwtdaPudKoriG8nXQssADpQW2lm6siDV+Qp1f5tTLXQ2e77N0LHbYizn4nhn121pf
 5m3hvou1EBb36ifw2C7QlXDkEXoGhjFBC23t6o81xor3NDQRIIAaewG4WDZmUU/ZxEq/
 pTeVnbfGySGQDtxsS+V19eEoT9JiXEXKQuqWRuz7SZ39qNnLgIzDiJTWnbteF71SsSjX
 tGMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769122016; x=1769726816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHurXUS0ruouKiyptPI40QB2ri7ZzQya7uPip7A60wA=;
 b=ACuPclyPV8sO+O+xcaDIsacAIkGmg8knF3Yef6/Gfd7l7pxgNGCuNZodKg5tRZ9II0
 BVNXRFNwhp1K0BNs1pecir4zSXgPUCrFn0c30lfK3RVKrYO5PMV2svcb3tjTaWsD+Y3m
 fvGl9XNQGEN18kmuUcfQvu9yTHgR31JJZ11JvS8Gb6fxIZkWVKfFrnATPl+RN+YRdP6Q
 UCq8n6EYeJ4vQRPD9J44EDeuJLXb0MP+Unewoyl7g3x88X0O+DaDbI3iw4quo6fDnzPk
 hgmn7vGIsmulAacbez39+JbiAPxL6hgEOKbtgnK48bLnEIqs0fSjnfTf51B8P43FNy8Z
 3coA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsdTBrCPNTkvM2lkILz0gC8yf/ITlyJhf+r82QGt3PlQV1benUGBFW759tIkDkvsI83BUu/vU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1KU06rQP7eRDSFdB4TV+vcjhPk03RetrYzMyiae7xdvbf5WY+
 /5Rz/KEBmDhmLO+b8VIBGFfCPfL88n8q31cFqsn+VqT7ObXYAL41fY+5v5pVXsEHI2jdslBmyLY
 yfcif3tu5DN4vxes+3NbTKAMsvc1z7KWW/ZsWpJIxp4mr+KWMM+mzBKSLnddNk1z9yeHeByTuS1
 MBgP2xpN4oRUImLXFUVyltO9nMIeWxqg5jMHNecAIISX7w9A==
X-Gm-Gg: AZuq6aKwQBNuno832hVSdPNlKctWzOYm3QTo7FlUna8/zFdSA8yl+Ly5LDPtYFIKk6j
 C4q0hd1sSbl3j4F1GfJm1Ycr4zliL/i4fuCkZIxsKaNnof9dw6WzuIl7M2huPSGEuu4LGXhY5Zl
 Z9vYXgYQZPbRZ2wq4SPPjnz1bjKjv1P01h6SrGprzTXbg6cubTD6z0VjthCFKbUCbyh7i6
X-Received: by 2002:a05:622a:3cc:b0:502:ba2c:b492 with SMTP id
 d75a77b69052e-502f7812090mr14817501cf.77.1769122015974; 
 Thu, 22 Jan 2026 14:46:55 -0800 (PST)
X-Received: by 2002:a05:622a:3cc:b0:502:ba2c:b492 with SMTP id
 d75a77b69052e-502f7812090mr14817341cf.77.1769122015587; Thu, 22 Jan 2026
 14:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de>
 <aXDJ4PrbO2eL63B-@mt.com> <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
In-Reply-To: <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
From: Simon Glass <simon.glass@canonical.com>
Date: Fri, 23 Jan 2026 11:46:44 +1300
X-Gm-Features: AZwV_QiUiYjySRIuocVYuzLnZxppn8MZ1TP4DVI7yvFcsOakopRHMq3k8PjIFGo
Message-ID: <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de,
 trini@konsulko.com, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 23 Jan 2026 00:24:50 +0100
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

Hi,

On Thu, 22 Jan 2026 at 02:06, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Wojciech,
>
> On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
> > On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
> > Hello Quentin,
> >> Hi Wojciech,
> >>
> >> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
> [...]
> >>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
> >>
> >> This is wrong, you'll be messing up with the environment of all tests being
> >> run in the same thread. You must use the "with
> >> unittest.mock.patch.dict('os.environ'," implementation I used in
> >> testFitSignPKCS11Simple.
> >
> > Well, I have done so in my V2 but has been commented as wrong by the
> > first reviewer. I will restore it back.
> >
>
> Indeed, I see Simon asked you to do this in v2 and I missed it. It isn't
> how we should be doing it.
>
> This is likely fine on its own because there's only one test that is now
> modifying os.environ's SOFTHSM2_CONF but this will be a problem next
> time a test wants to modify it. I actually hit this issue when
> developing the PKCS11 fit signing tests as I had two tests modifying the
> environment.
>
> The only trace of it left is the changelog in
> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/
>
> """
> - fixed issues due to modification of the environment in tests failing
>    other tests, by using unittest.mock.patch.dict() on os.environ as
>    suggested by the unittest.mock doc,
> """
>
> and you can check the diff between the v2 and v3 to check I used to
> modify the env directly but now mock it instead.
>
> Sorry for not catching this, should have answered to Simon in the v2.

In practice we try to set values for various which are important, so
future tests should explicitly delete the var if needed. But I am OK
with mocking, instead.

>
> [...]
>
> >>> +                      '-CAfile', cert_file, '-no_check_time')
> >>> +        except ValueError:
> >>> +            self.assertIn('UEFI Capsule verification failed')
> >>> +
> >>
> >> I don't think this is valid.
> >> https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIn
> >> states you need 2 (or three) argumentis, only one's provided here.
> >>
> >> I'm assuming we don't need the try..except since the raised Exception will
> >> just stop (and fail) the execution of the test but continue with the other
> >> ones? Can you check (locally) by purposefully using the wrong key for
> >> example?
> >
> > It has worked (failed) with try/except. I had to add no time check as the certificate
> Thanks for the heads up, @Simon any chance you can update the
> certificate so we're fine for the decades to come?

OK I sent a patch.

Regards,
Simon
