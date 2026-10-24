Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC7F606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uqesiTV5;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TtKH68Sj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C08B817BA;
	Sat, 24 Oct 2026 13:04:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XbCods5iW4EA; Sat, 24 Oct 2026 13:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D93AF8187F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847038;
	b=mu7Cq9+XmkfD/n3eRiWSL6ETBw/gQxsAwiIU+Qlb00LUe+7TWLPftfAEsLrWoVTUNqSO
	 jFOfHpooVQxFAHTfgGiESggTaaEdWWPmrUlIitgC9gzZvowD+rEY7NTzoIm1ofi2w+boD
	 Xgpit3bh3DCFUmQHsXCjuEM8AZuSUc+SowrKVI2JlhEu3YBx2a2CLVL96jgackpJF1FUu
	 c/Kp+uWLe2iSS5UoxqaVwjQ9IQMYzLuoikE8CJCPM144QpCGtZevWKioNTukW+SySoXKW
	 KvbiPz+ggVIh9hNsQwUbQYZJjJtZioxw2OV0n39RNPwZTPty1ubsxIokP3JcD70IaeA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ILIieaF9w2vGCm9cPTZMODZj7yK06jJBzxIIHYxqWDM=;
	b=CZH8rvZDjTvJGpWtJjhyDAsC0/42SKlKyixy/Y5vO1KucCdeHdu2l0LNanirMeiniprc
	 IjRmvTGDt+mwm3elSUm2aJD6hwPIgSM/ifPm26DA/tdoYLw5rxSQ7A5bDLrEvqoOUAvM7
	 VDgrPx1chPNCc7fTgpfX5/FU8B2qv1J6MZBrJOW/uBVQ0tQluPpBB4PTybgmhcr8KgUAQ
	 4IqCv2Hg3B8972VBMeD0Q3O1DteI3SdxYQF1Je4380EerrO8e4az0y3hNGMJetD3PtL2N
	 fK+mddNooiFYZuMsqQLpDUGrKr5T6UYLiBnwy30jWHFNMMUq6fphVRzlWWGtLS/S7dg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847038;
	bh=ILIieaF9w2vGCm9cPTZMODZj7yK06jJBzxIIHYxqWDM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uqesiTV5ivlyEXMv4KdlDRj/nv4XsDNUXCOXLGcju/3yQW9kxzIlybVolmqQHSQdX
	 urQa20eXzBha7KFgzpXOvWeYHHwfDcWaYhRl/4iodf2ouv+8pZCpR/VXoXoQYgLwBq
	 9d8NMY+f2GiIhJVPw3IZOrdhlTGBsVhu2bvHMatF5zKe6cpLY9CoeK3mt05YpD522X
	 o2a/tEtWVWc9NMz58eJfJLJZPVqQkRU11FYgg9OW4NhaFMuGL3agRspJdFD32FGFxh
	 MM0VCMBwmizmx8Qfr7bcNLFht/DZ3W5sNSQKdH9hvrO7d2BHWNrcG/RsisUSJTs81A
	 jRmIdHnhf/j4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D93AF8187F;
	Sat, 24 Oct 2026 13:03:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9C342C7
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB75560A59
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXctQD7Fau1J for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C622860A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825257;
 b=UKEp5sMXzlWYjofyR8UUtEKp4V/CPiumyZaOvjLgwOKgsVuIbR1jFz+d84NkguFZrKs8
 bR5oiTtjOQiL0K9OPfv3ou8Ck4n47l4dkifW5n0AQ/O411Ak8/XGS+3aNAlHHXQ3mdpgG
 Q8XSKh56O23ezguBe8CeKBPoo0Ax+R4Y84NDtpOyzm9I9FiDDJ+xsh2cz22eoQZlsJ40E
 eat3FoY5BVfbIXmK/wKt5/5taMmmMK8azEeDILDOo0Cu0k0AVWUCk0VV86nL8KeLG+F/e
 IeZMH9tMZNOT+QT9bkrpAoPM8jDHLsWzKLu5pXxMZlDsWRd938JBq8js/wi0afQwFqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825257;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=ILIieaF9w2vGCm9cPTZMODZj7yK06jJBzxIIHYxqWDM=;
 b=fAiPzypmRKRLbt97lL4mCVoqzhW1kNH4xMiD/vRKnueHGlxf7793RVjYzAuYMHz1m+kk
 9IK8Z08/BIT7WyloP9szOCRlHnF+vvkiA5MbLouv2LPLuSc9DRocBNG4d4V74jAXECynf
 3OzlB1TS3a7Px7ZJpB3+bHMHdifA7/Dq7Kj1VZo4qbFRkKFTzaAEioeMuo8OXOJkjprIF
 zORArT7ceI+Z9hW27SSqEsq6EG976+y/cG2MSxBlC+6x4f+rAgnCaHwxsfDN+2uxnYaAY
 3TIfw2DK/9QfrT+/ohuBHalo9wr5MxCbljYG+/TsrtaTdcIT7wsUzfA+/m+BZz87KiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TtKH68Sj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TtKH68Sj
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C622860A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:56 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so2563552a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825255; cv=none;
 d=google.com; s=arc-20260327;
 b=FLJe2Non4hfm0E0jtz/KI5LMCh/ThS8U/wXR/ZHK587cmnaPb4mrB/wKX1JYPD7p+f
 VMl9YsCsFL2DochaH6bWJsQ5HCNcIXTp97rvhtm0qUWsbxO1VkmFAf+2j6jNe/CLm8uf
 QyMW1VaZTiw+dJuGWdSaJAf5k4dvmCOx7ebUkJJu2xA8YUO16R8JzU69RCAmbaj9CrEX
 qd+Sz6bh3Pk4CusbbsksqieC0iyfYSyKPIikA7XSur/WSW8g+pnSazTDK0ER1C7ia8G/
 zISdjLqoSBZZwr3sXePbc8TjKXf1y2E1IQUTtBN9EFZSr7SxM/SOMQe1dZDk0QlyZMWa
 Zffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ILIieaF9w2vGCm9cPTZMODZj7yK06jJBzxIIHYxqWDM=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=PcF9+GtHbKPmrz79fdj3QxOwyHipN0+OpmdjNQ/EJDF2SPSA3utxysPVKV6Vcd+P7g
 luN7YXyG1RRzHGuFGs/WABSJiisnh5eB6gPGxDqNimjzgh6iYvFieG9Zt3izbwtwmBB/
 5uiUW+n6WJEP7X6rlrVR8LRs8XkYQLqx3EkxbuKdMS4xl5S+SgszKS/qXaSgnsggVb4+
 Ban3LR0dlYBFcbGoEVFrjvlSbEvUjmDoTn8bLXwnd/+KfrYt3eZZ85YboRuY/F/pTJe/
 ldDAlvMUQWIY2pL09iR51LBLJEILUItHmsI278woOoYn+6bpnT55QPTQeix8D7uwkZ9d
 ogeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825255; x=1793430055;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ILIieaF9w2vGCm9cPTZMODZj7yK06jJBzxIIHYxqWDM=;
 b=TtKH68SjhoGb9I1lh72/8E2VTy5UGzsmLsQB+ueb68DHUiojwVAFLwiBLQf0HNBPvI
 SLzMjM5lFG9og5pmHyVHiuWG6u9Qsy1TpGFmLEuZdiOrhxBuAoD8k84nyAvsi0SkOEVT
 o7osIsWn0KXiO0IW+QQHtBhBjbKhmSNZtX3I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825255; x=1793430055;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ILIieaF9w2vGCm9cPTZMODZj7yK06jJBzxIIHYxqWDM=;
 b=qeQ2Ignm6VOQZM46/mTA8hAY6vpXcwGN721iWarOvWgED7KkNkS3+KPx+F6xdEarnA
 pA36qvg5NVoW+7Y9Cyl6YPEJlzrMmG6XxhG4lX0tb0W7xTeTXJqQuTEK5lugZ22xAEBe
 ucTNx6jA/kHkkohd4pJiItWO93A/G3Zu/p+MsrCAdRk4rOkgxh9MS5Z9aBVYOTqG/4qn
 aRDbubPRuaue0xcHJY+Go6OZ93fhgkcFW3C+5/EaOh046O+qMIMazqnASWGavnXRJcfY
 5n4DdN5mOAuNZL2lP8LqdNw2ygHSrOF61bNY25v9UZnIIsRSj0rCnfY9a9TF/veIAr0r
 VjdQ==
X-Gm-Message-State: AFq9FYJG1t/1M6MnU4XykjfiqSrsISkUQHxHEO+/sdsUhi0sCRhyNOr5
 BrjSI6/ICH7a4DCZnCdiGAwxb6ZJh64DNXP2caVMgLQKsM90RyJQQ0gi5+M+eM7/S0RFrD1mGc7
 K2gmXwhwgIU1s7y+QT9y1SpVfv37k1y2nTRuWJEXK
X-Gm-Gg: AYBFou22dK+uJ99CD+Au87GXPeJbfZvtlkmXbV9ax/VgaUeSmtrXAsz8ERAyU2WUdKo
 JNG2UD/eXMJd/jqdj8lLVrXt8GUKxwXnykauzz9VDyS1tUWCCa4e5E80T1DAvW1FQ5TQMZmzkbv
 K+jJbV0st3utIffXRoXV5SNDfLRr4Ab2ibkR86plPynxmJhYWBOO9g3gqoSC4G/t2rZmUfJ5zim
 JZJXKbv0qmgmkFZeAMCUmjYtK6khdtoAkd8OFognOteO+eptaMMg3LEBjQ3l5ISalSHjdAyK4jl
 DVjQyy52iw00ade2QxKjoVyhiqy0IK7vYmEWcXW56WL35NR7HQPwWB6qpoHSKvJ/k4tRLnI+6Hd
 wCueyJh6oK7n0jUyde1jM9XV8MAH2pz7wpQw=
X-Received: by 2002:aa7:c587:0:b0:6aa:f1d2:ddb5 with SMTP id
 4fb4d7f45d1cf-6b44323fc46mr1147655a12.31.1792825254951; Sat, 24 Oct 2026
 00:00:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:53 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:41 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-21-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-21-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:53 -0700
X-Gm-Features: AclHuK9w1QzG-FBCLcGnEyluQPNbtXcGnolMICVxOZBbcxixwg2CbWDgoIyYKwY
Message-ID: <CAFLszTiP8u8dz2mDv9s3QOhn_63rPE4x_Gz5Sb_eahYb90ESMA@mail.gmail.com>
Subject: Re: [PATCH v3 21/23] rockchip: Choose FIT payload compression via
 Kconfig
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: Choose FIT payload compression via Kconfig
>
> The dtsi infers how to compress U-Boot proper from whichever SPL
> decompressor happens to be enabled, so there is no way to ask for one in
> particular, turning a decompressor on for something else silently
> changes the image, and the conditional has to be updated with every new
> algorithm.
>
> Take the selection from the generic choice instead, which covers every
> algorithm SPL can unpack and carries a compression level. Declare the
> capability under the same condition the dtsi already uses to decide
> whether it emits a FIT at all.
>
> This defaults to no compression rather than following whichever
> decompressor is enabled, which is a deliberate change: the setting is now
> asked for rather than inferred. No in-tree Rockchip defconfig enables
> SPL_GZIP or SPL_LZMA, so no board changes behaviour.
>
> The level is not offered for lzma, whose tool has no such knob and is
> steered by its dictionary and context-bit settings instead.

This describes the Kconfig from the previous patch, which already says
it ('Offer the level only for algorithms whose tools take one').
Nothing here affects lzma, since the dtsi only emits 'compress-level'
when the symbol is non-zero. Please can you drop this paragraph?

> [...]
>
>  arch/arm/Kconfig                  |  1 +
>  arch/arm/dts/rockchip-u-boot.dtsi | 16 ++++++----------
>  2 files changed, 7 insertions(+), 10 deletions(-)

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> @@ -2128,6 +2128,7 @@ config ARCH_ROCKCHIP
> +	select HAVE_SPL_FIT_COMPRESSION if ARM64 || SPL_OPTEE_IMAGE

This copies the HAS_FIT condition at the top of rockchip-u-boot.dtsi:

    #if defined(CONFIG_SPL_FIT) && (defined(CONFIG_ARM64) ||
defined(CONFIG_SPL_OPTEE_IMAGE))

so the two have to be kept in step by hand. If someone later widens
the dtsi condition (e.g. a 32-bit board with a FIT but no OP-TEE), the
choice stays hidden and the payload is quietly left uncompressed. It
would be worth having one symbol, e.g. a ROCKCHIP_SPL_FIT that is
'def_bool SPL_FIT && (ARM64 || SPL_OPTEE_IMAGE)', which the select
here hangs off and the dtsi tests directly. What do you think?

Regards,
Simon
