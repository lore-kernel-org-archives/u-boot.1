Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05818C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5499C4064F;
	Sat,  8 Aug 2026 17:49:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INZiFwycaKxf; Sat,  8 Aug 2026 17:49:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24E42405FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786211349;
	bh=8M3K8/j0kRI0M4/OXV7de4vmClucGbePCe+F9iFJKus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WGa2cBxWQwIB+TKbdIaXXt6oYNzClGnrA3PJEcYi6smBB491aD+slOgloBgbelP4M
	 52gU1rvzcLgIrVE4DKrhTBZqWJRh7wU6W7QVN19Q4RT+7P4F0klPHxqlHyqdfyMhAb
	 U65G8sjZWEiO/2mbLkEguK4zAyGVIyjlbtci8gargM83l5n4VYw2ds5BVKwGRur20m
	 cAbRDrSTZ64fUeyz9VZH2pYQoyhnpSFytKJYnoGatIHQqrViAebRHg8pphfL6qFYxs
	 w8fw4wQ60S8YL02VSp0Qu9vXUqlLoD9/G66x7Nm4KgIdI7iSXG7n6wAvwGjkHeLej2
	 N0imIwWnqOx/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24E42405FF;
	Sat,  8 Aug 2026 17:49:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A446296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77D70405FF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3uoTjmIlt8yf for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:49:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9AB6D405CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9AB6D405CC
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9AB6D405CC
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:49:06 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so819826a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786211345; cv=none;
 d=google.com; s=arc-20260327;
 b=jawEpCKOn9u1z3T/9R4vkLHQjWq8P1JaKdohDBpJbZ4fVZurTgAWLwT/3/3azt/kJD
 nXmzViRBsggWQq8UxULkGYm7m5OpxQ+pa6NvEGawocFXdVotUWlrHxCVG/xsAGmw+lZ6
 IxN7qx3m5QGL9zENQXfStByaNvVmE8jp8Fkbc8XF4GC/7lgtixlue+7QIfc5GpUkQr3N
 XHN7ulYU0VfaXekGAcsMZxPB0fhpkW9VouLmelRQHIaqVzaMJCXgeYrlTaf7wdCGX/Dy
 85FKG9Z6EKFewcrUdsNOgYfZkgllZaPIns7vWtk0nv6HiK1v61ATmm384D6moIsfcv6Z
 869Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8M3K8/j0kRI0M4/OXV7de4vmClucGbePCe+F9iFJKus=;
 fh=qpl1R5oyLDHrYwZo56n7zf1ddBj2+zYDxUllAj6kB/g=;
 b=RWTNMPwQSAILXHHKwRDGZ80uOF27NVWM10rqHxpZ3vogujWOZ9ud7Bil0X7Sq4EzCi
 /DCxTn0GefrKJ4kxFehjyg38RPg4zevGju+uPi6pSYxoLEAcVbIPWG/4ncb1XZ+Izrm0
 N8hx5ZGkUsADYsUSPC41VxzQTyvV6Z4Rruzkvg0aWhu19TDHpmy5x5zzSehmK6ABflCr
 YQeejzj2CwCOwQ3Em0/73+saSpuFICs5D8sj5g91DWe550EcV6qfpZsA2TfToe3ZGvvg
 k3Ps8rVn/RdjM8RPao9rDTfWy5ReKMhNj9T0FOKdwLGrlRDEOqXuZrsLgQjdvGUotS9K
 0mSw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786211345; x=1786816145;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8M3K8/j0kRI0M4/OXV7de4vmClucGbePCe+F9iFJKus=;
 b=d/oD+EHj4XutxK1QCxqq+GFFBmcOk16T8y2wR9y+MhuHByWkww1o2wH8XaEzDMp1D/
 0J74JGqEIQ9ph+PFe2J2aAolgqx+rCE5inNj4QRn/Wjl/XfkgZ6DYp2uQZ4FLx6CrfjF
 ikqQa7RJjsotlSjQjiUk77MaiIQf6mrC5r1OZgBByKAgV4gBA8fl3RWn7415RJFHrb8e
 EUpluhT3uDLCDPI/qCXlwJ2yY9rhZThV14dSOdpLcqQaR9UZH45WtrKiM7xKteekuuvi
 L/Q8eUm+yjksZPYYWnA/QMNArIAMbJD08JAWJsbbIi/MzZSPQVTEgulTuYYCg4Bk2wnD
 OqNQ==
X-Gm-Message-State: AOJu0YxwPjVIPOeCtzWxy91IQETh489A+ghIlFISQ3aoLasUaEJ3qQvG
 IrlN8rBWLooyZQRE1HTElNxLKVyTP4kOZoYAwnZIShqZUhrv7ardbPDa7b/FGvMHXatJxUCucLB
 bNYtoN1PZTYkoClkGK3ZBjCcIG70JR2Aj6Ao2xpb2dSiPQnwTeV4=
X-Gm-Gg: AR+sD13Xa45AkTtUO7w1Dm659k0LrdNeh5ZoWgnXUKWHbxyyqN7opkk48+8/9OwMZzm
 1vH3VkCOzqf7rqXbuSyt8ecSwC9Mv/dTJRYukvcrEdq7x309yI/LkFClMpUlkQip2Rf5NmQgwQ7
 fCB8wcKindFaJVLVN32LsNBEEdIiLax3FA2Lfkn073JY9Smnii+DFdWYLO+plFlomGsmFO8UJVn
 VTD95mTgRMEHPmFDwwdkAmHI0eEq2b2fauVSrbWwk46CEwBEHIbG8yugzo/huH4UnYEVAX+KeKf
 L85DjmdhixxWDGNRoG0JtJocwI6vqba8Bossv1IE9EMqjcjVcJQzEAQ=
X-Received: by 2002:a05:6402:21d8:b0:6a1:e59c:62bd with SMTP id
 4fb4d7f45d1cf-6a1e59c6678mr5503022a12.3.1786211344683; Sat, 08 Aug 2026
 10:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260729082350.2276234-2-dmukhin@ford.com>
In-Reply-To: <20260729082350.2276234-2-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:48:50 -0600
X-Gm-Features: AUfX_mwxIpCP6vtXzXMYdMvOFi-bPgXZ9jAl3ECQxECGNygF1oyPXeeYVuva_ks
Message-ID: <CAFLszTgPDptKG0Xi4+ESA5zweMW-5fxv1B=bFnCM4zziQC4n=g@mail.gmail.com>
Subject: Re: [PATCH] pytest: fix out of bounds access to bad_pattern_ids
To: dmukhin@ford.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786211345; x=1786816145;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8M3K8/j0kRI0M4/OXV7de4vmClucGbePCe+F9iFJKus=;
 b=e7BGUBCKR4A8Fy8TmFmTlPP2UJ7xMqdL0sGaykl9/rS/3oxmONkdx5YatkIQZ5rwaL
 aqIAff68t/QSYHckfwdFueEkn1LvABS7rvrMPNSUJcnQ1PwPz4NK19CeJYPU7Zhad29/
 4sIeBrqhih2ue1Le3G1ZgXJM05Ri19dESg/2k=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=e7BGUBCK
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

Hi Denis,

On 2026-07-29T08:23:51, NG, BOON KHAI via U-Boot
<u-boot@lists.u-boot-project.org> wrote:
> pytest: fix out of bounds access to bad_pattern_ids

Subject is fine, but please sharpen the body: with pattern_lab_mode at
index 1, every bad-pattern index is off by one, so the wrong id is
reported and a match on the final bad pattern indexes past the end of
bad_pattern_ids.

>
> Current logic in ConsoleBase() mislabels every bad pattern and walks
> pattern past the end when the last one matches.
>
> Ensure out of bound access to bad_pattern_ids is handled correctly
> while processing test console output.
>
> Fixes: 8308a5eed6e6 ("test: Introduce lab mode")
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> test/py/console_base.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

> diff --git a/test/py/console_base.py b/test/py/console_base.py
> @@ -212,24 +212,24 @@ class ConsoleBase(object):
> -                    m = self.p.expect([pattern_u_boot_spl_signon,
> -                                       pattern_lab_mode] + self.bad_patterns)
> +                    extra_patterns = [pattern_u_boot_spl_signon, pattern_lab_mode]
> +                    m = self.p.expect(extra_patterns + self.bad_patterns)
>                      if m == 1:
>                          self.set_lab_mode()
>                          break
>                      elif m != 0:
>                          raise BootFail('Bad pattern found on SPL console: ' +
> -                                       self.bad_pattern_ids[m - 1])
> +                                       self.bad_pattern_ids[m - len(extra_patterns)])

The fix is correct. Please hoist the length into a local so the offset
arithmetic reads more clearly, e.g.:

    extra_patterns = [pattern_u_boot_spl_signon, pattern_lab_mode]
    base = len(extra_patterns)
    m = self.p.expect(extra_patterns + self.bad_patterns)
    ...
    raise BootFail('Bad pattern found on SPL console: ' +
                   self.bad_pattern_ids[m - base])

Same for the main-signon block below. What do you think?

BTW while you are here, please double-check the other
bad_pattern_ids[m - 1] sites in this file - the pattern is only
correct where exactly one non-bad pattern precedes self.bad_patterns.

Regards,
Simon
