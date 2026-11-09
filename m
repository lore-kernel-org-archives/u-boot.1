Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4316A606A326
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IqriVN2U;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcHp3lxM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1439B80DF9;
	Mon,  9 Nov 2026 23:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLEPElMYC0rK; Mon,  9 Nov 2026 23:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6AAC680E11
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794267333;
	b=n01MkIQtwh9dnvuLiUQz/R420U4gR5auPZwUoweSnBxNThCWjxSwJzTkuSdoL8NDaQk5
	 iECGZeirGvvNbowscx45Gu+e9qHxPuaOIxi4+zgpa/WIjhD2z2p2aEdet29nWlsdftqAZ
	 wGh3hDIgBYWCR28OMi9G7b41zwz0gTY9w8N7IYWI6qGES/+UC160gugoxUHDC6XOrm0on
	 z/cYN5TohQzY2T6BBStxDdsmHoLGc1YjxA/Kl25NuPK7/RqP5s5JaMh62qvUo6qMuvoVQ
	 G469lICM6PhVYctYu7liupXtwYoLRaTzm96o5bQmiBok57BGujOQjdbIf11LDpJ4ECQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794267333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KDfZ2L8X7sWbZ9XOt1zPgY650KCr2ogBHdgmlnBBNWY=;
	b=oR6ZgSQO3RSJcpsXQZuW9wRLD3HWRv+u+Xaa97tzflIAh3Dd7QMXc6omPhGwSxCouq09
	 nSZCZbo/c8k7L1qPnYhwfMss8pAoQd/tj+K9LT0a1gHZ+JTUNkzeVw5Bf3h6V8o44la1b
	 Tjaf7k3o9ueZjOPmMylXQDYxKyxCY8xwezCzinJI1L1tzJHplrXzcybtveVu0Eyvkw+iR
	 5+mEfkcJaS3afpWWb0tUaCdrAK97mhVUYg00oTPw8aC6ndCOT63ue59ZyubWuwMiMtnjf
	 e6ueeOtekzW/QKwDwWJSnhCmmdLOR8+JAQGEMN6qEIBifKy4kg3C+DtOkU3DfmrG1cw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcHp3lxM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794267333;
	bh=KDfZ2L8X7sWbZ9XOt1zPgY650KCr2ogBHdgmlnBBNWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IqriVN2UHVs8nEPLbL7eD/AhmkqNfxPAb3ooASr6dOaD+cv5F94apKEPpqj1bl9XN
	 m3bLrSOrcKVJGXdenGhQxIHSAodFzwUlRtwKfzLZmGtccfFeT/6QZ89tPlYpkUkvwN
	 iQEvDi2RbusqkRfjVCll7JETOdIJMqPfvBC8auazlL6+zuTodHO929NoKBzI/H8UlA
	 LgnzY/j4oF8r5qb5TUZW74odcsN8QWhLweDdU+d6fGYL8FSUy14OJvgJbLVmwD7MKe
	 U11IA6WxuPRhn+nsUM60asrQqo+uPr6Cmi/9228mTcFvjdA5txoBZVnZCxJQCDHTr/
	 yGGUqg3zmshiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AAC680E11;
	Mon,  9 Nov 2026 23:35:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EC1F235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 23:35:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84EFE80E11
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 23:35:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZQsRiGP-f4L for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 23:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2A3A80DF9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XcHp3lxM
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2A3A80DF9
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 23:35:31 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8a39e5161c1so1017819b3a.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 15:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794267330; x=1794872130;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KDfZ2L8X7sWbZ9XOt1zPgY650KCr2ogBHdgmlnBBNWY=;
 b=XcHp3lxMLnvD69IOHpOh7C1MIC7zPILVOvXeE1/T6hZg5x9Dcag5AuXCEtN+fJkBHz
 AbPzdYWVt638Zu1w8NnFd2htaBIOSTuOD9q388WKxsdS9j63//jw51mwySRtOe96CjY1
 r4fMg+hJdVVhLtu98MgDnVmls2q/58UYW/EZWIFhv22DD6+0JP9oFQtn3Kz37mvJDEWv
 CRyHHiGMNnGgm3b99NAeF9e6fLlEnqSa7H9pg8gvQCpMXsrKPl4HQWHi9T11IAC5Bez+
 Ip9VWKObhljym+o1tX9bjC6Dn5EL9EoqHr5ipD1eiqk0c5YeYBsZtQTVQ2wBr6+0NI68
 WNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794267330; x=1794872130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KDfZ2L8X7sWbZ9XOt1zPgY650KCr2ogBHdgmlnBBNWY=;
 b=ImHDEFNrzYd6nO5kgrF5k2cy81qXAolmQt7Srb3mHUW/H8YumY6cx4FaWr4FtJUkeZ
 h6XhsPrn4CJ+S2abSFkHOgPgH6KhmowxaeCy0rGvKpoqksEHx+F1I2vrykFZdR5QEa6J
 Z0rt9f1w7R6Cj4zeISubPI5ktB1CqbXE6FczTmkXCkQ5JtUsEL+MkjGMhH1jyXhHXqzs
 KpwAstr9MeXIukRfy7+iejAcw8f7YtrQ2ng31SQhLU/GRdnrqBODAfnjCz3GuqAjn9NW
 8/vQFD9vbScPGOyFfYY5QzcpESp2rcTAp8rDJ4hNUtRgimZEAI2jmWaxXHmrziNxYa3U
 QxOg==
X-Gm-Message-State: APuU4Z/q3N/pNvmLBU2woZ6GK4SjW03Kk1r2MJOeGHkCwnRmtUnL/3ut
 sg/qBanjM6PzDfEneXO1/y3vFbMpNiniZWzhUrPbMyQkB2FEimxqevhR
X-Gm-Gg: AYBFou03Y5P9x18xSQpTMYowXjKSfv5gZKaZlFTKGoO+m/gkmygLKfKaIErWAvmqfFb
 PD3wTpRw0hFJJP5AwwYdAlrij3KJtLGiHPy1rug3n0gx8runbSVBvP5l431KgE4mGstP73IQ8xY
 9oCM9OvcZ6D34DxCrr53o/C8WcMLayX9cDBWTxoWtj8D/zTee7hF+GSFrov3Hf/A0q8uHvBHZlp
 yELo6VyhSHDoL3cUfC90t+MjuoIBfnny4I9T59c4MiqfXgBPfCp37hlIUL0gXsJDv30oirlTjNR
 EiPHuXaT5ak2Q8adP71oQG3hvQ8Iq9Tp0DiqBzHuuDWmA9wv21c48qG0dHRCoqt7k8UfjhaqRk+
 zogSBWNzrgEdQ/Mr43eD8nirYoUrORAOScMxKyOItLGAonNjfZDkflOda3Fke3rN0gaq88aaT2H
 ANmy5E17OjNovAiLcayGbcyNJsWPd0ChTPCFHynA84wo2jSUcY1LCYtluT9zzzXyLbZImXwuA13
 iKOm06PNmxso/TbwxjB2dkLvH36FOzjwOhWq7D7LAdkrdqP7ZKiiEkpxpiIdmdt0uTwmX/L8EZg
 GAFtcwW/f9BMChm1y30gKPn4s5GF9EEUXKhDiyrE2avm8hpEww0mlWNJipdR6/VA4N6WLNKgRQN
 FHQvg/tiUjQcwNxk/M5icwhlzDbr87s3GqCJhZaveQVb/6PJUnQKH4kYRo/5J5LUu/YV1KOcXLC
 cuGrk/uZXP
X-Received: by 2002:a05:6a00:ad5:b0:8a0:3ed7:93a1 with SMTP id
 d2e1a72fcca58-8ba8aeaa58emr1054066b3a.50.1794267330395; 
 Mon, 09 Nov 2026 15:35:30 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaae3e110sm176834b3a.36.2026.11.09.15.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 15:35:29 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.u-boot-project.org, bmeng.cn@gmail.com,
 bin.meng@processmission.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org
Subject: Re: [PATCH v7 0/6] virtio: Add a virtio RTC driver
Date: Tue, 10 Nov 2026 07:35:25 +0800
Message-ID: <20261109233525.2261520-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7BF67EEA-DB9F-4CCB-A81D-F7621FE1E1CB@gmx.de>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
 <7BF67EEA-DB9F-4CCB-A81D-F7621FE1E1CB@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On Mon, 9 Nov 2026 at 08:55, Heinrich Schuchardt wrote:
> I was not able to set the time with the date command using the prior
> version (v6). Is this a deficiency of the virtio RTC or of the U-Boot
> implementation?

It is the device. The virtio RTC spec has no request to set a clock:
besides reading the time and the clock capabilities, the only requests
are for alarms (VIRTIO_RTC_F_ALARM). The clocks follow the host clock
and are read-only to the guest, so the driver only implements .get and
"date reset" / "date YYMMDD..." fail with -ENOSYS.

Best regards,
Hung-Chun
