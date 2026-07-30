Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67573C54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 08:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EF2E80EFA;
	Thu, 30 Jul 2026 08:37:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g5RA0TqBxzOo; Thu, 30 Jul 2026 08:37:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24F8C80CC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785400633;
	bh=CZ4lJ4ErPrxcZ/M8Qypa8hniAcqZzZWFP7HBSOZ2scA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pcGcisaiVHQ1NeB5Rf7HEyBe2+Ym9rCsLxQj0OHKCCu93nSq7sFw2aBSRJsfc2moJ
	 19eizvuWBVTRFCQ1C2AVGH2EOjrVnv0wPFa5reXDFCZEfc4iFC8YabEYnuhIVnCeeK
	 kqujm9tf3ieslU0kZkZrV9u2LiJlTPZ+OADZK3DjvP/GCyWYIzpKxxXF0hdqVO+Qxg
	 HTueJDa9ozMhIPnc3q/n1lnrpAT1g9S7H0pt1u6JAaZUpMwV8ZTkMv9YoA3x5HCzOx
	 B25olhlNidDT23+JDkv66gj+DyoHmGziPekmrQiA4UfkOJQxtA5l6mjNdpSsbGPJv0
	 VHpszOlyhv6/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24F8C80CC3;
	Thu, 30 Jul 2026 08:37:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C8A1350
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81C4180CC3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id glFe03sVCg5w for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 08:37:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5E4AC80C41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E4AC80C41
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E4AC80C41
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:37:10 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81e69a2db34so29356097b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:37:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785400629; cv=none;
 d=google.com; s=arc-20260327;
 b=Lb6c9KJTOLjAEFe8e9FUw8ppez5QPBUU7Mup70RzK5BdTP1pOmeolP63BGhi+H2Mkc
 BJ6HFV22YDFijQviXiRMjHw7eZpAP4tK3LF1IzvNVs6B5/DtiApbZQNIbIYJW7hUjZdr
 6eudyObovZUKnnGzAX4BabzvTByrQ/jAVc81gpevERzL8XlR23LZCOthJNWDGsJneXix
 JDNadxDk7UtDVqoNNtLOBX/mVymdT2Jq9C00h/C3B5Ev1ylMKHEJLZyq3xtJVm/23WA8
 Jy3PA+3mE3vWvwikWwSBqdMYM9112pB8plkaP1IXEkKKPYBZMS/bNeWMFTu3DjCVlHOG
 7xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CZ4lJ4ErPrxcZ/M8Qypa8hniAcqZzZWFP7HBSOZ2scA=;
 fh=wLVR9j9PsWmfZqlK17unNjhvl3a2CWiRKFd4/I4kTgM=;
 b=rPKvncQLbGpAJBzln9oMP8h5iC2UJgaQ5HJ2FssPHCZSU4ZlAjNNw8q3K3C4xcuz6e
 ebZ0xP6dw8RcS0RG/ywJwFBMT5CXTu+MVXKqi41caeowv72lN2Eh/hzeKLgwhobwgEeb
 cU37FMCKUMrDIKmlaM2UamGGq+g3sg6zv8iwL0UdF0wpL6ZHd5AlZ0DMi8vGun9+1tFs
 KNgAUz0agCkZUJBb4hmklXYpzVqeOFBeDc8hpk3JU9ZruBqY/ZKVuxSARJiY3anzAf/L
 cjWae4dLxnxOJ2hlBkn86N4l3PIQvDaZzLShEi73kcP/G0bDGrS0C+bV/Q2Klx3TUUpu
 il4A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785400629; x=1786005429;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CZ4lJ4ErPrxcZ/M8Qypa8hniAcqZzZWFP7HBSOZ2scA=;
 b=VosetmJ6Mra0K/3bIxsBvzsrhFViYXbTp/GATXAIUwGhp9pByjsSFtv37vikI2ceK6
 7MZHDgCDTzOTBvk8WYrQJnL0g1+TKcYIjtpmIMySY7EMIBSYTdNHWfevY8FlteAq3TVl
 U723+uiLMVgnh3iegcbWQ9keveJyvbTCGBw74krHNLl0wN1on/j6KYlus1LK4mN0s5xP
 hczPdxrBSv+X5uUeXUJBz1A3BCtm7X6kXxYAwictvzOZ+PYB6ROa+31kvOYjkQb5bJNn
 Qc5TppET/s9viOJTKmlWeeOQqroNrKx1MdHQjro6aVC1F0B+ZWY2DIkR+gpRmsmeC8fV
 uycw==
X-Gm-Message-State: AOJu0YzLbbeAEuGmxwavNb/MFlI8FR0GVT05Wa8apP1qp4GgGJ3Wqkab
 E4xaWlWbcQZ85q4lIhN0QqDlgRgg/6JMvrF2WXMS5Uzsj7d01cs6bC23ykhoysKdMMwqjTX09S3
 dpGcjFseVzYHXG+xTCoY8mE413tsVWmMqkOWjoxzT6A==
X-Gm-Gg: AR+sD10fV7Mu5IEK5+e8VCVNAlu++ElybwqU5E+SyFgpyodR4vd0ESZhGZSYq5//17o
 +aAXSfrODaP7zp0BL64AsJbLkbYNrjW4zov81aXNdZsj6CMjj1HK/lshPQloMEXnA/HfLOEJhqD
 NWLMCJgJYKMgL0lAcFa8rToShAe8cpTaaDggx/B1RNnyhvKf6w03JGEoDhUARNVgs6cNbdfTjm9
 DFekk90iW3deSEZUpu2mqHscC7zIg2CX5k4v+pvdzdeEkxvt+Vf7lb3G+FLlKH9fuGIpAwaTuEX
 oahVEY+Zo/PmcNw6J17m2COtEl9q26PrwiqBfb2SigYgTf+wpuL07Eo2kzwfN1vJzC8Oy67078r
 ZYnQqwf/+HVfM+y5xM3ojOQiRvQ2Ivhr8M52uVQFpgESMyt2X7qKE+Z1axR4BhWjZxUc8jmX6oE
 ZxNCp+qBd726Nyy7lmdjnseUz4s6Vvq4Ab2Em6kcbldQMzHIZmVpmoylydJCAKmHO6JQHVkbHem
 2yA8kh9ZvB3iC2D0/CDExokOFDJJHDU5W45sncWsZlJ2oS63msFYVCXdNiwj8I37K2eogYZjnrM
 l5YSEQJOlc/TYPliKQAMpKE3drYPypxZLsyAKG1cIYqsLlozGQWozbHIELf01LNgHNaNThFLJLC
 xUefTG2VgjHcHiu4S5C97+KFuEVQg8WfywGZV4ZKcDIq/sm4dfwANgnzZakqY4wi1TVLmNkSEQM
 byXWdy36aQN+g=
X-Received: by 2002:a05:690c:4509:b0:80c:85e5:875d with SMTP id
 00721157ae682-81fb8b29859mr12216377b3.70.1785400628787; Thu, 30 Jul 2026
 01:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
 <20260729-tpm-trunc-resp-v4-1-5dd1a634ea4d@byteray.co.uk>
In-Reply-To: <20260729-tpm-trunc-resp-v4-1-5dd1a634ea4d@byteray.co.uk>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jul 2026 11:36:32 +0300
X-Gm-Features: AUfX_myutZi7_yiXZ_sOGqSdtcZ1oPnLO2oiZW727uXsTvDwvFwvYIn4J3BoaGY
Message-ID: <CAC_iWj+m642ax11mjm=GDLO5v1RZqVxcoSXpJD0Oyy0HPvONzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tpm: bounds-check the device-reported response
 length
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Reinhard Pfau <pfau@gdsys.de>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785400629; x=1786005429;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CZ4lJ4ErPrxcZ/M8Qypa8hniAcqZzZWFP7HBSOZ2scA=;
 b=lvLm7roTmWYLGCr3VjlVSQqMYY/CkXVsc33PwV1xh4jGEnOkVAsZhrtydkF0CQjMvd
 CE/Ug/jOzusBHAMXf6bxb1XZaZDs0OCKwGZoZRPDlN+Do9LG99mU7C9PnpJsF3aisxco
 X1VADkmZ0FAZLNuIqfOtqd+Dutb7vMi5ReFLswG8vDEVU6gzSTH7JvUMDIGz9p+nT4Ot
 3AogtmcznFsTbpzq6/MOZs+bnk3IEeVEjsZ0Nj4OKKV4Y0dBq2veaC/VNdMrJT+FvAwr
 RjAQmUvMoK7WIxgHdxSQAPKCDZQpV8Y9OJINoxKi52TthspYkcc3MW0D4uzhOqZbazFX
 zh0w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lvLm7roT
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

Hi Shahriyar,


On Wed, 29 Jul 2026 at 21:25, Shahriyar Jalayeri
<shahriyar@byteray.co.uk> wrote:
>
> The length of a TPM reply is set by the device: tpm_sendrecv_command()
> stores the number of bytes received, caps it only at the command buffer
> size, and reports success whenever the reply's return code is 0. Callers
> then use that length unchecked. The clearest damage is in the parsers that
> compute response_length - <header> and index the result (the TPM1 OIAP
> helpers and tpm2_get_capability): a reply shorter than the header
> underflows the subtraction into a huge memcpy.
>
> Rather than guard each caller, check the length once at the choke point.
> tpm_sendrecv_command() gains a min_response_len argument and rejects a
> reply shorter than the caller says it needs, before the caller parses it;
> every command that reads a response now declares its minimum.
>
> tpm2_get_capability() additionally copies response_len - 15 bytes into the
> caller's buffer, but was never told how big that buffer is, so a reply
> longer than it overruns it. Give the function a buf_size argument and
> reject a reply that would not fit, so the copy is bounded for every
> capability rather than for the properties query alone.
>
> A TPM sits on a discrete SPI/I2C/LPC bus that is physically accessible, so
> a reply this malformed is reachable by a bus interposer or a faulty part;
> on the TPM2 path this parsing runs during measured boot.
>

[...]

>  }
>
>  u32 tpm1_end_oiap(struct udevice *dev)
> @@ -695,7 +702,8 @@ u32 tpm1_oiap(struct udevice *dev, u32 *auth_handle)
>         if (oiap_session.valid)
>                 tpm1_terminate_auth_session(dev, oiap_session.handle);
>
> -       err = tpm_sendrecv_command(dev, command, response, &response_length);
> +       /* tag(2) + size(4) + rc(4) + authHandle(4) + nonceEven(20) = 34 */
> +       err = tpm_sendrecv_command(dev, command, response, &response_length, 34);
>         if (err)
>                 return err;
>         if (unpack_byte_string(response, response_length, "ds",
> @@ -750,7 +758,8 @@ u32 tpm1_load_key2_oiap(struct udevice *dev, u32 parent_handle, const void *key,
>                                   parent_key_usage_auth);
>         if (err)
>                 return err;
> -       err = tpm_sendrecv_command(dev, request, response, &response_length);
> +       /* nonceEven(20) + continueAuthSession(1) + resAuth(20) = 41 */
> +       err = tpm_sendrecv_command(dev, request, response, &response_length, 41);

The load doesn't seem to factor in the header len which the commit
message mentions. The code later on does "response_length -
TPM_RESPONSE_AUTH_LENGTH", so it should cause any issues, but we
should keep the same policy everywhere.
Do you know if loading the key includes the header in the response?

[...]


Cheers
/Ilias
