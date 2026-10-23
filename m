Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC6606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QenbRD26;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PU1fXqsL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D9888128D;
	Fri, 23 Oct 2026 11:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QYEDRjauCWJU; Fri, 23 Oct 2026 11:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 113CC812B8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755465;
	b=QIubtEj/l9fWLhKJxQx1IT0dajB4ubtNHA/9udfqn1h14o9BD9GlkuFV5v416S++2NLo
	 w02MMtegZdX9Julwbqn+0+iMymUte7BWTLiVb2e1Yik/h5jq/isqpWPFdofyfrKzOlnWK
	 81zpyDFERNGcXTEGUr8edI21TprAcrRxiL62YZFjNatZ24uKJYnEg3ZKVpfzI7gnHRkzn
	 sVUJpd4LuFwhnWF3Ct2d10sLBoyku3hNAXOAzcA7Utrkb1aveOfiPm7xKwUFJvbe1m/Kd
	 QIu7Vs6kFdW8DuTx3YTrtSR8Do0Q+2ow+UqCTOBAnsAMmFndtIckCMO9+J55Wr+KGMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792755465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pZeBUYM0g7yCgIznCuHdzpnevXA6pd1S0w2wwTpsmyo=;
	b=YUWnWY1D3Pc0Ttbx14wAT+V2RKed1XS3bioOeDPc9xAABQa9+JtDZRwZHd8jtkUDKq8i
	 bgW27LdHjJz/ZnNj6XuvrcGOC5qPuBQIen6ZNRRph8nqmHvVwHyukIGuK1L1vkUe4zTl/
	 6GwK3W3fNQZLErVUCkrAC7nwVX20v61YLV6rQyV8ICsv13Ce9BbrB4p2tcA3qOEYeeFe7
	 BkSwnZ51yL3hxlrpM2orGSnEvWjax9Z3xLKAGLzx0Hl8WcWyvNQh158mT9xut0s66dppT
	 dOULtVx49+t1jO6U6p+AUjympnAoFRyvl6uTWNAtcMLYJiUGd3u3NvsnbTsmuowo5gg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792755465;
	bh=pZeBUYM0g7yCgIznCuHdzpnevXA6pd1S0w2wwTpsmyo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QenbRD26o6NRH8Hv21eJR6SpPp4C19zPw5Zl3t9hXdpHtxp3OP8UOcQ0h9hq5Mqe9
	 bjGiAe4Cfpz/kPJLiQuCktXL0k1uKdRc1Maqy19DrjI1aFbHODQgQ1SgEbX2IKB6gB
	 oDEbIxpObbfbOmG6uR8sCZ2dZwVPJbiqIHYPSq9H2RqwggYc3H0mJTz+x9CZ0fqngb
	 VPNwv2XaVCxcXpLZzfpiMuTJWVbcywE+OihVRWWvsJCgWUfW4UcWkeu8oCHXdoUjiU
	 H2TT0jeruT3QIvtrzqHbJheiQSn+vLQpr8VR7pBE1SaWGXSF+mZTQ5LBxVcGBTugPg
	 kBsD+AT/PsZeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 113CC812B8;
	Fri, 23 Oct 2026 11:37:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CCD9235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFA41606C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HrkuM1THkaRP for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:37:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 014CD60639
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792755461;
 b=qgxHkMqPZhRF5EB+RdemmJKVCPmCfnhFXhWRwvt5W7FrFI7kT6zkRFpX06oeNFycq2OG
 qWh7PdMzBOgD9eAvHG0vy3Fq6JvbctGIoCNJttkwkKo+ESbz82CzYeNMGUrsTk2+BJoGe
 WgoEEXy6AD567XONex/AO+qt7tu69KOMmlRf0E6du+OmCpC7zM36sZyYEN8kb2Tklxde4
 HcLgIcbsifR7qeS7YPQfGwPNVOXR+Sm0038iFtxEDeRWWsEyimn4RCgPENkOQ5Jg1ifuq
 b7aYl+ol2RGKUpIngTuHC2yIk3/R00J+aY/jSxK4idHbwf3MnFP9FCUTbK6Gqq0DONg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792755461;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=pZeBUYM0g7yCgIznCuHdzpnevXA6pd1S0w2wwTpsmyo=;
 b=gkqgWl+x4oGVg68Tz+gBayTPoM7PNtfyzpgTiXiJGXpqgVrAI7IXkxK7n2tQ+twVf7EH
 N5+H+pWoEAjAppf/DD5kWVuSNnQhipFHs6QwCFU2R2xtuJhH6WUS2AV7jl2C4Z2q2f1jc
 vdEfvK298QL+HtsV9XtU5fjmIC3TkhPERXNurpRn0CtLe+YWFFaqC2hSE8x4HDCJA5p5r
 aLf4s8z+QjvVrBWGfsFVel5Nz9JiGPTY8llhIp1PNrBJ/MIxDCj2JuIrNv0Jo6I310D0h
 Il1aqAryCsDRUovcotLS4NVV+336gYRkZsMkT6Y/YDEEOsnLlW5oBpKdwB2NtKE+gjA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PU1fXqsL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PU1fXqsL
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 014CD60639
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:37:40 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so960446a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755459; cv=none;
 d=google.com; s=arc-20260327;
 b=GD1TRNUYxmuj6gWz7jDLvjKtEnUpUCPFKWfeJ4MRI40F3pRJcb1xgjh2/HA9pCmvDl
 iCNaxbm7NKh4BlO2fVeIzL7tPWvTXlRA/ziN2Qqeba8b7eMnwBjrOh1dh9Pu7qWibMlS
 39ZUnHep7Ak9zoOXLrV8twLj4W7Z30zIpUGyMXTb2t00eXWz3T4WtwhN+Agxt/dfu2Fq
 bcuiZZEItpDb/VHmirMk6z+JFQRHlE/AK9xbhzHtYPzM82ZvtI7L/un7KLtXB586HmW0
 tusGnXaX1yTZKdrBG9m0Bi3NoN0XDkoaqpWIIwbWB7RVgdircv4aREjqPkZlNKCZdrps
 DXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=pZeBUYM0g7yCgIznCuHdzpnevXA6pd1S0w2wwTpsmyo=;
 fh=buEZSn2lZd9cMy07plv2QQ2XjDvYzEA/85mgmkrnnkI=;
 b=Wf4KzREqB8n4zjL75bVEG5iAfB+Y+Jk7XG6q7BSfPMQbrD2lGXG+tYNmVLS1SxrvJ7
 rvcMutBOv4X8rv8OGYj+8S/OVpFDt3IUz7xjQn5DhuYbA+Q7LtK44DzTUN8kle3NddQW
 1jQJM64uD3Qw7v+K6Gi/1B6Hk+jbHw9PzagikeZfI8l/ysdozB7iFtUFoEUgKc/OzgW0
 cds8lFprpWeWH8pdrO/XfkOoEIyCkZ0iaCAylneAPxe0vSErV3S+Tpfptc2LMOQ5U7Sl
 zRSvQbskyXMUGDZ9PZmKheHe3buPTqYE4AsGR0fV3s2tRvLrHMcvEguJfMd0CPOELvMl
 QsdQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792755459; x=1793360259;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pZeBUYM0g7yCgIznCuHdzpnevXA6pd1S0w2wwTpsmyo=;
 b=PU1fXqsLc7t0VWiZMLx+SwovM+sD11G454/QZup8UHuSjGAoiSQoXYAkFxWGSuD3wX
 z38rqQhPnF4u8JXsOhQd2QUzLI0rBv1nHShv0rbwLpFlz6B/sWpnkrTqg4emi7UrVTI3
 pwD8xovcjzv0iUwzfkDT1oa9g/7Gc6h0CjyIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755459; x=1793360259;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pZeBUYM0g7yCgIznCuHdzpnevXA6pd1S0w2wwTpsmyo=;
 b=rMirvQp8DWc9jqVA5NkCjirYWslbeGwSGt1Xgph9DujLTv+wSq1FRhyQUZv0x7Fwko
 N8EfETe1ulV+k72GUy9qtAY9Z1kTxqR1OH0aHSVuqb/dE6B1a/Eh9ItdhoUk+pCgsQ8R
 Sry7GNaRGM4i7TUd7/euRjAPxBThBzqmLfszo0EqXgjhjj2ueGqn87UEyKLirKGl/Z0F
 UMEttkxPmJDnWPl7RcLJiUpWEGiLhkAvCxcP57luwdT65S/SEaks0S8YjSooSwCTnwWJ
 4xjqc1r6QC4ObuF3Zrp+/tItvTpYA4+eEoUhGSSOFI2P8uCEqspabL+Mtt2JguZ2HjSG
 bFtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTXZtrtcJS+SF8j5i8Q4y0iNX6so4SHSOIjBSh/kmOQfTtl6gOb1ZCAfJ/1NyfAEokXlTlxsY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWu8aACmQk+j8N8RK0DQDWP5mKOSWO2oaX3pBo30c6w5WosOVb
 h4w/GYpSVMliv0EaZ+FrxK8UcToL0Jcr4wB+9bYjEUEQ9R4FZU13o06DVGIazxFRAncHJV8DNkp
 97NK6YtRRNDr062WQfcmm5BGbnRMqpSZX9RMaPII5
X-Gm-Gg: AYBFou1l26W7rYJUa1DJkXALjbbjo8T4V05PqM1lgukEAM6pntpmrE/tVTToOe5cqwY
 weSxz5ZiB1PWZAt4+hgS8GX64BJxwmxqVvIw5OlSk/l5RfiGHA6WnCwoB0oHxxvxUI/FGF//3bd
 L7cpAXZ+lR6Gs8WxuAPIgymKe7VhTiMM2wNwd0cfSen/YYAdiruBkEof8RvwHGj25q5RKPqETwh
 U1cm9ygekEmrk4QZf0bq5S8XUfbH6um2N+4b06mHL+QTNaX250yKJn+UlBSVUVlicSjR4FIiglp
 SpojXgSWVksxS0M+fvr0n6RCQu6V2e+Rp0ASqa/lUQ85xHtSrnYG1Cf6FCwC6NmjuU/5X5k4fkj
 AnrpfS2kCj+WCIUqHwQ7asjmCC0eJ4PAdW78=
X-Received: by 2002:aa7:df08:0:b0:6b4:30f5:3a14 with SMTP id
 4fb4d7f45d1cf-6b432bdb09fmr2188413a12.31.1792755458729; Fri, 23 Oct 2026
 04:37:38 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 07:37:35 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 12:30:50 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1df57ba95b7802357450a76812dbc410390bd138.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
 <1df57ba95b7802357450a76812dbc410390bd138.1792591479.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 07:37:35 -0400
X-Gm-Features: AclHuK-brPXxzyxgpR9U_k8Ks_Vl6lUW0VFe86bcRemrqu5it6jxlaQpG0WrqZU
Message-ID: <CAFLszTjcyREXm0zoKvbWsUrgwwSkV_q2KH+U2hLx+w6PcqLKkw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] boot: build the imagemap pointers only when
 enabled
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Vincent Jardin <vjardin@free.fr>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21T14:08:59, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: build the imagemap pointers only when enabled
>
> struct bootm_headers and struct bootm_info carry an imagemap pointer
> whatever the configuration, so every board pays for it with the feature
> off, and each use site has to spell out an IS_ENABLED() test beside the
> NULL check.
>
> Compile the two fields under CONFIG_IMAGEMAP and reach them through
> bootm_imagemap(), bootm_set_imagemap(), bootm_info_imagemap() and
> bootm_info_set_imagemap(), which fold to NULL and to nothing when it
> is off.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/bootm.c     | 44 ++++++++++++++++++++++++++++----------------
>  boot/image-fit.c | 13 +++++++------
>  include/bootm.h  | 31 +++++++++++++++++++++++++++++++
>  include/image.h  | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 97 insertions(+), 22 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
