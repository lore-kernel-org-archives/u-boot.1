Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B9ECD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:08:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7409683CD3;
	Mon, 11 May 2026 15:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QMVh/kWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0089383DBF; Mon, 11 May 2026 15:08:19 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F390800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67e9b3037dcso5793474a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504896; cv=none;
 d=google.com; s=arc-20240605;
 b=NHuQkyXA7NWJU19IL5p6lVsm21VCH0s0mSWgpcsudaatLhEgXUJ+J5GP/33BR181BA
 0jG4jbZ/+0yvlQ0v6/MofWymeEkurM+NFYygWg3VzW73ZxnUuqe8XnSAo8y5FURBmsbA
 utspLGJZGDr5r5h1aRA4CgIL10YiV/f+3S9qCU5wgH6JLsko+dkMP1z0VN6kKwMlDGoS
 TugQgexgQfAwUNo4En3SW5S9yF7v1eDscJc2gNxam1azPe0l2PGevHEoMD89oCUW5igI
 gYG+i7irT97Q4/v4NeknBRP43mfcXkZ9A8MMzk0nbueyjl0FwkXYu+zFwveTiTwvdEpd
 KISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1kkFDUDxIVRrQBRxiYvGTiR9fNgUEQS68C7jVNasg7g=;
 fh=DHWba/x7tuoorNirX1jlfatUYioWd7qRviNee1YRGB0=;
 b=GOmU2p06Anea6hMGXY8j4ry6zWCwbRFhG45OpvB8eb5mlHKpanCYUcLqI8GFxGmpGr
 HeqREDgtcKgzvxIIr6BIqYsC2fEI8/lGcVmguc/cgyXtPDL+oVDtvhs0HwVIsWbAkBPV
 iOX5RkP5swajeeOM4nTmYX6HcB6NScv+L4tO6Xez9csj0eKAsN74hX9mQ9lHYWAJTK5r
 PSupMdEL5Go2xPe08cxct2FmTVGLLskJgjON1fEi2DUsPnHsEkT7LwtFMYMy5RW/6ENE
 dA5tZ5Uj2QXgRUsEfoesD80FPYFoc2B1qFT8ZI+X3F3EAMb+pmsDYJvWNfjuMRPZcubG
 pStA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504896; x=1779109696; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1kkFDUDxIVRrQBRxiYvGTiR9fNgUEQS68C7jVNasg7g=;
 b=QMVh/kWfYex1gNvrfJ7WMxeVkUu29bp2vayXeIWfxESspA6N1UVSUJtjHrlTSpmo35
 D9zodwv54ESBPECfil27XH4LlLU8lVvgCUfpoAphm0DnLYAthRN45N7nrSHDCAP7DAgg
 /3cLTbZi0UvZrJfOynzetue5dg8zq0aiDbH9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504896; x=1779109696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kkFDUDxIVRrQBRxiYvGTiR9fNgUEQS68C7jVNasg7g=;
 b=ig9SuQPAHPiW+HbPKsSnEIhXhsvFcFRnSy24xX7o6+yudzgVqR51B3SrmxSgwC14jF
 aY30PBBr/174VcViT2+ZpSzYJF7CKQMYIB78DUPxx8E/u5xlJyJR1LEDGYGS51K5DEhs
 C8OyPkFbcoV1jH1vDrgbO78Qp528Ord5sxH7zn9A/f16B/qndSWAxgzcxVEX4kuDjWKw
 K9jBZwziSrwNBWXlM8uL0dRcEJspJojgABHSpxFzi4gZn2BhMQDQMlX22QX2r/m6pej6
 JiCmjOp1dUAcm+hSCIJOqGpGiuRtXXwiBHapDDE5DD5ydnu+TCyBW9maz7Yv8LvUsDF8
 Hymg==
X-Gm-Message-State: AOJu0YzE3dIKeYNRXeYrZrOQi0ALH71Moh1AA99+yS6zNQxqbpLGh/hI
 fwm3TiR6BDqs9UzSgpSYcQlKBL112m74apZAfvbuzFSMCSaFVmZIulI+ngeevyKZIlIay+wnbEi
 ORZkU9pRY1w6Mja6f8+0wyBdLqnJUbeEOxBYkKGAS
X-Gm-Gg: Acq92OHHSBitbsAgVzrjjFDuLlZ1+TsGTXvINobYAINhknzpubK5bX++S0aVaJd1eEY
 Ah6CqdUoeo6i24pyC52aZtbDAnLGNKTa8Htrt5otPESRL7e+sMVNe4ePSBqY8t1k9BsRcGY0TLE
 6MRUbScFrG/+rUNhQCEKD0kHuXEWncWLqSj+JadZ7e4atM3qqMqH3+lpRWelPRbX+9z7t4OuC1z
 fHMosC7GYQG9KUVDw55SCRGufnbDR/z57oyc6qPi2G1KfvQwlTH70uvexqyVnGR9LMqw7RvGm0W
 Wu9HRA==
X-Received: by 2002:a17:907:983:b0:b9d:e301:20db with SMTP id
 a640c23a62f3a-bcaabe36334mr788412166b.25.1778504896416; Mon, 11 May 2026
 06:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:07:54 -0600
X-Gm-Features: AVHnY4JtgwqSXiPtA7TaTJVHKf531KAvzdejCuUn-IobiaMlQslnrVnPGjws_pI
Message-ID: <CAFLszTiALvNXSTZb1C=oaUhNYtdnLsTr77gL8AR_DtbJDYz1yw@mail.gmail.com>
Subject: Re: [PATCH 02/11] video: bridge: ps862x: Staticize and constify
 driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: bridge: ps862x: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/bridge/ps862x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
