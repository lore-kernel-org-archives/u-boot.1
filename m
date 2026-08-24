Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0568C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 23:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A8046067A;
	Mon, 24 Aug 2026 23:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rioadmtwhUp0; Mon, 24 Aug 2026 23:26:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787613961;
	bh=SLjWBhBSD7rhjXGn26q3Tp6nOaxVzub+LDYZCh4473o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hk+UHVUSAgoR3wsT8mSAiJiQikm2xxk7gXKiEBc1M3YeeXlihj8+47zLGktkL+gVO
	 C/LCvXJITscNzD7aFd7WO7e2QWk2BIxSJagVuja8oO+6HLSdDgmYvU2dr6BEiAyOWj
	 lFA8EYqECuFpy4doYVQBRfA0khQCtxgW9iNG+h0qA3t4GOT9Ho2WT5ZUY9bCvcAkuF
	 xE2s6YuMEZspkcf+duzCtD54ULc8womh+STzuGz1YvvsFYQIFwCWkTJ6izLc3ne8ko
	 ZezpcrdObwSWRCDQ6UjQ+zVMqq+BhcLCwG+pcbRvLJrsV3+/cjtSavq7Da9llDjGqF
	 TwNnH/lWEJRjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0704F6063A;
	Mon, 24 Aug 2026 23:26:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D9C429B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37988405F6
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:25:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RvX2Kg_k-qv9 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 23:25:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=P/Zo+knF
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 400D1405AC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 23:25:56 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3a14f6613fdso45017971fa.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787613954; cv=none;
 d=google.com; s=arc-20260327;
 b=RlUS1WuMEHTCCr1TZFHqsRJil5jJSO6/EzWxFGed7i1XA7X2ZnHh8tckGOLCsSk/91
 iAqLs56AsmLCRnB20+qDOLIu5dBuGnmRUm7/kMBBCLKpDQ71xaCp2/w7FQ1wRox01GZd
 3z1rYvmgW+yPVjChTynGNXWwLppvmKVsq5D6CJrliW7cMcnQ+JP0+gPRsns8tCL7S1xG
 GJmzwXSWDhkhUeKo2vFIc3q6QxEZITT+BTGcYkte+jJEFFvcvPp2/63chH3rwMmTwPPk
 tOIK63byyYrQypVGvHaP/lnP9Jjd8B+Sy0GIigs4KD3k3PLHRGhvXfvREqX2+Ij/iq/G
 Os7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SLjWBhBSD7rhjXGn26q3Tp6nOaxVzub+LDYZCh4473o=;
 fh=a18eQ1RVpL1aWxYl4TszqN0SID7gWhf6FQKUqgWycWs=;
 b=dyRxyCFL6WuZefByj1zX4BnVVg4nbPIBnLpBzutB8614N9PVPKCl197txXlXGnMiOt
 SCjN5wd5f1FmIOJPbiY6tv2GivpEmT0n+qtk3UR5xNj//MbaFLwUnt9N9Ip6gfr8EkKJ
 nrZMofVwcSEgcpq0sNHIRlnm/y26MVmuu8fMcAoDNfZRsBssJxzY8zWbOG/sNVv/DmHt
 QhNt6/PoQerd+Y6FpFB9wJTH4EnfPdRkd4VetP0s6ehz+k37h8A+8r+uVi9G9sJ12lwl
 961ecLeLhYVgYNNp4cpoOubA49iDs+2EXhH2NnEwQdl/KUk5N9hYjlkQBdtC3bHngHi7
 XKGA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787613954; x=1788218754;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SLjWBhBSD7rhjXGn26q3Tp6nOaxVzub+LDYZCh4473o=;
 b=P/Zo+knFDEwQp/uJjWY2NkJW1k4oePGAhbAdEUN7lX5yhulmgU7orztp8C8Pma2pZG
 u1gJg3ACZ0xaQOCYSyOpfnSBL1pCfB/WhjFq289GSCHUsgxYSC91A9leDl7uIf5Md+z7
 agPiACDju4kTeCD9E9G/pB3OT6RGKzot+bxWA+wTBCwkCAIBqd/GPbHl+OGwJsn8AavG
 oEUzhtuhr5kglZZu5l9xQcYaAAeH1eoDurlhhlgTt7FirUX2cDfcvffwWPIE9+UeeFcG
 dxjKqKYslrV+vJZp/VUui5mzMWvn5ejrAdMlCrgFJVdVgirqtC9DTvoL6mDHrByMgeZq
 fz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787613954; x=1788218754;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SLjWBhBSD7rhjXGn26q3Tp6nOaxVzub+LDYZCh4473o=;
 b=pmUr+cPzrzJ7hbWBofHYvMffzN6P1xg/crPcjHD6gwHG6SIGosZjmbqF+5DLtNEMn5
 chUbvngQAovReK6fACMskpVKZ829wp24Ew2A3oY/xF0+f38fybB7ruBb/WFnuQpXnDxn
 lic/vCe1pSzyN2hPOhganKjb4D9QSCUImimNzzU+L3nx51HH+mKYKB8thRj3ZlS0CMF6
 vnC+Whpwj+AeTy7pMF1fLzTyhQdU47LxZlmpeTRnbM/avP9bB/bjI7Agcbn5eWTvW3e6
 4BCfRCtldlVjDF7USiqVrYcFCVKJw8XQx1BwNV7Rrc6lciUQET8izloc8clhcEd//FJ9
 2xqQ==
X-Gm-Message-State: AFuF++kd7TD9SH8fm6vyu23mDMkgvGRsNUAKiJCYoVSINdxwNpLeR4oO
 jc1WFKn9Ap44H6CxdbMvc7LjTxkjjYs6M0n7N5e+xx00XrzY5AxC2bsKrXnJ/2m727jTR+78ll+
 O3oOpWkjoydZfP2mIe2an7BhdP6+BCV1j8w==
X-Gm-Gg: AR+sD13KiBlzWGz44jVjinLRi+BJf5sm24o9qvmzEChKWV5tyUlz6BsLVMQu3Y09Xr/
 8CjdHo3O8ovmqDrhHK3kZxvas0TFzjNjSgb0/o9o76WLY3/C9jpzt4yuWkpkLd2AuEH2mQ4SUDI
 XKBSNHYNVWk0bPhGTLTqxhC9uV21lVXjOSPAngHKbS2I+r3XLCm1Ja/oNhk4v2Mh6YL4m0c6LRP
 Ytz6B21WamYU6VnZAGcIRTDIB/ykt/BBDBvlrUEyD73RcwEs6A6aQnyCl4toE2PNzTomjVb3BbO
 vUVnKiufLU3Jo3zqkAGcwvsM9i9wLTCmWMzBXiMYTcJsguDtVZnn9CLSu2QFzLBDHF/DiIHy0Uv
 rqkFFfxyt/CeD2Arg0Wge3MU62ZL2KNJ4
X-Received: by 2002:a05:6512:3d8b:b0:5b4:508b:de9 with SMTP id
 2adb3069b0e04-5b49cdde48amr490757e87.25.1787613954204; Mon, 24 Aug 2026
 16:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260819153014.834228-1-petko.manolov@konsulko.com>
 <20260819153014.834228-2-petko.manolov@konsulko.com>
 <CAOMZO5B-Q6R652_wp=AWXURBSP8Npr_AwJUvaw=CYSL7=bJKKg@mail.gmail.com>
 <20260820061912.GD24421@carbon.k.g>
 <CAOMZO5AfFXrpN3RMPuYw4vM=AHOWBj6hnaXdG8W=KhSsWj5big@mail.gmail.com>
 <20260823150041.GE17052@cabron.k.g>
In-Reply-To: <20260823150041.GE17052@cabron.k.g>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 24 Aug 2026 20:25:41 -0300
X-Gm-Features: AcwNN1W_ASioo7aPIAGcumL6QMboEoLZOfH8HACL5F83FphJpWD_uhOBsCzQ7NE
Message-ID: <CAOMZO5BjH8zOHQQ_9nQE-aqC3k4BLc8qFeo81F1ufbJFtOaNbg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_1=2F1=5D_arm=3A_draeger=3A_Dr=C3=A4ger_M48_on_NXP_?=
 =?UTF-8?Q?i=2EMX6=28Q=29_and_Intel=2FAltera_SoCFPGA_Cyclone_V_devicetree=2E?=
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, uboot-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Aug 23, 2026 at 12:00=E2=80=AFPM Petko Manolov
<petko.manolov@konsulko.com> wrote:

> I have hard time believing the respective Linux maintainters would like t=
o waste
> time and energy upstreaming the DTs of a board that's never meant to run =
Linux
> in the first place.  Will see... :)

Linux DT maintainers are fully aware that Linux is not the only DT consumer=
.

They even take this into consideration when reviewing DT patches, to
make sure other projects don't regress.

> Does it make sense to start submitting the arch part of the i.MX6 patches=
 to
> u-boot while i'm busy with the DTs?

Submit the M48 patches to Linux first and wait for review.
