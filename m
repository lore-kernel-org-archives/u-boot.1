Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B797FC624D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 18:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F47C607D7;
	Tue,  1 Sep 2026 18:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLlSkn8xBfz8; Tue,  1 Sep 2026 18:02:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788285763;
	bh=MP6a3/EtVyeSyAirbrpoLdyQKUc6AMtbm6kBNNm4IEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m7/9rrYUTMykYn5kmMtS2++tDaBOVui0O3zUID/jt4uS+KB3LfAgX9DBwk6FqgSDc
	 fH0YWUUbEPkJ2C/EAmmaNpls5UI9ioRsLZJycO+ikV16gIN5oSNpZ7p0iagP6O99Un
	 XGYF4CTROdp9dZGA6YVWs2Ebt+ZVHxAwp8Shy+2jgJ5UjaNoJQSOI5opyw+lhJYGc4
	 8d9q3sZuWuf49mmvXHgA6zsx07hnW42zcYO6WdsBcKT7QfFOzJl5J+8wBf3xG/8orj
	 oXDXnR10daEZqfbHlgIbLtQrVBUqZqeHR2FpNWYd6VgWgGku2CkDFE8vfk+WR32tH7
	 9ZcCl+jr1cl5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E520607C8;
	Tue,  1 Sep 2026 18:02:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EC842FE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6057760790
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 817yXmqQdjKJ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 18:02:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cqflOdAj
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE68A607C6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 18:02:40 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-7f0355eb4b3so14452a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788285759; x=1788890559;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MP6a3/EtVyeSyAirbrpoLdyQKUc6AMtbm6kBNNm4IEo=;
 b=cqflOdAjfVsCHE5hn5EuDmNUH1J6+c5xneg6FwGz1mmFLSbSdUSW/GNPmv9Oz1tvlR
 p55QMCskQrfuRtQ/gU8P3Xt6B4pyWQbE+2soOrplig3La0+aoZKSetGxi/Bj6soCaupq
 dEYtPSipWAOfw/fV3+IGcUq6UjjI3ssYEIgQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788285759; x=1788890559;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MP6a3/EtVyeSyAirbrpoLdyQKUc6AMtbm6kBNNm4IEo=;
 b=OKaxgN6zE5NR7GHMQkLCdQfRiM4A00+4mqdEi88+tJySg5JbHblcfF4zu1p2LhzSFk
 vlK8QODrA2NHzreqJJ9Ry9DqGMZNNA+M5PW+DC56HkHf+y1Ivq2XCFe5jS/2hgWwpFFS
 iv7GRADUOcqK9exzwM3sJbK9pUjC0u/xZCpkF5nFhXpJIiETAgTY6LN37cTp66LUs0EO
 OsDuYjfJ32GvOCtQ6jsu8YKcjUoIVo65I2m2HFhaht2x0D2voO+LF+9O9XJlQTLzU+/2
 +3DPMiSuKp3LDXkPEwXmvG1HoU9Wz2xPRQ6NSGvLKLF1xLDuSS9zhbP9rMq4VmmSpMxJ
 vC+Q==
X-Gm-Message-State: AFuF++mIkHvGeYIEkop9m+rvX00kbFH1mPZXct11+gTKHE61dIck1LiD
 pKQ0WgGVRS5VQfK6h2RwBlB6bHym2KWuJgBLetmFihzTcU5XxcxWOs3zk2KwLs8ldoAEpv7EUay
 mMCGspi2uHAwqJSk=
X-Gm-Gg: AR+sD13myBEzt7ZLvYHxmPVJdIbrV6tAmP3vJ2fjMZAS9twGKgM1JOzAfD2mFq/miUw
 Tg4fuIVWETQFKYs5HWtV33rHldMmRUceS2IKPsnFMq6I9ByP+B9BCRtCLDwVvNMwMRW77K7gsXA
 DtdJrNEZZlL7KK5Q1TjU4O4lwB6/7FfAwDLuw7Bthf6lGQgpKsrV1iW3XJ/IPwfzv2RdIFQO/rX
 EBCTh2JC6Jj/YSN+nVJ3vI9kebgN+A3oeSRK8u/1OeRcE+9nSXtHvZcsp75/0u7G4CvmfhZGIHb
 0PQ9DiFtPdqEHrIaNoV+Y4k4Ntc5thDzPmW9oh8rV04YKXBy9Q3YLaFMRgUFN82Md2Tp42odpqf
 BLSLSe68bFtQhUrCE2NKMutQQpTZn7hbFE78WHwXtyNkRT+J3VX/3PxoFjguw6swtxtDc8TH1qk
 JZ7omfmpHQ/VxXuAq/SIy+kWzxRgOhv7qM+k9jVFbutM/kdYGW+yCi74ul11N/nc3BOXmpMWEUx
 hqrhyMSj+E64GcnJj/12A/SD4QG2KUwAHo2pVVqBnTBYD3kjcevKhNlcFhbJdalIFgpS+IQ2+8A
 c57JorgO
X-Received: by 2002:a05:6830:6f47:b0:7e6:e385:4c1e with SMTP id
 46e09a7af769-7f4f2216862mr36787979a34.4.1788285759426; 
 Tue, 01 Sep 2026 11:02:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74fdf3709sm113815a34.26.2026.09.01.11.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:02:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@nabladev.com>
In-Reply-To: <1b650381-f4ca-4293-88ea-496e825ab9fe@foss.st.com>
References: <1b650381-f4ca-4293-88ea-496e825ab9fe@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot next / v2027.01 =
 u-boot-stm32_20260901
Message-Id: <178828575772.1482491.6893388087667066896.b4-ty@konsulko.com>
Date: Tue, 01 Sep 2026 12:02:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 1 Sep 2026 13:48:12 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related fixes for u-boot/next, v2027.01: u-boot-stm32_20260901
> 
> CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1143
> 
> Thanks
> 
> The following changes since commit 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


