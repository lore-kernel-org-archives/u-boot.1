Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953BDC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 16:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E120877FE;
	Tue, 12 Dec 2023 17:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b5cbZ/7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF19787495; Tue, 12 Dec 2023 17:12:09 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61461877FE
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 17:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5c6ad67ab7aso309877a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 08:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702397526; x=1703002326; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovBjM3o/CZ9kN/8Z7pvPyWTBec7dss82K+vmgjRYk7s=;
 b=b5cbZ/7ES0NyFI7DrKK6TNlrWVdrm+tgxd9i28WuRRw8Tfz1JwuYa4nI5CSwgu0Qnu
 CfPt8243LKuSbuPGODvurQMGv6wwkv7uNUiSeK9OvSrPRnbJtHWTq2xDsd2SF33y/NAo
 gpFN72Oe1HYS5QwS8yy0eH5aGjFVbeKoJeDXK/h+mnpZPnzBwqrJS5f9xPJOnLwfSMO+
 ZMAbHBp7Mz5kE72yMOVsctkSR/hutO3AYh3/duOrOXHuTOdH6ptrtFYcxgET4AlOSf1i
 2Mn9GrVyU8cXNc3IQmYj7sEod5jpLWgUCYhW5xLszzSvreiAjJONkV8X0MJv4pKbs/ZD
 Z1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702397526; x=1703002326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovBjM3o/CZ9kN/8Z7pvPyWTBec7dss82K+vmgjRYk7s=;
 b=FQ8mBTYn8QxSuLAdCHlDYSw/47/VNJlSEICQJgz204X5DTVdiuGKpOzuliTlWY32/I
 MqMURR1KH2jTVuCBpGIWXlJ7TsJTaR7cBGeTB67BG+tCoEHJHRxAGgrQBL1HYrTlEUmc
 5nvB7gKGjiAojrq8KAaiN1ZMe7P7wnZacYpm5mFj/FAMAFi6HzrZozubpaNoj6a/dGb5
 bktW3TAz+tv0763l5HKTVKfU0d/Fhu95f+WpV869ILgwWINF3DeNW61pAXVCcIHvOY5C
 aRNbqBLA85Qu4aH50GzGIW9yrFZtEjRrYNR7+UFg02bqvzd2pIMUiUIvH220oEpGZnx2
 J5NQ==
X-Gm-Message-State: AOJu0YxTBcVeltE7TjTeufP4KcUm/6YS8hTByJmCpCE1TRlhLvjkFb2P
 BUZtoPhqC+p92p0v8D19qqVU3i6pbdjXKbTgp/QAZcyv
X-Google-Smtp-Source: AGHT+IHGb3ZCoI5WLReGymuji7iMs6ZhZWXRAquonokTi9MtzOlofXXsCDKkwqThYr4dBW1aRwjywd+swA4ryXDl178=
X-Received: by 2002:a05:6a21:78a8:b0:18b:1f5d:b105 with SMTP id
 bf40-20020a056a2178a800b0018b1f5db105mr12795551pzc.6.1702397525649; Tue, 12
 Dec 2023 08:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20231117150044.1792080-1-miquel.raynal@bootlin.com>
In-Reply-To: <20231117150044.1792080-1-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 12 Dec 2023 13:11:53 -0300
Message-ID: <CAOMZO5AwuiZAohLhRwFQx-UeL5eoxfCgVqVvM77+4eRKbmt6dA@mail.gmail.com>
Subject: Re: [PATCH] tqma6: Fix DDR configuration
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
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

On Fri, Nov 17, 2023 at 1:50=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Initially investigating a Linux network issue causing a lot of drop and
> poor network performances on a custom system based on a TQMA6A module
> (based on an iMX6Q), [1st link below].
>
> I eventually correlated my observations with a contention at the NIC
> level when in concurrency with the graphics pipeline. Troubleshooting
> this in the kernel lead to disabling DMA bursts accesses made by the IPU
> in order to avoid triggering the QoS at the interconnect level, reducing
> from 50 to 10% the drop rate on eth0, [2nd link below]. The solution
> worked on my setup but not on others, which still suffered from
> abnormally high drop rates even with this "fix".
>
> After looking a while into TQ Systems BSP I figured out a number of
> differences in recent U-Boot out-of-tree patches they had in their
> repository [3rd link]. Parsing the differences one after the other lead
> me to this final solution.
>
> The reset pad of the DDR controller was apparently misconfigured, Bit
> 18-19 picturing the "DDR select field". The current value b11 is
> reserved. The only defined value as of version 6 of the iMX6Q manual was
> b00 "DDR3 and LPDDR2 mode". In practice no register difference has been
> spotted after changing this configuration but all issues tracked thus
> far just vanished. All previous fixes have been proven irrelevant. Just
> clearing this field solved all our network issues and the drop rate as
> measured by iperf3 felt back to 0%.
>
> Link: https://lore.kernel.org/netdev/20231012193410.3d1812cf@xps-13/
> Link: https://lists.freedesktop.org/archives/dri-devel/2023-October/42825=
1.html
> Link: https://github.com/tq-systems/u-boot-tqmaxx/commit/15eb6abbefbf6916=
c28467b85485911dad3da6bc
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied, thanks.
