Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7A606A323
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A5mN1H9V;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Rtps6quN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6DE9409D3;
	Fri, 23 Oct 2026 17:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uvAHeZDjsyxy; Fri, 23 Oct 2026 17:11:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5DFB409AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792775517;
	b=TJhFV4NYasCOlZ3UCN1psiSomnZm6OHdiGQ2QXd+utZ68R3lPdjfeXoTSQQt1LmZwjYw
	 yZcWb2MKE6+Hp125FpqqPsjQhMwMS22LsT742iRqRnlSiQCS98Ng1ynP88egasmUoy0f+
	 9T4i/xIeckNJMDuOAD5+zUAW72XP8sbgpxu+srbU4XwF8FE7ZRV8E4HdqOaCg8dqikyFn
	 PMX4Nb/ztQRHrjYP1AO9z7iN8+fcBbhdrJHB6sqKOC+SXZYZlo5WCkD2THUlAnINJWxnG
	 D+4pO3V11vmHi++ByjjglybygSROQfFFr7RXLNmBwhkub3u0ATODpzkC5b7FbC2qZ+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792775517;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=XDEnwllcVTwOujH6aiL/p+6AeD3ZfpDaFri3IqeU2o0=;
	b=iXNEt0bPdNn/iZoXSgCRUz12wDvNjEjYbd+2LGZ5ILXbBV4DPuMe5UtFlJcqIGe/0QKO
	 8J00S/VS4c+ymWPQor9T+iGCzAMc4nCBU2GSEQyf2JpaGCKYSf6ysM9ap2etQMQ508eRr
	 n4dcPDDTuDQYp7/IW+DRdUESivSZVfRnw4bbRpiJqSoiuyKkVeffQpWlPawN/FGXtpOao
	 TJBMgrntlnGLMSA9r4/lyeXv+nZYDNb5PpKDBZRPZzyMWvUxoK1i811s1/tTVm6M3EvRj
	 mOcNs7h0liqVcIn48UQ7ke1LxsXClZFAMhRPxhD/qdf38ShD27Vd7hauOG73xdLnPNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792775517;
	bh=XDEnwllcVTwOujH6aiL/p+6AeD3ZfpDaFri3IqeU2o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A5mN1H9Vr+iZ0nhV26ZGTyPS+i9d8sw6DA5I0PNj6oAESgWr4LjXoN6X2mcaGTPKd
	 JvYCMUTZMzzS7DvkWF5P7tDbbeMZEJZgoUiWumVBr/jk9irr+HD8LyNP8lnIpCuQmN
	 d495sH+uWDDNmETqMHy3oO84gA6iJJBBgYA087g86q50aeHLesHhGX7380cvU/md5A
	 Lqty9pu6W8ShYVySZOJ5gdNgfY724LZmgBEvHMXkSf1riM8fJ+pUk6rzQw6NxS3jrq
	 hdPJAtKo5/r8s0dQe113JDMEMduVWxnL6FJ429oh38KaRcpx4/21Zr/cOrdEanM6xm
	 5SbGQtz+wfQmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5DFB409AD;
	Fri, 23 Oct 2026 17:11:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF5B12C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81530608C9
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibMX4Vr_kA3y for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0E476068D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792775515;
 b=ro7nCO4RNEP04F7ve6BelvUJt8oyvuQOHhK/9/TMG9H4SFuB0Nj8I5wqPVOD1gJVXulg
 cTnKzrOk6CD1ZE5xcnllYA+hfYcN6MJbq9JxfFDcehk0dvwWwrlU2+SwjZKYGMz9k5TbW
 US3oJR2s1mN2A1YPGHHi53zuvsTzuhTDUwl7DFxooRVGMnInNbyeXtineRZiDgC+g6+yr
 1qABR+kPtpk1l9fsXGhngHjMCvI+eUN5lQ/XscDFcXtV6p56qTrlfCLLOQazaxxAZY7Wr
 yAByGzty3+CGgvlADzUnMq1nmsJ4afuf2TapIHqwzEGyKaSrPnOYVh2NHAoJXn2Ymsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792775515;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=XDEnwllcVTwOujH6aiL/p+6AeD3ZfpDaFri3IqeU2o0=;
 b=Gy9lK4cxYe9maGGkgHyWdFRDp6Ab3CxV46borMUn7+IBXLthijSyPloN4L0xW8pii+DD
 J6XxTZclWPhraoxOLbhZP7md36Ux6LcgmQ38RXadoQAdYKtYZqUyIHDXcEig2RlTxKNDd
 qHs9aXeABCqMjhv3UBACpc+zPW4WIw1yWl/2SfozSk1oGWynlWUhQAhnqU6CgiMIBfLF8
 MrGFpBJQJs9MYWkkmA7YgSArbObJjbD9SnQV9ZXy3OcgSRqYPOxheyAElGDcu4Gkk4HKp
 jl4XkuwRtyUmvgjdPQsH0a92GCNvcsc7Ky8plMt4pb8Tbsyk++aOVlLPrrEa2NpulCw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Rtps6quN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Rtps6quN
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0E476068D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:54 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4af85d1cb34so200337b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792775513; x=1793380313;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XDEnwllcVTwOujH6aiL/p+6AeD3ZfpDaFri3IqeU2o0=;
 b=Rtps6quNGUh4avU6h+q/lVFY34K66hKnDbbNYq8dhdblFxW8T3PtK9kBLo62qQXqF2
 cR14sQ5xDwbShriZo77DiY3/a6QAwWkl7sZ2f/mSDpvsQTPsBR+PXyMa7ER8TNPHXYWX
 ILIcatku0hoJbfgrel0CV92fBMahEy0S/z3v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775513; x=1793380313;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XDEnwllcVTwOujH6aiL/p+6AeD3ZfpDaFri3IqeU2o0=;
 b=ZWskungwlu4ROgWgWIFlobQGzJ8vuKGEU3fVNv0BE4PCniliNpW/3rfpi3uIY10T+3
 opFZymhM10exPHL7woq6AfQruwuSk2gJEWykm+BZ3Yfi5dFU8Ti+y1X9ZMPshGy/mdmQ
 N27Usze3tBXxzvghPy+NvRqzhwfJBptUjlWVpA/wYZD4yMZpM0w+v+0Kz2+CniP5R8YB
 As2QR6b2PCipYGpLktvpJAPItwKsoY3hfP4gPkFu3TyCJWJj3TwKJ5sH7ksB5rp0w/6Y
 talH21EDazhwPBwXbJNbeNPuRStW0lAqQ32x1hYooacqhl20dqGxVxeSZpY0gO+cXZGb
 p10w==
X-Gm-Message-State: AFq9FYJpm9PKTQ8q1/vAGvhGwZIflf135+83Q73T3iEP5J1MMTC7LDT2
 EGZykeLfW+MECYkFfXde7eH4syY5o2piRG10qrA1My3q2nvh9mQISc/LTyb23gnQKRRAnGg7vfd
 8UFbweODLiHZJE9M=
X-Gm-Gg: AYBFou0CnnWcsu4RsBwk9edmHMwJHROLdpKBuki7/f+XdIxJEYewmSj+roa3P3kQPT5
 njlE0dMmQGpZGJt2yECM+CCasLuPuDPSRfrXGFc2KGURaU0SZRQVdeZwK6LaABirvDkLsdv/Zs5
 vC0gQ3h/SpFI7BGqFlDKkn9oqY74o1VUyIQjzcsBkguDDc99V1gIWpuhiK0vYRgFEEC/QDePPi1
 LWie+UeShUim5AN0CCTsQikBj+pLSXXnUflRPiju8w7FEW/sKtyqqLy6Dp0GqmfFntUEJDevClQ
 0Frwj8bkQ4IGQDnskzm3lPTaa7wtRunNq6oM6M3eDF8vhin/XULfmAPu+NLrKGE3LyyXPffN2Sy
 F2XCCNJT+sd4FP3jsxGtIIjDAJd1U46FpPEVn4avMeYoA8fUU8P5k27+apAg0rv0q0L8rlcnVqM
 Piet6dLi3cHx3Vn8eFS3EybjFMDjPzoA1Z8UQB0zo1fSkA6xOO/trozy7hI/s2PUAOmYYcTG9hb
 nXPNN9EimBbZR1TS09+EHQjJsm82d5+sGobxHbx3G7aaBefUZWz54TsT/DofnyW9hRG9YSY0hfj
 JG82kGS2Y78PazeRnoOIHam0UYEg1vIG/lL7qwSvdGbTxFnPLTkt5ZP9H3uXxEf7a7IlZem8qdw
 BN/qajipZS3fnyxbMgbncK6Jd5oD8E7/+waE0hw/ajimDI7h0NyZesB0H
X-Received: by 2002:a05:6808:2389:b0:496:976:acad with SMTP id
 5614622812f47-55be8056eb3mr1656712b6e.1.1792775513198; 
 Fri, 23 Oct 2026 10:11:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55bfe1537c3sm161329b6e.8.2026.10.23.10.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:11:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261023133916.1090964-1-dlechner@baylibre.com>
References: <20261023133916.1090964-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-main-2026-10-23 into main
Message-Id: <179277551221.3931275.14527230463175238363.b4-ty@konsulko.com>
Date: Fri, 23 Oct 2026 11:11:52 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 08:38:15 -0500, David Lechner wrote:

> The following changes since commit 62c9805d8d57cad407f0295879cc9a6182da464a:
> 
>   Merge patch series "fit: use constants for the cipher property names" (2026-10-20 11:13:13 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-main-2026-10-23
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


