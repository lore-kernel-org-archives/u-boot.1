Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205F7C5AD44
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 18:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D7F16068F;
	Sat,  8 Aug 2026 18:17:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rGXU8oUtlBuJ; Sat,  8 Aug 2026 18:17:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E16C160625
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786213077;
	bh=H7u7lkGbd1LWbVGZ/SlxF9zDDryDyth3hwqaZVO9KqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NipCgOmgYoDjw2RmsMWyeGTSBhANZRz8dEddDLb9iLM8ombuch1OJ2cCI6jEMENPQ
	 lvrW+aJpga/mdPYGpyiPMtwxjKAQ3hunLqfNgdl/+To/JsxGjZV8SH57zNcyOwiz1K
	 bXsF0ggxUOvD8l6gZN/K8Ay/5leW/gVWqZ0C/FrPtgWHlpWapjuu5m6qJ932+V6Gbi
	 G5Pq2k4Jwcs6X5HjyiYLavUpOBk7kGckmoImXjtkEAuqW08cFbUIonfzRD37VfzI6G
	 GJtEdHGqIrfNnOXX6C6cCVJnAsS53KEqheQyrk1UznjmLfuUjP3jS0570KLQiCf9Jk
	 DG1mAPhWVocPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E16C160625;
	Sat,  8 Aug 2026 18:17:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36B16296
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28537404F2
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kliz5rmGcIbP for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 18:17:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 365A5404EB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 365A5404EB
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 365A5404EB
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 18:17:53 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a051904222so631682a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 11:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786213072; cv=none;
 d=google.com; s=arc-20260327;
 b=T0A4YzY7qpDttQsUEQ/qgRoZxVMr376nh3yCmQusU4vn3DyHd+XD+F600d4mILpXi7
 XWWGKPJpjCVCaDjw48/fNfRXYmi73S6SDmjk1Cd8VI8LQMD3L+aFA6dG9FGv9WHJLR4g
 a7+GSl5+6eaI3ne7iueKpvMvSQgsUCKA5W5oujkhDX0MGfLRwmdPY2+1cqigZ//6Ixxv
 KbaFEXMpcURahkGfYS68B/EjBjDkQYZwNz0RtsAadns8JNn5RrTYgDwYxC6qDnEd8wQv
 RLq5d8nEcOynMq/rrCiPXYMMabE+fAR6FNcD9gatATbjA6zuzaIcyLkod/qtnqeNh9T6
 +BsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H7u7lkGbd1LWbVGZ/SlxF9zDDryDyth3hwqaZVO9KqY=;
 fh=UF8JWmk5ibj02D9AukKNB5sACZx4gDarPbgRyRwfn9I=;
 b=gebGdc6Ad/1fQ5haX1tpc+OdhusG1jfOO+V0OrTGMoC9+sJS1fqd/T89BXi3qQzdby
 xap6A3DqKyqJ32kq12aG7BsRYMRWbTrn49rF/lsYFV+cJ3O/pzdw3NcAnZ2dcOc0Tiqz
 IUNnoOJ4htli2y62yVQtjGmu83sROXNGR8TUaGuDaeYbJHOrWPv2X6xSPtEmywkAuDZ+
 kirVeflVFoOkGJlr6tLkYfUM5Af2VFxemALlXS48CWb94QzUut+FFjAT6rgHy5/8aWLJ
 BtMLlbshyGiFbwEx+8MGdnfKQzrrzsC4tp6w5fddat05PbXTYoj2T2LLHivKPxluMoLl
 5Seg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786213072; x=1786817872;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H7u7lkGbd1LWbVGZ/SlxF9zDDryDyth3hwqaZVO9KqY=;
 b=BwwaBoLF3mLTEnkuoLCsNh4nU7hEvqJBbPx2DJ2+uvADB5tATe5bFcRWB6UKz/Ru/9
 XAA+ml5+zTfYq5ufoFeR7Q2LldbUsutKX0IQG+88wmTZUsGzNMcEL4SkrjJ6XvY0bwM3
 fK+xI7ir9ug4o6eHbt4gp/lZO3TK5oc2P026EcNs6mfuQ/WEdGR3MU5830G4B8Vu4mIF
 5iFGodftr+JMbNIqppZVPzpCTv/+xcrohJLn64twAzR9TQ4hbXHusehB+GgB4X2PDKpg
 5nDeEhBpF3liVjt7Z2g5erepOsQurPyVEtIsW6em7PtIjibMK8wtz3ph1oIoUiCN6Lrd
 udtg==
X-Gm-Message-State: AOJu0YyIkdik6DjQmql8kIlKj5a1VMkDxN9heHKAMCoIO6VZ2wV5HDEx
 U/DOI02xcu2QXqNlo4RhRDe4rZA9EGegIBuw69GV1wqAkPUTWCZr7BMSc855ZRcKpTY3cloff79
 2X25XIYV8yW3/alCYE4B7CsVrqkmQsYILYkvT/hzx
X-Gm-Gg: AR+sD12ixvL8CskOwcT5yNV4DSwZ/y8efGLZzKAYtziSOgkUp5+B2FNvz2XQgrPdKqK
 DefGsCrxxr65DKQfHtalYmMy7d0fGAtmDHoHF+vu7z5HVG1pPsdJu8DBDgYdi7SwKHjYYbc9cp2
 fK4dPOtTzFdMmV/W7lurNCdfolMKdyj/zWt2MtbkztWN3UmO/TmcQ1g+Qb39HS/naD/w4I+oNx/
 UD5priFySoEma03/Tcan74fKNgE/S+X4nlQrsLQW6gxfEsnumIPufa0/zyxKt6CS7ou8yks7hPf
 2tMhTsXQ8ed5NH2Phrr350ybKGrX/jTNK8d6G8WH1wI=
X-Received: by 2002:a05:6402:5416:b0:699:fbe4:16d5 with SMTP id
 4fb4d7f45d1cf-6a14f07bde3mr17979965a12.1.1786213072027; Sat, 08 Aug 2026
 11:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260721194828.398524-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 12:17:39 -0600
X-Gm-Features: AUfX_mwSAUZo3Vwg_XQJPIa9NhEzfQJCOtjrrW0TjStvFJgZfHWDRhEkPKW5cVE
Message-ID: <CAFLszThbzKZWctdWh8B1j2cqACr+9dNVaX_FMkvbHtXkMDnsTg@mail.gmail.com>
Subject: Re: [PATCH] board_f: Call initf_malloc() before fdtdec_setup()
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786213072; x=1786817872;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H7u7lkGbd1LWbVGZ/SlxF9zDDryDyth3hwqaZVO9KqY=;
 b=DJg5zwDRy1dl/K2Ro1iDzKWhzTy/lTk/TPhMHQx8rCmF3xX0xOHEeu0NysE4JTikF+
 zC366TBMMHz59+Q+0X7MdhZke0QYp/YzdZ0Tjffwd705+/0Uz65rD0mjlmxMY1dP87cT
 wT+av+oiUFVlu+j4nRghaiqXtF0rGZWacJzqY=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DJg5zwDR
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

Hi Marek,

On Tue, 21 Jul 2026 at 13:48, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> In case MULTI_DTB_FIT_GZIP is enabled, fdtdec_setup() does uncompress
> the compressed DTs in uncompress_blob() using gunzip(), which invokes
> malloc() internally. The early simple malloc is initialized in board_f
> initf_malloc() call, which sets up the early simple malloc limit and
> offset pointer in global data. Currently, the initf_malloc() is called
> after fdtdec_setup(), which leads to malloc failure in fdtdec_setup()
> during the gzip decompression, because the early simple malloc is not
> initialized yet.
>
> Call initf_malloc() before fdtdec_setup() to assure fdtdec_setup() can
> use malloc() during gzip decompression of the DTs.
>
> The impact of this change on boot time is negligible, because the
> initf_malloc() only assigns two fields in global data.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  common/board_f.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not keen on reordering this list...

The offending call is inside uncompress_blob(), which already has a
non-malloc path - MULTI_DTB_FIT_USER_DEFINED_AREA with
MULTI_DTB_FIT_USER_DEF_ADDR. That is the pattern most boards using
compressed multi-DTB FIT already use, and it avoids early malloc
altogether. Could the BTT config not just switch to that and drop the
board-local initf_malloc() workaround at the same time?

Failing that, the per-board workaround in board/liebherr/btt/btt.c is
ugly but localised. If we really want a generic fix, I would rather
see uncompress_blob() call initf_malloc() itself when it needs the
heap, so the ordering constraint stays local to the code that needs
it. We would need to ensure that malloc() isn't then inited a second
time. We could always add a flag to gd->boardf, I suppose.

The reordering also means that malloc cannot be traced - the idea with
trace is that it is enabled as early as possible. Finally (that I can
think of), it means that early malloc can never be configured by the
devicetree (although that is not something we have needed yet).

Regards,
Simon
