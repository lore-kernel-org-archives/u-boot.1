Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89BCF94CB8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 00:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABBF84178;
	Wed, 22 Apr 2026 02:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lv4FmlWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A697805D7; Wed, 22 Apr 2026 02:13:16 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7C484178
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba699316b42so497453866b.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816794; cv=none;
 d=google.com; s=arc-20240605;
 b=DlXe5uRwe9VXSbQmBnXqMwT8TFp0Lqyk5vUCWLQ9lYHGwrFdqaK8mFJmCFzewBZh0r
 BTvCWn0b2DnVMNbTFByc02+hkbDaI98psBtacjXzn92KatLLSJvYnsCu1AxksUWVX6JS
 z8uVKdXyotdme4ZH2NYXcKVLoo1jeHVzIodj2qPnMH02w3gVJXVPneeMyAr1xJOzK0BI
 MgzsNDNHOBbG67Urrztgx5wQSxBA/K5DmrShY9FZeRVqRPx3lWEFL8+2yAlU06svZW5i
 XqItYhoQ4uYQeCf6jPWswI5a8HwbrckzpliZG5sOKDmlUa6yVKCNrl7895KA4ojl+jqK
 /uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s4irnFq4eZnnlu6+wQnijqmH0xIaBSnc89DTzxv6nUk=;
 fh=GyjVbUzo/sgVo7o61ypigW4C4XsTPGWcaBQI7MMmv2s=;
 b=b73o4HKBTp6Z9QbYm/1K02AjWXDUa2/ZRJ2lGKg8Qpk2J0HTZv7FCfCIO81H6F9Zlg
 4qumtKYWM8qDT195a1bkkrss/rK8VCFKryK0uDsvNtJuYZzgqWOce5jLS96fQQ2sisnQ
 yquMlxLSJwOCOPL87Ul/2K8M67O8kc+tMGJjLNffeAB8PTsVNkq0wxaERC18aVnCwsvf
 QURRrg3xzcCHChxgYV9rE9gAQeYC8N9sRl6IYIFx/XA7+CW05qdROYxjtnB3jvEO1Zu7
 cV8unFcCTzSuT7vuz+K35HbDBRsl3DdXoDg+8Byj1Iyq9AnwzvCiBjMUeeOkROXLQsaQ
 yeWQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776816794; x=1777421594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s4irnFq4eZnnlu6+wQnijqmH0xIaBSnc89DTzxv6nUk=;
 b=lv4FmlWBU5Yd/ncq9SLWWYgg7B6Mnkt4iswjmnRzU1kp4bszx7Cw0QJw1ADBTHc8E/
 vR7Ijc/aQwXdZLd37y4z6zGdkaTBxPhmCOvNQnNGPXZ4quDPhXBREwiBkK1f3IvNrNTx
 1ndyW58gtjCVQ5hnC8I8hXCNOcbitUCV8++cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816794; x=1777421594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s4irnFq4eZnnlu6+wQnijqmH0xIaBSnc89DTzxv6nUk=;
 b=BWb5QWfiCPZJOIUBJnX8xRSUrrjsbkbNpK1+J2g0bFVqd58xjvc6LjjDVQMdcX5ucw
 l8cM2KwSXywT/c8ELnF+ZmFXDE5AWl8hCr8mYh6wtRT6Nf7hi/Nqws/R23tr3GemHbU3
 1YxREiAkcCuernw/IO/n5feZHmAg5qbLll6HSw7GzE9Tz9clh9RTCIAUlVEOtJpzUnzz
 8RJuopsTnXdF8e9vnfrL2+FsX6q0qcVW/Rkkt/Mkm0cWCqImlzWs9jDOzz+QDq3wnBM/
 fCExF7Tgi40jgrvU5qrfgxGVG+p3AosUmGaI7KBv/v8E/WW24KlTdnj5DFpcZNr4GbpE
 BDKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a6s9HtZQOA3HWGzCy+3ZTczfpIVVsJ4VTiebYg5dxrjNcEwFh9Wi+TIkAvrk3gsoBneWDU98=@lists.denx.de
X-Gm-Message-State: AOJu0YzkR7k3WsV0+w9NkTFjOR3mzy5NjkLb/YW4xfvvzaRtE26ughdi
 ScArAjBgVp1kfuaxp7x8R9K2ejGvg7M7RoZ62+0c0jvnJHVmqaORdIeSEXzh9Kjr3W1MNoMce8u
 SvAxOt1jycSPrr75OyPvv88ojHLyGcCLDerqG8bDCDELxwt3Tk3d1oQ==
X-Gm-Gg: AeBDieuLRGsJxQuuWFR79eOniWGCy7mvko06zJUPFix710UvRXDRtM0zoRA+F4fxR/i
 tOp9Weu/7iGvOEXo+Ub0IPz3F8at/X6gT1Vb5p6TnfcFty0wTxnv16koDeCECVGaj2chpJovj0k
 i7yuVCuixRZL8brVHzMWDpKppaTiZfXkc3a89+UjNd3NGOQi7t3+VPBqozuKH5zhUHoREq0LHHM
 jMZ/0Y6hxS9h3LmkWtWZLpXOu7uCtLn++21Vps3KBuOXULTtMShkBN4SRj/3Afd9fbj5a11gkvB
 UhrmcC97GldvskO+8Dzz
X-Received: by 2002:a17:907:7b97:b0:ba7:a94d:af9b with SMTP id
 a640c23a62f3a-ba7a95cf4f4mr556957866b.35.1776816794163; Tue, 21 Apr 2026
 17:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-10-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-10-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 12:13:00 +1200
X-Gm-Features: AQROBzBjh70EcZnLww7TVHRm0GuGPOqJ92QQxXMM_s_RYNAuoL-rHzj3BxKIQoU
Message-ID: <CAFLszTj-j6WCrB0BdjmBa4onVF8wPb+rPnQvpD2Hn4+gWapxJw@mail.gmail.com>
Subject: Re: [PATCH v5 09/15] tools: fit_image_setup_sig: set required_keynode
 to -1
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-21T21:09:51, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> tools: fit_image_setup_sig: set required_keynode to -1
>
> When initializing info about a signature, set required_keynode
> to -1 instead of 0, as 0 is a valid keynode offset.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> tools/image-host.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
