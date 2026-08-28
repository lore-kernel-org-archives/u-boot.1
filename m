Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86B0C61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 18:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5812880ECD;
	Fri, 28 Aug 2026 18:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LLK-VDsbjhF; Fri, 28 Aug 2026 18:07:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787940467;
	bh=4CBlGkpiM6ITNjeTAR6DvUXXWyPk0bCsbhLC2hqE/is=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HeqkfTkUw7zWqPxze8NYlwe0TWbrbHMOkKnk3DzoYtk2dsAiPI3s52J648QFgByzl
	 h2iTyu/D7NS3tSbJGfQFZ+W/oo1dvOz2u/mNPgV7DDm8OK3bkw5YQt9RPvb/T3RJhy
	 867qWY6Zoak8znlkXdTE6VezXez2DQ/v1750ykBiBxqBd56jI6KfZt7c9Xej8ucq0F
	 5gvdk2WS5L38zEA87GH2KEFWErHhv4GL1zbVY0b35Qt2FbsFonLEyQexWFA5PA8s+a
	 NOMFeLI0yr+mBAFUysfjIkULdwyCGV2dCTcKn9QMfqnQOR9bva3rjoHxj0X5+dBct1
	 d4jDxu0Q2mgaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6976180EC8;
	Fri, 28 Aug 2026 18:07:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0356923E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9A9D60679
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n8vyOn0VcRAa for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 18:07:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dHl1kRe5
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 277636060E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 18:07:44 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4b3a61bdf22so551474b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787940463; x=1788545263;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4CBlGkpiM6ITNjeTAR6DvUXXWyPk0bCsbhLC2hqE/is=;
 b=dHl1kRe5xwqVRxAgk6jYH3IIcBhsKlsPzh4C4FRbjRY5xBMBbpriApbdQGhpK6se58
 WB3wGQblhSsCgTci5cUQ2FF43ekbKGi7oX5PpB0kqSTd/Qk1q7ABW4XM1lROyqiU9kdM
 eIgY2gxJfKEnyQjIKLQTWl8sqVz6QjPQW62Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787940463; x=1788545263;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4CBlGkpiM6ITNjeTAR6DvUXXWyPk0bCsbhLC2hqE/is=;
 b=apEp1iaMAFEFwOWIHvwbeOHnJnxNndrxxfnzOAXLAYX850gtOdinQmBvWYPGuObzzE
 dBnffTlFPfgoE0IVLtBtr5zU46OMYNA1XhB/tS59PaLKSEQjeIr7ykl9kxMnPmpojH42
 RLwvwNV33PUS1AATR2JsbeIncSg1Nk67mbm9Z1NvddLcugjM+wSqFyntr+Z8adfiiaaQ
 tm+u4NnSesF9t2DrJhcrZFiIQXzLaMxQ2TIQuCEVfwNApQfviRrFS0oZI9uajpHwyXol
 B+Jg/Tk2/UcPQ+J6wdTKTakfGSZE2OYXOVZAkLXeidm/bM2dkmgS00klQ8NtdpaZAlqJ
 ZnXQ==
X-Gm-Message-State: AFuF++mC2KFaCm+IpAx+fFyI02mOE6FvTJcI++JynY/Vb1TzHDPRvb46
 Hu23I9arIdAyuUUlSBV0eKRcTtS5MFVTM3/JbrlACGs116ufB/3vJTaRY9NsJ9f8JEs=
X-Gm-Gg: AR+sD13nSZuHf61i5mHTZuWTmNMtTJqmTpZFOYPyCfbxrqHzXy4x3iNSYpQgJ/bVLGZ
 OdGjLIjcHeGmXhJFUomEBHxoKkb1FN2KFuTxS0KbSQprrHVt+alOjJWY27lcj+IW4mkI/mNqhai
 Niuj+kDqT4zINoy09xrPv3pqVgEsZPNHUF9Gp8KusP3isPUrYHxlnGd9gc3tPbeFAwwEnADnKiX
 FIiOSBJouWyg0pWo3FNAUQskaaTZpqbd7NwmsSUn6zp8h1eUltr2jjdISi00SvosWRSzeLCvCqd
 0mteEvha4mmZW/Jug/J80l9i4eZcKvWyLLLQsnv3D48oNz2YbYfdZkp+2NHDjy7AA7FlOrHg51b
 Gdiu9Sbeb6TzZMeCDQZpR5Ol9zyLp5k0sK8uKti8Iq9U7AzKKcg69EFMMJBoUmOCZfeQIn1reK6
 ZW3i+3ugORByi4LZjFDxEKV7tISDtGZFnfxXiivejQ9FEKALtihNwtpHO5XTuwTGbepbfjYd7cn
 rzYj8bS1pWWhf95pgh20d5rMaG688YSzvcuO475oUfQy5ryd2p9Fww/qjSzjDDgYNnLpBw8B2+v
 yYm8/+dv
X-Received: by 2002:a05:6808:5091:b0:4b2:8d89:69d4 with SMTP id
 5614622812f47-4b39823886fmr9738854b6e.13.1787940463508; 
 Fri, 28 Aug 2026 11:07:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b3a1995f2fsm1834283b6e.11.2026.08.28.11.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 11:07:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Anshul Dalal <anshuld@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
References: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
Subject: Re: [PATCH v3] fdt: Fix phandles not copying when using templates
Message-Id: <178794046243.240063.5020532060520400474.b4-ty@konsulko.com>
Date: Fri, 28 Aug 2026 12:07:42 -0600
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

On Wed, 29 Jul 2026 15:54:57 +0530, Anshul Dalal wrote:

> The phandles used inside a template are not copied to the node inserting
> the template, leading to a missing phandle error.
> 
> The following example can be used to reproduce the issue:
> 
> &binman {
>   some_template: template-0 {
>     ti-secure-rom {
>       content = <&some_data>;
>       keyfile = "some_key";
>     };
>     some_data: blob-ext {
>       optional;
>     };
>   };
>   output-bin {
>     insert-template = <&some_template>;
>   };
> };
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] fdt: Fix phandles not copying when using templates
      commit: b8d9223a454374681bf7d0d4384bb101be92110d
-- 
Tom


