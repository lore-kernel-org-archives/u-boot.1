Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDA0CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 19:36:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EA30404DC;
	Sun, 18 Oct 2026 19:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4UaqKxI4DYGa; Sun, 18 Oct 2026 19:36:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75C56406CA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792352194;
	b=fThgQxgN+wxTzcPgvL/E2E+wN3425/XjsM/7MTlmLXtzTrJDCXE+C2DX0Mvr7O+pUXKw
	 yKMwzF29pb8Os1lkQ7xJySzasI29tKVJg+YckeNOn5lXSzkxUkvZBaa+a2olSsM64XsDI
	 N05DdJxWtDd8LGEXw7bA+JSsmdJptl0N2mSTnEqHw+iqy7gsTUast67wihf5o5qF9F1pu
	 XdSsgYCqzIx8eqz63hqhRtnrf5xV4iy7a0Ei6FrHvx4iNOc0T0C9UHMIrTMAzucTEznSA
	 grRlb2Z1noukUZBqhEDYUs56m85bpGfzdI8jM9Pdns+msx28dhwcmoDXBkwywEc5bLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792352194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zaZ/vj3iWMZ+mJQW5rKWpym2oWPaH3VvIc4O1285waM=;
	b=RcZr9eEOrc7Cgu3egUuMbP4FU348uSilpVeDYN0HFeJHBS5fJWQ17+jwMY/RuGNHLCD6
	 gE7xeQVTnQTJDGoea2BGdQjDfdZFhrx//HQQx4Jqqmyz2S9aY4Tr5/AKUpWgBCNKh2b3h
	 3xsy38Zpvw7NL2mtPhSuTI8Qr9JTzaC6dQJPBbeZFWLB+fxDyarvAjkMKTvpi/idmZKDZ
	 4CK5yXunpPUCtRHpZjfr/qRi9W5XRjcHsQhQjPJgEbTM1VlM9tMFx5GM4MmbwR8Mv6Zyn
	 tsoQSNSs02hAlFrRrkqcAMIihZM4gfNmd592lpqbNTufkVxrHtKF4hq1cuaaMzAbj9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792352194;
	bh=zaZ/vj3iWMZ+mJQW5rKWpym2oWPaH3VvIc4O1285waM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zBTrYkVetG8ASn+4cZLs3Q7FR5UbjJeuV/ffTXAN5M4b+tkD5oCFwe5GpykK4qeps
	 l7z/D5dCdvtP0T8qFdIgOSIDgcGYPeGY/Mzh6cdltMPOHomMgHra4hGd9ruAzP8giT
	 0xIkzY7U0baXs9nLxJkVsWfSuSM7ywacdeyCmm3nTvRjqsFMQJjR3jIWY112HWBjTi
	 Oh+9ah0uTH9r05UVHBORg7IkCrDZS3Zgm3Qw2oHiOVXtXDI0S81CL3YGiWuw3ggQDT
	 Z50AiYwMj/aO+yXTMojIZwVofLKNTCKnM5Y/ji2OgSFScj+YQKabc7UcB1WYZkxK3N
	 w8rY05KnZJxXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75C56406CA;
	Sun, 18 Oct 2026 19:36:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C8E4769
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1279480F56
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0us9JfClFcFN for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 19:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A00980E47
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792352191;
 b=bMWhIcv3DLCTcQFWoeO48QozeJzf2El6Jo4ACccOGFSTmkSEwVKoYFGGqXcagTxbGC8y
 ep/AE/PMzz3FMD3ybBNc1qIm09dpQ+3gxEYL9eeYiF83ylDt3z77fq1PuWABwWiyIJnOY
 Z55bs/GB4cMFcVxu5cgZwfEX4RsBeTqnAFqmHxuyb74LB/gXaIVkTjKC2pqm3xZaX+kyA
 NJeJ6dn7K/H0F/OyUbPbqnY/yS9x2bFjVW3IJgXf64rDIL1/T6vU7Ywb7wuhKTVAOL8aG
 sNvHP0/uhigZ4C7I4I0dy3r2md78uuWz34ygtxmJtnGZtODVWH+Td7V7GIPLWcFU9YA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792352191;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=zaZ/vj3iWMZ+mJQW5rKWpym2oWPaH3VvIc4O1285waM=;
 b=pz8KbaJ3D0NkBLnsEJiW0T0NC8xy73SsyvZtwmIjPz53IFGCDi8QgGFkPR8j09Ij2Ch/
 9je2JpMh9sDNfysRSkqe4Aef0MfGsCm29qJmx7mXP4WwF9KmD6RhFxoOgjsL/kAWxanG+
 YDI4qtUCjphR+aBMjQpsSUckgM4H3oUALP3im0FfpcH+1wzM1DSSSmQ/6YNwaIlJvJWu/
 gZWoLT0u7QxLfAAqr+uHaCkaz2DxJdnDvyfsuoWmwO1DQeA2iafABgz6nSBnZFIL8Fs2I
 gHRWRVREkqa12Y6V0IUKdrly82B1W3Z/WeN7SHawBlXCFVd7rfSM/ylaGUy/vWlUaeg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ezR5sS8V; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ezR5sS8V
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A00980E47
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 19:36:30 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso823999f8f.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792352188; x=1792956988;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zaZ/vj3iWMZ+mJQW5rKWpym2oWPaH3VvIc4O1285waM=;
 b=ezR5sS8VioYKMxU66LbYtWKkoFrhTF+DL2v4FLcwrUnCVGr8C1KaC/JtHnonVxb8e8
 kYldCKoECyTzPz/AnPko1sSNUbpboEUyQmbCzIfojFzo92fMQdkJBavT/aSAn3x8K5eT
 0VsBeb5GPpE8vprzmLyS0qICUnGJhRwMVB2yFx5E4mEFXaqxsDzssgksXITIOQONbgki
 Qh6EReihcJ4xJ3WTDsyWwxtONAFfRqXIE1f20aO9fD38iGZ9SJFTmCQHJDeD7RW0f0ZJ
 CDBYRoQ4WNM6D36uAK2fblobLCqn8Wq0R8HHOcdUiFl7TaeZUnAErryzXqmdo6FyAi2r
 CCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792352188; x=1792956988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zaZ/vj3iWMZ+mJQW5rKWpym2oWPaH3VvIc4O1285waM=;
 b=dzADfme4iX7UOYBsizJwawSnkcC4hOuoba2UsaciN5vMqH5EThFUlzNU9mmbb5vEf6
 7PzxCLNurlzwBCyKgLOOuHTZeZx32/LWLn1D9L24oBLjJtstlCnI3LF2dVsE6NlLhfsg
 9YkVOUXn1MjdJ5XWQkjGBhfDhsQ6Z3nkgLppvNay+cBAK1R4qfAPwdShhQzTs/ozBNB2
 DzemhUWQtf7n901ZmTt4MUfCPikZFVuA8kWfTeLOLjaAGtplS6KrJjq+fZNJ6YBflr59
 o/wGLSFAnV3qNkAsxTwG2yULp1YpE7oI5/YJu2lECu8ihjVK7GgAZnMTAXOXpTjJs7XG
 G19g==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1L714ObbUzr6b6axaZzURGokiRDdfV/asyCMFUr9MEtSNbefXLj4clDvkMXBCPlTVZPx5T3I=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIAVTWJWBQj/vKr5AfAPaiLDXZngTpHRlkq5ZXRsVghLCTJJkdd
 0aC80YEkPSxloUDTZfJHy32cH7/RtmNSmsyn3ESntiUkqPAJm4+KYDpv
X-Gm-Gg: AYBFou3Q/wBbwv7gtTNKGsk3r3shThO50yE3hhATyDXGC4slOW0bKUlfp06asV05D59
 scdzpH9jLCvV7AWyhG1XHJ8bB9L0KpPTAKOtp2Y3GEG7uL+tFngSbcC0fAlCk1x7NqWfRliRwES
 DTQiCvOU6BfQYWl1AeICpFepGctMt0bcDdFBByUOQnXM8CyDIIJ/tegVBGwwP1/6D27drTMejvs
 LnzCLyytTKXsR+x0+p2hWvySQwUxzCqdw95HXTs833Mfjl04YlOW/+a826qLsKCSeKd4scpfNaN
 +RoNEXWp+xEG1uSxwGLOUaZRGCMW083ABiBxxsssIPjOHpV5jZLuA7q3fVBjVmu50KznE89fvvG
 4TIEJ/j1IfXmxG37okiKp9lDxtFNQIbh+oTja7RSh53hC5ZN0haBQuEgIx9YBTnEXTKnuJOtC8M
 1W9FQjhfZbPbDst1uZ5zf3oK6o+e5Phtp37n9pBKhT9bZ700g0Qf76hQElgZJYDLM6PiBTAGNm8
 HXy
X-Received: by 2002:a5d:5f03:0:b0:485:8a47:5b91 with SMTP id
 ffacd0b85a97d-48e07fe0205mr11553886f8f.46.1792352188021; 
 Sun, 18 Oct 2026 12:36:28 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7ff1sm19674570f8f.25.2026.10.18.12.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:36:24 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v6 6/8] usb: ehci-vf: use usb_get_dr_mode()
Date: Sun, 18 Oct 2026 21:36:22 +0200
Message-ID: <20261018193622.2896690-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <571de8dc-4737-461b-be79-5f18315452f7@mailbox.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Marek,

On 2026-10-16, Marek Vasut wrote:
> Please split this into two patches:
> - First - only the macro replacements
> - Second - any additional clean ups

Will do in v7: the first patch only replaces the private enum and the
strcmp() chain with usb_get_dr_mode(), the second moves the ID detect
gpio request to the device.

> This has to check return value, gpio_request_by_name() can return
> negative error.
>
> This has to check return value, dm_gpio_get_value() can return negative
> error.

Both checked in v7; only -ENOENT from the request is tolerated, as the
property is optional, and keeps the port in device mode as before.

> Thus far, USB_DR_MODE_UNKNOWN or equivalent undecodable dr_mode made
> this function return -EINVAL ...
> ... Now it seems to be handled as host ?

Yes, v6 changed that by mistake. v7 keeps the old behaviour: a missing
property means host, a value the driver does not know fails with
-EINVAL.

Thanks,
Mehmet
