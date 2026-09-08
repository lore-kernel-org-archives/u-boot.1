Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678E4C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 09:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 169B48097B;
	Tue,  8 Sep 2026 09:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0YNLMGb91Ac; Tue,  8 Sep 2026 09:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A000680986
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788861075;
	b=cZIJbLRnzNexmdXVATRtEvqsCNW6b0n21hb/feHYAUr5coO3WxUpzcMlktceEUKUhTYU
	 40SL8TU9b5aXR+pWR12QJI6XjKIllJJDGsa5gmEwMdh9PQAt7d4jnof/JPrIJUP0Eh6IF
	 VVBDIYS287W3xxE8oTZBTZ1rE5Ez00pnkxDHEk/ggKUZ/RaxQRYz2S03UVX5Lth8XSGo0
	 syrbYCLFf+Sj+jo1FL97+ZAJDmRTMaQ64R/fxm7Kw0n6G5J17YLxTmdN+y2Lbzu1FTD9B
	 xLTMUzbjcFd5dRYFMMe55rMSS+fWro15IAHZobRwVQVZeqi1VZLdw7PD8vcc22ekh6w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788861075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gVm7Do0oaIHs3q4Viq1nUG13A3zMmPfJUKBU1vbN8QM=;
	b=OLkvY+SSPVW/UzyvNMLzh8SbPl1K7TimEftD0ln4MEaOzoqCGQROZUH54lCkOclkdXYz
	 UxwxTYdobDXYP9uRLfGDJn+lNbFjojZBGF6VXov65lBFrlqR86a2vyJu/+K8uvUspsuiv
	 Gzd7fCkJnIJek8CjQ4B/89HR1QndqoYYUlmiEbAA/AKKS0O9S3NY35jWJMz4CRUaWe1PK
	 XqbYA41w9oQ3STrBx4X2sL4twiecAiN1Qi1rvEVCVsEV273wZUTXd0eaAgsYAS96mxfbD
	 ViyXpitbxCj3HsS0VxuVNsCzXQsg0QdrNAOHNi+xACF06DKY0Mstoa26b/v9ZhZ9vwA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788861075;
	bh=gVm7Do0oaIHs3q4Viq1nUG13A3zMmPfJUKBU1vbN8QM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X16dueeTaYjyeTm4xJ0HFJt0OHV9GS+uVU4zt3NlYHr6vIsE0U7X3NyRe3mRPZI8d
	 HXl9uogUp2zVEK+xhXq0X3YeiiCgIu9dhRpH/ZwFRBXIm44dSCXR67mzhhiQZmNCeT
	 lL967J+gOkfOspRGfISNSSoh2TfxyJPjFTexUu7to4fLiIwGAFtc3zMX0rnY3TwfoW
	 NVZrPPq3Itk7NSHmgciQqWXjjfRQwenQLTw3nF3DA0o5DEikuR+D9ujVikJK9kyv9p
	 m7o67+4M/qpmcGNsEPdksLkleBj2AbS0OSKTECx4OdJzsJcRjyA9Cf9UmCdJ8XU7rh
	 ZKClD1sjY+v2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A000680986;
	Tue,  8 Sep 2026 09:51:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BA081D5F
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2E66404F6
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y04KL1b48PwD for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 09:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5F3BB40401
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788861073;
 b=LhLbruroeit0ZDbYMl1GlbrnkcMvK59fT4nhkhufW/JG4PBt8nmc44W5r65fbnQeVrAf
 l3wuYt8m9vpUcp0NbNDt6TCxbTOpACt6L06ux0j4pqv89js7zL+Gu3/MqqeZMLwqiZkVe
 qYND8o0xB3KrDAdjN9q+nCFdEWNBgUgTn+J/q0w+TcJRIM4Iej9w3ez0nbTGMJN988E7M
 vQSYx/ej2AeVPag4NtxeaX+MgqPIF2TOQtYapj+OM4+i6pVr8nTaOYEoFTf27VcKueOic
 iObEikt4+BomyU3RLzNugIOyRXzgSbKdN991DXOnkgMwOENVrRjCzD529jpVn7sFuHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788861073;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=gVm7Do0oaIHs3q4Viq1nUG13A3zMmPfJUKBU1vbN8QM=;
 b=EXBi0b+fBc5xCfGIZZDBSV0f4OKOE0l2EKZdF0DY170Bb0OU6o8zQgoLIesPg1moIDBe
 BDhl6FGaLQ1vTN6FYGJjg8jC/v/cGV0yiEAxHwi0JTtXNoQIDH3uKrSM6TMDOJfqToACq
 mFeVv/HFSMHM8iXOAzxfbEqWhDGfsgN+f9P/cljNgYU2Tm+xFOu9SBO6UbEuD9lPhYKiu
 oFc2Eu5C3GlsEerYhK+9VC8X9vHL3dqUSAOR9h52lkXLnkbjB6z8qBS1gKv6YlNXpS7z/
 UkrXUNZHTQ68Cnl9MFkSaproyL4myTmoAsyCCEQSQSSMj+vB8A9UbGJRFkZts5axo+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=A4mGAo9g; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=A4mGAo9g
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F3BB40401
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 09:51:11 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8726acc5eadso30740957b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 02:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788861070; cv=none;
 d=google.com; s=arc-20260327;
 b=aVKGculvx5AqCQ3JUpcSDs8MiBZ+REmlvkq2SYsM3cJ6s7XFgTzonBe3SQzp4tedeL
 jV6mDQmz7dBeNMt7ciqrflz2RywNVE53w3PsfFzY9rNYe61Z59A070qfrRz9WIndTJce
 EcV+Paiot4wjrH9BiSQ6GwIspE0PK1iBK4AGxQGyVGs4IcIbGDAkl6Lu1GVc2bwqrViW
 fRpPPbKl83GEwffWOxfY6MAOVPSW1CW15Bvvbm6Ll+uovWrntd7cvJ1rJTw73eFlGU37
 KhgfX7WT88eMb9GKQwh+kKHRaEW0e1a4jmNKPV4k4POfn0HFvZ5PyjICjverkbqnx/2M
 LJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gVm7Do0oaIHs3q4Viq1nUG13A3zMmPfJUKBU1vbN8QM=;
 fh=29c1nrkqZnbQeYBsMI6n2BOHI0D4qvssFPI4NAsSB2g=;
 b=BrWxjYf/rwHtB343GbJukPx3/7DgXV+nxePomIyIh8pQMPdPpBmiWWw4Lt1EYnd88k
 WImYpGUP33jhITwFfuJeKomGf4Pbwo7ya6Uuofx6ueuu84e2r9UdZ4hvI53f0mSlp9ch
 m2ZQEkMzj6tb53bSd8USPiYUdSJNuo1C30IE4DxReaIkuDLYrGL3n43EqTHdv/tm//7Z
 vqT0JiFIRgQ8EcNWWx6jpPbrJqiYN/aJM104Gb9aNOo+zwyosOv2qfIxR9/WgGlRxwan
 tzEeo0ONUBEqPqOlE71aUUQKci+GSMNDN1r6SrjLcE4gScLkN2c7fb1BAkbQ1/s4xF3I
 7iAg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788861070; x=1789465870;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gVm7Do0oaIHs3q4Viq1nUG13A3zMmPfJUKBU1vbN8QM=;
 b=A4mGAo9gXzVww6GqAl8ELvrOflj5Q1JkSHgevKCmmpsR5OoHcUQumrCueEvjn8e1DB
 1OjI2jCMDLYkSHhJ5PidY75z3UUBogbyq3jpIBg7HCH84HrqJShYnyok6CeK8zskTLQU
 kbKemB38IUqJj48w5gD6sV1g2emidn5wC5o8wKyNdD2HQzH88vCtySAscVjCWPOMdQbG
 ZQIBRN5UN+z/Wkec6wZH1zzJl3BQejem2M7+DxEyTTvrROQj3flJhu/iuR0N+dKxRIaW
 djgDVd4s87ukmHxc07FDfylvWpnQ/UqQLHTe2LUzGvXWiSuL3HMR6OHpGNi1wTnY56Yx
 uH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788861070; x=1789465870;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gVm7Do0oaIHs3q4Viq1nUG13A3zMmPfJUKBU1vbN8QM=;
 b=mn4WHBmGMLdPjnk5wrHUF5I2VpDlJVcDWs3+UB6f8YDPwdyyOlf7HEsJxgwUXSfjzK
 8KsiL91rl9CKseJtiRMJJaF0WBEcXvBsPx7zwgXuac9GtPxE0JB5V3dKd32HRaKxkPlv
 /TnmKP81LM2IHyPmkR29cs9FE5NeUB2wfGGY4UyfxWE8KERjXtzyTaLukjLcrQnZL4YU
 SV37Xu31Cy2QUy1JDViWyJ+XuAY/ychBDlZGfk2zCUWsccM/ITHUM6jpu8ylGxpU0dm+
 OxRrGyOD4z0kbWF18CfWsI42ukBLxKNLtuFdxcoyE21S7iEbXtDCJ7/TA4xZf4o2hiaz
 eOAA==
X-Gm-Message-State: AFuF++m8NBV5xYFq0urZomvvHSf7p3hh7UX59ubkw80d8hLECfBNkTMs
 gos40a62B7mKX3feQ1tQEOzdkVlm5hAWSpo3CNzSPiP/UamCX2Pwe+6tsbgTWRhgdz0gp8k/LoO
 6IEkYGVkt1Ox1DRssYWK2gwNdpTJ3IztfV4cZZv/+35pngMQwRldsvDKVKw==
X-Gm-Gg: AYBFou0lYUriuXqsOgH0rPpDIg6+Qw2/pESCmO8+jqTOHLNKAo9vcORFfeC8zh2KogR
 TWciAeZDV1o8SIDhJPOSTEDd/wogoYkk13y31lhg0WFKQg+FBtRH/u40an0j5/Y+Kv2pZPFmpr5
 R/tVRJweFrvOfHXXRf95biG1eRxcWNnIw+RlGc5iWtW6OButjxHVe3JepFrfV++0j1Y/WkOQfH0
 WgRDLXoZYPwrUKkexeBB0gL7+FbBMCkg2L3ezNLfpFwcPrAMWJ9EdNjk7lJfnmLJxSKKkNJ36oW
 8LYHPGy0xwsU/bejbDzJ2vAYhYt9aHeuO0OFgmiWDxJfI+YTOgMoCAiIPuWA6M7gevRwgUL4GIu
 yr0z+T4wDz+aJOpANKw7rhCuHiIvNjC64lOAGizqg0Wb3v+klvlBvkoLzI5uOAMQIgTwQUkjJZv
 6ULX8bQmbE2U2enpw0QZzeTkSPawjtrHP8rJ1alwLDcU8kLcKSZhQ1GxejXeiUlYr/TIgMeyecb
 8ueIATD9YwLhGooBVtMS/lv1DkvRBon1kR9sks+u3NvbVXj2WFEFiYXVQ1DOGn8UzwxoUSL/O7Q
 lOVTECrvMgcKgWM8dtB/Pr66tNswVuzotj1/a/tJQ+Lz016+G5JIk4SmSojzRmi3NJNXfgbQqoi
 TEnqdGG5xxZaP+CcWZ8BVNSs5WBqxO7nB2fRBZTvtscM=
X-Received: by 2002:a05:690c:7483:b0:86f:7e5f:3d37 with SMTP id
 00721157ae682-87dd873eb71mr6629627b3.4.1788861070054; Tue, 08 Sep 2026
 02:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
 <CAC_iWjKrYxidFNW9MWuKT2DKynD4OSirA-jprGQ=NJYUxPGFkQ@mail.gmail.com>
 <ap_PgbRzwImsNwO4@macbook>
In-Reply-To: <ap_PgbRzwImsNwO4@macbook>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 12:50:33 +0300
X-Gm-Features: AcwNN1V4r1yahVRyOjtnWClyhngxEZVZF3RY1PrsbxUkZL81DRwz3jwhReCnRK4
Message-ID: <CAC_iWj+hcckuyaMGmEJgNkEow6S4Uv5eqq3YTUtkKQcM6U5Prw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a22be2065af5ac25"
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

--000000000000a22be2065af5ac25
Content-Type: text/plain; charset="UTF-8"

Hi Carlo,


On Tue, 8 Sept 2026 at 12:09, Carlo Caione <ccaione@baylibre.com> wrote:

> On Tue, Sep 08, 2026 at 11:37:43 +0100, Ilias Apalodimas wrote:
> > Hi Carlo,
>
> Hello Ilias,
>
> > On Thu, 3 Sept 2026 at 16:10, Carlo Caione <ccaione@baylibre.com> wrote:
> >
> > > SystemReady DeviceTree can boot through the UEFI boot manager without
> > > going through the per-device EFI bootmeth. Use firmware_fdt_stage()
> here
> > > as well so both EFI launch paths install the same firmware-owned
> > > devicetree.
>
> [...]
> > >         if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
> > > +               if (!fdt) {
> > > +                       ulong fdt_addr = env_get_hex("fdt_addr_r", 0);
> > > +                       int err;
> > >
> > +
> > >
> >
> > Any reason we are doing the _hex variant instead of env_get? Don't we
> want
> > to bail out if the env variable isnt defined instead of picking 0x0 ?
>
> We do, but we do that in firmware_fdt_stage() that is returning -EINVAL
> before loading or copying the FIT (so we return EFI_DEVICE_ERROR from
> this function in the end).
>

That might end up being problematic. I don't know if any devices do that
today but 0x0 is a valid address.
Can't we get rid of the check in firmware_fdt_stage() and never call it if
we don't have an address set?

Thanks
/Ilias

>
> So basically zero is an invalid-address sentinel, never a staging
> destination.
>
> > +                       err = firmware_fdt_stage(fdt_addr, &fw_fdt_size,
> > > +                                                &fw_fdt_fname);
> > > +                       if (!err) {
> > > +                               fdt = map_sysmem(fdt_addr,
> fw_fdt_size);
> > > +                       } else if (err != -ENOENT) {
> > > +                               log_err("Failed to load firmware
> > > devicetree '%s' (err %d)\n",
> > > +                                       fw_fdt_fname ? fw_fdt_fname :
> > > "fdt.itb", err);
> > > +                               ret = EFI_DEVICE_ERROR;
> > > +                               goto out;
> > > +                       }
> > > +               }
> > > +
> [...]
>
> Ciao,
>
> --
> Carlo Caione
>

--000000000000a22be2065af5ac25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif">Hi Carlo,=C2=A0</div><div class=3D"gmail_default=
" style=3D"font-family:arial,sans-serif"><br></div></div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Tue, 8 Sept 2026 at 12:09, Carlo Caione &lt;<a href=3D"mailto:ccaione@bayl=
ibre.com">ccaione@baylibre.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">On Tue, Sep 08, 2026 at 11:37:43 +0100, Ilias=
 Apalodimas wrote:<br>
&gt; Hi Carlo,<br>
<br>
Hello Ilias,<br>
<br>
&gt; On Thu, 3 Sept 2026 at 16:10, Carlo Caione &lt;<a href=3D"mailto:ccaio=
ne@baylibre.com" target=3D"_blank">ccaione@baylibre.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; SystemReady DeviceTree can boot through the UEFI boot manager wit=
hout<br>
&gt; &gt; going through the per-device EFI bootmeth. Use firmware_fdt_stage=
() here<br>
&gt; &gt; as well so both EFI launch paths install the same firmware-owned<=
br>
&gt; &gt; devicetree.<br>
<br>
[...]<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ENABLED(CONFIG_GENERATE_=
ACPI_TABLE)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!fdt)=
 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ulong fdt_addr =3D env_get_hex(&quot;fdt_addr_r&quot;, =
0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0int err;<br>
&gt; &gt;<br>
&gt; +<br>
&gt; &gt;<br>
&gt; <br>
&gt; Any reason we are doing the _hex variant instead of env_get? Don&#39;t=
 we want<br>
&gt; to bail out if the env variable isnt defined instead of picking 0x0 ?<=
br>
<br>
We do, but we do that in <span class=3D"gmail_default" style=3D"font-family=
:arial,sans-serif"></span>firmware_fdt_stage() that is returning -EINVAL<br=
>
before loading or copying the FIT (so we return EFI_DEVICE_ERROR from<br>
this function in the end).<br></blockquote><div><br></div><div class=3D"gma=
il_default" style=3D"font-family:arial,sans-serif">That might end up being =
problematic. I don&#39;t know if any devices do that today but 0x0 is a val=
id address.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:ar=
ial,sans-serif">Can&#39;t we get rid of the check in=C2=A0<span style=3D"fo=
nt-family:Arial,Helvetica,sans-serif;background-color:transparent">firmware=
_fdt_stage() and never call it if we don&#39;t have an address set?</span><=
/div><div class=3D"gmail_default" style=3D"font-family:arial,sans-serif"><b=
r></div><div class=3D"gmail_default" style=3D"font-family:arial,sans-serif"=
>Thanks</div><div class=3D"gmail_default" style=3D"font-family:arial,sans-s=
erif">/Ilias</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
So basically zero is an invalid-address sentinel, never a staging<br>
destination.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0err =3D firmware_fdt_stage(fdt_addr, &amp;fw_fdt_size,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;fw_fdt_fname);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (!err) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fdt =3D map_sysmem(fdt_addr=
, fw_fdt_size);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else if (err !=3D -ENOENT) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_err(&quot;Failed to loa=
d firmware<br>
&gt; &gt; devicetree &#39;%s&#39; (err %d)\n&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fw_fdt_fname ? fw_fdt_fname :<br>
&gt; &gt; &quot;fdt.itb&quot;, err);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EFI_DEVICE_ERROR;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; +<br>
[...]<br>
<br>
Ciao,<br>
<br>
--<br>
Carlo Caione<br>
</blockquote></div></div>

--000000000000a22be2065af5ac25--
