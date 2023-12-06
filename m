Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E57C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 03:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9DC870F4;
	Wed,  6 Dec 2023 04:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Si+wxAkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3922186D37; Wed,  6 Dec 2023 04:54:45 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA9F87654
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 04:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5d719a2004fso30121027b3.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 19:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701834880; x=1702439680; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VuaNG5EPVp6r5PoEcTsXeY/sshEEfco5prmXRcjNWnE=;
 b=Si+wxAkxs4/SvaYq9OGHzs56UngAV1ct2+A6isohjWUtq0jtrOQOZ5/trRD8HnISod
 edJEb/f9tp5RmoPVwqlB4gO8O3mCzyBx8NNAWGUrJkr3M+oPxTFsnPqeIBU37WYt4pce
 qQZgdjXWgh8yteXTWglMcPcAxkVH2L/T/j8PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701834880; x=1702439680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VuaNG5EPVp6r5PoEcTsXeY/sshEEfco5prmXRcjNWnE=;
 b=qkFGZX/uVDj+GQIFG+IaVGzSpYcnJbHW2w2xlynj8L2btgzkalIA5HOgGFWIVoA4X6
 NvXi+PMt6JOYyLgmv1VQNOOVLOI5F+tZKdu5ng4BduohZxqQMMQDGuj46GHMtHRvuLzs
 qP9cL59MU8IJ8cKLFk+ARbP4+Pv3rLBb9dpu+7SBKcYYxanWXa6wzU1lDPqPfA0tzXwX
 RYvdfH+NIVXFh9neYmTO9V2Rp+Ohswslm9JKCOdVnKAdQaWYzXmelCEnmoGq52AYA28l
 T90zlvVWnZc56JAJoao+d0jciRKNUDSYPJb1cRM9MUXoRMLCdUVBVQT6vOF8eZMZ5RfG
 t9tg==
X-Gm-Message-State: AOJu0YwP/MKOt3NMozMk4Unu/0GiOWWTqVCTrylBIEAz7ZtoQjMGtdLs
 VqndsleY+CzUU3HF49nv1bmqVFDnE2vDCiXFIeG+KA==
X-Google-Smtp-Source: AGHT+IEuJxUOJCNeHmzmNLv4lSbN2bLag1VS7rcfyzU4xlT7bKHDeWa2V8ymTyf/7Duxxt+wiHHrRcYDq6dY2ntwics=
X-Received: by 2002:a05:690c:338f:b0:5d7:1940:8e00 with SMTP id
 fl15-20020a05690c338f00b005d719408e00mr94582ywb.103.1701834879791; Tue, 05
 Dec 2023 19:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20231205094220.2301360-1-n-francis@ti.com>
 <20231205094220.2301360-3-n-francis@ti.com>
In-Reply-To: <20231205094220.2301360-3-n-francis@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Dec 2023 20:54:11 -0700
Message-ID: <CAPnjgZ2og=T1gj1Q4xuE8zTLEy2Um8c4kvthHkCZXzYSZycekQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: dts: k3-*-binman: Move to using ti-dm entry
 type
To: Neha Malcom Francis <n-francis@ti.com>
Cc: marcel.ziswiler@toradex.com, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de, hs@denx.de, christophe.leroy@csgroup.eu, 
 mr.bossman075@gmail.com, afd@ti.com, m-chawdhry@ti.com, kamlesh@ti.com, 
 nm@ti.com, c-shilwant@ti.com, u-kumar1@ti.com
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

On Tue, 5 Dec 2023 at 02:42, Neha Malcom Francis <n-francis@ti.com> wrote:
>
> Move the DM entry in tispl.bin FIT image from default fetching an
> external blob entry to fetching using ti-dm entry type. This way, the
> DM entry will be populated by the TI_DM pathname if provided. Else it
> will resort to the ti-dm.bin file.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi              | 4 ++--
>  arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 4 ++--
>  arch/arm/dts/k3-am62a-sk-binman.dtsi              | 4 ++--
>  arch/arm/dts/k3-j7200-binman.dtsi                 | 4 ++--
>  arch/arm/dts/k3-j721e-binman.dtsi                 | 4 ++--
>  arch/arm/dts/k3-j721s2-binman.dtsi                | 4 ++--
>  6 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
