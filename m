Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6F6C5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:25:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 976F26068D;
	Sat,  8 Aug 2026 17:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ztevtgpD-FC; Sat,  8 Aug 2026 17:25:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07B64606DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786209913;
	bh=LcOcOwKJQC8yux3WvDTS2s4gibS2HFWG8zcTMw9crow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GA9/44d2bk6xq5vTYHH7YS/QcpPcbzMeDfW8qggFxve0W9PgPGBYGMW7RNDaJJLyE
	 IJQzIKh0khWEbX9Cw6qU2q8ns4fMUUa9gwSDIvCC/RMKEhnkyUML+eZ8JktwujlJWD
	 nx4Ab+ZjhmbjmABt8U1v5qYSWnmh1NO6LI/p4yQiDSVRvnsxV8pEPnP2E/NGdm9ChE
	 dZ0/frUcsxKuUXYXUD4hUe5qYQfeH1K4RGGu9BQwOioj55XD/HcT5hshiKmaL3X9SM
	 TMQK8NgUmzA81iFi/hi1arERk8F1zqSqPQS611WahsUTK2+kKOuBH3oNz+7iMDfXRS
	 H2NaTmQygfdOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07B64606DC;
	Sat,  8 Aug 2026 17:25:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A4A9D144
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AD834061A
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9MYc7sZjMbqW for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:25:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9CFA34060E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CFA34060E
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CFA34060E
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:25:09 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso606839a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786209907; cv=none;
 d=google.com; s=arc-20260327;
 b=fvdTQwTzwfdw36Gi8lAdxgRh+UZvUCpsr48zfsfa5sLskgW8z1yhbwYOCRaJXI7iHW
 VvZxc3GKxaUvflqSctfXcr0ajzzE/o7FF9g2uEHzirjfSEmiBMAyx9YknrsjQFABLLzm
 qezcfyot3gFJ3lJzwqQVqrLGxIHF0wlEywzMRHf/b3VZ0BvEzMs+2BoK+n2VncOqQIhv
 k3jBjlyZF9W0xSnrvt3iywK1dqGL9G2H+k8nZEQVi/f1UTm90v4bu634Ms/CArIuSMZ6
 H8jEE6DROsa+fwvaxRhl9qJuZR1S8Rh+9UARvCW/qhMqATa0l+N+yCkWmy225NGihH3a
 Sq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LcOcOwKJQC8yux3WvDTS2s4gibS2HFWG8zcTMw9crow=;
 fh=ECOLw5Xfh+cefcU3YnLLcS78vfzohGM51CXLc8vVNzk=;
 b=CiFSwodpmyu7ycF3aA25Oa3JXxn/hS/7CLlssn9/cJk5Xof/fKwFN2vdfb1P0Ihspc
 D0aOyXhvfM6i7r8bmYWwl+FW2HAIhEajWlXlIf+zyuwXRyzfdf+THkLRXSccuXcEteqm
 98Bkv5LbAomBoEsC2Es9RRo41w0hW0zY7FSwcZiEoOMdT+bmfLQo+OYFJ+azmG83iqaf
 kganLqcRg5VAcOw0BnL2ljVX/YGSrpPl8FiZdVLrvGATPrCCbpP1hkRwToNCo4aB1vE0
 eW2hlC0VF2TuZ3HU7HnhOdmludv2XAxec0zjeKjXJL3Dhs3ASNzASDWp18Qf3XKSk0Ov
 3NoA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209907; x=1786814707;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LcOcOwKJQC8yux3WvDTS2s4gibS2HFWG8zcTMw9crow=;
 b=Xk9Zat6lCSJJNQsD+XjtOLz0FzEg+f0v8D7IuDAbNRUXI3TNXJ2O5iRh0zc3mSErfo
 X9HKqjK/JNoRKh73tmU99G2gPE5kD+YfmSAGU88yuGDVaZTr686ShtZYhs7000nAu8o9
 NULKtlQPt9L6g3JRChjiAPmuv2Ex3oaPBsPIEL4NNFDdiow0KVys17NewGyvClQ6mfCi
 amxGtEiIg8a+lFAo8OzPCfnvri/RaoEtEEjYgGNMN0E0+Lf0Y+9vg8rFaZTbIk8N+LUY
 1vLNWGSQShhO89Dxl9O9NQ0e4coeGXX2UyGZ1dytZlMEhAJI804pGDTMG31vL0Qd5Vna
 ptBQ==
X-Gm-Message-State: AOJu0Yzv9f+AVAjhcmL+H7cw53jZm9vCSBWk9CX71bQpNVKfoxuSsZ0L
 q9y0MyER2+BUo3RLalny/QMUFC6mxvOYL9JtLHKDHs5sR0lrguTA5hF8P3Rc/MatL8o87zjrUyI
 UgmLTGwNQp54RzaedBg4g7hNNS8+VEj8yhbCt0Sqn5kWMlpZxwJI=
X-Gm-Gg: AR+sD12T1gtNdEKf4Y0JyjerRaS+Ui2mkxeB9XJd76m9ftT+Q3pE/HeObENjoJmfRus
 I9rYFiw+RIYSV2TKGWkAIhqLcXQrBrt3txPk1xXYzWQUh9zTRwKNRCuTY/fns5Vr+cK5GVzEINQ
 gNcjjmQefUVgzSfLCZRFrQYfvdHZ7/1BruXKAnl1ye18uYDZVDzqjlnN1f/z16z2rtpn6dQ9m9C
 xCtZkKc2BFgYpsLRUvvq/yC+fN+752LtyTzLgdM7uWkGfX61lt5L+T5vKcZTjcFQerXnGBR+u5T
 FVsgOFUpLxioFR6ZiDsZrauvNcqt5YCGfpfKYJnK1orpF1aLUYznSw==
X-Received: by 2002:a05:6402:388d:b0:698:ae69:3992 with SMTP id
 4fb4d7f45d1cf-6a1b4b98deemr8647636a12.16.1786209907515; Sat, 08 Aug 2026
 10:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260730-spl-lzma-link-v1-1-03bb8331029a@flipper.net>
In-Reply-To: <20260730-spl-lzma-link-v1-1-03bb8331029a@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:24:53 -0600
X-Gm-Features: AUfX_mzxHDBQMMFLUBEjE4e7lMxFyrggByyxcRuzOeG927qQCbkJ9P4Eis64k_c
Message-ID: <CAFLszThhWiB_Bqex6eB6vWOU5UsAbqQMzL+Zos=+LSKb9pdDJA@mail.gmail.com>
Subject: Re: [PATCH] spl: Fix link when LZMA is enabled without legacy image
 format support
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786209907; x=1786814707;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LcOcOwKJQC8yux3WvDTS2s4gibS2HFWG8zcTMw9crow=;
 b=j2+liudKgvjVN/xXZ499U2oQtYBpTrlaYT68aF0TU5RHIHim4M7f28zUV6udPRfkk5
 yfNTNrt9ALjo81rYxUJXIc+RcudfYq5Gaacj4ucRbbbwF4R9vj+FIepND+ZkI1U99nb1
 2yy7pdylaYOqcbG/KYsQ7wEg5Jef88mK0pbLU=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=j2+liudK
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

On 2026-07-30T09:31:47, Alexey Charkov <alchark@flipper.net> wrote:
> spl: Fix link when LZMA is enabled without legacy image format support
>
> spl_load_legacy_lzma() lives in common/spl/spl_legacy.c, which is only
> built when CONFIG_$(PHASE_)LEGACY_IMAGE_FORMAT is set, but the call site
> in _spl_load() is guarded by CONFIG_SPL_LZMA alone. Enabling LZMA
> decompression without the legacy image format therefore fails to link:
>
>   ld: common/spl/spl.o: in function `_spl_load':
>   include/spl_load.h:73: undefined reference to `spl_load_legacy_lzma'
>
> CONFIG_SPL_LZMA is also needed to support LZMA-compressed payloads with a
> FIT-only SPL, so add the missing condition to avoid including the legacy
> image related function call when legacy image support is not built.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> include/spl_load.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
