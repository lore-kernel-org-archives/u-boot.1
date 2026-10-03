Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A457CCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 14:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 647BB60675;
	Sat,  3 Oct 2026 14:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ui9dpugq6MIg; Sat,  3 Oct 2026 14:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B228C6067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791038133;
	b=Au0IzT9klm/07/5UH1bNLag5AdO8h7g7+bVRjMTOs1UNrlPynnrbLm983tcDr1Cuw4QJ
	 lOs5PvhtzTBYbdEsJel5BXtDSH31pJAepcYGjxSRdsj8tOKhJBww/ZR9C2uYn7TTNTkCk
	 GqyzhmUOorywW6o3cncGnmZLtRlLX/ZfT+b7cXHJysigXe31lg/m7NGReOkkVUSgFGkWb
	 lcMywr+99BMzgE5AZ0BtRXFWMk/OkVckYQHaKLwMB/apTOu4VSTTFbJJsBg/5CbE+FYu0
	 fIXEp6db/1Is1ACz7WMVWJqjqlTZXBcvV/FkAaEcKiG3HarBNSUfcL5Ct35iRm+JD4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791038133;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GRMm9VcRxXm8PNzZZ2aNE+pYh+aVGCpzR8eF8cVWBRs=;
	b=QgI9A8wtJ1IJ/fBbTGasLJXGpJ0rm6aA4Elc3MLgoZU9n0Npbv34uipwpnbo6URBjbbZ
	 yfMKTbQyFqF8d5O3WpYOcjnna8mVPESLLHoHiZXZ7oZ38+nkYc0yjOuEWaz0bjlZ/aH9e
	 EKY+7RcDcErSRSybzfNmfsMcHCKt+4cPLM8RqOBq+F1/6L2zwHSTD7sJNYWEl2fcJC82H
	 HiRpVxksz2XzHxbbU7twkd5/NPm3miGqNYOQnD54IJF2pK09pvY5GbcButrEj8vQp/36t
	 F2IhG3LH/ux6CiojAkx9YeCcFgxNmS1pWbrfzNcj93WYQv4B8fiZddaj/xZ1lyqfkBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=eFpKGvJl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791038133;
	bh=GRMm9VcRxXm8PNzZZ2aNE+pYh+aVGCpzR8eF8cVWBRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oYuthEcAodHQFbGThBNGkdbzAfe5N3219J+76wpjz3dB4fsX9Hjm94uWRhPbm5WII
	 i/tZvA7HyFh+qgYc0ZzZsc9hj/xyRy6dtqWsh4rDBBfPO/V4QT7xkMTVWy97FxWv1g
	 5rQB6r0q0+5wuJ1eKiLOG4vKZZ+y57A7D7kYQjP8BrC7wzhcShnnS2NVuqQBwsL9pe
	 7I/m+8cX9/463vrPqF343O/8/vvNcuRoPMPzK9ql/Ay0RoozTyLISN6OyIrFoURPtZ
	 bpycEp3HCHHqbpJ6EwHyMD9I2TyfHAjjUlw7TqJg8uA307bZJdGVjZUK2CZCXqFshY
	 2ieaEw3vWbQ/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B228C6067D;
	Sat,  3 Oct 2026 14:35:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A05341A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91E466067D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bFYHmimbe50m for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:35:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B741260675
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791038131;
 b=DLLUQFFw2tLik3YJtNIv213wHUz5maB6jvzLAuarsMT5qJ6Cn4zkV5+XeNFfm4tqwY/F
 qa6HpAPo2pDmWmGag2dj7Jtfc/8gh7Qr6x79pqrN4XnZSzYEoy8PJCMftwcp7fWCCvWFU
 is9U177K1sqJe+Q/hjTI0jZufSZdJk/MGA4FkM49gJW3DP8WQWkXgL5LKt6VZH3QOAPrH
 hZ+/7JdCqCGLx4tjnV8DwarmSepgMMmh+gRPjgqwAIUwDfdr9KvXK2s2TI8YeL2fkIKk+
 ZG2FpSO/TfvtE3SLsnKuUMbdgRcwb9Q4MG2Cns1+TI4/rWE/vDWW3uFTL6geeSVRDnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791038131;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=GRMm9VcRxXm8PNzZZ2aNE+pYh+aVGCpzR8eF8cVWBRs=;
 b=aTGCEFgccu5o5f2TBHPjE8kbLsEQfRyK4xLhI1hrx4/2HVYExV818CG+XYGrk6p13Jva
 JGkcarnnCXkLdDV8jSnwMhBS+swDYU4uIsnatlqAkPQ5690R31JlRM0B0jablKw0nUAyA
 5wMv1s1ytbtDzrvFxkSUejpvdy5d6POLWd6EFnn+CxWeEo1cws9tnVZ1/BEm6OClEsIHw
 lwEd78XIeFwNiwLvrVgM9DA3aU2O6PWkSDT5Q68F3F3e5tWsl4Fu1XJDPpmNt+jfVfJEG
 0N6T9bEwdDmmL+nOxKMWeLjBfnWisYMvb01fT8XnczblgKqRIwJ8flsdIn3/+7c+iZA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=eFpKGvJl; 
 arc=none smtp.remote-ip=185.136.64.226
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-664519-20261003143525ae5e38f96200020782-yl2sov@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=eFpKGvJl
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B741260675
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:35:28 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20261003143525ae5e38f96200020782
 for <u-boot@lists.u-boot-project.org>;
 Sat, 03 Oct 2026 16:35:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GRMm9VcRxXm8PNzZZ2aNE+pYh+aVGCpzR8eF8cVWBRs=;
 b=eFpKGvJlfx8Z205tDAkbU0NePoADarUN5Y0cfN28zEVxV8j3HiM4Jr5aQMVgHKH7OEigKa
 HGeSkFgLD51Px10Lh+dO9i7TfCXTbA7QOQwxGt9WS8X0fNU7ZsGwpJV+1RyFJf4+nIoR17D4
 J+74qDFr2pkbpEpUR+Q/cvSdoytdxgMxBCm5dKC2Cx6beNQW931lu5G4hrCp4bFS0BuJs1Ep
 33HTR03SlRS62Xo7wESOBQhdeskTMXmTCr5d30xqt+BwwwublEI74S+MXQoZT+oPa+OoURoj
 y/miOrVIxfdhYfNBUzg/1u9YXxeHCVZm5CKtj6nyFE3Cgj9y0NCxFiWQ==;
From: Michael Haener <michael.haener@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
Date: Sat,  3 Oct 2026 16:35:24 +0200
Message-Id: <20261003143524.71665-1-michael.haener@siemens.com>
In-Reply-To: <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
References: <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

Hi Ilias,

On Thu, 1 Oct 2026 at 11:41, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Any reason why we can't add this directly to the uclass probe instead?
> According to our docs, the probe is supposed to 'make a device ready
> for use'.

I tried that, but there are two problems:

1. On a plain booti/bootm nothing probes the TPM, so post_probe() never
   runs. Something still has to probe it during init, which is what the
   event handler does.

2. It changes probe behaviour for every caller. Once post_probe() has
   started the chip, tpm_init() returns -EBUSY. With that change, five
   existing sandbox tests in test/dm/tpm.c fail.

The existing users (tpm command, efi_tcg2, tpm_tcg2) already call
tpm_auto_start() when they need it. Since a full self-test adds boot
time, I would prefer to keep this opt-in and explicit.

Following Simon's suggestion, I have moved the handler to lib/ for v2.
Are you OK with that direction?

Regards,
Michael
