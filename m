Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45425CA5FC4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA66D811EA;
	Thu,  1 Oct 2026 01:07:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fe-R-rXUeZ-m; Thu,  1 Oct 2026 01:07:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 08867811D4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816878;
	b=k9OD+aGKbXHoyoiBqrBZ0h3mBAotEcEVuE2N6+pmtTNQKkOOa4un/kNfp4ee/kU4KT4R
	 KVsPiXXMiYqFHaFmaIqU+HyObDc28WMMgn6xYpI/7dIXQhQ/WshoO/F7DG1iFy8YCrRzR
	 XxPCOl2uwrPXReJwsuJ/qvoNxZGCpQu8gqp71WTy8elNOQPgUFhNMa5BVoOcmTKyrbhqr
	 WVQ7bhx7Dq7EvUmzGM1vyxjHWwUUtbQmtxfCwif2NbBTy4ZlUA7U948EjnFZLxFP9tLEM
	 gGeT09RRlrDF0IT4ugusSkQwPmFFP7vBbuhUvblggCabxzAzTIyD4KeRsK9wAFXwF0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790816878;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k7ou6Somm9/5EIi/vz8/eegUAhHlr8CPCq6Ctaqi3+0=;
	b=h2+sxKcQTPo3Eh0U89WG8WKkvWSdVNkliWUv0Uu5QZXMRAUGtl4qSFfLTv1hIBkePP0Y
	 H6UGuxMGLJmRcFV+VRYPlFeiJsRsuzNfTuTIvdmSkl8Ojmh/nEr/evHVJnIOOHZ9aVFXn
	 6vxRcOapH/32ZtHoDxZZE02UIe7dFSDf/Turdev/imXkdkYp8xPSRn1P0MaAEuHCsOjFN
	 /pSN5K9i7WXKzYpCR7hpdw9vxH1pnypVcv5so8Fzb6/0tRwiDrK7hctbRFSHMchQdo8y5
	 L2I3HMy+ODSSzBOcJoz9wMmgV17q8Ksd4dwh+dovGhR+ThL8DvtI/OI4IFoNU3xeOpQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=A31ZoSSh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790816878;
	bh=k7ou6Somm9/5EIi/vz8/eegUAhHlr8CPCq6Ctaqi3+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nh0qEurnREG5ajktyWr8lkd9H0pKvqTrNkITW+bqQ3KR8BjKA1w1E9POXoF4QOHDI
	 aPXKVo6GLY62RdlWPn/LAc1yMLeajSw/9/qGROhiXF2qRh/lYcFQpCKf9P4zBIPk79
	 v+3ur8eCvUmcgoTzH3pOKjlo4XoGNCn5DtThzUt3SOb8oQldCjTxmcvNor4zdK/UAZ
	 WtY1gIluzDYw1EzT5Es2vlGbM8DS+TCIgmbF5yvaxacps/KrrNUHwd2ppsDlWPy9tG
	 LhyhJAxNmLLom16iJq6VIdR3+nA2fSAC3c0LiD/gZam1Ml26KvbQpGRB+lQFfOgjma
	 3MP6tHrgPlVIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08867811D4;
	Thu,  1 Oct 2026 01:07:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67EB41A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 594A1811D4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:07:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyC44Kn40P-8 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:07:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0FDA9811D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790816875;
 b=rd7jMkZ7spbkYqw9A4bXH0/gNYp2LRVv5vsDWfoJVCSwjI8yoGDJiPpmZ/hw5nL5+nIc
 7l8j3WWvmihGs2jBE4uDv/dX/GGbrvNbRMF91Rn4wulaTgPU1lHV2DNEKEDcJa+7Zm6jk
 GdodZ6C3VdMaOmmZoKaBY3zFiT3/TY0sLC6jWcZSiRX0mcgl8cN0kLMX4SrdHFmOv7O8l
 o25FKOlT0DDYvHeD3WllRgYua8TlB7ksuWmKu0nI75l3icoIHdN3r63iSapLMvi/wHnNQ
 sA5UmVnMZXFnjOTiaVfZXdxtVLGB1UlYb+ZyfmnVaw/gQ9apsOvhSDO0C2Hxj78BM3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790816875;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=k7ou6Somm9/5EIi/vz8/eegUAhHlr8CPCq6Ctaqi3+0=;
 b=KETP9a6qoXC6FYyd/Aqk2lcTFwreHwKPIl7a+9oIqN08OBbW0dywvRiG4aTRjD9YiRfH
 a+OksWD5oQA7ZaIKiiL0m67C/jjt5hE7PjPAHyVgGzcwEDur5Npd/SNheUp6/PCZjKehs
 LSNVr3lR6q79WHlJnf0XRoP6DTiCTJWZi63AWEJ78yDxXf/YnCzxe5MpUJ3e/pmfqNHgK
 LaftQadDnZQVIBxsJKkuwX4T2opiuX3d5lxve16DsgmMq3M1qOmvWNJ2Z8IukqG4IGSO9
 CaO9JSystM/kso7THn/d9CWdtuQNG/jEc6F9EWxXo2Bx3uGQOilKoY2BpX6BPbmmnXA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=A31ZoSSh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=A31ZoSSh
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FDA9811D3
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:07:54 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2e1432bc59so203691966b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:07:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790816872; cv=none;
 d=google.com; s=arc-20260327;
 b=LDjmuoQx4fGIPw9f8u9aamA5OX3zW85QnicfDfsYzuf3mhlAqvh3A3Drte17+HCN4n
 gEOS2/MFlZN7p60j8gVeAqrZWwy+mg5U2ZZWxtUavH9xlcNUj32zvTwzTdjNbqWWcRqi
 Fri81ye/QplTbfcm3fimO5QVnkaOLcKLqiipGPSoXBEDQUigKRuReaEx34Pvax+s5VJY
 x9nDUdPR1nIQxJOAj22bV9iY+YW0hnzwZY9k6nScRUcj/yoIjMxqCqDEHWr5fCoCxiJk
 ty5nXdnj4pQ3oP2w+PEbIQ0OpImhHRqs6HvSuF/Of7miv5AUTIXz7kufP1DLyNtErmCq
 trAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k7ou6Somm9/5EIi/vz8/eegUAhHlr8CPCq6Ctaqi3+0=;
 fh=+a4ub8lFAc9b0mik1jHhGO4GYGqqASyYSmSW/GjCf5I=;
 b=gRG5vQ8d9XCxGmN2m0ETiOVVDvulW8yIsMic8CJQMrRA1JIlB6lm1SlMDLG07dzgRv
 K0kZhopEBrcXIV77DINDhgoB6ZO0Yy6EVKqGQtci7gnSQM5p3XskVsBhTCS4xdkvzx4I
 Ey7qEsk9pTfpmRt0Ews9hb0f4IIlOcSmgRzBaAdX3+/b3kFs6OG91Ug7rZ0Mljsnw51H
 1fbneePdm7VRj9mvnqLQMMrmoDQcSeJbyBlcHwvNbu57THkVX+msT9i8QV4+UGjga2/A
 T1BVSVuRSwBfveQNgtrlPWA7IFw1RNpz64OpCNn9Yr69Sw6+OTWB38Zh/6djtbKJ0uSa
 7NFg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790816872; x=1791421672;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k7ou6Somm9/5EIi/vz8/eegUAhHlr8CPCq6Ctaqi3+0=;
 b=A31ZoSSh8+6Z2lNghT0xh3W63XSMeZClDoGWXQnsxMSgbnR0m9WEyLatisKFv9MFKi
 3Q3OUNYaaghaLW0ojNeW6XnEcEKqSiDq+WjNmQijZTnpQYAAYg37gOn8w6s2Wuis0tKt
 73rkSJmEMjQj1i9WRlj/pi3brSy2e52faRe94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790816872; x=1791421672;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k7ou6Somm9/5EIi/vz8/eegUAhHlr8CPCq6Ctaqi3+0=;
 b=wqUsIXR8JITMLaFMt+B4SHz0jpMyXDnA1Hb7Vuz6fA7A7TW34oKefgeOoj7W7rJTlV
 6M7XaAhZPttHvfnk1xoUoagYaDdK2eb+xXbiIXfM80svtFD3QzxBB0Kn01XIsLooDlqZ
 Dxd05biRDIih1vlBkxLzQW4KT33o/rbTyG3wA6ItmrOspG1t8Ht/R0XW5PKFdSljjvcD
 KWDh48iXuWR45qekwLzEIroxaPL2YzE6F5rJrAaE/1uP1M0ypFS25T0ZD9Jmia0ckXHc
 rinnZhbkd9QXulBSmPVDTFWhKMyQKpxbvPOp9o0npDk0ehf99jDrZnxqwqiJ3svOcybJ
 /kZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzikmw4jXVEoCMw01DgUxagBtNUaCoIsc8x87aXanHH7SDQucs2x+evFejt1K9ETkOg9rtqKT8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k0RfE1za7o4g9pb3hIrlZzKJQV7vc+tz0sGtX9mZiAVBOHlOp3
 eLVPuQNqEDiDu55S5647ziPvHaMQcJ5dNSwP3LS13to8Mrw3UBZWwSBXUFAvtczzuGrRk4zQoyj
 b4Q1pSFHsjJCHJkAuolCZl9CmGmucG+NDAbSsk8MU
X-Gm-Gg: AYBFou3qCffhGwV7+twlykeaBezOAk6bHO1r2Vy5zACYPt2WpJKmiM1WgZ/lplkK8Zp
 cRdNHqG6uZawwlLLNSHgSgLOxBHK90c43fKrpoBa2sc0f1r+nA2sU7i10cBQi4oNwT7fPVqOJUu
 y36sU1GogSjykDSXHOloI3+4sXP0xEYXMwMB2Q2MPafac+152J8266bKmFG5L9ZG9GGH3uN/Dg3
 m4TioGSNUZazlLspOujyu2czmaLerAWbGzbVL6gi+EXI0MOEHrGuBBFlFjimX2dMVS5UHgxgYsd
 PAXofosN2sA+Pd35XnIh/LDtEdpRioSh6ECOEMDgxA4WV6GtUk6innCP
X-Received: by 2002:a17:907:1b14:b0:c25:cb7e:1cc9 with SMTP id
 a640c23a62f3a-c2e237551c3mr229040766b.7.1790816872570; Wed, 30 Sep 2026
 18:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
 <20260930-imx93-secureboot-v4-1-f968a1b14dc5@bootlin.com>
In-Reply-To: <20260930-imx93-secureboot-v4-1-f968a1b14dc5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:07:38 +0100
X-Gm-Features: AclHuK_YxRXKgL6czG63_RZ4PHc-15qpU8-x9IEHrkqHx5KwY6wUGM6J2mwecHY
Message-ID: <CAFLszThjAst7Qooy++qsD3RSQY3EoPmt=KYXExny8N3X2srjZg@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] binman: add nxp_imxcst base etype for i.MX CST
 signing
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
> binman: add nxp_imxcst base etype for i.MX CST signing
>
> Add a common etype which provides the shared functionality for signing
> i.MX images with the NXP Code Signing Tool (CST). This includes the SRK
> table property handling, the CST bintool registration, and helpers for
> writing the input data and configuration files and for running cst.
>
> The nxp_imx8mcst etype and the upcoming nxp_imx93cst etype will be
> converted to use this common base in the following commits.
>
> No functional changes.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/etype/nxp_imxcst.py | 120 ++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 120 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
