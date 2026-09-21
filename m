Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C23C982EE
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07E1B6060D;
	Mon, 21 Sep 2026 20:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4dMhVCDNLPf5; Mon, 21 Sep 2026 20:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 661286068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790021915;
	b=gFgZOKs55zJbw5fRSdz32AuNgMR0yPAbmmu8u6H37lvqsotVqGTeQGEMrLohmvZIvPdJ
	 1A2Z7vQU41SlV5Fbzsg2oJ5pifpzOKZ0oWyvuCbfTafreG3Hmn8y2f5qrvhx/4DTJt8Y0
	 mmUgFOzRMzbc1mN40b84JBkYlRl8Wfs4dPugtFwZJvnhzUDN5a0XIg+N9REQaRU51uPkd
	 DRU/H7K2RvZxHHchlDRse9neeyVIPj40K2jY+GhAsRBNyuXGUFrNWlN4/kFxVpVIGHxzF
	 WJYbfru8iCQ1DW+NuLWeL5Mm0n7XxvPYGFj4wE7lt1RNp2fJ794gGZBIeZdwdZhJa7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790021915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lhBdGGwjIRKsPrtoCSQIvcxdT+1m4Q9qnzVNMVYUmpc=;
	b=NmQ1GA5ATzNTEXM//63zuS5dAUIS+jfX0U1amsRFKzwMlX2ftOtrA4qTFmsbqpKPjnHU
	 cgirzfTUZQLvQrSxgwVuHUDateYeZj01uX2y1FtUDqZgiwDiDw9Zl/dbU4xCIqOb9JC9I
	 shtu36kfqrVUzmi2ZOIQsQ/OBlu8krGsV0hvWXNpsZyVlvXGHtZESjNLI8HE0IKg3h3t5
	 GQYfitSZJ9fmYlrhvmwplZBeqk3P6ThvMakIUyOlKKBAydqyuStlqOeimSBKZh9k2cnqB
	 nhbqMTZvwI59c03yBxbzAbNhcSKgtqLqHTnXQMYtSjUt5XCFKFHEjgeMlTAsE3LwnKw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VlHJjo+b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790021915;
	bh=lhBdGGwjIRKsPrtoCSQIvcxdT+1m4Q9qnzVNMVYUmpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xYQrpb9iFHGwSvvwMH4NDR6NAueS8Ayy86MMBkmBTufsOrhdDqvqglcoC8Xh5Guwe
	 qvbesXtJbaE4eXPV3QbfCO727fzVaUcmirw967OEi3SP4PUPyCkKP1szp+I+Y/U+hl
	 JiKrGMO4z6mJW0AGfWm/vH6uAsHAm5h1tqABhg/8HMQSxBOD7kAVkFifafFWocZlht
	 eGq3zMOQyLjZ7W+yHfqt6IaOCNZlLecz0kS0hc/aSxUP86ew7mYIBBybqDj62jhbaT
	 6XlTvfhmuTiXnE08Z7ZWYTA25uYKwHv2EARt/peQrnknh/eD3ugIVN8Xx0U69RhopR
	 5+XeAfgJxGw2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 661286068B;
	Mon, 21 Sep 2026 20:18:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 619503A9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 539826068B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNw2KHOnsvaL for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:18:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CB7A1605FF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790021913;
 b=OFW3vsk4eUZelpbnh2HT3DIzx3HxXLXJUjGZLlO028Q/6bPoigFjcbzY5oP0K1NJId2i
 U6pbxkiPnaf2hyKc2j8gXZIjP3hilhxmiNCgoFBCTausuo2qJ114UmtfKaX2O5kQLH1HD
 xKYKGKRv8Q1um20RjBKSEw8xo/rzM+4QzListSVHwJZ0oE3NDeu+TyT6k1uGAuspBROFt
 eb3Ljh2DLuI6t+/UjfJ93o/KOGohgSDwRd9P6OMz4hB2x6JXBszA6HQqzStT5X1QE84x4
 k2ueGfy2FL9Q5HuD2U68hL0QmhN6D9eALQGTHwTPEWU5FAv+jkzFMTJhtT6SbXxBLvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790021913;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=lhBdGGwjIRKsPrtoCSQIvcxdT+1m4Q9qnzVNMVYUmpc=;
 b=i4faYXp0N9iPAUODwjz4gWcg7uEo3MLPfm7tu/+G0KYFEfNtmE/WXqGmYwMnOQJj4uMG
 Ccjqpna1dYCHb//i6mvzU8gqS/+Qnyf+qbDBZpk+9mUcqEL9qJNa3SS0I1EM4DTqXcCeS
 fcjo/5QUnXAmuGwstcd9k9LaR+8YIDhQtWhGZvlhrw7Gw2okQ0ztuA3lG2tYdf+PIUCc7
 06cIysXppcmt3BK8Ou17aIb3kuvtSLQBDmjq7PViTyrTYvuwZMKlzT+o7foiGd2iuJvP7
 hj3f+qxvJv1fXXhCJj3Gr439au48pHjTAMXbsK4GM2PqLoxxYKYwJWNzRmtbREMjDug==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VlHJjo+b; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VlHJjo+b
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB7A1605FF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:18:30 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so33739735e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790021909; x=1790626709;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lhBdGGwjIRKsPrtoCSQIvcxdT+1m4Q9qnzVNMVYUmpc=;
 b=VlHJjo+b3KZ4gIXbzZmeUbDNcfuJ9oYzyJB1+C7hL1D1L0jqlkRaLBfoWDVqTBWAao
 vMTIy51aQtfyygNMs46nHz28sxxR3rWXiG5ix5tB43w0esdOEb0KucPSvaZbCP5DlWVe
 vYLP+rHS3RGEwzBgMIPOP3mBV6NKtil+8P8vJRs0HUqynYCmAlVvnsPvxOrZ+e8QMYR1
 LRHdKsYoVtOlyPe3QDXUzsj5+DgFTGZJEPEzIzMz3wIZZAXwKxugwYgAaCYWoWLW2G1z
 /2dGYLRJU88qB//GI2g205H3eUsChgLtbQ/CbM9tZjGY2T4AhDY3w8gK1wjSAiSR2oVT
 Z2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790021909; x=1790626709;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lhBdGGwjIRKsPrtoCSQIvcxdT+1m4Q9qnzVNMVYUmpc=;
 b=2GemaWLmSMeq23ucS1D3u92FB2EbtDZB3fxOY5zCUayMGSNkBiBA/ee9NLQ5e+3OV+
 ypOSIg58BD00shxW7GuNFzr/NPwL6w64kEZiytKWfJJiUkWcFbmzlEZnIFvrq9kUhi20
 6JNq6k+BI7p1odglEVvjFrZIMBnJlNTBGzWhwdmxRJ2svPc38FiyybZDhWuKd5a4qwn2
 FWOcbwX8oIAhXSSQmJTP9XQHmPlyFjeekdI9gp35fuoyahcTC3S2bjKxdyYtOTJ223Zk
 ARpa41lWE6c7+2qU/qMouX7f9tAC+TTduEo87e6Db5cHiwYaETRzpLXzhn7I3/y3qy8I
 W9vg==
X-Gm-Message-State: AFuF++lPQiECzWe+20LINiG62BeIy2qWe7PPZoeuBBFVxVFn8ocdSzjG
 94We8AjYZ+pWKOgXELqaE2aXqk3zlmhnGK5YZm1sW4OyqYzLXBCuP59mrq/XTre8poSkDEDZGy+
 NLI/32us=
X-Gm-Gg: AYBFou1YIGN1NPVfWj48kFGT4uMaV/hpo+RmEhkK6eAIVkblYhFrur5kFOQfDueuH/r
 rF5WSLdApOKTiOS+5CsXbjUSR6D4R1q5nYpozpkcq1P1HNQAg+y+LL+jtWAIA4I8OHAZU5OLiEW
 +jF4AdQ7SYr7Q7nwIcqVdyWKIjnsdLVK9e+YtPzdM6foZSMfBXtS61RnPkdRkgnvZPiVQQHuqBG
 IFvkpEkkDclkBweCIwwmNS8eka1z3XFgLL9020dPwDeS9YPdxv/jg3atqRiguzzCng+8HLkW9Y2
 PvBikuZpKxmvUtbHsASXjO8Vz6sbb+dsUqThaMSVMeKcaxMqUYtSLYqw9HtLvf0PtKMn58+51FY
 JZ/w0XmzwWNJEYCrxmdZwZtaCZcJ227Jzgn2jWsOjlJ1202nmjkoBym4eseJDlYwjvI7rxstmC6
 5eq3silrC47C25yNmjaUsTxtvNiY5FNuNIJ6bD12xTYsDkf7UWNZgzF7pw0XZ+qpjpyJ1Tl/9Cr
 vNvlmAuLXe4fZsiOb9LYZjmPfa3jBBhGdBC9o81vBSlkeSO3ufskq/9aX8x5wcgNr6cqpvD8ebJ
 /LDQIfbUsaJmnQs=
X-Received: by 2002:a05:600d:16:b0:49f:c1a1:5222 with SMTP id
 5b1f17b1804b1-49fcbb0de51mr114569065e9.33.1790021908919; 
 Mon, 21 Sep 2026 13:18:28 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cd8dd6sm15091425e9.11.2026.09.21.13.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:18:28 -0700 (PDT)
Date: Mon, 21 Sep 2026 22:18:25 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v6 0/5] Add fastboot to SPL
Message-ID: <arGOFmNyq9-40x8k@macbook.homenet.telecomitalia.it>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
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

On Sun, Sep 13, 2026 at 09:28:42 +0100, Carlo Caione wrote:
> Some recovery and initial-provisioning flows need a standard host protocol
> before usable firmware is available in persistent storage. U-Boot already
> provides fastboot, but the implementation can currently be started only
> from the U-Boot-proper command line.
> 
> This series makes USB fastboot available as an opt-in SPL service,
> including MMC partition flashing and Android sparse images. The interface
> is kept deliberately narrower in SPL: it does not support the boot command
> or filesystem probing, and reboot support remains platform-dependent.
[...]

Hi Mattijs,
are you happy with the current version or is there anything else I
should address / fix?

Thank you!

--
Carlo Caione
