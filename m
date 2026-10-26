Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53551606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FZhaUmKf;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cme9lOIQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FB82406E0;
	Mon, 26 Oct 2026 16:07:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cDK4ioS28HX5; Mon, 26 Oct 2026 16:07:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C295406F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030862;
	b=HnUJMCDd/q67yg9kJf+V4fZYqPFHnUZbwGMcuTce0Dw6k3DClZ8I7ylQhUxibWhwfC6e
	 c7rq9dv3BevHP5O83pfzFXoypexHaULLDSEgz5XDyYa1/29nIpBg3vSI5zgvEbRt5ztkr
	 OR2c6I+svX8bByIMCEwGtOfxH2LnhL89vvFTODQ6v82KhhX4bxXtx83kFevboCygTsBBY
	 5sTWAJXKR1G1wDMYjOx7vYOpzvqEbWc1lzCpgIuoLSFjCt6drm+Ynmj4o/1PhEkRwzV0H
	 L3FcWYNf9Al3vOyXZExI6siFjyyVVnosHn9ibzZggvOOiY/wRiaKW1dRc43oqHjwSKw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793030862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XRWtjXKSC5Xleaf044ett5awJVla7zF8bWDuXnMB0S8=;
	b=h5qJrbHunRsBqMiApaAoitbFu/MVF4bs2wPR/+5KOJM6g1YJuC9sm9bA0B2zSUpEWIlW
	 xxvVqzEfvLqqAcg74gs3O3Vs02j9x71hovwCln8Ct50afZiBaTFfrHK0OM1T9y+VCSqPt
	 MUnB850ruKsPpTWX+r5GQk0tiLIuSPQLPJzFQWVFS1DJLqp5CGC0MEDV7gAh78rcORvtv
	 o2hvL+afxrdnVM0k/3j7gNI0ZIVW4+jnsVS3kmm6ubM7T/1zSwJJ7gsTSrVxrhLRacAHD
	 BA/A+EX4OyqBouJEnlxvYdH6c1cnrVriq0mpOGmG38i+gzfQAEhgGaVcb1LIF1VqZUA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793030862;
	bh=XRWtjXKSC5Xleaf044ett5awJVla7zF8bWDuXnMB0S8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FZhaUmKfB1XAMu947G3kd2Yvr8dXI7FhKmxbWBRMPm02zJlASzd+72lTwR8+1rAq1
	 Ya7Qsh3Q6v1axmQM6YCskcVy4z6VHkIZnQVy2/9Ayo8BeedVnSO1kePqZQILEvbhEE
	 zl3jv9nprpqM1wIQO1xoKZxBuJqBfeW7UuIuUWs0QZ+ygpieL/v0ZZ6iTnyRw5+fUY
	 KT1p/zBmL2JoEllITmGVvqohlw00b6iHheXzMVrWRnR1Ue/vajxdhEflF2lB4yjXIi
	 JHatqdoSBuvqujden5lAnB1LAZLKjO+olo650iv6FJ8uOvS00LwbhPnZ2tmnh2mlQ9
	 sBhzUyDkmTL0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C295406F4;
	Mon, 26 Oct 2026 16:07:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 925FC2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78B6E60612
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f-o9vYvIOsEq for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:07:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7DCF760603
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793030859;
 b=OVPUjFYtxQ9iqDIKynfggj9uhblgKalO8ZYHveGcPcJd7jPFjeGt28zubve05G69TpLY
 5v6FAmSIh7aGDGLEofg6fen6LSaDr8Nva0B2Uhh56l5qflx48sDniHe9iQtgHMUfVILFE
 MSVVMducpsFCHKmYMAmOn/T9k7HLu/LzdLk+jegEvYhi0holMLZHC4e9krwrSG96+v6Ka
 uTOpZuxCxrPpiTJb8Vo1MBpo2dbLs38OddgzNm0qVAPsE4keLrnGzBsdiZBWzyPKCp1rY
 9Yqa2d9xtwXJVGSVWb4hjvXVrRtqVAIbNVpGPNVoAaDEeAtiViBbamNGHigTW96khvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793030859;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=XRWtjXKSC5Xleaf044ett5awJVla7zF8bWDuXnMB0S8=;
 b=EIHVtNxbhZp7L0oBiMBqnNHHQ9D4FKU3pMmOQclatKInbcc2P/Ni7NOPNBPkLSSmRRT0
 ALEyW7+OAemgefM3a/SztyMAsoY3zJdv60pH4bM0Pui56HetqRROVLP4Zvb+2VeZGaTNh
 hm7Zecl32+/ds6EDjoMV7Odz46XVapnKiFDPl7V1ApNAu77bbAMNnRs+NdKy6266Ci8NK
 f36na6njOoEs6om4ue5JyfXxHEmzVntL2Jmv2dIgKEOW8/cF7Oby9v4L4S/2ynUxQ71us
 abozYLC6xfd8H66GeSEIfbiyK20Es5HP35pxqswECxMqyb4Y/tU1nsoMWPPsde8+cqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cme9lOIQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=cme9lOIQ
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DCF760603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:07:38 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so3755405a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793030857; cv=none;
 d=google.com; s=arc-20260327;
 b=kFdEPLwC1iljqHletXtpftyXeSgWIJZgHWrx+U1Iy9OLF3COou20gnYkpnZp93xQFt
 tQZRZqh8ij/w7ZIz1dmxq9ekVMYM3kXq258898TFoI12J8uEYc31+4IjWR55eWMEQuGn
 MY4XmXP/yL8Qu+2kYcoS11vVb/90qGYkBrQagv2CKkPhnotXGYtqSmODFlHhS/iV+jL9
 Z4DSC5/cBFsMCpia08qTw6CrS0nIPJSYGWAX+o7UU0CK3g0IaVCec/XhCVkmN4NOGfyP
 70GKzuTEoosT+fTp7/1vzhnh+jru0Oih9N5qIAajOk0iBTsrddgoX91WO7bdIHVLB8U0
 Mm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=XRWtjXKSC5Xleaf044ett5awJVla7zF8bWDuXnMB0S8=;
 fh=Vi46RdmyXd0SupGlsPtmZZi6NaJCBu3Vb80GVjkTlag=;
 b=MjB++oSWk61qA2rbW+h1GrwwsP0+MUvm5UDfa/UfcL4sM91CTVh004/9jUF3+CGSX1
 eAGkHypTqun1Zkao0YklY8kSuSxCdZ0YZ3H9QqscoMSgXHn1Wiq/VEB+9v3FtdiMvDr0
 mw1oL2dQMncoqxqQEx5fqlT0o8TfPU0KMDQNF4izqRtiUKo2j34NiostcnRVSWCMjN/+
 W+YR7k+HcQQLFDw9A6JTwZydHUjbXWI9ex8oz9Kp+TUdE7HjQMKoyBhvx3qngynli/SR
 do6WDeAsImCkF9WT/Z+WJN2Ftm/m609qXL9SmV81jX/G4ArAjNUF1CUGAaMaIj7RFLO0
 6AKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793030857; x=1793635657;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XRWtjXKSC5Xleaf044ett5awJVla7zF8bWDuXnMB0S8=;
 b=cme9lOIQUTGhJtwdAuKAvp4L81jnHeRCdZVKMsco/O8y3edTMBaupxlWy/QuQSG0rw
 tFn1l+cwFWWAnoGSL0vcC0vbM8d6I04Hw3lilJG5JMlh5R6YddnI7GMaguXtReSrd2YZ
 atoKSUnNJa63xn/U+lT8S3kctH4hSWWYikNuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793030857; x=1793635657;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XRWtjXKSC5Xleaf044ett5awJVla7zF8bWDuXnMB0S8=;
 b=JCoVsOXPn982GHBj1ZJ+mjxosnJpv3pccnkN9Sqe/MRaB64OvjQfoHitcRK9/h0v0S
 CK/h9bySSQgkGnh3EtJnX59Dli8JA45dtdiIKEWI6/jZPjq3JDlEYoMXKhHKTfNR1RsA
 hfV0pV6ZhskB9LHR7XTJkbGHWOTsLbrbzWDMjpZvN4zWLekumHuCdOGvEycNV3xz872f
 IdlR7kXF3twQWJIHCwIBs1taP53R6nMEIGnPSEWRqwlzu/pDYkKtdjnb16X8tKkNqCae
 NSrdk8cop2ezkwvYKClbh5DKgvb1c+uDw5jWrOG2Y7D+d9DWIdZ6Cw2WCVksZZAAQ/3X
 GBIA==
X-Gm-Message-State: AFq9FYIVRqUxAT/sGhi1QwisySEvwSQ3L7xHcFUYxlKOJ/q1Tk+d6QEV
 qe5lf89jpWIor7GLmvBwq/sUWkKBv/aAGx+pOTodXmmksAyfAkj2LDDxPz3qWzQvghzObBh2lSY
 j5RX66ItlghAVPSrPxB2aXTRcQSxrSCGqrH8mqSL+
X-Gm-Gg: AYBFou1DgeKCGxMaqHnebuW2XDT4j4ZOZWW23dLgdl62fpXdw8E5Yk1BGAHg0o1nfxm
 TRDekI/+Sgi4nV1sH2BY9XFejk/zSqx2HCYsq8XIdigxFVofgkGA/zou56un00wJKsuyFBknjtB
 Ty0IqF5YNdXb1i7CQr5C8KulFMJvupVKLsOIXXiS6T7C9Cv23PgvOHVxqqJw5UWGVhy7UCOVqTD
 SPrV6VSWdQTou0hC5suefjOWIeWqucyaFZK3zhiPRH1LTsnTz97m0lFZ7JZFqVgcCieWuLPnoEn
 hgO5edwEz9nv7H888iNKmxopqFxLQEawUrPp4zBO1KW0FrrU1U/FpBjEamIpKYvmWCO7E3GNJqW
 2JuJ/Xav9RbpyvjZacov6C8gn1X0c+g01v5zInH+zr8v3AvmqBJBw7Wdl
X-Received: by 2002:a05:6402:1a35:b0:6ac:aec6:a3c5 with SMTP id
 4fb4d7f45d1cf-6b442ffc8f9mr5808197a12.42.1793030857035; Mon, 26 Oct 2026
 09:07:37 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:07:35 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:41:13 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-6-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
 <20261021-rinta-watchdog-gettimeout-v1-6-e7f3157b8bab@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:07:35 -0700
X-Gm-Features: AclHuK9EKozBjvF7oSYxRkJXmqptDbSYgGdn9A4XHvliWfbwV-KcoDhBFr4OzUQ
Message-ID: <CAFLszTg2Z6jS9BH09ZM5zaDsCB1j0MU6nO_Jb1eC=0wBamafXg@mail.gmail.com>
Subject: Re: [PATCH 6/7] watchdog: sandbox_wdt: add get_timeout operation
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Juuso,

On 2026-10-21T08:08:13, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: sandbox_wdt: add get_timeout operation
>
> Implement the get_timeout operation for the sandbox watchdog driver.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
>  drivers/watchdog/sandbox_wdt.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

> diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
> @@ -7,6 +7,18 @@
> +static int sandbox_wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
> +{
> +	struct sandbox_state *state = state_get_current();
> +
> +	if (!state->wdt.running)
> +		return -ENODATA;
> +
> +	*timeout_ms = state->wdt.counter;
> +
> +	return 0;
> +}
> +
>  static int sandbox_wdt_start(struct udevice *dev, u64 timeout, ulong flags)

Please can you move this after sandbox_wdt_expire_now() so the
functions follow the order of the ops struct.

This returns exactly the value that start() stored, so sandbox never
reports a timeout different from the one requested, which is the case
the series is for. The test in patch 7 therefore cannot reach the ',
requested %ds' path through wdt_get_timeout(); the clamping test only
covers it because the uclass clamps to max_timeout_ms first, and
passes with or without get_timeout(). It would be worth having the
emulated hardware adjust the value in sandbox_wdt_start(), e.g.
rounding up to a whole second or a power of two, or to fixed steps as
max6370 does. A test could then check that wdt_get_timeout() returns
the adjusted value and that the start message reports both values.
What do you think?

Regards,
Simon
