Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24503D0EE1E
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 18:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE6C893AD;
	Fri, 11 Oct 2024 20:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MeW9EYXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A36893CA; Fri, 11 Oct 2024 20:06:24 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC3F893AD
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 20:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fad5024b8dso27084021fa.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728669981; x=1729274781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zYweDjW8AF+NHSJGTlEUAEsVXzacEJx2R+zHvuCiwbg=;
 b=MeW9EYXe1/XVW0e7RnzHaFtyE7JBWFZ8XWWSqHLaxAvW7g8SKGZqXYcig8R9C2T79L
 1jDidW14hkiYCWOIR68Y6E7eMFLhgS9iN6jl+JUVbTA2rzfnyQ8oD4skkzY/dzjDdEfC
 VYeHN3lpvAuHZ4Up54cMJ4pFZrqzZs2XLO6DrHaVQ/HP3Aur4V5c12B44D73vntd17ey
 1UsI7U7ifebrm8TMsR+RG+WjRnCqKxUvvgtEe5xCaRjzBMlbvT6dvKkLfm+DpkTFy+ja
 cOkGKHELvepF6uy/Zom3KPGgk/4yIBf4STGV0Ctc1ukRW5DEkTLkgl7Vo+4ArQVyQKOo
 567g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728669981; x=1729274781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYweDjW8AF+NHSJGTlEUAEsVXzacEJx2R+zHvuCiwbg=;
 b=DBZfIEVQUXKHsK1/AZ4HWxJfR33w5vUtaSJvyvKEaFRe4Yw1zqeP164OuIjBu2jmn/
 CB5fTXF4gZMl/f5FTOAAQRPpNJlQkjRsDTQm+YjvhdrVnzGvqbvNjx/dE6AYOPWyLl8y
 73Ab1nojfx1LhkQrxhKcz4VZORc9NH7Ek/HfDgh4xkvHsEQKcMYqYpwWDzPN7eJOoTuN
 swvZY5w1Lbi4CpnwzsPFjIpsDKeJQlSAIl8+1qr3+e5K9iCvIcVmJgf1paOLsFM8nYxF
 t7T1XoKx/Vebm0bQ+vZHVZLsTA+NAgy2Ebvdz42nIL6qwko212dew5iMYn4zxNg6XW+w
 p2fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKRFpbmQiKgM8dOWXpo1oGQAz8LbUr/g80r+DRauVRzSBAaW0S5HTvb9k4uJqMxzDyM2gs/w0=@lists.denx.de
X-Gm-Message-State: AOJu0YxEcyr4P0CUC+iG/fa72AdWGIW/IHqFBv4I0Yhz8qEDExSVE+RU
 orxDZNziilKllXki88eOV74gEtpbEFGu06f9X5JbyEAkezZRK+Or3Pt/TiLytdKVHcRi6RIgOOK
 RMliqQetjuVs0BC4JZ6ttSqTr7nE=
X-Google-Smtp-Source: AGHT+IG7d+UrtTsjKp/nPhc0XlZLEgZJfDWxbdAFQWD7FvyGQzgePheVje8ZiEJzBUeyn0/67TSgvECRSVui05C2TsM=
X-Received: by 2002:a2e:712:0:b0:2f5:11f6:1b24 with SMTP id
 38308e7fff4ca-2fb327423bdmr15287091fa.18.1728669981270; Fri, 11 Oct 2024
 11:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241011165616.GW14210@bill-the-cat>
In-Reply-To: <20241011165616.GW14210@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Oct 2024 15:06:10 -0300
Message-ID: <CAOMZO5CSK74_TcubtN1W1MpVmTwTmbv_XfhaOexpdvoc5WGb=w@mail.gmail.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
To: Tom Rini <trini@konsulko.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Simon Glass <sjg@chromium.org>,
 sbabic@denx.de, 
 u-boot@lists.denx.de, uboot-imx@nxp.com, gilles.talis@nxp.com, 
 Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

> Why isn't this padding and alignment with the BSS being taken care of in
> either the linker script or the binman dts?

Peng, in addition to Tom's comment: which commit caused the problem?

Please add a Fixes tag.
