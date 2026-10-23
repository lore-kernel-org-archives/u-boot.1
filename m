Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DNWaJAf6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oJWModXc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 045DA812A4;
	Fri, 23 Oct 2026 04:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVcENng7CeEm; Fri, 23 Oct 2026 04:59:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3615E812CD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731569;
	b=gfuxa+SQsGZJvcorb02MVBQ1FIwkMOCPb46y9KpwSFV5uQksnUkQ5N5acUjHr6+HXb/B
	 ADh68rc+AMV5JEzRJoBekybl39YqEPqdscQdeTDpxP/Yny8vMmoU4qTCIv3m6UN3gpXtU
	 XeEE3BYQhlkZxWKy7L49T6Q/pgouKRYfaQuYH9ixwdx+Ybo7N78bf34ltzaZXS5RmbUCo
	 MI41NSQayrqJx5DaWIKmtaM/sAI01XVkNR47t5agKXMGAoxJmzAuOcAVyzttCgeU04E7K
	 76hxWFnSYyZpASb0m5UIaDfAvO+YHL+sW3FeWzuPcu5iRGxw27y8MCof4h/8QLHPhEQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EeQW//Ct+uDD8goGj+gCzfu4EXvnROEyC7IFy59YbZ4=;
	b=bqPU9wcbDsvlMMg9TzhU/ArWi5DMpQiFO42TFR2+H8JeSom6nHVGN6wOKbrqdzvgaIHd
	 nAgtxguRmToN49WLimpEdb1TYq59OYg8I/NpQJkMNpkY8S16YjUJ0S/DJR/E9zIrCsHZQ
	 eP/oL8q+9jYK9dfOXf7eCsOyB+ClULauAiUWBtPks0vWo1THzaOxS7o4CqYbiqufSAiCb
	 RwYRq8nG2x4B5bPYNTkoWyqwhIdY91i8tkU1F7c8+blL0lMPpP/dZqKeSqx2tzfdOK44T
	 wMnK/qPoV20g2kCQr9Zp3HsXXQ3j8dQTzqrF5KeAVq7YKDLXg7dv7GIUianEVNA0dOw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731569;
	bh=EeQW//Ct+uDD8goGj+gCzfu4EXvnROEyC7IFy59YbZ4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DNWaJAf6DE31R8NeVz0Z1T5zEIhYRSD9EH0ibvSHbaHZUyd7gvMLUIL5FShFe+UM1
	 UT5Pj0F0Zok/wxJRQqbLzI8lxhAHeQa+ex8knBwkLNeLstU505ric5v0+eJIbkQDQK
	 K6eTg3an6jJo1kdB9g/nROlpeVTHFfF5yZ+EbSHkMqZf2Rp2K3J0R/4OSNpd0XbvFY
	 EYpbWxNxMyXHduHCwgMbVd2XSEUi4cqV1+ZlYsMXG2IhmdI/YwBFAAbILpJ51DAyjK
	 rLPt+I2Z+xkwo0l/dnuGM4WAFl+lqJYLc3peruCU7sdRTlV0Io+D6zpIDUmasNKgt1
	 VMIh1ZtwG3ppw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3615E812CD;
	Fri, 23 Oct 2026 04:59:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 05C6022D1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6B1B401BE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yp175xAJ9aHG for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 04:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1D59940182
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::244"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792728382;
 b=ccijzPkyahcUl1CFS77UvhhRGyXHXyXMbAAFAmiVvxREUVh3cIT+UHMKk8qNE9Nr5ZTu
 9tMj2ke5+zbp35pzTePogHHlAJyotB6gA/pGZ9xVCHeTKgW6cni44tjILiLZpHNibsgJI
 3E5aC4Afg9DWO/9VoUwbi0MRPzB/GyuToNAxSFDkkzSefbH4Yf0IywkABn5727XOVMOEo
 KMM1rS1hDx0EKSHP3D3oukFw34sb9aYqAsH1xPwc7Ekzj4FjhHEtF51KrhYtZ+h32f3LN
 iYxgXRJ7PUvWpX07+yZLby+Z0msMJ9G3I8y5M0er7f+LyhbkSaisHvtsBynWpsF2Lgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792728382;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=EeQW//Ct+uDD8goGj+gCzfu4EXvnROEyC7IFy59YbZ4=;
 b=av7gLCLyV/uOqAfcgeuAF0hxl7DcEhRm/gb/BEzmZuaQUvMHrmSWBUaqZIKpio4UuWv7
 FUFhwOPO5rF3V7BiVpGENqIg0EyBwtlwodqhI8IbGhU9QmiEZfi1FBUpMrDzBYqmXymfs
 2MoDE9xit1Wx9waunxUPvRyh+E233FpC/san7AipGNoLUgb5R/xQnh8ACdo8HparD2BLz
 6hvMWUujAtc6iXLqjUQeu0GAQtprpsR+5+mBGzGQQZSdsjHCDKqVFNBHeIvyhz33rOoAm
 yL0RS9ycQ6T9rYw1asu/2b24E3EXGxE6NDvNIeWf6RoBELWBigVnzoGvFYfsCQA0AGQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oJWModXc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::244"
Received-SPF: Temperror (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oJWModXc
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D59940182
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:35 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-53dbe9b8d6eso285610b6e.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792728331; cv=none;
 d=google.com; s=arc-20260327;
 b=mdFw6oMj2w+OTADjJ6cqqZpmRzx7htTBEoC/jpFH4XOP0P+9rY1IG8j+2h6rlRguOE
 5g5ICvmX46NtyyDsShyNHuTfQspriZ178iImxq3/CdIFweChb6Cxv1vpMWtOFCayO5UJ
 0svA3QffskkGnDuCwMJOG6TfUK6b+KLAORHYNDNWA1AKlKkQFMp9+J7+7OeoYQLCMI9T
 XlsuK/1gLJGppeBzaEg1h3HpnMz2dYJ+tQEBpqoyOtHi845Wwcjj5I0knmDet+kE2KqW
 Fel/DlEBk+1ufCSWmLgCsrWoSE/DKISRZdUs6HCQqhWoSXcMa7xVPL7MGeSulzeR2i37
 mcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=EeQW//Ct+uDD8goGj+gCzfu4EXvnROEyC7IFy59YbZ4=;
 fh=fO/i0n3hYJ74cs21KGuyGF2OazYql2f81AfdSYYrRi4=;
 b=YaAVKFFBKPr63aTVH8Nr9VcGiw9KCi+l+Z3v39gNlVfdl0Ec4QB3m0EVmT/CcIjGHL
 PtFH2k1psqUpyEPZPgIjTq5uVMX8J0b2XzKsxXfSmGg4pFwJOq1jaz60w62N1JGY1DrD
 jcT0k9v01Z1cvw6ee1JEnU2lJhNM2UfraXTZYW7kXq3AgwC6sAcICDhs3C08jd1yYed2
 8ZHU+PN24VoiCOEvUjGvkWztp/qyFQY4XlfvliuvNxzMceSp/vO87EWkfaj5jRvQZeo9
 XQn4QY5wI08TpGyy4ZEghkSb96uau1E34ODmwRF7ILdaHVL/AxMcOCKi7WmYxhPUXSh7
 dTug==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792728331; x=1793333131;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EeQW//Ct+uDD8goGj+gCzfu4EXvnROEyC7IFy59YbZ4=;
 b=oJWModXc/YRW0dj1pP3c2N9OFeyype4dCgO6Zo3i3iXW1atd5Fi3mfb44WX8dWeZ/u
 tmY3vsl16dLjoMQYIDkRC9AogwsmpQX1gsmPdiBeaHu3hhIKmEkqhhx5Hnslf/inJi0p
 vvvcHn6Fz8H6jSmQCrHCtbGgjXktrcw8aSr3OQdvgPYqoDVWgCSsFm+F7d7dSs4hasQT
 J6mFblWr0qrmbUcPslR64UP5FRyKuiUqCPap44AzW4v/M4/UOvbcmZk2yNrSo0Q/ZYxG
 duKkiwaQ3PcMAhdIhQxIEvfbP/+BTwK3y37r9VJXBa1AVXOsX8epyMvGxmzST9HuuGZy
 fheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792728331; x=1793333131;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EeQW//Ct+uDD8goGj+gCzfu4EXvnROEyC7IFy59YbZ4=;
 b=i45Ml+0yICUnLwpgtjFJYKpy53p76HpxtAEI/NUXEB4hjwoOd2sE4+QUhJqB4WkGQO
 afZuT6Ek2tI1wAwoHL5YgYaR1ZdRUGMouubIR7SPQGKdV14A4QFw6UMCaowkpG0On5X9
 Gt9QYDfIuCRs74DeFbuUq9FS/wwW9C9dh6jBIeGOYQ4ANRZhnv7/fHVxS0c/EtFB4UoY
 6puq/S5fa1pX3f1ml60WTUq4Z8h/s+bDZwELElXgd20KySfGBL2pG2KmYkFYZ5Z/vdVY
 AoK8YWK/rsbwntqxaP+4hNUYYFD7LvB7vOI/qN8I3vsMJ9hy3rYQLndHYX2dNzAgJDZl
 sdrQ==
X-Gm-Message-State: AFq9FYIKsOWMM/r6EzYS1QKunLQBJ0N7hpHMs9ORrNRiRcpXPLXp/Vq4
 DCTbQO+0oyyQtc9H6d0vV/UugsHT5ZDnivW5BGEcD9l5HG34nXM81CsJQNgSVNfQkC50hloS7Fv
 4ZJOgegNk60jEyI/wACQUqsjZPQExw3s=
X-Gm-Gg: AYBFou0vUfvy6+expTEVhfbGaEhctEK3viMhrNlKSbc1ljXlNW7Ei8HwnLtPY+T8R32
 yI41a5idEdLjm/xO6L+qlMTNA+WI1dRVjFLuAoCd7VfsYlv+M+IRjjnLabfQJS/y/dlrvWEYksU
 MrFlAbzNIWl8AjB2kSEqJy9wiaMZAPPHkaploTJ7PiBnybLU1/EP6+QnogkLwIn6wP0/u8juLjj
 giaZArAPG0N3EOi43X8xRxLdKmWvh0OgBlYRPkZiYwEtAXa77aISG1ADgNh2smntwTzYCUlR/7W
 V0NYRVAmUeyCt1k5hy5WdNXu3whEhqvOU1atRCFQMh8rigv130MraD4VAp/WXWqfW+I51Su9N68
 amEaiqr4HD/k7eUF2nMnavLA=
X-Received: by 2002:a05:6808:2e45:b0:4f5:214:fb96 with SMTP id
 5614622812f47-557ef21ec8bmr2330982b6e.42.1792728331328; Thu, 22 Oct 2026
 21:05:31 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:29 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 21:05:29 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
References: <CAJnxHsh5DbQdf+UfmbSKt7xY4QvecGWdVzSo-xEFgM8yTBCHXQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 21:05:29 -0700
X-Gm-Features: AclHuK--6ztGRhy3Rio69c9yOftK9BYVB_TWkJ9Ja4_KdptNeHZGrpDml2oGdqo
Message-ID: <CAJnxHsguQ0Qy5sUKZovb4bX1r3gdjiRe1feNdgkR8AzJ0ZUeCw@mail.gmail.com>
Subject: [PATCH 3/6] fs: ext4: refuse to write with an unsupported block group
 layout
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: multipart/mixed; boundary="0000000000005e3a60065e7a179c"
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000005e3a60065e7a179c
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--0000000000005e3a60065e7a179c
Content-Type: text/plain; charset="utf-8"; name="0003.patch"
Content-Disposition: attachment; filename="0003.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: ca8408ce682b57f_0.1

ZXh0NGZzX2luaXQoKSBkaXZpZGVzIGJ5IHNfYmxvY2tzX3Blcl9ncm91cCBmcm9tIHRoZSBzdXBl
cmJsb2NrIHRvCmNvdW50IHRoZSBibG9jayBncm91cHMsIHNvIGEgdmFsdWUgb2YgemVybyBjcmFz
aGVzIHRoZSB3cml0ZSBwYXRoIGF0Cm9uY2UuIFRoZSBiaXRtYXAgY29kZSBvZiB0aGUgd3JpdGUg
cGF0aCBhbHNvIGFzc3VtZXMgb25lIGJpdG1hcApibG9jaydzIHdvcnRoIG9mIGJsb2NrcyBwZXIg
Z3JvdXA6IGV4dDRmc19zZXRfYmxvY2tfYm1hcCgpIGFuZApleHQ0ZnNfcmVzZXRfYmxvY2tfYm1h
cCgpIGZpbmQgdGhlIGJpdHMgb2YgZ3JvdXAgbiBhdCBuICogYmxvY2tzaXplCmJ5dGVzIGludG8g
aXRzIGJpdG1hcCwgYW5kIGV4dDRmc19nZXRfbmV3X2Jsa19ubygpIG51bWJlcnMgdGhlIGJsb2Nr
cwpvZiBncm91cCBuIGZyb20gbiAqIGJsb2Nrc2l6ZSAqIDguIFdpdGggYW55IG90aGVyIHNfYmxv
Y2tzX3Blcl9ncm91cAp0aGUgZ3JvdXBzIGFmdGVyIHRoZSBmaXJzdCBhcmUgaW5kZXhlZCBvdXRz
aWRlIHRoZWlyIGJpdG1hcCBidWZmZXJzLgpzX2lub2Rlc19wZXJfZ3JvdXAgbGlrZXdpc2UgY2Fu
bm90IGV4Y2VlZCB0aGUgYml0cyBvZiBvbmUgYml0bWFwIGJsb2NrLgoKbWtlMmZzIHVzZXMgdGhh
dCBsYXlvdXQgdW5sZXNzIGl0IGlzIHRvbGQgb3RoZXJ3aXNlOyBpdCBsb3dlcnMKc19ibG9ja3Nf
cGVyX2dyb3VwIGZvciA2NCBLaUIgYmxvY2tzLCB3aXRoIC1nLCBvciB3aGVuIG1hbnkgaW5vZGVz
IGFyZQphc2tlZCBmb3IuIENoZWNrIHRoZSBsYXlvdXQgYXQgdGhlIHN0YXJ0IG9mIGV4dDRmc19p
bml0KCksIGJlZm9yZSB0aGUKam91cm5hbCBpcyByZXBsYXllZCwgYW5kIHJlZnVzZSB0byB3cml0
ZSB0byBhIGZpbGVzeXN0ZW0gb2YgbW9yZSB0aGFuCm9uZSBncm91cCBsYWlkIG91dCBhbnkgb3Ro
ZXIgd2F5LCBpbnN0ZWFkIG9mIGRpdmlkaW5nIGJ5IHplcm8gb3IKaW5kZXhpbmcgb3V0c2lkZSB0
aGUgYml0bWFwIGJ1ZmZlcnMuIEEgZmlsZXN5c3RlbSBvZiBhIHNpbmdsZSBncm91cAppcyBzdGls
bCB3cml0dGVuIHRvLCBhcyBiZWZvcmUuCgpTaWduZWQtb2ZmLWJ5OiBBbmEgQm9iaWxsbyA8YW5h
Ym9iaWxsbzNAZ21haWwuY29tPgotLS0KIGZzL2V4dDQvZXh0NF93cml0ZS5jIHwgMTkgKysrKysr
KysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9mcy9leHQ0L2V4dDRfd3JpdGUuYyBiL2ZzL2V4dDQvZXh0NF93cml0ZS5jCmluZGV4IDJm
YmEyMTk3YzE5Li40ZThmYTQzNDQwOSAxMDA2NDQKLS0tIGEvZnMvZXh0NC9leHQ0X3dyaXRlLmMK
KysrIGIvZnMvZXh0NC9leHQ0X3dyaXRlLmMKQEAgLTYwNSwxMSArNjA1LDMwIEBAIGludCBleHQ0
ZnNfaW5pdCh2b2lkKQogCWludCBpOwogCXVpbnQzMl90IHJlYWxfZnJlZV9ibG9ja3MgPSAwOwog
CXN0cnVjdCBleHRfZmlsZXN5c3RlbSAqZnMgPSBnZXRfZnMoKTsKKwlzdHJ1Y3QgZXh0Ml9zYmxv
Y2sgKnNibG9jayA9ICZleHQ0ZnNfcm9vdC0+c2Jsb2NrOworCXVpbnQzMl90IGJsa19wZXJfZ3Jw
ID0gbGUzMl90b19jcHUoc2Jsb2NrLT5ibG9ja3NfcGVyX2dyb3VwKTsKKwl1aW50MzJfdCBpbm9k
ZV9wZXJfZ3JwID0gbGUzMl90b19jcHUoc2Jsb2NrLT5pbm9kZXNfcGVyX2dyb3VwKTsKIAogCS8q
IHBvcHVsYXRlIGZzICovCiAJZnMtPmJsa3N6ID0gRVhUMl9CTE9DS19TSVpFKGV4dDRmc19yb290
KTsKIAlmcy0+c2VjdF9wZXJibGsgPSBmcy0+Ymxrc3ogPj4gZnMtPmRldl9kZXNjLT5sb2cyYmxr
c3o7CiAKKwkvKgorCSAqIFRoZSBiaXRtYXAgY29kZSBmaW5kcyB0aGUgYml0bWFwIGJpdHMgb2Yg
Z3JvdXAgbiBhdCBuICogYmxvY2tzaXplCisJICogYnl0ZXMsIHNvIGV2ZXJ5IGdyb3VwIG11c3Qg
aG9sZCBvbmUgYml0bWFwIGJsb2NrJ3Mgd29ydGggb2YKKwkgKiBibG9ja3MsIHVubGVzcyB0aGVy
ZSBpcyBvbmx5IG9uZSBncm91cC4gQ2hlY2sgdGhpcyBiZWZvcmUgdGhlCisJICogam91cm5hbCBp
cyByZXBsYXllZCwgc28gdGhhdCBub3RoaW5nIGlzIHdyaXR0ZW4gdG8gYSBmaWxlc3lzdGVtCisJ
ICogdGhhdCBpcyByZWZ1c2VkLgorCSAqLworCWlmICghYmxrX3Blcl9ncnAgfHwgYmxrX3Blcl9n
cnAgPiBmcy0+Ymxrc3ogKiA4IHx8CisJICAgIChibGtfcGVyX2dycCAhPSBmcy0+Ymxrc3ogKiA4
ICYmCisJICAgICBsZTMyX3RvX2NwdShzYmxvY2stPnRvdGFsX2Jsb2NrcykgLQorCSAgICAgbGUz
Ml90b19jcHUoc2Jsb2NrLT5maXJzdF9kYXRhX2Jsb2NrKSA+IGJsa19wZXJfZ3JwKSB8fAorCSAg
ICAhaW5vZGVfcGVyX2dycCB8fCBpbm9kZV9wZXJfZ3JwID4gZnMtPmJsa3N6ICogOCkgeworCQls
b2dfZXJyKCJVbnN1cHBvcnRlZCBibG9jayBncm91cCBsYXlvdXQsIG5vdCB3cml0aW5nXG4iKTsK
KwkJcmV0dXJuIC1FSU5WQUw7CisJfQorCiAJLyogZ2V0IHRoZSBzdXBlcmJsb2NrICovCiAJZnMt
PnNiID0gemFsbG9jKFNVUEVSQkxPQ0tfU0laRSk7CiAJaWYgKCFmcy0+c2IpCg==
--0000000000005e3a60065e7a179c--
