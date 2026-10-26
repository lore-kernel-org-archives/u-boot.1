Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RF7gBZxo;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fYMTxf4/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 506FF406DE;
	Mon, 26 Oct 2026 16:07:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9K2PanICSzG6; Mon, 26 Oct 2026 16:07:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 63D1A406B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030820;
	b=PLZcRQgVdMhLv7fEkOpI6n+ZfXypTsbuxjoRICEpHdWHayf6ETisUMG4lHGJRpGZNa0S
	 ObBfoMc70tGXo099HrP2LlhS7BHXtWgCqG3HmKNV9s18mKaRVddqeSmVReFq+Q2fE148L
	 0YY16vs1G2UgseGGUTnZdPvvgRyeYy2Q5u08Q14SNtRFUPjaePfHF7KAcTSq8LwYFdZWJ
	 Iaph4EsQp+Vn3lL4cH2jUqNdM2lXVQRJIQzg/ijOLqbpZFPC/kpXzI4kL3lC5RYOlpueX
	 k1ndp/ULVjvjIFrZ8YWA+J6qQT5kaJY29Si4P7xLQJ/FVo6NYb3bKHDZnOF5whQJ5KA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F4tYpQoSybollSuN20YA45L1CQIuL8v/karSL0/aH+Y=;
	b=d+4EWqDiamVTLaI1vte2TSoAQN+kfcfweK6YgiF8+S6SymRYGpKOWZtfqPwgYbJhOPh2
	 k+sCIEyAUx6383HMXb/Sm6n9vwgfRMED5j7gaK+AVVcITpYCMnVTfmMIPfUK5GnKpkopx
	 /VcpBdF7ZCmD08voumBXInVSO8mv+dnqZOgbauGw9Dad23S5gUXAh6os1ccVzqtYDrzDz
	 unK+0LkxyOrVo5Vqf80wghTDrZ7YMBpFvhK9pNjMgvkclIXvYmMwFeSanc7h9slvlGJ82
	 kERgMTxlmR1IXnIsG3JZT70aogN5K8Xj33xD2WFoqRVBB441617Vl5U1pI7pklTIjcg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030820;
	bh=F4tYpQoSybollSuN20YA45L1CQIuL8v/karSL0/aH+Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RF7gBZxoyvkoxVeNbujpEFeuFaIOEzChK82kjAh9VAFzq2oF3prCTcWDgOs3bDtZV
	 bhFa9wBh+E6l2YwRbOlJWa96aN76tT62AwpbRScPsKyj67WfGcCFin5uGEjFUA5vZn
	 rGAxfwNs38voF4KS+M2Vm0htYFV+KDNHPsKLm9zP2hz+x5sCjMdxhy0uqsgtFpaGaO
	 Ej2rdfKms8U965uC6u/pNi4mxMkgC8Hadnf4KmdBnj0ELjzBTgh3hndFuf2KMe5mrs
	 V+dci7oB8z9LhdIGZNPzCGXOVXqeBSYv/MjoTaO97cfKaVWrybiBNDKNTor5jnh84R
	 Qoyq3pjadS9ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63D1A406B3;
	Mon, 26 Oct 2026 16:07:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DE15235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 53F1380E02
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hq1Mn2hUCNe8 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 945A880DDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030818;
 b=cjhb82JEZ+MayOrQyJrBaHqGS827p8ZGnaMhH0C7qd9wabqhruq0PqNEAjqadLRRRQtQ
 9Rs91+K/gh0gNb8SeCRGgtqjP2N6TR1ep8MtOeGrcbWc+3yuAD5wphE6W3aHU1RV9fytb
 pbTeos4MNGWVbTqxf3QDxH5MycI7wiKRj7xJ6gs1BkwdN3CSXXYOS9duJt1/TwdbX2Jsi
 /QpeoHt8bv0woYIfMv/9eN9mFWxz4+3ua8pv9oqM5wmot7/8uA3CLxjgnVoS7cCkkDxQq
 CNPp90/7m6cjPjzVBSc3+zVk1B3PTQ7MZq7N+rtYaGFtcy6VLPBD2WlhlvUNDaKBCbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030818;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=F4tYpQoSybollSuN20YA45L1CQIuL8v/karSL0/aH+Y=;
 b=fT05g3Hht21JYX1ptp8GzBY+CnjCzen2uN38eY0A0dz6+PWBYr49n3CRBEUDxUSciEvn
 vLlG2Q24I/ERtmJGzlR27IOsWxIga9/tlYTCfLX4DYAuVr0waRco5M85shMr1F3wJKf+4
 sfOlRHeBN7EgFDw+IfYZ8z9+QJBVsotBh2kYdY5emvhj+ohSXfTIewp1WWR/LbXaZnccn
 9e75JeCKoYKTgBTbe5Bl+1GUFxkA6xnT1m8RX3H02ehMTIMh8v5XFoyIRBojLyiK14fmp
 JSKxRd6GK2V4NVEnnY4FgPggtkQ7sz+joP+HRoSAc8Fm/V9hDoL8hc85FF+NpX8sq/w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="fYMTxf4/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1030"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fYMTxf4/
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 945A880DDB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:06:58 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so2620226a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030817; cv=none;
 d=google.com; s=arc-20260327;
 b=rB8ivZtMn1XQAuuDQABtXHiuEICF16Dl4Emmyh9QjwPIAy9hsg3QNVcfjCQQrq9ki+
 XmyPZdq/zfxgeL6xsA1qWDY36Pc77XUBRpCZCRh2yimIUmlX2MD2kHyPfnlzwknFx/qm
 bS677Oj/S3xg7ytpaZhAwkfIL7c0/NdAt7sdDBwfOZeZlmj+RYr2ML/bNmgVGmM+TO8p
 xxe6KLQBm8/wc3xk+Nm4nazA68lMK98qxmTa6ItbBCQvERT9ALWDRvsowc7t55rBZLdJ
 WxROaa8XdxYX5fSEwMi8dQc7FPWmzfgu+/EB7KbZj+95Ad63+9B67aqWOItpUdmvCFHG
 BcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=F4tYpQoSybollSuN20YA45L1CQIuL8v/karSL0/aH+Y=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=ERkyk1RzTIV3/Eke9DqjEWyX64xNPRvxxzuYBS5Uw3wSai4sYzXiJuR8AmPmqKaoIq
 nqyA2toGzzPqMB2Vicb174F8Snht0UIiJX7bEtlrniCvGacOtmHviLV24l4vjhqPyjsf
 FW96fXIu51fCsjm81x63aHl//MDusm0fszc6isn+Gi/7tbUgNNcPv+dKTebE7mr1WFOH
 0DKWTiTTQTu7RH4yoWmccNCCITxiovqkNhBKkL5yOCXN5NRGlXrengmLJWT7di+mjDz3
 Bpnm+EYOK54jFXCcvVI7xG41ipNjgkXiX2S2DROTmUjyr86OxbO9AGHaFh5CvIE0OsWd
 58bA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030817; x=1793635617;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F4tYpQoSybollSuN20YA45L1CQIuL8v/karSL0/aH+Y=;
 b=fYMTxf4/ppz9VXHnTFKrvj9DNxzybvP9c4jz13embf1ufw6PjO1STuoyc431cQvRCO
 AbSTQ8IqO0zGIro6RN3tbPcHt8cEldDDoVYxu9Cm29r8PjQRLGx9VarUhrbr8Yi5WKP+
 Dsc9QHm3/driUPaV75JYXFRT2vCGpl+Ws5amo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030817; x=1793635617;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F4tYpQoSybollSuN20YA45L1CQIuL8v/karSL0/aH+Y=;
 b=E/BmnrTOdKT8w9xSQ1GCrk9283dfgzx5BB+y55ABD88/7yo0l8WCc9YU42hHr1PtOR
 MoALxrT+7oKBOydUQkeO4tt2gZQFJGHQttmlcdhXhqLT3YsSLoFF6VWpBtIlaIBiiX7Z
 QZ9Qxly/Nc6O2UoXelXGhAqqZN7dD8uxqrUTgUrJjp6DjPACc5oj5cH3iwu63ubkSWBU
 7dVu9PSKxtJGB8CJAXFz31a2O7IR2ZmsX1ZCTVx3/akfKq19dTSHcilpp5wm0xaYO81d
 VCu0tPoZfiPXtQwKJPiw06Q/1KcLxwW5aFieWcYoZyYIqQKhZqw35oYsxLNV7xRwCl0q
 lEZA==
X-Gm-Message-State: AFq9FYKR3MSbNgUsFHC+IBgDku50YrOzJCOWimq/uw1J55BHTtCZBPcm
 SAxqvSuYLsPzPwrMj9W5jzLRJlevSuo3vt2U5CkbpMDsR+tqBK22guEutKjCV6BTLdnIPcRtWoa
 rQU5prVnvjKS8+WDikqt7AHYbRBmI6xGHZQzzOF2w
X-Gm-Gg: AYBFou3fJm1Zd4SMBTSXQwxf0BiVeW+n1HqTKkEUFkUlXUDMtW2d0bENAKe8jvsePeF
 x3afGrH13jXXzUE9io2AZSkNqeP0v/AVViJPed1cmn1koZvVFOIrRAiovL1mkmVaDiqbfD1t6YF
 sU4myNukEoR3B/Y+x0YLxZA0K0j3u7qUn3TtiZuKy8bpuZb7MXaT2CUrvWjLuRvBJZ70wxHuKMT
 xHftzDrbscfUj+5BSXLkRaAhE70PUYYLdnhFHx6rzYJXZgaOAMLdRM2m+ISyUmB5jSuCotFb+gA
 NRRBD92vAlUo5gzIrZ5vAXdlTLsiRCctvHmIWNL+gGJYXSN6kzARlZrjEbB+XR2EMiIE/GUJ8xB
 k1XLb+fRb7gV40NwamlJFJDkuH+1HYVjY8TFR
X-Received: by 2002:a17:90b:37c5:b0:3ac:85be:cd52 with SMTP id
 98e67ed59e1d1-3adeafd6820mr6544981a91.59.1793030817465; Mon, 26 Oct 2026
 09:06:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:06:53 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 15:41:04 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:06:53 -0700
X-Gm-Features: AclHuK_NDRtI4biAJPITVc-sm-Se344jt_aw92Q-hI1FVIHzGi3Irtc24ARAOfo
Message-ID: <CAFLszTgNczZSGUh-hCEiZR5wQ0u6AYx+Jsvh-ZiWz5a1ZLwMwA@mail.gmail.com>
Subject: Re: [PATCH 0/7] watchdog: add get_timeout operation
To: juuso.rinta@nokia.com
Cc: u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 2026-10-21T08:08:13, Juuso Rinta <juuso.rinta@nokia.com> wrote:

> Add an optional get_timeout operation and a wdt_get_timeout() helper to
> the watchdog uclass so drivers can report the timeout actually programmed
> in hardware. The requested value passed to wdt_start() can differ after
> clamping, discrete steps, or rounding (for example power-of-two periods).

The real implementations (designware and max6370) have not been tried
on hardware, so sandbox is the only coverage. At present it never
reports a timeout that differs from the requested one, which is the
case this series is for. See my comment on patch 6.

Regards,
Simon
