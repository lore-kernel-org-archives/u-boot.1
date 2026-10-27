Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCD606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y9Dpa1P/;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mHpHAp7r
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AE4D605D9;
	Tue, 27 Oct 2026 13:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioXiifjsbUOc; Tue, 27 Oct 2026 13:35:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA91B60708
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108117;
	b=ch4Dd2Hox3d7fxOLD+B8AIIZ7bVzpIHM4IkhdqSrnnb9BgT8YrOx7sw3/HiNfO42PdjN
	 UjrrRKxfW1b8CK7bptrRYuQgAu4HIOe0DxutcGU5IGkzSfJzZsP08OXCHjmOKkVmk3Ml6
	 Ke24USxheFJ0W5XEdGT+Gqv/fDXgvZiCz3rDJQBgTChrWlRURbef/M8XtTRecUxlIAvfy
	 I3BWdko2LmcxRjrFEX33Cu+7pqlMX2KE2WV6B+jxPvD2mK8GYlyhs/lrt0b/KiFMJFM8D
	 2hZ2DIUX619ZQFHBTW6y7cmTs6IhcaRQg1BbuUHQnKTeZipSlEg9kIq+IsTnKIhI0yA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793108117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OtyBA/HhGSXBLjsAqF+0qEAAJaL1ISSzdzdfY0fq7v4=;
	b=IoW9Q8NRNct6jS14QumLhiLVgVQBzbbhWnUDHHVxthutX5TXzWtaXQgivSt08H9wm9jq
	 +/WMK8djl4LGbpB1uiKJLhfjOFQeymmSoORjuSsO+EHeBIA/a/ddZT/xgkNNyVS/jB+Di
	 SNZrTn2YcOC9JDVhJ9aiKm7gwLG7N+23eQbAFXRRXgx5et/Cpvt2YT1kyOViBqKcLvohl
	 c0kznYo2cHp5UW8sLkukAsKuKehmR8VN+aGyARAjpE6GOkxesYSvWB/+jJ7zbFhsFqA32
	 a5/xUNDWUYZkE94ec5UMPbZ+LsLMXFb0glwQlneYC5KIT9/7MsGLJzXRJdOo6vbr+2w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793108116;
	bh=OtyBA/HhGSXBLjsAqF+0qEAAJaL1ISSzdzdfY0fq7v4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y9Dpa1P/4+W2p/nFUdR+v/+wfcZfh1FbQZL9DOGwdjl8Siw2uuCttktPuWayuQU7r
	 xbB/4CXlB8h0LC1TIMpv332nIfNsAdVbilorvLpXxGQpioRumG9RZtuklwRpzA8CaW
	 Lv7cerHmKMaaLeTwiYYySq4S5gvSKQNX70RQ2aDG/xNPFKMHcMq8xgFJYS2MRFzOpp
	 /Ggk5XhERobnVIiYED45tmh+rLW1ruerrK7myCdit91fo7vxtvcUC9SiI9cdKFfeMG
	 DURnDN6Bf76PJwR0x6apoqobbhR5yffvyA54HZxrpOAuEvbKoRL2PDQIuIqLld6bhM
	 u9iC41+Tm3GWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA91B60708;
	Tue, 27 Oct 2026 13:35:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 668F84D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57CC38062F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yB2BN-q-pwOf for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 48785805D6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793108114;
 b=IzurvDYYq81gI1iab6OjN8ETyYk3K7oXRFj81DT6yOXIg4QMWj711RGUGxit2HKmRlsK
 lkCSYDS02pKTOd+6CB5Xp82D5MkooWunfa5ZpIH8ZTtJSBuWKpeYOlgg0x1m+bSDkZ6Ae
 GnNE7291kd+YObGwiKHl45GEfHigsu2W41dsfRxc/TZ/2VpcO0Cbtd4/AF0RHwkEQvn3T
 z0i181qKiQqrRffMag4KQMyhkMeDN7AzoQDR/Xl47dK806Q5R9gPLZIsrIN2Oypa9/tMW
 5FF/S5eDJSvT+IVJPOhEXz6yLW/j9VPD4e7X1k4Xi296Ua42wRckmFeAKKiSou0sFQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793108114;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=OtyBA/HhGSXBLjsAqF+0qEAAJaL1ISSzdzdfY0fq7v4=;
 b=EhqsHTwVAXP60ss5dkaui7ibTaYuoyOjOUU4MHwW08vAJS9CVLsVLXKD9vdvSn+MGoRr
 jnWAs4+2mhv8EidCUngwn3MAlxPCpRxco/b2TgBrPgUDDanKNPxt7KYUQu/0MaUWldhjP
 Un6rHnJxifhqoU/ZTz83U/1aRVUX5TmNnrlxi0MGK6ZIlM0KpHCy6o70w8vx9N58RxPHW
 K39w4P+UUdrKxSH60/YFVzleSrM3Kecx/8aMciq8oCOzhzMI8I+j4mRBMM+hhvdv9nYk3
 5wlclvuP323DmtBJg46LECX2cQ1B7gz0J0SaBHEuOyq6osrkGrSmAL93T7G9LKTa0Rw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mHpHAp7r; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mHpHAp7r
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48785805D6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:35:13 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so6164649a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793108112; cv=none;
 d=google.com; s=arc-20260327;
 b=n4YQRNSj/+Br7kTznjRXOBskLzxWk0xUW86J7nZvXiQJunf05zBo2nIsavT3ZI6+O0
 0Qn72yfi736rFL3uxWXqDURwS/L7+RFwu491Lgpwv7/+z+0N7pKXD9RXZy0BaOQ0JXWC
 fRMcaTnu7e7U3I2VQ08UUY1kWnyJvH6/l3rJNvnlJYfi/Iiwpa4udjykDF9c0d3jQ1ol
 prFe+iH7+6UyvMDH/dlvV5Nk6D6g2NUGQTkCG3LWUi36aiuXY1orchbv3NAIe3cuG71v
 bsE/BDl1Z5BfNjwol6aGj1th9SWPriszxnlxP2OUAKl1kSESqiebd9dZy7GVLqwzF/w5
 TozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=OtyBA/HhGSXBLjsAqF+0qEAAJaL1ISSzdzdfY0fq7v4=;
 fh=hvx4fqlremtGPA+whBS+q1979/OjzIfq5Ea4cwWkG7U=;
 b=LFVpqaEg7K+SDUIzTuivMsLfFwrNdEGPqqtVENENhkwJf+5tIe2jc2trA9tWCQccrt
 4uT56iUZ08vitkB2/K3KfJGigvJzRbenMn94wfmCvnvQYZdoGtxsh2A0iHvDAn3Wifju
 s64zLfPOKP7WdcpfH41h7AAkts8iysWKX0FrDn+TG8iZ84zIEdgj5T+EUD7vpUlA9RQj
 S1luYyxgeu5zQMQqRA76uomlMnFk1GBR8IxpQelnlSjvjDu/b/sjsf8Ofr+lmswKdRvX
 IGPpb/evM9I3awJByyZXtAH7OxT7grT6Z6rFZG1Uj1vFWyfUy4C3TS47VfSKYbnmwt9m
 Ir3A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793108112; x=1793712912;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OtyBA/HhGSXBLjsAqF+0qEAAJaL1ISSzdzdfY0fq7v4=;
 b=mHpHAp7r/o4qHkeeUPpm5JoXj92Vr3922+Vncv5lCmCoEtY1Uz6YR/B/6fR3gKgYP4
 52tSrIRzsWWNnucz/gJiwgL9HEEOyTX7sc6vFI+YczgOFUkV2zYpI8nRUkfv11joD3MD
 Ng2K/2vb2ntJIGeDzdw+RyMw7ZZwAjer23cbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108112; x=1793712912;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OtyBA/HhGSXBLjsAqF+0qEAAJaL1ISSzdzdfY0fq7v4=;
 b=2lBSr9m2IyefDTkY8Oz+ULIqx+1cq4Lqy2fjtxaCrQm0yQKeGAyG1m4l+1s9anEA7E
 cSplLzEeeyQrqxpFvXysEAnVC6Pp8ZSQAG5fHJdiDHYjLQ0MY/X/7+VF9ija9JizFIVv
 wr2A4CAcyWWRUm5orp9KakzZhRubK3YMCUdfAFAGV8ug+E6YqZzKVLZuEPjXql8xz6Ua
 DHskB1m6aGbLIu3aBiFis+9IB3RaOweNV1mmsyGDlszBIig5AMpd5t1kpYlkB7EK0AXq
 QiHvbgBGMm1L/j8PJGKNULJu+w2cVBKg+kKIHGNSd7v+0fealuRxrNWyh2B5WhJFWTkk
 ARRw==
X-Gm-Message-State: AFq9FYLrQDJXSpDJRGrqFDCxVs6v+IzUInQ8veYIF9pFEIeIghJAy4mb
 s3StPRTtibP6AB06dmSArgVii1D+C/yX+8bVCr9B1m+cP3RQq422IWzjNbQnQkU+SJo7GJ9tFs4
 uX5tUArw3pRI4+0AxuWoWIiWqK5YfpaZoK4ERgjgKA43T/gwneShJDw==
X-Gm-Gg: AYBFou2cxSgQGrdgYBYu1m+uStpR8YJUsdcuazwC4dxCHmEveYHOCbzlASRF7xGxaSa
 MXZVXYmBc32LChFTqIh6rhUD1yHjqbKhUw3Co65XOGNxKN50tH8MIrY+pE0LWybwOXf1n2h9M0O
 bgTF9cubanBEB+Dc8utmzAgGBeUFYZddTN7mSh+ikCXbnkHH0CvgfsqUwD5KoTjLMSeKdFDZ2Bg
 kGdGS2QDH2N7W+SVAkqd1e36hCBGd5Od8gizILXz+TvNHuS5xWtqnd9TDGaKlJqKyzocWTM0iX4
 AQMKdE8bk+p2haEXQmIEVjggSgb22Hxj+YIhNbC/MXGaZIgZ5IPZsXA9kbcRlwO9UwxNVQu0cVl
 Rz6yEJ/N3XAog3Y3qBi9FvelKEvWjyKm2/Hc=
X-Received: by 2002:a05:6402:2491:b0:6b4:1916:965d with SMTP id
 4fb4d7f45d1cf-6b442fbe4aamr9731236a12.12.1793108111677; Tue, 27 Oct 2026
 06:35:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 08:35:10 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 08:33:45 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261026201101.400702-1-marek.vasut+renesas@mailbox.org>
References: <20261026201101.400702-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 08:35:10 -0500
X-Gm-Features: AclHuK8VvOezmh22SYv-cO6tpwq58EUfOiq6sHU-lw0GjR7mRtOL2RmYGtboRzY
Message-ID: <CAFLszTijC1u3aUBh+O_OanaEcywtheR-j2nYQRm2upUWfP-jKA@mail.gmail.com>
Subject: Re: [PATCH] dm: blk: Fix blk_common_cmd() return code typo
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.u-boot-project.org, Daniel Golle <daniel@makrotopia.org>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-26T20:10:52, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> dm: blk: Fix blk_common_cmd() return code typo
>
> The CMD_RET_ERROR does not exist, update it to CMD_RET_FAILURE
> which does exist. No functional change, this is a typo fix.
>
> Fixes: 4395f6673901 ("dm: blk: Add a generic function for block device commands")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
>  include/blk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
