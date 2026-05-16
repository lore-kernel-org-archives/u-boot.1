Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD51CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 13:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712DA845E3;
	Sat, 16 May 2026 15:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JHpoPiaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5611C84659; Sat, 16 May 2026 15:28:56 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E1E8407D
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 15:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd4f7f05e90so190586266b.2
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 06:28:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778938134; cv=none;
 d=google.com; s=arc-20240605;
 b=iuNtge+JXXlh9qaoiLW3MzaggDlbDDlw8SHDq4Z/A8LQ+WG62MoSCkDXUhT1Stz6dK
 JhkGQHeXZccY8QBl6gsJDvd+sam9vii3F8gv7gaZCWKFMFK1DgPb8QQ4H6yELdIhSUOI
 ffCMiC3uSBz4X/SLgihdfaS3XXMNgrKTnO8EA+nL/dJl1DaRFMFzPAn6HVTXUGuxnduC
 gBCmYilzxRBzBp91gmiBJSC8cNZ37BaOWo1u8FpmmjnMfRPdJKSJ9uGHv1X277p1J5QF
 qDkn8fDLakakDhEIg955GIKLNH09dCxduCmdQ4h1f/9Zw6CzMcPXEECQEMkLd/CXrFJK
 jf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H9TlimUVMK6R0PUN5vVsiq2R9HM4B2h/Wn6NkDcIQGQ=;
 fh=dV+BOyvQfqal2evuHSWtSdoatlf3EYFlPsmIsPRe/Bk=;
 b=igfOdBTg/hqOQL13mhWfC1OJwQiCXjBeVGyRJyTCLtTJITLmIANXIJl6wNA/i2NfEm
 RfF+E0I6jSgN32a0VX5e2zcd29sh6t5g/67gi7IfSCTC2BoPAwwtFIZIgATo8DtsH2nG
 UsIX/rL7WTHceAVN2hrz6ptb09U3AOWXAIs+X3Bp4av3Lmui3dxJTTmbWT1tq91gl9Um
 3LL+cZ8SvK70J2kqjcDh7IBk3B8fDdXCxcWeiNKu8OLlqMZDC621mpA2wkZU5Oyp2xxf
 Hvw7S/P53DCwkKcmHz54Yboq7h2HXALRk2m7wxrwTOdq5KOrp2d64jAEwcLaVLZAzRul
 A5HA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778938134; x=1779542934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H9TlimUVMK6R0PUN5vVsiq2R9HM4B2h/Wn6NkDcIQGQ=;
 b=JHpoPiaZZBsOWP0RUmKSQBCVlLDILmWSCPs/zDWKakXaoQeFpYw8/bdAwO55D7/hpl
 uhQ9a+zU+gAMELbZ0nVBjaIzyAM2jq4huvmns7GQdJt1dioyY5GTS/3PWwKHvYKNOs8p
 MNOI9B9A1bnmJ9Wqa6CoYHsBqiSm7Kk8DDVuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778938134; x=1779542934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H9TlimUVMK6R0PUN5vVsiq2R9HM4B2h/Wn6NkDcIQGQ=;
 b=Uho9gyf4s7/Rh5nj4DcWf9yhyqxBhRS/Jlm+6GRktVADcOZBz9SeAqwvK/5q5EIzRG
 KpHZi2lbzERodOqk+9889JfED6wrW40w3brnnsm0ERkdZhwMWWIRXEc1e9UXmBosZiEm
 3PE15/AIuP160r91bVJiAelOxEq0iCcSj5o3HlErRiheNtjNNLshEj7RJ6l7mmH4mKO+
 GhrVQeBM4i1JpR7HcUypT/HNx2Y7VQSGJK7nlzdAX5IAqkTwrfeSXpyXaO+lohjIivSJ
 qs9EFxLo0EhUet1fWoLxyOpoM9ORuw0oEkqCsd406UcsWhoIC8zdTMiO8p4jcJIeaJD8
 0vzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TVhyxFLzCboPF+ITALYW3LZpwf8Qvq4rxzCS33fzc9O6GO6OjEXGcuCYF/64UmYPtsjgzUsc=@lists.denx.de
X-Gm-Message-State: AOJu0YwXBucMK3S/l7wVe0erjVzulbDya7eVRneH4w9NET9iDoIERi2u
 tVYZKXd8nR4MU2xfd9Uw1fsCyB4snsoXo+44wBfwajGpptx7qrhtUhvpyrwSMv5+b//6M1CKewB
 4qgkXYT2xVXn0KlOlXBxf+gyesn6fIywBYK/xVxi3
X-Gm-Gg: Acq92OFldPww14ASx7fQM69agVoLzcD4Rj7QjJs9QqpeoqzdY55i7PBm6ka/N010FKk
 YKGFSBmf1fkckf/Z88XHENbZcGMkW0otV27zBdbyzxLcUM/te+B2e1rWQ9TlI63Q2eexPU/q6LY
 9KOEq5OgnimjFlV3HxSlLaheyxKEfoj4BF9VcoI8YJddBPvimjDoRQs0Nv4l1T+TXZgZB4YPL0S
 83y3C0I9qSGXS+OZHSuE2LecAl7DEVehW/apgWXesrQHX9J0PMHn4Khj8LZLUu2xvRZD9pTmOT1
 A6bxtA==
X-Received: by 2002:a17:907:3d45:b0:bd5:27b7:adaf with SMTP id
 a640c23a62f3a-bd527b7af46mr268882666b.33.1778938133641; Sat, 16 May 2026
 06:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <ageGYp5K7a2hanTC@os.inf.tu-dresden.de>
In-Reply-To: <ageGYp5K7a2hanTC@os.inf.tu-dresden.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 May 2026 07:28:40 -0600
X-Gm-Features: AVHnY4JPG8WPjMGdq_wB8NmA37NNGslf-saIec4JXxRG_QIcNZXoB1O2Gk0jT-s
Message-ID: <CAFLszTgAWM3rj9rSOovRYtz7DC7FfffnirOJnJGMJufnGU94_g@mail.gmail.com>
Subject: Re: [PATCH v2] common/command.c: Avoid NULL pointer use in
 cmd_auto_complete
To: adam@l4re.org
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-15T20:47:30, Adam Lackorzynski <adam@l4re.org> wrote:
> common/command.c: Avoid NULL pointer use in cmd_auto_complete
>
> Avoid using ps_prompt having a NULL pointer. For that, use the same
> approach as in uboot_cli_readline().
>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Adam Lackorzynski <adam@l4re.org>
>
> common/command.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
