Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C65C4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 19:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D93A40A91;
	Wed, 22 Jul 2026 19:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFkCMrRJvPbg; Wed, 22 Jul 2026 19:03:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BC4140A78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784746982;
	bh=vtIVAoTVbBailtEe9gQUy6Mv5/bzqd2thWQ9VZw+BKM=;
	h=Date:Cc:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=R9CAztAlT//fhZrnF9C/CVxqWFekxUYN2/yG31Yg+ntRlAReO5Hduyg+WCoLq5F9m
	 Nji6tsu2fkm81WiOf2R45K86i8YsKcDiqIxtHJqPjnZn+gH+xjqmCcV78+1H47U650
	 RZfAx1RHcXu6ck3Mcu2T0PCxeK33C9MWH877i5EY4Ce4f1PvBVLEGz9t0Ga2FfVEib
	 03o16/ezRa0wqc1Ac62Xj4CfIBNeHF4mDEA3mIf0Cz8P4ZxIzK+xmW+LWqNa/iBABr
	 OTCt5F/wWXJ1tGGxXUKuWHTeEvmUwSRsuW9ofIYDpGYl9DZ8MudMJ8xymGlNEhjQNb
	 5707oflsS9znA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BC4140A78;
	Wed, 22 Jul 2026 19:03:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DFC5C39E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C65B640A7C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwnKcmAAWpcY for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 19:03:00 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 74A0040889
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74A0040889
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74A0040889
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 19:02:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0ED848BA; Wed, 22 Jul 2026 21:02:57 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F9B83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 21:02:55 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso34666285e9.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784746975; x=1785351775;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vtIVAoTVbBailtEe9gQUy6Mv5/bzqd2thWQ9VZw+BKM=;
 b=kTHT1wKk+moUzhxbbFMKNaL9c4VI+PnylKAtJxa3t0h8c2CTVnQPU3YLWkzDhBwnts
 320nD95C2ugsMX/2KO+quBOb/oFhns6RC/gDbZKULtul/CE7qIs6n1j1uG8BAQ5lpS6h
 7mlojj6BfUqwWEG65nW40tNijLTMYcSy59L49Oxp4ZDlTAqHSNLOl9lOkcrtuTQFd2N0
 Ba4gZ8Dv7j/K6jN4PtMnNJ2VQNW6Of4I15/QQs6V+jaHrFmSm+KkH3HAvhEdtPruTqNb
 01yGWskHGquqFaO4VwfYyDLIS/R1fCHamlbD+1fQUwcyCLvkWBjVlo/pXnlfzJ/XTG34
 5ErQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9VcfMg2JS5gxdTLpikSEf/IRL4VB1y1dvS6CJGOONh5Q9dJpthlY4Q6+SGMTGtKO3F/BGVH0=@lists.denx.de
X-Gm-Message-State: AOJu0YwWZ9ajQA75wPwsmaKHeoSF7HBoKIrIdfUgXIF35ISZ0gC4tA2Z
 d2arDxSl4fO/N0jM+ePABRAU/X2Rd1Enuxe58cqi9kzFMRQ2MxcvDTZxODnZtFLKlHw=
X-Gm-Gg: AR+sD13lxfD8PyTGH9yGkIzCpl95CR/UZThAnS9I33AP38DsL2kbLlLlKMkHDcKj+np
 gX6brkBEsFLVMk6JS5wVShEO6h1pHqmsUJhFVKskzGOE2Kwk44nkMm1Q5qjsThrbqpNqHBpJUNu
 AQf41XMAZS4e+EOQewvaZytLHw7C/BqHbR1+nyQw9Y2Xt2uaXa56Sizt5qUQJKTC0sswf7mMMi7
 UP1KZgNmjfw81E0OBFf5PoeREx0YLtrf7tLleaxVGg0GKQYfotEAhpA1wjEu7gy5pJOigQjLUYf
 J5B7MrH8K/zlu59vgHhRjTukt+f2Dtzwx+k7jm4HTbbSpur55cYlu1oEw6qSd2xk/ZiY2wR/dyA
 AbzD5jYTJVN8O4G9x5Uw6SOWOgZYQfHEijrkOYRywrk0toBOK9tQSIQz/0C1tYHmj076+E5+VzS
 ZLEq2bPVrZib4HA6AbY04Zc17hMnDkv0XV7v2rfGWMsMAYecCDdDI3uTuQc0KibwP5FDo=
X-Received: by 2002:a05:600c:310b:b0:495:7287:293d with SMTP id
 5b1f17b1804b1-495728736b3mr13978155e9.27.1784746974623; 
 Wed, 22 Jul 2026 12:02:54 -0700 (PDT)
Received: from localhost (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a6d7sm8847641f8f.2.2026.07.22.12.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 12:02:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 21:02:53 +0200
Message-Id: <DK5C00JR1Z4O.1FWDBY5GK5EP0@baylibre.com>
Cc: "Mattijs Korpershoek" <mkorpershoek@kernel.org>, "Tom Rini"
 <trini@konsulko.com>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Lukasz Majewski" <lukma@denx.de>, "Marek Vasut"
 <marex@denx.de>, "Peter Robinson" <pbrobinson@gmail.com>, "Sam Day"
 <me@samcday.com>, "Julien Masson" <jmasson@baylibre.com>, "Alexey Charkov"
 <alchark@gmail.com>, "Vitor Sato Eschholz" <vsatoes@baylibre.com>, "Quentin
 Schulz" <quentin.schulz@cherry.de>, "Adrian Freihofer"
 <adrian.freihofer@siemens.com>, "Francois Berder" <fberder@outlook.fr>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Vincent Jardin"
 <vjardin@free.fr>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Carlo Caione"
 <ccaione@baylibre.com>, <u-boot@lists.denx.de>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH RFC] fastboot: add SPL support
X-Mailer: aerc 0.21.0
References: <20260719-ccaione-upstream-spl-fastboot-v1-1-c9bab5b0ba72@baylibre.com>
 <dfa8cb93-535b-4707-8472-63c0d8038df5@linaro.org>
In-Reply-To: <dfa8cb93-535b-4707-8472-63c0d8038df5@linaro.org>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784746975; x=1785351775; darn=lists.denx.de;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vtIVAoTVbBailtEe9gQUy6Mv5/bzqd2thWQ9VZw+BKM=;
 b=ps97gt8znswqWHrPcX8CqDgljAlLi1iW6I0aazASqmS4+qOsBE0fiESuhasmUFcpoL
 Q6xkTSzHJCVHIlaY+z0B0ts+cieyrf+KuX0eV2ZyrymD80nYR48SMR/MVNZjKdZ+zWAH
 1JwHPRzBROxvrw3i6t3pwJmmTY6kKCgHCoqkG3UkYlYZXwDl3QjTLXvQv9NKPS5efBKD
 F5ahefGJgn0eG8UktEp0kR4x/Ar+w1Y+mIUc2+XXduaTXsc60Q7OGznrYTc6fi0cgDy4
 YY27fPGe/kTGyun7qp1EIGhXVLBSNjYWtI6T9EwUC/Uq/+zbQ2XuJ0zPFSP6O3mETroK
 /jvA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ps97gt8z
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ccaione@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="ps97gt8z"; 
 dkim-atps=neutral
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed Jul 22, 2026 at 11:05 AM CEST, Neil Armstrong wrote:
> Hi Carlo,

Hey Neil,

> The overrall code looks fine for me, but it would be much easier to revie=
w
> if you did as split by moving all the non-SPL changes in some previous co=
mmits
> like the usb_start, config_boot and preparation for SPL (CONFIG_IS_ENABLE=
D, CONFIG_VAL).

makse sense. Let me split this into a V2 for your consideration.

ciao,

--
Carlo Caione
