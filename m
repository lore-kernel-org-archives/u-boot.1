Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D587F94CDB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 07:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E36A58352B;
	Wed, 22 Apr 2026 09:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="GxoCBFOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D40383936; Wed, 22 Apr 2026 09:08:53 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD7AC801A9
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6770fc8383cso330010a12.1
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776841731; cv=none;
 d=google.com; s=arc-20240605;
 b=SzsIpu6V16MJxjK+Q8e+lC67rWmViIARn1MQh8k3LkgJ4EEaM8nnWCXfeAbLDxxiQe
 bJ+27EGl+p+R4iERMAeM207x9/Uz6tshtw6VBtkR/bNOv0JxQjOng6CtF06kxml5hfNN
 lIR9KxZALhclINl5Q+fESSwcOOhm2hOrrhUvhtsecgcthQLqNiyaAMNCCBKkL1EWZSs3
 FoeSqx86DGLctsJgueBNHTGIUdpwEokzKaidhfH+nssbBGFQ+ubhJaw+aEljhH+pgdl7
 OZ081CuQK0e13K3cnM/caVI33fHGESdbHHEo9LqyHnK/kWdCN0K1YaUcaRZPX7COD6nx
 5Tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ll71U+ssRGQpAL2qAgEGtGsKPg4973XFofkqFvL0uS0=;
 fh=cxm+pcIwe5vJ3rbIQlg4QNoDkJ/q+xbNZ/CzLk/szDQ=;
 b=kZazYEwYMOdSHurzAgsSWtesWRMNxeUNDZNqmKzCVjttqEHi42m6pTnNew+0btRp9N
 VA+d3FezkPSpDXRBaMhAT+mhDzKvfEnrgNbqxg3Sn+iGq+u/TKt0YbszS/mRe5ShPN4o
 JerTkQMmCMLuHx6JV/p+9qg/M1pe0h3mMxijnEo5YoVvLoq60E6k6qQk8N9YPtIUiP6d
 g1CokDkX76ArCW9OEhfJ6wt0ZMpuEDsSqSsxaRLfJoaeYQSG3sUy3HF0SM5fH4dnJgHn
 QIKt0+5ONAfxxBH7YLq9QIiNHqlQbgXZxpJrt5Gwg6wwiqds3kYzKDLikmEEy3/yIBQA
 1Vnw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1776841731; x=1777446531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll71U+ssRGQpAL2qAgEGtGsKPg4973XFofkqFvL0uS0=;
 b=GxoCBFOZ/VYV6P1Hoy7oNY/Pv0qzg21yKZ7iIIXtE+mX5df2rVcpTnCQ2fW/isO/T/
 gLen148CbsFw9dMNPb/ZwGsemM34UjFQ4Jk76EA6QONF05fZw8K0D2iPxSsuwZuw7CXP
 z1kBsxPuHQdz7uoRuAxb/VyRpBO9PWXa/w4YGoH5PCB+ooxXktGrlLkys7WsWaGd+3Ig
 mH0ea0khwPsmglGe8BrE/q9++bvZla1DKSu+OjvXtP5Ea3wyFBVzpSi3eFz8blGIAGSH
 4NNhskcdS+uWpNM9G9+a5kM0Treh2YcJgrXoVjRNC7iTSCh0Ylc8qbGokLjexuUsTY9I
 jhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776841731; x=1777446531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ll71U+ssRGQpAL2qAgEGtGsKPg4973XFofkqFvL0uS0=;
 b=leXMbn9ugqDOE48IKWyic4mvCU1IS6UtLKaM8JUEnI28A/6cuQVe1q2BPoSvLV975R
 Nu2ODXzeZqctsReVFCWP+T4kSvG8WlGiZ+5fJPfcJRCLwoG9I2QuYgvGIxpGJxpueq9G
 aA0f/Mbai/i06a8P455vme+QRe6bdfQ8LndqWYFmNObF8v0SvSGJbVi6yWuJ421AFOth
 ynGxdwyaY5i3tKxubtfs6Tay96/1gFxjPU9pPwXhb5WJCeu9VPi822psmpmQDEl0yV20
 fioawyPQZt54TmviUy1OUN/buCfj3G91EJp51dQqhpkHo19AM8J4ZvISPh1fYXBumT2P
 1Fbg==
X-Gm-Message-State: AOJu0YzBtglcFyRvhsVL5XBfMGZX6YZJ8UnVf7xTp8CFRf/lj6ntZWLk
 kp6NAzmGVXzYS729IJk2fimUBHbyHjLslC/XP3fE3XRMePvWOGYoHNrymQDSeg+SeHB+YT2cc0F
 dlzj7JoYdFKovwIZpWUL/6li8S2W0DXmtmh/GlbuPNeaQmC6NSHoi
X-Gm-Gg: AeBDiesIU+2+zSxwBNqu9FSH9gLnjQSQjJACzef4pz9Nb+QXr8c0YTVTrp1PyWNf756
 E4uGLTdtCP2deFqSb2SocP3Pjyog1XgrTXfd50SfKnD8a27vNoDV45ewjw7GGe65oqc2Fzxh2Pa
 fWZ+CB0HcU8cdJ4/sg3145mN6DQSt1AZXwywHyYRxRmNC5eSleQ0SexNMrah78eCx14IVDowmOf
 IVbaRw80rSSeiVBvk8u5K2bSFV4daOWlMwMjowRJo23E2aKMeI+/BpcrZcI+sIZ2RWt5c2m6kln
 JLs2tcnhlXfCm43MOBPIGSMGPZQ5
X-Received: by 2002:a17:907:c9a2:b0:b9c:b475:90f4 with SMTP id
 a640c23a62f3a-ba41aa1373fmr771444366b.29.1776841730686; Wed, 22 Apr 2026
 00:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260316-rockchip-ufs-reset-v1-1-808eb017459a@flipper.net>
In-Reply-To: <20260316-rockchip-ufs-reset-v1-1-808eb017459a@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 22 Apr 2026 11:08:41 +0400
X-Gm-Features: AQROBzBEwjlLqTQkNd0KLQiMVgAqUtOC--TmrWXNV2k8aesK4r1CujK3no8V-QA
Message-ID: <CAKTNdwFUke7u40HpefYdn1SM5WawB7WoR_Ps6quTd2FZ7wLoWQ@mail.gmail.com>
Subject: Re: [PATCH] ufs: rockchip: Make use of controller resets
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Mon, Mar 16, 2026 at 8:50=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> Assert Rockchip UFS controller resets during initialization and HCE
> enable, as it is done by the Linux driver.
>
> This is required to make some UFS chips, such as Foresee FEUDNN064G-C2G0,
> work properly.
>
> Note that the resets were already requested in the probe function, just
> not used.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  drivers/ufs/ufs-rockchip.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Hi Neil,

Could you please look into this one? Please let me know if I should
rebase onto the current next branch, or if any other changes are
needed.

Thanks a lot,
Alexey
