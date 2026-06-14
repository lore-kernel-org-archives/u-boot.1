Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A2CCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC6183FEE;
	Sun, 14 Jun 2026 18:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NtgTToCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57E5784704; Sun, 14 Jun 2026 18:16:07 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F19A83EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:16:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bec354815b9so225831766b.3
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453764; cv=none;
 d=google.com; s=arc-20240605;
 b=koFSPe3FETSIGWZ7Z2iWnltgdSknexiQKyJkuk1r3LH3mFSKlfONy+I90k7jnReW/Z
 uQ5nMrapgn3l4xHOGBvIeGZorVPyaviF1LGoBnSP2Olsf0YW+vf6nQIGvG2ymIndDK/M
 VWDu1/iPhCWnZibdXPEuNmBCgJ6iJYXCB2GvXMkBErAOmC4K1HCFFc4md9w2YU8I6KbZ
 c4NqLYhodnhVIx76PMOirV6Bl2EH3P5Jrz/l0zwqW9cgupySH22apNVqxRQYRe/kmhhe
 /GSyINAdhJ/tsF1nX+K0FEXtecshdd/RvTg4LvpOmNrDzdUCL/UhVlmrtAOWB3qrhOuL
 CWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e3ha76n5L6AxpGxPT0K1vlYEQ3deyY83ix69Nk//MEQ=;
 fh=rLQMN6a/UX9jMmUsQuTe1A8wK9bTo6tPxTHfkaExRTU=;
 b=iu11E/liE27CMpboUW1fU+XsktT5Lw1b8H8hNpPLGrPerrU1tZzD/jA2x3qHsCunnn
 c8iC3DpA/pw04QPayBOaPPGrSWXYcPKBodOPvPyayCIySfLw7VxdBY1TqLCNim4AgMXC
 urPFhT89yh/UmTMt+asnLGgQvvoXIMkk6jrWvaL+A7ilA0gv4UG8l2QBDto9eAPzgUn1
 XWYMiotHmOGJQn9kE8IwzUyI5vMIBuZWIxfiawWt7GvxYDd0xJn2x3Da+TJpOIspg+CT
 BYqORBGiLCKvRES89wKqfYFb5cyndtSpjhKctWEASvce18r+zv2d59nueyOrfHJ3lAXV
 ejNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781453764; x=1782058564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e3ha76n5L6AxpGxPT0K1vlYEQ3deyY83ix69Nk//MEQ=;
 b=NtgTToCkLV/3kcRv/77fWwFsUclQjrcG+3OPBj6ELTyPwo2eQKTxiMIqxkT7Kh+tSa
 ArCKeEpkkT/DhtJQGFSn233BYHHbLOxVWoEilMgGMncmAUrGzZ9Y5txLW5Vn+j/6MLoZ
 44oac8oqq6dOOnfCJAWyWOaFxZ9PdSQ8J439U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453764; x=1782058564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3ha76n5L6AxpGxPT0K1vlYEQ3deyY83ix69Nk//MEQ=;
 b=iE3Png5howUjlmvOPkJ5SDnWWRGWbCT7lqaET1WUFDJU/Pkif2e7neiorsejQMSanJ
 Qtnqr0Jr3gn/mx5+fMX0y7feKkd9JrDK7HCQxInK0vkvbGZ0TDUm5Vswv45r4suP2vO+
 hMsjZNK/3eLKFBBCXAjcw5byJ0hXvLuCtz7cyxPaOFP6szi7dwGceZSZLi9RwrwaceC6
 i67DI4fBkDXNOMXBYJGr5wFWwsItdNRTYgZ0/tH5utkr8X1Awrj3y9v15OPeCiVHbx5i
 KE8etKzraqJlfCORZBv4hNWt2aX7wLpFua+LCcSDr9DL/KxYN5RFzf9VtnFWB6glG1n7
 UECA==
X-Gm-Message-State: AOJu0YzqHaVI3qLYwIYwuGqozMQerOHn3+iZBtjytvNxL5+7vW6yw3uu
 MfXioBbfgo4DKqrPcCMmOF/ECD6x1FEQsFfr0JtPni/cQEDSiFwkmMIMXY4uu9dZWOZz0dY0Kvv
 bK0qJJYFM0+4cfFEVBYbIxTekEcrBuFet4iAJiBAdmke6N2RlVL4=
X-Gm-Gg: Acq92OHhztKyfZZ5f/ZeGC50jPK+OWv5e21mY0zsK+tCJuxRoCFthxU1EjmYnThraKt
 ef90B2G+helgCM53CTkoHNUw9Fl2ORTCtRiPr3UGHAZ+nDDHCsgUJkRpZgpZaxPiK/4xhQRmrRt
 6ONUD5Krtah1120a2lVUn1+3PMNRbaeF0IAHAClOO85lptciPOfSzdRFiavn00E8sNcOtUFa/8l
 7uu+hbQC8cte+79ReskAiDRHASV2VTpwq32nKCfUrQWEKwTuY7am/8TWnzA6JT1J55wM+1XdJYd
 tcr/aA==
X-Received: by 2002:a17:907:7632:b0:bdd:f2e9:37d2 with SMTP id
 a640c23a62f3a-bfe29328b50mr309631366b.33.1781453764430; Sun, 14 Jun 2026
 09:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260611014843.3735672-1-dmukhin@ford.com>
In-Reply-To: <20260611014843.3735672-1-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:15:52 -0600
X-Gm-Features: AVVi8CcR6wy-Ct12DfCuWognTqQ94uCMhUOa6IJd8P7ZlcyIADiseUIeCO3Y0rc
Message-ID: <CAFLszTgfVVW_W7OaRZsUrJH81yd4QsGvVzeHh9n=P2xeO2iusA@mail.gmail.com>
Subject: Re: [v1,0/2] bootdev: few fixes for automatic boot
To: dmukhin@ford.com
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

Hi Denis,

On 2026-06-11T01:48:41, None <dmukhin@ford.com> wrote:

> This mini-series addresses few findings in bootdev code.

Thanks for looking at this.

Patch 2 changes the bootdev hunting behaviour, which is covered by the
sandbox tests in test/boot/bootflow.c (bootflow_scan_drvs() and
friends). Please can you add a test for the new fall-through: a
high-priority bootdev whose hunter fails, followed by a lower-priority
bootdev that still gets scanned? Without that we have no regression
coverage.

Regards,
Simon
