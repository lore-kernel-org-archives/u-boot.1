Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B98C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 21:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FBAE80F55;
	Mon, 27 Jul 2026 21:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQj7_sSyJcM7; Mon, 27 Jul 2026 21:43:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D9E780F4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785188624;
	bh=iTo9X9E8SnsCeCG5AhQucmO3G4XsXJN7QfUJfEYQhK0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uz1tZ47/sz35doT8m5mLmQIknScsePJbAQ+ckAR1SG2mD/Zp5TOJl5TL2Iq0S1Isl
	 LguPvn+HsnHYkrEyBt+UsE2DkS8HhqyKo/9Du2geAvggH+ZUYGYf00qAeW2h1RcEPs
	 wCPzG7b5g2fBMrQvgTloPPVuTbCPWWtPtm/FUeIqO3iU4P5tgkjCNvz2/DmREkZDrg
	 UjO+jarU5hpzwbTDoDig6r1IM+aDtmfDc0V2r18SXJskpiPjJM1lD04keYe0gKWgq5
	 qBsRmbKBJ6+SVgRgssEQRX24ZsvG+sH78UFV6PneT4qptaS2VuF5cZ2OpLxdbqQy3U
	 CuPFYBBS8kIBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D9E780F4A;
	Mon, 27 Jul 2026 21:43:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 316A6194
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 238B86075F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSdBYWvKhrEG for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 21:43:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 163BA605F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 163BA605F1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 163BA605F1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:43:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E62846A3; Mon, 27 Jul 2026 23:43:38 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7519482991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 23:43:36 +0200 (CEST)
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-39c8ee87f7eso27999291fa.3
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 14:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785188615; cv=none;
 d=google.com; s=arc-20260327;
 b=aBWYvjw213+pt/KSwU1dmmcpSBpZc6v3Xmy7rC2bEZo6dHxftjtHcp/FLw6rNtfYeE
 Qsn3a0k0LSXZ6rnKS8tMzVJsa8H9RNAzhVViWbnBTJ/GN5BsD/T07PxzXx8AdxgOghAF
 wdvRZ2lvsPdG9Hh/YsQXnNltHS5fQLNZ07GKykPAXeN5HjlSZgliSTFZjAtHcXlwU40P
 RZfME1oyIePK9aKPv3/aC0MofvpVJDZR//SepawVZTlx06drVrrmHJwS8V/ll6oQgDKJ
 2356Ho6JjDkjwSfpfbT+3N6tK+wTsGCGk7pF4XjZSLMt8lAJ7AytyJoB/8iusiVdy/Kf
 4GNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iTo9X9E8SnsCeCG5AhQucmO3G4XsXJN7QfUJfEYQhK0=;
 fh=aePCYDgZGt0oIolQk1ieMWyvLC7IBNQHNfapZii0MOc=;
 b=Hu6kGm87iimXxDkreGS9OfKvSq3uBAPjJnT091xFdnV4GKZHhgD5EouBky32437rmX
 6biUkXud/WqVxRWB4hF8WyAsrRYzX7HHYjgLY3xbg1L5+eVaxhl0PiqOGtbEgUvZQQ5S
 PF+R5mjWPGyaxkIhCo9Gdy1Fz30iUTJFic7jykj7cNPVGR6h1A//D4q4gQF8LxE+mCNh
 6S/YuA+FFpCtC1XSnG+m2pjv+vCh5cnxnlUVGg78YT9gqZtLD9Cw2+SN2iVv/bXj3GWN
 3rZcxhK0X4pUWZPjw2Hlpsfpq7QHEDZ9Pz+D5UCCokZXpe69YIyQmo501lxpK+U5LcDv
 bJJg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785188615; x=1785793415;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iTo9X9E8SnsCeCG5AhQucmO3G4XsXJN7QfUJfEYQhK0=;
 b=cpn+uoY3myd7RsFI3n5k0ygBALyh/SdNGXZmeYTkbw2kbdQdPOADYSUt8Et9yOBUKr
 RIN5m87FFMJqpsAtq6LQ760YSb65oU0VIeRq2NF4h568aiZUZsKQwltmUjja34ZTqC6a
 rOZp+v63RKr7dtOT+hUbgtm+u8z2yiHGJsqjd0WpOGffVm6rmozHWN2IwG0qi52c1r7f
 OH4DzVwxWoiJBk6igG5c9NTnZJBHKX633PqHrWIEeLjyG26bpeSXVUaRfoIITtoU0far
 OI+S2HHru2w3YYtkMqBwrjY7CeSpwAmTgfD98oHRoVhb4VPjWRYXiXRgA6nfvoLYi2f4
 h0rA==
X-Gm-Message-State: AOJu0YwQRJhPHwoN0Urr2XjnuNVLNdfoZ/hUXHdxIqj1NZrOJSxs719W
 esX3zSDjvm2rIxslzh79kXWloiJtslHWpVXokOZpt0UTnfJz6ru4vqp+rU7XuY8OXtwuODg+uof
 /6cCZyPgquSDMzQ2HxxTHhi3zhQiGzyg=
X-Gm-Gg: AR+sD13NGEhyztAatVXmwDNWITc+5Qx5lusP6aSnJuZNYyxWiW77C6rZzTxjwyTV2lC
 2jmjhfkJVGVt05Yj9invWPvYyByq/GBStY9cMyKmEhUk0/Qs75qAwSIDMhCWX4Isi60x++e7EAy
 A44qTxfsVKsM2ktGDqudzvNFWZ39OLPHTuiDVs9OTp5mX3fm5ecsIqzV7j2Hw170I+wczsY7zs5
 m4Xi2NthTN0nGt9Xi+FfVZ/SF9Ey7d8cdq3Ut0TN4X8TU0G8HbTPDpeKljgBcc5Wi7KOkg4XjoX
 B4EUY1lk7oVpUXrrZ1lrPv73n1nxX5vN/YT8en8lDlCapxoYJh2bWor7RdYVJQ==
X-Received: by 2002:a05:6512:3f0c:b0:5b0:137f:9476 with SMTP id
 2adb3069b0e04-5b2c1afa9b7mr2359170e87.16.1785188615475; Mon, 27 Jul 2026
 14:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260707220301.252935-1-trini@konsulko.com>
In-Reply-To: <20260707220301.252935-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 27 Jul 2026 18:43:24 -0300
X-Gm-Features: AUfX_myKWxVbmTZBQrs_bNKIrU8o8zliUQn31HnexzSF8lBVjfjkrJUFKGYf0LI
Message-ID: <CAOMZO5CiHN50j0jcuydok3rV71eXFA1Becxfq9prjOZp6X7oPQ@mail.gmail.com>
Subject: Re: [PATCH] arm: imx943: Update dts files to build with v7.1-dts tag
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785188615; x=1785793415; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iTo9X9E8SnsCeCG5AhQucmO3G4XsXJN7QfUJfEYQhK0=;
 b=hIzK2yqPA9Vmq6K1e9YoWvXUerUsR10BqAP47RRmo8ou6fMyLzvnxvy1Jzcet3G7/T
 TgYZX/Oi0QpHtkgXJDdOn6WNOYVhz1yljONu1Fj1bQAit606jHVakxdLy4XZ6BuaSzao
 U0AyAy5jz+sMNCsjGWu4oYj9chZZcTYSdlSho2lSGaX3G9PcU/pTTv/aKyCLyufQl4Vo
 79Dxe4lqjKU7mARcJDWCYeXcnYNRaesJzDRcuYwW8Ee3iiAVvege4yRavPlcAS8zRVkJ
 pdyE4GPeU23rB6DawUKg9SCacT7wmNjyYkFtMxaYTw6XG+VG7L0UQDfs5tMF4JyMYqGn
 mx1g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hIzK2yqP
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=festevam@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIzK2yqP"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

On Tue, Jul 7, 2026 at 7:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> -       usb3: usb@4c010010 {

The removal of usb3 caused a build failure, so I did not apply this patch.
