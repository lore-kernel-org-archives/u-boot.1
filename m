Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A8F60A6F55
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U33CMEMQ;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=m9Yl3+sh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 255DB6080C;
	Tue,  3 Nov 2026 14:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9IvXTBoD-UBB; Tue,  3 Nov 2026 14:48:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4C71E60873
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717290;
	b=kgxpghBUDESQ6rmDv8q8guemF+P5bdx71ZpYKPhekobHfm2iUGyiZJLaN0mdjAHmhwRX
	 C9DuWVcQZzQ33S0XIMLPLxiKyZMnJRdvJZdxDE6MP8cTcBZWQlFW+3CsUilsSVRPQJrlJ
	 AZkWfkoAfJ2S3q53ehHQ5gtiLTbbmW4dXCrBP6yduEoqYNfXOi3aPH2YT95xDrzplVLQ9
	 Z8IdV6o1Xlk5SOeVFpyobP/rWijq1sORbodmxl4AJd0Ryrk3gKUfHlNH/NpCXMrUaJDes
	 GeGzRFpYRbbis6P7k4xjT2D0dbDNouHW4U1Suaqa9hMqPxkbWlxUu0ujN2wKzCZkLeA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PWk/fKuGwIH0F1Cfv9Kjx9AF6lNpKGkdvCiqhHnWnik=;
	b=LI8LVGzfe0OE+fdTGiDWsofMdKUQhuH7Hc3ZIbB8oG9Nib6cW2fzsj3Es7WDfsCZWfq8
	 4m1ArBrSyxs76baWPYzIzKdB3HdRu/g9TNmjLEyFNBSYwQQuhprK/atW8uHXKR7fhO40Z
	 Oi7w69wnirNz214BDOuwS3z1o3OefY3+nQRTtFFkfiYy3MwAtjtkmj1jrdHAjSqiFLabU
	 St9RERZRCm6MM49SBcZuGrC8sKv7330i0DsHhKxRn6zUDKM8I6jvCynE7hF3vkMJry3WS
	 HHcpuKAKYPswk+AwAXLiWgW+rLmmSGbPc6XoqcW2fjDAYsJkZp7i8hdRxnwLnmv4paQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793717290;
	bh=PWk/fKuGwIH0F1Cfv9Kjx9AF6lNpKGkdvCiqhHnWnik=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U33CMEMQ6SYhzQWnITEp8RXsYexhRe7MoGbX1F7dSISn7uWO9w+dycr2+wgMAcNmW
	 gsu/K8MbCpDZ+lLrtkeSZNYodS6k6uiZ8ds+WGRq1pmRy301M70CfZqC1yQat1mdya
	 bGiKBznK/FvGu3h+8fdleq6Ko2JXSWaFQFoWS0OI76oBL5gBdpIokFcU3F/xKjQK79
	 pk24pmW745qCBlmW7SmcZS2/uWbMbB7m8O+SPKXPCCK8IzTmmOdXoCHLW94Uz3t/Pa
	 1BDQA3jvlGzoVJ8xqGo6waBWCmgmAxB+Zc5g44JlIoWQotoUtoC56KSdSjEYA5YZeQ
	 gi6v6PoYTkKVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C71E60873;
	Tue,  3 Nov 2026 14:48:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7507A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A34540070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9aafloI2OmjQ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9769440068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717286;
 b=IJSxxcV87z470uwT7C52CWGsVpRJGY1324kejK872pNrl1avnp9xx6h6EHhfPqP3iYWl
 zOQH6gvjm0H53rzyIGqW2JYvakccYLpC/OeKkOLbNzycPa1Gykr7/QRL/gqFaSW5JK5PZ
 NznFd/zgbNKyxHHnaa5ieBlEXiPlzjoTzXv4uMv7eb6t6GoKbpzmOfenwTeuJ/tXQoCpP
 A5D/Ws5bKpxatZDfMUu1G3oVHKcLWjF5VCF0CczVZzoekNn1ZYqWIsR7/Vl+5FoLRMmOG
 7pId5cD3Tpl05WKYgGWwbP3XpmfC/OFbd3qhZYMtuRhuz3FE8LZCFHxXv98Lq3NJ45g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793717286;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=PWk/fKuGwIH0F1Cfv9Kjx9AF6lNpKGkdvCiqhHnWnik=;
 b=G+Cz2u243Xmi/VLf5IRicJCGbtUhjS5IORfHVkPAaSPR4Nx8C303PnB0xxfraWcwTMcE
 9gHAxMPoydBKxuaf1MhrQ8+bluRwYuegDZFU0TI+hMNGwCl18GvdWWLbuw7ngxXCIA3O6
 cBzHFm9TfZYCIdego5BH86oIvWhdQLCWTrcJsZZTlABD692jw7wz9a2ksHaaCPxfiEXkd
 CW00Mx8GMHUUtG7gdDK7/4Qc68cXmPmlsWDSyFFCEZ4CcF7ti/WdBfy4yAP2xH8mc28dj
 whUhgbjwRm6pMrpzGwNC8Y661AkCNuNgktGpP1ve0AnQd9GtfVZ6rWOQkyVPCIMAEEQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m9Yl3+sh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m9Yl3+sh
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9769440068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:48:05 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso5815585a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 06:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717283; cv=none;
 d=google.com; s=arc-20260327;
 b=av7BUAhrqp1shWUL37UjneHQ19oD3y/x4HL+GjFtxPcwaRI6fX8xNlfGGkCT5mVHQM
 shnZINLA2HPBOOo2VHYyol9/gONk/CA4UIyc0V8tFqcwv4c1n/wdixJiQKox9OD511vU
 A5+XeBnZkk0SBcTAuV95y8MvcY3r3G6AtAGifAXrd3mGa4KQCjdUaWZNrjsGaMtLgO20
 YvZ4Du97xkEl39ITntvaQtqidB5QzXP8fuO9qZ21zkCVpk+qvpqObS04G4l7kXTiP6R/
 7xWdQl4FcMDDK+dIyJSvo+St4CfUJDx8y3UXLFYjuKN7shIEH73dqOfpApwmLkWukPCy
 PF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=PWk/fKuGwIH0F1Cfv9Kjx9AF6lNpKGkdvCiqhHnWnik=;
 fh=0NQ7+2w65RPpNCI26M/orhiD8SBg8LO9BJXQBsj2UFo=;
 b=R6lzW4w1EOxOHtkIgaK8teBL2JYOlzJcm3tkJAgAZuQpZ7Jao5MlMDaCNqFj55+QkD
 mOYE1+ftRqDf/9Mo/btYr4ck0ZkYjTEFFT9Txs8N4yH/KXJE4vgcfqPEA2nh7oDPEyBM
 lT2keubhJhE0ZgL6G7AMzOIUZqWoA+2C1vCDqu/hxaSyOzUmVml6zZdETQ5Y1dNkNQYq
 s83Ph6hTGA3NiI4letbSyH3FVPqAxmkv0iFFBDROIbv9wh6eLpSWGec7/lqLQo/2eRX3
 gzPAgLu1w0u2Sz7vPFYUVqLU7L+Uxn2hjM6J0QlMODq9tk0eMq70P/K0iyvouYdDGhOY
 zP1Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793717283; x=1794322083;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PWk/fKuGwIH0F1Cfv9Kjx9AF6lNpKGkdvCiqhHnWnik=;
 b=m9Yl3+shIppHU+cK4yGwGwmC3kTbVzbkod7oJTD3T7MfgWgOsSg6azgPoNNb/mKkej
 jP/yxg5wZ+CYBl0OR1XuRSoJnDUfO715Ayb7zRJk7coFfJgVFETV6oLYQKCvuQHi3CeX
 5xrTfkhl5DQqDwZIzv3k28FI5YyIHTOufrzsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717283; x=1794322083;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PWk/fKuGwIH0F1Cfv9Kjx9AF6lNpKGkdvCiqhHnWnik=;
 b=1qHvT2vPUj8SdFmt33pajmo42M75jWz1bQCX5/m/cnwXP4EiinwcGrzIjvFbIGI3Rs
 KAvHF2e0YbE0DOeI72+cTypPjaqDG+tLqs0sK8Kc/8LZ8HuSm/UgrScrB6HjGLWA3zoC
 Nhp9zgS872xkWqWq7XNE9MeJ7/WZhIKchorg4Im8VvyQtyCQr8gbS1/0FE7/n6le3Br1
 obc1qOnZhoHCGBz6eZI2bvNmUdt1XtKpWNpT15Swk3uwWAWM/FAncrCj1t7RS2HJ/2iG
 hYkPOLGKUFj4RmbK8LLtn0N9eZTNEFrAjJrggdj31m5/8qgEYkVUxMSoHpHZ8ktGuO0J
 9Hbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8GddKp8+H62kRtOMoZY378z4cwQm8PI7fKLHKcu4+S7pSg4hMseJ1I9UEi0Ue3Lahms54Iwc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8EBBkfXlyjm5uDUeljY5k27xxL1Y+SHxPHCl4JLtPV7H+7y6p/
 uhZvDUfQcjbnftGsup+ySIW9pgwb8yaYGHdMi4Acx5pFbfoRjsuxOUkn2+vUkQEjGBoDGG5l+Dd
 igIup59GNlutPLt0GHhLC+oALlauiCPIDQzKyTHCLyZ0Gk76fTz+CKQ==
X-Gm-Gg: AYBFou1Ibm2TFXqeELodXPuJ7zSqj4FuoNdsH1zl3yS0Iy8LZsh0oK9cA7/awD64GH9
 8KYmauRTcgOFvXR+8rUcXRtfherkjJcYVeBJXInuFYr1cx+YiMd5UOoJw0yHcMkzU6kWxlXoMuS
 rI4Axe+uzmPOexq5mjJaeehOfIN/abmPtF5bo943nuPT0peKMlKghoIh5vg3iYPernwxLArHtkU
 ziEZSB3tHx0tJ0iBGl+/NsuKkdEFCbQReYr5HtBHNooJO2uAfyS6XihcTnTdeTYEAJ8De2D1ZXh
 cj1p3132SB39d1sllNHeUiv+jr4Y1UOQXWrMst7J8uvfrhwYskXJjArmW5Syxux966sawkaRJCh
 3k2FmhUdTvESJoXcrnKXy0xOcW1IqTIX8eKD+k8BArdTAoFUpJOOLHKYJAiA1I6aYT/B9V1s=
X-Received: by 2002:aa7:d815:0:b0:6ac:fe75:16a with SMTP id
 4fb4d7f45d1cf-6b4d337bdcemr7753978a12.1.1793717283232; Tue, 03 Nov 2026
 06:48:03 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 08:48:01 -0600
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 09:40:40 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261102-blk-part-unbind-v2-2-d0319d20fbfe@kontron.de>
References: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
 <20261102-blk-part-unbind-v2-2-d0319d20fbfe@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Nov 2026 08:48:01 -0600
X-Gm-Features: AclHuK8N5Sn4tfHlEHmqotfQYc0qah9hg8SRM4SHnB_rA-Q3gfJT6sNVPoEfVuk
Message-ID: <CAFLszTgeJ=Q0KmR5thFKwTCjUHX9qT85K3XRZjS0=F9dtnD57g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: blk: Check that partition devices are
 unbound on remove
To: frieder@fris.de
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-02T09:03:47+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> test: blk: Check that partition devices are unbound on remove
>
> Add a test that removes and probes a block device with a GPT several
> times and checks that its partition devices are unbound on remove and
> bound again only once on probe. Also check this when removing the block
> device with the flags used before booting an OS. The partition driver
> doesn't match these flags, but the partition devices are removed along
> with the block device and must be unbound as well.
>
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  test/dm/blk.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
