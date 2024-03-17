Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A63C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 09:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923C0877AF;
	Sun, 17 Mar 2024 10:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JOZTEZ9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9F7879E2; Sun, 17 Mar 2024 10:30:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DAC8723E
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 10:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710667816; x=1711272616; i=xypron.glpk@gmx.de;
 bh=HHXzlZRihYyEJk8RS1yjosDuxifpDR7LkglQp82bpLI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=JOZTEZ9e2g3IUxdWDJAD257NdFVBreBnzLG2Qzr9fifmjagVpzaXbtJB7RghD7Xl
 PpQNK5aLTKHBnOFzimM8IsY6w2ld4a1B7H0GqN/DEQnIQZLUGrjZ4hWdBHGgQYKfZ
 hG0h7vBAtKSiFTGKdf8fdCeU7h/v0WA2QC67Blo7cBsJB2STbLHuLs6PD21EZY3XA
 SrulxmcEvJeqopl4zbGAoexrt5pUVaN2+5xvAZESSiEUNd23t0AHd1DrGqjqlmxMl
 qwEObBR0AsgDkNu5vbWiwPk6g8BYRvEU+my8HBJYD/LwxxFR3dAyMuDi/OtVksI1i
 TufeZnL3dqC/QYRVKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1r9PII3fKv-00hRdB; Sun, 17
 Mar 2024 10:30:15 +0100
Message-ID: <6e04fc86-1b54-4788-b9c1-89dbcdc08dd8@gmx.de>
Date: Sun, 17 Mar 2024 10:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] lib: charset: Fix and extend
 utf8_to_utf32_stream() documentation
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
 <20240316-vidconsole-utf8-uefi-v3-1-4e8a3d349447@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-1-4e8a3d349447@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wGilZeqwLGPuxKB8sBcP0qK2p8pI0Tnc4vqkznom2+ugUMGl6tb
 epIWRJJYomh1Q2cfPS5WEDuKOQQbbWMrzM8371lqtN7KQfACrjORGaWMdvlk9aE/Z36/fIM
 K52oaqNR+okDVT5Fnxf2Db57h+S3Vus9mO4Ryem4LhxJgtU23dmYGorANonElbVrY4qXbGm
 ux6lzxhQHR+Z2EjSyY2FQ==
UI-OutboundReport: notjunk:1;M01:P0:9a7oh7+BI38=;BULftyiE9KGXvgVYrDW9XZiI0o2
 fSVkHPq4k1x6hMttylbys9GA7Gp4/YG8GTNzJPeNwGzQC+jlabd/7exeoLhjKXRMgNA39AIEG
 uomm8rdcZrcGJXbS1bKJswJQS/juLxpVBDkNE3NFNYTbXbHnaywDuDR2ZgsCcAyNYHMzB2f8A
 Aej2Xyn/JMmbHaBO4dYUNQfrdjNCxN9AJbxQ6Xe8wj+yOIOboE/8ZZOISmFa2ImcuDIn2XoUx
 EJcpAzA7saoJ4SnzpZO+WnKBPAVbzPfEj5I3E4CU68v5vHfxHlsU/3EcW4NiAPQweIdqr2Ufh
 kEyLr8sSZN5MAtS2J3UBwgDZapQenlvSZOGrZ7rk3LNuypqEBpy6f+sLYgCsCi04M6l3FjJSu
 WHatjqmLM8GXIGX6X8UU5fz8ktopzrz+Ajo++z50+slVA7Hk39DCbhlEKfVki1lxd2bDoDj3y
 lJMkWmbaCP9BJA8vKE9EHrgRjmv7HVNwbeNxBR2YIyQOCMDlp8dJnARgbzAExppPQaBWY6TbE
 Ax8qvZUCtk4BTztE59ea23Tt0TKBvqleQFD2NIL5CoRMjbAFrVqevArgT31pm7rJUT8kFkwET
 D2E+xBkk8JkhxDNe/UkGyDJOwHz/iFJfnhy6BENGoZkSk9XoAfwF/7qhkE7D9yTvp87CfSYa/
 vreT+s2niBjJehA7XVK7QyMGBej6elPGtJZQ9S/p84514gxMoP9LfMqsT921BXCPckdJxEmfe
 QjHxu+yZgeFyU3QZOkzmz4QS3wziKa01DwiX/B6Ld/471KS3D+d8+0em4JmIlLPykBL+xlvFR
 7I2qTeYOHwBw9a+xpfMD4eLWenJ3vbXsFfhqKpU45lBOM=
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

On 3/16/24 22:50, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Janne Grunau <j@jannau.net>

This patch was already merged. No need to resend it.

Best regards

Heinrich

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

