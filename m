Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF08C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 14:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F191481273;
	Thu, 27 Mar 2025 15:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kwnzhQgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093B981CFD; Thu, 27 Mar 2025 15:21:00 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09822806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac289147833so194530266b.2
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743085257; x=1743690057; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wmgQvEpmwFyQxNzFTVVaK+BWyWBf2w2uAouCQE0fa3I=;
 b=kwnzhQgymcd0NyIysSt4RcRzveVfzKpngdyXk+bHbayXp/gvGdf+cIWbb3CtKeHkwF
 cZtyq2KUNbd+sWk5soAp03q8KvNuSocv/w1nixAB+W3mSLTuzvNIAyRScwqFns4OqMOW
 BwAddpyvUhaZVG631vTzr+SAe8Dufb5Bqyi+Yk54XMTzeNQv17g1en+nqi2tS8ImFl3Q
 q71d33y9bYhYDbvPAIod+2KDV+9fpOGN93+w4E3X1MkMQZadnmL6f7Zd2DTxJPxJBd3l
 msBwOG7RWEDuebMAn0P5O63TPDElGL/vKmy0iKvtd+0/PAzw1EeSxmsQlQN4/zeHqN3u
 eH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743085257; x=1743690057;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmgQvEpmwFyQxNzFTVVaK+BWyWBf2w2uAouCQE0fa3I=;
 b=sLLS1Qsn9q4AckpKimr+9dJQDbVC2BbsWLxWdYsnaxeN5DyrrHdBnqFZw1TdFBGqzh
 jlt/m8v7kqmuGVanDAYwBnkxZ2mSHt64l8y/Pj1LwlUw/b44PH6NCXdP52nxgrdPWnpE
 ehKQpahVa28X7sLG0u18WH2KVbPbMve8mSQj6tBC1TTLB7UPP2d2NfsXXcqAtvaeybE3
 AlQ8LGOIURVRjYcDwdPINSXsk8DN7pqXGa8q9uUcwNHVPbCfXttSopKAxh+jMIBRzCIX
 JW6iSi5J/fa5Z1yVe58MmZ6cU1FC0xBb2uF5tcIBbIgtwAOg+gzwUgjX0Q6DNaeXtHHD
 euMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjiM4BFMLqF6wf0YrvNf+PqG2jKINewm5eXEdl/Ru0z1WKW7qFZprJRR4WxPhA+zU1sbVsGKA=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ/MEga8azCIMrddri+zoPzW06/MPBmwz5gUhjoP42D3lEQnc5
 Y7qqRfiFaSNIFlAVksy/BwZPI3HsZ64Lzy5yQcIoeuwfR1zjVPSR
X-Gm-Gg: ASbGncveDEr/NlvqpjwVyOn7TG5UH1k+Z+YlwH1knvAHYrLK1IDejgyATf8ofiErovz
 iD54MXd/NRup7g8fB8w5eveb/SBf/ToTqJ0JFcs3x/E/TEcclwEXW1N/c8XXy3/+YabPXwSe5dV
 3EjgGHa7ev2FE9jyNMtVvIc3/yKiXOYEife73omqpOp688oJjZcsQU2vSUiNwrBz6SI2NIWr3Lx
 /tk0xQtAr0gWiFe5K8ZAmZa0rOTfPNG9kkmz3WPZijb/G9ZMR4YAaYufvOj3446U78xFpksxHxi
 JZHaQU+wS3oslDO/piPzm8FfLZpIhZYHxnql+fjYfEXrnHDZvPadyhUgoHSQ3C/TzZYnFe271vr
 ZL38Hspgwiv4=
X-Google-Smtp-Source: AGHT+IGqg+UMKFFwbNIiu/3hKBSf6gh3HsZn17jf/OfMcT+eT55PG4/LNZ78TP9KufLPov59qIX45g==
X-Received: by 2002:a17:906:f59d:b0:ac3:bbc8:ecab with SMTP id
 a640c23a62f3a-ac6fae415famr380380466b.11.1743085256969; 
 Thu, 27 Mar 2025 07:20:56 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef86e56dsm1227173766b.37.2025.03.27.07.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 07:20:56 -0700 (PDT)
Message-ID: <67e55ec8.170a0220.20f0c6.7d4c@mx.google.com>
X-Google-Original-Message-ID: <Z-VexrdXWOfDf2ot@Ansuel-XPS.>
Date: Thu, 27 Mar 2025 15:20:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/6] airoha: Add initial support AN7581
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314202611.GF2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314202611.GF2640854@bill-the-cat>
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

On Fri, Mar 14, 2025 at 02:26:11PM -0600, Tom Rini wrote:
> On Fri, Mar 14, 2025 at 07:59:20PM +0100, Christian Marangi wrote:
> `
> > This little series adds initial support for Airoha AN7581 SoC.
> > 
> > With the help of some backport patch, this use OF_UPSTREAM
> > directly.
> > 
> > Posting this to have the targer and the very basic driver.
> > 
> > Ethernet, SNAND and eMMC support is already ready downstream
> > and will be posted shortly after this gets approved.
> > 
> > Having the first driver ready permits to separately push
> > dedicate series for SNAND, eMMC and Ethrnet as they all depends
> > on basic support of clock and reset and nothing else.
> > 
> > Changes v2:
> > - Use OF_UPSTREAM directly
> > - Backport some patch for OF_UPSTREAM
> > - Make use of u-boot.dtsi files
> > - Fix defconfig
> > - Use pattern for MAINTAINERS file
> > - Correctly handle SYS_BOARD/SYS_CONFIG_NAME
> > - Drop config for header file
> 
> This generally looks good, thanks.
> 

Hi Tom, may I ask status of this? I would like to continue with posting
follow-up driver like mmc nand ethernet for this. Is it ok if I say this
series is a dependency so I can start the review process for it?

-- 
	Ansuel
