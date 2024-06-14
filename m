Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D424BC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 10:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A32889A7;
	Fri, 14 Jun 2024 12:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fSlr1IfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32922889AA; Fri, 14 Jun 2024 12:52:57 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10EB3889A1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 12:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2c31d6961beso374118a91.3
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 03:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718362373; x=1718967173; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BSqmEIuO5PjXSycsE2ZOd1FoMTT49RXj1pa162rnZs=;
 b=fSlr1IfIell7vlTYtYyOebdOUB+V2/D1GD8ALiTnE2azjCwalPGqom8scT2CjJCz6E
 TfNe6xk8+2wm9GIUECeSfMupzRV5dPeP6K6dx+ijkGqREZaxf3zQX73SEP53lDOQCOH5
 ry+jb721u9/0Qi6/Dh5NDAzI4ejBlTFOfB+A8AZmBo96S3ixydNKtmNqZQyoRd5Mf587
 JEjChMoZwKQGt7KJO+hBMQTk775Ros/kWUaTbtUPXLc7IXfWm27qo46k6hxiJa62n6H1
 eVcxbkOQ9RW8nw6cllDP6TBwL7exS6LQtLrOkRuz0wuvts57VyftTVujyHzPvLDcR4CM
 rKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718362373; x=1718967173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BSqmEIuO5PjXSycsE2ZOd1FoMTT49RXj1pa162rnZs=;
 b=hy5TFQ/b7GbIVCq6ined0VDqMrcrarVTVAzo+lttLHdvtkhpq9VV8VJkq2Q4vbrkEB
 4uihMS4r+7ZeArVq7ARBdjnQ9uxj4d979FiLT66/fLz3fJTS5rrfcbNOKsv2REwTjLkM
 bRlv9RVtOVP3Ya6fI2IBwJn8ISoQwJeDcOJ2tkjJ6/VupMSj9aqpvFrPNWsmxfr/E2iY
 Vj4wu+fw9CI/gpmOpaRgOuCK8ly8RBePLfAvp538/tKBd9ODx2978wn3qLjE0CBiyTJV
 3JNNtHYrsNOHEmwrpkdo0fw6nEL0QtBONvINDQnzT0ifhh/5AqjZXuSvpTbpHZfj1U+w
 fD6A==
X-Gm-Message-State: AOJu0Yw4i4uqMEbTKD+sdp7aYdhQXGbEEJd/+1u/8sZSPPFQFdPZKFCB
 t4w2Z8XHKy2W2l4KNspvUfcolnC9odUY7YAXOeW0J1DVK1+uFzcIvjdEPyBuWon9IZVz8/tndA5
 egmYq5vYQWSRoA+/CKdNHQh+Lc/NKYiZo
X-Google-Smtp-Source: AGHT+IE3yfdL4sQZOY025+EURb0/CHQSvdmbfBsu+yAJ83xJLxwn3OaSiMEsLtEi34VnjnR7CwATdu5qP3CCGrJ9G5E=
X-Received: by 2002:a05:6a21:78a6:b0:1af:cc80:57b6 with SMTP id
 adf61e73a8af0-1bae82c2125mr2642147637.3.1718362373481; Fri, 14 Jun 2024
 03:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <6fc28b7090833e94d47ee3abfce1b1f5a75d349f.camel@opensuse.org>
 <ca425556-fdbd-457e-8713-5176f925cce7@seco.com>
 <fad372cd45b13bd15fb07c10c66802b0a03b4f25.camel@opensuse.org>
In-Reply-To: <fad372cd45b13bd15fb07c10c66802b0a03b4f25.camel@opensuse.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 14 Jun 2024 07:52:41 -0300
Message-ID: <CAOMZO5B3krB1vyibGNYej9nrPMkOXh1+P05Boqd2Vsr1E5nmcg@mail.gmail.com>
Subject: Re: silent u-boot not working
To: Jonas Kvinge <jonaski@opensuse.org>
Cc: u-boot@lists.denx.de
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

Hi Jonas,

On Fri, Jun 14, 2024 at 7:49=E2=80=AFAM Jonas Kvinge <jonaski@opensuse.org>=
 wrote:

> Where do I find CONFIG_EXTRA_ENV_SETTINGS? Is it an option in make
> menuconfig, or do I need to edit the header file include/configs/rpi.h?

In recent U-Boot versions, this option has been renamed to
CFG_EXTRA_ENV_SETTINGS.

It is located at include/configs/<board>.h
