Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F8B606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YyLqiy/h;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=EwMSw858
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E642B60D64;
	Fri, 27 Nov 2026 19:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-o1aKKlaE4e; Fri, 27 Nov 2026 19:16:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4A96460D7F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795806991;
	b=Pg348QOojZKLQAcS5tUjra396f6xk1FMLUTEOBdDGemsXKzbnvjBG335OtTuCyB9DyIF
	 G+57qNL5uQQV+g77V+IbU4OWtLtxq63LQRUdBoqUNSrhADZsHUyqn9uLV1VKx5cOMcLP9
	 2K3MTd7o8Su+S4Cm/ElGWHUtLCygSTp12dFFr2jaK0JBy3e8PtL+ejGNOzEysudy3+C4z
	 eIGVLlV4HL2A3UDJAfQsSdiRGT3IBUMB61LKw3fJgjkCV6FTjPk1TnC83xBNL6ngQ+IaG
	 ouMYoIVLGObzeQJKVUASOfd5Y6H7GO3+E0cIp4c7cMA6oLyqSsafxjqdV/6Yi6QeiJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vcw9PWDQlCh5nErpZc4vFv7RMZX2643DPekDzZ4KpxA=;
	b=RK5fF4MUWoOFc7AgvjV2gyb7fYmfWWA/rkAA5nCnOjID0AlWmfXWLKt98b++ANUCLNid
	 zmIPBWqCK/aVGonrikIKUaadC4Vag85noCUhUGRfgBgVC+/eJ9/tEi7k6pzTCsKYA6g/e
	 FsMchNeFkIDzH/MdO3kQYAnoJREGMxXmdFoK02ZiyrjSrdfntgRjcpYrzQQ7KFJOPGQaO
	 ewSobiKNAZH+mAbbSRpna5zju3zn5eDYwqNWXbhQoFgylah+L5uPHNh/1V3m3925Sr7/O
	 MYyo5H8xq2UkU7mlz+7lxut+Cw9pgXcLjtx0nvg6QoZ1dxGKMBRLe0j1K63+XeQLohA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795806991;
	bh=vcw9PWDQlCh5nErpZc4vFv7RMZX2643DPekDzZ4KpxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YyLqiy/h+3+/IV31KwuTA30nUuqpZsZE4s/W3M8+9BYdLLp13eWzTKgKr1yPLg1Sq
	 S5OSTDfCah/9uL8SOrd1htVcn1nwKBWMFWiYRHT+FIbbvm5CdzgfeFlJxttE57/uDG
	 lH4lssCKa+S/7z8SphoYco9+StYkZ4oHFJm2oeqRfHGxZ7cw3pchQgo4mfHB49En0F
	 O3COBXYaUImfN/LqLOKJUS+2RFBfw3iDfA995N4as4OgRgEEgajM++9EovIu2kJNi8
	 gMG9LL6zD27TleNEpi5w6b1/VCbaaOnyRLGDFodTN0YnyKMT20R9XpBKWXZ333sicn
	 SBqXbmU1NwmbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A96460D7F;
	Fri, 27 Nov 2026 19:16:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C36B2311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B51CC812EB
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id otIO8mt-C6DX for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1507081158
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EwMSw858
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1507081158
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:16:24 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-862d919fb1cso4059065a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795806984; x=1796411784;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vcw9PWDQlCh5nErpZc4vFv7RMZX2643DPekDzZ4KpxA=;
 b=EwMSw858Wdu1EzNnIWZoyxMVXAccXJYYWL7lWBDCpN0uzz4GXo+dPvQehT2aRZCG20
 VEJ9anHvDKKXzynjQX6DOkmstWXi8L+8XsMJvY5HFlVyWrbrrLvv33Di/sVn928rfsog
 HKjLkkOzdsa4CxFmVvomjzTLtKyyCB558Otto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795806984; x=1796411784;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vcw9PWDQlCh5nErpZc4vFv7RMZX2643DPekDzZ4KpxA=;
 b=wZBVDuHQaj/AXwnU1toWPIJstBEjOhG3u6Xf5Yk1f5M4hCs9FZRJN4OgcnS4u2H+1g
 sTw5H0CBcJHq5+zTC9IJYGfloOGEKFJhmUfHvUcVtgeDx9i/QHJWFVX397M4+4u5Q4Db
 iVQr9VjJDjb/4nF2pqWpTMSujOxOCn67OKCMDi+CGj+ER4XUXXmScsFwXcLyZx+ElE4i
 QNn8wTw2q6cxYjE6+AOdrakL3ep2vNnf6FI9AXzugbY4mFKmrXMz0V2DLoEZdiwWq/ht
 RxoxJnN8dd4YG8FuIQUaE5F6uWMQu1QTHljYvuzqP+Wooi/2y3X5R+XjwqByqS18BBvm
 MF+w==
X-Gm-Message-State: APuU4Z98JXyfEv29UQ41ON7q6IIDiLNm7R1N0MYbGnQRluFLz6WO32dV
 6s8ZxfSILES4CoisYMAR0f6cyY0iWi+LQyxl9Y/J4Rx4U5kflHM4MKnDKX4WT75q4juFnYkj1J1
 xaYRQw7mUPBQh
X-Gm-Gg: AZFdTZeNcTNFCgDd4wdQft2bZXaMHtzQy82MtlkNNJzHNlfzhNoiNUTK4gwlEomjVRG
 u/lrS912x9dvFih29ZSmiOHvGVvIVtknZNuYA36zzq4P1TNvPPphfMO5M7XCNTdDEJ4IgOHrbeN
 VFXPL95O2MQ6mQCVlLSdj/mFrVpq1i3AMA3PE+fWKlUOQA/x2LVZgbXA2YY4m6fIcOg0fAwMEAm
 fejDNlAIsbzb6ZjTzg6nbVzqkwi0SgayK4V6MAbCvmf9pHOfbmWC+I04G1TysGcP4zwGBj+wzA3
 GjRCS5uxPH/VnlSfg+UcO6pw5QSpcRA728M5rAKKhVyGFHhYpsU5Z8bhOkqXVsW/OgVvRo8/1Mj
 rllQIlwxng7u/RvDeBrD3zJ92a3E6pqTovOjLoKsKhKW7mgjQHAGsjyXuqWZp82NqXaSePGmb0o
 nmJCwv4GZ8+YwXkPqy3gMEff2Q+AkYmaYSTld/XPWTHdN3ZqbiTCwLCApDjrxbaITfeWVYl119P
 8bg/m+W5RykwzknQPFA6t3lqF6rSkdrFbcuXdUgFP4t8y6x4vBctV5lK9iDHPJi+tWiP7GcZjFS
 4TDst5Qpy6T8uW0TtnsA2x2iC0iLciqEbKptR9yeUdG6Qcpqr5gzXhw+CTfRHn08UlJU8xzIhF+
 wLvx/Svz5LytZjqkaEsJ17FAVugsdKLSUcxJtuUaUysMu7mn4TQ6ZRZaqtv9+s8kxUKSVpbJDjt
 Y4LCvnbIplz1/vlKoUM5hCscTjK51dG2T5Ku327C1y25i3l5+/o0g=
X-Received: by 2002:a05:6830:b14:b0:81c:4784:a5e2 with SMTP id
 46e09a7af769-8631549fdccmr30043876a34.6.1795806983750; 
 Fri, 27 Nov 2026 11:16:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-86385358ca2sm3258789a34.21.2026.11.27.11.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:16:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20261125204733.2995467-1-trini@konsulko.com>
References: <20261125204733.2995467-1-trini@konsulko.com>
Subject: Re: [PATCH] Azure: Move Qualcomm boards out of aarch64 catch all
 builds
Message-Id: <179580698317.3581729.15591831580446487032.b4-ty@konsulko.com>
Date: Fri, 27 Nov 2026 13:16:23 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 14:47:33 -0600, Tom Rini wrote:

> The aarch64 catch all build is currently failing, due to running out of
> disk space. Also currently we build kirkwood platforms in two jobs. Take
> kirkwood out of one of them and replace it with qcom, and exclude qcom
> from the aarch64 catch all build.
> 
> 

Applied to u-boot/main, thanks!

[1/1] Azure: Move Qualcomm boards out of aarch64 catch all builds
      commit: 40bafcab3bea0511eb3925da2f0fdc1df9758e3d
-- 
Tom


