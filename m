Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7AEC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 20:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B212087D26;
	Thu,  7 Mar 2024 21:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUF0/ggC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E5487D99; Thu,  7 Mar 2024 21:26:39 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E17A87776
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 21:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e5769aa0b3so313057b3a.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709843196; x=1710447996; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqVuDHcyzw6TkBUEko1qcBk0U3foNBJmhOeT4J8uKh4=;
 b=BUF0/ggCagknyszuk9/DGVSiQNqIky28kR7GiJk0vEZG5Zf9p9DtPLRPW3jJFV+kkY
 QG64/C0d04YBPckQPzaz5oWScguogFbIATzf7m6cec1e7fJtDit4MMaPEoQmZI8YIRlO
 Lx0uBwjoO9LTVTiyw8qtm2UMD7FwC4ehpnSl2chFnbYteiO96hVClaQFRkwNFPTC021T
 Srj3b6/OwrpO/2qqZBgT3NvmOvd/8z+ojYdwHoLa4TtujLWZVSgyW3C67rV3tg3gV1OJ
 iCrYW5BCHqH8ctWhr69vHvB0Zw6Q1nzhCwKjz1gM38SktiPMJ+WVuUDOQfL03h1DkEpH
 qgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709843196; x=1710447996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqVuDHcyzw6TkBUEko1qcBk0U3foNBJmhOeT4J8uKh4=;
 b=n2NiZAkOjIjB5M8xNhVNNDK3/v7C6ZvlVsxFY6lCY21sau3GQA/JtjITNlZGzkfHeM
 Yv1W2O9PkI3S0WjWGCxeR9kCl9OB9PncJP1EkDgN84OP9Zhj9FiREEviIWuEIsN4q7f3
 kjstXNv4b0rQhjE1swj1wvCL4ykkOTKLTwK7RNHM6vKIXRtl0cbQ91KjzEKwwZCJqPKM
 poLiSRP8WJhJbzLEx0lX17asCKVlXt6xOHB70aHM/g1hpUg5EWXPoVFcAMmQU3m/yMS4
 pJC57A2lxcFyKSSGmrDimzB4HmdpwatvXg0ip1pZOks+A57oyLL8rstjz1k9kpXF7eij
 rBlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjEo87azwmcmOZWnINZbX4yBRf68XmOV58dXLyovHDPeWBm9grgUN+oNMkrAuEzwQnvr7RcrV5BdZxmsxq0jUkUquQZA==
X-Gm-Message-State: AOJu0YxugDmJ4I3EkRoteNl0FP7E3kGUnXZAi9jV4WxbqSPPikGau5Mz
 PHYAP+Hzo27t9yqKJTiDNWX+C/r2qWrNYk3RnQT7cGwQlqekGK27KgHuxD0iIT6Xplx7axf3OpY
 X2TYUGsbEUHgh6iVATniS/rcG3jg=
X-Google-Smtp-Source: AGHT+IE/LZFStlV9o2im/N+n84GVuTxOEn79FUO2nSFXcY24UiEF1XAT5WDbTvKUhQpXWIv6KTb1sPNbYY1igTIdAjg=
X-Received: by 2002:a05:6a20:8e1e:b0:1a1:694d:d4f7 with SMTP id
 y30-20020a056a208e1e00b001a1694dd4f7mr107248pzj.0.1709843195911; Thu, 07 Mar
 2024 12:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
In-Reply-To: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 7 Mar 2024 17:26:24 -0300
Message-ID: <CAOMZO5Df5WuOi-_sNvCcWM7oWxZPtm69P=7Sgmsi0iY_Q7HeoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] board: phytec_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

Hi Benjamin,

On Wed, Mar 6, 2024 at 1:18=E2=80=AFPM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:
>
> PCL-070 supports 2GHz RAM-timings from pcb_rev 1 and newer. PCM-070
> supports 2GHz RAM-timings only from pcb_rev 3 and newer.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

v3 looks good.

Is this material for U-Boot 2024.04 or 2024.07?
