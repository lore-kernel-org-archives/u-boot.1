Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8A2C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 13:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 974B180B6B;
	Tue,  1 Sep 2026 13:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hChYq6ABvXPA; Tue,  1 Sep 2026 13:55:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788270901;
	bh=Y8FSBh9e0V9ztCDfEU6KP2od2xzsVGoeCLNLPAhFhAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LeN3UZ0XWFAcpXe2k+w8GbEIMcMOtJ7YO+oleBntzJfCsY+fGdQsOYztiCLHPxnBl
	 TIqEKq/HIrWgZy6G5eL3HC3LPpp+9wGZ+etfFeIS9/ttJue/nfiOG7EdFKbbeFYs3b
	 LVOmugiV4J0ukWQa3Y1U7zciJlou3ElTJR3Hkd4+KHohNkTy+nMU3+ATBeidXUXKrA
	 QZIZrbnyKqm6P4mSn0rpFZ6HahMP9NiYnxwAD07zAoX+Pnf5jcQWjodOVsYC2TFowi
	 HVOx6/SYdqm71VVD/oNV4VSoEidG1Ot1gzzDQGK4EVCBwcG3LFs8eVPEWDFv+F9O4L
	 DJvA2rw7I56/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE34280AC7;
	Tue,  1 Sep 2026 13:55:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC799279
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC8AF6066A
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:55:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qC1QuvhOPebM for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 13:55:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Sxs9jEBI
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD9726065F
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 13:54:58 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c2533d83e3bso779237766b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 06:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788270896; cv=none;
 d=google.com; s=arc-20260327;
 b=NmS/mKlkcyw4XUhBX2KexHqKC43tl8PG6eFOnewcdhYdbdSTsgrvDX3hoazs1HeOFu
 qVUdxoezV5eaTAnT7n3Tc5Tf2mnKlXpbIHA79IXH9+qll40C+26Wp20+NEshn8ehfB7h
 Z89Xi3kl4Xu9+L1vi13d8FsewqMWII+4dbDLjQm5c1fEoKrYTSokm+T3E/w2L/HUxxRi
 vR/THVjS8l3cAALu1PQB/C4GcvIc81qgPiNC5EhdCiQyrBsgLnN0vl+4M+d67DgykNl8
 8/7IGLVrKKlhw5Y2s+jD0VbIV8Vhu7v4TGg+9aVIzbwah2VMPoGw4eBGWCpM3g3oxrab
 9/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y8FSBh9e0V9ztCDfEU6KP2od2xzsVGoeCLNLPAhFhAc=;
 fh=GJ9eJK66co3XwOqZaSzbyBDClJA5txYj4bE7iisFBhw=;
 b=ruEDNYDWhI0xiIJg886zBQyZO6S9o5nUjPMvmPSR2gPTpDbE3TyI05udpJ/Iaghjv6
 2YMDquf4g3aLrlptpCUxOvYDdHSBiqacUD2zl8bSxPONnKC3syfNYGxD7F1JMmqOLCs2
 HeVz6GkCkFgTetauQSjvxHpan863PaHeRne4ZaqncOlp3lhaVyFaCH2+EEuAbR7WQzHe
 G4HqzOaoVEfcb1eRT0LNppIlAOKLaMEdoGn6ajWdEkI6qyO59o4hmzSnOhIrscFUhonp
 gSlJcxL0S07WS2Z0rd+CWCXzk2lJEEgnpyhRN/TOAl/71ZqGz7jf9UbsIQcDS08BYRpV
 Lj7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788270896; x=1788875696;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y8FSBh9e0V9ztCDfEU6KP2od2xzsVGoeCLNLPAhFhAc=;
 b=Sxs9jEBIzre4JBVDgaObf1m6bksmgQNjWcNpWd/u0zmYn+eK1qIxOJ9BoDLmMBACGQ
 u1Qy7OtqkmXoViU4ioQoFQW9n+DwDax2zKhvrUcf4UDPVXJp+o+dK3IbFlCilHis5LzH
 hzEO/NpXH4nmjz4WAwRmNnAm68irVM81a8+K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788270896; x=1788875696;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y8FSBh9e0V9ztCDfEU6KP2od2xzsVGoeCLNLPAhFhAc=;
 b=R5bKBlkPF08iBcOJMkIP0K+sR7VCCYppYLsKUlZCGR1WjRW0lNNj+lMzF+m7aVUS9U
 dQkcFr6MZsUC5tNF+128sOQm30qKx6QEvLTW5m+yX5brxhRcc+rTW0mwjvrLxEk6N1Rj
 5JSrd2v5URjSzUB+EROoyUsY0dzXBoGtQ81QoYvTDdyj5yG1F60v57J1M7R2FFPHRc6k
 KflzCVLCQBGkftVdSwIfXu0XYgDp6tjZsEG4HzG5NGp3sqj3s2GTTtUBAky5Of6d1Oh1
 aXT0/ghZeQqqV6+HxE9hgzBZ7Y/o+IJq8ZWsXCIvg9lVvGPqeQBzdRjD720uK5sm+Mbl
 FKBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHC6xfr7hBtW39B3eppe6fGv/CwLn3c7/m69TcCWPd96nYBXiJwCG0hlf5LKl05LTHDH+I040=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mfgadlCMpIX5r95kmqQ/r9eiQNshLqGi8SKHOsucbTOVALq0cH
 Me+rCjvmhuZE/zUNls5sBvx5hhFmzRvtsmedJmaqfO9itaMkqvI47WErr7C8XPTE+3zkAtaj/AJ
 k9WPOE1KGmaO9K4Uin2LU+lHj4BQe2MxNeuTwHXH3
X-Gm-Gg: AR+sD1037XcgAFEPyphgef3gDiidKnTbr79aT2s+2XXKjQIxVBkhKe/OMUN3nOUKbSK
 9h1tBx9NiGr/jHCUmAw5SXNsrB73FfcPgVlV1LERXJFi5kQurA8qJVTr7DZ2PlkwQZJueP8Kgj1
 pgxS87RRxZDL2+MTLJBLkxiYLXXnFWNEF9QiQ24hPuBwYnLm+0UJoXRUo4vDujPlVUgz+Ev8ZnG
 DySoMCq41fP5aStzuMD1E7DD6NdGgv7/3jW2+t1hzsnIlL4cXor9b208gXmv4ZpbAt0MjyhokvR
 kycArWiOfljnVSP3uBtUBKOkev86ntIrygCFjN1GOMNU6y2icdJ5YA==
X-Received: by 2002:a17:906:ee82:b0:c25:5114:c832 with SMTP id
 a640c23a62f3a-c25b3b804b3mr571357266b.3.1788270896211; Tue, 01 Sep 2026
 06:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <7guo2gscv64pjcfcp7wjvs2r6msrxgylgtpcurbcfpd73siplj@zc363ld34pb5>
In-Reply-To: <7guo2gscv64pjcfcp7wjvs2r6msrxgylgtpcurbcfpd73siplj@zc363ld34pb5>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 1 Sep 2026 07:54:42 -0600
X-Gm-Features: AcwNN1XBjqo5-EPZI7YdFdWZZb5yx-uGTovBdMPdCDol1wO-0R1-PF0VbZYAx_M
Message-ID: <CAFLszTgLiKPkDwpAs++7z9gY4HUwKWnkoQFjxUmGGFr11pK1Rw@mail.gmail.com>
Subject: Re: [PATCH] bootstage: fix record name fix-up offset in
 bootstage_unstash()
To: naveen.osdev@gmail.com
Cc: trini@konsulko.com, sjg@chromium.org, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Naveen,

On 2026-09-01T10:21:23, Naveen Kumar Chaudhary <naveen.osdev@gmail.com> wrote:
> bootstage: fix record name fix-up offset in bootstage_unstash()
>
> The records read from the stash are copied to data->record +
> data->rec_count, but the loop that assigns their name pointers iterated
> starting at data->record + data->next_id. These offsets only coincide
> when both are zero; with a non-zero next_id (e.g. after a 'first' init,
> where next_id is BOOTSTAGE_ID_USER) the names are written into the wrong
> records or past the end of the array.
>
> Iterate from data->record + data->rec_count so the name fix-up matches
> the records that were actually copied.
>
> Fixes: 03ecac31498 ("bootstage: Use rec_count as the array index")
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
>
> common/bootstage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
