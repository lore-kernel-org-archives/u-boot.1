Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F938606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N5uibCxO;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qm+kpG9Y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64445407A0;
	Fri, 23 Oct 2026 13:12:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yod5gvgR9DWy; Fri, 23 Oct 2026 13:12:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 93045407FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761160;
	b=QU8uJ/fu93BMa774NWSKICBeGF5Pkma96wj372BiI6pILi8u9IM08KL0WSDjiadB/89I
	 5u7pshtFze15KwgvMokAqg+44uJB2dr22btFXFHk6JcZkUmakycMvtRLpwB1QmmnSGxjy
	 dphP+FHBRCoCIvTqN2Fd2O+gFvqqMBlUGSLk9QDuEH8wJmIlGstTbDHe9q1NT6ESEDDp5
	 jXUbIuBLOCiaqIBePBLrEJw7iujE8UzCsrP8nbETS9VFoV42oVxjtkFd/fsYB8Ump9CQg
	 LloFkz4/OKpX+gPNwjhlwKO7MdCnG75NUTNoNiebDmSiG6ac+dNWgge+b49t6WmJtNQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792761160;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=CaZQCib8liBBGIICVIwylv5cpAJKZdsqoThSNJ1VxaU=;
	b=XzxzOtq0UOQogzRpQSdtmv6aC1q05na8EJOx4m4YCpYw0i7dUcDkZeK/PvH121bFOvKm
	 KzJUvxDv4qKiflVpgKURAXr+ARUnzmGDCk5hOMRuUJuGGG+qHqczUEqKO7qOxjEpYiEu9
	 HKqOPLH/nzDjXzBfOjtfqPqtt4vzR9+KjKViqkgN+tFkG26wqeNLrep0WzzSUeq1QNCEG
	 jshq5Yao9z/dME8IXvPe0whdq6j4rQSjJcCz6bup4sNh6eidIbJI3iZg5vscZxCjqrt2l
	 VrsvsV2pLRHWFFcuF9D1LccZDBvA8EIbQGAIXnmU4sucd9vGk7AbLqGRXankL4h58kQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qm+kpG9Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792761160;
	bh=CaZQCib8liBBGIICVIwylv5cpAJKZdsqoThSNJ1VxaU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N5uibCxOhJknDNBVAMB9w3EwFTi8kj/GrmrTEhztX7Qpjv7EXbPAE1Pfh6LPYSSf6
	 u5g1d+nS6G6sVLnPTV9OfGC2BUlqk+zH6tGDm8LhRM5/drLWP022p85LBoO3G4acHn
	 9vJWccgqGP0GTkMe40fzVEFjs7DwvdLMIMKp8PTahZWDUrv342ZdSvILo6VbOib3IT
	 yeLrGUfvdP7MVhWsMu089UDEQF21Hy5ZHBQQe1MwfZ+koK4O220tP4/euoVe/wNlvD
	 eDrY/Eg91+nXoXxK0Z0vB+Exhlyd0oDhWWtP0//eHk2M09vktnQdQvTy7BTiMULyr8
	 AYqc/3Wz5PdKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93045407FC;
	Fri, 23 Oct 2026 13:12:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 037CA3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9CDC4072F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4mweKCEZQ0SL for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EAFAC407A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761158;
 b=cfdo2YR6j+4hmaq5xnPbof8hCHONeR8LsAtn1SOle8XZ1gxltmKKfMjIB0XjDR7RX/w4
 g6OBf9cd7snRihwuTaonl0vJgvXJQOLlKKRncYFjjdwUQhXZPcW11dmwx4G3WON/zRMOJ
 eCH0hZhTVc/v99Bsa7+/5F7p8O/qDIqthsmLpcJqJnC3HI6TfH9/OTFZnn5S2aZKrIrIR
 tebI9B6SR/IyLg1he0Spc8h5FO6antrfo8NxFuxolHpcOV3vyzIL9WW4u8YlA5Z2byuOF
 PGXJ2WT8maI2YVUpQj+0ML5DKj2GgBo/ov1rjdIPxEjR8jumOZVqAd/BmaVPBnYhFeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761158;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=CaZQCib8liBBGIICVIwylv5cpAJKZdsqoThSNJ1VxaU=;
 b=WOtIGUrLTcJ6Qa6s8RU16+sYzxsk/Q8dOHlXA2KmMqe4pz1NaGBUzb8nf91J8U1seaqh
 64ByvbQehsucdrokJKx8TjfQLeDrOoMb3woGIDWLQwhASaAQFCNyILvsDsPB2Nau79w14
 o46QHZ7CCA45kf5w8c049VYPSqXk7do7VbdpJi+ry6PRXvBn2+YWNsI+u6w3fIW4x9jPA
 /cwnBDQtYHD9SLgAiOQTuEnrlEXjaO4E9q+1+INrszAMwnWuju4N+7vp9gFias6WAdBat
 PuN9+CPOGLsD3IPHm5kz986Qt9dSF5+EthDI907VGUoQslUM98bYDPwoxiSanXbISzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Qm+kpG9Y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Qm+kpG9Y
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAFAC407A0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:37 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1f31c63ebso3375918a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792761155; cv=none;
 d=google.com; s=arc-20260327;
 b=pjAaHLoFlwpm+HyXNIYgBBlLeeSkvU6qEsicINbizf0szzcukNEj0+fYCT/qHOaaRW
 Ro6fNDhsr+TKLh0TY+TqUrbzsXRz/I4/UNO1xXDoU6KLRSMaNLQN9saF5tToR9v8exqx
 mxhg8mjuVef8+/orzcRtOs1GoX1HWhwweHfq1OcI/wjn9IKoaYY/cNsG72pcWaD+kg/k
 m8xhdsMqNGdAqSEZCx/gL1BFbz7Vq7JEJ2c8REBXe8Q/DpztlsleqLY0uTaQkSJxm559
 JWnKcvmuy1R7Xv31APhyMULb1vDj+nD/3puIEid9m3wz6PYWrXg6zgtcE3n64vUMUk9A
 Ck4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=CaZQCib8liBBGIICVIwylv5cpAJKZdsqoThSNJ1VxaU=;
 fh=EiTd089Y1Y4VVeZZUdLUO+AwN0F0kOE/8ZhynYqszKU=;
 b=D/zJFWqip3Z4Zjqx1DZIIT2rtRuWt0g4hJuflOioFF6nX9dky385HpHSGFHNT/nIF1
 R+D7t3dIjWWg2X/INFQT2rU6m3d1ndANsPrqhxYG01+uLK65T9doxgDSLtazF5viVBzh
 nMogKbbAF7iX9yXIsgiJWvb2LrbecacABDSyHAdT++ozrom4C/94Aiz07BdqBBS5rKu9
 7wMAmVn4iRFN5v22P64B55Mc6Fj43xWBjEe3puX5F8C1dR9iXnacLC6au7JGNwHwpOip
 olf/V9SUslBCSvLkiAr8fuNZfM9J0NI44G0zZaZHdyvz3rOQPd0UhtE3lsazxOPG+JHY
 UvWQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792761155; x=1793365955;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CaZQCib8liBBGIICVIwylv5cpAJKZdsqoThSNJ1VxaU=;
 b=Qm+kpG9YtK+8DDf7n5NTAEZecVYbPlHirL9aRmuiiigYqyDqCjzwUqW9lKvbjlEoJp
 /V4zQqeGK3IMM1iGKp6q8r5XZMJScRFMXMyX3BfQj34D7mQe42IrZOoAdvTq5Pc5ZA56
 Tr/4e0te8skSafQiR+wHR+VscEtfGxI9c7U8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761155; x=1793365955;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CaZQCib8liBBGIICVIwylv5cpAJKZdsqoThSNJ1VxaU=;
 b=xw2ip0kM8cjr0GpseT+uIWqtPx26DR7wk5f4A23kd7BwB1/7QUyvp2Chp3+H5chKU8
 0yA5sWwqu/ZLGu9MIb203EIYbzwaCH9EC7KuRFVNgLiyUKoEnQcbxUvmqpoiKEvl6Cqk
 EW3/lQKARfBE1Vius2pTTguGNqENfUXDJ0nEkZWggEYkdT4AKeSNYJtzAYHoA/96kta5
 /O0AscvKXxXJUaz6hxtupQfXvnc5GAX4fjvKXdkn35asq8yZ6twdmyNe85paC84fjcxv
 egASK1XJ8BFZaNHOjCWN9cxmANBoQCqmCzK5tttLhPTW9lRsz0RDQ9PG1OgHwOlKve67
 +hsA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTcZw38Im2T+YSCu1dz2iD0hiJKBmBKRG85R0snD6Ue3BQppbhvIL0Mkzti/+DXx7ezHnxpD4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKr65QKUoxzMssYPtdggVsrqWBYzzcY9O4F4jjxDxAqdTU6mwkr
 f8B3BV36VZJHro2AilIyUz25357D2HIFhv5Lo+wf4euVZgxLTQolfrmapfePqYKF5xcaI2Z1P5S
 GrEUY1DiR96ZbuYh7g2UHjwh9zf/11ar/hm1UR8Io
X-Gm-Gg: AYBFou28kXx+lDseGHUnvWFETykbRj/jcps1M4UQjRTTrLzHOZ7epF79p4ifNKVSUJY
 Mp19m7O8Dosy/jBfjxe8/ISZtToUvkczmn/b6z8l07roNa56B+yT+EHjVgZYRfehjWFfH4Ig4ZE
 gWPAKr4QYUvYDY950ecB/sWxUxoMPjB1uv4xqw8OHo8ecwA7fG+zY/42vMoNAfKyunI5/K7wK7B
 HgXlL7XNsKlQNppr/9fW8nNR3R/qmJ4Dcwnc3KHMs/nb4siT082xtEIBHGBHS5BVeQUq9AzMD8w
 kjIn832ryxPPSwP2VJt0rs1yxTNauRRpvCiflN0/ZsbsGHgwi4kB3HsScmDn2Ko71e0YxkkRLln
 wSNFkNMH8lC1mNgL07lL839XM+9mP87pWjew=
X-Received: by 2002:a17:907:9611:b0:c2d:cdc6:8271 with SMTP id
 a640c23a62f3a-c468d7cf342mr827454366b.13.1792761155453; Fri, 23 Oct 2026
 06:12:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 09:12:33 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:55:18 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022194049.670889-6-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
 <20261022194049.670889-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 09:12:32 -0400
X-Gm-Features: AclHuK8f_M7YrsmqfnUMWPH3tWLTDPrU5LXq4fuJ28GXqnYY4dFN5i_0WpwKY9U
Message-ID: <CAFLszThunA9w1o0+7qT+5j_jvbZ23bt2wukSyjF5-Xf3qUyF6A@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] misc: fw_loader: introduce FIP loader driver
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: introduce FIP loader driver
>
> Introduce a variant of the FS loader driver to extract images from FIP
> image. These image can contain additional binary used to init Network
> accelerator or PHY firmware blob.
>
> The way FIP handle image type is with the usage of UUID.
>
> This FIP loader driver implement a simple FIP image parser that check
> every entry for a matching UUID.
>
> Similar to FS loader, this driver also support both UBI and Block
> devices.
>
> Also an additional property is added to handle special case with eMMC
> that doesn't have a GPT partition and require a global offset to
> reference the FIP partition.
>
> An example usage of this driver is the following:
>
> [...]
>
>  drivers/misc/Kconfig                |  23 ++
>  drivers/misc/fw_loader/Makefile     |   1 +
>  drivers/misc/fw_loader/fip_loader.c | 556 ++++++++++++++++++++++++++++++++++++
>  drivers/misc/fw_loader/internal.h   |   2 +
>  4 files changed, 582 insertions(+)

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,556 @@
> +static int blk_read_fip_firmware(struct firmware *firmwarep,
> +				 struct blk_desc *desc,
> +				 struct disk_partition *part_info,
> +				 unsigned int part_offset,
> +				 const struct fip_toc_entry *ent)
> +{
> +	unsigned int offset = part_info->start + part_offset;

The parse path now uses lbaint_t, but this read path still truncates
part_info->start to unsigned int, so on a large device the header is
found but the data is read from the wrong block. Please can you use
lbaint_t here too (and for blkcnt/blkstart, to match
blk_parse_fip_firmware())?

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,556 @@
> +	size = min(firmwarep->size, (size_t)ent->size - offset);
> +	ret = ubi_volume_read(ubi_vol,
> +			      (u8 *)firmwarep->data,
> +			      ent->offset_address + offset,
> +			      size);
> +	if (ret)
> +		return ret;
> +
> +	return size - firmwarep->offset;

'size' already has the offset taken off, so this subtracts it twice.
With a non-zero offset the UBI path returns less than it actually
read, whereas the block path returns the full 'read' count. I think
this should just be 'return size;'

Also, ubi_volume_read() treats size == 0 as 'read the whole volume',
which overruns the buffer. That happens if offset == ent->size (which
the check in fw_get_fip_firmware() allows) or if the caller passes a
zero-sized buffer. Please can you return early when size is 0?

Regards,
Simon
