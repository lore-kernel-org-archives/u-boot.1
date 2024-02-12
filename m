Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EADC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 12:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263E487C1F;
	Mon, 12 Feb 2024 13:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KcVjcckp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA35487EBD; Mon, 12 Feb 2024 13:00:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91BD87BC3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 13:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707739225; x=1708344025; i=xypron.glpk@gmx.de;
 bh=JXX878ndJsIbfemTkofEhiazFQdXnfsZJYxXUPlKu+c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=KcVjcckpUTDzY67mWA7JiqXwa6epxHGsOQJCC/nv6Mwpv8bTYEmEJZHo6jhviEl/
 qfMmh9FWSc+ZD+D3I2im3Ar8fFeJwep9y+XHnZuHfxayvMGmSRpSkVhbXXNsfS/If
 JFJmqbN7jK1Ddkymdsd7HPlMUrrUyTHcpqHLrRHYJQbRYdaSNRFLCiHGR14LQIFNy
 Om8dJNdqZ0YyhxCs9OglLf/zW1/NfsyuBjyLYCVGtQfiwhN7VfdSlkOX7UhUqJhR2
 E+xNpDnVQaE6DyFHPcHsasO0T7XRLwrCn51ZKaNC3qL2Y5LdrPgpxU6oFbNiSl65S
 EBnF0uRlezoQwxxi+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1r6Ehh3S9F-00f8xQ; Mon, 12
 Feb 2024 13:00:24 +0100
Message-ID: <f6e726f2-ff7a-47fa-8aec-88e0de2b1549@gmx.de>
Date: Mon, 12 Feb 2024 13:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] lib: charset: Fix and extend
 utf8_to_utf32_stream() documentation
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
 <20240210-vidconsole-utf8-uefi-v2-1-88c03db60de2@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-1-88c03db60de2@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:89OF3RnObj5UvMQ1sPBJhAblMW1Mm5SDEIYIyvEVQjaTNmbVh9g
 RCDALyoRJm1oh/RqoUKOIVRGI92uiDnaMB5VVWsh6nqcv9C+/U+LgjfL0pfauVoTvaul+3g
 dbFRkoVOl8hZOrGq1h2wVY4zAvnoIjwd+oVujWOTOFznnkeo1DR74D5pvJcnJFIs03mqBJY
 F9uBLgqUQvFLA952u+G/g==
UI-OutboundReport: notjunk:1;M01:P0:17CTwvw4+DA=;FkCIr4CJ76sxP7LmPP4SAWooMEi
 m1lD3ssnjMpazKZIWSHE+Jk2CxDN30TXeXP9evmjEeWvV8y/J0im4ck0KZAxq9Im8tw7mPrwo
 FrjiV4DQpPGFoQ60KGA5YXMuGA46mEddv6MUF+qUGx+fvhqCRzUq4o2+t2KbgK4x5eVMPujZv
 B9mvjzlWlljQzQRKXaZEgAkqytCn30HYgbDW95X+HtxJZzhPzTssrExEzuqEL4jA8cROBPtaW
 AuM3aOw3/Lk+c6/SqQhhbvPhWUiM2L1pJksnSPx7PwWy60w3+f9GhSmO9Qn+NH3v6BB6zcmSK
 7uDWUIUeS1zeDY12dFAY+YyaCLwU3VO4tMM/4bW6hUaOtAKxErFIj4n05z5vKZO7QNBse0zVq
 O1CC2GyVteuwAfock+Hbh9SRlEXUvVCWj1cMYLuWNAofBaFvMnMRmIRREEvmgO6JzdSiDwAIu
 NRIGLq9uhm/t8yvZa/eiEh3qYZZBstOl7knfv/4cFJuEcUjB13nc6Qda1j/U4XB25IWzM4PH1
 Yh+WTVwDuVAP+DvPbpSQkaXYPkOwqJFYrpupT/kpIeSqA9pLg7XpIIww1EyU9mGY7aqICIUxZ
 OpPGTQ+qs/ruKFkFUC+qv7DJIMKhtDENOMQBwG9DbghzdGNsWfPOoqsYN+VzAJ9xKxr9YhqqI
 mlBduiYBYtTBBjwxPsgBsYWA8ITBlOAk6t9s0b+wQSnCUH97QITNaGVq+gGCKUAo+hiSf0i92
 4qmCtskS4SkK8OsSpt1oUYpijvS8s7CZxZLCtLXPY6+Lc9CM5tqquGJcMEPn/hGsmq4xp0o/f
 w2K+/KRHVyPlhE+bkGUGh6fmQr6/AFOqpbFPwVOx7ypwY=
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

On 10.02.24 13:46, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/charset.h | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/charset.h b/include/charset.h
> index 44034c71d3..f1050c903d 100644
> --- a/include/charset.h
> +++ b/include/charset.h
> @@ -324,11 +324,21 @@ int utf_to_cp(s32 *c, const u16 *codepage);
>   int utf8_to_cp437_stream(u8 c, char *buffer);
>
>   /**
> - * utf8_to_utf32_stream() - convert UTF-8 stream to UTF-32
> + * utf8_to_utf32_stream() - convert UTF-8 byte stream to Unicode code p=
oints
> + *
> + * The function is called for each byte @c in a UTF-8 stream. The byte =
is
> + * appended to the temporary storage @buffer until the UTF-8 stream in
> + * @buffer describes a Unicode code point.
> + *
> + * When a new code point has been decoded it is returned and buffer[0] =
is
> + * set to '\0', otherwise the return value is 0.
> + *
> + * The buffer must be at least 5 characters long. Before the first func=
tion
> + * invocation buffer[0] must be set to '\0'."
>    *
>    * @c:		next UTF-8 character to convert
>    * @buffer:	buffer, at least 5 characters
> - * Return:	next codepage 437 character or 0
> + * Return:	Unicode code point or 0
>    */
>   int utf8_to_utf32_stream(u8 c, char *buffer);
>
>

