Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4E4CD4F48
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 203188467A;
	Fri, 15 May 2026 15:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fnfOOTFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4A6846A4; Fri, 15 May 2026 15:33:20 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B8384676
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c801d732058so460308a12.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778851996; cv=none;
 d=google.com; s=arc-20240605;
 b=hOiMYP7vPI5CP/DZIdWn3EolMjO2eeROoGcJu17iq6jHsjNsuHMtUToHHLlssImy8T
 snwlEi3YMadvNmf8r55ekdWAmFHthLaDm3g7sRHP8oGIy4k3HqPNHWOMKmXPn/+zLCgC
 uOvsLABv0oR7HdoNzCevxISsS/tLySkOn1dDo6d5y0sa0T4iSu4T2gr6idJxHrvNGtRn
 5SiuL9zdHcUFVd4iAoebHV6KHu1YIyaij5kP0STQvQJ9xlgwdmjf4hubh3vvyVI/C/ZC
 qK0T+UXxHDhNmaIRMa0CEmBZa4Xy8KmC5wUcUB8wCY+EyWETUtuk5u77QZvT+OLzYnJ7
 Qezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AIgf6GA6T2kECzqosHZbtyb6rZwBXDOE8oL8GvOsOf0=;
 fh=is6TKv49MgERBAcyxHwJilOvaFSawPXqsCYNk2VrlTs=;
 b=GiGlcA6DH/eMOmjyY+dgGZ+w9Y3+g9Hkime/dhBGyhd1+5Neq8gXJ2BWutNl+I8PND
 Le5vWe62JopEFcSPzkdw8uxJUsBn/A5D97oVx0TBX1TAjA77Q4Gr8+V3tusDVB+y/cY0
 a0VvdsLNfrePhDVr4pOFoebsQ45wzSYEHmU70WX62LiFJ5aUVBUlOzPoubRLOAOtXPhJ
 RJT+et4fn2g6rBi7g3yxpJbzCn4HWRzPn+Vj/uVTe1L9nl6U6Hu6w/UEN+xySGigPkyz
 gYFQmglfwBU9NpEm6cY4U7IPMATJC8vPGlNGm5G7uzJkTg+TeHljIK+gH5WwVbwCAsID
 msyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778851996; x=1779456796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AIgf6GA6T2kECzqosHZbtyb6rZwBXDOE8oL8GvOsOf0=;
 b=fnfOOTFBHv4kQfoipXY3upF5AEP1GdnMl3x1s3FSLD0Wxo3Z+EpxVceB7Di4u1ZPcJ
 BdYhCzXZ7jniIEG5TjZbEwpgC1Mx1TGsc7Ecrks1tN/zlTkQXfmMbEfVGwlsp88S5E7s
 eb4u0PAeKxfZ025sa3nCkPSd0UHaBeCwZ7K4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778851996; x=1779456796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AIgf6GA6T2kECzqosHZbtyb6rZwBXDOE8oL8GvOsOf0=;
 b=q5FIidDz5M6mORgFhQ2F9H+hvwio3iIcTxcU4+rL4VIWj3N9OwAvOq8dPkrkR/g2OE
 B3vPxZvxLcVkoLp17W1YlrcU1Ntbfoh7QCXHUVIVtNdXqTeYQrGOStBGE/m4Axl+8j3e
 gF2JIvA8bbzJbzxeTCrYzHKVEf+OwBKD3698jXCbkNlunSOVvPwcc2xte+7NQboc/uEv
 K17Ln5hNlqIVrQK0jZt+RxKoYTTwnFXIn0938lXOoycl5gVu+S0Z+gqRtlMD7wMaY/kU
 pWfBMqw2atwzoTH2Dc4F7S3A8NO5Xiz2Ycx9jSdyr0fU/8Lfc/+FRG6qZH00DDORUy/h
 yvWA==
X-Gm-Message-State: AOJu0Yx6ozcyVT6Kg+YqjXe0NzRPmQ218pduMgfb7oISOVXA42DICdsB
 NsMw933aTcB/BHZb+s3OfPqUAixrhQM8YIH8EP6VzTWgJV+M8Sp0y2GUXzjiZLRR7MHCwrEL/Ci
 N0C7dkc8zLV4L9r/O2dszKa94RQ//9TsdIG+ozg65Wui+UYBP//0=
X-Gm-Gg: Acq92OGCqBodO7AZIKUkyXJ+zghZInZRn1Wq/JQNBTJo4RWwxvf2fPTcc5F+Gv09k6G
 WZf8xc7wBiD5/Q06u064ktYuor9SaJzkWF0m2PZY5PsSbPdD0G9pFp3jxN02mrR2/E8r0BskBKe
 9w3s/4eIdhgjEpwc/3l4+I3c6309CYUrYOTJVG+b4VmzlcUqtWnTzXm3boU4bLfX8XAg+HuFrtj
 MMm3PUbEpc2Okq4o/x1O8pfVKpxmpN3K5+Grz3/UC4uzF2neWjbx4o9owbd+KAAGp8N98rqqnN5
 LFgr0w==
X-Received: by 2002:a05:6a20:12c3:b0:3a2:c7e1:ff93 with SMTP id
 adf61e73a8af0-3b22d16984emr4225268637.8.1778851996613; Fri, 15 May 2026
 06:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260512161631.284143-1-ravi@prevas.dk>
In-Reply-To: <20260512161631.284143-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:33:03 -0600
X-Gm-Features: AVHnY4LMGkH0pWbboIPPwWAyQ_r7sOhwAR15u0LnDQzPkgoCO0xSNL0eAybpCEU
Message-ID: <CAFLszTisVttLYAOt5ZTR8un=MUMFGQ1Sa_sZ4UHZsTvkXK858g@mail.gmail.com>
Subject: Re: [0/2] allow control DTB to double as "FIT image"
To: ravi@prevas.dk
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

Hi Rasmus,

On 2026-05-12T16:16:29, Rasmus Villemoes <ravi@prevas.dk> wrote:

> RFC: allow the control DTB to act as a FIT image

Thanks for the write-up. Makes sense to me.

A couple of series-level concerns beyond the per-patch comments.

First, this needs documentation. The control DTB doubling as a FIT
image, and 'source ${fdtcontroladdr}:foo' becoming a supported idiom,
deserves a short page under doc/usage/ covering how to set up
CONFIG_DEVICE_TREE_INCLUDES with an 'images' node, the constraints
(script type, compression none, etc.) and the security argument from
the cover letter.

> I am of course happy to put this exemption for gd->fdt_blob under a
> CONFIG_ knob if that is deemed necessary.

Please decide this now rather than leaving it open. My preference is a
Kconfig option (default n) so boards keep the strict
fit_check_format() behaviour unless they opt in. That also gives a
natural home for the doc/usage/ page and makes it discoverable via
menuconfig. What do you think?

Regards,
Simon
