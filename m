Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35439606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mvB2rXJx;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=c6UdEqH9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11C0E60AEE;
	Sat, 31 Oct 2026 08:53:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o0GEBBVNg7Dd; Sat, 31 Oct 2026 08:53:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2EFF360A7E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436820;
	b=bd92/PD0pspWTuW+IBwUSxTXnTCwwAdP5EcgT9S7wHA/Gur7mg0tOKR75m+DQl68sszK
	 3x5DQZck0URrJdcEcOsOaSPScklUERDmcnBBBpd/n+B5OqAubfAgTqtq+8N0OJz9FQTAy
	 MyQ6uoaMaR+zkkupagy016lgF/gqgtv8Bfeclc69BfPr5PUNjWUfsw6ike3nW9aRm4KRl
	 2KC40nYdR78ZYyWtCPflzs4ymcmy00KkMKcPbstrg/WwCfABPY/9sh0Evru2B+vpfVKnx
	 L2PcM3F4lUwgaLmSu7+M7Cz8kjHVckA5sXlmtVHgveZfHwzkB47EXAOkN+2oFuM71Qw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iD5tLDYZFfz8NF2jFQtzsoG9CKoxqgOwpJM857/wyWc=;
	b=o9U4Db/8lSWS+7nXRZbgOQCkjf/zywcbRgARN5M6GthISE0sAxBNT94g2vyBAySwWXda
	 o0wEDu8DvsTMuoRoARwml3C5a8MHZga3l+NTsKxinVvDb42hoLOm3oM+g8JbkwNU436ay
	 oCb5JlvL4/kYBRTHvyd6DCa0J0XD2Ire94B3aGpnUmAQuxgKT8fgiFEgTW39TxIP6XqeG
	 1nWVl7mq9fD6lEIrcUyPWGysTP3RU5AWLwrD59ViZ2Rt1/Yo0H+6mAkBSCBxpm/OZycV6
	 wum4As9u99Z7drtfGTCee8kHwwdyKXZg/ZoHBGiwRnaWGDAcFzbKcF7qapCGAlXcDXA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436820;
	bh=iD5tLDYZFfz8NF2jFQtzsoG9CKoxqgOwpJM857/wyWc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mvB2rXJxL25Um3dGWrfIUw7TyfSguOPpqzpDS03TmQxXMbATZhUPyACP3unux+z9G
	 /OEDoV0oceHw9eluvtm/jtX+mstKK4VGPSy7XrVVOqZqWF0wFbfo/zT2jQ6adCv2J1
	 8wBfs+NZ/wTKoeT/aPKCBXYbIb79Gq9j32s3iLWh6s4ZQWAsVh0ua9m9Tx83HHKGxI
	 rN3RUXJLMBvp0NpCiNUDGZf1dnBXUj6VzYN9DoAgjkZ7MIive2CDDZpA1WWVIu36ec
	 EWe7VmeILOcw1wReNTl/tF+LbRmOiRhre+VukfHNKu7QjQ/2YylTg56jg/LSdtDJ0d
	 /leH5HiokIstw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EFF360A7E;
	Sat, 31 Oct 2026 08:53:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B2D41DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70D96400B4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHkLaqvPFz0Q for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C005840057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436816;
 b=HcPe7Jb3v2Ue9SqQSf9uMHvR/tbydMPraILUSxWuohYL9l/VEK2dS75gpel7P650wAWJ
 Ux7/b7i0rGClke9JnIDme2psSDaxI7U/q5r5BdQcxA8jD11nvdAEkl7f7cMNF5CEjQurl
 5J5kQ40sAGndKYKszu++LjOqvKg0/HeXIS6Dx00rjeshru8lrJCaELtba/mTqJ+QYnHwd
 xKGWuptGi4lRnrW9RE/yqwjpXJgqbhtJmLCJ+QKLk1rna/vpgdAuyuJ0OpCshO54Gt8ZL
 JWC+vA3UgzBJmat9RkIH2XB/h25CiePv1qJWyOG5ux0lrL7Oo1guI3Q0ezgR7LUeK7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436816;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=iD5tLDYZFfz8NF2jFQtzsoG9CKoxqgOwpJM857/wyWc=;
 b=DyZwm0EAeP3+wV6qyD/xBVEvSj3l7I42D9NZ4P8efCirSWUQnez2pNV3r0xCQtM57paM
 QLP47wO+y0SM5YQf+9+Da6ngbcO4JD27qxuuXo8EBhtPHLrAowO11Og9xlyohOyeNufqb
 AFbGGlF1/9R5+jq8UjCWAsPmm93lvsrli3Jgdw/wuoZfStnu3q7fzEhwzv2G62CfIHkox
 88fWETkk12o5yeQuJKG01yxWflHIK34NhAwj8Ol0VvMP30eMIKDTMM5abZyhrtEP+Hn1k
 +lApxHJGO7s6U04gesOtxB9c3e8qZ/o1hIPWUc0AsFMzBXd8grWSVZqx3D2xsTXWDvQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=c6UdEqH9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=c6UdEqH9
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C005840057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:36 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cdab938dc83so612851a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436816; cv=none;
 d=google.com; s=arc-20260327;
 b=jy+yAjO3V3HrsBXh2+VmDJKpT3LNo8+q+NaUjtBg1a69WKkovPn20AjIDW4oKYC9Oh
 YQaeLvMp8TN6qe+i4xONO4RWgfeb/Zr5QjrI0IfI5s3VxQp9MCWEfAdEJS33Lk+Ma+Te
 zK8YHCtmeMpTonxsLvBkmVQjtPq5o9o+uFjmUquaKltm15K3FPnpaJlcRBnGMbFCed0W
 /OI6RWLA+1THZTn++n4ge3Dh+ow4TtMsg3dpAciCo5rApA5aPT+Dqi9qfUiMWmChCdzi
 cMiHDRLeKWWKTkRcGitlBfmvi7BKI+mTCbMxgsDSnficgoh4ty51h6HQS68J/CneVPXC
 2XSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=iD5tLDYZFfz8NF2jFQtzsoG9CKoxqgOwpJM857/wyWc=;
 fh=14V5QZ2qJWOmkUpIay8f5wLH4+hU5ubxJ+YNB0Krams=;
 b=Fl5gwycOUN4tcNO8ikuc+2JTTq7IeQv1tUUvWk54H9bMsCH5iPh2gWWH/2cypDaiQ9
 r0ozKwpMEUsJBwMP8mjoYptxiv/JqrA7VzdU/uOPTU56OeOOb8xC+AEq3CzdRqOfKtSR
 j6tS/ShivA0Rs08VFIPXnq6TAFdfm+lO8+w+2VoasJE6Phj5JuFuJsxXWtkY0yH2YFUN
 JtX72VfLyHirCt58ePCG6hxM0t2HvNmrgLMTZh3T01stAk52jFiknRVMRuTP3cac38fz
 5ZSgBUSxzuTIJGn9Bf/ALf+qCVcyEFLiDyC0aLC5iAMwkBy7D+HwXbVt0xMSyDV2TGGi
 ShTw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436816; x=1794041616;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iD5tLDYZFfz8NF2jFQtzsoG9CKoxqgOwpJM857/wyWc=;
 b=c6UdEqH91V0DvdvpSOpR38yNI6loQj5kq4GmxzGrSszlHZvKnGP7gX85OcSdVDv5qp
 172T9QxxEYx1XG8e8ZwGJNqFa3NdMNpXNHprL7FTyEddNNleKntvBbAeXCs0U/FWyMWo
 Z1G63S4++sXrbe7L0lmKLb971Lj4HvbIttzSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436816; x=1794041616;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iD5tLDYZFfz8NF2jFQtzsoG9CKoxqgOwpJM857/wyWc=;
 b=UHp+Hyz0GyGswuh9fu5N5Ypz/+i1ZGZGLpKv18FyqXqPY3wsW6e3u/uF7wcOGEx4Oj
 N1PBRbNqoHGcZWiRaUch7b4WXQAFqcbRt/GpNlV0w2KMO/WfxaiAEL5NSr8OxW0QVXNH
 kWnR2cYlHJFrFuumO7/J8k0X9Oe/Au0aPJfmJuQqJm8DjcuMB5tupwuAgjPx6X5/wGdW
 f2HR6LwzwKOu6NJZ84vLKahnosvbclCFbQ6GSH04AeM+NL/DDd8prCVEUpXmPsmS3fAA
 q0Uy/xXs4oys14H7muVRQd9/L/TtdOhGmJJDsCx69/ha5pu5agPe/vqEx0o7LEla9EE2
 kW5Q==
X-Gm-Message-State: AFq9FYLQ2rutv8msV+7frxagp98bfqZqZ5YNMQwkrIJIcRExby/zPfkY
 gTG9RqoPjcshGngj756I/AEK7jVfUUkcDJ0NyGqle9aDD+W4vbTdSeWemgwa2y/9aEBOZeG/DY3
 XN+lk0Hki+/4hoObXJOwZWSffKFp6gENw6SGfU7EA
X-Gm-Gg: AYBFou1O2HozMvAzW9dBNdyUQllb6blV4ZKJIpB+1BXdpyZLu6Hl2in189NW9DJTzPJ
 F2G+qQP5YQC51IDZK+JRKBEEHZS80Coq3T5l8cDeXX+fQCPnlqGGTM//sQ6e3Nftw6VPybpW0K4
 SVPDOSzaMmof8QffxoZrvB5JP523Jw8PZOuzjb0UC/9F+HWZ3inWSRQrozkNy27jxyvsrdRp0go
 SkKNE/Wp6WRbwCyMGoe03IOvzblMvOu6F/Imk/r4RXrDImeB6Th4MrcUWVNUO9lB00x86hGS3Ug
 toppUawb3kc31e2b4l7Y6s03Zw70BYaRkw+5xnRxKcIEqWnNDcPCcyy6u3i87OaoQpMl1qS4LTC
 aEZPOlLaqdLS85CrZixxw9O4ycG4Kri7T84IIVEdwYlMdhcGbn5F7h2wPsjSjHc717oXZItkt
X-Received: by 2002:a17:90b:43:b0:3a7:e126:4980 with SMTP id
 98e67ed59e1d1-3ae8979de24mr3753406a91.43.1793436815700; Sat, 31 Oct 2026
 01:53:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:53:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:46:47 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028103102.414657-5-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
 <20261028103102.414657-5-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:53:31 -0700
X-Gm-Features: AclHuK9FMRiKveay5VvOT1Hz_cX0oIQHB2OS6hikca6DXWqyysaP6BuxH2AeRTI
Message-ID: <CAFLszTjTKmsb4HRVOuDsbmHHGn1kHPntL+LOyrYPEZtAQz3jwQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] lib: rsa: Accept .pem private key files as a
 fallback
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-28T10:31:01+11:00, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> lib: rsa: Accept .pem private key files as a fallback
>
> Allow mkimage -k to use a .pem file when the RSA .key file is absent.
> Keep .key precedence so existing key selection is preserved.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  lib/rsa/rsa-sign.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> @@ -176,10 +176,11 @@ static int rsa_get_pub_key(const char *keydir, const char *name,
>   * @keydir:	Directory containing the key
> - * @name	Name of key file (will have a .key extension)
> + * @name	Name of key file (.key, falling back to .pem if absent)
> + * @keyfile:	Explicit key filename, used if keydir or name is absent
>   * @evpp	Returns EVP_PKEY object, or NULL on failure

Since you are rewriting this, please can you add the missing colons
after @name and @evpp so that kernel-doc parses them properly.

> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> @@ -202,6 +203,17 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
>  	f = fopen(path, "r");
> +	if (!f && errno == ENOENT && keydir && name) {
> +		snprintf(path, sizeof(path), "%s/%s.pem", keydir, name);
> +		f = fopen(path, "r");
> +		if (!f) {
> +			ret = -errno;
> +			fprintf(stderr,
> +				"Couldn't open RSA private key: '%s/%s.key' or '%s': %s\n",
> +				keydir, name, path, strerror(-ret));
> +			return ret;
> +		}
> +	}
>  	if (!f) {
>  		ret = -errno;
>  		fprintf(stderr, "Couldn't open RSA private key: '%s': %s\n",

As with patch 3, this adds a second error path next to the existing
one. If the fallback fopen() fails, the code could fall through to the
existing 'if (!f)' block, which already reports the path and errno;
you could print the '.key' name there if a fallback was tried. Also,
if the .pem file fails with something like EACCES, the combined
message attaches that error to both files, even though the .key file
was simply missing.

Regards,
Simon
