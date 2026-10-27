Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34864606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jImpqkT8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YTY/zJJn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C90D80FA3;
	Tue, 27 Oct 2026 16:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9RtUmDhkx-w9; Tue, 27 Oct 2026 16:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 65AF980F6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116952;
	b=KJo2XRIuyv/enOgg3Olt0T5RXikXsDE7C5y4hRhMZ5KonzoEHeVgnAuIN5lTpIwTVn5c
	 oO5avZQY1NFF+GfdNzfxbAOkE2ou2u+RXrqAt1gT6AW+IwLalQ+9G80yaTA6r2m1ZlYL8
	 hQnsxQJU6fUc147x4tyJVf9I1aK/ObTvlMiNpkhmLjppidHzbHRo1OxUCSO0c8AquF7aC
	 PGGpnln+HxHcA/sSI37uWSwrW86vYmqc0qz/yzMSqkJY1LtYvWGT9UxOj1tSTnOadIXGO
	 TQd9FYB54oymvmitNUUDkxmcelUwbmKCSNgbOLUIEQY1L9GwIdJI7fmVprd8lIfZBBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JivKbezFp7RFCpf2gt+B1QzkrmzFud1iSM0kmlkk9Do=;
	b=ZG+zA8VuJZLZ+ny8PlPUKI3XR8O5mudgTd6WAa/6BrzLeLe/yTfvEA0z647roN1fsEYO
	 aLnRgrNfIWGh4vLAgQEyacwxNew0tDcf7T8mRO4Aw3zFjeVlsPyJ6pnityEx79SullNOI
	 fkVCahIrZYH0uHRqxJACMr2jICB8EETvRjV+eOax4C6TG4+W1+DXIGRunTQn2IDiYMmp/
	 5qQhrHxbt0auIxGamoWjbXfzyK+A445tojpeIpF/pXgqCjrXmurIwrY105qgWQIWP98R7
	 igGD+rZg3Rofw5WnxxImYReyo/NUUtzdq5TUqDPX4h5Hjmh+1i2tIvGB3gVFurm0llA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="YTY/zJJn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116952;
	bh=JivKbezFp7RFCpf2gt+B1QzkrmzFud1iSM0kmlkk9Do=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jImpqkT809HjAgdS/r2foM3Soy3sKe+VOQXcC1iyLSCuaBkEW/wDlY+DP2zIopdxH
	 589Sk6ZARAEaoAzb5Ddmx44fV8hzlHsWxJa/FA7Pi2kfxdl6N/GQIpY8SuQ8384pJ/
	 HPlD/IrEbLDRojFSCu2Ww7xR4lxaEoDJ5Dy5xSaDaxAB5NCsmNB0NQOmHOxigu+YQR
	 fCb6nMuKYONh9hEPYHo6eRin0iCGwL+0X5SMsBCLAeUQTZmYbHy/m1brvsaxQaizlx
	 56KzzDVHE5aEb/fC+fwcoO1KLRHlx04VfrwLig8YQosJ/S8h+t2RsJUa9Pqxgi6hQk
	 mCmUsw8Zetu/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65AF980F6F;
	Tue, 27 Oct 2026 16:02:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED75772
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF59580F88
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5aUti3kxdey for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E64180FA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793116950;
 b=MUPaQdVlc5pwTkIHW4ynaIq5cHVvDpSu6TWOf2riNSisrBhUdmjWp9sYBvZWSm2M0KSd
 0cqvfR2dngZYOogD8Plchc24QFvbc8rtXn3fdZrm50I/XxjJB74PFQEc/tikuYn020G73
 CCDp4aZcuy0XS4ubXMJQC/7/MdmBeGTfXwmS+UKJVO4Jm955Zy55WnXp6KgCRESRVlKy2
 F9G4uUit6hmkCWuG6ePeF2NYKl7aM1/SsfXa8Wgo43JyLgDtwtSA2OnXX3Dho9pfPDRuy
 /bWrd4LESyx4br6/D5QvxQDwiO4vapYgOvw0RhRIfelkIGviTwZgA5moNE5MUO2+sBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793116950;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=JivKbezFp7RFCpf2gt+B1QzkrmzFud1iSM0kmlkk9Do=;
 b=DdLUVXnyxWXojIjGYC0P/OhUFcLfnhl1+1Wo8AzPIROyTWsSKLgvKnso97Ub/jooNF+T
 7UWqzuPBTN2CSO4XPxOG6vImh8/JSf3GfZVFGPZ/ZW/l7DI3c+bFZn7/jH+W7UThipkrJ
 GKMqobjLnS3C91xhu52mEfE5Zf9xAXg3W4dhjGrPf0T61ewWAxcMb49APU8pFyNy9OZom
 S3oZ063huLQVhUwnzr7JUHT2DOgi94gDCMp3q7s87BpLFWKpMtmAMch+sP00x04iusK0i
 L6Pe6e2KV1XlsLezbHZ2fbVt3pYCLOjoKmyMqTy6imviTRyfbyWSrVXGLj+6W5Si96Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="YTY/zJJn"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=YTY/zJJn
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E64180FA6
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:02:29 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4f48d91ba7dso18291b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793116949; x=1793721749;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JivKbezFp7RFCpf2gt+B1QzkrmzFud1iSM0kmlkk9Do=;
 b=YTY/zJJnPI3os4+svrSgGoa96O049RC5+wtGkLNAG26w4eWhEDCiNSCo2/a0DkFSP7
 lwGfChPrSsY9n1POoAIqGedhHyXOtgcE8T9IArfc/nyOm9PuCacn9QRXM60xuRiLAeRQ
 RQdy0jGSlaAzRMeB5K65MIRsm39+i0iZXDsIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116949; x=1793721749;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JivKbezFp7RFCpf2gt+B1QzkrmzFud1iSM0kmlkk9Do=;
 b=lPEly6SkFg50Y/GF+eK21vJqMhKsaXNdLs2X+He4sNJPPD5ojJRoyAtd3G8GMNh4dO
 rQLkXr1XvmWSGecEU0SgWIqjpP6UtRwofon6d8X5oZc848eLeHaG+N00WrgCBVZcSjU5
 LOO4VixBZn9dre8H/zLRm+81fMnKLZpXN8g6viLz+1o28Zy+kxxY+0uQ1r+c3rjGA1x6
 IQFc7PhuCOZNDMWOWCIv9839wnQylSz/ALdIsfQuDCbuRMmWv5V1y/mboCIt9xLjag2P
 YOjabdKpNgsxhwfZciRLTgCduCACsTaCCxyoHIkl7BJQu7E8SCP/4qNHZFY6JhJwQ+0E
 i28w==
X-Gm-Message-State: AFq9FYJzL+i0DQutr74Uf6o3+vXtHWv6OPjXfvxL3aSDGT6VSroWdiTq
 N4x9JbSgeDsNcOBS1FzlA1L+UCnwUunWVEgRhdrdHAx1RucFD7oWMrJbWbTvArX0olg=
X-Gm-Gg: AYBFou2iY3rDwFF72p3CrC4urdfZWsfE0wH9MEWxSwnPQf2yN2Sq8OQJ3mJatVKy5p9
 WrFIJzhO957NXvYgcVFK2pHl+ACUxnXv0CEhAJ1HiGnyLpkYHu3h/5W9xie9SxVM7AT0S0sHIR6
 emzCgmoVvL+OE03nk1Wsyr/6TXB1KqU6eWGYbRv4AQl1R8a0GqLQX6EiynrWlSWKruU90ZSaVJT
 MggkRYt6j1WAJbhke+zj8XVCoP+H6pzrzLSefw+syW6A+/7Q4CYcEjW0BMUsccMJbaPDsNApC1j
 Wju6XuFwtxbZDxIddI/gCZ55ae8AIs7BExLGr2ntnw5lNnjqq8oWNweU/7xMzrKhRFGFRrT2UET
 SYtdYIzr8iKqqbsdomXKWFYgB6Ke34z0dlEQM+TJQ6W6LKpiVJGCWrrS5GxqWKnhvgBUo9LeuwU
 g1fq1gJ0v/8jpfMBfPleiKxt+qg2OC+zD/q5cWjqcIpEsZanxFInxvaSK8fh8/U7tPNguEDKbVV
 xeu2XcNmywfbjKsdrZPwBV03ZDg+jhN/ksmNbs56pjWv9Eyt6VN7dgvuiXWUF8K6I4MWeOCN0Nz
 5bCSwi/5lSVcRUnC8PnGPdonFBogMPK+pF+vS5saTfmrrdyBasc/Lmsz0Mm8zewiexm+PJ6U1Zy
 XKrm2Nem5C5Pvo+9NpAG8A/kzn90wn7qjct6dnSCbFhB0WHNlgZzsjotu
X-Received: by 2002:a05:6808:5391:b0:4b5:5bfb:f25d with SMTP id
 5614622812f47-55c002340a6mr7193522b6e.20.1793116948460; 
 Tue, 27 Oct 2026 09:02:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c0424973bsm8537548b6e.6.2026.10.27.09.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:02:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Altair Bueno Calvente <abueno@airzonecontrol.com>, 
 Alexey Charkov <alchark@flipper.net>
In-Reply-To: <d7da7b0b-8420-ac6f-1f92-5c643563d045@nabladev.com>
References: <d7da7b0b-8420-ac6f-1f92-5c643563d045@nabladev.com>
Subject: Re: Please pull u-boot-ubi
Message-Id: <179311694531.2385664.15103410254857631796.b4-ty@konsulko.com>
Date: Tue, 27 Oct 2026 10:02:25 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 13:58:27 +0100, Heiko Schocher wrote:

> please pull from:
> 
> The following changes since commit dfcfc4c9f78d1743f490a497082a4ec8e058aae8:
> 
>    Prepare v2027.01-rc1 (2026-10-26 18:21:37 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


