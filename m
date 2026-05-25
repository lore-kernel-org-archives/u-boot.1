Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15750CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEC784702;
	Mon, 25 May 2026 16:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y6xytT5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20864847C8; Mon, 25 May 2026 16:07:49 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42C6846C6
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so1915662266b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:07:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779718066; cv=none;
 d=google.com; s=arc-20240605;
 b=BdcE1GmxJ7X0OuOLMQmVfE7Vv+FInvF3NNrgABMAJOboIA1MiRzngFN2Scx+HjR6VY
 jU0S6QMxcMEXqofFKsypbbUocxViqstCb1G0XvLIvsMc1f96XtCP+Au0HIIEgOUQT2u8
 Mrbc+MzlRiuNcHnziWN/O5rtzkl4PASTpNo47KkHEBVrXfPVuHi3M+m45jFw8cOUssCU
 fmjfKw11yNia13NMcpG0QsoKK2pBVo+3HLrJQjB7oSQ5JhPEPM1CtYb7NT1sp6Az0Lw7
 yVYeCJiyN6sxPern5Q4Z6sH3KB2QoCDz0CBPuLBgpvN7TDKhFNlC1JJJvBma8nRz1kw7
 /VfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DRCt9K3EzcJSmgIe/52Q114k+eQs8C7nRqKJ87tOqig=;
 fh=gfiyHLADYi3dWVOfIhvgX1L8P40N612p54aX9Prr3tA=;
 b=I0/g6ySwjrmKh1UIYUB9UcNDbE4FdgBZNQ2Wt36yz5JDsn41JWEgnSybTEORCP9p//
 d2h1NLGeWSaz+B4YkXQ1fpd7DSPhDzCT3CFouKuWuKGUapSfOL0VxYTYIaPW3tlhHPN7
 5l0srfMHK66taWTcW7+uNIJHfZsexBv72jRz3p3QQ62IYaio7Qq7Euu9/JjC0PjOPgXd
 uw4RbMEHxDw2b5MFjVoiVnAua4zJA0R+8m562rq46mJRPce3k0mrtSjhONZqLuSDEl3l
 Torl0ADRofnpykKGBCTSvJKmmba+hyt1ST4xgdtqaobFYiLL6WC0Y2FNmRvofnkLE0fW
 godQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779718066; x=1780322866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DRCt9K3EzcJSmgIe/52Q114k+eQs8C7nRqKJ87tOqig=;
 b=Y6xytT5fLHq7iwQjLbrRyB+EI24qNTawYRaerB4HM0IV79uFwYhDyqo6b7fRhkrfsJ
 khZncoYNzgiBigj6ZUPPS1ivP10vmWQQqEmMKTAvGKALvYFijKEYOJdByPxbKSd+LcFN
 Ia/XmyBP/YRp4jbxZ2i6zso43JKK49nMk+v00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779718066; x=1780322866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRCt9K3EzcJSmgIe/52Q114k+eQs8C7nRqKJ87tOqig=;
 b=iMlTmYHVuTKedd51D/uih9/2g9Lmvb3XDaxUEGMZ+X7dibpuYlCSCZVaH+BLLshETn
 a4Mory+ojBYxkOZYwhubWJvTBrz4oEAy3ri3S6CPZX+dg+xReKt9CXiNjofWKUMrWfUX
 ct4KEhaF1ZViMNgEwdwQs6u15Hy1Ni390DaQK/MZtG6XudW3FwP0NfYf9yAy65iqgnnj
 n4lOb6NUvGXa7AMcH7qnyIbZL/IbsEXkpmqruKeOAFByrWTe2zgMQM73WgEiEIaXtBqh
 PJSDxkRlQ0Kiw1tmoJD/mDLgLdfGl2OF0KaWRfKsOQGIdVIEeGfR0iiFbzJvDIdls9+P
 7PeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CdhmPmm1iUoh5zhYTlqtNZbxWMXDGvYZj+m1VB5zMAAE12RJ8gVN62kE7svp0T6cUPXo3vfo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2R7sSUIu52+HzrSXorjfDo8eiX4kvTRdFnMQ9Y/LPvFIwFCZX
 Dcah3v2vyf33yaBG+kUNq5zob0yZPfDi4rYe7HrMLi31hnXqBhHVnHk5oLTP23AQgcL0PmFWk/E
 /iF/zdeNENv/vnNevvGplo3ogz5E1cgMfZcGN00J2
X-Gm-Gg: Acq92OG2CIz72WOBRedqFFAlRllHc5gORcpgx9qOvaZkp3yXnG1OsQd+TLgcdhyEknl
 0kpkg0S2X28/ANkBAYRYJfIpr6y3RmjgwZFqQxAYvqm3kwp9NrmmcpDZ2Wdig1zgFfIXG0rs5gi
 ecjsV9yD42vojlGq1gJFzMA3xtYELO12alm73VTBo8DRV/kj51DTc6YXmhoiXM+mmBJ9GERrm7y
 LkAQ2OPaRbjz2l1NoGGhmxl+3vugmubt/5KjmIXZz+RMrNgSlIut1KaBqx9DSj/ruXD6HDbu4GL
 QruR4A==
X-Received: by 2002:a17:907:94c8:b0:bd3:7514:14f3 with SMTP id
 a640c23a62f3a-bdbffc5d7bcmr943826866b.11.1779718066103; Mon, 25 May 2026
 07:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260525072947.2399715-1-peng.fan@nxp.com>
In-Reply-To: <20260525072947.2399715-1-peng.fan@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 08:07:33 -0600
X-Gm-Features: AVHnY4IagkU7LbER9SXIOpZoM8HTx8khMWzzvQTPzxKO6M3R2mVgtYS0ZNuZmpQ
Message-ID: <CAFLszTj6OQc_042PJKZ9AD5if+H6h3Z5-VBrxz-+4NBf9rV5cQ@mail.gmail.com>
Subject: Re: [PATCH] power: regulator: tps6287x: Use dev_read_addr_index()
To: peng.fan@nxp.com
Cc: jh80.chung@samsung.com, u-boot@lists.denx.de
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

On Mon, 25 May 2026 at 00:13, <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Use dev_read_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/power/regulator/tps6287x_regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
