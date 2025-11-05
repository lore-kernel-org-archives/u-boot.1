Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955CDCCF9E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C472883981;
	Wed,  5 Nov 2025 01:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PGNI/eRm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6904C839B9; Wed,  5 Nov 2025 01:41:54 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A39D83968
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-63fc72db706so1720885d50.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 16:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762303311; x=1762908111; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgtUjoA0PNSVHeepHKYJFLTSqvcrY9n3HlVpFJIRKfI=;
 b=PGNI/eRmZ5ZS0zj/ev822tMi4jCFAerrm1u/q7e0ONbTnbqP3lhlFtBToYh+hnMKSA
 s+fFFsvheQbs1ZufgjfGyKi2d+w5aq/DLGZPFVZi/XpnYnOxklpQeKB0AraFOYN8ZJPa
 M5xtOKybh2WAkDPOskQ8qo0MnIfKllOwpKZVfF7b6r6ERFCUqAMEeXq4T3bnHikFWM0P
 Wg/vh2ZtEHyLm99eTARYgy+NBcpF57n9M6QunDcrHdekQQ2+EG6M8VQm+1p/NBvRbqeP
 nIXT23CUtwXZ3g46Bx4ayFJts4fFVu1SDiYNmfwSnbiEX8YvIfvDZkZuqZsrnMv9uC/H
 Z+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762303311; x=1762908111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgtUjoA0PNSVHeepHKYJFLTSqvcrY9n3HlVpFJIRKfI=;
 b=AcfXQrIaNUwgnTf90MaPsN1I6i+IbYzRvYZ2kXWin3UC/pf4C+F1APBHPvM7eXkTP/
 Y/ooQxyxDpMK0EhjFq3ncxIKq0tY8KCHgCiB/xfZrJv/P6QCZtgQCU1nZtO95mW7IPbi
 gwZlDoEN5K/cYRBXm1vsc2+0kAZvDWBLPOWpxRohU5h1GHoY5tt/E0Dkl6zWo/436Voi
 9Fz1EWpA/UPuE1Y5jwA4cp+1+Zjkd08KyRNqSioSYb008QUunFqWy90j4K0yV5BnDkRE
 jOqY6heWtbZPU3DhozInrAnBHofSlUiTNPPUdk5Qnp8jCMcbse+G12Kb0k3C6EwZfvBs
 CI8Q==
X-Gm-Message-State: AOJu0YwFDmTDINYQMsPVmOhwF25NMLqx5pjcOV/5F3IneTPWmbQI+G32
 aet+mS17MMVenBsVsEg0xLhVNG4LiI0FPiS0MyTGSnRpnYNq1+14prok5F3EQYRcYAOE7nEYYlY
 zig0S3SbQFTSOEQbs5OdZ+GpXzycjLYU0DOek
X-Gm-Gg: ASbGncuLVtM09dp3TgnSW4DseZSxCEkAdbpB1tscFLPz/8Yof5gnpOfZ/MUbHru/nq4
 8YXEaVGahFOb+6iVMbOk0O4L+/XtHJNbUxeRwKkttacEbEO6zSe+HbLt3dVUVMwRiTyHXpMEt9R
 is0/0AiUYZEtb1IRy1yWe9FUYWDu1Ds56lWRtd9k7s9u9JEVjKL2af7TIwKA7R3fteyUBBsJd3k
 evdusN5+9/QF27+9HFURcP+C/ZjgMzUb2uHrkY9MndsO/qEErhYuahUY/p9UAV007Tndwc=
X-Google-Smtp-Source: AGHT+IFqVIFqKAiCeg5BfizVOsbgSJVlzGH9Lx2GLUiVOFVt3I9mQGML5FfHc3xSX3kaug0NulsGxuwzTGQvYdkgrlo=
X-Received: by 2002:a05:690e:254e:b0:63f:7617:e338 with SMTP id
 956f58d0204a3-63fd3585e28mr1009061d50.53.1762303310990; Tue, 04 Nov 2025
 16:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20251104233915.89413-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251104233915.89413-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 5 Nov 2025 08:41:39 +0800
X-Gm-Features: AWmQ_blZmZIdgLBXh6VjkLNZcJPImTLPolrI20fPwI_wSORjr9Br5AWeRP2PYgc
Message-ID: <CAEUhbmWhdt_8_moHLnkmAkM=N3_wWgSh1pKHAWidH0ghUpnz2w@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio: typo complaint
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Wed, Nov 5, 2025 at 7:39=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/v1.0 complaint/v1.0 compliant/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/virtio/virtio-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
