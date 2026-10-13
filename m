Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71051CC6B19
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 20:19:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36FBB60681;
	Tue, 13 Oct 2026 20:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKneSPpKeAIl; Tue, 13 Oct 2026 20:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A5A9607EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791922791;
	b=AColFjYmP8wOT+E0lcVl3pFjBuxSbOSBDYIFOsfq7zl+Kv+YXb4DFrxtVnhr8dC2Zzq9
	 iWMBKiNDjjTbfnnqoKSiuwaeksW22Lgf1VlzCCI+1wxUlUCRuytsilMQbQnF20/bFGw7Z
	 BmEEj7mIppE/e5w6v6DwfjdE1J4IgCtNhXrfTid/+CBGz/HEAThbyfB49cnAtCZp6iEEK
	 IMHQEyIbqd1ZH/cHcxiUidUahu8wqeQTH7rldc6o1EAzPx4IUwmptZes7VJHAJySruJG7
	 +J/0vOBnAhCCSb4tAJT4o59stRM43/WnlXtulSZ84W2pmpVdPhXVmmiyy6I6P0gO/EQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791922791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6+a9vYH40MOMEpLwr+Fo/d1C7Ymb9H7pVIrIaRMwJVc=;
	b=dBNS2HR/elag55Mza/Ce0RuRPn7JXUoqP9tw+TWJFObMeL4sb5CWAL5YslsM/BcCXQgF
	 7V4K3hUnokO2gzb39GHuj/yN9yfKSm1sXTrSAjsGvCx67mEFy9YJ8c2Pa5O4YF9huqtzA
	 92gl3P8xMm791Vip2n+/k6p3RyZDTxSILmpI9pRirXTAj8i2Gck9YpwRFWCoqrweIT4Ez
	 cJBPV7ZaX7ufExEvhUlN+ZlPNAKRytwN4ad0K3CwmNgMKdb/rj808/EiX07wficf9TvQA
	 LNRdOr+tThjk0EQrq7n4n/+ahqnsrysVhm8/zUw5Dxld2Fi4TpiUmCgWKf9sI3GN8Ug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791922791;
	bh=6+a9vYH40MOMEpLwr+Fo/d1C7Ymb9H7pVIrIaRMwJVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMWCe46znGBzuZRPZruw1ebLkC2TL4laDKHsovsrGM5oi/hHW04/FpD1J9/bGiDt0
	 k+Ueq+rJdu8WgXMbgAkzitdmKck/HRR39kNhm9IjQmfWce1eDuRCMTPiv4V4a0eXXb
	 Ebfb15KBG3XjHVmcLene+BzRHO7OpiA5CmJHUfzpzdJFrP8mUs7KvYwHzppua3+8ur
	 eiXy7GIULeT6OPpe4htWENguiTh7TBi8IGS1X9fwJ64lK3/A6XcnkU8gD9jQ7xvafh
	 hMOP1ruDfIEim8PoDz5ZFf4C8Tynxfhp3oV05Ec784CkEBhAvCYA3HQuiLacL09XQV
	 Fs3YQUGl8K/qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A5A9607EF;
	Tue, 13 Oct 2026 20:19:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BED2255
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41C1D40647
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPiI9pCO5r84 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 20:19:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D77C4068C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791922786;
 b=tJa/1odnf/JdMXMCMD8QDd74CHfSSfJMz4pgEp1jFcCiawDInmnE516zCUIZdtxLkFPx
 jC/TmAo9/SpmnI535wyE2GN/77kW4eoJNh/vSSxOvILTiw8h3pBmQ8yf9LDZ4eDSVfJuC
 WjRcpxp/P6TOlHKObBgbxYujUqW4ZyfdDg0ALLyoGRI1qdVZUGiCkIVWxrZmljhoRwOYD
 V35olND5RLS6S/u7COnXSXYwzsUiqhJmYd4o/fnsTkWovJ2rdBmSPLUsdATeto22VrmPE
 C4wrf4+yFY6RrJdp+XMhqwI1Jv0hrMoSw1NzwWCcjO8Liy+TnWP1Qe0puveLeeM3ddQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791922786;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=6+a9vYH40MOMEpLwr+Fo/d1C7Ymb9H7pVIrIaRMwJVc=;
 b=c313TNu2XajQROFflA0fx7+omq/UJLIMF/PtcixKMo9A9+/BC7XXYUScPEjyp0Bc6X6t
 MORyknC41nFMty1LWxvqSSAU2jnvN8v5plR2GbrauqP7HjYXrcbmBjhnzSgWsZrKlSR8Z
 prDOD6VJxddwgzR8R647NrlbFP3xTub5K6/7JLLY7iq0mAO/gv5eYErWGcq2+ECXEJDhj
 G+fy6CQJlkYwlJ4KwtLxmmzKuCqr6fIX9DRY6A7h03jKwBpBi3I/4lCGdyqCOwpFgWjn1
 6U4msabpMdjOsHZ/tcKleU9fHr5IIDcuHI+MPju1ejvVUG3wgeZOJ+lpiQm0+N5tL0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YkK8qaSh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YkK8qaSh
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D77C4068C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 20:19:45 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4c5d8c7f326so1202322b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791922785; x=1792527585;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6+a9vYH40MOMEpLwr+Fo/d1C7Ymb9H7pVIrIaRMwJVc=;
 b=YkK8qaShIasBoGynaeeB4KWtBywr42xliFV/uABbZdjBttQFdo/BDace/EKC9cFEUh
 CpEqo8njs7HlQh+mhi/c5ZKm6CHKhH6/rPgK2GyhtMtAI1aUALMEQXdcYx5FRiuFiPEv
 mXViMfXg+6ETY1cig5His4VCakFuQPWN7+bDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791922785; x=1792527585;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6+a9vYH40MOMEpLwr+Fo/d1C7Ymb9H7pVIrIaRMwJVc=;
 b=cO5En2iSfEbM3Oe3uuAZ74xGhXyNwcVCDyE22QSIFwX3jDGGMuRMmJXOdfi2CuuERi
 6yGwkxLAHkuWVVjnQEo5D8XcrAkxSqMivTp/BShtDCVAYLAaFZLGZ6/O6WN7WwtWCKlB
 LbyUFyDNwIaISIlMV/n1jocRm68N61OcIUVaKO81dXqbqWFuIXcoSqbMAIQK2vczXfIK
 AInw0pDoXiIukpelu4PaB4JSBRdhYExdiuElgQm8bSs1lWD4Guen9OSOhtMFi000UQYx
 ArP7QmpgduVxE25eTV6ASsMo48AlRAKzFgi8XicARy7w3VkwPBLoKET1YMtesJzLqHta
 Sxgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6ST4LeMWVUBAOa8aDLIzCGD7W/rFxqBH+2vrWQh//1uhV2otrMBwkKpBGh7nvNlRdPN80QDs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJMRDXSg4++A2cGkRPb5DhaWjCuOb5VdQxjLMIlAIozgQS5Amk6
 VJjbLd2B+FCZDp+wZY0h23/VMd9YL+FaMnjYKq/bIvpktdWF7wM7HPt1qyTqhvW5U/8=
X-Gm-Gg: AYBFou2etBeU37rzKVgUDpoDirErHT08PZdT3fMNxMjuCfWo7LjIF4q1MDDkKEn7exZ
 MMzNccr/WyGg6O72V46YAc3o8vL4A1wEbJcWpX79W3ewMfkJ6dBJVpmHAm4Y0IS/swALrGh+5D8
 31ZODU4md7jebKE0SdVR5W84myarn8pUaP/tmDM+MWuKTWOmIn0OsGkdOaxeU9psoYmPfjEgi68
 gkvl65yYAAC7Kv5BKfMKr+U1tByIH0x8mRIGZMesab8IdR6aBvm/cmrhQeY2cbQGUHWaTi6yUqN
 3xw9ZSgjXa/o/ofHymK5eWpfF+6FZwa/4actOBPBRB+iR3F7EVnBcPzLJiHsXEtEOfbeBPGx7Vn
 v5R66QH2lHerVkiAAf3RRl5GKr7Dbtmx0kO2YFnz4x6O63IZId/ZFwv900ZXMUgSncyUOULRra4
 JXvn9nIaXeEt3JRgBrUTTzk6Z+RxBuXQJ6sRgEBfED+dth2/ardnTMhpliah5Opj7byWjDAkxcG
 OyvswAPqD2qnA4EnQHekUVF60eRwUIiGWxU34B0KYiXwnD+wnsgLU2/99d110jvXbAUdsGybROO
 rLxefl6YoTtmEj297G94plYnsvCc
X-Received: by 2002:a05:6808:19a0:b0:4b9:e5fa:8a23 with SMTP id
 5614622812f47-50c53c94aedmr14989130b6e.40.1791922784815; 
 Tue, 13 Oct 2026 13:19:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1c120ae6sm15016505b6e.17.2026.10.13.13.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:19:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: sjg@chromium.org, ilias.apalodimas@linaro.org, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260930095948.1556020-1-anders.roxell@linaro.org>
References: <20260930095948.1556020-1-anders.roxell@linaro.org>
Subject: Re: [PATCH] test: ut: run every suite in a comma separated list
Message-Id: <179192278324.4115168.12337094788673390409.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 14:19:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 30 Sep 2026 11:59:48 +0200, Anders Roxell wrote:

> "ut lib,mem" only runs lib. The loop sets name to NULL after strsep(),
> but strsep() has already moved it past the comma.
> 
> Loop on strsep() until it returns NULL.
> 
> 

Applied to u-boot/main, thanks!

[1/1] test: ut: run every suite in a comma separated list
      commit: 6bbb926339da1267496089d857b74cc7e897a7b1
-- 
Tom


