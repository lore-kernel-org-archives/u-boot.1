Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F7CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA8BD80F71;
	Fri,  2 Oct 2026 19:32:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rvP1BnUz8Cy2; Fri,  2 Oct 2026 19:32:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DBA2380F48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790969579;
	b=TLuuu6TW5NQW6xCrdFUaIleFLFx6ARNCIERV/EZ978m3A89ZjdXfrSMSoTxXMzKKcseT
	 VmBr3rBc5Dy0+Lc4KSGgNRm/yJ7eRI0QAWeNY/nYXfKYEAv5icpB+AlmnYt1D0dTayn+m
	 OfU2y6nd3xxoWFymj0QquMmXS1NXEEYqq7I/N661emR1jfGYM8dAyfOmTob2dsfbjqlh7
	 UEHBciyhSkFBEe5Ri7y4srSkr00MEGc93seenl2iQCLDxAovh49b5CnKfxeHjEkzcYN0l
	 jgFiAkcfUF2I4xurVw9UX91EDSRataCiN5RyAkomYyoO4zG3+1az95BR/jRZ1rkOAfA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790969579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LF8oTqn1HOk35dDQ7BhRZTmSx46b5jO+J2JF8eZK2rA=;
	b=hsIHfrW2CqRWjaAidA0TC86QwOzGryZrAfrElT/NgYwVHPpGCBa7VuU9BfANyUGQHDbH
	 2dFPz6k1LN4aYr7cctdFtqqVTGOfW2j0dNpwXKDGqf5vxAtHwNXTQD6KTdfULo9Ya65we
	 9mNda6zBRz3f6sdG8nbtwgskRF5fbPmhLmw0Aq41TavboQaxEROXu1Y/Kh5yxVnsIfbr8
	 Y310C39XUVs7ibgPt+XurPRA8kYs26y/4EoGv5SuFnYGaElKzlK3dpyGfXvBVPV+GY3Rp
	 RyWelxFcaHQ2L53kV9EN3gjufLlpUucv2kXZ67ZnjDrqt0nh507ifSJH2hrY2ADX4gQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790969579;
	bh=LF8oTqn1HOk35dDQ7BhRZTmSx46b5jO+J2JF8eZK2rA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QRx2xfOntZVnHwJEh1msRcucgjpWwJc6OdVxx6xzwDl5wtPB2idiJOUM+wFD6r3zv
	 PpLIAZVzbgoHw83FsO2h4VIg40saIauZOsb64kkq+4ZtxaDHLAeCPWyhaEfDmKh0yG
	 Q4Awp2yb8WEpvGKyFpJakpkq+SHUZbf+edgfoljOUnl4nPh7iz39l/50GkmoXNaai2
	 cS7ina1OIH+lyNsl9A0pAwLhFp1BJ0edxW0/TOtyq0BVA/qrkbmoGc8qLPrc3r0jyE
	 uSXkTSXwg9Qo1PdCxiwyggvRn4GUW29IACE7znYEcmOCjyEJ1M57qZ7yygsCpEBY++
	 EzkVKVZct6rgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBA2380F48;
	Fri,  2 Oct 2026 19:32:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D89E1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CA0340B03
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrGFyjVfVtyG for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 19:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5574540B05
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:38::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790969576;
 b=F9+TndPk335EWDJMrwCicq19TRhkdZorQuRpWP7vgaqIgyQvFP9SZqFJsAErhSh3wW26
 QapJ8B6R28Eb3PJXLGsh7SVnm3M4/B6C8YFSh+rxXnmDmAAPxfJyVUBDPhNTwedtghEeh
 R2q1iOYtJjqqTiGKMddWBZ0fhAtjVKMbvr57c1USZSW8Q4DSYXwRschKkA0Uqztx6lb3a
 y34NSqhWESaHRHKKMB+/Xu3aiysU4zKqXhhdgpM6Ie/XQwUs+a11mhu3DZhsx+vVy0LUk
 7c19Z0vkCYOupp/gNsvZ/OEC2ZZQF5v/Ndkne/Gga6F7+GCbfK8Oa36zPildtbja2rg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790969576;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=LF8oTqn1HOk35dDQ7BhRZTmSx46b5jO+J2JF8eZK2rA=;
 b=YFdNB4oDEKkXLbiWP38uOgDo2OwjeY2gAY8Jg0SCXEcparWLt0lydA10InkFtsYnYGtD
 tabty6IPgEPiZrViQe0E6H9cXolanp8+xwYfYhMGgjuls6PUzYrVMYgEHAekMxwcpRCqX
 wEjbXDyOW8RWHYyvEKwX9g0k+Yz02w1v0QnphxJ10qClZAbpazeeCafpM+unfZsBH2lNF
 SCTQB3OJoPOO5RpZXdegFiHTsUItPWLqo+1xGsQ9ZWXu3bxQvuI/earsXCq/qtYtMLiVX
 gOQEaH2qJSUnF5oCP9vaUVNrSdeJXRZ+0iqj4iqyn232cq1aZ0gAaaCopvI5zs2pxgA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Sb8tybVj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:38::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:38::e;
 helo=mail-lr2-x0e.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Sb8tybVj
Received: from mail-lr2-x0e.google.com (mail-lr2-x0e.google.com
 [IPv6:2a00:1450:4864:38::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5574540B05
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 19:32:55 +0000 (UTC)
Received: by mail-lr2-x0e.google.com with SMTP id
 38308e7fff4ca-3a652b710a5so2791051fa.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 12:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790969573; cv=none;
 d=google.com; s=arc-20260327;
 b=KunJUyw0gSNimTKvtdTCK4EOtWSA2MRHgmRUrOUzAr6ekZBH6mNjCL8Yx5kHXC4hXP
 P2mv7eLD6XW1/cWHEyDWiRGpVJAGf0PvmciaJ7+mJXIEe9XU0SgXqeDTa6rZXvhrZq1L
 ipzhjhAtFNPX4+sZ8oyMMbbNjiMwAQg/UzzOycJmF85nCglhIwWIYm4YjXINH6yimWrz
 xKAO2ZCsjPML6Xi9BsJEWK5m8u17qfYED1E52NsilURGK2OOmsA4kowNxxtVVreMGAbi
 CYlc8ewMZk6YG5fPopOLkqtztayjZoh++xLe77onsAeZRoAXmrL8/3uYfh6P+aG7e3vA
 t4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LF8oTqn1HOk35dDQ7BhRZTmSx46b5jO+J2JF8eZK2rA=;
 fh=qKJmo5syRGYW1cxgf6kVwNcGwjB1clfHQJEDU5VNVo0=;
 b=RB9zoKcDkJPdzmMaZ+ViuTC7ZnYt2wgWnO6a9Y9bBwmanePam6Lp2p0j1kDDsqCYYw
 njUdyyt66FBjegRHNhKBZs78gSq9QaTFjsDUhM8HfI9E8iL/oXz4pCiEiDtBQxDv7Fji
 ff558uLrfn9sJ6c3pSOGFZ2RainMNDTPpqRg3yNUR5qH+zrA9BBDsmUH/LIWc8rfRUyJ
 TXN17n8pQJZO0+tZRMYOibJQMNHTL8uKdlIC/K3JDWg2IUHBq0XMvylpm70T55PcHgxu
 7BRLBaMO+OkldaPeX25kkgFLH479+MqXMMotccESmTmdWcmiiR5HHYwEKp8lW2ag1+1V
 SXvg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790969573; x=1791574373;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LF8oTqn1HOk35dDQ7BhRZTmSx46b5jO+J2JF8eZK2rA=;
 b=Sb8tybVjpN5Xbqm+NVfDC2UEmib+c+AmMf7kgvHsOq8L43Zp8QyXY/Yrnb39GOfxRf
 eEfCfJJHb3NzjkOrYIVPEnbD4gGFubmRvdqujKMs3jMhPcilG4XbXSuqeYj45r5a8rHy
 77skjwxFA07s7hNHUXVRRPUBYPkSZcmzX15D99bNs03Vx7MQhZAo/IRX9D00zphf+Nuw
 x/1oks+PqwFD5Lmn+JWyr9vmVNp/ozxA3F+wyFFgSnn6NVpCxf7kXyfVzkewQDQXU5W6
 qubFzEtiYlYEhpLdyjz3TKci3InaCrt+kCzDZtQN+nt40s9pGekM8YvkPbhOaO0ZcJZp
 9cIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790969573; x=1791574373;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LF8oTqn1HOk35dDQ7BhRZTmSx46b5jO+J2JF8eZK2rA=;
 b=BjwDU/TYjGEziw5Cqxfa97gBHXWgdRznLfuTlOp1oWUtJavArUmOIv27d3AOYFyBCJ
 9mkUs1iUFjjCSGRgBkR36oCoImptDFtUh1dnUHAwvI3yTJccMzU29zR4s1OyE1o5VwHQ
 wxzI0BTa0oWR45/IG++3CjZupgELCb+r4OJZ64c1RZ2g/pFetKwosSqHiCDEwcgO0dz9
 G9JJROtRP46Val02W7jhYueF8YpqnPYMj56W5ifHdeCGfCbaNW1VyWEtXZm1FCS+HxkU
 AIyZUijJLEjohzYgFBLXA0fbXXJwVz07enRfWskMI0jwyMcpsKWu4fPU7vDlZyib0s0v
 basg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvTGaXqEQE+7npcn1iKiQsLq/XgMBLAhxk3D+JG+ZuN6xXVMzIiwrsgahH/jCrxs9RirGgVIY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLHOKSNK7KhuzeRe2KL9jbulvNvkjSj7UlSa0gxyvxHbbfJsgOc
 q7Sd/wF2OwpqgKPtw/A1Wq1U9lG/k6+t0SLEF3pbE9YcQuKNhtmX98PwEXi0PiNn2wSIdoHkiq3
 h7g5PrTYqUSu6EAegsKeE6RVm7HsnVqU=
X-Gm-Gg: AYBFou3oQM92G+eN9C/hvqTlu1MMUDs0Tg5YVXWR+8pm/Yo5PUJZk9Sysql5FGxdQWE
 DZZhHHlJCJgT2gdrp+coser9+HCFb6q0quHDvZk2OEnU9JUMZxZVXPOAq5mbt+us/qhWXNXWaAi
 op5ly27/zK8Dp3wgfknIYoziyXAHtGZ26ln8pPCGMJl/qWTRl4mkepGjpoZBCWGJY5MZefHWqYE
 jH/0urJ/RQ2HENcTx+Q7Cpj9tqkMwP8fZlH89XjM2drCsf8G/Ue7PIH1q3iddd1NwIWavuWbt8f
 JzqqU8LXkqDvVRPR7n4kSKUlquG6eerq5CX20l/1DwAs2sEl+Cwui/4ANKP9pILSxGyNXKk34ZC
 G2ybSqW6zY0nsr5sU7o8iLLe0w076JEFfIqW6jExqNEh+NJykWUGeUw==
X-Received: by 2002:a05:651c:546:b0:3a7:6d4a:1c9e with SMTP id
 38308e7fff4ca-3a8877a9cacmr9201271fa.11.1790969573184; Fri, 02 Oct 2026
 12:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
In-Reply-To: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 2 Oct 2026 16:32:41 -0300
X-Gm-Features: AclHuK83DNPi5ZemGd3JCRPO47kjea_bI1npg2VtvR_N8wnuaVucJ8hlsI3SI5U
Message-ID: <CAOMZO5CwR4Lh9eJ-xudFSRZu23c7sNT0LOP2EzqLQMksa76bdw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] binman: add nxp_imx93cst etype for i.MX93
 flash.bin signing
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lei Xu <lei.xu@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi J=C3=A9r=C3=A9mie,

On Thu, Oct 1, 2026 at 1:26=E2=80=AFPM J=C3=A9r=C3=A9mie Dautheribes (Schne=
ider
Electric) <jeremie.dautheribes@bootlin.com> wrote:
>
> Hello,
>
> This series adds support for signing i.MX93 images by leveraging binman
> and CST, the NXP tool used for secure boot. This introduces a new binman
> entry type (etype) for this purpose.
>
> As the implementation is largely similar to the existing i.MX8M support,
> this series also introduce a new common nxp_imxcst etype to share the
> common functionnalities.
>
> This procedure has been tested on the imx93-evk board, using both ECDSA
> and RSA-PSS keys.

This series causes CI to fail:

+binman: Error 1 running 'mkimage -d
./imx9image.imx-boot.nxp-imx93cst@1.u-boot -n
./u-boot-container.cfgout -T imx8image
./imx9image-out.imx-boot.nxp-imx93cst@1.u-boot': ././bl31.bin: Can't
open: No such file or directory
+make[1]: *** [Makefile:1410: .binman_stamp] Error 1
+make: *** [Makefile:189: __sub-make] Error 2

https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/jobs/105126

Please fix and resend.

Thanks
