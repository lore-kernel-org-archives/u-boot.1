Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D35CA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DDA281218;
	Thu,  1 Oct 2026 01:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQjVIK81PW36; Thu,  1 Oct 2026 01:08:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 76E8A81206
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816915;
	b=KejtSpXg5oHtSTMEDQqWFbnXCtWtp8bBV6uvoPFaMf2bButQtDv7J0oSD96BA/qp8Glg
	 GnNTQUNWJ2FVpxIcL8hH0rMxNpede3RocrfRiDYskWPGBGwIJP0VPKbzqcisRpumPb49+
	 trHkCvKKQGAOfRawMfbHA+j+K7LTa6QSmCLiTIWC1Z5apx/cIhD0QbVUZT+vGd8M9L1/G
	 FQS1uDHWqELHQ6K0fKh4MJLHhUByod39FYI/uRnDiV0TBZXRx2oDNaU8VPWNFBsQCWOf5
	 vPb6cuW58YqND2W9eGrthaF6P0ePkA8o3e2CFmjG/Ux6gz6TXQtWfHYHFxvdZJ4AmZg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790816915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=n/ntI+VAgGeolddEJoJfgRU0TDiuYCmLDWlaTMN9XvI=;
	b=Q6ERd0olnlJlDJ5PEp3jzmZOr3O/O83AEG1P0rZjwdjXF1+MjTTZHbNPhZnyGBGdnLW+
	 qx4mNeFlT6ZfjtYtd8WBUCTw1sDFxJhUCKgaDrsMs/PlwJKOndfGzqS2cpnFM4JfB+L0A
	 Y3zvOTceGg10bxLelV5kirvSpp19MmPoLZL0AMuN2x8/9d84uN9fmijKHibKn1GSiKoie
	 b78P2H53K7BhuVcWpj+drwF0+mNnPxqg5Y+Pf6Do67y/SFv7Ver2anNROIGi36vtKz5Id
	 u5+tsxu3qdcyL98tqOU7eEqFngXxqjvJtYj5QqUc0WPrbQmD5vepCcBKUedSL6aX8Ww==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790816915;
	bh=n/ntI+VAgGeolddEJoJfgRU0TDiuYCmLDWlaTMN9XvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cHaiJPrsjuuaciuTPKZTY7yUDG8lFJKVITrVWwoAt0Y+Pi0PBGbYiALyhOTgDfz+l
	 J5FWI3wTB7UTt3fijVMo8iyWMd+x2dP1k6CrSkIh1vFvRAb4J9JZLDuQJt8iOpfHeB
	 d7tfzX2XBdFRXsi3+dBM0HwuzP2k++A6JxvY+thns370YkLBfsKRPjjDRr2COv3qz8
	 cg31QEXwzMLjWTRKT79lF+2MR0cv9GQ51GLnfp7EjZupYFttxdyElXi7jkDtQr6CDF
	 PhBzcojxG20T+41HPnt9+i/2Lv29Zps5ShUvIpx7THoKLE3x7fdzKcAMO1KVjwTV6R
	 kyIa8MYDe73eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76E8A81206;
	Thu,  1 Oct 2026 01:08:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F5E43AC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3554B60BA5
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6unkSphJmUj for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:08:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BEC0D60B74
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:3b::2a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816910;
 b=fIZdj8ZYPvJppC6W7khTKsswX8nKI9+ot1tNQ7473SbI7yWJcpWr/2nhdJhqzsQwVG2M
 Sz/+mueXhUOE0bIhgBDbZcMAcL4A1Dfzoe4p/ytLba3vKY2gjW/RNTCqqrIUufIui9hKl
 IAxoAexWryS2rNg2biIKfibOEp91xFfK/NMASzpH+rmZ3DPw+5LyEQav7pFLxxMUakSE4
 209IUYKPZJNC4vIBzJJbpE91KgEd1c/O/J6Dbk+8dF2+f+a4O20JHJrn+zK5Ci1y19oun
 IiKFHhJwVrCgw8h9YQZTZdkw4/8UaFFqaMl/cVMwprkvBt4kdXQUm1pCGOG80t3eSrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790816910;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=n/ntI+VAgGeolddEJoJfgRU0TDiuYCmLDWlaTMN9XvI=;
 b=Dhb5PR3nBx/M2TbXeH0T4e8wao1Fxz2Bty4q1253ZSTZasKE0A//qHGKyWLkm5VMSFFD
 H/VPYJpb+XxxiSNosoAVxqzteMiRBM6Yt7sPmjY2Cz55gr3X0yxlEtFtNdIgPa2UMJztt
 hA3fyOtFWyq+z5vlR1uRwHZxMTFtKsHCXzhJ4tp6E8YntzSVvb6JyTxbmXWB5XMJSvCtG
 joB8R9UmlUeWWSsVQ4hOhefbrO6ZW3uK8FBoK22SJrtMPLznJI03M+QMUjSXzB7zncNBC
 VXU8W4IrC3ZfohIMf2NvjZkNHIid0nfpzrJYWKDw54J6zJ2JQ9g307+6I/bvxckP8wQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EsjFvZ4G; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:3b::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::2a; helo=mail-pz2-x2a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=EsjFvZ4G
Received: from mail-pz2-x2a.google.com (mail-pz2-x2a.google.com
 [IPv6:2607:f8b0:4864:3b::2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEC0D60B74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:30 +0000 (UTC)
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-88272e1d069so2943377b3a.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790816910; cv=none;
 d=google.com; s=arc-20260327;
 b=if/LBE2MG5R3GGVXHbmXIwCH8x1RPykkQ/660OhVRM1ETAQ+9sEOaACgAIq8XHO41z
 QFFAToM7vmxpzPfJ/UEywHjXmkXQb9GKbSyy25aPkXXuU+Y9OOzEDVgPTujvTpgAi/bE
 tWvhulxOal87YHY24SpTyKKEH0oHZkWqSFMMLUVbCZBl1LwSSNgqYRVmZUEjCHotslRo
 4eVdMGB6RSMEyVraClhScjQnJVk89i5F5ru3yoU/68T4bRcfPbJQdKp9nDvKjyTPdYmR
 25+GD5md84JOr2LjcreLwxZKGFPzCmpehwuL4oPSN0mjJKWNnTKoq75/4cBmggM2+CIU
 hTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n/ntI+VAgGeolddEJoJfgRU0TDiuYCmLDWlaTMN9XvI=;
 fh=Z+VpP1dwfKFCxD+uM9VBd/VhYIt7lPZuwBAce10fH4A=;
 b=pduS4RMp1ax8K43MINGjftWMx8PyviUfOzMwz7d8ZDjkO8vA0GKfJiRP5eO2i+gsBM
 ii++E8+Ppd9G1U6NK14PjB9aX453cld/wlVYklbLR9EnUjO5d9hzI4U92zCwbKC+YfB0
 E48792adEaUscvVStiv9I+BHjDyicDbTrTY3G77CKR9AEbvuNFnUaq7Td0jNtkeh6+pm
 5cEqSMh9PlDYtY9M4zCCXKJxJ1mexUA88vyXStE1cFgNatLeTEc79z26ulPzIWSU627w
 hLK5Fl7C5TgYUgKtE1pWIR+60Jh3RvYcofcVF/33WqrBP14+2rlf0ITr4OSm4hOnFXxM
 ArAA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790816910; x=1791421710;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n/ntI+VAgGeolddEJoJfgRU0TDiuYCmLDWlaTMN9XvI=;
 b=EsjFvZ4G1aV3BE7ndAU49c5TReulPK8+bn85MSRNtRgsgHUQVIz+gTGPOLnfEooG9P
 MDwYthtRJE6TtcKkZ7stgk2NwfBX5Zqk4ygJRP5ITuw/LKDZnLP3tKMM1P8WKlhGUGED
 IEwDkGTW5SXBFtPSThQE+RfzLYwzlsau8tswg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790816910; x=1791421710;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n/ntI+VAgGeolddEJoJfgRU0TDiuYCmLDWlaTMN9XvI=;
 b=Ph6q0nNvrKPPe/Gj6Tf14POlm03qEGm44ymLX5+W8zAYjboBa71qvvBWum3PVqMfPD
 K7+OyB8X9lQxbzs772BwU3GQQgIH24/KaEZsIej/Cq0lAmZCaUfR8A6cgos2jJTf4qZD
 Q0FfLRpnKVRFgPbSEPpHsJcssCCLUATHXXpb/F0z1kJo6sFrGWsNZsT6XMMleaA9quSW
 7Aez+gSPO2LcMjHGEWfjPyC17a6d6FDY13JFoTx3kTTncdgdv5AWdPT4IRCUx6pyy+PE
 j5Yryd8zj3KwPFl0D3UoRtDyJervR5yR7stpLAqSU09r6JKMx5gpQu58vvjjrhT5muvj
 2cAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMdEKbGAJXyrw4CQjkRWXvFVmKwF7Q/DyHLVeqhs9uKWLXpWltJL1jiG8YmbeHrHeI/q1NBLk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m3ayew+eiQHZHVwN+6xwRuDjxbqQbzGoZoaleKuHgzzyg1ZmkF
 rz8yC8IRM6uObB0lKS0i5EMHug61R+vUEyzXgEweGOfvaj8xalWyn7QjbQTRU39duRmZ9pMORcl
 TmEzlKQXVUhPUd/xcAJX7eIXG/m23k3Bs0EaXz+x0
X-Gm-Gg: AYBFou3GaE6VYTH9hPaJq96ieRBS07WnyOXTDR+L0hmTuwra/D/zB6WVJdC91t9Zrsf
 4vBoZdfBzm9Vn5LXK5nQBSO8ufUBp50QSJBpagZ1BlMbBK7ASNdg+c11KaiXyphoingMcKFrH73
 31IOxfDexpU56tWQhtVjMMdeiGKY4gLbp8xyH6diZAmBS0GWsnkEiwiArfqgtci+7um0Jwtp6y0
 ld0K0zOhe/8RtfnwwONugOgbY1h+IspF9gZFtNkXbWELBViS2OVjnZDUzxcJ0Ql+h2RJz46fLxM
 4w4hMqtqXy0Egvz97nd4hnCzo6RHRMtzLEo9KHova0bDbhrH/xFDiNFp
X-Received: by 2002:a05:6a00:b42:b0:87a:9335:c93f with SMTP id
 d2e1a72fcca58-8874d0ab687mr2259663b3a.43.1790816909725; Wed, 30 Sep 2026
 18:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
 <20260930-imx93-secureboot-v4-8-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-8-f968a1b14dc5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:08:01 +0100
X-Gm-Features: AclHuK8xbFMj5LIQeHS9jOwFOMklxPG8LznBV1QEXWcmEJ069pMQsklwbjaAhBc
Message-ID: <CAFLszTiqZjm2gWE70BmM_PK6KVe4E_ZZLocSx8XdPWm42fHNFA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] binman: test: use the cst mock helper in
 testNxpImx8mCSTSigned
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
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

On 2026-09-30T13:42:33, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: test: use the cst mock helper in testNxpImx8mCSTSigned
>
> Use the _MockCstRunCmd() helper instead of the inline fake cst
> run_cmd() mock in testNxpImx8mCSTSigned(). No functional change.
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/ftest.py | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
