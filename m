Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BB7C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7709E82CA0;
	Fri, 13 Jun 2025 14:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="fbEDCDlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE5C82C44; Fri, 13 Jun 2025 08:45:31 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3C5982AA7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 08:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6071ac9dc3eso3030584a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 23:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749797129; x=1750401929; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JROmtDKLyrV0fHRjuVQ0VXFjNcNn3xrT7F9HfVb2Hc=;
 b=fbEDCDlQBLdOaMGIoeqDKpJGKBh0olhUbQHJG7QJTCcZvPdpwVCG8blf0RumK9suaI
 Jgt8YXDwGXU+qbt++gajU6W5peSTCwiPfCS2FL1vWZvNnOHGTLUV9NshgWbe2kdMTM0X
 /6suXUAHXLrtk7yNS5Z0TH3fwvEkN8AWRevdw9ctAOD5JrjiaTCnk9xYvHBncQZXwWBS
 wb7Kw4qsKsd4KGcm969ynDAqNCsuJa+ymmAfDwhDZvsPd3iBosV3sN+ML5ik1IvtEOFj
 68rCPFusm4XhueI1Y0TKzNfEpYikD02tocARbszmFlnlkxqXIv2aMSXCuRXnjz05XcfN
 wjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749797129; x=1750401929;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6JROmtDKLyrV0fHRjuVQ0VXFjNcNn3xrT7F9HfVb2Hc=;
 b=mknYC7hVrObv4CKY9V8x0dVBdWx2sfYzg5gOuRBWxgMn3aWA2/DMMcnqZEdsCo3BDW
 UP18Xsei9lF9CCwQy8U2NbRnK9pVepZJ4GkILSNi2nKGNKqMiGQ8asr8uqUezYVgXBfv
 eKa9RemCWpYLrgJhb3Clj8vcGlfpiS4mMIDnP9JW2vLrdpKEAuggrovHBBnCWBcU8EEo
 Nws7Od863Ov5s9BAZqNtuUD20o2RGmnPevdkYDbcTs9WMDp7oBIj+sBZ8Mx7ZrNanBo1
 I5Q0kF9rwve0NYoQpW4Od0KIauNbmgWEvuLjY8JL3ya0C2snKNik9OLkK0AH788hJEgA
 5usw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm4bVnpnTAucpsPVg04AzLVdDvMPp1wfWg/Z70axoCyWyNlVMml2CFu56qCjzzdot1mL33fbE=@lists.denx.de
X-Gm-Message-State: AOJu0YwkXagFzqsO3MJnhq8MIDrfHIARgyynhPNVdfSICiIrFRxz5PZD
 vFvz/Majm70wgBS3e+m5BD/+EaOb7RIyQTUi5GEyiJJJXDry/SUHqkeGB7ELR4xfras=
X-Gm-Gg: ASbGncsVSY9GkQTB4V1UeptVMrrPpC/rkGaD84kK9jOWj2I0dLzfEMNL2bSRw7GtZd8
 Akvu7eIdHy/JvI+/zTBmnpfIMNmsYnK4lgIvMf24yYe31J09rxV2ZllAi4SWk0sk3nqz5wRYPdg
 8xT5NZz2VH1zjfpp4ziTjv5UhR1dewdiv4lRPBdP6UONEDUv0T2Vu84rNDiS0fB8tfVAKQ04ZK+
 iPm4eu7nEmiEjhdeKbTYIb7YKOkJCTOikLBavn7NWsO0UgQEJcg433yoKE7CiFME2cYTKZ2s7nI
 ltO7U6Z928AFF2f6IkFmnlQ8zxQ37z1Fpzzw++C3DVkpddq0Uh4GUScuZwqVjM6u4I7pI4WZLNK
 O2h7TDOKZE431I/Qbm4MmcunT9x33iZI=
X-Google-Smtp-Source: AGHT+IExlhOgrG4+mLFzhPhf9TieD6MwJn8bMLntPCdfBvt6hnNwS5++x8kZrLFcsJrD4M7qrMUgNg==
X-Received: by 2002:a05:6402:2816:b0:608:6734:7744 with SMTP id
 4fb4d7f45d1cf-608b48af4bbmr1474743a12.7.1749797129198; 
 Thu, 12 Jun 2025 23:45:29 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b48faf6asm756507a12.31.2025.06.12.23.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 23:45:28 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Jun 2025 08:45:28 +0200
Message-Id: <DAL7BBN0YH1Y.1HOHC7JM44TFF@fairphone.com>
Cc: <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] clk/qcom: sm8250: Fix variable name of msm_clk_data
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Alexey Minnekhanov" <alexeymin@minlexx.ru>, "Sean Anderson"
 <seanga2@gmail.com>, "Casey Connolly" <casey.connolly@linaro.org>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
 <20250611-qcom-clk-variable-names-v1-2-37615b74daad@fairphone.com>
 <267f957f-f74d-40f9-a65a-da00ea12810c@minlexx.ru>
In-Reply-To: <267f957f-f74d-40f9-a65a-da00ea12810c@minlexx.ru>
X-Mailman-Approved-At: Fri, 13 Jun 2025 14:17:10 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu Jun 12, 2025 at 5:49 PM CEST, Alexey Minnekhanov wrote:
> On 11.06.2025 15:08, Luca Weiss wrote:
>> Update the variable name to sm8250_gcc_data as it's in the sc7280
>> driver.
>
> Hi!
> But why are you mentioning sc7280 here, while fixing clock-sm8250.c ?

Copy paste from the other patch :'(

Will fix, thanks for spotting!

>
>> ---
>>   drivers/clk/qcom/clock-sm8250.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm=
8250.c
>
>
> ---
> Regards,
> Alexey Minnekhanov

