Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D110C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD60820DE;
	Tue,  1 Apr 2025 15:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GgAMEXZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C4C820F1; Tue,  1 Apr 2025 15:27:42 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB4708209D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30c2d427194so56056661fa.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743514059; x=1744118859; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ko7g6txShFIYBfQ3x2ezAThM0uv+iWyGnLEdyCZoa9g=;
 b=GgAMEXZJNjhxzCSJSqRhDerIRaXK/RnET5SmZodye6B0NTs++GLQjW1sycSjF2yRH2
 ciif/wQwpiO1tTnvZJbNSfhz6nt1uWdnjt1DxMUO0p1IrtCc0AsljIae8JjOXwNDpzsO
 U26WupKQR1W1LxOeEtQjfGsVeJoDvlFDE6nwpeLsZJI119rxEY+rSQBm4pbyJnk8XQNZ
 YtIcLChSLddxpc2fZCyn8E8IhsGSY1uqeLFRsT8dZz0Pk15aK8tL9S29o67to1Wux7Ja
 aPOzmgTL9MyQIexOcAAS3eI+Fjv1/SqZ+RCBGoVcmMaU3Ce18sGQDjycM79or6s2JREq
 K3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514059; x=1744118859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ko7g6txShFIYBfQ3x2ezAThM0uv+iWyGnLEdyCZoa9g=;
 b=jUEahy7SwZOwPg2Im/ggPG3sVXcXHKzaDEKQHp7SEBOi33OzoUyLtz2NX3k9v5hB48
 1hltMiKLb776dZD7S6xVhdnS4mdXt/EPQEpzwgxqFeWveKjia239icwMOTo+k5loSUvE
 Ms8wUct4pWpJcELSbKt0+6fVQCsbrnlWhq5abaR2Tq7Bk3gIAI9pWMIznKXDqMGUJIwq
 cpCwF/KifxBsTpwdClr/bOS5QEjAei5XIcxbp8/mCFYce8vjefQ4j1UO7JNxmc5K3CN8
 OelGRTJ23L5XMumWRWlCN18BWAFqleDLR1oOXujtGsJsTXqEwDmVXpJEt40Q7rgbss9s
 5m7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtKlGnn1OGvqioJ+h81TLVtizixBQBcB9CuyHlz1KuKVAF7iflglGOKONfXjRrmLezcFmluFw=@lists.denx.de
X-Gm-Message-State: AOJu0YyQ70hONrSe0O59fp11eI357XwkUBqkG5ARqt1Z/VdmRjEft/Pl
 mChMSm0XsqG/CSsFwZfaxH5UEvn259d1hxoLoL6I0o2AsQwyLlCCNUqYLdTMXxUcBK4U3sQpx9v
 c/k2V5WYUwgPEcanybx0k908VJH4=
X-Gm-Gg: ASbGnctrMiE4zXX/W3aL1PyfYJUOgfixoaY8fddn9ma2zuj9QnSS754INIyfq2S8cYa
 BghBsZn1suMWctkxpoO7e4sM7HA9kFVCQfXkNMiOJ3CB3QWI+xpcq/UXcO9C46IGbk1sI5x76nN
 Qy11PtNRbe4zfFPzbTVgjEe8CsIaD3W9siFzjcRwC/NP4URzA6gpAf+ddr
X-Google-Smtp-Source: AGHT+IHwsJfu+PWDnxPU55Ti/sNMifYuobvE+ApuuAWaz3sjsBe2oOmcAIuM+1BsGrLnRihQIrPpjMnQV0F4VbXdexo=
X-Received: by 2002:a2e:a593:0:b0:30c:2dbc:6e1c with SMTP id
 38308e7fff4ca-30eecd8cdf7mr10434121fa.31.1743514058867; Tue, 01 Apr 2025
 06:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
 <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
 <20250325080614.GC27303@nxa18884-linux>
 <a84f63fb-61c2-4f0e-89ed-8046e8eeed85@denx.de>
 <PAXPR04MB8459808C7CC6C16DB43B973388A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bc232085-3efb-43fb-b176-eaf43e52f1f8@denx.de>
 <PAXPR04MB8459F46041C7EFF7191F8EFD88A62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <bbb8ecca-789d-40cc-93a8-e7284e1af840@denx.de>
 <PAXPR04MB96445CAACB6E8413A03CA386E2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <a3007174-30a8-4dc2-ab7f-da1c1de52440@denx.de>
In-Reply-To: <a3007174-30a8-4dc2-ab7f-da1c1de52440@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 1 Apr 2025 10:27:27 -0300
X-Gm-Features: AQ5f1JqPqsT-CFJaT45UAZJsPkBmXrYaP0ORfp6m3nWHfg98m2Ds22Kr10rhjOM
Message-ID: <CAOMZO5ADxWjgSyYf2MKNodpRbJTRxUKETvqXatB_N510XOy5xw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E5=9B=9E=E5=A4=8D=3A_=5BPATCH_v8_02=2F19=5D_pinctrl=3A_nxp=3A_add_a_pin?=
 =?UTF-8?Q?_controller_driver_based_on_SCMI_pin_control_protocol?=
To: Marek Vasut <marex@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, dl-uboot-imx <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
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

On Tue, Apr 1, 2025 at 9:53=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:

> > When will this patch "[PATCH] power: regulator: scmi: Move regulator su=
bnode hack to scmi_regulator" be applied to the uboot next branch? I have a=
lready made the next version patch set based on this patch.
> Fabio/Tom ?

This is assigned to Jaehoon in patchwork:
https://patchwork.ozlabs.org/project/uboot/patch/20250322014444.174796-1-ma=
rex@denx.de/
