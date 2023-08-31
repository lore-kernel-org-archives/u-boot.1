Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5742CC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF87D8669F;
	Thu, 31 Aug 2023 14:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z7xGNNLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BFEF86556; Thu, 31 Aug 2023 11:22:20 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DA486558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 11:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31c79850df5so435054f8f.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693473737; x=1694078537; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+fqLmMUdcmDCacRbaA4AVrDpA4fRjEWTPvc+pS0aVQ=;
 b=Z7xGNNLvButpESZQeb/8qUzNJMYClCd8LXSNH018Sk6xp3A9RFEUnnhLcwN4WGH7Fs
 dsBDeSfaOQTnn1Lj4Pj9FXiT89MvHJHUgX9dqcxCe+1H8RlSFvLUZFROvbamroaJEiXY
 ymayIeB/XQbDOpVU8kt0rUjDXRuM39Z6Bwr+VGxmB7j6SZuVbR7l4NJDtKGocE0fEN2n
 ZyCom7Lwe4dg2Lw3ynhLOIzrg2+1Gwc6/pjmWZGvUjNZl8AiPqBtzR6JmxnMAJtOI49H
 n8pyPCagSz/BqvZsNMCZ28mjrq02TfO80nk+iAWkWSPqFxgSgqocVpi8nbQDkYgL8LD8
 oz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693473737; x=1694078537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+fqLmMUdcmDCacRbaA4AVrDpA4fRjEWTPvc+pS0aVQ=;
 b=g8ll9hkXWpvdw7NXYPBpubsg3ddrCXLZX49Iffh+CANJMXhM6riKIlG/0CTr5NsGEq
 vppvXpjt+vIxi9X+6rjTgl8FHwkmkuC4asJRmdldyx6ECsLBTpd4Wyj8ynj1fMOh8xnd
 hsl3fvfW09sp3+U8NFripNcpIUfPwDooJH1gFSYVbP9iGMB7BRPHOhj84f7hHgfwEf/H
 1DkY9mCQRyGbw4TdYGgP0kCyXaeqL+WPQaD42mp5J4aBLoIuu5c7bA4AUTcfd65M1NFn
 3/kz29mO7CL5YRN2Chm7wxZ94XH42csg/Qb/1mNpumUDuLzxgetrtNjoUaKhzzQKBDpO
 PenQ==
X-Gm-Message-State: AOJu0YwBdTfLd/yKNS+fY82z/o6MQvfjGWp5E3uQUd8JIKkrNbDY7d8+
 EvegFUhdTCYxjqD9m5j9bYgsqqnmkR7E2Ydisz0=
X-Google-Smtp-Source: AGHT+IEf+/2zja4RgliFPX2diVeKZCLeH9mV6FxeU4F7nG8YnmZ5MWVm9rQGKzKOHt5QprlkxEXM3MIlbQBs2+UFw5Q=
X-Received: by 2002:a5d:44c5:0:b0:319:6b6c:dd01 with SMTP id
 z5-20020a5d44c5000000b003196b6cdd01mr3478681wrr.17.1693473736841; Thu, 31 Aug
 2023 02:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-3-sjg@chromium.org>
In-Reply-To: <20230830180524.315916-3-sjg@chromium.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 31 Aug 2023 12:22:05 +0300
Message-ID: <CAPVz0n2u1o9jYDG6kfJSby9_JrgshoX+_gMOBbj6xWMoLCBUug@mail.gmail.com>
Subject: Re: [PATCH 02/32] spl: Use CONFIG_SPL... instead of CONFIG_..._SPL_...
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Alban Bedel <alban.bedel@avionic-design.de>, 
 Anatolij Gustschin <agust@denx.de>, "Andrew F. Davis" <afd@ti.com>,
 Aswath Govindraju <a-govindraju@ti.com>, 
 Breno Lima <breno.lima@nxp.com>, Dave Gerlach <d-gerlach@ti.com>,
 Dinh Nguyen <dinguyen@kernel.org>, 
 Green Wan <green.wan@sifive.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, Le Jin <le.jin@siemens.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>,
 Matthias Winker <matthias.winker@de.bosch.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Michael Walle <michael@walle.cc>,
 Michal Simek <michal.simek@amd.com>,
 Navin Sankar Velliangiri <navin@linumiz.com>, Niel Fourie <lusus@denx.de>, 
 Patrick Wildt <patrick@blueri.se>,
 =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>, 
 Peng Fan <peng.fan@nxp.com>, Siew Chin Lim <elly.siew.chin.lim@intel.com>, 
 Silvio Fricke <open-source@softing.de>, Stefan Roese <sr@denx.de>,
 Udit Agarwal <udit.agarwal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

Greetings!

=D1=81=D1=80, 30 =D1=81=D0=B5=D1=80=D0=BF. 2023=E2=80=AF=D1=80. =D0=BE 21:0=
5 Simon Glass <sjg@chromium.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> We like to put the SPL first so it is clear that it relates to SPL. Renam=
e
> various malloc-related options which have crept in, to stick to this
> convention.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

For the Tegra30 Transformers, Grouper, X3 and Endeavoru.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
