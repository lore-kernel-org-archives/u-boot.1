Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928DCC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B1F877AF;
	Wed, 27 Dec 2023 16:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QjIr/aem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FE287956; Wed, 27 Dec 2023 16:19:52 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C944F8775F
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so4096353a12.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703690388; x=1704295188; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9S9vnAs94vQEoJGI1wp4VnJTgMRi2BuIHyhx9+0C9tU=;
 b=QjIr/aemW2805dpq3Vrx5IlcMr088zp1DAcrxojL4Mc8qr3g4V6a2/3Z/OAfuhkWuo
 06fo4B21WTmaA/VuzaLPN9jpqzVbCFwfdOfpt8PTOVSS6roldM2DNk7jYOeZJP/6bztz
 ynEdU/D3DuX5/15Xn6nb5Ba99Oh/usKX86wc3EeCXQY7DDVg6cPpSMaKetuwK/Semzl0
 4KTXi2dNOySjm9RRqxJE12wteKMfC1rUqobw9pPSzZijiqzXZ+oo1uj2v+sB5QuKsc4B
 db3T6hs+F1f010LGXTBHq1lYyaV49HFjDoJM+UIij91I6yW7nuF4nHU6zCl7XE5sW+FH
 Zp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703690388; x=1704295188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9S9vnAs94vQEoJGI1wp4VnJTgMRi2BuIHyhx9+0C9tU=;
 b=A8UPbFvW9NHq3vvsxUteGzWpCoGo9R7NQre82GiEJXJ04L9fEPL8k2cAaQ2L5hCuR7
 p4xKa4w3hsG3eNv7c5QUbDCHaogJ00siLw6Rk85zuksZgIDoWPbPZ5n8XB0OyavDObWs
 25PRY1+LB/DKtw/VJAoU6WK/eXwuzRBE/cwVvt14ZBA4BIcL6WCE+J8fXKwy9BIrijU/
 M8DF07ptNP9qwNwLMNtXMPEgGw9g8QrnptJdF0Ra0PcsXMAKXojwwmU+N5k90VSYbZcL
 TF7tRAIfah2ifZQEWBG6tLIVYhN2zNabXK5VbzSWN1J2+pwnC70eHpIGpvX0JkZo1Uko
 2GqA==
X-Gm-Message-State: AOJu0Yws7uOSIDDSOG0pInLFIaBuaYzclIx6dZyMDaMYkSIA5c85XyXK
 1lhfrGQgzi+URvxfnNevhf4aKoF+UoAvR1d++2C3b8s5Vf2Ftw==
X-Google-Smtp-Source: AGHT+IGOlTl+JMrG5pV/MInzZajdnfyUyXFyoqEKM26tFMKVH1jn5nT77i1txrGQ+C6bJEdZJoGDLz735/0ErjyX44o=
X-Received: by 2002:a05:6a20:9191:b0:196:3c48:e11a with SMTP id
 v17-20020a056a20919100b001963c48e11amr233977pzd.104.1703690388127; Wed, 27
 Dec 2023 07:19:48 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-3-raymond.mao@linaro.org>
 <CAC_iWjKEeQ6V9O1EPfP1oR+CyZfEE-gANg_su=53QC=MdMkauw@mail.gmail.com>
In-Reply-To: <CAC_iWjKEeQ6V9O1EPfP1oR+CyZfEE-gANg_su=53QC=MdMkauw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:19:38 -0500
Message-ID: <CAEfUkU+gEXLX7xbM98UCQKae+_d4tytOTurLP2o-wMFvom3cAA@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] bloblist: Adjust API to align in powers of 2
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Wed, 27 Dec 2023 at 04:53, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi,
>
> On Mon, 18 Dec 2023 at 20:19, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > The updated bloblist structure stores the alignment as a power-of-two
> > value in its structures. Adjust the API to use this, to avoid needing to
> > calling ilog2().
> >
> > Drop a stale comment while we are here.
>
> The patch does more than what the description suggests. So either the
> new 8b alignment is wrong or the commit message needs and update and
> explain why we are changing this.
>
> The 8-byte-alignment is correct and matching with the spec.
I will update the commit message.

[...]

Regards,
Raymond
