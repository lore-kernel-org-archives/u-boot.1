Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G2ujDf2q;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ML2uBkDc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6384A60A7E;
	Sat, 31 Oct 2026 09:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wszG1scef9z1; Sat, 31 Oct 2026 09:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4449606A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438689;
	b=UuPNOk+v5xmkInmj6BPKlO7p6ujF9Xu3LnC79LIvNZx1Yt1A3yx4fyDZDOnf3g/pyJWw
	 6MfjVWFElZevgxWprI5Cg3W4xnCWVemSlpjO0UiKbWqA3knNB03ha04L41wkMdEebASb5
	 1+NIApSoW6Hfa52wwWTO1U7MkSXEBiPfUQcAKLiBBSZFcg8HDYJ1F9BuQ3m2VNhmwRJM/
	 /Rtl8OHj56MD+P5ZBv607NfH8+cZHb6Ymlvkz2uLxvA82vZfo43iz2DWw4xw6OZ4UNUF+
	 JR7qDuxD7M7fWN/PM3UGHCJEqG3Ja8tU8Rtvz1VdCcRjoIU+kyYU55Lyyf2pYwcZExA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793438689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gyDlderlc7kA3boAbppNE1zhabPM4qmxqI9pNQoI0CA=;
	b=hWRmjh3iA7Xe5zn0zhice2B9WAerpgqQ4L+yyVpSvkW01SQVUko4GgFwQ4GCEBHG/iMM
	 YwaeQumDAogXij1w3AF43eEk57pI+rtx5o4QrTjzsRul1N0DfZ4Phc5wtKzJ9PdAdLISd
	 hMvuPekKKMBfRTR+Hz7s4QCtBVjT7XY2ymhPaFiL63cCuhRntPb0L19LoiGs/MO8uqj/t
	 0/73WoH1khpafuOc2CHTQdVZdq/4ADNQ3rowHkQjNdLesgrqdbsv5n1sdgY/eAKEA8Odq
	 4VXAQK7EDmBke7mx2NmKtYd4OsgsjJndHIi/7csPFUbrlHiI2qpnobhT5nETmoBvrjg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793438689;
	bh=gyDlderlc7kA3boAbppNE1zhabPM4qmxqI9pNQoI0CA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2ujDf2qHV3cg1TFqJynw8pAkKFW40zQh/zZ+qZr4lBWQtkYSFwPod4693Urn5UY0
	 ASOUAl0Wph067aDN2YidQldvEBU8LTLTcFMAwyxzQD9ix3Q7Bh2JIwpl42chbBpxsR
	 JyuuWXyVkdzsLNes837wVFarsGqQT8tyP12YRXsQoTPwFN2svd3OCHCI0DvslAW9SZ
	 FwMBYf65pWgoGOmS43YWa4gnrL0WiwA2mxUtkYCmAdeWsuxusmNExeLUx8Ctu73USu
	 lXYNMe8tcQsZe8/PZ68UsfdRSKMbldT27/jOCQ83dmqBla1Hw7siRPQ8fRUbdXlJIm
	 9PW5dRUBsw5tA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4449606A9;
	Sat, 31 Oct 2026 09:24:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 097D14BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 073EF400F9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kct5dQpPog8 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:24:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 174C240057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793438685;
 b=lhZanQHH/Ls8cwQY050Hay7JYcrXLvBixNB1MRMTzfV9vS+42BPom5jhLivzpxb1iVlw
 FCWgrW6SeLwh+E1lDomh77OKp33Rc8ZuVhZoqdtN2OfxE9tYPlKNj3zuAjGYYRdSy+zz2
 3Ml4wSI8LB6AU514JxPurfKeiChgAYIVO4SIla58qIGpB7tzgCsX2IGTYkvGyfFNxFPhq
 IZ/8tfYYERIu5JycsXZOj1302wAszIRq3884X77EucH3l+hJxpEDs5+hrrEZ1keuly+Mb
 /8W73jGvRac5E2+6oK8jGB50menEZ1YBIfoF0SljZt1c0W6Np2Qj6WRbQn/uYTJeQfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793438685;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gyDlderlc7kA3boAbppNE1zhabPM4qmxqI9pNQoI0CA=;
 b=pQ9lnFqpAQZnw6fV/xdo75I3T3diPqeg3/44zFvoA+XmSI3YCHgG9AyJJQ7zxw0oeuI5
 XAgAPN6ZjVrBm98tH+WPgBPS8fvyujlxGwAtwtWngZ3gMh+MUl5QAMUq2tpBRvI3wLsHj
 iJC+zVqXBh06lN42fvbhizbbpf3eKm2vvvLpkMAt7NvAZKbsqzVljlwRSBxyPiWYjZKrN
 lTPKz+22/Y5rkoyNYHUFb3sYIhhfxHoNmbhsKEZ8u8fn1fFtR0gVACcPi3j/UM6jNY6+m
 ateWOIAFwEkVmypABYD3XmMgJO21poRBY8WokCTdZx33iHpDnYMdMr/35E1QIGPHYTg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ML2uBkDc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ML2uBkDc
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 174C240057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:24:44 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b4bd3d98bfso1699059a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793438683; cv=none;
 d=google.com; s=arc-20260327;
 b=Eq3TBbWWkeu1dT0lkcc/xnlP3kwlnLuSnYSsPJ7aVcgZF0dOvGf4H3RcZH/yY9Bzvh
 LJj00n1PO7wb8mBRzbmRQAreCHE7M7kcyWTDRmXhdNj+N4YeAEFoJ28Zx2CKitDJ6Zm0
 DjVw2n50W83fQ1FaoLq7h0EnGWUscNxQBkAQ3EnucVbaQBshI9mnwfaZ6LzCsWpSY9Rx
 0fcEk+p03ZylT9Nawe5Gyr7I3wFx7EL86c9Sif6fdpwrmir4AHJoDaJqjYeDGuS7BOr4
 H8RGrv1D8fIHmjU38Bds1ZWTcTvgURAv5CJgyYw+Y+m61z6aW3FwRas+7fAeNB189vRW
 W79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=gyDlderlc7kA3boAbppNE1zhabPM4qmxqI9pNQoI0CA=;
 fh=tfST3HCc0TE4s3bZkI6H56lRKPy75ztLBdimdwocQyU=;
 b=rzrlPkci7EtL8IKrYg9JYvlTCZq/WAyoFuw4usdPyLpQFzIyxCqU+UyWjQA+PGXfyN
 CITpGKSjMLbwSdoJlkAPlvmEOG1Ugkrq8w1K/IqRbZeW2tnSNXtd9HytelltMKsloYDK
 4IPa4JUqw6ips65vOTtpNxFLRimQVXRkdr6MIVrguPHDpjsUQpkMlt3Fnd+xo4l1+LWG
 1f5xYizHpP8PphLt4XIbTuyfmndNRoAAje6wrk224Tivvl1EQ3yBSkfticObtBzrqmTt
 CnPcvY6bR/yJ5qPmqXw9FKL0a3u7xNmwxgmlKKYJ8/lDIHUcntlhSwRGnQusiZzQAP2s
 d/2Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793438683; x=1794043483;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gyDlderlc7kA3boAbppNE1zhabPM4qmxqI9pNQoI0CA=;
 b=ML2uBkDcChIz+LE95okBtMp6Qf7VU69sxIUGmppgrH0Vfg2nb/9jJcUji7XDCJLIrA
 Qd96rLqwmkY5XDyrOg6WIpFvtLgYb8KhxV110uV2SskaM9uH9sJmqEtaJmSKQ5ctGOJh
 jg25s1rUWEQSXHHUBHkua3dia5q3p2oBsUhwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793438683; x=1794043483;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gyDlderlc7kA3boAbppNE1zhabPM4qmxqI9pNQoI0CA=;
 b=a+Z1EKbdJodgJ8NPggka0+8TTCHjIZuZ7GO0ueB47emDKKD9y1+MLjNh6n10ucwseP
 hs3zGZnQFkKBOmR2okGT3WBhVkG2oNvXuLHyUGQmCDyBmlze4r7LNVrpC++j9FnqU2CW
 U2f5nMiBB8rtwg10t18M0jphontkyI4wiC2d8Uy0N7uaamnSdWD1wdtMINEZx1xbPbjO
 MYWNlAd2pjCKgQ52so93cZjB99dpayUwWKayLupjPI+ANPa5JWQjijsszXHY+AWXhqRJ
 8suF7DxVJuAmGW4Y3MBga8EMMEgBfXrdQ/1gqjXIJ5+A+HpEXu3D+nJgfk4itsSzsWaW
 s/2A==
X-Forwarded-Encrypted: i=1;
 AKwUvByfIe9Qz5yvH3E2zs11uRPtMSwX51bHBD6+cot54n8tijaxiUBtjmomplcCNpAjs+2DNRvTeB8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIwkokRBN8CK4x7eB5y7z0dmSFWyc1zpyZbvikIzw5EZ0sO+aTb
 TrUSvANXBLcDXstcYWNlWPwI7R93pbXOq6X+5/lwNogCerp1R4iGDwsyhERdwCRbkg6bFG2UasL
 pKI1DMqIUrslYIoBDl4Jz6bTqX41cglyh/H1ZqljN
X-Gm-Gg: AYBFou3ZZvZmmopeLpUTHwFQuf7gGQysRkM1XnDFImYiwUia1oU1WsMPDuPsfJqy6b5
 naLzAWrcbPxKZTFhJmATI3H4TqT0INF7sIoRkVAeVElzpCGN49ftMrm6k1EOa20bbHiKbvElGRH
 lAw4fE9YMc55uf2d5hcgg6i6hfUI142s8M8fbHlhxzxPOKtjbdzGx6ReFdf/iA31BdxrtSZQlFZ
 qBHQrYwLHQhq8YU+lx1x6ndhjaHBTQG/NwDtmRKmWSafi/cRCdlJjPH9KSIwyvz3gdPt3Y0nMEd
 IMc1yW1StxmICdYqVRSkFp5avgxDPUllBl+kY2jbM+qoSX89Tf1mvdjxQb9biDt4vJRvsepyMHJ
 p5cPX9MP06iSFs1c2L5A03PlChI76cFeO5hzI4cmvAwKQS/RFmpC6j+JL2g0hpYVI7Phv0NqUiN
 rjOmOOeQIGGxq+vns5
X-Received: by 2002:a05:6402:5190:b0:6af:d968:dd26 with SMTP id
 4fb4d7f45d1cf-6b4d4d7f9c2mr3437755a12.25.1793438682834; Sat, 31 Oct 2026
 02:24:42 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:24:41 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:58:21 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1a8f4816-bae8-4fce-9189-4668f781ca58@arm.com>
References: <1a8f4816-bae8-4fce-9189-4668f781ca58@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:24:40 -0700
X-Gm-Features: AclHuK8ba-_32atOujE2oW4WnZzm_q9iEIWKXgjsYNxeujUtsqLExy94-x_aCHY
Message-ID: <CAFLszTj0P_B=4Piqbr9j02Ld3htr=0gt4CcD+G=VW2QFxgAQwQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Handle unordered runtime relocations
To: jerome.forissier@arm.com
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, 
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T16:23:17+11:00, Jerome Forissier <jerome.forissier@arm.com> wrote:
> x86: Handle unordered runtime relocations
>
> Runtime relocation entries are not guaranteed to be sorted by target
> address. This was observed with GNU ld 2.42 when linking qemu-x86 using
> --emit-relocs and -pie: after an unrelated image-layout change, .rel.dyn
> contained 450 address decreases. The old code skipped relocation of
> mem_malloc_brk in sbrk(), causing allocation to fail and log_init() to
> abort boot.
>
> The ordering check was added as a cheap corruption guard because .bss
> overlays __rel_dyn_start and may overwrite relocation entries before
> relocation. Replace it with lower and upper image-bound checks. Together
> with the existing type and target checks, these reject most corrupted
> entries without requiring sorted input. A corrupted entry whose location
> and target both happen to be in range may still be applied; the ordering
> check likewise could not reject corruption that preserved increasing
> addresses.
>
> Apply the same correction to the 32-bit and 64-bit paths.
>
> Fixes: b50b1633c022 ("x86: Add support for 64-bit relocation")
> Fixes: 62f7970a5a06 ("x86: Add error checking to x86 relocation code")
> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
>
>  arch/x86/lib/relocate.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
