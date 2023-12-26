Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CB9C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F4151878F1;
	Tue, 26 Dec 2023 10:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OFSHxkzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCF58786E; Tue, 26 Dec 2023 10:47:35 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA61878F1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-594965fbb3cso707267eaf.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584051; x=1704188851; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhbjdiXWuf/yHTGcvGsH9DplVpuo2ikwiArOJZ5lUiQ=;
 b=OFSHxkzL7eMGaGVKzhOEmn9JylieXwriVM5Y4AMJ6ud2sO3gT7ltZxU3sMgXSdgoaD
 PxBFSuwZwCA2U3kEprBbVLV+thIf/dvbKCvIiJp1r7cjmMNdOD7QKm2q7bpHnJ8A5fGm
 q5a4+2rVXu0cuf9WBfhu3z9v+yOe+x5OiUH0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584051; x=1704188851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhbjdiXWuf/yHTGcvGsH9DplVpuo2ikwiArOJZ5lUiQ=;
 b=PXG0S2sYmzZL9Qn9fxntfJjThp4cEzZhuANb9lRuFtTjzuWGUuxkiD7GacTX1o6yoU
 ERtW/kLHi7rWocK3RL1s8d1PTjig68r9EIuz0E31CaGT7zL2c8VbYdSWpktdr7GQ/LJc
 iQJ5MzU9hpwc+fXpK4b87tUcqddoNThvdqRP9fUijIRc3A/u5FJ7KK09QZbFx04O2c9y
 ndUv+OWLPjMdXUHOSQ7ai+ij1ZndGvTSAhx+aobRqm/otNvdHYAJJXOPuu3hNUbGwRT/
 IpnLihWtPvqPccodFzX1uAQvw2IOn7g9H3vkffomXtDo99VQHTOBDIufyUHchKb5r8vA
 5dwg==
X-Gm-Message-State: AOJu0YyMq8tYRBX3B+Qo4SAmI/INdYC+0gQ0sSRxumdlQlgxq6ljrpFb
 5d/M6OFw4l6YMNbJV868g3KrIT0d7/LoGuCshEMoFTo1OrTV
X-Google-Smtp-Source: AGHT+IG6tk3QykbmGy911FDtKEWrchdcHo8P6rci4YIgmnEq+b2EXZKdDVAYmaV1Lt0eZLG7EAVvJwiqTXh3dSLAXQc=
X-Received: by 2002:a05:6358:4406:b0:170:982:5611 with SMTP id
 z6-20020a056358440600b0017009825611mr10352122rwc.32.1703584051731; Tue, 26
 Dec 2023 01:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-4-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-4-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:46:59 +0000
Message-ID: <CAFLszTjUcyiG29YjxstZOTJytbb367+dEtoECEwE+FMT55Yk9Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] bloblist: Change the magic value
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 18, 2023 at 6:19=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> This uses a new value with spec v0.9 so change it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Update the bloblist magic to align to FW handoff spec v0.9.
> Changes in v3
> - Update the bloblist magic to align to FW handoff spec up to commit 3592=
349.
>
>  include/bloblist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
