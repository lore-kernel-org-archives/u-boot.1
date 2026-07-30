Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ABAC54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 08:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1185280D10;
	Thu, 30 Jul 2026 08:41:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8PBSZ8Q-GtVH; Thu, 30 Jul 2026 08:41:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F3A380C43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785400907;
	bh=H9ClqW4WxacyriRrNpeu79ggLgXNFn909X/n+nAQpwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TrdHJ3PgZzm15MwEbr4ZOOHpHZLS4hOcZStuofFaDXGt8EWOvNaG/DAPgaPQuHw6M
	 wEdC53iMeGeloQ7lLXa49uCRqKcIyRO5QOKgoPlGkO9EyjYfrLHG+YNlDoSS+VsYV/
	 i1gPJyIHqYlhemYB0SA9GFtfEzkU1ep6lCDt0tzkRNAGGXaRnNGfR6Odzg1KqYk3Px
	 jiTTjJZCaJELoprjVCDgISVNUO7H/MyYQKKeCBc8eRNl6rvYzoTqwJt6cYBIJDcytn
	 +VqT8MOukhpeo3hm5Y8QhaeATvOAbud85oTL28arJOKgIQcndQ1nec5mEOQ5RI747V
	 PcxamkSG1gdlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F3A380C43;
	Thu, 30 Jul 2026 08:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94809194
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8689C40904
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PAD5Kxfeuc7b for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 08:41:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AE5374064B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE5374064B
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE5374064B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:41:44 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-80cebd41372so28526187b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785400903; cv=none;
 d=google.com; s=arc-20260327;
 b=nAzeZsD2j7fGhioVlqXZ7hX9tYln21Q9/uvEecAYYTnoO9rPA5inUAygIgSOrStvSA
 2jxD9JBGWxeEbrNdpgeDJs7YGHJt8LNBW8vL8mOKzsvGwK6iE34MZBVcake5sIJu+gm9
 wxWnQscdQtvxCDgxdgwhcFfe/QwRuECkb1ykWqUeIK+NPClT/cNlF0Bpzr9aiAzE8Gsn
 EjBHIkk6ClLXSl5WJNfE8g6tZlSJX3LTNrMsdsnX679cgCf9lFMhuWwdspHmupj8z1Er
 8Ni0enuhILGJLXDJD8+NDP6YnyFrcR+JtTcMFmbK86T+FbzoSE1fu9BOxmT+OiXETJpi
 fCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H9ClqW4WxacyriRrNpeu79ggLgXNFn909X/n+nAQpwU=;
 fh=wLVR9j9PsWmfZqlK17unNjhvl3a2CWiRKFd4/I4kTgM=;
 b=B5lRzyLBDD7wwjVEKPAJuWEAYXHAVl51xF1vCuNNozu6jEiGQV+earXU+Xl9XpgLrN
 aZTzar73XgU+2fLVXUGGX1HLX5uVNo3es4sEi5u6MeL/aA1JP1FOdZwa2CBNY4Xn7Hmn
 85obEkhixv+W/PR9xARevBT8FMq0YcfP6woJDjjAYX5ZRxKNtHygX96TEEZtQViaaQbd
 MTmdD6WSfIDbSP1mOaQyUeHJ5x4q+cVJhqQUS12KTba1bikxDZ4tRquVtI5Zwmg37d+V
 lDSF5dG1ZnJ74E6xA0cIg8QFleV+Pehur7+/hiIIR+sE1fjEbOFiM+w6+4Pum7I9F96T
 NyPg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785400903; x=1786005703;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H9ClqW4WxacyriRrNpeu79ggLgXNFn909X/n+nAQpwU=;
 b=GCv+MHNt+RHR3GqaBYmQM7O6Mt88mo1KUEpuYLcOhCkZAC1hRVrWuQLn4sqOjcLy77
 GykOVr08oTr3Ixr0lKwpr6XkdFxEWBDAP84lz7g5ayotfRUJvdaY2HL0E4zOXb3/kAV0
 jeG/fM+PzBx36S8k//kIfX+BDRtUc2Qpkot3YwvkRCu8NCAFYUYQBAb1Pq4v7Fzmk3Ob
 D4qWrcIQl8ZgJqL45zNlwPl7H/mv5FqxuHbKpDPAgaZArKSRjo3k4oXE6ndmr61kL05j
 NzbAMnB11mtCqe8WZ9Hr+J2tpp5TNRq1e4yiY2vYi8UNq5LZd09vXmQXIshMZ+ro/ydV
 q//w==
X-Gm-Message-State: AOJu0YwWaHTi2+CsOtMmqM1VxjIko7MJs3lhMRGZXE8YeIFBcpg9sWAh
 kizDS8mR5CKGdWmsEGB06Pw5+bSJgzUtIiG6NpXDZaiUHLPm/4QgUc/8I0IYBUCpC0AgnD6/oq4
 bMXgDc0MlduOHjvgFZNXAwkY/WgPpGZOwJZE+95OdpQ==
X-Gm-Gg: AR+sD10+SUYuWlxi564qwRVznjUKXEatATaXEIGak391D1sumID+7aiZ+h4QepGp5uB
 7j4Ehma7YyALTYSQ++nYK10SmKfOr1BpaiS4cy72VzgmtXg64FNYZbiPeDC5cILKlXlbZMDtgMN
 kYWFzqne9YHL0Pa00dMTUL5bagA7d/0dtBXK8qpKQpSuMwoYA6mv7TWKcO3IYyvjMyJFsacWIeT
 bT1fcP5yKYk+YRNgrzGuCFv6eWfpLvXc3NXq4P2bBeJ/4VslUzza/C9Us6dNtT1yGnT2KZXeXU/
 s+Yf1Z1FBx60tOvHAiwD/hvUtmwn+M+VWPRuukMUDSONwuMSQOT+ifM8XnvuM2iZzoYZFs73NKD
 +zPDTEnfdqhmGrqM0a+hSUQVelDjKno+9VRmCnOWltVn6POS1bxRvgTc3piiTHZKEzT98UKOoED
 2w4/txQOZ/cYcbzCpNDFxDOjB8JR0TpVawYcwCygrLTAcUhf7wqFHhpmBUDta1i0PWVaTlbTo+o
 noKNjtJfnO8GIpKwqVrcGfX7IlNLvmBplj1ak/MmiwsiIcMfwQTs9380yT+xK5xyPB7LaZCWiuR
 8jj5Lnu1hoofL20IkinrF/9SgaRzvz8FZ6QzHH6+DwhYRfosR7tRWUaIwXbG303TT+hUXzo0k2s
 ixfU4vtetP0e2k0RdKbnFKayXKTCI6S2ipFR1BB/8jYh009SqlUggtTCALCoAcuFgQ11vPjtM2w
 /D
X-Received: by 2002:a05:690c:88f:b0:81e:c510:caf9 with SMTP id
 00721157ae682-81fb8b57a93mr12831587b3.65.1785400903173; Thu, 30 Jul 2026
 01:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
 <20260729-tpm-trunc-resp-v4-2-5dd1a634ea4d@byteray.co.uk>
In-Reply-To: <20260729-tpm-trunc-resp-v4-2-5dd1a634ea4d@byteray.co.uk>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jul 2026 11:41:06 +0300
X-Gm-Features: AUfX_mx0mO8Ujb-NQCHL8Gkzm-dv2w96MU1oajDwiiHFqTRWD_aQxX4vPkXhMQE
Message-ID: <CAC_iWjLmnQoaNVqpUd2UsbDSkXh3AUKn5PCT8dT4hPCy6V5RAQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] test: tpm: check malformed capability and OIAP
 responses are rejected
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785400903; x=1786005703;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H9ClqW4WxacyriRrNpeu79ggLgXNFn909X/n+nAQpwU=;
 b=WU6kwrz8cSmqc7LrXvTEkfHWAyP/57bdNGNDxXmovfIWSKpz33l57BThmt1vDqPVkC
 EyLPgZIMgIjHN5DrD2J74eWM9GdHlmLB3JBhWUIGjx6YP3dAuM3cFDZrNQErRyollc2Z
 g9x5S7MZR5qnJaQOKuXkgaduwII/KZdjszpmIT6aKDWgaJ9ZjLAWClmmXkN0ZI9Qn5eL
 8xgaTPf/sK3X5DdcMB7rqcsW5KrHLnueR8uc+pEsdZyQF1H6F69FWIFn8UdsuPsUYptp
 Xia6afNxZ+Qvv8TEoZWUDLrojfqhBMec82v+uFlqOTDGEOVkfPTKa2n8ZtKBC6Inkl/0
 q7eQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WU6kwrz8
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

This generally looks ok

> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 4f5082f2234..648dfa2aec8 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -43,6 +43,16 @@ struct udevice;
>  #define TPM2_CAP_PCRS 0x00000005U
>  #define TPM2_CAP_TPM_PROPERTIES 0x00000006U
>
> +/*
> + * Sandbox emulator test hooks: a TPM2_GetCapability for these properties makes
> + * the emulated TPM reply with, respectively, a header-only response and one
> + * advertising more property data than a single-property request can hold. They
> + * let tests drive the response parser with a reply shorter or longer than the
> + * data it should carry, as a tampered or faulty TPM on the bus could.
> + */
> +#define TPM2_PT_SANDBOX_SHORT_RESPONSE 0x00ffffff
> +#define TPM2_PT_SANDBOX_LONG_RESPONSE  0x00fffffe

Move these to some sandbox TPM related header only.
This file is trying to define the common parts across TPMs

[...]


With the change above

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks
/Ilias
