Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AA6FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B10A8466E;
	Mon,  4 May 2026 14:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A0Z9lo2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFE58466E; Mon,  4 May 2026 14:17:25 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE99C83EF9
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so682280366b.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777897042; cv=none;
 d=google.com; s=arc-20240605;
 b=EIv26r0pCFvgWetk1+SJnfkTbrsdIlfDhMBphoa8ATT5swsJYQNm8wVhNgKBtK73mF
 GVq80Lo+z0hfyLlts002U0Agd7fYiXbsfKWNAYjIfmDm2pGcnrYOjWYPHTbQEz0JEAlO
 6nV/ET+CgGGfld78KRGulZgjBb6kkPv9MY9NSFA9pJOuo8ZrCvdd8qX8eTRxAx69Zm47
 LrofIfCWCeMhjy7tzgGA7+c7P3k1KyOPFKRkWYHaZHHn8sSeFCZ2tJReL8wy0PS/Pzaw
 aMt4vagqP92PNtilLhrG3g7uO77q8rNiNqxHdpFVw1P6wfirVmTti6UR2aIE9/iWC+XN
 MX6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=emvUuoS/uEHd5r2YtpO/FqRYCxn8H5B+JnhnCs6U1PY=;
 fh=Yqo3kvyYlhf4BsICGWzprkFwRdlHD4njc+N+xidygHw=;
 b=S91Tn1x4rSlWjgoLiSoiMmdbaB6yxe50Wqg11e4R0AAksHg6U3tVDC/ZnyQxU8A9MS
 yWCNTJzN1FIIOOqIDKzbM3+Bl8aehSFIUs5K1CZ8wi0ZE2VXx0c7nT5npGpVNXjCMJ/v
 U4NNiuu5kKbF0pXi1vxfFhcF0dpMZOUtdMgAUk1M+z8hC6Wv/PUS8PAt4gEFLm1yS3m/
 pzQKX9vFqLTJwiPOYKrIlt0N1q5bweDRDecOhnhCqqmqfVvo2C3WCB6tgw4iYUEyOKWE
 kXeA7lGE/OQZEGDmAbf7jKZdxDqIRHmLbng4o9fDKBkiUgLUHco7NDPL0bnJaqMNe4N7
 9ZkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777897042; x=1778501842; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emvUuoS/uEHd5r2YtpO/FqRYCxn8H5B+JnhnCs6U1PY=;
 b=A0Z9lo2Daw5yvk157pKj2viHexXkB0jM0f/iD1YHrGRxEp0r2TaUac7ulWwuowy2ZT
 sNqd6h3if3aV5D2ouZrz0ksoQTPoNnNL7Atp1N5Lwp1VeikumpQH3IMiUtIAWQo3KEZf
 P0WtHsiHKHnrwiGysp/v5yARykxalqqtrQgSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897042; x=1778501842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emvUuoS/uEHd5r2YtpO/FqRYCxn8H5B+JnhnCs6U1PY=;
 b=bD3t+Uj09cAmr1iW9w4b8iBgDeESkyX6IR1wozjTXYVDMfdFRkGLUUrE9xp68zOVQm
 aQTrvIOOC4OPPL393DGR0tPBNSNGhkUOU1ZbQmp8ogvpHH4FkCXbQqJUQll/a40P0Rq/
 nWW3HOxvqPl/K86l7dDsjjUT9xRsZP1uBKrhU8agYRUQTKzge34naZOHGjcSYRb5lBjV
 pvQ2hgGkMvKpNdl3jHSISbxyxSCGTkdGydOG8KXeduh/3XVZZk4r3UeuG6eZ69dll/IB
 HeRJpVkHRFGMztFDt9o7m9G69dCigwPEyoWCIMhmagYhhmGuLDStS/MbkcYYhvjXCd9g
 M7HQ==
X-Gm-Message-State: AOJu0Yzoyqzm/EypC/yWRhGM3rQXhOX+ljr/ZwYkTsrjNiDiQqBB2TgI
 xS1GH48yREJBmJo2f4r7h46MyGxEuJt/IJO3TA1Um/0CyhDhvXcXwBnRQVwZU51mHI1yWMUS3+m
 PFtTCX9WCgQtGlJo7cEmtW60gXDxxLIM3urMdZ5PN
X-Gm-Gg: AeBDiev7eJW6KKpqdNwDee2fqsHoTSRI8n6j7rWPPyh1EPYHV0hKOlimsKgdx9cP4PI
 l11EwCgLWncW4zkMNzfBlPl2VmFaYYbgU31mGHxKjpIZRWZBOVCgfPzfs3IbYqlD+euFdnQZo2L
 PloRONjjH0/meIzLtDPSdOocYKtLWscFIue19faM0FNTe6aYsfh2AzLZkD/nrG7o60JzDxx8dBm
 jrhyHAbWaGtgYpspuZ3VSYT4rIPETgubq70CcMT1esd0JUtxe7Hgt3MLS4FdzQvsvAP/88zO6m1
 +ZXVwoHeFwhdBisExdGr4Qj5/GU=
X-Received: by 2002:a17:907:70a:b0:bab:dfe2:5472 with SMTP id
 a640c23a62f3a-bbffcb7cd0dmr483581666b.41.1777897042121; Mon, 04 May 2026
 05:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:17:08 -0600
X-Gm-Features: AVHnY4JmlooiSuDgC22rdZ4ssqTb7z9sPvZYj-5B8kxmWf9KPsuoix5b4VMO0So
Message-ID: <CAFLszTgLkxDgJ4w-VGr4oKRjc-99UF19ntzJUES48VAGJ4V_nQ@mail.gmail.com>
Subject: Re: [v8,0/8] Support metadata-driven A/B boot for STM32MP25
To: dario.binacchi@amarulasolutions.com
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

Hi Dario,

On 2026-04-30T08:06:01, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:

> 1/7 lib: uuid: add partition type GUID for extended bootloader
> 4/7 cmd: part: support lookup by UUID in 'part number'
> 6/7 fwu: add helper to get image GUID by type and bank index

nit in case you resend: the series series is now 8 patches

Regards,
Simon
