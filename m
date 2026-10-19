Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7054CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A060D80FF5;
	Mon, 19 Oct 2026 13:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id URdXq9AM8mo6; Mon, 19 Oct 2026 13:33:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D1D0680F7D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416830;
	b=Kba9lNlfK0MJBIqBWYphFFrYCTDYrs7K3JFScBpdXJl72YaN4e4Sot90arYSokOJo0T3
	 5oc80qQVdisV+U5fgh0WBuwSW4Y0oKag4xeWvkAz7EoJyDkFwOVObkAWcvLntih7aPlHT
	 80J1mbJZRrWgobVXW6CF3RWIRb3nlloywlE4pC3ebIplbMsPe5hr4QV9vll2BWJo7fDVs
	 NqKOeVU5DPGMIo3YP05/n6lNYEDpV2IX+rR6xQO9ra9UJXvb0qRGCfCKJA0csCAYnFwMM
	 nh3DpN0fzn9sxCO5IacmPOGd1fP6BesYjUTG6Y3JnbpK33e3eiFTr8TqF/fLDv9xCqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EkCplBq9QToRQst3/r4iewVVm6S6ZEcafiG6mxdfoTY=;
	b=CqRo/cKYpK5iWBm3HhDE4PUP1xx+iBGrUEC/i3PxM9J/k3hzAFhwNy57v027rcQRgWcy
	 +V0UDbRHiEUiulvjs+vcCDln12yrVt8yWqcqkhdjdU8u13JMiCKI+aIDrZlwSLRC2k2pF
	 uvfTul+gq5KR+F7CCDrGuCfIXTea2fU92kYJlQekhLTTnhOBPJqnn6TzRTqy+j/iSP8jt
	 PA0WBcUledZ/4/L/Iqw58fwufZZlorPY7FENYIWpNK5MCwmG70Ou9qNs4uTVZ/PikEsqC
	 CpK5J8q+YCNft1uWlM4ovu8yX9sFxUa9bJn+dTX1s4hykOcNplyrTtCyQroTt/xJeVQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416830;
	bh=EkCplBq9QToRQst3/r4iewVVm6S6ZEcafiG6mxdfoTY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rb4j/FzoG+2X6hgMoKhc3/ntFQpnooeRbJrSEWUd8FMwlPTmF7klhWuDK/aNImCnt
	 d+CuU3N/+x4rS7A5jnmEeHbvECoG+LQYLMvWrhtwxlG6FUKBJsTEdklwdPmKVb7yKe
	 8JTvaXqLZQVO0IrGRWsjoHdM+1kpj1TO7ktAgITHZDH+th6tRdei27+mUYgTOJO7H0
	 Bu5/RCnjGp/Z+8+W8BX3Ct8z+o+hDRJFbHSezsfdQG048FlL6gUTnz2ekZUxmo2FFV
	 hfNMYNsbkVBG8N4uRiqqOdpoDz618e4jyMy3FcTDWtKW3Q/xGJh1dbMHibWh4n1uXj
	 KvaDQrYwvi27w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D1D0680F7D;
	Mon, 19 Oct 2026 13:33:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 342921AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19747405C8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pJHUiecEBRfG for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C01C405B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416825;
 b=Y6Qz1II4o+kp+OQjHQbdFTONi3UJLLdvAz+7WbCyTDPRLyUvke/u0VjfTR3ZFJ6noCQg
 ttKkVtWLdLxJMiGaJgK7Fw2FxfZaifkl3U52rbVIync2zEVyIarfZlSCPzATmQpI2SXMp
 wUiLAIWbIQeC7YXG2XnFFeUmPPq//WHV9aQhrjyCLrPu7ywt5L7s8KOde96Z9uQtGt1b1
 yMFuTb5ybn25frqvK+gadU1GjsSIDWzn5F97kbkVy8iJOcQNxbsTl2+AoKAUb24ikdWk/
 AURe9v5ImRd/mjE9ZTE23G9wQpOs07BIpNi8XyyxxUK73dxZv+AhwlvDKYfYSLsofwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416825;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=EkCplBq9QToRQst3/r4iewVVm6S6ZEcafiG6mxdfoTY=;
 b=UXFDlsLkLU09STZYPhy5hxpW5hIA1q6gIWH29booyqpPmSeZP+UQWCN9yNa30e2RpY8Y
 V0lbXtfhLJdbIehIzvl9pPjWaHV/aC8reS+Eq9T7Xr8l+3oTe0S0Yf/PA89rniTtSDf+5
 jwUKauJ2wj5vH7ctPlj0EE4dEoZU1P9kP7qakp1gCiPSGJes6WCd1t0ZbW3MUAYkf2zms
 5LgneHQWFxdf4vmUIqPFPjUYyAXZNyQnRQDzZ+piG2UraxSqwyYPicNBfqKc9c6bbwb3C
 Weul94+YjwnVYcPXlj/gOYNrsBNIU2JSRCjzxBdpIt0nkcrtW9ju5o4AMNmVTXk73ow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Id1A1pLn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Id1A1pLn
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C01C405B9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:33:44 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1f31c63ebso5260742a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416823; cv=none;
 d=google.com; s=arc-20260327;
 b=IFNLDpynHF1hqFj5byUSvrcP3UHl00d/PkO3Z+/0kKtnQj+EkazeWpzuZHU65kF2D0
 PJDXZOZrGLOJ0Xp7W3HPUqv9T4RAwonQSfgSf02o/w3Lc97mbgKe4v/JB587Gx2gQ3EY
 yq21tLowo2bzgehqFiIUePFcc6Ma4TrNpClT4RWKq12Uq6Vmge0MRnF9M2GJOKdbt7b7
 XMRb/7Esj6pLN+9028C/5AEqTMFHw88zt9Oi4OiEPPeIxoAzEocZKIldf6YXc/MG4cs/
 KXb0sKz249IR5XaEeg2UiE866RkTuSDAWGlKMwWm9BRm21N6V90zm12cr9bLSpnsxH/p
 lCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=EkCplBq9QToRQst3/r4iewVVm6S6ZEcafiG6mxdfoTY=;
 fh=i2tQHTfbjxCsmvhnoxB9qnRhfzM8iCx7s7bfzE6Yn9Q=;
 b=alNsC5nwysuGSj8UPQ4cqIf6wOTyJmTyZU1oHdaSImV4fX8mbDVg2BbMy7oy4PwDx1
 lPCljkafOykTfQZj0Tx1cZ6tvM3EEXT/Gy/N7eu6AA+TNObc76unFu6lUlE6/p+SIB4N
 0oqwg0rSv0aRV8Rqw67NomPn8deIDmaMeHySnmB9HRrU+puNxYSpx6SPaMf3ltVjTR5c
 RwyJjvVB9tgY3hQ/TLsKdBO+HcwFlmSQ6uj8OKGHXuOQbxnGT58CVhkmhyjJxRF7ESw9
 ZTAsV0IYfZB1bPvhWRXDZuDssAzuQD7n6Msr+GhmQXnqMAPTOYLCcR7BluMKeCtXlmXF
 nKaw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416823; x=1793021623;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EkCplBq9QToRQst3/r4iewVVm6S6ZEcafiG6mxdfoTY=;
 b=Id1A1pLnhtWzsb1bKmqNcl+KB9rhjs+rs17nkhmx3fIgHmeSeCAmpd8ljzuLJMyGVq
 I123qAE5umrT8xqoPBOb7S3PL7A3q0nfdN/qKO1f6THK9FEkOsUTDYC+4sQeIJyLI2bs
 H8tRpSXxmW3boGMSIqIglhMGA9MscE8v5onho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416823; x=1793021623;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EkCplBq9QToRQst3/r4iewVVm6S6ZEcafiG6mxdfoTY=;
 b=zWt11ni6+IN42Gyk3KX3UglfJeFgU+/arKdI7I8dTQSIBaDCT1xc7+aLpWESpQ+czF
 vjjMR1uVDnhEYpiHDBTAJBpmIWdk4ftb/Sius3qxszYWyKz2ViFKD+MD5r325orbS3Wl
 PsOCn6VURXD/UX0n/JVQzIn2/mHf8q9pMMMAvgQ71VNaXyj9LkXS0gGlUHBLzfu+MbiV
 OXj8nmAZv08GsH8nhn14S4SSEKTIHN6Lh1bPkJF1oxzOVMjxHBdBHFydYTFVOkaeCJKL
 1DbVE/pT8T5RR/UYGk3rQ4fMxJgL1j+VZMSoEjFYcJH7PhWoo/rtZ74S/8yNzjefntZ5
 EWqw==
X-Gm-Message-State: AFq9FYLl/1ze4KyQs2o67peSLdYbRR2dLGP2E9pkWO8dWj8J0suqpuV+
 9gW/qvJaoIP1ywgWsc1HMvN40ZVp+VYAcUcLLx6CrP1k/U7/BGe5z7lsYVsGA2iRGGF5c7IbVrS
 P22a/vZu4Wt4d10K3qHQh9zyVeyuO0fh2w+hIHer9
X-Gm-Gg: AYBFou3qGrbT/MuGZfGvu6dGXbjmwDGY//OuwrcKSMqsivvkG+hGzFDiDTOT/34tUXM
 uIBuGY94Upp/QwKl99K9RBI9Ws9OD25PxUcUA2YBrsBCJHsK/Srpcwn/p27BaKAqIVgDfOML/c7
 MR9NaCrSMBktW9MTU5f3seeRn7BBcxW+CET34pbZwNxQRG2OqqvVy6Pifta23eTiqxgF9dko9UG
 bXwUG6bg1BCDIj4nU1A2ExVbGRn6anRsimUVxSL8J8DSMdPCkPwxQbi8odHraJDpiKkZQr7mQt0
 7Pkxk8ph+fwHPxOLNYqoNVpG4YqhuVb0UU+vEBiu+56z5Zyc1JrhHQ==
X-Received: by 2002:a05:6402:510d:b0:6ac:7d58:dbed with SMTP id
 4fb4d7f45d1cf-6b3a8161907mr4400673a12.3.1792416822684; Mon, 19 Oct 2026
 06:33:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:33:40 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:38:01 -0700
MIME-Version: 1.0
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-4-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
 <20261016-ccaione-upstream-fdt-fit-v1-4-f6286ef82364@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:33:40 -0700
X-Gm-Features: AclHuK8Gl3ooQGWbvjGdTKI_un66TH3hySBea8l8da1RAQE14tf8RnleCXakDik
Message-ID: <CAFLszTgn3o08Ea9BiVi8m9MHqSwe2y33rF3o7zZJLz5bVETK_w@mail.gmail.com>
Subject: Re: [PATCH 4/5] cmd: fdt: add 'fdt fit' to prepare a devicetree for
 other boot commands
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 David Lechner <dlechner@baylibre.com>, Ahmad Fatoum <a.fatoum@barebox.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-16T08:36:59, Carlo Caione <ccaione@baylibre.com> wrote:
> cmd: fdt: add 'fdt fit' to prepare a devicetree for other boot commands
>
> A board may keep its devicetree and overlays in a FIT while booting
> a kernel or EFI application from elsewhere. Boot scripts need a way
> to verify and assemble that devicetree without asking bootm to boot
> the FIT.
>
> Add fdt fit to prepare the devicetree described by one FIT
> configuration and copy it to an address chosen by the script. The
> result can then be passed to bootefi, booti or another boot command.
>
> Always check image hashes and enforce any required configuration
> signatures, even when verify=no. Reject chained configurations:
> signing each configuration separately does not authenticate the
> combination.
>
> Only copy the completed result after verification, overlay
> application and destination checks succeed. The script remains
> responsible for loading the FIT and stopping the boot on failure.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
>  cmd/Kconfig           |  9 ++++++
>  cmd/fdt.c             | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/cmd/fdt.rst | 75 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 167 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
