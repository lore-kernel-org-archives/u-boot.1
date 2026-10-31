Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B7606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bZU+JdXX;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fhXOs/YG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB33A607A0;
	Sat, 31 Oct 2026 08:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W7VCjkSoSrry; Sat, 31 Oct 2026 08:44:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35D2E60A7E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436259;
	b=cKCGxnThx9lEqsJAn+/vm9Ya1xgTblmcc5ugh1ba+uc3xeZAZr3Y3MjBXNTu3MMdmTGb
	 J5j3RCEXMyOxOuYi0zdcIaP6162dQsggRWKv/pFqD4pw6mQH65mYj74PBrtqhOipi/cr0
	 qRXA4m37sH0Pd3ul6ntAPX5OT+BNnG8K4i+Uiw9fVLdXS/UTbkrdSBfRZIZgnzLJeemgN
	 TUktm0XX46H69/wYGjR/L/wv/yxelv/vyutRZiEn7Id+2u+xyZyiMDuGva5b7DOMBibum
	 a0qe8wsbhsHZBv3OIpqDw1BzLizwOLLBKqOQGyWp+gHK14GCpKPUJ6ozxZaZIrOD9iA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fkIcTgd42UN+22JohF+2V5ZK5ReS6iyX3z3NVgmQyPo=;
	b=qsFlwaXXgjczyvat9YCC9YtQBPq0LE9nrJbwSJ0BQRZNPDIhjfv/x5WMP7XlYJlzOMM/
	 lnXy1M8Cv+6PWxW0sFv8TUXrqJ3clprvRGyBYM+oK4XuMiD6Vzsbh4fQCbxtOQDK4KkKj
	 Ueda9aNeIGs0tH3QLfn9Rh+bF+WXInX0GKgmn8TyweVuQ9BxIH/UORV5GWB+U5zyJCOr+
	 /Ii7r1z8tRY4sDJEjam9CH+HD7JJ9Um3kTqYY/ojhbZyzjrwQN+m8Ea2jfBcZW4J07DRp
	 OR1uy6s/G5u5fmUF7AUcO9ywLU+bIU0cZY07KgFsPfnmw+/STdzPVjLHVYJCya+jKfg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436259;
	bh=fkIcTgd42UN+22JohF+2V5ZK5ReS6iyX3z3NVgmQyPo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bZU+JdXX1vLLfUzrZCErXGhhJKzkj2iuPWHvmldYaDEfosayvLGTmHuE07wjhp0Fk
	 eQUuvTvC9ad8I7JDjNdx7MIhgHsUPVRKS1y4ICpVuxgamV3yj2/hxxIWE8d8oJTuBm
	 TBFNI964X4SMGUxw8tSSn/mIzsXJuFTqDUAOsNXCCiUh0bG7HymfpP14TOY7xORd6b
	 Z1S1IK+3VkxMbdzcDi8ZzyFuAkOKi6qsnIULKxOUZ1uQ6YYN3vi+zzux0GYItrJ3g2
	 eKlEVi6MCpxC7cE3WUFimgT5GtoU58bb4quhqRXJHzWc/BPi2H/gxFAowgxTSKx6zC
	 5+zjATQY9gWqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35D2E60A7E;
	Sat, 31 Oct 2026 08:44:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DEBD380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84107406DF
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HCE4P0p5x0T for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:44:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF0A6406B9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436255;
 b=IgPNz1YWf91406EPCSq5QUXJM7ehRoustOHMwstXor4Dk8SGjyaq8rJQcmV09c+9Z0+V
 9WC/n71Uk4YIsSA+AhhvHCOgLclIWL53eyX3RFr3YR52+Haw17o5Gk5byrwy5RGFlkNHF
 pn26nDOegSYemyLp27EKkWMtnIIeC+/2YepeQyiLEpi7mR0uo/xdUBW3hhppjh2L7EpQI
 4aehrW9WjTlz35FVsCjLqOJbZL766QdHnntQCoeuq/2tx/UXlIFU7wg+EEvS49wD6jRHt
 EjsfTEIZA/6Zkecmt7s1o0uQTQwKqk8THym20vVIDVVisPyLAL0whzm/03Pdq7eXryw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436255;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=fkIcTgd42UN+22JohF+2V5ZK5ReS6iyX3z3NVgmQyPo=;
 b=Ty3N6MIMTy1EdsLkpK8qreHvcUNudv3IHTrj7ulzogH+OqL/6dQG4g0ijG65bGvBzc2J
 eEwbQZmrapk9Z4ItGTlPNx8ga3Yg+NB8jc/yFfOIpq9/OjaAxsLvQkrnQpRvcKS+UtaKf
 z+BWkYER6nT1hZ7VBtIHUm0ETLX95pe6O6pSbaxEwzTI/COhC/FIpO67DWw/mlIjrCB6u
 sd/iAdo6P7qjrG5wr7MIP8TrGMARitW4uzMv83yldPPe9snN98SsR6qK5AgUhWRU9HGr3
 rRTf/I+H3Ne+vNSOWpSCy96jM9J6tqgvOoVZxyOM15/GmcEz2CSSUvfu6idgvX3x19w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="fhXOs/YG"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fhXOs/YG
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF0A6406B9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:44:14 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so591000a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436254; cv=none;
 d=google.com; s=arc-20260327;
 b=YWk8ccNddi7Mcv/d00S+WYsMelT9R/m0ZNCqx849CDu96bo3INyGrAoyKdH34gRPgP
 Q/rOJ+ZZmX/iOAG9CEo3oKytC+1hngIJ6RnyS6tqVAQV6aCxfoRXxFRVUKXP4cOih08f
 UJKkr6SZHBnZ5IT8i2cdDDk8YNg1w8Hch3Jl8bx6b92eWOPkC2MY0/J3BOKTHnRvU6gP
 M9//enkzaQw7yq6Zjjmvrmu4OPQDRkPfFV5KsLjGtWaUWv9DaxKIrOn17wCYgQWzHbZK
 SHUaf1tucZnhVTOvqg8S8aEeBZtAsr1ThtktSfIhRsIKsAlpCfy9vykA3v9/WDNY9bo+
 M/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=fkIcTgd42UN+22JohF+2V5ZK5ReS6iyX3z3NVgmQyPo=;
 fh=2V6GVFDG22OBvXgghdqzGFawlyrWxSONgmk2MUN9Tu0=;
 b=K/CXGT0m6fKV3VBhQBwkw2ueHQ2oN6q1TeWBzzK1m6NHkDZY3x1wWtgf0mUgMvann6
 Fu6g/m8kovCB8IKtYIM6cj2Dqvi2gcTB+TqOPcci+WHup/nVE+STxFYA0RpHkIUcGZXf
 WVzEQAt1oAcgAycMMaQRLWpbnM0Tyh8gB/rMfOtPQ5qlMD0alghdDZTO5kLJPthUWQyL
 JRVp6OPvElci9J0OpmPIAPJD1pXxCGhnxLNTe2VLVDMfjVf36AoYNd2UrlCEGa4IZJwo
 uNmx+UDvAToxp+hbHLsAm+X3e5cyoT9BDFlYhkWiWAF1CaNlF5yU+DSFItVj9oCiqGMS
 Z0sw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436254; x=1794041054;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fkIcTgd42UN+22JohF+2V5ZK5ReS6iyX3z3NVgmQyPo=;
 b=fhXOs/YGb5kj/G6A0ExgT9xHY15N4db175wrKUt8aLViLkE0rxC+vzr6FKalNHFY2R
 fLS6UysofWpI4yg2WhzolPXyJnPd1xZHqHMjTlqxnVo1cmJ4mN6XvG34otzgmyUiIrMG
 G4CxMgH2a27Y9nYg/gDYHZnZfJvOIOHYv7GMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436254; x=1794041054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fkIcTgd42UN+22JohF+2V5ZK5ReS6iyX3z3NVgmQyPo=;
 b=aiHIs/yNuvbQH6LCoYT0QISfaypPbwuHleiKu1VUaQdfRFkNPTA8qdsja7Ej9OgStZ
 NE9UpZaNbluL4EU3xsVeStXaMoQ+E85lo57o+n/cDYXGiIo3vhSr2Jq/p8MmY3lpUIAi
 KbyInIKsM+0415u9zzNM+yDLufnSZiC0mrStBo9UyCQMOQM6NYxUM8vZAPEyyMhONqoC
 I/gXokNinTBiJhS4NElt18s/YEfESooY/jBZA/8338yUtjDlyOpodNIcFTZx7Wl4DRbM
 Amy8XrTpJBYQcFl7oSxfSsBUIdjGFu/R7ie6hy65FZW2Uk+ud6cwMQn79vQqjEodjiA7
 gm1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpd858nxFtcaiu7I+7CsO6S2RJZmrwwlpuo+/477TOKxyCDftmsDWPEKSupffTLEDx+9+LsTI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKWkfSrtlPO2O3c1D53X0zEUE453rHxELHQXT+S1zH1SV1Dc6eD
 HkNMapkyXM7+IRbIDsZqouLPqwWn6G2W3P1ijoI9kcHEFugQQu/tCtJeJGUKQZ6p+l1HiBi3f2y
 L29P0vy6bBuaGhWn/ZeAw0vLZJYON+47Pe8xw3VhJGBlirVfmTipO3g==
X-Gm-Gg: AYBFou3AhIuiwtVP86hygdQMMDCxBs+tmQiwGVR1n3nhxtojGEeK1TDTnUQMOw1FXbt
 0nmVIyV8s/5pwiov4yKAf/qwqLB7Gi3PRHhXVu3hNM11gWxJRTX8yQETa3WFgFe0OvFJiCJABXF
 gUXnGE17EmFwoO+KypQUcIdfj/Bz8CcS2VutJU6nB3zl6U2eiK053oEHSrB0XgAE1mDZi31ECqy
 LXL6HqFnDjyuHEGnLW8LYNHxLCVq4lnKmdIlnohfv2JWaqVcAYWryHX1dO1VDYrus8HnbS1QUra
 FOve2Q1n9DyVMRioJe2OFnzmVSljBGhg+B5moqTNYgU+2Ug83xQwBcVJeDyUEmjiUG6DngWKtse
 duhj6oh2GEZmz2DQG58JtSSdE1HrObUhy94whvvD/K6E2EZi4jqN3ycohxd0hwxoEQOkq67cF
X-Received: by 2002:a17:90b:1c0d:b0:3ac:adce:60a8 with SMTP id
 98e67ed59e1d1-3ae8957a07fmr4038696a91.5.1793436253934; Sat, 31 Oct 2026
 01:44:13 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:44:09 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:39:33 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-imx93-secureboot-v6-9-27b9c987e25f@bootlin.com>
References: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
 <20261029-imx93-secureboot-v6-9-27b9c987e25f@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:44:09 -0700
X-Gm-Features: AclHuK_o3eI1bdC4LX9IUlh4TGQJ0QZhSRoFh6tzd7MNdO_4Who1FszUR0B3z4c
Message-ID: <CAFLszTgHtRpS5dp-wuuxeLOe4PJRy_Su79eWsX2=UyyeYsZhTA@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] binman: test: add code coverage for nxp_imx93cst
 etype
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
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T17:35:23+11:00, J=C3=A9r=C3=A9mie Dautheribes (Schneider Elec=
tric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: test: add code coverage for nxp_imx93cst etype
>
> Add test methods to cover all code paths of the nxp_imx93cst etype,
> reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
> ("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
> Glass.
>
> This brings nxp_imx93cst to 100% coverage.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
>  tools/binman/ftest.py                      | 97 ++++++++++++++++++++++++=
++++++
>  tools/binman/test/vendor/nxp_imx93_csf.dts | 18 ++++++
>  2 files changed, 115 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
