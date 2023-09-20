Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A82CE79CB
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 11:14:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E2286AFA;
	Wed, 20 Sep 2023 13:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MSX/qU6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B8986813; Wed, 20 Sep 2023 13:14:10 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823A786AFA
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 13:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-578bb70ad89so173097a12.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695208447; x=1695813247; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCgdva+CuqwJbSJOFKFRg7Pira/CLZM3GuiCUncXbMs=;
 b=MSX/qU6CgpyUznB2afu+DAjDfegzp7n/6nBrBENpuNCFtMfWIRQddqyJT5zej7Rxcp
 xt220J0mzt+aTv/3i22RY34tW0uj7Jm3kj+/tF/W+IAHBuZtAb/BXLJzCguuHA8SbnZO
 KIzmw+7B90FJ9Vd6UMPDcW7L4464UcryzfPQyR+720SvRcBAwxqC+jztqZ+3JTk8lRw/
 oUThmXiPx343RHj0HG6vfvDqC2qR7RZmhmz18qV+na/dEgRZ/VX12cvu6ocYwipwsmis
 ezvmpX3nbMCMeb1u2PXNM7N3lA1OGZBX9ss+6GQN4nhljtczdvr3iWHfzgKKgPw2KqZu
 tNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208447; x=1695813247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aCgdva+CuqwJbSJOFKFRg7Pira/CLZM3GuiCUncXbMs=;
 b=nWjJ0bW754RfaPNf8c0INgv1Ljhd/N6aGpPVTeH7HXaLKYOEA+to4IBNipQZicLZlm
 3euIevHeYyxNGICol09Kbtbu46C+Duxwp0u/w7bUTEhjsGfVBVt+4r9yUCFelOGCe7CB
 GwZ2wX3r2q3q8EcMJ4cmN24OeCDEtuA8VaiqI8WMiiBMB19Ew2CzScjs8wSq5zdp1xEu
 L2J+BtPmMC/MKyAw65HLXtFRzAmkc2HMO7G6x574siu0ZyOr+2IlIbRxAFXiFVN+anhT
 YeC93N84yl36uZJrULzo+ej/asrhMPTQq3rgFFrGzvXYkkq6qAElDxmdFebK9tzWXWrZ
 jdHA==
X-Gm-Message-State: AOJu0Yzs14cd4lbxEuNUxLdvfy4Vn/dnoz3sWEp0u+bgwihy4nxjeLC4
 8ADJO5yZq87FvpqHjVMoIc/3xieOhvr6auj3D+c=
X-Google-Smtp-Source: AGHT+IEnTFI+PZq00ki7KxnoANwM4EAPBtn+a68X+RnNjBKzXQ46TI8wFWn3buFhdDn7kRqRxFkJscFwgC3srgj3I8U=
X-Received: by 2002:a05:6a21:6d92:b0:13f:65ca:52a2 with SMTP id
 wl18-20020a056a216d9200b0013f65ca52a2mr2272589pzb.5.1695208446783; Wed, 20
 Sep 2023 04:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230919134932.134678-1-rasmus.villemoes@prevas.dk>
 <20230919134932.134678-3-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230919134932.134678-3-rasmus.villemoes@prevas.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Sep 2023 08:13:54 -0300
Message-ID: <CAOMZO5DcppvD7_yx1PqCkHd23uJ2B64RNknJJOPBHBSsEO5_eg@mail.gmail.com>
Subject: Re: [PATCH resend 2/2] imx: spl_imx_romapi.c: remove dead code
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com
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

On Tue, Sep 19, 2023 at 10:49=E2=80=AFAM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> These IS_ENABLED(CONFIG_SPL_LOAD_FIT) cases can no longer be reached,
> and thus get_fit_image_size() is also redundant.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Fabio Estevam <festevam@denx.de>
