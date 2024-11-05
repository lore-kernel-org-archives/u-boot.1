Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5272ED2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AACDF891C0;
	Tue,  5 Nov 2024 16:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hh77ElA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A718913F; Tue,  5 Nov 2024 16:15:52 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E58891E4
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso543243366b.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819747; x=1731424547; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PUq+F/fOhlX2dQRABqwxE+3OjzAWCkgyEDjETl3bw9g=;
 b=Hh77ElA63TzBIPmjmSigQgXnajYxC+bmhL+rmADrREUCaS+OrVBVPLfmLjP/L9ueP2
 jespBX5tigXuClFNOtt9WEQcZvToecg29X30hJFy2IzRuWJ8Ovqs/xD439WtOmg7/sPi
 cr3IeCyMCB7+lFkCO1umDTVqzmafNKdFnaovQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819747; x=1731424547;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PUq+F/fOhlX2dQRABqwxE+3OjzAWCkgyEDjETl3bw9g=;
 b=ZfHTfV/d4wtEwqTaeadlKoAXJsBpYTE/2uiqtugoLZXIZ/kWo3Kr5kdRbWQaoJyRU+
 ou9c5Q+G4IwRaB8Y6+LDrWs6BObnfXI58X+XRw5FQYhhV2n1Md7ZNNiyQwR20hlU+Omt
 eGXJPRrm7LuNomttEeXO333zin6tuhHF7H8LaphJ4/Iq6jMVCC7gRnzK6FgMR1tUv3Mk
 r9KUVml0Vh+3oMeuiUNIcZaH1BhuhujZPFT+mjVb+w217pcMjsS9eBHQhb5dCVLrH3g4
 f2tMGa2qVmB201A4q5uO+VE862w3MOHRCxnxkKsIC48wFzBFoI/+lThoPZFMZEEKf2Qz
 XuBw==
X-Gm-Message-State: AOJu0Yz16ICx5iwSSbki0OgAQu5MAb0TnrQaM6lEubhLXbjsudxjc+K3
 jurXE/2GDQBwxTXerKfPaY3okQ/S0pe+D9ST1+f04QvSJB99/O4SPVArcZYVTkqh5daCmYZaxLr
 g+oFM+tnYA5u6wOCM63geSVfhBnvmj9pIN4aH
X-Google-Smtp-Source: AGHT+IG7FUKFi0QmomJAcgMUzgviYGIB8kYQ3E+P3Lo04LWUC+0Q0U76JUKqFasicDh4xq4TTmvtIZLk/g3d2+Rp2As=
X-Received: by 2002:a17:907:2d91:b0:a9a:80cc:c972 with SMTP id
 a640c23a62f3a-a9e655a8980mr1569945666b.27.1730819746951; Tue, 05 Nov 2024
 07:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
In-Reply-To: <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:15:34 -0700
Message-ID: <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Doug Zobel <douglas.zobel@climate.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jens Scharsig <esw@bus-elektronik.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 05 Nov 2024 16:54:11 +0100
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

Hi Peter,

On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
> >
> > There has been an LED framework in U-Boot which uses driver model for
> > about 9 years now. Recent work is underway to improve it and provide
> > more features. It is probably a good time to drop the old code, which
> > is only used by 5 boards:
>
> I don't believe, from what I can tell, they are feature comparable, at
> the very least I have not been able to get the Pinephone working with
> this so as it stands I still don't think this patch set is ready yet.

I don't have that hardware, nor the other 4, so cannot do anything
with this feedback.

Can you please be clear what you are asking me to do?

Regards,
Simon
