Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C2CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 17:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21813841C2;
	Mon,  8 Jun 2026 19:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eGng6QGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41C18466E; Mon,  8 Jun 2026 19:13:25 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F7548405A
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 19:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6919f40a0c8so3279800a12.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 10:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780938803; cv=none;
 d=google.com; s=arc-20240605;
 b=As1qeCnk2CIHlggp4lZPL9GsVFVPsYOcV4oOpZDvHhFzd6wthKudexFeQhCpOjuN1T
 /qB8KlR+chN1si9Z/4l9MVcjHzxzqOEvhD8YCORUMtXrAVLzANLzv71AebhQlO88sk4M
 u3C9pfQb5brcTVMYu1UJz3zusRnct7cm147/UR6MR2Hxu8aAXcpc1LsoDCJBGyVnwlF5
 j9G7lVBw6iD/ZYK0CBTYzqjYn7OtskHyZA2wAoveu5DBXQ0H/e9uvuSDtmLABQNA9Zrs
 v2xvTG45buz5UU8tmmOWkYbEJ5Kbwj1Z3o3+I8S2t8wg+PU1nzARCxBOSVY+MS800GhH
 1AHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=r8XN6XlupxQqkgZHRRmH47UtLcnf6BxD5l5ZgqK68v4=;
 fh=pKnws8VhcMhWHU1cVLDlbwyYZQdtlg37mkY6X1v3Elo=;
 b=Q7R92qDGJlkQNTTWQh6UK/qeAfs05TTnypOtcv0aXOOJwRae+wXkDXhGauYCX45LT/
 WcudWWGHhKMTHxVUmP6tvxCePYKTQH7kAq+qQZhBkHqtZULzBi44LZFdRz6Bzwz+avRm
 Y2+uecoujuNSBEkoMVprIobANely2vB5hVwAMfY/Kqp+0PB+9JgQp90FRx+HLP77i61O
 3v8pSDpAKmGcxz5quMi3/YBJhY9L1jIqcQkkzG2IgzPDpsO4qXvwvymPPqI2fOxxr2U3
 tm6MemxPc1otFrKO/2t/DmLkTWKPzlSekPB1LE0LJ7aVEuQvg/A5YtVMqJbAFzLLmps9
 5sQA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780938803; x=1781543603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=r8XN6XlupxQqkgZHRRmH47UtLcnf6BxD5l5ZgqK68v4=;
 b=eGng6QGKG2U2xAu/dq1HJhZIhxCAO7KMX18Qh5ILxWd7GXxLlNCHifzNjhy5SIWmfu
 rUW7MKC8KlRqAUOOUdkZBwEkOUr+n9/SqFulw7HzJMZeZOXw6csfhRElHkGZljQUdWUy
 VjZ4RzWMt4cpwUPopPHMWsklSpFVUoCGbqn+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780938803; x=1781543603;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r8XN6XlupxQqkgZHRRmH47UtLcnf6BxD5l5ZgqK68v4=;
 b=lUDbbOrKFGnRA5GoVw0z4bLsqd5Rrkv9haBGkBdKYfACiFwXWOD0Cx0J5tUxCkDaPr
 faBWO3VUqccZ/0pnRwqEy6yFqlSUZJcRSVgp2CD3+ec5+qZOiqtO7CzBHmZ0TnEOVGpV
 axhj+P7HVWPV6R2ANzTeT1gU1IRNiriOPjDFFa5klYNayQxbLkIGBZEV/XKdqYDal0ZM
 0YiTo8du7WHjrTL4BQIT3GNKzRSlp8mMqJqdNQ+zyEjx5m+i380RpSbMfFbjlKeT6CLX
 SucMZ5JbK4omaEO/zuW7irAdiFkng4WaE2FAE5BrlY4Iem3i5Plf7C/BtbsEAiDbg6Nj
 XtjQ==
X-Gm-Message-State: AOJu0YzmTVobFQIlf5grXuxhgQD7mvvfMVmuBQFr/u1Gt4FhrKNYqZDv
 boyDPdui03BHgLEo8291TCOKIBBv4LH520bQCRqYvWaW4Qirw0nymQI+3FsGf3Z7JAfgsn+w/HN
 JfGIwCDja0M5oGrRy0yCflhJuinzRcytg3eNJO80TGiINyqsmUHLBrQ==
X-Gm-Gg: Acq92OF3Z0lbsF5dGqCMl7Dj4CxaLxA+MgyLMZQ0LZYFOpYRmCO8kjd3J2LtFgpO3Ra
 0/RUpXPfYYNieaT8DNahlQorBJ+CUK4ORGD1yYdChuzZmLdYJVz5Vo/4fjQ4mdP6uZrnYPS7kut
 HttZmk9pzP6br7okiD3F5gZXAmb0TrsER2H+leMBx61CrOfXvWJY+u2kgZ4QC3mLsvIUYYUIAVp
 EqGaGT2u9vMAkah9W23mPeWegBFwVKXt5TQNJo7pTYDNWQoKPfiGQpVe2mV8CnLp/AuRRXUBGMO
 utttdljXUrE2u46m
X-Received: by 2002:a05:6402:3217:b0:691:5f30:37ed with SMTP id
 4fb4d7f45d1cf-6915f303a57mr5209330a12.23.1780938802998; Mon, 08 Jun 2026
 10:13:22 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 11:13:09 -0600
X-Gm-Features: AVVi8Cejel_8lC7P3uucSVrAs2iv5Z281OWOm4MTM7dr2uH1mQYWLWcBBZDLQnQ
Message-ID: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
Subject: Binman with Qualcomm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>
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

Hi,

I want to start a new thread to work through the issues which result
in later versions of [1] moving to custom build rules instead of
Binman.

From what I understand there are some things unique to Qualcomm here,
as well as some general comments [2]

Let's first get a list of the problems and then we can look at
possible solutions.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250722-b4-qcom-tooling-improvements-v5-2-df143f1247fc@linaro.org/
[2] https://patchwork.ozlabs.org/project/uboot/cover/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org/
