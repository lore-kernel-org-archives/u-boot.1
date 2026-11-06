Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A6606D805
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pw6dLRLr;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=IXCduvDd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D27BC608BB;
	Fri,  6 Nov 2026 19:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zpnaWXagfRRd; Fri,  6 Nov 2026 19:14:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 19AEE60744
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793992484;
	b=jD1djp/f1vgI16XKn5ZCi2QjdYEBGCakEwRygA/3D1Xb2tTDZeeR2IpOXFWqMOjilAVY
	 2ZItJfBwptlt6pXkmtFuO/1cjzqNzMgLomCje8C5xbOhgSaHutcO8b8afP6JZ2czn7b/Q
	 nRumGSj7j0YznfVAdDDrn1tlP7T7yG2kjbgIMTj+h+8KCjGXaO9ZvDK2iERC+Y5kcSAry
	 +oO+P6JR/rW4w2PeC6aU0XyFLUThuau7hZyamPIwkQgfTwCv8iqD/CAWZyE3y1Iim7Crr
	 kUtCn5AFVvdYTLnsj87y2rKJ2agvJdVTItlRKNxXpyFAJGTHmtW+uCFyL7ct+4s77Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793992484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=R6EJtWz0S1zWEO763oxHgmbQVQcCGxtIUuNo1F0439I=;
	b=rHUdSgV1RLY2Zjnr3Ayr6muT5ytPJgBFW5Tocq78hEomyHi9pZ5Nrtvri81X38dMA+VG
	 yZnWFb9LwIeaRHhGAAmrCXBQlywKdGE3dKWXcs9t0+9Twwq+D+rMxHTv9EisoDymcgaaS
	 WX+20xFsc+qoyUfIQSnm3sOyyFoBHttex58iXrXGRGA2nGPy9v7542bsq7PsfbOHo72gF
	 IJMutoXxTRJABXuyqT/BLrWbntkmAF3loQQNw3WTob6GlvpOZcENwd7/DWVrTzPImz1xQ
	 PJXhEuHUDK3sHveiwZs6vlynm9fU5wgVWjdGhA0n6CJ2mpYXkEc1KAz0ZtNOXKVoF6w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793992484;
	bh=R6EJtWz0S1zWEO763oxHgmbQVQcCGxtIUuNo1F0439I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pw6dLRLr1aM6piptBn5hVP4/5JA9j7FjMTlA38AXIOxmF0DcoXrB9VoQWtOOt0oQY
	 jbJZJf/iVw3lGMlMSxvx9HHMT9cn55zjLO/0EKn626QRHLqIgnXJ5QbjsI6VgVzM9L
	 EbbhKAd7YcsJ5RxrCswRl3Wx/vFpATU9PN8kpoO+V4HpU2ALKOZbYP/COgFATJvJhD
	 WSKwB94MqcAUjft0DcUPzMPluJKK+czUXtlorXHoYkhvXveQUcNdAaH/57bJKEyTBg
	 ozAaGkSv5i7QTXMbSmFdpPnJjrRaj2kq8unvDpyfJ0O64/uVn4iSQ+IrHWSDsQtCm+
	 WqVOojPOXo8IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19AEE60744;
	Fri,  6 Nov 2026 19:14:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 294F42E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1AC614096D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qRd6EuMylItE for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 792B840980
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=IXCduvDd
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 792B840980
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793992476; x=1794597276; i=xypron.glpk@gmx.de;
 bh=R6EJtWz0S1zWEO763oxHgmbQVQcCGxtIUuNo1F0439I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IXCduvDdfqq6TxAgqpItnNLop6123WRCRw3YMyyvzMIOu7VYOGSnw4iz6tQeM7VI
 2V21Ts88EVI3x/krYA1VuE4fd0vTlQ1TMeXIWvbbdohp/dbd9U7sXaooprE/AATs4
 mfBNc3CICg0QcXG7s24i+e3m+SoRzlIHv4NG/Qq+OeF7gq1uckWic+U+dnGIr3ldx
 Jsz+o+CUE6hqMYKYIVwcCq/RK0i/+HkzmtlRjMb4qz8qG0WNQVQyJWEqP3Lnubatk
 SHi2NXe/UKrwtUpO/ZN0L6cQgn0A+W/wN7BQR/T2RNIBLj8mvN+MQfRs27+2tTaT5
 Zs78HMm/tCb1qIU0pQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1wNF3u1BNq-012azi; Fri, 06
 Nov 2026 20:14:36 +0100
Message-ID: <7fa987f6-0e2c-4926-a1d2-8269aa096ff6@gmx.de>
Date: Fri, 6 Nov 2026 20:14:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] net: lwip: wget: accept a reply without
 Content-Length in the size check
To: iav@iav.lv
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <20261101-b4-wget-blk-r4-v1-1-e27a009e4043@iav.lv>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261101-b4-wget-blk-r4-v1-1-e27a009e4043@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W/FIC6Sv1Zcg5oaeo3zvhlRIOamaAO111olbaHp5k3O3a3m1JNB
 U9yKaWlYD2ru/H7UMXjdEy0XEGbZ5RiPO/uoObrzKLVE0vGCJvchnpFca/VGco80mwWbP49
 gpEJHhCulm5ilDS5gHJ5ZNKIHHIBpuHjuUooIXBunSJzIdDfjWbtfPG6U4Kr/rbsQ+BKxy3
 mlxrNKhukqTPR21aAKIlg==
UI-OutboundReport: notjunk:1;M01:P0:MH0nBlJh+V8=;krEWLM7MLII6ibsWg5K3XG5yP0H
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 06:53, Igor Velkov via B4 Relay wrote:
> From: Igor Velkov <iav@iav.lv>
>=20
> lwIP passes 0xffffffff as the content length when a reply has no usable
> Content-Length header. With check_buffer_size set, wget compares that
> value with the buffer size and refuses the download whenever the
> buffer is smaller than 4 GiB, before any data arrives.
>=20
> Skip the check when the length is unknown, as the legacy wget does.
> store_block() still stops a download that outgrows the buffer.
>=20
> Fixes: 1327c2a8d651 ("net/lwip: wget: integrate struct wget_info into wg=
et code")
> Signed-off-by: Igor Velkov <iav@iav.lv>
> ---
>   net/lwip/wget.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index 96ee600c5e1..615ea035a28 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -6,6 +6,7 @@
>   #include <display_options.h>
>   #include <efi_loader.h>
>   #include <env.h>
> +#include <limits.h>
>   #include <linux/kconfig.h>
>   #include <lwip/apps/http_client.h>
>   #include "lwip/altcp_tls.h"
> @@ -285,7 +286,9 @@ static err_t httpc_headers_done_cb(httpc_state_t *co=
nnection, void *arg, struct
>  =20
>   	wget_lwip_fill_info(hdr, hdr_len, content_len);
>  =20
> -	if (wget_info->check_buffer_size && (ulong)content_len > wget_info->bu=
ffer_size)
> +	/* lwIP passes U32_MAX when the reply has no usable Content-Length */
> +	if (wget_info->check_buffer_size && content_len !=3D U32_MAX &&

Hello Igor,

A constant of this name does not exist in LWIP. Do you mean
HTTPC_CONTENT_LEN_INVALID ?

Using this constant would make the code better readable and not require=20
a comment.

A script like the following probably could be used for testing:

python3 -c '
import functools, http.server

class Handler(http.server.SimpleHTTPRequestHandler):
     def send_header(self, keyword, value):
         if keyword.lower() !=3D "content-length":
             super().send_header(keyword, value)

http.server.test(
     HandlerClass=3Dfunctools.partial(Handler, directory=3D"/path/to/dir")=
,
     port=3D8080,
)
'

I am not sure if would want to add this to our CI for just testing a=20
corner case.

Best regards

Heinrich

> +	    (ulong)content_len > wget_info->buffer_size)
>   		return ERR_BUF;
>  =20
>   	ctx->content_len =3D content_len;
>=20

