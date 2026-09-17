Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85421C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 15:26:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDEDD607CE;
	Thu, 17 Sep 2026 15:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ZgUmHbtwxpb; Thu, 17 Sep 2026 15:26:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 18F3060890
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789658807;
	b=ms9BmsLq10/clfIWjl48LBgRLu4Zt9puIuj9VOjYyCQQvzji5kRpRVN5XIvGcFAKJBZ9
	 LMzHfW16l0xG174CkMet4Ri/ligSFczFu71ryArrTQMZMTGXOzwxZLkv1G0KUpeNfcjLc
	 2HC1iv87q3DiAoIwG6xpAVZn4IRrwHY4XPaARUhZqtcAj5lAYxDx7c6+hApf4RvqiLCW8
	 SRSTmOIF/qWxe8neuRpuTqVN4PDyAZor3CTUsVw8kVFmOcX/cizXVydw1CVeCxjDeDDOO
	 n/maHRiY7YtMc05CYABVtQSt1evBMZCXJyY45nDuvSmeKK5Bh2maFbD/kb856CthYAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789658807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0DvnEOgDtZaQZV0/Z4WmEoBHIU6L1ZlwFurlQeOVs6I=;
	b=BOPQIHZf450zc+CvZz0ZUAkkCjKcpbZAc6WOXNdj23oYnyI8sWM/Et04PYwu4zIQMTSg
	 bQStmpcl5hWjMAyZV9wRRi+jopzEK52jaEeJ5eBy2Cnq1+6K7YMyClpfd9is7ekhqvBIM
	 rHGxrcQUeJ2oux978m8TpHHotq1wMu+U2DCxM0wj/P9qfT99dl5gMghWFlnxpSjpuhIZf
	 U5flmEzVYO326OYNvkBv+dVVzWf6D78w15nWr5pP9sBt9IG+AN2EStgKbMK/QR5FCG3uP
	 OlylD6/9HFvFKMfw3TIEnZtKDcSbN0Tslu78hWbV0kuEUXb505DcZZb5laNccVgFMMw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789658807;
	bh=0DvnEOgDtZaQZV0/Z4WmEoBHIU6L1ZlwFurlQeOVs6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T6fXYHqJstzH2LC23XX5mhhdisKqVgC7ncGXrHhFZozmyeiJibXlDkaJqMivWdTG0
	 pImTKHGsNHjmfkl28fIKPp/2EoK3zJtHkOL6DzBv5Gibyp1W2wL5p88w1HVdfNP9Jt
	 36o0oJUQPxGzV2CHocRLUkZwTJHcA0lyPW4F1OBan0i9AiuxemgzO+BrR+3p7vy4Hm
	 0/EAjsGpKtcrHtU24CyomWwqJa8Beus4NJtbW+S0rwfYWqPl4eXn5RHk5Vc1XG+wKr
	 NsI2yaqyr3mLj/azvNbpaW1jbFBzcDHDxe7S9sAkGCEtI5QejzObyn36C7yvhut2SG
	 pPf3gE/OoCqWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18F3060890;
	Thu, 17 Sep 2026 15:26:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FEE8422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00C7D40831
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FZzcNq1MJhYp for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 15:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E868C40824
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789658804;
 b=JQEkDninXrjy/mced2tYnOgrNa3dJjuLjvTOKlce83rQTSYjskxm2ZNIMuD2fy/w8ecP
 Qv6YZZivdmIYwZHIG1Mcrtft21C8pkulCUIzXGHH8Sn6FOotqR81exltOUZn14kJoLtjY
 grg6QsX06OD+/Y5kFGSIGzHrbEhj+Lssc8SVn6krz1E0W4tt9ZI7M3RP66wF4mGcPJ4++
 hPfIDnN2d9cNILfW4v9EgRRQ9Hi1HnG6RrZgtCdj6JFSK/co7vEzDks9Di0cQBz+V6g82
 DPF6vb5v9SLkz1aceXbrZGyfwgfxKQJbtM2tRrZlbTO/D3YoDr1Qo2m3pnulDb+EkCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789658804;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
 bh=0DvnEOgDtZaQZV0/Z4WmEoBHIU6L1ZlwFurlQeOVs6I=;
 b=XIAzJ7PAdNSAp0fVFxeQsstXBLBiP2IY/rA5C1Nk7OEGaxKyym7o5K67BneQttzAyCS8
 xD9LHnlC51PQVqmyW33lJmpzNz/9dersr6BZwfa6BLUx4p013J3vLtpyY3kqf0m/AySUq
 XvpruRvF/6qX9vsR+USuoznwYoFasUcD1PiTcGXxUAgtWNki7wlZHIQ7E8skLQ4wbAWjp
 /PcfIl+TlJRTtDZRp4v4qfoiTfjW8DuDWrf75hSjjnPlhgx32XvRl5//LT0NSHUWIKJ83
 lmPVDtHeZWqCIWbkQB3LT3wZSn2ZpaHSp085GPbytXBVvS8ajdafM/EHCuW6GT5GuCg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=G3c7wT5U; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=G3c7wT5U
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E868C40824
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:26:43 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso7397455e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789658801; x=1790263601;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0DvnEOgDtZaQZV0/Z4WmEoBHIU6L1ZlwFurlQeOVs6I=;
 b=G3c7wT5UNljoG6Pv10VoT/nvxwyoRmkmlykQRt1hcoU2czVa4TB8h+Sb7+B1cH1Q2K
 u2vhVrYp5NXtvnUqS8a0EzMuDYTPJqTjnO0nsuXYyF6fQtDDtTS9nVMsmK9NsabAQcMJ
 iZvhsCYBmDWLoVm9k/OYGQ625zmuTDtkgzrG9zY+NgVADwWR5sNIWI/O+ap2Ay7H78V6
 h+YW9YUTHqj7sVRyCjD6v13OPAvokLLRtFjMPBkOkfVwp8Ncp3KbrtiXlq3f2HaQgCki
 CEvlSNNRNzf1ze46I8kzJnmpfI6fM00s3hFPoHm873zO1in2CUWocBKJbnrsKB5bd3r2
 IcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789658801; x=1790263601;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0DvnEOgDtZaQZV0/Z4WmEoBHIU6L1ZlwFurlQeOVs6I=;
 b=Kpu6DK6fKS0fxD9mJFXFO8itptMOHwTR+mDLZrSAndb3P6D/+6dIYiY/LAHAGwnChb
 ajxFItPBairvJfiCCkUlIlWm+XuQpiqY969O4nJuYR1Lk6YAiTrumdt2cDwytaiCNfGT
 qnpmKZsamJSmT4c+rJzNjr1o+mcugXeHpKYcYzWhOhvYIOQujyUm8ySvN9OAWYRt1xvL
 4qOPOJgrEHAMaTz7rtWNplC+n6EZN0NR5Q2j3qHZ3ChLS28t9YmNqqVBDV7cFje3yV35
 aGrq12DohGQsS/wHD5cGwhahgidpXnyJCXKB5+rhqzyjaLfv3qmj1ZiS+TCX+7NH0vNT
 MY4g==
X-Forwarded-Encrypted: i=1;
 AKwUvByW30G+JAXzf0uJF6FWWOoJP7d3NTWjJA4kByqDBCgicj55vFKtJvrvVW5SYm5s5+znFLWdLG4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l66QLpzE0GAjLbRI7j4UphJln6vZ2sYbZH9TIcTIeUiVuJ/Bdo
 xatF6/6B7p0Q8iDMxeDhfMgoywGPSIQ4BFgGg5C3IzmpvxMotw3ku7Toj/R+aFRmHu4=
X-Gm-Gg: AYBFou1fZ71ZIXashDl7K13NUGOF1qHwOmGe6oyMHzcxmIZtVE8TbSRx4+Jyf+9zhoe
 kqNu488aer5haii0Up9VRzHdx1H86aKnNcMNM1E5vt08+zNtdM1DkSuSIlc83f9gcsKJ9EOVueq
 3wlf97jKK/AsWfde3UKiArGDzIUat2FkNRwc3JMepXFjn1/IVJ2nk5+rrs67B2VTM2/rYJbN9Jq
 nk4wT2J/EcgxmycttgmNxlb/O0tT9aRDaqEcvdqDVcc3XhOHNaTel+K5HaRHQKGAP52/uUEOah1
 /pKh9aawpYqSPz/mnyTW8NO+F4Gk+6cX8ENygN4WjshxfudT3YApuaO/NLM0Iwk3KdkA6K2QDzh
 od5vyFIM8kWQ4KgPke76zhx5RXu3gMlIZM8MSZpOEQ0xrSxH2F+KzPDF3N7M8wIyo4aa5cNtIcR
 AwZeCt2CriAoDJZvkEAC03xkMdUcyPR97H0twslVvCJpFlZVB1YNqD2263Img5OP/n+wLGtqrbB
 mxB7Om+4P8oZ8K/FojQqMrWi6jWvF9v868x29Sdo8C0bM1FRWfpCOLjkgZzTk4aotMWtfGfZfAp
 2mkDpDdNHpGtj9yMu1v3ROeESebbKG4aR+KU52ihDILlHgopSZAu+Mc/3gnBNfzAMy1rtkTfFeq
 TljYUWNKcjrp4MTNbDH6FVxt7msWMOxe8TNTizwsP2w329ktACVqT32rRLQvPHtJADexR74m5sK
 UdNg/P8Znc50+Fh0GC8U6qwsKQa5O3I8epBG8jQ/jAZpl9lCPNvxVyABWg3RjtfYEPiK3OH2JjU
 TSmjmsocydwptkKWPy6V5psALO8WPh4PaQp+jGMbS1zjb/XrI6iFv/XI+Y2ipEwkhoOEi7ICRee
 N/A=
X-Received: by 2002:a05:600d:9:b0:49f:bc28:e8bc with SMTP id
 5b1f17b1804b1-49fbc28ea04mr51687925e9.17.1789658801116; 
 Thu, 17 Sep 2026 08:26:41 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd691d8esm34640555e9.0.2026.09.17.08.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 08:26:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 18:26:37 +0300
Message-Id: <DLHP3HJCA217.1Z4YOZ4KVQZNO@linaro.org>
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, "Sughosh Ganu"
 <sughosh.ganu@arm.com>, <u-boot@lists.u-boot-project.org>
Cc: "Etienne Carriere" <etienne.carriere@linaro.org>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] fwu: fix read buffer size
X-Mailer: aerc 0.17.0
References: <20260915-fwu-v1-1-cc1fe9640334@arm.com>
In-Reply-To: <20260915-fwu-v1-1-cc1fe9640334@arm.com>
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

Hi Vincent,

On Tue Sep 15, 2026 at 5:29 PM EEST, Vincent Stehl=C3=A9 wrote:
> When the trial_counter_read() function reads its counter from the
> TrialStateCtr UEFI Variable, it erroneously computes the return buffer
> size to be the size of a pointer instead of a u16.
>
> As the UEFI Variable is always created by trial_counter_update() with
> the right size before any read attempt, overflow cannot happen in
> practice, but fix the size computation for correctness.

The fix is correct, but the commit message if a bit off. The creation
is not the reason the read works. It works because the current sizeof is
always > of the new updated sizeof so the GetVariable calls has enough size
to fix the output.


Cheers
/Ilias
>
> Fixes: 7e9814cc6c1d ("FWU: Add boot time checks as highlighted by the FWU=
 specification")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> Cc: Kory Maincent <kory.maincent@bootlin.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Hi,
>
> This has been tested on the sandbox, with CONFIG_FWU_MULTI_BANK_UPDATE=3D=
y
> & CONFIG_FWU_MDATA_V2=3Dy, and with a modified fwu_boottime_checks()
> function doing essentially the following sequence:
>
>   efi_init_obj_list();
>   trial_counter_update();
>   trial_counter_read();
> ---
>  lib/fwu_updates/fwu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> index e9bb1b4fc65..24a8f1ce5b2 100644
> --- a/lib/fwu_updates/fwu.c
> +++ b/lib/fwu_updates/fwu.c
> @@ -82,7 +82,7 @@ static int trial_counter_read(u16 *trial_state_ctr)
>  	efi_status_t status;
>  	efi_uintn_t var_size;
>
> -	var_size =3D (efi_uintn_t)sizeof(trial_state_ctr);
> +	var_size =3D (efi_uintn_t)sizeof(*trial_state_ctr);
>  	status =3D efi_get_variable_int(u"TrialStateCtr",
>  				      &efi_global_variable_guid,
>  				      NULL,
>
> ---
> base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
> change-id: 20260914-fwu-24265a691f9a
>
> Best regards,
> --
> Vincent.

