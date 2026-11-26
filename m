Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A9606A330
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=keQFjGcR;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFBX5zKL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1024608F5;
	Thu, 26 Nov 2026 10:50:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwmbP2ariZjA; Thu, 26 Nov 2026 10:50:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 48C40608DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690241;
	b=gp2wse5uiRSQw5l1wt/IzosBmXKJB9i26SCzHqZm3I1Or7kbDAe/PyUrDjs4p3yOWu8i
	 KjBaXsooZBuD5i7ADipj2s0dkR5Ob6q4OtYzafLEENLFJpOl223XkUF8aQk9fqNDRq6eG
	 EHMocb349zQmVCIy61Y2/RShUXsG4Q/VTsyoyCe3wEqmohaYeOqZ8JljJQTuR4xTYA8If
	 A5tDOiwYf6LSXnGN5J2ZYq4/qwzesgV983PGSlH+opl96LrJIEfCqtwaqtzsOMS0x4jXP
	 FGLzSHZKuRJE9uydxUjzhJb/OA/F1jaMv67RVsA/KFkxZ5rc11DdrXmQNug1Q3oRfug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690241;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+5kN1QBdMecvLWaaTCfmxRb9EjXuLHO50WM/yakmMoE=;
	b=tUPIKFlEdQWI1dHtzvK/t6ciSPmqgNdYyO6Pkz2sQA9aiqbRgRz/CKSh/hDWnGRuelzN
	 H0vIabgDbMEhU66gZzlAcNyMlFVnyCdrj0KGDUDjopV46cm5+U0Cx3lprpahiI6Oj92IA
	 JjTe/9u2Z7jUcRHjTGEZlwvr70TuauzSD/nxkzhq4RbpLLqcGTpULsPdh926S4OifZpOP
	 Y9yrcrOoxzgcefeBq1UOKbuQS4k0SXxNzMVPlzF2Hhnls0/sZsKmxx83ZsNhox6mtU3Ut
	 8qERUJSEuEcqE9PTWn7lMTEUrUUN/eQ9WOFOP8+jrDzWfihqlyypsdWddY1PZgPfN1g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690241;
	bh=+5kN1QBdMecvLWaaTCfmxRb9EjXuLHO50WM/yakmMoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=keQFjGcRAxPbcIvqqSztEA3y7vWAil8ydm7iXhxQu7A5d4Vyx+O9BpKjx/Op4SfMc
	 MKKz7L1x80HjATOoxaCvTkhShx+3BPLL+WdFFXZlS02uIxMsgC9vCNesiOsbAHgAQF
	 yQEC+p49vBNit+NcYmD+sSBE6YILUSM5Q2ivFKB+/bC2NBl5jXb/rwqrGzytI8l06L
	 GEb+Pp4j4zKVxmdHsI2+ScUUFjjGYQR9v5lgMyQGUC34ePEniLeuYqs5ATQCtP0NN7
	 Erf1vy0fNPvgqAGCChS64I8oxbHCjAuaDv36WGLRzPmVVL+udDlXaKdtmfjd1FTyo9
	 dI76TbFcK+hCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48C40608DE;
	Thu, 26 Nov 2026 10:50:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23964325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 094E9810D2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIqOgaRDO0VE for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:50:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B983810E2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::12d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=lFBX5zKL
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B983810E2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:50:37 +0000 (UTC)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5bcdae234ecso1423902e87.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 02:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795690235; x=1796295035;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+5kN1QBdMecvLWaaTCfmxRb9EjXuLHO50WM/yakmMoE=;
 b=lFBX5zKL9Db+AHG6C3dPghQAcLEsEnBicIjrGiOjty64d/n7XTPKqu1c4PDXv+XWk3
 MoCq2u/CAPkcjIUPC8B1AGsxBpev7QVaKn6pw95RT9Buay/bkX+BuVwvRx63ez3sPkh9
 5tuTD40m+W5fgOC9Kjh8cIzjA30MBH7wA5QiHE9avKH8SGO8oYDF0nWzMT/Nf0N0m92u
 u3Bl6fMB2uLke0XhY3vc39dWw7lIaDtMcfGZQGKvfIfmhinnUDhffVjco3GP3/7/kCl4
 pTMZHw8295hrQMF4mexAe676ZuDGfpExVSwq6d6Xtk9yhSeTZJGCq8f6L3aUcvz2EdcR
 z1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795690235; x=1796295035;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+5kN1QBdMecvLWaaTCfmxRb9EjXuLHO50WM/yakmMoE=;
 b=E/xc79sJcYQGYixPR4ui28JIRtDSsuJ7YsuR7/SIR8cL3pi1QF7k+pPyXkzym4Qeft
 0aUxOfF1ogFuFHWt/Un1Ff1TavdmjFLegGue9A/ILTWOkrbiDRVzv7kE/7S+SEdn17CN
 UiIMlW8+wLIjuUJpz2ZPkwdcMVR8PE25rvbcx4BMxXdh4ESs2oB2oprIX3Me8Srb3vu3
 Prp4CDy1NBlnKAGaFoLRZ6MiQ/oTC//tXyS5yxrcmxvS6wKx1CeH7EcW/tdO09yjqh1e
 1WwTeVUlQr2ENUtaqb/dW/GtiNZOj+6pQGZcQd+ceNE3JyCNoeMKa6NFu407X973CLlW
 kzvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHqiVuWUqj/DFwGd4aUk1sUSbgeupJduzv14oERonGIUCZx/J7xS9KRkMWUnmkaZe8xL6UsUgQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8VzkmLrkplCt35uOq6C4BeA5/0cNM10ojyNqms7HoR8Y28JzcG
 Cezyi3wWMTDZiYSYSu6QW4/eJEh5d1ZOqoe8tADQsfJqH4DAxQPuhpG/DqPTH0+9qnLFBp6+YtM
 oy/RoddB+sRNVAHLAu9+VQ7POF9thsgM=
X-Gm-Gg: AZFdTZcVB9m7BlYDCSta8N8ZR0qEOP5jfKJeHI37AUhFfHjisXRDEMy/RUUr4N6FVZQ
 FvaLH7kuInoEYR65yQ/LUowzkxumYg63wbhHRRwrUEK2AWwAFwgv1TKdbyOthSVLsedZWuumXd/
 xiNH3F41kCi3X3KhNK9O8TYbib9m2xr2bgJfCjEGv3UF2b3ZY2NoIemiwS5rMuIPT6vCi5Ag+R/
 ihLOM9ZFVF5RlEDJWxOG1ZXFj7ufwjtTAZzI8LIKmV0A3EXSXiD9Vhnbx9ifn3Ko29lTo3YPHir
 7uTji1hYFjQcuHu/d/kDK/GFZtgdnCOzJHfIWjilfm9QlDbDkmuSmXjwgXmJJAmzmET5VBSwopZ
 xfAJ9MT3dG6PHR0Kw4fF7yQ42WEyMsAYfj3lor8S9YPzAv8SmZntYvbtyUvhEYGpvrcmz24mi4e
 1gjak+zXg0C1FYjzaWtiBr1S0cmg==
X-Received: by 2002:a05:6512:804b:b0:5c3:1ac3:131e with SMTP id
 2adb3069b0e04-5c31ac3132emr1943492e87.20.1795690235163; Thu, 26 Nov 2026
 02:50:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
 <20261126-update-tqma6-v1-1-a105aba78868@ew.tq-group.com>
In-Reply-To: <20261126-update-tqma6-v1-1-a105aba78868@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 26 Nov 2026 07:50:23 -0300
X-Gm-Features: Aa3M54rZcYg6M8onv39RNbvgrVo0q5lVI-qd2J8-sjrtAbt5i9DIm0oEQ-F4KVY
Message-ID: <CAOMZO5CV=BV07naQgYG=0f330Und_haW856-S2tuMpPBX0W7EQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] configs: tqma6: rename .defconfig to .config
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Paul Gerber <Paul.Gerber@tq-group.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Johan Jonker <jbx6244@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Paul Gerber <Paul.Gerber@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Max,

On Thu, Nov 26, 2026 at 7:47=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> Change name from *.defconfig to *.config

Please explain the motivation for doing this.

I understand after reading the full series, but each patch needs to
provide its own rationale.
