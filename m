Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4BFE8536A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0D984129;
	Fri,  3 Apr 2026 15:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X+vt519Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59D5840AB; Fri,  3 Apr 2026 15:22:35 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD8D84154
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 15:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66bf6aa4858so3416830a12.2
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 06:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222553; cv=none;
 d=google.com; s=arc-20240605;
 b=N2KDBYL6sFhNR4Odn6xW22XwFIjj8iQk0Xb3FIf18733RJNx7H+AE3x6DvWF0jcoJC
 O3JyG/9YAH8xrt/rRviV2fncxYxAPcrPfd5edkv6IUSunuIrStb/KPlq2MwHAk5sOJ1c
 dgDSJcDWvWFrJ9gnAjBXmNEwKytmEYbqsmRWC21YWtntLzrt4W1FMk4HC48SwCVUpKcS
 30g0We4Uqjma4cEoDgn3B0jC0dL0ElCFl+BLDVusm30T+ZTopbv59iwVDN9q+I5svIoG
 6rFoZFnzzWWYOx8hv/3D+YDWjgjjU9Z826rNuzlNiH/Rp1fvr3attFHEDs1Ac25PXt2v
 2FSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fkmvoH5SZ65OWModzTaLABB08kPjoSeSnGE9FxhVEHU=;
 fh=/TVO6FbF4O18NfbcdZKcO54HkyGWIpFzJvmjXOOBnv0=;
 b=U4ktFksWwg8FmlJtTfIBK0FJ3hFdmdPqByXpguPV9kJmcTCGPxTxI0otqgd6YfpWbs
 caMvPDG5Y2ZzBP6CCG5sXK8Uojha+ynPQ1aUw0ceX7vyB4BM6prSaSFXhQn7g5FwZxjM
 F/UhiJvkpBkeu3TZfixzfjRaTCDxFxU5xC0B+GW/h1I6H4h1HQDtqOzBsvGO9/eu1Uzu
 g/vLEFUg8CItXEToSS0NVnHJylzOu130E0Vb0xiABVdyHAZmaHXL5zUbpV0Djz7yR+1r
 Op1U2kTH3aY0OLndeZGUEtIHagYAh2szyUFhUQ0ckUnlLHhZanNMvLb/PYQANm1OAe1c
 3WdQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775222553; x=1775827353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fkmvoH5SZ65OWModzTaLABB08kPjoSeSnGE9FxhVEHU=;
 b=X+vt519YRWiPRAULShXctNs/fU95OI/SOWbWl9domRmM94N+975KiIoNO4LrdIkltr
 lCNc15OiSop0kEJ2s6S/ySmvfyVfBskpitrtb7Cuipxwz61OmrUio1kMjfSFx/kvlmya
 YBEy6FrsUSw1bWS55m1GaVM8DVVJTOGyz76YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775222553; x=1775827353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkmvoH5SZ65OWModzTaLABB08kPjoSeSnGE9FxhVEHU=;
 b=hPqHDgTHhnQ729hHi+3IhTWvGRgLrBfD3um8VbLgo26iOrox7xlQb0S7b3XywIGloE
 XaeP9qW85NCwCyyAfoQVjUu7CqqhohaqILG3bGFn3qBu82jOn5misj0pOqCjXeWad6e2
 4nxb8D1Vpq5Qb9903ErjF6z7iczS7BxQtkQH6eYF+d1uFgj7mGkdE7eDrWJ+x5zizTGD
 NR9pfI2tDYvFErXdj8eBLdYwqdCfKSaOpSO5yN/xvSjI5isLoHLVcEs3hPCEOolK0Wu+
 13I1YLQkHFS2KtxJJY0p911ZWOiIEYZnPt+rUhXd/F9WC8GytdnyH1TuKx75LA6Z2F2V
 EMUw==
X-Gm-Message-State: AOJu0Yx2J0N9SSUy5OZx0hcOtNvUWYKuBpRAZsxVEGCJJtTOcookWgcu
 DG2SiirbhrLHKOPmnmeXt/u/sOrNAXrDa6Yix/xdj3HqB4RBSoO0YhstfF6PgnU/ubv3QgvCGju
 Q4xdP5MFrITyO6t843jzYRCJXQr+8jVOrjsPkXL3V
X-Gm-Gg: AeBDiet2QVdjjvCyleNViBCS+abcSVhkZ11Cx79SJKLrNFeIWVa67vT5wjOgW8D3g6U
 LU+gjy4w2gK9gnJuNk1unx2V3OTaBVvcodiI2c9fp4sUQC4Fwddt4BSGoBeqQDu827/KiAxl7V6
 ZFhavXYJyQUZie7AJ3Nwk6vlJSZX6pVglUmqonD7+svN4EcUNmwZ1+C2CbB7BRTGKuzWyDZcJJX
 81bzreqHQ3p3mfBTcwMu7YDFHF5o/hu60crl0CLwEzeRJYwzShE2eYMoaV9JNWoE6Om1m9ZAQ5M
 tCts1w==
X-Received: by 2002:a17:907:8b93:b0:b9c:ed9:50c8 with SMTP id
 a640c23a62f3a-b9c67979c9cmr142979166b.26.1775222553327; Fri, 03 Apr 2026
 06:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260401124128.178799-2-gregor.herburger@linutronix.de>
 <20260401124128.178799-3-gregor.herburger@linutronix.de>
 <CAFLszTg_LiyHPYhQh+MTV5skuY0ORrPotOFQWkQSQvsBzjHTYw@mail.gmail.com>
 <ac4jcb5rmFG3qDz-@gregor-framework>
In-Reply-To: <ac4jcb5rmFG3qDz-@gregor-framework>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 07:22:11 -0600
X-Gm-Features: AQROBzCSXbH3XIdZGWEgErOTb4opvf-pf8XEWlDOk2w78EOhNPj0iCaY5UDxhHI
Message-ID: <CAFLszTj25te2hEy6vCW5k5GjGayFLYeXF2niB52TWGUvHFpgfA@mail.gmail.com>
Subject: Re: [v2,2/2] cli: flush stdin before enabling cli
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
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

Hi Gregor,

On Thu, 2 Apr 2026 at 02:06, Gregor Herburger
<gregor.herburger@linutronix.de> wrote:
>
> Hi Simon,
> > Just to check, does this option also need 'depends on !SANDBOX' like
> > AUTOBOOT_FLUSH_STDIN does? That option notes that flushing stdin
> > breaks autoboot unit tests. I suspect the CLI entry path might not be
> > exercised by those tests, but it would be good to confirm.
>
> I now tested a bit with the sandbox and I couldn't find any issues. I
> ran some unit tests with/without this patch series and with
> CMDLINE_FLUSH_STDIN enabled/disabled and couldn't find any issues. I
> also ran `u-boot -c bdinfo` which seems to be executed after the
> cli_init and therefore after the flush but I could't see any issues
> here.
>
> But this is the first time for me using the sandbox so I don't know what
> I could test further. If anybody has an idea what tests could be run let
> me know. Otherwise I will send a v3 with an updated help text.

OK that's good, thanks.

Regards,
Simon
