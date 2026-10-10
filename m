Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FBBCA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 07:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8240F813F5;
	Sat, 10 Oct 2026 07:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TdZlmODJoK9C; Sat, 10 Oct 2026 07:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9E40813F6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791618280;
	b=SROmp3Y0y49TfdABLNkA/DPBmP+yO/PpmFmED/7EJ7xy9N3GCcHEBgDF6p8t1LmM4gbB
	 9GTgu91rHkvXQtXRgvSl+YWa6DDFj5AZ+sHnhCV1lGMwVtzhCDlluFEEuIBiXiE0nTBZc
	 nSRLl9UF29KmjVKylFoDbRcweDC4AtMIlyAAIbTCuIwOP5wBNJHxipjma6PCnEa/KpJFM
	 oXKStBIWIZdeIk2QoEExdFt8TI1z0C1kkEfxnlXjznnZVaOKfeb+hiaP6zKo8H70ZnOgb
	 z4bdffm9PVL98OWV7ImdCI72JGXlS6uKk3/x5epVG7bPunxnUpzQIBsgJ3dNazPgwDw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791618280;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Lq16Mp4AvjiufEBBwzBtEazb0ehRbw/vYBIkmWtcPZ4=;
	b=JmrwtpA+sTICoWRcMJ9Gb2nx2Cu3jSCBqvkCqSN59sfZsis1/TdOKmwCUkbTUJaUBgDq
	 JFBAiOctlCCbtTYIyiSKRFC1/J+oxEpuzygePo/gHgRga9z8CbFvyRU1Lr2lJmqWPb5T0
	 ZHrn0fBgKurQqbNrkFTne/0wCgio1pk1e8bQWJCt2969f9RZJSjHRYyyY/jXSQenStW9k
	 8DgINy0Hc+VgpWYOwiN6Gj1kG/7TKGYIAK4IV+o5oHyS6awY3rIpHDphdL/XSCAwjidvM
	 aC+6HKLeWVua373XmXMaSUyxF2hOY5EC+KJcn2+hu1iGaVWcT4LrtwDeRxJjfHD4YFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791618279;
	bh=Lq16Mp4AvjiufEBBwzBtEazb0ehRbw/vYBIkmWtcPZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1IP671+KdsslZvIJ2kPshSQdRYUv2SO8VKlR2OXvrHXrQ3+Pwm21Q36T5d2OdrJYs
	 eFZ7pQswMsru3uo+/b4aG+mCsCm1K5b972U/xwIjWB8HKINKNKCSQS4yEkItSHqVuF
	 ltyJrdVGqo8U9qbnHpP/QbqfUq116rWSOK9/tQfy+AFYDlb8SltUOMxuQGzKxV2MSc
	 LxdYC/dqzg2gdFMaNroJOC2h3w36caRTOE5vj/Ogoi9YsTw+ClZ3TJ0w4YJLFIOGuh
	 G9yEviHNsU2PQ5NSYdmwsdcAd1EjtOqFWpIgDbz1yz/AhuRp/0W+gjiK7psaR//iTE
	 3yx91qs91U5IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9E40813F6;
	Sat, 10 Oct 2026 07:44:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01C9E111
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD71960658
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIEr-QtrHL4W for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 07:44:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86EEC6064C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791618275;
 b=rawFG8dvFXn64EZgdHppqtmgt/68A88JWQHfeOFSHAYgiKLdomD01m3SN3aabjjIhAty
 WZJJTNx6MGVdpJmOXqzQkQ9uCOUHBd6aIsBnp8F3J1ARdPA9ldhniKJ5rQ1RwHKcacJzq
 PqXfv72Hw2xLaSjDCNJCbVA6Eh8l8tM+j99L2QX3uIgRMXJkWlch+kGcI3ZLhWZZAabEh
 NcLyIroTIdhiOblMWjlN1IlOyWGYZZyOOu8MRRLPZ/ZxHTUMZ78pUbRXVNuUMPbV/BGsp
 mfNQjHvJZ35JqQTQsohulw0bfZmlkVYcg7iU/YBwIBP2WG5kil/bKWHX7DndnJxPR/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791618275;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Lq16Mp4AvjiufEBBwzBtEazb0ehRbw/vYBIkmWtcPZ4=;
 b=JRWaTSXI45WfIkBn7fD4vAoc91qN5ZoRprjN88+MB7DwMtPl1Om2bTbgOmiImK/HOsor
 ysv/449SMAsZ07Yy/FGD73NRXEJ9C9mvRSOXhal2rc486L8TpGfXs/KY+Z4LlLKM1jGYy
 xDNIi3AF6N9tqWIJLDSKJY9nm0zBAk+dI5V+d5D3CoCdC8ghnbwt2b8+iGh2J9/V3jGQC
 IPpY2+T0AJE4g+aNdvPhffOHxgNgxzLeVEvPFXbpo25I2+en6/YbScYz7l6fibhXPo1O8
 DIuQHZ5733oe344WQammtLvEaKIJmXzIpJfJbOfe6k71HIxJq+hPlL6xRv+6zPJZ86A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=l4oG0mqn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=l4oG0mqn
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86EEC6064C
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:44:33 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so3113105e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791618272; x=1792223072;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lq16Mp4AvjiufEBBwzBtEazb0ehRbw/vYBIkmWtcPZ4=;
 b=l4oG0mqnbw4eZ3vFDPf9/fRR0drLNmdLXM9uChgHJPm7py1tdGFW7sRsQlPF772i08
 SHaoI9yUpsMU//DFSHNlvV1WB1txuu8upTTxuiYfkBq0MPy0kuD0np0zSZ2UDSpLr/ZM
 CsNxeLIn6UyVxdJVRofaihpwoxAw+SAfBJFpTiwdulNDwi0E0yt/kdFGzA/8V4s71b8e
 wTIYGvf/AqnsnWLXzIbT1S5415oswBx8iAbG8mimCokAPYJBeKxCNkilgHakCKWtMmN6
 1wgG36JfCZmZlkk9qjcUC95Js3VV5YBHrtpsdPqBkrHdqLGG5/O8iayHJpuivuQLzVDS
 X7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791618272; x=1792223072;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lq16Mp4AvjiufEBBwzBtEazb0ehRbw/vYBIkmWtcPZ4=;
 b=BTQc3hG/2TxqQr5enEBJxwXkzrfd+mf+WaMM4vWS4iNB6dtl0aV+WIN5KLl/dDPMxB
 OOUnHq1hBDyt/claDD5qdETgda1jJ7g+LItAhueyf42FQU0dJrP5ngbjE1/qs2D16Y2e
 ldKl4bILvxeP36VS0ZYvTDoS4F6EhLzUVh/caFy9opd/FMrxyGVQpQvsHtr9LAj4nDY1
 7rUc+lcIeIa/X8uPFVI/KJOxJEPMgyieuABchWYqFe0oWuq+Ei7lxZPYbA/N29dML2wD
 1Z06CrR7zZxhtzdFBxGg9DsrMuRZaBbrfMQigz9G9xFEINeq06SgItLZe1otWsFhx2TF
 jwlQ==
X-Gm-Message-State: AFq9FYLhr2pCHcBwDUAnmAmxUhX9AdkHMduklcqNx0yNJOMxereHRUBk
 04657WZ/m5M54LTHDC+51+UvrAMTs5F/xSoxzVjNcePMICYIYatNo0ezhnE57tLs9qk=
X-Gm-Gg: AYBFou3oPclv/PDaezPFiL7v1Hn62f46FBxEISavzSfIHntDm+1aXH/Wo6U1JeeajVi
 6/SsaXErjZSUi7e5u37dn853mzhmwZ1oMUwCUYUUwr8J1Kkx20X5icwaKXUn07nC8ycyzetuUi9
 J4xSAn6+JlCdGZjxh7JvrUHn/iHYHeJF75hmP9Bm6BqvHK0NWpfpO+Ua8mqpj3SxmCXJZ83rv6V
 s/tu9H6sKKGuIrNcn5lP9848p9a6fhN0ECihzo+ah+8eygTGP8xXVOkM5k33HP/cIql6L5zOSpc
 9z/GJOBVoIyPpCcOvI4+zrXu9H4iTSoAXdIn0yMG/PUXUa9VCCXtoVGAa/NkAFX/Hizp+rZgAjL
 pmDynaJJip+10dQgUL6DEBk6cjQpjWE2X+/908tceXnNKQmjmigls5K27WSAsIkGxYh+aj4uaZM
 d1kYgxgxln9NXnvfiXMjKUi5fh263EaCneKPwOxrdI2I2rvzPAVJ4croq1wWCL1jenUuHLlEMM6
 yDeVoGrgWvdvdJ6qTWh4AbxnvirwZoMDA==
X-Received: by 2002:a05:600c:e548:10b0:49f:e427:e88f with SMTP id
 5b1f17b1804b1-4a18e4b584amr50175605e9.21.1791618271343; 
 Sat, 10 Oct 2026 00:44:31 -0700 (PDT)
Received: from macbook.tail959722.ts.net ([37.101.69.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e4225f4sm145005305e9.0.2026.10.10.00.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 00:44:30 -0700 (PDT)
Date: Sat, 10 Oct 2026 09:44:28 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin <vjardin@free.fr>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v6 0/5] Add fastboot to SPL
Message-ID: <asnsgPaKy_Ri3H4E@macbook.tail959722.ts.net>
References: <20260913-ccaione-upstream-spl-fastboot-v6-0-dd3ba81a7ed2@baylibre.com>
 <arGOFmNyq9-40x8k@macbook.homenet.telecomitalia.it>
 <xhkdb5wzws8dh.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhkdb5wzws8dh.fsf@mkorpers-koolstof.csb>
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

On Wed, Sep 23, 2026 at 10:02:34 +0100, Mattijs Korpershoek wrote:
> I've just applied the series. This means that they will go through CI.
> 
> If everything goes well, it will be send to Tom for inclusion in next
> when I send my next PR.
> 
> If there are some issues with CI, I'll let you know.
> 
> Thanks again for contributing to U-Boot

Hi Mattijs,

Did CI uncover any issues with this series? With the v2027.01 merge
window closing soon-ish, I wanted to check whether you plan to include
it in an upcoming pull request.

The MediaTek DA series depends on it so I'm trying to plan in advance :)

Thanks!

--
Carlo Caione
