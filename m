Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D7ECC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:48:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00A5880843;
	Tue, 13 Oct 2026 10:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dzUB46V546O; Tue, 13 Oct 2026 10:48:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6DC98081D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791888525;
	b=GPwJirWAP+LxscnQEOkgC9PdwXmVumsY08zrpA+tgp9zGxrCe8khg6WniqWkSigoO0yW
	 tDyBAN/dfG1/znNjatV3iN9ED2tbKj3k+8mGxDA19KOigZQEh9jJsS9xsAWTeh58Gj9oR
	 ZfXaHekd+SX/2rvnZW2/IdYMLbkl17HhZHcg9Q1mmnR6G/jMvPyjnYS/zLtvY5bExKC1/
	 4BbwMBrCACuliujj8NhwkSqNlFoViHJv3SR7pEWimlJV+zcxmKgd8llQYnIeFucNsvJ/v
	 avkjGsEJ7eZJes2Q87MwjdFaeFIfQhy9nCyreBD1IJdpLZHiqVTxZJdWrCC5NaiA/wQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791888525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KF0tSsMybKCgU7jLatM4UYBr7V9ueSXbXqPRFxWIF40=;
	b=FMHZMxcOPE7mk7zY7NI7DnvBQ/H8sWmKgMqiFVYFjdzCB+56ia8vfSthFdC/b69FqQLe
	 Z37r1QngO79E833Jb7W4V6/cynax2Wq0khJY4ahn7Vt2yo5JNVRj1Hw0cwAZD7PscmbCZ
	 cOerdQb2yCGkS9Z2WeIPCs5G9c0t4ea/oEgBnMMzv+J85XBpx3u46HmFQ7kgQc/EKTBAw
	 hJcV5OCnzzcRMLcgQFk3V+dIKQCIeH9Z427o7YcoKyDvMJuk9hjj95psovDG+jS7NAdNk
	 SuvNRFMMUQmJwNwz8+Nydc2JLPf8gGrtOHp+g1kGVX9HW5IGwyToeeZI+CSgn48l2Jw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KiyGTCcH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791888525;
	bh=KF0tSsMybKCgU7jLatM4UYBr7V9ueSXbXqPRFxWIF40=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KJQktOKbf7ikc5akj9aHQbO6TbG7JJt08fd6uJ+cpD2b4avQTBIySnZ5gTDu0e2Ri
	 nnXdTmsWyJtjzKxs/1/DocJ4QrMbbiv0v30nw8DUALhpGjX36MVhWGUIaxGsBtodAh
	 owziv8mwOlqOSXaQ/l7YEbcqXxXbNAzIy0od3bwtb7kk3g62wLuERTzG7XHIU8lCDv
	 cQete1tU1K0JzXjvPysZTT044MC3f3zThwv/F+uS1EJmPvAG2hE8hLaa2O5mym+6Lw
	 HPV2oP77yvm+RdeLHfFuLn3xigwCK5ahInYtnyEGpS6q6gzGtjUuLPr5axdMOZwM71
	 E3ijZ0ciqU5bA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6DC98081D;
	Tue, 13 Oct 2026 10:48:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB8FF75
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A90338081D
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5_HnxN4w6Z5 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7491E80818
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791888523;
 b=IHL9A0hh2+7hgROC4ZES+QvCRMu6nxIEzoYpLBgWpEjo6v21pt6CO0PVNmdA7JbZ0pqI
 6DUfpPp0WyocMUXkC3yWLi4Bx3WlowlxWo0jtiQFDIG2Q53xyP999ark8LoeYjw0y9rzt
 YVEpWsob12RCnFz9gx3WrCrn5PuuOvvhXiDR18qFFZ3U6dilxjkB2jvXuCYMFmDoChR+E
 30ptA+KGMaoeNF1Oz6CQcVK6CYa3XVo/z45rz0qNHSi9hJUYI5Mci8wtGH8cPcRZtXagW
 0IOgNZpA9qDpwp8npoOJ2/+ksFQftJV6yT+rWKy8TVaXNot97UmkOAisgNaqLc+YAlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791888523;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=KF0tSsMybKCgU7jLatM4UYBr7V9ueSXbXqPRFxWIF40=;
 b=K6diLRVwtzpHxKn04Ue8o7rI8t7jP9KyRhlI9XQt8qGMc+bEcU1oq5TdN15UiiCg+F2A
 AHave5LC23kcTO7VVSmZR/Ns7BZMng6WJniZmLLKC9MFO8UL004j9hPWZidCly8/aMm8I
 rgjQnrX7D89m04atXHyi1tNpypgYQ/DGrZE0g7ff4YAfrrOg7tUyaMrQ0q+GWJDDiRC5I
 Jc1YAMfGUZCMsAzJcrUHXuyA1rpWY9hTKaI+r2NI0lWtf8ojPzkwjTApLyJt6jo/mbNZy
 QhiQIEBiSccPD8IgflaS3j0c2CfgF1/TmpDx9ri2eDYBne39oRcmwmGRlhNssJXEOXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KiyGTCcH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KiyGTCcH
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7491E80818
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:48:41 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c263415982eso330369366b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888519; cv=none;
 d=google.com; s=arc-20260327;
 b=cZFo2BgVTf6tViwny7yZidQnRN7jztew2pol+HmHIZWOL8K9HzbZfVScqUQVn9qza5
 92Ycj0hK3AOyTOso9g1J8tr8nvS9L7UJf6lfmXkFWyVSzAEH/t9hXhXSVw3nefC6yWgm
 0YkCGSwRoYZStMI3i7u730iHwMiL1RlEUgsUjtNjTlTfPLR0zgkS/yHWf22g8eSAM4ec
 kLXe+/vcHr/c81AzhQEcLKAPyr2DJPnIcWYL00sufi2yx7bBS0LxPLJfhgx0XI9EjqK1
 qkByKXsCReZUA6SX+3p1UNRDg5WKE5vSkCqD+2ctszeaSHNSBsEnhgXs6hCLJC6hllo2
 kCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KF0tSsMybKCgU7jLatM4UYBr7V9ueSXbXqPRFxWIF40=;
 fh=QoVswdEzJKgH4fCp/6w67GNuVr5Nz0yDB6OwWH/AuRs=;
 b=WB9+ggQLgFqo/JC87qI/GluYemFi1Yha/zo4W2W4fARJaXFa0qR/PjGVr/bL9gta4K
 sPxDLJ93r9vlyLRsLvYMJPlBuPJbzit6M/K1VWJIcsQIV1pgTCN+WTPEkztZ0qtoXYvO
 YOGNVIHUQQXStzj+Mlo5hC+Ks81rRkh4XzRb6liNV/RvG/T7dqNWOPkGH3vxHmwyUeVk
 nsVikY0CO2RE+bcyRNMIbELny5QGu2qLoAYE8vW6bc+6l/TzLz7ncYR60A6ERu7KI3nO
 G6n5SA39eQYO0rbBLuULcCjd18iUxWT3hF4xINutZHp4LbEo+WGbY3l2xKecGVNvrarQ
 IMlQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791888519; x=1792493319;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KF0tSsMybKCgU7jLatM4UYBr7V9ueSXbXqPRFxWIF40=;
 b=KiyGTCcHHto0nAeI7ZfyBRHjp8fRyzNzhz6kF9Mma7dsnjo0mpixz3BtDzRfc5YpZK
 L9OeRIy1TvujVQhia4TNfzbP8lVMbI3XSjcoUBBbNcmx5O+MdggQfI6kinmgXET6RxTw
 w31+NVpFgXXCL7i2v8jv8KLra+2o9lNAfPVsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888519; x=1792493319;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KF0tSsMybKCgU7jLatM4UYBr7V9ueSXbXqPRFxWIF40=;
 b=JmwNRtGExUpoW/f8J/eLpGAvm+HcWucw7JEmO/1vHbkEraaA5WYsn2tN+WjNQCOBI1
 6OGrLcGncGPk9IXrb94OEJqWVmhlziasC5CNJQHNNsibYXuQozcM75sbZN4vXROWPXQ4
 iQmESEiotBVmN1aRUMJM315ZVxs1ryMtVc/nqsylxvShzjf9rJPprZ4rfUAfgV5sGGA/
 JTUEIGggLltnqwUahYg6edqGlGBnfnTzvTvKBRmjF0zUovXw3cBof+A00Ru6zxDHfgW+
 ng5U0UoaP/5qCOasaMP/6/mPg5Mub8dDHHqmVUdy2fUCEeCATtJb4bdEg3zCDX2AzVUx
 YJJw==
X-Forwarded-Encrypted: i=1;
 AKwUvByYxy3xmz5UyHsVVGjqAm00xrVNa5yFqnvkQmnazOJbMrY3EP5zl/6Eugc7oqPKPd06BUeRXos=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJWsjlHrRDNmkvWFtDVRVeZLMO0Iy+1hEFLnCwn36gme8Zmt4Wy
 CaWBT8aAYoKWS8VVuFvyGOsUI7W8ChInpyR3jYQ3CBNFtMX+dVZITiAdSib6H9lkALxAaMyugwR
 3+nlfLvQjORuD1cxn578E7RORHlk7JaEPT0hT0ZmA
X-Gm-Gg: AYBFou2tuwNbmh55JgV0lBbe31cLtp4cuRQLMsscYtB8fECAXkURlsy/Tir+2vScAOx
 Qu7VsJc2LUlixzZAmpRIJe+oWNmfEd+kwm0vvxa1VaCst3VtovhWJkqLQUuf1Z5B7V+IDrWF7gI
 YMQKvuNr0F5BRF2bY/jQ+cYykdugi1jtHHONUY0JviO9PFN0UIwCEzHGf+cK+LD2FPN8ajkbhwa
 qtEw3lEtKR6RFOfAeFfXhzE1wkxN8za+eqVYew8ZbgrzTMdhTa2REdpydBDS7zUOZT/57h7VI+D
 mKgDhi7SOXRe3wiCHZkBUpYrLqPSMdsuTX4rxbmku5Un0ynBjOOqap5s
X-Received: by 2002:a17:907:9694:b0:c20:9447:bd5e with SMTP id
 a640c23a62f3a-c31a9fa1d3amr1231293066b.9.1791888519212; Tue, 13 Oct 2026
 03:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-spi-probe-speed-v1-1-ff9aebfebdf9@iav.lv>
 <CAFLszTj_fXh+4c2Ldq4cw8n973=R-1z38SrE1cp6-Z0hy4+USg@mail.gmail.com>
 <179113522079.1894383.11891966557600672757@iav.lv>
In-Reply-To: <179113522079.1894383.11891966557600672757@iav.lv>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 11:48:26 +0100
X-Gm-Features: AclHuK-BBCbxLMIBPP2OCMfEXN9mxzACZ5YEDK5IplC3gJzcHRgF7dsady-hq2o
Message-ID: <CAFLszTj4r1dD0D828=yDYtH3ikwUkQ2-1_FH_OHMTBUzD05Hrg@mail.gmail.com>
Subject: Re: [PATCH] spi: Probe a device tree device at the requested speed
To: Igor Velkov <iav@iav.lv>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Igor,

On Sun, 4 Oct 2026 at 18:34, Igor Velkov <iav@iav.lv> wrote:
>
> Hi Simon,
>
> On Sat, 3 Oct 2026 at 06:41, Simon Glass <sjg@chromium.org> wrote:
> > Please can you override just max_hz here?
>
> Yes, v2 will override only max_hz and keep the mode from the DT.
>
> > Their flashes are now probed at that speed and stay there, since
> > slave->max_hz keeps it, rather than running at spi-max-frequency as
> > they do today.
>
> Checking this led me through the history:
>
> - 96907c0fe50a and b0cc1b846fcb ("dm: spi: Read default speed and mode
>   values from DT", 2016 and 2019): a device with a DT node gets the DT
>   values; the second says "even if speed and mode are requested" and
>   names SPL boot and the splash screen. The SF_DEFAULT_SPEED help says
>   the same.
> - e2e95e5e2542 ("spi: Update speed/mode on change", 2021): after the
>   probe, _spi_get_bus_and_cs() calls spi_set_speed_mode() with the
>   requested speed but does not update bus_data->speed.
> - 3feea0ba196a ("spi: spi_flash_probe_bus_cs() rely on DT for spi speed
>   and mode", 2022): callers that want the DT values use
>   spi_flash_probe_bus_cs(); sf probe uses spi_flash_probe() only when a
>   speed or mode is given.
>
> On sandbox at a6ab6a66146, spi_flash_probe(0, 0, 1000000, 0) on
> spi.bin@0 (40 MHz in the DT) leaves the controller at 1 MHz after the
> probe, after spi_claim_bus() and after spi_flash_read(), while
> slave->max_hz and bus_data->speed stay at 40 MHz: the claim compares
> against the stale cache and does not reprogram the bus. rk_spi behaves
> the same, as its set_speed() takes effect on the next transfer. So
> these callers already run at the requested speed after the probe; only
> the ID read happens at spi-max-frequency. It also makes a sentence in
> my v1 commit message wrong ("the next claim of the bus goes back to
> that frequency").
>
> > Just to check: should a requested speed above spi-max-frequency be
> > honoured here, rather than capped at it?
>
> I don't think this choice is mine to make; it is about what the SPI
> uclass should promise. The options I see:
>
> A. Keep the v1 scope and override only max_hz for the probe, so the
>    probe runs at the speed the callers already get after it, uncapped
>    as today.
> B. Honour the speed only for an explicit request from the shell
>    (sf probe with a speed), where whoever is debugging answers for the
>    value, and keep the DT speed for everyone else. That also needs the
>    path from e2e95e5e2542 to stop overriding the DT speed for them,
>    which is a separate fix.
>
> Which would you prefer? I will also add the checks you suggested to
> the test, on spi.bin@1, whose DT node sets spi-cpol and spi-cpha, so
> lost mode bits show up.

This sounds like a decision for the maintainer - maybe B would be better?

Marek do you have any thoughts on this.

Regards,
Simon
