Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE235606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xzIvW7fc;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hkj8B8/M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92AC1607A0;
	Sat, 31 Oct 2026 08:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T99C3KaNSuOx; Sat, 31 Oct 2026 08:34:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C846E60895
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435667;
	b=h6Oy66R73Wdixq3Xhlo4Msj+mUOlN0rUxy0CKgLJ/wdonqDbl59D1ETJMy3379ujFpNS
	 XFNR91V1YLF2FSGasJoKuZA3rPj2jZFatH/Eg5Lxgu9H3G2VpaBvM/IGsxuknPe25G/yc
	 0Rb4Cv+2YGSnf+wLlkBedqnCw4cld6sKzeTGG/V7wAUfqRgLMUMFv4Ir5JwT7lENYQ+DH
	 6CGv9vDdrvDsarsfhDWbQ7jP7MA4is9ylsewE0YunW11k8Qi9tJDtEbbref4gYPjqg+by
	 G103Gkc1CCLZX7xepx2cZtxi/IpUtjoI3cg30oY9Q81r4FskF0Eq/AcdBhWSDTCBD9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793435667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=96jzBiVY30m9Ux7FWfTeUCaLaYwOjjt3HXvLA+IrHRI=;
	b=fiiYLwf6nJ8EcKeTKXR0VX1B148+/HtSOfwX1D1KfNcqAE+a348iWjuU6YhVQezxhtaZ
	 TJQgOovSqB3siph34jsCavD83M6llEqt2RtvQ8n7Ll+8dkwv9W4o/qiHELPONue99TyAa
	 oQ1ZEuCPkUH+SrpllJWpH1kGbQj38lfrZVRGTAXV60ALYR25B7bzR8smOaDL+Z2Co8M3F
	 v9jwEuo5p6bjZNW12gSDPqEy8mz6DaysrtZzk+WBl9fiXXY73tyWIGM8FFKkcmlpUlAAa
	 8/dzwJ5yEzyQA7fqD3ujc3bNXfNSwS7TGZbf15pOZyOVhvG0ZVUZnPK+Yr8V3J9ieIg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Hkj8B8/M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793435666;
	bh=96jzBiVY30m9Ux7FWfTeUCaLaYwOjjt3HXvLA+IrHRI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xzIvW7fcBjnlyNAhopFocPqf8hzqgA/hFZpoLtHuPXXXmvsgZR5oqgrteXy6MUr8Y
	 VPQ4dT0xrfJXeh1jcUJVmiBMfTsianJKOJKaEWG8Nn6Vq6lQ893l4uTBCmKO6O1BvG
	 fYzEBjf19kf3VH+fmumjazFwPfmCBw15nFnS7U3gkNm92IHHBR+O5B51Im5UgisN72
	 HYKVNp4sjUfRYeYqotbGRYjc2B4Z7FI3hZ53QUFRua3jAqDuwFtFaX3ZxKPNA7UbRI
	 svoJDK7TrZcG4XyKaxgsL5eJgBmVLg1c+tCvonv8fo3Kkbn+QHBrqnaoUn9KVUYTok
	 3yav5gFHE6FjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C846E60895;
	Sat, 31 Oct 2026 08:34:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E349156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3422A60895
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avKu4jTsDu2R for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:34:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F9D5607A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435664;
 b=ZB3SyZrYgk5+olMZW+l5LGYRuYsG7HYSz1VHhM52lJYmUuHA9wsssrRdzp8q7HDlWh2P
 9j84p6Xh+sDcLjmHC62+Rz60mbg8fqzuAS70pZSiuuggnbrkdIdtj+/iFVMJt7g3fhIZP
 cFND3b13C89n4PPNsveCOlRcWEdtVsJ+HSRnE8tZ7c5LmnWayND/bEMa6MJQJ/a0mEUBK
 DnDBq9PiMJSVj6XI7+sCrDTWtkw4Q8NfNGH681WwtgZektIgbDQdmkINi4WfKS3KtgEFt
 VZWhvDOzpWEyRjqvjlUa0DsC0/2dArgX1WHlDIp9PcFrma3KsYoaDCvdfosHiTo26uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793435664;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=96jzBiVY30m9Ux7FWfTeUCaLaYwOjjt3HXvLA+IrHRI=;
 b=JHpOyjXWWbDOweQwsrXZURFrOkL8RVtj86XjmTj9rig5Sd2WK2TKRCouguQ4J9x1ZT0h
 AB6rmIC68l6hHxi959SBHxyoUUVuSRlySabfcDm60xqvN5KGcbq1EcSZEGGhsAXK3Mej4
 E5+UDMbErw5lwGyI7LGk9J7AIKK9n4YokD0ugS1l8yPZ90PsYuH+/tUnhHkvyWzwuDNAb
 NowhSgtwMRgeqXf5EKrI8dKk9cUZ8gROa92IlSQO5DnCrEk5+6Vqs1sgdgqaDydIxEfnf
 CUodf76HdBA0JjfxbKMxsPjcde/g0Fjz/p/Ex6ZxnbDbsFekCnEfed5uBBADTms63pg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="Hkj8B8/M"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Hkj8B8/M
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F9D5607A0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:23 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso700128a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793435663; cv=none;
 d=google.com; s=arc-20260327;
 b=hJbPBHST6WED31sdg3ssXETXGGJPyZhXgeC/RYX5taNEJYfEBeFh+8sbcuC5NlFp/3
 sxQVkaV+HbxH4Gp2unpW4HIoXCrIehhuibEa9VzMX3hnqLbuCp6a0nsBEIj6ThW0Bm6X
 F13MbctbizLVyADsgRwdWkOa3xkHlRTj8v2EmDbUGa/GoQf08JXrFS+WC1FydWINIspc
 gyVfIic8ci0KMdRRrPFhg9H9o3R3hLcQ9P807qRkraV+YgGGZ4JvALVTNPbgkHVtZ2df
 zyhmh6Gg+j9Zq7kKXNtZkWCop97pU5T2PmcMXvRgu/2E4Y5X6vct0kRl9Fe0Sa7pS+JU
 YbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=96jzBiVY30m9Ux7FWfTeUCaLaYwOjjt3HXvLA+IrHRI=;
 fh=VN98Y0auae+gfOO5vPHq5BCDyz+eiCJJZ2MVhrlBNbY=;
 b=rn/Tb+lHcRgej73n8c3NV84a9FZNG77A1gCmn8C1zsk1A+SPXgVeAwJIL8PU47VMOz
 LnM1E8h4uVKAdTDubo0d7+PzqLPphQqTG6VPxwNjeIPZRTvtIqODMo88PRDSC9qVDcD3
 fx4CTeb6SBSB0jfHqdRspAYU4B/GZ6gr9KuuhCqiJUXC+sQO9yIQewEpH69jv93caCpN
 AgFO3urpSrvG7yqzzsH/FkzybBWys96SMQPkXJ1Ct4TAmgtFdm2Nclttfd4KiMc91BUm
 6jPcxrwuPREDPadM2aYg90yc+ik+Gb+kEtq8r0Hz2DPnH33QLS+jB7Zj2WxNsBEQRJ5+
 NVtw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793435663; x=1794040463;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=96jzBiVY30m9Ux7FWfTeUCaLaYwOjjt3HXvLA+IrHRI=;
 b=Hkj8B8/MSIYwR7NbaoleXaf94Yae9GxLD1b908khF6OC2S/74i+bZ7TnS/P8ACfmI5
 g+BlxWaOdoHBPXm1t5J2gytxxYbaOzw6ARxMWIB5VnTZulC+ViADBlNsjjNQvntw9gbY
 bmGHFy5ddiDMh5WZTE4jXGs04G3aUBlJT/FOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793435663; x=1794040463;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=96jzBiVY30m9Ux7FWfTeUCaLaYwOjjt3HXvLA+IrHRI=;
 b=KiStB9Ox5B5FTzfCPWaPKraU5b6S0yE2y9R7cCfdHaO70j7F6HTNpMt60t2CKc039x
 NxmEiOhi7Xah6dsnHe8WvuxtY+q4LR5j+2XkYKGXjMltbsn+bSvwWu3MKpoSmFdORj4s
 tFTMWLb9+Au1q0nWAy6gG8OlrMPcKX83z5nWQC8ALzJx8di0jkR82qdTUVsW7lh8nAhh
 W5DlQr/CA6Fkne/cSpv2tn4osIqIAICghzWQ61Medmpa4U3Ka/kqcbtTq9xVr1PNstVy
 7V350GHZU8ATMOoxnC7rQ0CE+DmsM268I8oSf6E78uKaYkkCu+eq93nyVa5UY3MZGpKu
 ZoLQ==
X-Gm-Message-State: AFq9FYKwSK8+H2sHmXy8s+zt4Ne1oYz6+Tyw9w9jWjQVw70eSWJCRO6m
 9ven5kmRJCJrP3XRNZPGCdQsLaGbGV6T+7jPkzT72KY9fQ+ssxsLdPbcD0IFnAMYVwyKXV+xtm6
 0WPmOfOn6Jw9mXZ2JyHX0bgeCVEUg82KssD6jcpeZ
X-Gm-Gg: AYBFou1yBSd5mxTLXicrPem9g5whFcCstgrquW2QGT5aWq75ulRjNmFscFNfuqCL5sJ
 a845j7Tp0HbpDNvLrluYnthfDFysJgL5rmtbywVJTfMroX1y8di8bNbq7XYzMfOF+tujymbcpsn
 uYryM4R+keLjyPUEprMSLZeih118blLgRHXOCA5ZmalmJUmzh/SONE1dO92lE27yLcM4mk5WMhl
 1W+/lWTFPo29TK7C2Hr8+FXA5wv+/7Y0E3uPy4SreBvUPn0l3iZ6K0Em4CJ7KsQ+yViO021o+v1
 74r1RwwEixXSzqOkeemnBssM03UBY2FcEpvghU7v71MUhE8dugodHmiBBarUoq3CDSbmE5IdlsL
 3cqb+HahARczeS6bc1q9TebrPY9PS/UwE9qOJ4n6jJ/IyZb28hNlrP4O+uXqtb+MyWf6hWwr4We
 7RsSGl4DGrASQ06W0Dow==
X-Received: by 2002:a17:90b:4ace:b0:39e:4c7f:7308 with SMTP id
 98e67ed59e1d1-3ae89742921mr3704593a91.31.1793435663136; Sat, 31 Oct 2026
 01:34:23 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:34:18 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:34:30 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030143843.467968-3-felix.moessbauer@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
 <20261030143843.467968-3-felix.moessbauer@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:34:18 -0700
X-Gm-Features: AclHuK8gBK9P_d0m5KN9azbPpfxY22XQ5hfbO_wXhbR8QZ8LeHJh51wIdI73Ot4
Message-ID: <CAFLszTgZ7BHpivUBqfrJTJEe99OHJZw6SmzjFa22t9xQRFjsTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
To: felix.moessbauer@siemens.com
Cc: u-boot@lists.u-boot-project.org, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, jan.kiszka@siemens.com
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

Hi Felix,

On 2026-10-30T14:38:40+11:00, Felix Moessbauer
<felix.moessbauer@siemens.com> wrote:
> efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
>
> Make sure the protocol is usable: the counter must advance at roughly
> the reported frequency, otherwise applications get wrong time
> measurements.

I don't think the test can actually check this. See below.

> diff --git a/lib/efi_selftest/efi_selftest_timestamp.c b/lib/efi_selftest/efi_selftest_timestamp.c
> @@ -0,0 +1,99 @@
> +	t0 = ts->get_timestamp();
> +	ret = boottime->stall(10000);
> +	if (ret != EFI_SUCCESS) {
> +		efi_st_error("Stall failed\n");
> +		return EFI_ST_FAILURE;
> +	}
> +	t1 = ts->get_timestamp();
> +
> +	if (t1 <= t0) {
> +		efi_st_error("Timestamp did not advance\n");
> +		return EFI_ST_FAILURE;
> +	}
> +	/* 10 ms correspond to frequency / 100 ticks, allow 50 % slack */
> +	expected = props.frequency / 100;
> +	if (t1 - t0 < expected / 2) {
> +		efi_st_error("Timestamp advanced too slowly\n");
> +		return EFI_ST_FAILURE;
> +	}

This check is circular. efi_stall() sets 'end_tick = get_ticks() +
usec_to_tick(microseconds)' and spins until get_ticks() reaches it,
and usec_to_tick() uses get_tbclk(). So when stall() returns, the
counter has already advanced by at least frequency / 100 ticks,
whatever the real frequency is. The check can only fail if
get_timestamp() stops using get_ticks(); a wrong get_tbclk() value
(the case the commit message describes) still passes. The 50% slack
suggests tolerance for a real-time measurement, but there isn't one
here.

Checking the frequency needs an independent time source, e.g. the
runtime get_time() service when CONFIG_EFI_GET_TIME is enabled,
measuring over a second or two, though that makes the test slower.
Otherwise, please can you reword the commit message and the comment to
claim only that the counter is monotonic and consistent with Stall(),
and drop the slack, since stall() already guarantees 't1 - t0 >=
expected'. What do you think?

There is also no upper bound, so a reported frequency that is far too
low would not be caught either way.

>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>
>  lib/efi_selftest/Makefile                 |  1 +
>  lib/efi_selftest/efi_selftest_timestamp.c | 99 +++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)

Regards,
Simon
