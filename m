Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D213BC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0338812E3;
	Fri, 14 Aug 2026 22:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m9cr7jnAzh7N; Fri, 14 Aug 2026 22:55:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 070D9812B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786748149;
	bh=G90ieMTuXtbCC3atXl1yk09D1vr9OYtAhSIxgyn/83o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d3VWLCv5AFydmNhGNUkJGXvZrHorT3G3mPcXCAzZZBHIQyiZRLp5qQ+j1TLs9YfEX
	 C617ubJpjenTvOFMdLt0ToL/tK35RdELz1fxqyUVlC3bhXnx+Aj4jvMYhqv3Hs+d/5
	 CuIv+55nz0cUNhZ/Kccwfd83wu86wYr0vlj8rKlkc7ymtZS4zF2Lgm+AiAtoot9VkZ
	 4xcTUDih4iG6l/juZqcvok8OX3E8eLp6SqRgZxHo+37ZwJiRbhZ1hFuDVZxb/Tq8tp
	 lwfRDn8jhcJGWDQb5oKP2qcpNy4ILIaukZ6ODLzD5PVlBstwelmcdmXQxMI/fMgQE0
	 y0vtYta5o8TIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 070D9812B2;
	Fri, 14 Aug 2026 22:55:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A6882BB
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0808C40C9D
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J0HvhL3xElvo for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:55:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0A73E40C78
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A73E40C78
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=IBl1WfGI
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A73E40C78
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:55:46 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so171169766b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786748145; cv=none;
 d=google.com; s=arc-20260327;
 b=aal7/sAvp+QFg4GbKs3I1fwaWNbkjE5GgAtUDS0q5LZz7oRoKTXUEThkT1CTyM8GZa
 e7FRHJ4wVnWPAYBzokeQw66IhPfwStkLWubsQ/yewUspYyUkxDCVlSV0gkqWPCZE2Irm
 IwrAHEaRWQ1gwEYEJ+6U5wPzYj2VufdPc5SLvGVkD5TEqxJorQg8/QLhQDMTC+JEonYV
 cZA+MP8FegvumJ90Igul501nHjRmqgbegsrqNqgSvUwDSRTz7hHqAw7sfwXmcnBrORUY
 bFS1snUfiy9dzCmBl8EDnuV9bIs/S+TJYfchBV+HatWKeo7jFNONZ3xw0fwmBhVkqROa
 OBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=G90ieMTuXtbCC3atXl1yk09D1vr9OYtAhSIxgyn/83o=;
 fh=ykfKS/haxsKhjCOFJ8eab7SykjDB2XUE4xn7bagk86c=;
 b=ZoC9UuCOxmResxlPpzzn1xdpNAiFnZI4ca4qGYPfmuroDr6gsSnK5WvxeRncnCYYC9
 kwVLCpjaZp5XRzlt/BfAmYLOYoPqEyBgifEeVfFdQ0nnhXWc+JOD4NzFS1cUE3+D5hDt
 yIZGN2bA6Nl0jPum3Exv/AJOc8f9sxZz+wjHcV1Y3/fkOu5zwE0mo6/301q5NwJsbDGJ
 lo8x+dh2ded81QU7UV4u89WeFnT+AcA++7KhgqqtmJxatZX7ejZDy0LQjR1EqS1tBmkF
 YRDCUrZaTpyFetlnZRGrCaBUNKUx9K6m++/DF9Zw2UBYPIzdWABJg3ETZu3bHNGciXq4
 j94w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786748145; x=1787352945;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G90ieMTuXtbCC3atXl1yk09D1vr9OYtAhSIxgyn/83o=;
 b=IBl1WfGIADeLP5pTOdWKWWlM/WGutp1PB9n3vVbLVwq09VLSgVL0mKm1Jj7MbYgxUn
 hDb3FNCGPGDqkVFiEIzfAyRChz++KThwWrK8/WCqDKtJXDPmj34fz4hgFJu/C+i3HNGZ
 Ht5cNBzOXyMt6xgvWghmBgzNSn1ZrQGKp1ukw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786748145; x=1787352945;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G90ieMTuXtbCC3atXl1yk09D1vr9OYtAhSIxgyn/83o=;
 b=Uxg/LPzoDLN6cpn3iup98z7Z4+HRSGqJ0LtteyWODX0AZH2578p31tH8GW9KjUpita
 wXuxwxiM+qsFH8vEs69vjEgcWGp/FpyNsexocIaK6qvSBaGRFSJD9zw2h0WrLbXZwIqf
 t5G5G6ZdqvEfR14TQkJ1NX1RJtnfRnF5LUMohQe4iPwg0VaGFavQOLq0veAo7y9IWLiz
 Nwjg2yFrcFQOJFDcgzslzMBf/nUR387ju/t2CFij9hiiCM5UOBh0t/A2g3m7wTftgxlq
 CmN4LMrDvhMNObrbOa7RUunqKbZXyTG958S9It2t4oB/WFHs7oLLlcySNpezoMaqzciD
 t3RQ==
X-Gm-Message-State: AOJu0Yze8A109n58guRirNKTj62Zegjbt1ksxJMyU0Ml4U0+VYdyhKD2
 F+M8F9sm13FB5X07Ty1bmIo9vvqtpF17J82YY4JMOmom1ZxSrimYQ3OJtdcBfgySJILenudPzni
 KPzrBjOPIFV8bniBpZjIAQQwAVPhaVeY1OP4N4h+QvVCbsZUziZs=
X-Gm-Gg: AR+sD10l+W35uTk6W7GhXm9LS/28lGRiwqAfm7mCFtI29DDizsZUisXBd3M1dlpprkD
 gHN86pAQ9oTiB8+6M6OUXuyYXYW6wvLjg3Y3E9oL6+HMeCx9nIJ8Y4HLc1o97cjorjYk4KksJAK
 ujOkiin6vmT0BcuYaYKk1XIGvP2U7ukvcZn27gqGIiOM64PeQNiqXMMl8CA9kNwt7duOsNwvHi1
 Aj4UwzVIS3h1cQJlsdg9FMmEo9dAGvCW4+4+MYaXILJTTeVVanQjmjQoauzgmLGXwcD9KmtRghb
 4k0G9VvMk2FXUvInASiarHgjRldGqBKgwKtlV2DSUFo=
X-Received: by 2002:a17:906:ee8d:b0:c21:792:8257 with SMTP id
 a640c23a62f3a-c212a1d6bd0mr389260666b.15.1786748144779; Fri, 14 Aug 2026
 15:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-rinta-watchdog-gettime-v2-0-d8a5a7aa0df7@nokia.com>
In-Reply-To: <20260812-rinta-watchdog-gettime-v2-0-d8a5a7aa0df7@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:55:33 -0600
X-Gm-Features: AUfX_mxA4hAXWLdv6knLum01mMhDECUROJCsPxsIsEF85WZQOVBTi_JMWbT7W_Q
Message-ID: <CAFLszThdqj8hPL82RKe5secs1_Vg0N1fSNRcwBX0RuhfUCttzQ@mail.gmail.com>
Subject: Re: [RESEND,v2,0/5] watchdog: report effective timeout
To: juuso.rinta@nokia.com
Cc: u-boot@lists.u-boot-project.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Juuso,

On 2026-08-12T09:48:39, Juuso Rinta <juuso.rinta@nokia.com> wrote:

> The hardware still performs the actual clamping; max_timeout_ms only
> lets the uclass report the effective value in the start-path print.

Since the uclass now knows both the requested value and the
driver-reported maximum, would it be cleaner to have the uclass clamp
timeout_ms before calling ops->start(), rather than reporting a value
the driver may or may not honour? The sandbox driver has had to grow
its own clamp in patch 4 purely so the print path is testable. If the
uclass clamped, real drivers would never see an out-of-range value and
the sandbox change in patch 4 would not be needed. What do you think?

Regards,
Simon
