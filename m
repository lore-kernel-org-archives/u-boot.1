Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12D606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LExJGHbC;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KjCYI9dP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 272D340729;
	Tue, 27 Oct 2026 08:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHyBVl0yOxPp; Tue, 27 Oct 2026 08:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1339740708
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091574;
	b=kwfenlQYAlMDWJoQlX5MdDWTPX/nn+7pRch07KLh2qT7fqN6Lu7tW636usMJTQuHrdyN
	 n5qKq8+ElmKB3+D9KNfmkjiTm6Cn2b7+y0wHQPTM8xEpeh5yoJm72ZVlIov3OHOHWF20F
	 9tsX5qjzE6fCAtkDBo7w15wWBankCBFqcA0vZaG+XIl3nBvW1yxYoPoGg7L9odVcZjb/r
	 tmOnUGsIzZJH3h2Zwj2JxmTLAAvySF/YCHrWUK4dcBxE9YIMASicwyWdyZi7y5xZs7niP
	 jw5BeGoqUCN9BEx6x4y/+HjQoEFV8UewcxtFv995f/eeah4kbXEr2/dY+wR6iPG381w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793091574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HqwN3CP77hOiw7li5q/+vMqSe/gwtZffq7zBxScMOUM=;
	b=VY4h4XJNbDzOyy7lAUoqx1CJffm8pY/nAecSzyaAGR6nrfpkgv/cNadrpRpYx2qscFqU
	 XMK0QWd6/1mW/m97HgRb5zaykSiPUXldje2Nj/St9ghR67eI4nMV2dMMs00oTDwN6tRVj
	 3kIyYk1EuboSsb8LGCEuG0IRNi5NRm4b4ohugPg2WBnxQsb81vzKoWCxauJQDJe/Nohqp
	 U1RTbKrmuHjK9/w7WNYu2sN2JCXfnqPl0Y3wmiLGjGlmn1Mwm/PghZELLXq5WNhi08uWW
	 HMfPj2v8iLFk4WcAe/cIPf8X1COvCogkylS1cmNATlZxUlCRpiFahAiVtTBPdx3FTtw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793091574;
	bh=HqwN3CP77hOiw7li5q/+vMqSe/gwtZffq7zBxScMOUM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LExJGHbCLD1gKRS+zEVvzUhU1Hqc99Nhg1deeDtKhGXO/n67FHyqI6rSxwp/GK0UJ
	 wsQwEL6hgh9N1lC0VEy2S+mpIaZXE2woqTj6TmNIOPDDGSllgONjRA56m6GBDWug0U
	 Y5UfvWZeQtLYtux48jp7pqfkcB3nLOA0v/U3E5r3iGp3ArpIHXaV+0bwmWBfnoZX2c
	 2O6MOWfkc6gZd8AlX23GxBffzATYroljE8sA4yrcah7+Vl6KvVRhjN6w66aoQn6b+b
	 dcytai0lz0U4MTLNox5U9jiHm+Ka84UzZu57MQdsQhJEBHrrF3ugB7omyZrXzgiluT
	 C9Fk2B1htsTrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1339740708;
	Tue, 27 Oct 2026 08:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D70D4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F067605EF
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yOQBFjTw6Ky for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 08:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 85084605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793091571;
 b=HgtQIHjbiFyaY3fJJDYck9/6+r8dg3HeQYWAw6D/FoFKeb6rhkp3j3aEyOfi0LL+Xbcu
 bcx60GaMIvrJH6oYlDQ44S0CwnwouRkNGowNszTWTzSqwf7M4ZVfoAW31JJv65S7d53Mf
 ZTV0AaTBJqtJrJ6f56oIPIGeRj0xI+ppiUflMlUQzmf3Y6vZIP6fsPbaSfosUBeQCBsne
 jtf6TRESgyzoQBtS/H0QYgj5DVjbL6YW57QNUHOtuHDBirehkvLvja6GW4M93YFLCwSbo
 gG5g5I2tZ5qeRihXL8hPKje/lX/UI+zXpsFAAil1TA1l0e/bJaBri5uzqnaXhJJpWQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793091571;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=HqwN3CP77hOiw7li5q/+vMqSe/gwtZffq7zBxScMOUM=;
 b=ipmyh2Fo/9AoM2OMigAR64DpsHLBBABlldNuTVQDDJC+VyzK57IjR5Mav7b7GYEFJsN/
 CWbmAnaih+UxHPJTmIiBgqLCXLQRhAEff45ycs2sZNk1Y0d7dbt7z5Y1dedpp72tgL4sF
 LDYR8dchgRzTK8qZ9umeatjyhSdgjwQi57XCm2lcg+s2nGfiQvDmvZlo0Xsjwk4MbLpuu
 AXn6XgTYoVTeAUkef2MKcq/DTpSyQBsrKJ0xd8XrPihVP1gsp3nKaucrEY/s7arASVFja
 SviXEUXPmyqxM9bBAYOJ8OrsFe4WzyEcE2B4kMqTOHazve0oyI469RYfjSJ1oJWwfgg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KjCYI9dP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KjCYI9dP
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85084605EB
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 08:59:30 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so5047592a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 01:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793091569; cv=none;
 d=google.com; s=arc-20260327;
 b=dpzkD17KVVK1xWRpfF/TgsGnvIB/C7wzQ6aSBOT6QfEMwOzPf4We2jkdz/5Uxo5cT/
 GuX8xzvyM+xAQfJUwXavKL8CxjXzrdmU2RuX+12u2N6PP3FX4PvVqa3xynXgoUBmIauS
 /O1pHrFJ0DK7KVlQhHlwpgE17NgUYFbVLE0dO/Ns+51jePY0fHVvGHfrtNuFxi7FEQVZ
 KEzGXgZNSpAL3SpwLCgdONzdpt5hmB0NAXAXcV9fXAsFNPqeUkhTDxcExLWqKL/fvvX7
 pDqkXoec3IrVEN/dgSISfV2HFLLFjUmKOp4Q7dd4pD09xqnaq0rfKMrn45+mjCIxIZ+m
 SDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=HqwN3CP77hOiw7li5q/+vMqSe/gwtZffq7zBxScMOUM=;
 fh=/rdnnAgt/z8Y/gO/kkwLsOp9dS2eruYSp+dyjwHJTc8=;
 b=V1q2Hcn/laJmAAeejhVIN+xgArJArrQMAnJh9pN6p7UZMDTE/qdp+ylUCV3fC7pVxt
 sm6DiyTIKmsdxlCc1kh1vIV5Uapn122q3jdU9Bak2hF0PHVsIjej/2NapzEJakV0fLSG
 TlCKSr09dGhEgSQW0UyrRaIUjoQTZ4O+mNQiVx7mx2YkMIdqZxgh+hQup3/wEj36dWwj
 jAuuFEMc9o/fll853kVxfR2HvihKo/+5w3wOIMwnU+PD8/6lCa9j4ZrHtNh2siexPXh3
 lSisHbtIRqV2cfIrsySBmBLN2HMWrZyOzrsrhqZJoArSi7f2SHmLpeckb+/FmcCVWr3R
 L7gQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793091569; x=1793696369;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HqwN3CP77hOiw7li5q/+vMqSe/gwtZffq7zBxScMOUM=;
 b=KjCYI9dPOU0ETpzcmKusa1GYFDpTh7pw4htaWWxr74ypLpT/Qlc+iYKG4qmvp7axb8
 vy+/WrnsPoGvud12l4IgeH8AhnODtlHtLK2O34RH1DICX/+dmjCcBElgdvs+6927n8Kd
 Sm/t2RtpJa+h4bCsd4zw8RLzPlY0t9+9MWYys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091569; x=1793696369;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HqwN3CP77hOiw7li5q/+vMqSe/gwtZffq7zBxScMOUM=;
 b=M0eNEZJ5GhB78yBeOPC2LWDF41kb4Af8d0AfSuhzPFdy5mk7xDVS1q6a1xTldaG9HO
 A0W1vQ+2Eb6MsRU57LPQxGFCCHzNH7qsIAs+pL6UkH3cgQKIue47JHHm785fx2aco32t
 PZzqc+ObSwmeSQ31m6zcZzT9dUE02AUW2Eh1euipHi2osg5xhYELhJMrY3Zl1a55RMBh
 gH3vXF9LfJI813TEqx3Mqf1N5vA1NpCXhBNgjXBzlry+e/vT/x63DiocoNXQtm8iyxCJ
 DLZwrYP4z84ADziZTggJQ9bXldJ2/r1IPrmPFzfTDnAgv6BitujwD5wFJuhsR/hQJVOA
 t3kA==
X-Gm-Message-State: AFq9FYLtNCbDwSVqe5xKufSHKNqPmGnHnbN6eeT4dLWBUHtXQvLvrKoZ
 7yOZnPd5l1effkRLxZ0X0QmLuu/kt51o0PGS7b/BaO5JBg8VmFwNkQlkMhGW6zzeSi6uyOXT3JL
 Gdt8boxIHGfautIzR/vyS776qG+XUaAVK8SI/WQvF
X-Gm-Gg: AYBFou3LQxkfygwOdLZSyyZNMiUrJ7U1LrY552NhALacnczXtTJhankGpWxgx6MfJne
 jLUnN3pe21ZRbmM/ex54CnL8csOOUThYn92l6NONqK6XLgxjB6ox9veyLqkjRwUPLejNxzDUq4W
 0hrhmDYoG+SjRUH6zFz8BHYWUPbtD6AU+K5dbLnxhpTY8ZVinKAegfnarUFohPmINtrpzydVTlB
 6ykA3wY/zqEHOJ9dL7A+yfiF4DozyqPRfTVDb9deaGv3JC9p/EEaENdBBUzkS2N10aQnesz1KMf
 nc/OAMZCeJuNXHGAPuVvhqxImPkq2HrKt3fuYAFvPxhFZC+D7cFj3Wzs53iacVtr/xv1m1W5fBs
 E72arp8bDyX4eLJVnJ9GzhSJMrid7XLuZ+u8=
X-Received: by 2002:a05:6402:27cf:b0:6b4:597f:9bc4 with SMTP id
 4fb4d7f45d1cf-6b4597f9d2cmr7502708a12.9.1793091569082; Tue, 27 Oct 2026
 01:59:29 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 01:59:26 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 00:14:36 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2b8522f0-65b4-41ae-8bf1-adf794c7920a@gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <2b8522f0-65b4-41ae-8bf1-adf794c7920a@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 01:59:26 -0700
X-Gm-Features: AclHuK_MoWn1otNgPQ42vXfKqK6ArjJ91t7OazjOnxNNxSqFivmNmUjOnWUdopA
Message-ID: <CAFLszTizbib+FM7inPXZjV83bqnt9KxdmsVSJfeSrEsx=+tOMQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/9] nvme: Skip a namespace with an unsupported LBA
 data size
To: anabobillo3@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-24T12:16:28, Ana Bobillo <anabobillo3@gmail.com> wrote:
> nvme: Skip a namespace with an unsupported LBA data size
>
> nvme_blk_probe() takes the LBA data size (log2 of the block size) of the
> namespace's current LBA format as the device reports it, and shifts by
> it: 1 << ns->lba_shift is undefined for a value of 31 or more, and
> nvme_blk_rw() sizes each transfer with
> 1 << (dev->max_transfer_shift - ns->lba_shift), a negative shift for a
> block larger than the maximum transfer size of the controller.
>
> Check it, through a new nvme_lba_shift(), against the block sizes
> blk_valid_blksz() accepts and the maximum transfer size. nvme_init()
> skips a namespace with an unsupported LBA data size, as it skips an
> inactive one, rather than create a block device for it that then fails
> to probe, failing nvme_init() and leaving the namespaces it has already
> probed on a controller that failed to probe. nvme_blk_probe() checks the
> value it uses again.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  drivers/nvme/nvme.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
