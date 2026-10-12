Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D418DCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 994BA60665;
	Mon, 12 Oct 2026 14:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7I8fUPLTHJg; Mon, 12 Oct 2026 14:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D51C7605D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813764;
	b=OPlY8ZDe7j3uBFvj10taCjMly1L0Eny7U8fzL4MHfHNUObE8by4VMwHtACqApTKEwQQW
	 Bmlh93wvQMrr8jPCQ12ggJZqID0hJmQFHVJSbGCTX5DgRIF1B9MpojgKAkRUoecLXgMjZ
	 SwmNuAaN8PFCmN7OMHYzZwz9Rh/rUJw60WCt422r5GVo6LCqPjqtgAUNTNnz8Cs49ubpi
	 /4wDn290VZxwQ8+GdjzO3hyTy6bVN//39AmoMsd4yq65oJibz4o7NfQI9hInD9DMMRp8c
	 89PIt7v2sQMyE8xEl99wBlcjDUp9lTITGC5Y7RLkzV9lLpSB/RSvtouLcDYRTEc6wNQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/+mAFlrrxYNXfRmT+E0oDR5EBaIGPe7kBNcFCYlVfeQ=;
	b=jjzBrib9vQtfIjR1H5/jOHQWTPV6iXfmNWSgdtT4WA9zvKxrC3ZE1P6Vy8qFBSTrlckP
	 ihBscmYlsqHFcC9GlOrIBZRCFB53WMEhpzw1wmSgOPNi73rStDbfX+B7RPvjwhgsu1aAS
	 LcNgUpRCmYNxirWmH0uPWyEhCtr+/vxpPcWVm2P3C52SHT8klbkJt0Ckl7YH6UZ2ttSIr
	 JkoSfW2Ph8F/1cMZ8KIyT6+PeCfG5OoVHp026gFqAhk8fMy6eq8+ykVIroj+mxowBlcoT
	 WJ4MlPFgsHVIXkc/UcU/RCUA4zXF/SEWPlQ474NJF6CEPPbDoT8szmnvBLPvGCvk0ZQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813764;
	bh=/+mAFlrrxYNXfRmT+E0oDR5EBaIGPe7kBNcFCYlVfeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QaB1Uk9t7vQHUMeQ6C1523TDXAH9JxM51JbxaA7+CpNpYCacs3Gb1j6Ik2giZpj67
	 CMWyA5VShpbsLToaHh7JM5ziVmWl7JBMe/GCtI2R7eNhmQ2LJgjdk+Kb/lZ86GgX3H
	 +qsLSGGPjoQi249NiTHx0clPHlu18B2QbsGfnwmBKURASLjG3tzZg/6C1RMR4UIdk7
	 CxDJv/q6rc1TcgKQ3f5EZVkZexAIVzh1i+cuX7hpKdHjjHPZLdNOlF97nDnsAsWPUp
	 E0RSHavuiW8bc4AHHpucfgtfXnoI5dS/pkY1BuaiSRwJnXKA4HpclKVFIzr9olX1FQ
	 xobnZh7voKYrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D51C7605D5;
	Mon, 12 Oct 2026 14:02:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 283D32E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19CF1403EE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJrRxZN8Wnaj for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:02:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8EB6C403A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813761;
 b=X1pgXx3JuyKUnGYkD357DfrmL+HGeH4nw8PmqjPfSb5R71gdO8xW4b3+AlMnwxZomMWW
 uNLYESE2lNcCxUe75FMhGLNfn18E9sKcjb339s/fa3r4nc+SVNTe0Snx46Ioyfn3R9I5t
 H0xb22IJfe1ndzh06ECVVIgGGCo5QaZREmAv1+uXf15jcQu0YSQTtsHARreQNVERHNJlG
 jlQJ5dn/8LWzwpb0srE5YwJFQSeF1uVbo+hO3K2Xen31L3BX09+kKOUwaHngmJbnoHz26
 t451j4xQb4LMK85/m2ngywECt/fnQf9I4MUi1oDs2l76cdieteqAfKLPfyh5oqSfpNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=/+mAFlrrxYNXfRmT+E0oDR5EBaIGPe7kBNcFCYlVfeQ=;
 b=CCz82vzYvWiuCLA8KJwOxBRt4QVBJiH1offITwJP4NvYt2UV+BSRKK8v659Cn2MKMA9g
 +0NfYdt3nf2CyIUA1d/nTN7xvswtZ2QC6H/F4ZgU3vaDdJ2TVLU+PsNUwa0bmggEIfOv/
 yR5b8GQWaEzaCesmfkIg4PbpM/SC+nmG9Ce9XrCQKZ03pZ6Yq8iA3mZgxchVh/oSrQG6o
 jHZkY9NIEWPacWYBn/APi6Bl/tQGZBCbCV9hxW2Gv2miuX5HixfjCb7JDGpH4q0ehXvl7
 QZ8TkprEOnb+mefphs7F1HEFbsXd0pYObrzH0f1/gp1vGMmivzs3nEP6pKttB6hQ6NQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=iywYSUwH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=iywYSUwH
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8EB6C403A1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:02:40 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so983546a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813760; cv=none;
 d=google.com; s=arc-20260327;
 b=aqJg3ZkfDsijI1aW+X/2JvaaTCLaEsYfYZUICoZpl9ymeFwQJe3sv1A6IKhTUkhQnx
 LKwA444+WnJrYUCc8ggARzPTSaO/h0AwTFq6KlFW5Dv6Qq/nHAB1+OHSv0dpsU9IXLKx
 4IAnQZJbBlyVbBEQaJhCFkprdUp5Gd4Z51QW01MUNAfvADgHRnBGu1c1jgQa61vnSFno
 A62hwu70QWRfo0p/nJWXYoxuXUtBcoWTcJC/spk67ouNu1BuZi4yIdI3SrUe9AzQNl2o
 +fK+ljhZkTCI4tPudvG75yMtv8bTvR6aFXiGedLMtmCDZaNTQERfrO5urd9Phcq3S5ht
 8Ptw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/+mAFlrrxYNXfRmT+E0oDR5EBaIGPe7kBNcFCYlVfeQ=;
 fh=8hQXk2ZJkYA4l2TQ9z26QS5/4fWjHIWHYH+dDCjbogQ=;
 b=RTP6nqadGTC2WibMU11718BvF+qFEVh/qriA+9psFvDuH0kxEkbZmk1jF4kpl8ypsL
 hJCZiENgKw2uppRKyl6NY5qHaVn+nP1j+rScIAGDSxJs/qtnZnf8EAhIc58QPyVn7gkd
 h5q7bDm/dO4Gk46XQfBce6DiwxFG3v8gyyRufE2hqFytxYZk2OnZmYFYuKrypSZj4vij
 YI08oVlwhsXzINU4pl9amSKZhVqEcKhq9DOKHWrLXQo62Gi9qsRbdtdKbKwAxglzmJlh
 DzHAT+iCQCdMJlPKIPKbik4wHKkNjK15RpeC/1nyv+nE21FGR+N67AgVBGOBt+U+yGAe
 +kQg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813760; x=1792418560;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/+mAFlrrxYNXfRmT+E0oDR5EBaIGPe7kBNcFCYlVfeQ=;
 b=iywYSUwHx5s18kJp/YyG7xb/NYGGfCQ55lJ/oajv8/eBB7ke8873hS6XOuosZ+tCI1
 YQXbgn/DFR3H1btzLSF6AzPY2oZv42xCv/0vF+aO3b5+LEW8MmsJDTnNOCGznPcp9qpq
 7I3KndGBGYl1TKk+grEQHmD9g2uoJJf9BY/aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813760; x=1792418560;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/+mAFlrrxYNXfRmT+E0oDR5EBaIGPe7kBNcFCYlVfeQ=;
 b=DoMQX7OegAeeJ4CgloD7IokZ3GgdHKpw8MilJx/eSA774XvZ53K4yEX1w9/OEcxCqC
 U2sE38ErtIRs6bMPRXOmRCPlYH8NdHd0S6TG4cTnL5s5GETwnwwlvUC4xxZu3I34FdKm
 c4z3sZiAuLfrcLybBmthd9cgrMHg7jwZla1txFMCEDCVy+DGRxvAITMI/y59ekNdAgu9
 Sqljzl+3Cm6CL1RQIrTpU0CBq65Xl+H9mLo4L1c1xFFzNpUKSS9DBZjAUSYysP3sxOUj
 +1T+sumGLXmPbpdrFbON10d8k20qcGX4u/c6zt1FoIcwSVQtLuD60boQGkW/8wXExSRz
 E4pQ==
X-Gm-Message-State: AFq9FYJJcsn+nzoH1kOZlbSvCUfNq6wpLX/ZmUQZyL2mEU7dHuqPNvXt
 IABWzjzieCie67pQGsFaesiYMNVxAIVlJeMEuOADFU9Q+G6gu0a3kPhOlJJHUsGU3/YIBFBvh5+
 FjJUrPrJqIkm8hwRrk6Xjz9tJwd8jT2aCu/OQM008
X-Gm-Gg: AYBFou29EpndnpYsZIF94QZydwJ4XwaSZqKMZHcE9OgjqIxOqCCayWYpMhoFSCSR5oM
 dLcUuP7p03aKgpmfqyemvrd4IrIbBGb2d0rxpoeeisISDsFqhFCFhwoiOCCiaRUsQU4wWXQLcVY
 rLOx8DAGYyRcP1vUHg5CMSXrmoNrZbH/dcwyJMtrsC5MeV5skCC4lbfoWw9dcI1OQJfjEScrRMa
 27Vi5JHql7ZtpmHwzhCepdpacaPnx0qazPHyXWqTAJ/WkmOn9qCo/LYx3YgMtu9rGuZi0kSqiXg
 eVK2i1JU4QtUqZIOvc0ezLWnYHio0DecNd+8ypGzTYr4VUqdwMETGy+mLhw84uzxCg==
X-Received: by 2002:a17:90b:3145:b0:3ab:413:49ab with SMTP id
 98e67ed59e1d1-3ab3a9e00f7mr7866194a91.66.1791813760170; Mon, 12 Oct 2026
 07:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20261004-b4-framebuffer-stride-fix-v2-1-923af6708491@protonmail.com>
In-Reply-To: <20261004-b4-framebuffer-stride-fix-v2-1-923af6708491@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:02:11 +0100
X-Gm-Features: AclHuK_wk7JMPvwQ6kyDYqCUFPc-5yQsWFr753VbWKqf8PkwJqTzdwPum56xe6Q
Message-ID: <CAFLszTgk5JfhZJZ02GFQFGaXzR3GmAkt5oZ+kZHALNbCu6SWVA@mail.gmail.com>
Subject: Re: [PATCH v2] video: console: clear rows stride-aware in set_row
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
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

On 2026-10-04T19:47:24, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> video: console: clear rows stride-aware in set_row
>
> console_set_row() and console_set_row_2() clear a row with a single
> contiguous fill assuming line_length == xsize * pbytes. A stride-padded
> framebuffer inherited from a prior boot stage (e.g. via
> simple-framebuffer) breaks that assumption leaving stale pixels after
> scroll.
>
> Use video_fill_part() which already steps per scanline by
> line_length.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> drivers/video/console_normal.c | 26 +++-----------------------
>  drivers/video/console_rotate.c | 23 ++++-------------------
>  2 files changed, 7 insertions(+), 42 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
