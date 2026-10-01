Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7627FCA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEAC581219;
	Thu,  1 Oct 2026 01:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQnfOMisXk-0; Thu,  1 Oct 2026 01:08:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5951D811F8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816889;
	b=jlLJe21c5dPrStIXnd4DfyioH3635JO6f7wDoV0kCmEjJ0eAD/5EIFflAbZLiXHzRbVd
	 5wqLMGtPEx4pXIh98otBwLP45bgy6+p2Nlq8iQXgoFEXs/FCXt4KiHMoBn8eFdyW5+KRd
	 JfQXSYOzsPqGG8/fi3tdO71OEaxqcuPLxNIQN4QhebZut3VMwZ310S8HaCIeUvsWbmp+e
	 xwKKyxQd+AhRtWEIprkvIJpTFoPebkeig1l6T6HHzNGfL82iQvfS/qBjbLJ1e2e7cU6uG
	 hneUQjqLM3h7VjoQkVqbYzIdvqCl3ZXmGVfhGLvbAy5Y1Sskou4xjs5Ioh2jatrXM0g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790816889;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jt9W3e6/wEiCLIJXOkKbAUrugWtg9bhWNvmdD93Mso4=;
	b=RzFy0TZgF0b6PaOfWRm5z+pLKeoBZ1P5tV4+w35ckY+Fo+a8n8OqOasnMgi9IRe+lVvv
	 w/MY3W9OyHHn+5/6SG8YAHqZOVwigVEgNHFzyWPW+6wiqIA5DMxsIrH+v9ABs5eThg/gW
	 tVjUiTBV4CeizdGMV7DL0eElhkaHFnvcDwuKItzcC3Z6l7aDN6sj3X582k4xYKZ7hbxcc
	 y1RcpGwK24YoUAx6FVpSwJsk6s6YRMZ1/uAd2H5s1p1sUcZ0WdsTME2bpxUVDYq1WO0xc
	 yY1qaHRGAcd3xCcIMcO9QFjK6niindWta+auzel+Om5KfyREfu4bQ66GmHnEYTkKwYg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TZ1j89TJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790816889;
	bh=Jt9W3e6/wEiCLIJXOkKbAUrugWtg9bhWNvmdD93Mso4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C86YTpKchNcCw+GMLzq5g6BwYgG79+P3JTU1s/1TLN0pDIfb3us8eq7ZuKHMpdPNN
	 NswkXoiFs+WHAaPFAVjSz2J1H1K9eORudHnpCgLbJvaju4xuz9u/EN9U1IsXnesLf3
	 6yjTpgN3c/0SEvjXiduqiJ+7yBFXbnfNG27likQqg0qySzp6RFcjbcKcsCH1QEa3mT
	 R+qBdmaL0ebHp6JbI7CVrcBn1tLtNdvVXTOSDTEs6vN5i7N7BX6yXkR70MHsl3RtuO
	 8C/uyEaEG2TV/uP37rYYJCqE8TNFaQ36jrWO7XYvhoxSdjZaoOjCXwlY7kbg9uEEUL
	 2GkL+u6/f3HLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5951D811F8;
	Thu,  1 Oct 2026 01:08:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BEB9116C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8249A811F8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rkIAEf4sC6Va for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 92784811DB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::1c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816886;
 b=hc4okJSgSUyw9BM+fRQN1OC95aXjAIstSVy41lSfJ41k7J1812nor2KHuhZ+L4FNcDbE
 16k3gHQuO04c1trkd0YggIgjnhZr8hlnfOb5aZAfLqOne62NbMaFLtMA4dNuXi3XR4mUo
 bWOAykQj2j7KREbnktrsaviSyz7YwuwQV1E2i/BdcsFp3C8sHvkBFLepJRXtbUNm3Teb0
 EspSiUHse4YVC8ekI6iHi1fnK/zJtNf/lm/IjUQ8yfzQ3BCqqRGVC/95cOU7pR2WrsWKy
 T9lql7LXZRfrOcl7qoY7jBsHdTT2IITphCA1X2iVQDOei0imb3uhDtzXjp9cPZBG8FA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790816886;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Jt9W3e6/wEiCLIJXOkKbAUrugWtg9bhWNvmdD93Mso4=;
 b=TrnSoI1Iy47Nyl5FZ9NhqmDJOeMmfe8LJ7HVUjRyz47+WZw8l53w/RzW+76Jq7MpXwZZ
 PC2V8M1WcpGqbR6o8LLr9NajiUxOu8NWt/+BMDlWS38p8m5A3ZZzcq8EEGVIu93ZqArrB
 CfWfCouKbfJjriPZXEdiQweGG4q2mCe9MuqcbkXKi/HhGyIRQAMFKHlnAaXBqhdj3A/WX
 KIXPctoJPIqKbDSwx9wkr4tRtjnxf7iFRErKyKNmX1I7M/H7lNSW/8Sj3XDYNxAx10NHW
 fBFECRo+utR2Ghvoq+Mpl/Fe6+TzQ7t6TojYb2h61kBfmpA17rmRu30BhEXCC2cOfBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TZ1j89TJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::1c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::1c; helo=mail-ed2-x1c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TZ1j89TJ
Received: from mail-ed2-x1c.google.com (mail-ed2-x1c.google.com
 [IPv6:2a00:1450:4864:33::1c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92784811DB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:08:04 +0000 (UTC)
Received: by mail-ed2-x1c.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso10160515a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790816882; cv=none;
 d=google.com; s=arc-20260327;
 b=Mwr4i6QWP6si1HU18QYR/uPIhlr1OuTmZs0PhqSi0exs8dcmLSPPICfbTh/TByfLme
 I7zjDduVTmO7DDUQcvS/T9iU2kUI1xai7sBRz/oj7e0d6H2kSKWSLe2xLNo7wTTFM02g
 c1/I2g/xm98wf6neZvzw9H1WKcVI3ra+S9IiyrVlTu4C5wYZ+76fCsJqSpjfIu9XsdzS
 kDGzuwqzbgwT1dL/T1PdNbAdcit+Eb0MTgzWDL041eWNIaWjROxoLEtZwHGFjJE9tRq8
 1Xvi3gGxRYgoE7oPNnon6lalDScz0ddrocO9usV7C6ZBj7oCCU4gEaBU776nOu+xzLik
 jwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jt9W3e6/wEiCLIJXOkKbAUrugWtg9bhWNvmdD93Mso4=;
 fh=mmCWSiopKOgagP4rQboMbEICHJae9OdJ/ilYIqNg4lc=;
 b=MJ/yANDOYJYeU+RP7Q58cnB7+qixyfagWnlTzi8V3PRKC6SZMmutlUgpLkj5/ksBi4
 +jBV+aduOHh/8PQUWHDni3SJO6AAQa1z4aVQ1h3owRBl1/1WM0MLr3UyXnzDwGApyg8B
 2U4nqkraaVoDWxf1aWxF4H03ZrwHVblTB9Aqa0j922wCJa35kj4AHqCXaZaBa5ZWelll
 UCDWsui1MfnPLvDTX1yZ5jKkq5KRshCkykRBFr1ZV9UpgFmS1VIigaHynMmJYGr2TyO6
 +IFS38jo6D+YwdDjoEHOmVM+CksBImQW3MonrYsVWzizMZF0jIDIWpQwgw6XWg/22wz2
 jFCg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790816882; x=1791421682;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jt9W3e6/wEiCLIJXOkKbAUrugWtg9bhWNvmdD93Mso4=;
 b=TZ1j89TJpbL83bP2+NdN7FzgaVsgWPLtrDVFmWc4C73Fuy7FpUzTgntHNFLe8pbM5E
 dSsDhNGzBe/dRVMkct/UmG4/1rlae+ivQ4963+OTzpten7rl2+hM491Ko4mXZ1dUPTig
 e9xxw8cx610UByaSAHC884d08u1RSvMx8+dZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790816882; x=1791421682;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jt9W3e6/wEiCLIJXOkKbAUrugWtg9bhWNvmdD93Mso4=;
 b=ZesobqGJ8KBUkpJHV6MK70QGpvoht3RavumsqvDqFX6PsczLuCS37DBOy7qTTDrszQ
 VB8MmljxKEhS/9Vfmcqm77zK67BXfrh0ce9lgPInZ7bXr7+2q2KH1/vbdrsz7SM6FZ9u
 DNuk6eYATwME4T3CHPcZIVIxt5ESTaK4K8EgidaOqsDiFXgq7/ziduBwDKeV4+UzNKAb
 PmoPBpKNfizIbxY36BK46LociGmsuOqlDCXMY55hYI8at0jPPf1B6oGeEE4DL/odqmqD
 aCZjcl+n2RnqHotko8RRVXTJO6q44TA5PKJ+bHzFfxZYkhCf+hqWGemjAdjelJ5QQsow
 4z0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgKwj6uLlfBJCojBHxabDHVn+euUfxz7wp0qNq0sA38yQXn2A+XkItII+XO0orqVPBIjwE8Y8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJL+lR++OhH44ozIC0Msc3DAPzgQiOyENvMxlDKjJWBik6pgGuz
 Gd5t1sJpai2OZe7U3B35Sngh3OIlCezDeN5UWu4jIZN5xFtL3ytqiub87ePi9CXDJ5utsFWutU9
 rQGayOWMZvIDCljsbiE36udKpV0vzgHprsyB1DQoL
X-Gm-Gg: AYBFou2zda+cU3cdMUmMg1tNcGZDNjUBGWE6ZeHSDXQwROaVaSYESAgJo9pbrp39ans
 Ui3hzJTNICPGgNtRbuxRukBa+XlYBGgdxSTkbzgMiFJgECTx/fiFygYgj8pU8xscDULP4CPQF5F
 2HzJWRF3XcE5/fT+Glg8klTd8mIUXc+mH85PN/3+1OEoCcC20Bm2C/9K6pP4uaMbfdwlySvNi9c
 MRw42ng6+3MnC2+gMZsreejD0LahCnxL6CWehK4FNAtniwiBSpLalFkBJIhwU0RZGnXCZ8PfvJm
 szjtkPNR8lzFQ42z8wHW/qLfM4epnEygFvq1gGpUj1gCW7hs3TSS6cQcBqcOB54LRZQ=
X-Received: by 2002:a05:6402:1d55:b0:6a5:fbc6:cad1 with SMTP id
 4fb4d7f45d1cf-6ae198f3b4cmr2209160a12.7.1790816882241; Wed, 30 Sep 2026
 18:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
 <20260930-imx93-secureboot-v4-5-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-5-f968a1b14dc5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:07:47 +0100
X-Gm-Features: AclHuK8av53ZkzfaoX7QbZTSmT_IUI1vK8KhzzJqkCZM44VtnunToqCyNpYl63A
Message-ID: <CAFLszThU740rWjtCaKSkyGn4rHDTRcbqxLzqpOT_9LOJKZmiGw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] doc: imx: ahab: add AHAB introduction
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
> doc: imx: ahab: add AHAB introduction
>
> Add an introductory document describing the AHAB (Advanced High
> Assurance Boot) secure and encrypted boot flow, covering the
> following topics:
> - AHAB architecture overview (SCU, SECO, PKI tree)
> - AHAB secure boot and encrypted boot flow
> - PKI tree generation (ahab_pki_tree)
> - SRK Table and SRK Hash generation (srktool)
> - SRK Hash fuse programming and sanity check notes
> - i.MX 8ULP/93 secure boot support
>
> This is based on doc/imx/ahab/introduction_ahab.txt from uboot-imx
> (lf_v2026.04). Originally written by Breno Lima, with contributions
> from Ye Li, Vanessa Maegima, and Utkarsh Gupta upstream in
> uboot-imx.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> doc/board/nxp/index.rst            |   1 +
>  doc/imx/ahab/introduction_ahab.rst | 459 +++++++++++++++++++++++++++++++=
++++++
>  doc/imx/index.rst                  |  13 ++
>  3 files changed, 473 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
