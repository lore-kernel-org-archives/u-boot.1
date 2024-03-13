Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CC0C54E5D
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 00:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B3687DE3;
	Wed, 13 Mar 2024 01:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTa6JvjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C74787F16; Wed, 13 Mar 2024 01:53:04 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24AC87C83
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 01:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so1792275a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 17:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710291180; x=1710895980; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tc/rkX+cHNlwLghCnE2uWp0QPX3H/EIMPGFUtOSUsp4=;
 b=GTa6JvjTew13Kg9JmiECQSBloZT2smA8DVdwkVGsdvPJlAci14vZeokREAF2gWiLLm
 eO/DmqIdC3vXWulpLLG3nnESoT6m3qb9IN7E24DOr9+HqB3/Fkri+YZ4gkoNi/n0i5A7
 7oyfNPSm+81j3Wpx2RfI323ikFVrQ0yZDPOX4yLmtsZClMpX0DMt0QE/wdMy4YlFZ7fV
 94MuPn2tzFwH/h6qKVErVfuCNLCkRfSfKP9/+29UFc5YoCqLD5gaXdgxKLgnOQF8PuAO
 CKX2ksNmPOA2xeZkrZB1F7oJEo8avPDiXFRy4dJAmNYmXJH2OJfyAYE9N3JBDh8AVGad
 EchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710291180; x=1710895980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tc/rkX+cHNlwLghCnE2uWp0QPX3H/EIMPGFUtOSUsp4=;
 b=GWaWoI9x4V4DH968VKbVccxZFlgqGUVvnPtXt0J8a3vVwen09dgOgBRoa6YXvyIHSf
 f5xGBj6Oh9UTDLi23X/XIEYwsu31cnuliq/g5x/TRa6hFPg2e8/o3mrkfbSgRdL5cwdS
 9t/e3mCWluMSnt1KtpBBw5MFwIPcR1bdkzZjtIWkRJUMs/orJgiIi418MQi2NEDiTCB4
 Bf/y95awhOS9KX8sL4g+W7VUe/pP8nVCeEjSP6o5EIr64l5Z071AEb57hqt9JCUFRzMY
 gm3v1AhZpeyKjVWCMM1SRGm/xedBzwWc9KveFv2ooNH9r510Dc4LZpS6VFi2jqtVHZX5
 Vn+w==
X-Gm-Message-State: AOJu0YygjUX94EwKwpOBELLqf9leG/yyQzxUe0ukjNpAgs+jOkUCo4ak
 heVlnj6g+hfTN+NcJOyeyWLvE1koOFQg4IycgGHRmlm6RlO1GT4RLOZ5xxjMBBmQ66cXSYa+G5P
 JpsOrUAE6VwuqExptge9cce7W/Og=
X-Google-Smtp-Source: AGHT+IGnEYbbNJojD66SzBzWtyqdyiwFXxhsuFKq6nCc9XZmb90Kqztj9x2v8NFvjiC8svLKxxMRInCF4jXOBH/kxek=
X-Received: by 2002:a17:90a:a116:b0:29b:f75d:bf5d with SMTP id
 s22-20020a17090aa11600b0029bf75dbf5dmr244445pjp.4.1710291180127; Tue, 12 Mar
 2024 17:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240312211628.32842-1-marex@denx.de>
In-Reply-To: <20240312211628.32842-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Mar 2024 21:52:48 -0300
Message-ID: <CAOMZO5BL0-1r63OiKLwgj1D2X1BHw4sN45g+QVeJ6vOSHrNFig@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: stm32: Test whether ethernet node is enabled
 before reading MAC EEPROM on DHSOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
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

Hi Marek,

On Tue, Mar 12, 2024 at 6:16=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

> NOTE: It is probably best if this goes in via either imx or stm32 tree,
>       I can break the patch up, but that would introduce dependency
>       between two PRs in different trees. Let me know what you prefer.

I can apply it to u-boot-imx next if Patrice and Patrick are OK.
