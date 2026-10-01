Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9502BCA5FA5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 07:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5155B60BF0;
	Thu,  1 Oct 2026 07:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bukQM09mQyYx; Thu,  1 Oct 2026 07:55:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 88B9C60BEA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790841307;
	b=FpWbaADM+adffOo0lF44AqKnEwZYuBjJaSOWFnHLlyOxfKJfVKhJlfPPLK8ZANcRfEcT
	 clsupnzoX/DddPuoVbtmzlDWs5neaw0sU3IuREKhQWdNUXquTPr4CYDm96MN6tjsHG/tw
	 jN87ToLEsmnOIXw/W8VfiYM9b+SiKPwaeBiw1/Vf18viYkjEkiLg5crg9E0yVkpvY8wmt
	 rNHcbjrLjom1VAcOW27R6sM/pshBCyM4ihQon6cVpJAXVGj8spvEwJQdwD0iTc/Y/DrsM
	 cQDwIMYE/tQlfj8zDPlbNDmoevPVLFR6s0HUJV71QuiuMHz/tKJJL1dTdW5tHqvMU0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790841307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=R1QFYN/vxtEMWS3tR8vnt3wuNXQIeBAt07rTTT5t3pE=;
	b=bW6eYzo8L5imw89ytRVYv5b7jbdOpRecDVnBnpfVnhaDD/9bU9z7JGtVPNXf6zrLuJ+1
	 qFUfiz01M8Te3jJu5YLxOwdcBU6gmNAxZjKBYSVFvVzr8gdOlznDSaXtzV/b7La14Pvye
	 K66KnltrkNI6nJ6tNCznZuOmXWh81B/r9289Aq0siV54IU60eyV/ERHVLPtHNRFIysSqx
	 HDwaPa42f/SjDU1uW1d7AYWuoCzWd9dYrNjTBVY7k5KiMYIhAv708tb3ND2aj0GeBWW8P
	 ZF6iQfXEPCJVNPxtLzkFbnIowZihoi72I6MuF30mALpqEPsGypLdUbYsSQOYCAAmzGQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790841307;
	bh=R1QFYN/vxtEMWS3tR8vnt3wuNXQIeBAt07rTTT5t3pE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xTEY0CcEreKdDZsH+zg7TCF/N+3BbuaBf4jjwBjNQ7WsmduVoM7y5Dxi9owdPxd87
	 QyEbAaPcVhM29RY6u+HjazzM/zWj+k7qDMJgcU43Wzw2Zuc+0TK1mMQcABULg0gWgv
	 xYH+Ws0aVqKVrTpCS+gfcnxUvwAri02jOjurQIXZqZTREvPmg983QkcitdpVTUPDvG
	 +DMpQ+2XyKRrLCZN/oMKNO0rNqGa0CCOpmoQIM6XC4dXfceUtqsZFgCZAl5JBXqKAi
	 DOP2kPnAOMJTphBmMBTmc3WaUHz6IHv5A4op/Q+xsZOclZEpP32nAowUOmcliEw1G0
	 /xoZH6s4K3oAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88B9C60BEA;
	Thu,  1 Oct 2026 07:55:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D786634D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD61F81288
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:55:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAXwX0JMOVhX for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 07:55:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C1FF28124F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790841305;
 b=oSwHl2EoB9WoFSqR53Npw+mlLHkQbwWv58/9tJ+XuMZd35Zh50/NHGtseha7W0AJRLzp
 iGJH/hShhHyJwjuTec63TXEGUNDjWQqIxyDo4Hxu/1x8bNrnZ2B3Rva3s4uwBTmW0dfJu
 8kqoKNW79aTEDkQR7Ss2t2E+M0YslfehXPyg5Li0nG+UAUyLJtmpwEUb/d+Oi+mmbw2rq
 g2Daa2UtYZ/YqPKXiX83Y5Ov7a51WcOhNImKBagg1fn/3vWCOECki/sBPL931XbBizig9
 Bkoqu8yWmelUg7jz0KpbFBqCFYohg0ojFNPOyB/rCnI6a3hc50hczMZ1sI/7G+O95rQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790841305;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=R1QFYN/vxtEMWS3tR8vnt3wuNXQIeBAt07rTTT5t3pE=;
 b=J6mBatOzetuUI45lXdN8jl8gQKH4EVxilSeF1Ul9ZafGpRS67UKtCsqNolL+IBxfuUT1
 64jDv7yiwhgsGTQ2F/v2/QascTfQCIiUMto1SbaCHf4I1mKva+p0qpKMED/DuI8kYtVjc
 J4QoyNpBHmulYh6oAnQu/Qiy5hfZ0PbCSVixexkF6v21lEnVXJ4DdftJMqS80h5qmACzT
 KdlazB3NpdZDAQMNbQIo8o8S7BXOGUMYfA8GV2BOEHOIpnBtXZOaasNIBSyim8j80UPIS
 FtngQPA9YvyE4pkhAwhtg2VYnoXKvr3GCJQsYU2juD3HC80BtkD/34BqhQZn8rH6jfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DpRDhdW3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::c;
 helo=mail-ed2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DpRDhdW3
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com
 [IPv6:2a00:1450:4864:33::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1FF28124F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:55:03 +0000 (UTC)
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6af7d408b51so202607a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 00:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790841301; cv=none;
 d=google.com; s=arc-20260327;
 b=ADoJBjsCIKt4HQ0CRTQ5DIDnU7st9dT7AeGzeQvH4d/gxysuK8JoHw0aQM5ap+7O1q
 ugLrrs1RaJNDXM0AVZfRCwAvEkLSUKROSvVnPGesOOCDiePwwtUM33SWd445LX5xx2hu
 6Js2JBWhBH7ATaH51IssOapIZDhz8MI9o+SsEiqm9ww3ZDWc1nRpXwn9gliA0dLDD6Xw
 BOI1Jrg9l2dDuTjiGIylDSqR6kqsm0GRGwng1ist/A2wjGcHQT6NFGKkx110FlImE42n
 S3QM21ey3b1rDmhRIw2QNWSKYMulr2o89oQ3mkaklQQ2PhON0dlH/SdcKKHeCI2tgh2y
 uwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R1QFYN/vxtEMWS3tR8vnt3wuNXQIeBAt07rTTT5t3pE=;
 fh=qGXFymjRF84IwoVOPzvxNVoytPXZ0hYfgiKbDkgZ0n4=;
 b=kamObNgsxINvobTPS5Y6j9MraiCZdNR2SwnXA1HR5vUI/kfhnRptBLrVPd/ACpIQpA
 52UTcIq/KqhihZr3dOQQvmpa0d0zE/5whGYYvN7HwVVTrN5rpGQKNeX/a8CgMD7Sbt+O
 05/NtFf8edCXGK9RJ+oNq0iApVjZfuVxrPjnLBgeHYilD41LNoy7HBzOPPAyYlN17Gdp
 foKbH7XtPGTozpOHasCail5ZkauTeRtpUFOTw6IPDd5arYcXgtSOYEz9Dmk3AXJRgbkp
 Exx0Go9/NUTb1D7YPLQRfI9BKa9DS8d75oUx92buh+SlO3M4QFCIqkcots/Lo5GdFfQV
 3XTw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790841301; x=1791446101;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R1QFYN/vxtEMWS3tR8vnt3wuNXQIeBAt07rTTT5t3pE=;
 b=DpRDhdW3VaCbtyX0GOsoxk+NIx0NwMQbzZ4XBfHRxzGCkra6fd+JXU+gOP77XoRTir
 JMN/wOYfp6AUQo8PMs33JWOx3wSpXg/lvwIfz59++h94w5moOZLDmZJQz2sR681MsZzl
 GSc3PzBKaoxu7JZHDcfvam+M1tXCvHcUSiiAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790841301; x=1791446101;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R1QFYN/vxtEMWS3tR8vnt3wuNXQIeBAt07rTTT5t3pE=;
 b=pieRcpdb5wz/ol0WomW8VoU70Jp62mFhxExdB1hqBNN18Wf3bgNuN4PE3WA3mJ6l0k
 fjvhgUzkb+CuQShqcS+BJKjgVhOT2iGl2WFB9xv68J6W6r66TpjsCZ47XrKaP13lhwgi
 UfcBX67iZqlP0t7qECJr1wn1TSFZPHqrOo4NSVA3LWj+LvSe5D2pb2tXDlUoPfTbKn8Z
 cXw1vExS79VQQVw/c06V0CnPj8bJ/D9eispFOiKWvqskcn66rglKBPD4RZ7Nm5Mskpf8
 nbViFSlI2vq+gv3NRrNXjgypTr26aDkfaXwYYR7gED5iq67wZPi6/76rCHJ/iexcafaN
 f3lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylcnotXYhJBRmbIo5iOhvD2/rGOCLAVaPLbLLsJRbSOTemDA8LT+8IVcRlaJ4IQ6kqsKKLwMU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLwQp4ksbjHiaIuaVKFqxPoAMAMBjlk6JTpJEL4yO3S4Ht6FDIb
 CMfK60PX9JjTQsww2HsMcrZ18GxZJ21ISACeF+w1Z7yktNPEez5c+7xk8HrXNT11o3uM7HiUJph
 yhREg9CKwAZubUOMDXMa6xZ2i0xGOlZV4xVt4BWCn
X-Gm-Gg: AYBFou2AlG4MnUYzAtNh0Gu+DWJZy+ZptyIWW8qmSj/OX4hvmV2x0OZLIyTmDnDLyIA
 yG9o/CQl+EUfB7rFo6A7p5PEZFpbBboCHXt7FnmQikEYRhSI+JpYbj8O8QqX1Chu6yGx0I7FFVf
 dE4+IQyFTefumt528aDORt/cVx3yZhAy/cyzEIiFn7cmaW87ANWETbVWslRnXjf4wt0Iqes92+n
 pwvkekGBrcohXG2vHn2SAox/obYck6owF60W/GrXASdbvKAOPfFQjKuAUiHz0berztBMsWCLuHC
 x4X3Xi6g8/hyhSEf1LeNV4WPgQuaqX2eN6Oc/A4by856eHrARkW9LIZ3
X-Received: by 2002:a05:6402:439b:b0:6ac:6d97:c5f7 with SMTP id
 4fb4d7f45d1cf-6ae30836691mr1220921a12.17.1790841300867; Thu, 01 Oct 2026
 00:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260930095948.1556020-1-anders.roxell@linaro.org>
In-Reply-To: <20260930095948.1556020-1-anders.roxell@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 08:54:48 +0100
X-Gm-Features: AclHuK95XQ0fy9PXVkNqlPDnyeKdnX2KvdxNVpdmZHeRpxRey1WHiFyoQoMun8c
Message-ID: <CAFLszTh+qKBGPY5qTQGT1C7nAqs_j0=jEx_NWyiCCnokqiEPcw@mail.gmail.com>
Subject: Re: [PATCH] test: ut: run every suite in a comma separated list
To: anders.roxell@linaro.org
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Anders,

On 2026-09-30T09:59:48, Anders Roxell <anders.roxell@linaro.org> wrote:
> test: ut: run every suite in a comma separated list
>
> "ut lib,mem" only runs lib. The loop sets name to NULL after strsep(),
> but strsep() has already moved it past the comma.
>
> Loop on strsep() until it returns NULL.
>
> Fixes: fa0b68d22add ("test: Allow running a selection of suites")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> test/cmd_ut.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> @@ -301,7 +301,7 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> -             for (; p = strsep(&name, ","), p; name = NULL) {
> +             while ((p = strsep(&name, ","))) {

Thanks for fixing this.

BTW, test_suite.py already checks this with 'ut bloblist,setexpr,mem'
and expects 'Suites run: 3', but the test is disabled because it is
named xtest_suite(), which probably explains why nobody noticed. It
would be nice to re-enable it, perhaps in a follow-up.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
