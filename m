Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE900C47DB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B0A87BAE;
	Thu, 18 Jan 2024 18:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UourpVvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E443687BBD; Thu, 18 Jan 2024 18:59:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D2F87B6E
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 18:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705600772; x=1706205572; i=xypron.glpk@gmx.de;
 bh=KfhbV7rUTXlWjFH913OQGsNM4B2MEvpLg9CiXX91vEk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=UourpVvvdsTeWVC5fABsj2fu0ebHJxZjbE13c00d14+GTftrFn2GVMcpH1DuZUHy
 /L67dUKg7gjLtviZo0/9t4Kh6YAg4lylTTOtgADlrwQ7j7+kWYmAKCNgBE1gEmJaH
 ueBYewM1Zphco80dtdRCj4WCYPu+MVez4viPJuh47ynqJcvLuAhNeIqovbJIBRnhx
 vlg3w2LLbPFYJifMt/cxFUM1r/JDsxsKDZCuLgokDbjpyKY9GRhwFGbm7TaDwMfQL
 LlP/wAUd8ayl53jNHuGRxeFJk/MLLMLlr1yC9X5V7YI+dEwOgnFb3lyDogvLG2qS5
 CRoJUslSde9BHLzrxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.55] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1qidHg2fT6-00i9eU; Thu, 18
 Jan 2024 18:59:32 +0100
Message-ID: <a9307d07-ad39-4167-b2c6-87ed9de8d7a2@gmx.de>
Date: Thu, 18 Jan 2024 18:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/6] lib: charset: Fix utf8_to_utf32_stream() return
 value doc string
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <20240117-vidconsole-utf8-uefi-v1-1-539f7ce74fb9@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-1-539f7ce74fb9@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/TevuYFzGUaRIUIbXUY7ctLkvLGXtLk/gPt8DswdpBECMkuNGCM
 sULY6I3mVsfOr/ZkGyG/DtTyGJ7XWo1SRW2GGQgat/By6t10eIBuGI6DsZU8VuDo6zepdE9
 jCSlpRQ8vQt/75PKMuZn2hBZQ44gZQ/ZFsDY8G8H0Pa4XuhGdKaOa+gkadImu2ksq46NUQL
 vzdizZcqk8BGsqayvXzuQ==
UI-OutboundReport: notjunk:1;M01:P0:00KdK7Ao+cc=;P2kSnFTcwD5ETyZwJCqBreXLuBs
 ESkihiXqso62VabD0F3EuIGfEwujkIDgs1TkrQ9hRKjzuuX7+wI9HlVmTsk5sIFGhedyHwfG9
 k6C6yKTuTspBiIm2ytEfCt4MBk1wjNtP5WUx63IJ+Grks4IOfT/xBacBngsdlY8GAZGVQcOxG
 xm7KLgO2kyfoSZA6hO2jkxJjgMpm32Sgb1Bs4L5j2E0kizZliXLGb7GmKHHgp9AHTqgf7dXXd
 S0FwRdqdnyBQn4q0bxRZi25lA0DLu4UYJwvKlYhrhlvL3BZMF0I8+8FcSwgkFE8hGaZ5+DlRV
 LtpdXR0jTVGKRfLF7WqlWonDPGc/fXvw3lsXCnWvJeQhUKICMphFVzB8Fw9lISMr+EHVfMoXe
 PtKiooO+8Nfmk2ySjvrIq8E/dgEA1cx9r+zpyh2hyxPU22H47CPywIYqxOr/w5/JKtk5NKwdh
 DGB69zIwFQxBKOceQ7CHrKMfJNsIcenBkAkGgNIWScprFiOLfg6yq3kFlQTuSoM1vReecBpyH
 2tUOcfkys345EpMyhAaQkff+Ur/9tGjje3sxXOsry5pmNj3bUvTUhEastJ2juuxA2CMGxpdTd
 6mkvi7BM/8Lmrdl0tVBohzy7fDNurSa1JJ641dV/gb9ck9zXdag18v7RqYSIdycTXho4dpJgH
 uzxYQnGNYqe/npOMjl3NN22LS85l55UGeMV+oeYoiqabhF9fvlpGkHsS/9Bp+EZb1m9nZYRMc
 p1YBdEuWfXn3kuzbaSL6rCyYhcfglRSMdugz8j5meSrJcY2wH7pHxpCyV4VAy3DWM+WGkIO63
 azcA1lcLTvFdhUmnSpEACxRFWpr9J4mILkoJ4xeRrIaWKFCoNxxEMkDa5ge7bDvaNcEAtzxq+
 SWLwitlODMnBUnx9W2BBUl5RDyu6sH15e8LNpeNG0PgGNocSHlweYimkKCYl9VcqnAVWSyJgF
 Ta4wWhlXKnneVb/AQdHeh082nVQ=
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

On 1/17/24 23:24, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> The comment appears to be copied from utf8_to_cp437_stream() but was not
> updated.
>

Fixes: e91789e2f661 ("lib/charset: UTF-8 stream conversion")

> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   include/charset.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/charset.h b/include/charset.h
> index 44034c71d3..714382e1c1 100644
> --- a/include/charset.h
> +++ b/include/charset.h
> @@ -328,7 +328,7 @@ int utf8_to_cp437_stream(u8 c, char *buffer);

Without a further description it is unclear what this function is
intended to do. How about:

"This function can be used to convert a UTF-8 byte-stream to Unicode
code-points.

The function is called for each byte @c in a UTF-8 stream. The byte is
appended to the temporary storage @buffer until the UTF-8 stream in
@buffer describes a Unicode code point.

When a new code point has been decoded it is returned and buffer[0] is
set to '\0', otherwise the return value is 0.

The buffer must be at least 5 characters long. Before the first function
invocation buffer[0] must be set to '\0'."

>    *
>    * @c:		next UTF-8 character to convert
>    * @buffer:	buffer, at least 5 characters
> - * Return:	next codepage 437 character or 0
> + * Return:	next Unicode code point or 0

%s/next//g

>    */
>   int utf8_to_utf32_stream(u8 c, char *buffer);

Best regards

Heinrich
