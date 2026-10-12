Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8FACA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C920760643;
	Mon, 12 Oct 2026 14:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BV08XZR_blZx; Mon, 12 Oct 2026 14:10:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1CD3F60664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814239;
	b=iaCDpBslf4D7DLCu0F9z+QHYlNZUKxNCVMTtsn6CD9uNUt4PIcq9gtkQEAbs9Yb0VjXY
	 VLjvK7fybo9rizpftcPttc7ddpmMZBs90Z/MXA/8LU67eOokWQ5B619KSIOyxCOZvpPuk
	 XIa2E/qchoK03u71zZPC89XMxuExeXacMsESSnUbppABofjBBJCT1FEXTPUYTFPhz6fTk
	 z8/euu3HY1Cgl/UpLhxZo7OVgZgAmjEJcxm6EJ7L4yhatYH33TBKOXBoViolNVGG8B9YT
	 ZIVNun7f6WsYjo1N3phjOU9pog9Qib+F6T6MUbZvca0VFP3IY5OC81jFWh2RnU2K8QA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791814239;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+lGMEXH8FbYTFrsvehaIwe9JhQBcw5AHAmpLSuWBORM=;
	b=elYOTOF23pYU15UFhQWmdp57w9DPkVj35In9zjq1c7RjHrk1jifEb8HaRyyaCFqCxPdc
	 pKVI1IcEEAzKOL5VGutInFGga3h9vlMIsm+F8F0cX5KLcgHIU/V7ubw0I50lS5FxixS01
	 wsRCxIKpU6XdRtZ1uSZnG3AeGYPZUpT2Wjf8j8dD4pHjbAg6hPQAkEq+2CWHpZNYz1sNI
	 szLkKNYfVtjPSr2tu8J3kWAefV1kaPsNBfGwqgV5ARm/cAhbb1fGEg5Nwncd6ruSc1cEm
	 dKeVukr8rEmEdIgz+SHl1U5YAAO1nPffoVdPzFzisSMJeXanCfMEskxriGhfqDWr2zw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791814239;
	bh=+lGMEXH8FbYTFrsvehaIwe9JhQBcw5AHAmpLSuWBORM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFz7ryUySvB8r8dvI0ZFfhoUPPj8eCdDsrGtxEFD0Si2WS539lA1snTrfsmEpztxH
	 ff3vl6H1b2FaLA1BmG9fQAUgnfRFuYlRIT5bQ9h01R6occNB8bXlB02kr5lQpWX4Mp
	 9JfqyTSxh747Un4ofF9CeyCiBkmSefPnXrbxDhaUKhv9FiGSXSWwDng15k0jxjZeMI
	 1F6rCB1usAUWB/5ik4vwowexU6DHZ0cu6b+E/FS40w9O4981Nv4SnNrxEMm8HzamC0
	 KyaAXAwYh1mnzmTYobVbYfsLzCwEM1C95gaYostwXTCJO29Z0kMs0QZqyh4OknNrvv
	 gDGJkf54VBicA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CD3F60664;
	Mon, 12 Oct 2026 14:10:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49C55179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BCEE40503
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g0-_xLnjVCzd for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:10:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2CD51404F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814236;
 b=VFM3asILME6sKR7vlZSMr4j9VeFrNFXTeSJ/v5C6Q4o0wvOkvbWxkXfcWg/dxiR2jd4n
 KV6C6ZAu7WZE45yiJqSBZrYFtneQQsie0C38i36QeTFL7/5nOCJS5To6D4dckkORYi69C
 FtraRDa4nxl0UHOrx9udUYWs9X7ZWcrqoykp8yxhoG2FBwR6a7OdY4w7lGfZQRKT92NgL
 OPxAvRckhnFTlXwtOwmL5Egd0xTLT1E4WJ7HY5sE+D2eEy+uRtW2OIhV0wYUiuUohsNuX
 6CymJ+TmyFmXBKhYVRsN9DA9BbVgsp+KEXtvVtQPa92MLBw2dMHndMY2ezZO1XlAbcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791814236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=+lGMEXH8FbYTFrsvehaIwe9JhQBcw5AHAmpLSuWBORM=;
 b=bpzkFnpmfdPp5dNBYIn3CbMFkZ8xv+ZR96hOpMhnHwDJIVzPln3YBFaMpbGplbTyRhG4
 CHq1fSVq4n1RHFsJr2+qvJqHUMf2+CWKe2/k09szkVjj4bvIc4gZIVRALmWl9PA0p+JG9
 2EmLsZj0Aw8KOxA3XxOjhxiD73XQSTEJebDYdMxeiuvvqHe2QgYwHNaXNEH6XQ5UzuQaJ
 aEv6tXyBEHKOiow4U0lt/4y//AjaFz69lzUDddktpDJfqN5ALzIMd+HebQX7A//HPmg5m
 aEm4q7MA9Tgu5GNF4Va2JMxudxUiKZCW3R9t+Jo6PLGuxHV38+W0XQKLz6Va0WnYMNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="nBfKtB/Y"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nBfKtB/Y
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CD51404F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:10:35 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6af9a90e4bbso1979269a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814233; cv=none;
 d=google.com; s=arc-20260327;
 b=rQCUj4s8pMp3LJemp9dl9zKjFK8TdlDZbPqU6ZlZX//aNECbI9YwyNngCc2Zqc9R1g
 bpr6jClflHdr+cD3ZnGg1+GhuGucYgbjFROF3S68+KYPQ1NHg2Kh5bzRRMU5xSZEpqqN
 xx6iHDyoy82iZ/RGLPHF5FWYVH7phmokH7vj0M2m4XeE0xXWr0C+jSueU6h49/6j3B67
 dAE1eMETgDCdCBWlnbbi9Dz81mBIAftLVhWlS4TnsfeJ9wywh0gMAERy7tBL9qJUoVrs
 HwiWRjW/tU864Lczptr78UVWafiGsLp+uPGP5eck4gvPzXKR2ipJf102+4fszMUzA1k+
 exAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+lGMEXH8FbYTFrsvehaIwe9JhQBcw5AHAmpLSuWBORM=;
 fh=O6yyDpq51zTRjYTvyWS96c+vjtmCfJXCgqOToRtEnC0=;
 b=AKHmiggge60t7x8Do1COp8bmYl5cOZPH8bFdKoyarCP2QY2cWiC27WMKL/iFRVVRVz
 4ZLpsdGJlsGzL85Yla4/L131tio0CQjTCmGQ1yOKAZH4L50ZLx5vmTeaM7vp15UqMk5Q
 Hklp4ePMEZ1Zzp1dBPqUoHWwUjZKl0US18vIE82EvjReUg3NZ3Qrf4LmXs9arFGLJ93U
 D0BWwWALT7/95a1/LbortOpayoUFPbwKxBlwTwEeC1Wvv6VJ+MLaoOizKpVR8HCtFYPO
 ei6X3rbzft9glAeQB4Tqc8DvKIf+gllR/GyiS7M7koYzcWkzeiqv6WpWe2e7M7AzlH7V
 GvPA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791814233; x=1792419033;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+lGMEXH8FbYTFrsvehaIwe9JhQBcw5AHAmpLSuWBORM=;
 b=nBfKtB/Y6B0o1dw/E4DX1g5CWFndhWJQ8aBFjaTQ/8tjAIITkkBqHRlvNfzBxRYR+U
 CXvb4ynIN/doCn/LW3YL/fCU5bW889v4QbeKPGz8HifAns3dm8ka7aYo74XG1vCWmNVE
 /I5ZOvgfOoZ3v5IakC5Akfo2tVkcPow60pw08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814233; x=1792419033;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+lGMEXH8FbYTFrsvehaIwe9JhQBcw5AHAmpLSuWBORM=;
 b=LJKKPhTYnpArdUqAAj2qROuATp5/UAUEEEalh2T3MDHWgSWABbKuECg1SJcKI9cEtX
 DFHUOKyePc6r06IQctKWorvCXQ4FaDEU3dyrqyF3zEZ0zg2kCuB9Kg0IWG1u7TsvCfLQ
 WtmUgcMmiVnkrQiNpqiK0RwV9c24TaXv9zYj7GpfN7vEU5AMI1B1idGsSc2ntLNX4WCs
 u+02jSgBzVLS9BQyehHs5ZCp6TFy7GPdK1ThoRyEicCK5nl3+hhxJpz73cFnyxMS79Sk
 MEcoy11W/mOE6royMMsSOFlpSqMyxlsUNAUedUdmCwGclb4FSA4u26I4TyxkLi4P1Ww5
 Dp/w==
X-Gm-Message-State: AFq9FYKqhKFq8PyPeiMquC8jEPiCQyXEhBBnE8VI36Jl+bAeW5wv9ERm
 CKgjs20ceYfwPpzwWydf8jVDmPdKs4yTzpydE4gy7VeF9r3iwsDqOHgayaBGpGCazaxaGS7BkoI
 zLDHVuoEVCDR7nl8b/WcvLEpO91mY+SQtdVbchAKo
X-Gm-Gg: AYBFou0Mhctlmv4NpoHVuJEOvsdHaw7HJw546Al0lmAorMe3AQx4cEqLzWnmtR6xUel
 izDWcVr3aWmgSb6O6Og5FfL/yzoM0QPJf4oxcW7KAFm99eRg/XLTNeLwi16BLt+IbOS/lI13xKk
 ezzgyLH/f7tCgcwcEJguPL30gE1u5Or/+wl+GfLpUuUT3Z93NWfevNztCo+EuCseA9OrCMo1mgS
 ou/G2ifsix8Dy0l1Vpz+qED2czPrwJsPdqJC8XAXJeakNIzCXFlcjBuIg6NY9/1yYNSB+hv8dCb
 PK1MbcerDXbdggybBZxpgjc//p+Gx1g6l9K3m29nKTSdF96ka8JdqDM=
X-Received: by 2002:a05:6402:21cc:b0:6aa:e589:87d7 with SMTP id
 4fb4d7f45d1cf-6b17c1decf7mr7463894a12.6.1791814233435; Mon, 12 Oct 2026
 07:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261011152235.8842-2-aristo.chen@canonical.com>
In-Reply-To: <20261011152235.8842-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:10:17 +0100
X-Gm-Features: AclHuK-EBKzCc22tVC740IKQphljL_z2E_TQle8mk7fQ0yT_a6bie3Uh1p-lv9o
Message-ID: <CAFLszThirXtcY2XtGLojebTZO+vEwPKzQNjr8X6b7JBEESt5aA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] test: py: keep the external payload when editing a
 FIT with fdtput
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 anton@binarly.io, pranavkasthuri@gmail.com
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

On 2026-10-11T15:21:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: py: keep the external payload when editing a FIT with fdtput
>
> test_fit_import_data_missing_offset() builds an external-data FIT and
> removes one image's data-offset with fdtput. fdtput rewrites only the
> device tree, so the external payload behind it is dropped and the file
> shrinks to the bare FIT. The test still passed, but only because
> fit_import_data() reads the remaining image's data from beyond the end
> of the truncated file, which on Linux lands in the zero-filled rest of
> the mapped page rather than crashing. A bounds check on those reads,
> added next, rejects that image first and the test would stop
> exercising the case it was written for.
>
> Add a helper that saves the payload before running fdtput and appends
> it again afterwards at the 4-byte alignment fit_import_data() expects,
> and use it in the test so that the edited FIT stays complete.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit_import_data.py | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
