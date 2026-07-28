Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F85C54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 331A760A35;
	Tue, 28 Jul 2026 18:45:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id niRzB1DGkeRr; Tue, 28 Jul 2026 18:45:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78DEB608F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264355;
	bh=q4zpbV08Y+0Lvnzu8YFo/okH0yzYmm+2/wyMPcDGyOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dBUUP0qos7fgf2+GPe44WWSyltKAXUutHtAR2+86a3zpDYpZVdV9AJr0E/uW147SA
	 +wv20hXFeXEnJbVRbT18qf57mHG9rqqScKBbXlxCHYaQPEsdyzklBCXtq2wlc4xKtA
	 5XfEDv1bKP8QTpjTRgdDewMQVw/fobgi5s7/6Zy1ul8XUxYLb7YYWhPd30FfXbpLUJ
	 IxQRc23QR1Via/uwiLVullzjPTIgpaODLWtHgdL8vZFA6kWjPLJG4sI4UDRJR4zVzL
	 hxoGM1J4fkT7Vr9VwznaCMXTGg7is5ZX8mXUAl4Myd6iCT3QTi/9IiIXoWbk+oTBuF
	 Nd3GXDyks5yXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78DEB608F2;
	Tue, 28 Jul 2026 18:45:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF185350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C108E40373
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:45:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2sxlMfepQsIE for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:45:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AE89840176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE89840176
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE89840176
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:45:53 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69eae037da1so123129a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264352; cv=none;
 d=google.com; s=arc-20260327;
 b=Dl1sDWhMWPSlVd+RD4G5y3qe5NLFzkFcwOv8iPWYe9BGBLQBYPoI9QxhcSASdacDmk
 tJ4Pv+PNhk33zClIYykvNhgqtdYphBVuOQ/TU+9hjlF/Lkf+8t8rPUxHsh8hpu/9Cp02
 pkV8qYAbAB2uimE2hVAXXd05Sybgxpmi/EG2qQN7HyjgA1UfW0hoRInRV0XmjDHUVnVB
 5rqOCOPaE3Tyi+yVtd9nEFsTzL7munxP11CSjw/jKqGLMfRhoq6ykFwdxMu58fP3OkzI
 RTdCi6J+0SLoU2PoiCcNZ7bnLSahsAxcw/gM+VyfHaC+NQQrHGvAELjd0ICh2eeAmuBy
 T+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q4zpbV08Y+0Lvnzu8YFo/okH0yzYmm+2/wyMPcDGyOo=;
 fh=BevGJNW5AOKnfy8O/FowEJJ3Prwfzn1eQzuyArZTRL0=;
 b=ihj3thZRJ5Tt33va55aTQHNlNELxH+t7f4+3kxtvOoCeMQPB6Aj8Aj62PuRUjy8FZK
 Fc26VKgqpBdefz8wK5CQwbN3eqVCmdShZqbaVtfdLH6uunPPuuVCpBOml+rT8nb3nuYi
 VMJOhE/qA/E8ONcCvLQ+3ep6uBdI/duTa9HjPDOgyuPV0Ch05biyW8x2QtWgENK6ud8D
 LgNksFhFM/w4TprcKafhRf6OCcJVtUsBQHj18jV5f0oSGZ7r6oD0AlCAd1X2J+4PvJX6
 kNNVm0hhyUoy+GWUMFvCr2TZcPpoZHimPKI/UMoVdnoM1VwkxDNw9y+pHlHCjuQIh4g2
 HinA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264352; x=1785869152;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q4zpbV08Y+0Lvnzu8YFo/okH0yzYmm+2/wyMPcDGyOo=;
 b=k35NuCN05Tl345+LJEMTvg+COY6CglPJs0/W3VAmmZOvuiUfjC+Hi80w54vNOXsza8
 GB11O7UWXZOxGJRRcS8pe+Z/3W59DkOBjDgpmXItzkd/V5jJn8CMavEEW2+cBTBmTjpp
 MxqkLpTADZ/isgRihCiWr492bf8uy2n1zSRGesmk08gVGzN5CClPxzgYGW/wt4iDWUWY
 JFw1bktyfzjSs9pFSd+bb0q3BWyHyYHx4/AmQ2wLjmlTq3+1XlnhCKgwufLHK6aQewzq
 Qm48emX2yrn97pgqNPy308kM/Yo+uDIPpDVsn7S2SRwKUWi/dd8+hN2hp3Rpuh8VBdrZ
 /Syg==
X-Gm-Message-State: AOJu0Yxjoxl76kb4PgFKbkhXvI3XHLzKi4MZiPIaGN2XMi04ZXElFZaq
 48F0i2q0LKlzyG1P4LG45hN5naBIYcHCA1j5mNxOFIJvDggOLshB8XJJi30lHzD2nig3Np1st+L
 mfn2Z43oobZvXLxqIhuZ818ZmWjgYwkKbOqKwE38BwbHjQyOjqtg=
X-Gm-Gg: AR+sD13h9tGxEPGn2cS7UXjz7K/k/VHz5Qw3kwY1CKaCN/nZxNP9DwpSvRcrWfweCHc
 M39VJ+KeOWElqOAZrIGZSSFSnd13vLzmeRWJOaQlo9nuvmzeT3aTh+kvFkYjLA0vpjEz0z5bayX
 akXXY5i2alXZ5bPiX52u1Qm7O/i4PmehH1BkK2Ceg6/HyZT2JosGxSvXYPnRigp2b7+I4STOrDA
 kf56hPL+zVZhOQQYFnejpFlJbXMxk4mLFH9KlAqbemQWin6mTIFYSFZwU6g
X-Received: by 2002:a05:6402:24c8:b0:698:e595:a54 with SMTP id
 4fb4d7f45d1cf-6a034a5f0camr1584266a12.25.1785264351853; Tue, 28 Jul 2026
 11:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784601041.git.daniel@makrotopia.org>
In-Reply-To: <cover.1784601041.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:45:38 -0600
X-Gm-Features: AUfX_my412W4K7NrVdMj0qhh8VmuyB8UnEuozYrfyND1-I05NOzqiaGKk2Q7qz8
Message-ID: <CAFLszTgMxNnShY+WrNXxTwuZ2RMoqXDj7L5f0CofcDwNeehJOw@mail.gmail.com>
Subject: Re: [v3,0/3] boot: fit: authenticate the dm-verity roothash
To: daniel@makrotopia.org
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264352; x=1785869152;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q4zpbV08Y+0Lvnzu8YFo/okH0yzYmm+2/wyMPcDGyOo=;
 b=MQGWkiqUpiw1R2qzwDkYQWjsqYfHG3zVLo/m44d2+DnxCwlw5E3D00UArlnX+e68JP
 29n14TyxE9sFINgpmBxbpivE0+wkwmPyvgzAq2Yvf8QiKjJqKF+mRYdX52d7IT20iJRC
 MyFoma6MTI21pMfVkzQyqL1lblGvQ52r/yrlI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MQGWkiqU
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Daniel,

On 2026-07-21T02:34:47, Daniel Golle <daniel@makrotopia.org> wrote:

> v3: address comments by Simon Glass

Thanks for the rework - the doc additions in signature.rst and
dm-verity.rst read well, and the test fix is a good catch.

I still think we should state the compatibility break explicitly
somehow: because U-Boot rebuilds the node list rather than trusting
hashed-nodes, an image signed by an older mkimage that carries a
dm-verity subnode stops verifying under this fix, and an image signed
by the new mkimage does not verify on an older U-Boot.

The new language in dm-verity.rst documents the security property (the
roothash can no longer be swapped out), but it doesn't warn that
deployed images must be re-signed after upgrading and that mixed
old/new fleets need care.

The break is unavoidable I think and I may be overthinking all this,
but it would be nice to avoid people getting confused.

Regards,
Simon
