Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4EBC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC95E409F4;
	Tue, 28 Jul 2026 11:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgfuL-oxhsdb; Tue, 28 Jul 2026 11:38:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19680409DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238695;
	bh=UZjN8JOR95h0uQ2y5qw9Uy4umP2su94ptl3k4J7CD+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EQCT8S6UmjbjUW7dzN08g+91nZf4Emy0R/CrX9pmySuJ076xihDc5D+aSGJlsrP82
	 OHi2Mclmki+O/KZByDoeq+Wd8g65oQD3qvEbIwQBVeJRbW48t52kkihVolPMNjdlPc
	 ztghK762QdC9NFl3yj+4tPFw/c888fUReAW0YYI2CVnliZBSunxgOhbMWDGk3JFe18
	 FdJ/O/OGUtfpnsipH7vnkLnavimleaYVZkqvfHzF6UAExcVnllEHRwQhPuCZDPf9aF
	 Gy41l+0J1bygh9tPnY79o/6cL5xj/G8MjVbGjB8YgWDf1ZyPRLeyNPeZCBC09w+Fo+
	 Yo4Y86v16gJTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19680409DB;
	Tue, 28 Jul 2026 11:38:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 30A6445B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 169CB812A4
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CtoW0rLzZIwY for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:38:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BB94481217
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB94481217
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB94481217
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:38:12 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B7B58494B; Tue, 28 Jul 2026 13:38:11 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7283082991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:38:08 +0200 (CEST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so4936141a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238688; cv=none;
 d=google.com; s=arc-20260327;
 b=JSAhGmrXjCLfMNIXRwljmgD4/CtapIEmwfbe7o7wZOUGdAkLyE6bgBQNLmbt6WZlHo
 ZfG1AslJXSOUWMipliHsVbcqtyhJCfXxbyAoq4fAV4grRtzo1KO/kS0uKLSHiNwwFWu6
 SIareD76GtD2Ubir9gioMnaQ4y2nKMnvq50vTWM0ZdFm+ISnpyyQ6Oy/Nhxxkt4rLzrL
 7aQa7tUVt61ug63HlrKA1cshiYJd6hFluZDZIkjOnc5gGpGhEO/9u3YaTCNmfMvFQpbU
 CD18d3IcYlPw3kdcAPEzczb45t/kXnfp73TUH8FA9XjvIjUzSHIstHiM91nqR3a5jjCT
 ka6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UZjN8JOR95h0uQ2y5qw9Uy4umP2su94ptl3k4J7CD+o=;
 fh=runy5GsEaBbwYs4tLCkIDKGakFI3WhxP+HVdMM9V8MU=;
 b=I5CJjij57lh/XzW+AFVo1lrG++Q8JOcUqGaGtXN3108ROmNRQnFDXJ2MHTDRZSvUVP
 nxHxw3u26jMI8oU+jm8O9UZ2DdKva/OMSMPMOVy5Hxov0racBzbL6hu7n9d7epKwO9c7
 8aZ6DpfcRT1C2YNgwz4zpq7bXB6d1osckn/jMXRo3/E59LJPArGbwsygFLwZlcZV4B8f
 RRemhbECpMV6bCKXjP9/BglSQSuGBeq0vKER5G69YlvSzEM8qxEf63uHo8qmrCmcUIoo
 o/izcDY7NiKGXA2TkfuprcLLTc+fKWDdjl92SuL6UDyRTFBxkVtPGG32mi4EY5S0uvgF
 QFYg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238688; x=1785843488;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UZjN8JOR95h0uQ2y5qw9Uy4umP2su94ptl3k4J7CD+o=;
 b=KDQ14XTUu9iKKLWXdl72pE07j6Gse36gPUmsUFBXuEqfqr+Q2vxHvx6zfKgp13X+QF
 50uZfbKK9gRDAGZWvwB0ok17txl9nsobPxp9TFQIBRR3S7/SDPCpZlGT8vR1W/+A+TsX
 MEXiD5XT6W3fRwjnOcqHTuMZiJY1gHHy6OqgHbyqZkzTmlVw8D/8vz7TF5rigx7f0Usx
 MtTZKOeqcwhQV6C8PRwnOy2FXstaDq/vPnPg8nhNeWVnO8P+zElSFYwQFifpxcFwNc7G
 jaMw/iJVEhNKMRtmtECB9EnM4ciC03Ahr/bBfMfAOf54r7N3tF6cmbQBk2KdZtJnPqrF
 VSmg==
X-Gm-Message-State: AOJu0YxMityzo6tZG6sHQLnXZodHCc+oROa+evi185dWFV/HemyKXrsD
 Kpy4iM7CqamnJXjNlANr2DfNxXaumis1N5Xn6KsOt3OeO9zPHgeFUtS5J0Fu3lbEjBnUrHlFhoS
 CqEM01qyNDvJue4wtGwuAj8kjGvfxdsQ11NZuahqM
X-Gm-Gg: AR+sD131yK4L7Zx6GxztLpK75bePXyVy3uxYerYWhCnHCIOWvSAZB64ylI9yE+0ZMJu
 l+sEnpe5Joy1TNHSuGcbwCdoma7wDt/4VmPIUMCwTYzYWePqWWMC2n40QS6MauG4+wfZED6fwhO
 RtHNrNMDVJd23rjI98p0rk+Gsi+HpKGkqssC2Ecgs7ccfav60pw980C2j5327VkLDp8OT7RZMCq
 lF3F1HERa19dx9aWWsGGxZkpWsHqFHNpSbr49lSRF/T2caOx55H0i+ixkB7
X-Received: by 2002:a05:6402:e88:b0:69a:a9c1:c340 with SMTP id
 4fb4d7f45d1cf-6a034a737ddmr1054890a12.32.1785238687933; Tue, 28 Jul 2026
 04:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260716223401.378989-1-dmukhin@ford.com>
 <20260716223401.378989-7-dmukhin@ford.com>
In-Reply-To: <20260716223401.378989-7-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:37:53 -0600
X-Gm-Features: AUfX_mzUrE23qU-Gi2QCOMf5omm6FzybudNZFukckuBJHERBgU4dPekUYKzzMcQ
Message-ID: <CAFLszTgkiBLOM5tWqMK-K1S885bjTP3Sm_LFsj8ruEsmJRf_Bw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] docs: nvme: Update QEMU command for testing
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, seanga2@gmail.com, 
 sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238688; x=1785843488; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UZjN8JOR95h0uQ2y5qw9Uy4umP2su94ptl3k4J7CD+o=;
 b=Fz3rxLBePQFIcv4moH6BHcZ9GI9RLzQS3ufB5CXkOrnd27xhkKaPoB7RWphbRY6zlQ
 9b1EUCm7K+No+k2DzpPDcotJ/CsXUgPrm74pD2uBo2ZvzEVFt8kXnnR/BTm4o78lxfbJ
 m6xBToSlCiJn1dGq7UomrJo+4cT4UVkz19QX4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Fz3rxLBe
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fz3rxLBe";
 dkim-atps=neutral
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

On 2026-07-16T22:33:54, None <dmukhin@ford.com> wrote:
> docs: nvme: Update QEMU command for testing
>
> Switch to x86-64 QEMU machine for NVMe testing in the docs.
> Add `format=raw` for empty NVMe disks QEMU command line.
>
> Also, add -nographic for terminal based QEMU start.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> doc/develop/driver-model/nvme.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
