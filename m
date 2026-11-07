Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EF606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nebTlGMQ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Nd/o23XF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 523B981684;
	Sat,  7 Nov 2026 12:51:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oROwapkTRNGr; Sat,  7 Nov 2026 12:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B90EA816EF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055853;
	b=FaqEgd8KKcQ6Vj91MfExgCSHnJSciZC2Rfa0m9JuKqtLykHX7FgaUOy+iTUFBHHE+dR4
	 QhUn8p5x1D54rY5novkhlXxq/l6rMsTXVWWM2UE6JlV9B1TNAYDEbNMWR0QsxFylRt4wV
	 HaAG1XpR76xq79t3oE20e3xkSx3e5UIOvn3gLx8m5r1P9PDXMwq64W0UNO2LsGiZmClOA
	 dZ9RBM4aSxLp9nqngjAqfx6ixBh9etblkCDySnPGbTpamZqdzuAoHuij/1kU/UuIp92UR
	 PIvIwZGgKFz87l3SLIJJ65SejAYxiwXYlKhhOzDj5PHFMmNbDLAsYK6Uw6rY62w5xTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LtM57qFVXXmQVnXYuhHVCSEswlVAfemLnSkHuV17FHQ=;
	b=fVhxqOJxhGA+Bz4H/RjJACKNHM8ElxxsET0c0fiNeqtQmUomwFmny3qPPyaTQIsQSiGR
	 nkiR28urAD9EcORDAvKx75aUqcMrA0+wHOWzxZ2W4NblBemIW7fEdWANUOIa8r54sk2XB
	 VtN2YMqOoCj30a8rXLBDBBVg97Gewje7IKhkMHMH7qkZ1BkHGaP61MUFD71kh2zHRbn6a
	 JQ2nh4OgEdHz4+jw9TN95K96PJ/0C9XwqWKLT0Ifs7JMMGXkDLu6mCOM2zV/1ol6xu6Z0
	 IN5lr7dCYwaz+TEym8SAJ2BnDH8HcfxRh9VyJhgScv+uVr+jMGgFMk0SC6o+Aw+c07w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="Nd/o23XF";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055853;
	bh=LtM57qFVXXmQVnXYuhHVCSEswlVAfemLnSkHuV17FHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nebTlGMQf1QSVn6v1Qu971QHrimK/uV2NU9W31YUp5j2jBVRapveT2x/VtIR1HDuM
	 9n0VJhhRjKWGVObhpygDWklsQ21xPH2JXl5ZqwgNeXIru8+0czQP0WPnFg5dzWgTEl
	 mzseF/VVrjOH7tjZlyn32YCr8KjYP988nZC8OBcT9Iry+bSrYp6Wa9YCQE7k5meuOg
	 v6qeqvRbOKxNl6H767MnBV3M5zaFYRSOFi6+eKVi60CZaD8qmxS4ps/D4qYyWVba4R
	 PuSvTNLth0fPCU/+pWEMnao+wgZlXr9rXBHeQFn0JuXei0E4xKOp+0VbIRkU4W5+Dr
	 zV5mHd4mmZcqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B90EA816EF;
	Sat,  7 Nov 2026 12:50:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFF7C211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B574B81244
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7t8Hvzwfkp_C for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 08:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D15681238
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Nd/o23XF
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D15681238
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 08:34:34 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b5853f3d8bso284883a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794040473; x=1794645273;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LtM57qFVXXmQVnXYuhHVCSEswlVAfemLnSkHuV17FHQ=;
 b=Nd/o23XFGHPupimFAbH8S9jNNGyaIyjJiG8eOkkfhJG5XgXc9Btqr6eSPpQu4d9aUS
 vOsI2qwzjHWG70lcmYgBLbUtsD7Q/a1A5notvkJ2gEsatT0RIM0Xfl6PhZHtbIoIMrgq
 U0h9NDgmv4JUmfPBaX2iFq/6obak8G3dcY/fyaXqyAFQpzxfvoyvJtKxffH4VT2xP7fn
 p0P+6c4qZIt5J9q4NYrl1xLxP/y24E4YoN7iqZADeGAzTGyd42OT6no+L6ZzMdQgPe5B
 DRblTsgkuSc77lxA2v2CdksFbGrWGPlygYSpV0ryCc/S3x5w5/u+eYPgZCRNZgpGGjlz
 UklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794040473; x=1794645273;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LtM57qFVXXmQVnXYuhHVCSEswlVAfemLnSkHuV17FHQ=;
 b=oedYfNxE/NHnGfuIOk3r1P7Swcd4PlkXOVqbh9kkf6WxE3+eueXIEPd8CrB+JNeoDJ
 JfKxtTW9hIzNBXcSYmd//ZIhCtT6BCAmDNki1ePtKOvMfLEKjFORG/jj2GRtn3PZv00c
 rkraTf3iSo8+94MHy9zpNMVq54LiaJpRCVbouAuiveXbDHyyE2mhBkssYa8qOhLRf4tR
 QpNz9mcKIXXRWS9FVVol2+CMFknBFOs2nX+xRn5Xu+GUnK+3TIqDUOlGm6kgO9nYNsOI
 7cBWG7M7ALVcF4X9FFJznqqIFpeI2Ao9saBNk191TqLrVxppYSpboMSivgwzTndQ7gIU
 7sAA==
X-Gm-Message-State: APuU4Z8v88J8j0zfdKUUqnYoU8tVQZ2oY+JOEY4XM9YoqnL7K0+11fWE
 HZPLNBpgPCqLv6b1Mn8x+7vYCaNMryp4KGMyeG2zTLtvd9TlFBtQs5pQ0otmo7Z2riZJpwSpaks
 VeQWBDIfQls3sAFaCwrk6JVDE0yB7kMBRVZfv76ZYYA==
X-Gm-Gg: AYBFou3gNoHHZrvelOY8QSrT1fksyqLXNtcu0erXq0J8tRn0gvGmFMr9cjYso7YEo9s
 O7QVCcUnFB+3Aa+rT0xX12yRobqzscfm9wZA2gJVRoVqSTo7jMWJyIsoStw7P4bmSkLTcj7Q+vs
 cYbeLeV/8XBSQEe5itEfhPxTaRmwUvNEwBqXpakbXwjZD5WZNhDpq01eU5nwXw5gaZ928JwTN3V
 fLQXgMXXkwSPTVdQxXatmGZ0vo5GVo7pETdRPb+BfqdAEln6MX2eUrsMhnPnlpy2Ra3zAlDS9x+
 pRxlBRrX6vgFvRBLKdRVzdevTN0YfvAqKftO1SMaZgzTIktgKWT1rbCG3RSspsymyXzlVqGqbGF
 Rm9sexDSLRkoBGwrrzx/vYeQH6NunNhtkB6c=
X-Received: by 2002:a05:6402:1256:b0:6b4:2960:d381 with SMTP id
 4fb4d7f45d1cf-6b5975659b7mr3731918a12.1.1794040472251; Sat, 07 Nov 2026
 00:34:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
 <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de> <aunlk5FaVe_jcpSr@monster>
 <ca7b3725-cabd-4064-95dd-46c3eaa325f0@cherry.de>
 <548adaa3-9d2f-4fa2-8fdf-7c537c4d153b@cherry.de>
In-Reply-To: <548adaa3-9d2f-4fa2-8fdf-7c537c4d153b@cherry.de>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 7 Nov 2026 09:34:20 +0100
X-Gm-Features: AclHuK9yRwzvHu1lx6VgnN2zT36XkMwR8FhE-6zku_-TwLtmZ8S2c1berrk1avY
Message-ID: <CADYN=9LxRY_AT4rtyv9OfpxWcWd-uRxQnbAgc7xkhmx2HUZgNA@mail.gmail.com>
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org, 
 trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com, 
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com, 
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org, 
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com, 
 s-vadapalli@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:49:49 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 11:57, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anders,
>
> On 11/4/26 6:51 PM, Quentin Schulz wrote:
> > Hi Anders,
> >
> > On 11/3/26 2:45 PM, Anders Roxell wrote:
> >> On 2026-10-30 15:28, Quentin Schulz wrote:
> >>> Hi Andrew,
> >>>
> >>> On 10/28/26 3:15 PM, Anders Roxell wrote:
> >>>> Hi,
> >>>>
> >>

[ ... ]

> > I would like to run all test scenarios again and see if v11 introduces
> > other regressions compared to v10, but this takes me about 2h
> > uninterrupted and I'm not sure I will have time tomorrow or Friday as
> > there are other fires to put out (still have to review the OpenSSL
> > provider thing again, and I'm now finally impacted by it myself as I
> > updated to Fedora 45 with OpenSSL 4 this morning).
> >
>
> For the v11 (commit 6030c4d33099 ("usb: dwc3: enable SUSPHY again after
> xhci is registered")):
>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> RK3399 Puma
> usbdrd_dwc3_1
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> RK3588 Tiger
> usb_host1_xhci + usb_host2_xhci
>
> I've just remembered I've now got a Pine64 Quartz64 (RK3566) with two
> DWC3, will try it next Monday.

Thanks for testing, Quentin. I added your tags to the v11 cover letter.

Cheers,
Anders
