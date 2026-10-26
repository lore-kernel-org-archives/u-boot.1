Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18945606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vVRf40Vo;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=g58YOvSg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD50405D6;
	Mon, 26 Oct 2026 06:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nt_VLVBYRsvS; Mon, 26 Oct 2026 06:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B2660405CB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792995441;
	b=HmRwJ85tsdhANdUIj8EKsg/Rcf/rsZMYsmYHUNJbn42YC9cu+0unsfcBnS1CD2cO+hKO
	 mBgi9qhpHC95goM0IEC9270O9tvSq5D3xbPdh176MUfYqO82v6lNVUHs0celdm/JYDJ+J
	 4W/QwecXBEiTDct674PDMRfLzNxJOCSgCKuojBjAMKkO0ccpNuz/1WOLBdlP3Lp1ChQcX
	 NjuR4faiQtvHPGAJEx0Y/lWzSi+UrJr94fC7SRiBrlGS8kcuxk7vQXB9qu/PfOXGnQrN2
	 E81iHUXr8USfG4tfMSmx+gn+7mJ9o6FDa1hZlSwcW+8OgtwBfukY3kIKIuJGRXClLnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792995441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=t64CHCYhHBlG1C6SjfqOgGaqiDLW9TdLz02lZFFfhd4=;
	b=Mz4MRZYsVcqc8tZ8rHBHfceGcft4kvMNGrTLAz+B+/0ZX1d0QXOIA5TJU6LZ28jnIxDY
	 mf3RN9xjDBHQBoYWbfzsA2M3dZeKYXjWz15gG0kOuxscTfAZBNAljSG0UIGAQNbVowCKh
	 2qeHZdB+n6hrY/pn/FMNh2op0/akLf0PEPemE0hSkxH6SUqy1F2csK1AYd7EpmfhzAGPy
	 YNJZPzgXfw/aA1fxIMLkxxmEgMxA2Jcs/L3yfV2/1mI46O75f9DR2Mfrc18x074uE0JVw
	 ONYxfTQJhZg32dP82fylsJwG4iVPYLnQjs5L4y5InLr6q0s7mzaXxFLpucx9ltlrkzQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792995441;
	bh=t64CHCYhHBlG1C6SjfqOgGaqiDLW9TdLz02lZFFfhd4=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vVRf40Vo0dRjF0LgxZhpz+QCBARZ8DzrkS6Ozn+BePShf70gnzEtvn1fyM40uZh7F
	 wh6l14zIUQNnv5mMDgCI+TK656YIQgZQT/SI5C/D0iZ0xdUET79fTqMzuRhYlJIeYU
	 rUGF+dFrKli5bCcnFUAvdPe9Fs//CSYe4WWgspZgXK+TJI9ciLWX3bvs9Y8kkEbExD
	 yWuDkFwFOOV4+Du5Y9C+N7ygTquc/ICJU9kSrfvbQeINGH9pEWlYPEiWs3xV1TaUQr
	 qdPgbm0J+KqN1mSpnuMiaaLOzOqYteIHizZN455IjwpQ0pD/tLyz2eTK6g3yJfqiNb
	 xXVGHL4I16o3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2660405CB;
	Mon, 26 Oct 2026 06:17:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 188EB235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:17:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0ACA180D3C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:17:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8PkCErTOTqW for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 06:17:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03EBF80CED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792995440;
 b=LIv16rVHmB8IY8Z6GgPp+TDt0HFjXolz2EAatgD5ltcMlJnLaYTWh9Acvf2XtHlhpP+X
 SpTN7ppgvPH8s2TueZCzvV8OHJ/8VNnglN9NV7VRFhRWHQQ7r45Hsfn+SztLfrlTi4ARF
 JLGNIB/uzP8W+VdZn6jhczZdaCSSxxWmV7lXw49+Tq2J7slIf2z2CJQa/scXStgVxxSLo
 oZzW5kxP50GwbUezdPVwmsepZYtZahefFaNjEAggRXs13/u6Xx9i/2diUbU//+B8d0BIB
 5r2JvpJCwIDOVheuSSVPLiLHQh0LJV/RfA/K+qbpoOQUDpUmQqvMtSI5eV9y9JDyneQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792995440;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=t64CHCYhHBlG1C6SjfqOgGaqiDLW9TdLz02lZFFfhd4=;
 b=S+nNky4uRCNH69HIQGc2xE36hMcMSvHJ8+snk94C+zWb/8vmwmlKJDOHLDQAM+Pbut+b
 hWUusqZ1ERg/kmWT4OZslunulNtCtGZR7hNHjOtdOxWo1mnU0k1kLgcyoW7cLYNsCCcQv
 jzKTyIg6nZiGkibauAnoUc9Kxo48w7XjwEjO4jZxACP8468jVXwDd67fkHe1XlCBBT+2a
 RSoErgDPU65uESL74f8LPOMvzJaH6kwNZ7ZS7VrcmZObfzGsziOcaJiuVXplyqhbZ1mLM
 29mIfvR8AZAgvabhPnnNkloPyA5h1084R4WyyLm77XoCqofF9S9gh+sQc/mloZ3bcKw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=g58YOvSg; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=g58YOvSg
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03EBF80CED
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:17:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 527A710B05D; Mon, 26 Oct 2026 07:17:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792995433;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=t64CHCYhHBlG1C6SjfqOgGaqiDLW9TdLz02lZFFfhd4=;
 b=g58YOvSgULBLvboy4UroW9Q3t9RPb7EJXEsRnWkpZqZh+4QGq+ricNy6teRxGU3M4/CQXC
 Un6lAG3+tF6p+SnwqHCHNScwWIq25vU0z00ChC3coQkaqrxeQlU1DRwMXDKWJgICrE/Fse
 zryU57M7RNjiBTiZSUJhzD9aPzUJ1IIUGSDCYcwxTBuBL7xMRc01w0ZSLA3np87AMuLkfa
 g+ixcsmQRQp+8hirXLhS8uVcnlGLhtSbyM+gqmfI4Yg0acGdm8kt3DfMx0OlPSuiK+14rO
 8uNgCjebi25NlVcPUkOL4iqX99iSvP9Ghg5rdmDq+5dKXtvP3nGze5xksGHWhQ==
Message-ID: <d0dbe72c-7531-9556-2ec0-f147d6c3160f@nabladev.com>
Date: Mon, 26 Oct 2026 07:16:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Altair Bueno Calvente <abueno@airzonecontrol.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: "trini@konsulko.com" <trini@konsulko.com>
References: <DB9PR10MB79301375ACA9877030AF8D87A4802@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH] fs: ubifs: resolve "." path components
In-Reply-To: <DB9PR10MB79301375ACA9877030AF8D87A4802@DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Altair,

On 25.09.26 14:57, Altair Bueno Calvente wrote:
> ubifs_findfile() resolves each path component with ubifs_finddir(),
> which only matches directory entries stored on flash. UBIFS stores no
> "." entries, so any path with a "." component fails to resolve. Such
> paths are reached through relative symlinks to the current directory,
> e.g. OSTree's "boot -> ." at the root of a separate /boot volume, which
> it creates so that its hardcoded /boot/... paths in uEnv.txt resolve:
> loading /boot/loader/uEnv.txt then fails with "file not found".
> 
> Treat a "." component as the current directory without a lookup.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>
> ---
>   fs/ubifs/ubifs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Checkpatch warns with:

   WARNING: Non-standard signature: Assisted-by:
   #16:
   Assisted-by: Claude:claude-opus-5-5

   ERROR: Unrecognized email address: 'Claude:claude-opus-5-5'
   #16:
   Assisted-by: Claude:claude-opus-5-5

   WARNING: From:/Signed-off-by: email name mismatch: 'From: Altair Bueno Calvente 
<abueno@airzonecontrol.com>' != 'Signed-off-by: Altair Bueno <abueno@airzonecontrol.com>'

May you meant "Co-developed-by" ?

Please fix the name mismatch, thanks!

> 
> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> index 6121fb0b1..fe6d0cd7a 100644
> --- a/fs/ubifs/ubifs.c
> +++ b/fs/ubifs/ubifs.c
> @@ -543,6 +543,16 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>                    while (*next == '/')
>                          *(next++) = '\0';
>              }
> +
> +           if (!strcmp(name, ".")) {
> +                 if (!next || *next == '\0') {
> +                       kfree(buf);
> +                       return root_inum;
> +                 }
> +                 name = next;
> +                 continue;
> +           }
> +
>              ret = ubifs_finddir(sb, name, root_inum, &inum);
>              if (ret <= 0) {
>                    kfree(buf);
> -- 
> 2.43.0

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
