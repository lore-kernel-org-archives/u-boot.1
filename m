Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908E606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RHIwY+tM;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RQlD5iBe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4175F6071D;
	Tue, 20 Oct 2026 19:20:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yiGAsTMfooRZ; Tue, 20 Oct 2026 19:20:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92DEB60730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792524012;
	b=NWE/ntKIpk9NWyIJo2vbEvrJPdvpo205CdFMDl6+fERd27NOX+nUc9xSWqSgS2ZkB0b7
	 mLoqLwTZoNd5Nhl2juuwWHzQ+CZ/uAOOFxWRg90lGkYfXb8VRmKlAv2h/MXwhJP65adTh
	 UzXhU2Wh8pO/aCR4HMcQ+amQbLpeQeO4dX7n3pVPVzGxbgXIlpVT50KhF3HjuEw6sZNZH
	 jQTJWG286d8jW3eNkfkUeEjzfeDeq/ZipIJnpVJp9x4F5LrcnqrOQQZvqDVg+PQVOYCxo
	 Yc4ib0MPfdtZndjGkmX11S6/tVKjP2ph3GaKzMZ0wyuafDF5o+LtxYZg+V50APWnVTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792524012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Okgz6/xGyYknGx3sONRmW+SzvAbKa5hSZLM95Ib/EX8=;
	b=picLkqFsppljMZSyaUbImYVGHt9yVWiBPPGr6lcQmLp2L33XlzhGDOuZgfYmZ3pGlOJu
	 /mgCqLEfo5Z0Qhd/zBaa0tlyOI2cmsbiRETTLURqxCpNUgGyMNfx0sKKnnrVbGb10mI9i
	 mk3qCyYVDVsGbAquABJkALT4U0YWLYgoMxIPyNwTY3dpRlXJhDhK6JgyTWYSO2yeKS3p2
	 Rvx4fe4y7nCnZzLdEjyo2v8n36SezVrFPG6Bh77cotCmuHcSBpXx0kAcurHJ1Mo7m/6w3
	 rno+lVkuMd/fojosF88pJ9nSXwrwtKs/YfQi7R1jeNOHW4eXRGS8uoyZzlYQF1WcVaA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792524012;
	bh=Okgz6/xGyYknGx3sONRmW+SzvAbKa5hSZLM95Ib/EX8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RHIwY+tMz7byWyAJioBG4hpH2u2gkaKvxB4wy/zlKv+/gpllwOPMWtW1mUMqNeNNa
	 yXl4Le4OhGwXjTTJmJeaIH2YhlzQd3yMWgKaIjAWO8HU5+bnk1p9qlobi5iHKmMGzA
	 O9ylJ7P4UO5e9uE96xVrDQa6zRxe7QqAOkp/kXKfMNvfDyB2cRvw9y68H5JxaVE825
	 05++pCX6h+KP6IYP05d6HUde06/3mCADWPvjxDDRsnsZ5ZVc/uogb0mDbiXCMj6Fwn
	 kN8iTt0RpYLTUxU0fs0KXuHUd/cuugMbBHTkBIVSslpJzDVwCX8NUl2RmetI7xQpTP
	 hUfxdYecYR6cQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92DEB60730;
	Tue, 20 Oct 2026 19:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D639255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B246400C8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fh16Mclv9Ha for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:20:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 548DF4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792524007;
 b=FPZ3svhmFsggBdkx+q8mzlCRhyz4FI6Hu/Sxr4qhAfknzajbZQux6eao1xr+dlyUyI8s
 IOTuSw+51Dyi4BNBjI/R7LUX/dra6+89Z4CGsXuMxmO4zBHobi2ggYFMhnPDR1Uw566DQ
 4Xssd3kZBBjksLjSjX0eBWa6+qh/pt/Kct7FHdi5pd4C/SDugBeBUxkDY7u/LjIQLbV1/
 WMBLuuuYl4sSBMCG1m5WdAhYx+Y+ZlHdYvK2iVD2B3KIHHC2R2HdodMdo95PQ1pq7DO3L
 XEMORgowv4jrdd7AnWL91V/hZkodk1eI5ewA9trNQgidBrm0ZhjWLnSW/Lok9lnXm6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792524007;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Okgz6/xGyYknGx3sONRmW+SzvAbKa5hSZLM95Ib/EX8=;
 b=f2SpVKOVwGOQMRxN2sD7WrlZM7sroZVRi16MD8bV2wIlrPGjJiF5Vz0N/4PJzA+7LV5J
 afozci7luZqKi5HE+t5tLVM2fYO6FhJa9matiu9cSQ/uz3ZpTDoUaGKCZb1qSL7/Nr79z
 ATlli2OQyJKKQ/sz54wuMqMnZgu7rSQVqMZsdw0XaNNMuhipfNIJHB+J6jnnw1GB6ES4e
 Ec5V7IuBMwACZA3iGV3HePZGF4xWqPcWcE0V4hi4CkLDGiVuE/8LANb7xXyr1Nd128TRo
 XlRuOmTWc+y0ExdnNc+QktZNUFHhnPrn5soNCI1BK2ofjd5ee4OVslM1DijB9Qfy0gQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RQlD5iBe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RQlD5iBe
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 548DF4006F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:20:06 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-82109f51565so1512944a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792524006; x=1793128806;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Okgz6/xGyYknGx3sONRmW+SzvAbKa5hSZLM95Ib/EX8=;
 b=RQlD5iBe6dXIYKMayAhE5nEXsv7CJxrsRc2hrCzd9bf36lfw5H0kfG3fA/B2UFLReI
 fWta+3HSHR2GzJNLfRnTnsiYfyekWvX7PW7XJU10yIEIvrjWthPFF+rvhPcyV8MaaJ8h
 ESUL8Jpio8G18e2QENtjevmHUBi6mgYWt7HJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524006; x=1793128806;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Okgz6/xGyYknGx3sONRmW+SzvAbKa5hSZLM95Ib/EX8=;
 b=NyBs779iBfLKQqMD9NuAH583FHpZmfN5wkBn63oIP2thQBoeDwOxuz1T/JbvYh57wX
 JGKJfyajZDkW/BAvDXGLtgGA9pdkUDWgQ5hwUeO0sFZype0Jy0waDp2vO5u1aQT5x61y
 upIZMrJEYtRQEpWahIXg1qh9g0IhLX+OIl3DLRYslJa6xs9X3i/Ezi3triivh+gy2PqK
 bQ8SOD2gxIsNZWyLT4Z+Uw8WODqtWC7PfYjMZSRPmKwfjNnJb4QADrTb1XZU6tCKFaDr
 L5dwRwwTvOKxKiKve+Ov/hI7y71cKd+FRVtOV/q79TTSSA5cX0M5z2tx0BvMz6mxEwvZ
 VAng==
X-Gm-Message-State: AFq9FYJyQhMbLA7CTSLMZH0XTpC6/DAL68HNNw92MsJEUVUG+kizp/ig
 HDhVsDwOHWH55rcRYXc41g62jeThQ/dJl6cxkgEf0AwhoivIPXOxEM53y7Z1uCsCcwX2sfy1bI0
 wvArBhQlHTPwR
X-Gm-Gg: AYBFou219Rb7lLPHy8+lUmxrQZZbzo5VX4++LkbRV4blsnDfFYA+C4gjKXG7Cn7hIE+
 JaR53vcBhIIsUsazFsk0elHCX49L++M/svaKPD0uBwVvZV1ME6xQtiG8z7vE4JHfsviolCog8OZ
 SlGe4tAr+I8oub834b43Z5k3Y1Gk7anMDn8k3V4Ogt+50mqEwHPTafqSDZmhodoSqbAOu+hTB2C
 t3FJ1MJTER1iEd1rbg+7Je5qnNe3lslg59ovDftQ2BGUE0WHREviWsMGEAJmA/0U77n+n52tQT8
 q4qnnJnOjTYD1LkNfXHwDYdSVbaw65T+6ihgNUHH817/pbHRyL0IWgNo81qLTIj3vXqHPwqlaVX
 ocFngEREnLBEyqoxk4kZKLRga0ryOKk91JmbRpEjNLibvbVBZgHcBBibgAJuVrY5SzJ14KyO8A4
 EnVfOGJdzgmrIfPmHJZSIjWXpv6WWDh8rr312fyDa+cyYAawF+JNqMP9N22/WsC+PKZHfiYECy1
 TQc56cuGYMhVFHmU0lrG6Tvl7i0+0pHMb5s1FrFpGovo/K76GpGHMLy2JfBUJXD6M5U3Xe3TJ1M
 RkklHhIXKuB7idFlEA==
X-Received: by 2002:a05:6830:661a:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-844f3396ab2mr12509029a34.0.1792524005793; 
 Tue, 20 Oct 2026 12:20:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cba7d4648sm347685a34.1.2026.10.20.12.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 12:20:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-ti-sysc-v1-0-e2c43cecc71e@baylibre.com>
Subject: Re: [PATCH 0/3] bus: ti-sysc: Prepare for use with am43 and
 OF_UPSTREAM
Message-Id: <179252400522.1115934.8507237180512218999.b4-ty@konsulko.com>
Date: Tue, 20 Oct 2026 13:20:05 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 27 Aug 2026 16:23:26 +0200, Markus Schneider-Pargmann (TI) wrote:

> this series prepares ti-sysc to support am43 upstream devicetrees. In
> particular CLK dependency has to be removed for SPL.
> 
> Best,
> Markus
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] bus: ti-sysc: Tolerate disabled CLK
      commit: 2580bf01875be7e2769679cda03811fa1a9a4dd2
[2/3] bus: ti-sysc: Simplify with clk_get_by_name_optional
      commit: 01f891c2a7d243ddb1ae07463ca0b9935e7a2130
[3/3] bus: ti-sysc: Add omap2/4-timer compatibles
      commit: 0ad4c34260a9ec4dd77d39f98c39a7b58ef47419
-- 
Tom


