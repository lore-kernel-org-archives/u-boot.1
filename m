Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F5E606A32C
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X1aXlXe8;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SwPsojCH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F347440726;
	Tue,  3 Nov 2026 16:32:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0O4O2QrF2c0; Tue,  3 Nov 2026 16:32:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03EC740557
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793723570;
	b=gxemIkMWQeJhPA+PhOwbVBCHNTRQiyz84oYgFOkChIB++kovhemRp0quoqeshDmTBdPw
	 ouisN7fO5ObYBKaCk90YoB+qrj03BCMI9H8LXPMPN/SNUlM0fK5PLQ2+5SHdtdo3WhVQA
	 +7gMBEtAdqhT0RWoJEkqqyaQYHY/LVCjGLKtlkb/rjBXF9sL47gZAvG8wP4TPFvbl4MFP
	 R+7oLls7tUgPeL++QON+pbUKoijMRylnjeFMelj9dzcG0EchCWDfy4fxWIP806VzDq2Xv
	 TQ6APCROrrH7tzS6AaJcoAanZutGXXmb6BQ8EwiyJf838wNOVt91k8SkuiYFx/+OMGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793723570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nx1frV4zQ7xfV5/18une84DaD3Lbl2QkdIwj2zpckJc=;
	b=q8sckuFMUiEwfFX7S6dT676CidkYk4ZBswkTAWrJoCptClaLYGSswlDZ5NUDohWLjnzT
	 /VU+/19uOhfpqKNkFDbExShtgFS08mCWa32riBDn6bGffvC+EL9vAT5tgXKi5s3mKa2ov
	 ZJF8dX+J+PxMDFn898AnLI2rJc5cG44+pqoDem1hsYe4BSR7+EFVbL4dbY7cyVexnxOUd
	 flfK5dJf29VukmOSVGicPYRDSB+rMmN1pxKZO5V4W4FNjisz0AnaLeNkIj7RHA1yQaU2Z
	 a4y4Pm3bFVpG6uCucI2CUhthUNfUnm0eF8RDxaT3ymgYXsl2EAevLUEkHu4twiNbzvw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SwPsojCH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793723570;
	bh=nx1frV4zQ7xfV5/18une84DaD3Lbl2QkdIwj2zpckJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X1aXlXe8Psf1Uv4/7ifkakIJTaLNpSi6b8X1FUWfG4HDXuWQhw0S4QTWyQt5wo+KD
	 6WpU1zS1vqlq6IyHGAvFj4XfhAuGYq1XDaLHsevkPUXpjyzBCxWOvWK3kR2DjaKNYI
	 6XzEZaBI9cLdyh7CaZ2XUfAP88DMQyq8F5zfkj1hm5ahJ7Ae42vONsW8rbquBIa15D
	 eRCr5ohIYJsONt99sFQeu0AibuZ9LDdri77C0rmNYPmxOY3T0kMkgrZS+IeOtwQR7O
	 c7E+u8SCFqOU65Bt2Yvdqt8IT+HDHgM3I8KxNGMwjd6HatBOCsYIb57P1avkmz70AZ
	 iHZ/lIzPlKx6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03EC740557;
	Tue,  3 Nov 2026 16:32:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68E4B235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59D4C405B7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KVHz0hEzgeB for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:46:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1226940528
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713561;
 b=m9phTuU2S4kCq0VW95AOt1KGix/zppPv2iMuSQnKUA4Ce9OoF688uUA9GVBgRZc5isBq
 V+DW4FkvtjDnjRW3KS2xUBsQpjIK0FUpRcIsZ+Eo33GBVWa5X5TRfzbTYCwqbp5S+vb7a
 2XXxiBQb/hjw1GWF1FMuZFZM7QNAjkR+9ehVy+6wBCSurwcn/qmbNKRkwhilXgLywZV5S
 E87EKpeEUdbV32LMTDXr7xdj3SHO4Zf+MUcjuBl1Kz25NVYaz1fVIgB5KLZ5uz8ouHXEo
 XcTWLs5pmDtUIVCoe78m8FQWYpcXKmOkUIP3tgwS9kR11TubKF/RGZrwG7AZa91rWRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713561;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=nx1frV4zQ7xfV5/18une84DaD3Lbl2QkdIwj2zpckJc=;
 b=aQFilkiKN6+Dm60VX77+WgNPyYY7GFM2JSzGK1e6e5S+KvAaD4jMRGpVH4MCNW0Cap9I
 ezX6M11O8BYvE6dHWfb1U5vbkU/bmvjkSZDFtJr6NZkYAjWGE5BWhaY7ReCZo6SxKWOTo
 oNBKQdwA7VfuIzwFKLUaMjazlqTS2KuSOFXoSXwc6AFvnjBdCqMX70R/hDLuoL6hu0XPO
 ARz5CXfcdhYwkcKWV5qmB/djBxu5QiRb4f2kDPzIRodKgTZV3BnRJ1IHpAXm2/ACezg1W
 PSF09f12cSZW1gvuDzU/SCMLaK+kpCy18/94AhJp4FwAznauh09pkzO27yewSuVtnMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SwPsojCH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SwPsojCH
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1226940528
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:46:00 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c4cd28978b8so72897566b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793713558; x=1794318358;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nx1frV4zQ7xfV5/18une84DaD3Lbl2QkdIwj2zpckJc=;
 b=SwPsojCHX1YJdKYLIfrnGLet8rOLuR1J/iw8UqetbFODx8cyJmnNqOzSnQ0OvetTWY
 D6jQI3CG8X4N4MiX3WVH5AQG8C6Kqt4FN6R3y+U3zLa5t6P5ny/GpkWCgn7EJX+w/qtQ
 UZQVxt4pw3YPD9XqsL+zZ/ExeOBVjqFUdRp0vpm+8Em8c/eRuTodP06NwIdfBy63Yb48
 wQi8zO+6jcPYQgKNJvR02ftlT3gJ+qpD28iHqno3bSh/1Ilcqfx2sgkzy+taSCEM8OBn
 P/3tTQFxutcOfjOs7kdGRz6P/ZCEGmM8E9N4L8ZJ8i6PxeB8KD8nSbpcBIPNWaapVZ4Y
 JvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713558; x=1794318358;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nx1frV4zQ7xfV5/18une84DaD3Lbl2QkdIwj2zpckJc=;
 b=2J0fmU0ZAuQKmUD3EmNb/HKSJZdXKfTvZGOlW0vgSXSPIUXMkS+UQOgSrIBEmd3W0O
 tcWecrJqJKKOE2d2lwzLv9YzQLAosa0qNCVk0+t2bS3nHQpdmw+AnXARvD3/qMhwch5K
 KgK2MXlJdz2mf6XdNB4W2hVsMEq/KSp3qkbruyi5lYHTLbK14DVFNN6k1/y0hOfBpS57
 G3XxrrV47TeqG8+CtB08OekwNXVRiSspM1gOpIqPde+LuioQ4bcl6lNdJ5JkTkBpQ59K
 x2P3Rm5XFmEq/P5cNULF3lWel4QilvJX2D2476S5di/ls9WK6X5k2CdENTNrQt+6Y8Rm
 CPfA==
X-Gm-Message-State: AFq9FYI5+KOcNW/jtJ/hkS9mhgH/uKUHB74ONDqlAHAXOOyGo/L4jIyc
 U1YlR2KIDFpTT5CJi9Qtj4S9BxdvYq0Y0AYlA1tm9XYJ18tTvPx5OhT7oUGhtaypc8g=
X-Gm-Gg: AYBFou16IXSRurMlABPOwzGizIZy4cb/jY7ID1tL7MiEuqZIXJADN5DjKXiBUOhG9+C
 wz7rKWE0Dtx0pe+reBoVffM2+epGJR5qELZK7H4N5kOegtghxP1zXCQK5N3vZyktSlNaKxrrBZ/
 4gd/XE6jkebsYOdF11IY0pDClFLHSqy65AJKQXqqmtI2BbVRJCM6VfdpPKAs9kzN/38KrlNohQ2
 7BF0OehgaXm9amxjBJq7Kuh77m/22Fs4LQhQFaPVD/8OiNBFJ7Pph8xwaGsKisdikOLQLamfAXO
 wFk1nfgciT/7aGl97xvU3p/dkBhVnVzhItW+qO9IQe15YrFWmFkuiq3SDfVhZ6cEAHKxd2cW1+v
 D0i27ByzdkMQywJ3lZfwCTEXR//6Cz67gBwYSAQS74AW2Ixvb+9g24kcTHSut/u2ncPcsqEuS86
 INJc7uUeGxoi61OdP6OX8Q0ORaQJCMllVGhdnM8p+426qTBSMShvNUJXQqn1POc22f4DX2ST22b
 G+AGg4iBvpYaU7rQUYoUxiPkLWBaFy4HniOM43UJVuPw4G+GTgumRVvJ8NwE/PWl2QyiZDpAgYA
 ZHGWlxnQvViHn8GyLPi/jktKXMeUe6Zl92B4zpYuv18w95RVLCS5LMVSvaFx
X-Received: by 2002:a17:906:b055:b0:c49:ce7c:8a60 with SMTP id
 a640c23a62f3a-c4ca7a0feebmr1149148466b.2.1793713558432; 
 Tue, 03 Nov 2026 05:45:58 -0800 (PST)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cebf3dcc9sm88010866b.53.2026.11.03.05.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:45:57 -0800 (PST)
Date: Tue, 3 Nov 2026 14:45:55 +0100
From: Anders Roxell <anders.roxell@linaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com,
 mkorpershoek@kernel.org, love.kumar@amd.com, s-vadapalli@ti.com
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
Message-ID: <aunlk5FaVe_jcpSr@monster>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
 <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de>
X-Mailman-Approved-At: Tue, 03 Nov 2026 16:32:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-30 15:28, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 10/28/26 3:15 PM, Anders Roxell wrote:
> > Hi,
> > 

[ ... ]

> - Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
> - Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,
> 
> RK3399 Puma behaves the same in main and with your series applied.
> RK3588 Tiger has some regressions.
> 
> Q7 USB P2 (upper) doesn't detect the Sandisk Ultra Flair USB stick anymore.
> It does on main branch, but on the USB2 controller only.
> 
> Q7 USB P0 (lower) has issues handling the Kingston USB stick. 1st try:

Hi Quentin,

Thanks for testing both boards.

About the OTG port: no need to spend more time on it.

v10 had two bugs in the dwc3 core. It never read the core version, so
every version check was false. It also cleared the GSBUSCFG0 REQINFO
bits on every controller, and main does not touch them. v11 fixes both.
My best guess for the Kingston write on P0 is REQINFO, but I have no
Tiger to test it on.

Did the other sticks pass with v10? That is the Ultra Flair and the
Extreme Pro on P0, and the Kingston and the Extreme Pro on P2. I want
to know if it is only one stick on each port.

Can you run the same tests with v11? It is on [1], on top of main
ab4dc5aacf95.

If it still fails, a register dump would help. No patch is needed, md
is enough. Please run this on main and on v11, once after "usb reset"
and once after the failed write. Not before "usb reset", because the
controllers may not be probed then.

  # P0 lower, usb@fc400000
  md.l 0xfc40c100 0x14
  md.l 0xfc40c19c 1
  md.l 0xfc40c200 1
  md.l 0xfc40c2c0 1
  md.l 0xfc40c630 1
  md.l 0xfc400000 2
  md.l 0xfc400420 8

  # P2 upper, usb@fcd00000
  md.l 0xfcd0c100 0x14
  md.l 0xfcd0c19c 1
  md.l 0xfcd0c200 1
  md.l 0xfcd0c2c0 1
  md.l 0xfcd0c630 1
  md.l 0xfcd00000 2
  md.l 0xfcd00420 8

If CAPLENGTH (low byte at the base) is not 0x20, PORTSC is at
base + CAPLENGTH + 0x400 instead of base + 0x420.

Cheers,
Anders
[1] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v11

