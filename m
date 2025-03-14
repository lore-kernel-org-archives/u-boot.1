Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFFFC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDC181E1F;
	Fri, 14 Mar 2025 15:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lAUzBz6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B6581E14; Fri, 14 Mar 2025 15:44:22 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6B081D42
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-abf3d64849dso360935866b.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963460; x=1742568260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VS0Kve83MZTr+llTZtrmSpiATDFCY7Gs4XxciZqaW3c=;
 b=lAUzBz6D8DCiQOro7MENwz0yVUs+SlRidIfMwwJFwNntlosSxjU1M/awFSvFki6Z1i
 tIVkjwmyFePf7eERzveMSu1yp7fFNbrgWFh2LAsu9D2NsHPMcBky+ywJetnYbLAHNwH5
 imIH3s1eEbC2Xu7HmVFUPZ+xyXmeVVE5gDFKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963460; x=1742568260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VS0Kve83MZTr+llTZtrmSpiATDFCY7Gs4XxciZqaW3c=;
 b=RqNTEfdKgyITrT9QoQcvQpFzp2Gh4o2QFiEeJf3upadG20WU3/jGPmVtndfTK8RhdX
 s8pTz9iDlVKZmgly2tnk4hH21RartVOrXhPdGy2cX2UIqbqK4l7XgdEUt2dDJJYI3ajW
 BqgbMXkndI+ER1liZ5ykqfh1/Ieo/3yxUYxUsLV1J10SUKfa8M818zCpVMcEhuELBULH
 L6++Rd1z9BDvcR1Ls3zwi7HJf9Hw1qi722dh6B7h9bEN/OBQxKyfjiOiUg2z8uxKjjHD
 ZszXlONEvbE8mMNa5Lsn8Dfxprcf58uJZAruPZt3Q0A53SBp8+H1up8HWVT0YApNOJB+
 7bXQ==
X-Gm-Message-State: AOJu0Yxe/kTai29RF0fKdARDZtcz5/ZwFqkj3C+kHmFeF54hYPkzvvXw
 Zdr+yaFi9pDa3v2x2l1sykzNKK9ks43T8IklYqIGLcsrqM379MABPrWyVoFReoJpYxC9aAtr+No
 VMoh73h5IHBx5gmkDCHx7kUEx4F82+onPTJLN
X-Gm-Gg: ASbGncvfE0NdlDUIsEMf3cb3rqWo3rCdcgMr7QeR07pk3aMDkp7OEu64UDnLOYZMEYX
 mAaiu6X4+2J53A6c4TkCxfOs/SvirmjYXf1wSCRFcWh9K45DUQYA+5CwcEPoMH0s39VSWZlQZ1P
 B0LAfyB7iZVei5wv8vIh2/zZjVFHRN
X-Google-Smtp-Source: AGHT+IHd1MrBTZUGEtcsrJr2stZXLVkY4neLYbDVbIVAyXiFHUiWqupoYfdCyul9tpd58SaOjhl3IyFpukugn8YAOHQ=
X-Received: by 2002:a17:907:3f9f:b0:ab7:6606:a8b9 with SMTP id
 a640c23a62f3a-ac3303f75c6mr281605866b.42.1741963459903; Fri, 14 Mar 2025
 07:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250306160428.3041057-31-sjg@chromium.org>
 <20250307190946.GU2640854@bill-the-cat>
In-Reply-To: <20250307190946.GU2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:44:04 +0000
X-Gm-Features: AQ5f1JpwOU5G3I1obZcW2d4H9bCmgObUtQyhMK9sFYm42_9ufyn-ORLknFdRku8
Message-ID: <CAFLszTgdpsURmOpYTMMuqsk8eisiTmFi3YZucSeYevLTYsGk_w@mail.gmail.com>
Subject: Re: [PATCH v4 30/47] test/py: Add a helper to send characters
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

Hi Tom,

On Fri, 7 Mar 2025 at 19:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 06, 2025 at 09:03:57AM -0700, Simon Glass wrote:
>
> > The existing run_command() method is not great for sending things other
> > than U-Boot commands. Add a helper for sending arbitrary strings as well
> > as control characters.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This seems fine so:
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> And so that it doesn't get lost nor expand this series more, an issue to
> cleanup the existing users that would benefit from the "send" macro
> would be good.

Yes:

https://source.denx.de/u-boot/u-boot/-/issues/47

Regards,
Simon
