Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA960A382B
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bHGckBh0;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gTbvMbCb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39ABF80E7D;
	Mon, 16 Nov 2026 20:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uN3eT2FJ1fPO; Mon, 16 Nov 2026 20:04:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6913180DE9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794859473;
	b=M90ZaCj0vqegBVMA2pxisMlnYJUERlayvyBBYj18PP4iAKTJILDP3zvU4APiDsO7HU4A
	 AZ0VejtOCokKRUOClnaUdGJi3aH2y11UDSTDkWqZAxRf7mjftenPvnM136Hww1hRyWDLI
	 VqL6RZ1qOhgdqAPKte1JhAzdkMZsopvFYLd/NRSuLUmlH6mRymgxLxW49O9j2/hQlKFlE
	 DI6VGO0I43Sb3i+WbeKgGzbKX9p6Hrq4lzQoIOD76lv6x38qfSMicbb7H6mh83cQRS3qO
	 zVqj57gxMewIXgtGTX3AUFGJ2ensrHIPhDODCibAUSh/Zk0/bzEv9IA00814eiwzb6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794859473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jwE7nTdtiGniGZ6PGcqK4UfLryQqWbDrcMB0Qbu8p4Y=;
	b=N0bTnoVGteOoiE1yX6KbiODkmJayHmiozLNmd2Klp7VCh9meQp9CsbvxVXbY+GAsI4jv
	 ptoEE8lJtN9lGrBh8dBIItXUsBHdu8/FeGnkXYWsVMOCApcrpDdnV/Mp9YcktrOCLRtrh
	 1ipYUtGgu4S1ENU2adtwhLd4zI/Ogb6q249HFavsWnhQPT9jAqPAKOcuoP+RJ1Ckflh8f
	 ux1ucgQUAxzFWZCpIRHkhf0oJJuRIlB1I+8kkQb8i8gA/v/H59JQGVFlg1d5no4Yq4vOd
	 oLUWOD6ZLitS+xRBzIYSRY5KskSX8/TjNlvMz2hxgmhEI633QR/05dWJKyEV5SMEejQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794859473;
	bh=jwE7nTdtiGniGZ6PGcqK4UfLryQqWbDrcMB0Qbu8p4Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bHGckBh04t+rsEsLWaaa6n+hRq7ulv4H07fKJd3UNa/Ou1hohdjO+yXXSDL8DQ/Yp
	 5YkY3A4zkBcLNMUAzmCTvKhAEU6Nf6Wj+jndO8BPk5zVnnuVPR6dm+oT7c81Ik1iuC
	 QNsPzetb4k+w7WmEnwVGYNj4tgNBVR4CtO3K16vjA6Umc5noGIP9gNRZ7l4WWHyHX2
	 fiHulYAO6p0sFbWRAOoE5DNAnufGCBbYf74chKy6ur+YW7LlsMOJDjzTdIetNFwFyh
	 PfEEq0nxwqcFp+s5cUgGCUqh7EgYpSGk72LmL1tFob6f/AGdIEtROq+ICtLl3Tmapp
	 Rs7q+NShBj/PQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6913180DE9;
	Mon, 16 Nov 2026 20:04:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F2F070B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2137340538
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypOkaSTkadzk for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 20:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5110940534
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gTbvMbCb
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5110940534
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 20:04:30 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-8490a7d6696so2997519a34.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794859470; x=1795464270;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jwE7nTdtiGniGZ6PGcqK4UfLryQqWbDrcMB0Qbu8p4Y=;
 b=gTbvMbCb4+0ZWwXsJM650e7l64ZYIDP9nULxB8dAdr3/iBpjrf26XBlM6A6Df+rVoM
 LVUWTZzn/ns1lsdhioTa1lCZ52ReGmQMAY1w2AuqfYmybe9B2WIUVq16KChSOtOLXmnD
 eakD4n/W5nMtXdpcxt9KQSoLCI08AScruqPFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794859470; x=1795464270;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jwE7nTdtiGniGZ6PGcqK4UfLryQqWbDrcMB0Qbu8p4Y=;
 b=GXZVCe6gtw8QtTEIXuHwQL4WsWE3Qg2ZuDiZdFUdjl1ErHQPZPX0a7wysvxpFfhKPC
 5cw/8VE4rVLprRBLMiEXeIvNqUA3jgeYd0wBoEgwae2zwkOqYqYhmD+cfA9s7zXrhXyS
 m0jcLgpS74jjvotLSofEQDFJXiq0/Bmpk0G2AT8GOUOn/s6a25k212YcsILUlPAUjFDj
 LpgDUbMorayUwgtaQsqxVHo6xvCc0XuzM+NW618XwWbMe4xB5B+KN7zZjFB4ypCzNRuV
 BDWBza+UJDIZ+gaKMwfYoXzo9g1AiY8/Wz9VLSMkM56A3eAx1okJSHyt/X6Ons0mCTRd
 Xysw==
X-Gm-Message-State: APuU4Z/iliIZh/oevb1Wd0ax97MMh2slysdXNEHTz+INPwiRM2O+wog0
 TsXtvOHs+iSBpzuZQTRWai9F8A1LiLp8LU4P6GEyNVnZLsLXxGHebij7YmCybUo3hDbPI8qPOGz
 2eew/Srndkg==
X-Gm-Gg: AYBFou31T8v7kDqxuPgRdLgxBLO6IACkaQx7tvUIlKvsBC43sBwY1f43jfny0wuN3mW
 lGELeW0e825+iiWeku1sD/ZVC7u+kC3yXI7zdJPGsRNx3BO7DPAXxz5RLvC/VKrQEJ7EkPzeEi9
 eDmxTXlJZ75kTWSzscp+SDuMU3xE6YOlvYb0+fmwS6rjBbcgxyFb6ONkCLFU4DCNZGrwi0NU0+o
 Fff6WefyAv/lHV8qn5ADMDDYFesLA/iE2U86oyUcshpUP10Ze01YIhQNmiTa/Cq9ieuCjg3h5hN
 lqhipJxJKPnHdvTlXDAvoiGQF1oTnM/9JipfRZo0AmfeIs8Y3HdMByGHOyoxkwBilqdafe0Hv0n
 qEAKfXLBWTfndX5O3aeH2LryTBkdCZ0mMZ32ziIJdXcxXIcitAGG8K4dd+HbXRMEh3GPs3TD2MK
 3fSQD60iGiA0awuJvmE7VoQgORJ8Z4SZbdCj7LKkx3bJZPTlHu12B/hhdN8FH3gKFDeR8qV+Ez4
 Qt3I8I8p8sypE3BYSh/lwP1vZjctkdQkjcuNaC+nWdq6Zn2t84xQlC31bjgtHPqBKwcX5ADmLB8
 ufqLYPkXJrDU4YZUCvIVv7o8cNPSj1WYd8tfH6bnpyV0/g+Tmbo+K260jVpQ2Dn5j/QsKN94vID
 9YUtt2o2B7Aqlf+EwPwXSLx8WYrLb56W77+tUbAtn+T13zP4HNBTkYl3YzoBr2cXsbh673OU5pF
 fdpXmk/0YheYThoSFqPcyOu+86711/vA==
X-Received: by 2002:a05:6830:6512:b0:861:f4f6:1f81 with SMTP id
 46e09a7af769-86289929948mr10768763a34.31.1794859469896; 
 Mon, 16 Nov 2026 12:04:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880e9abbsm10790881a34.9.2026.11.16.12.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 12:04:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261116170457.1849016-1-u-boot@0leil.net>
References: <20261116170457.1849016-1-u-boot@0leil.net>
Subject: Re: [GIT PULL] Please pull u-boot-rockchip-2027.04-20261116 into next
Message-Id: <179485946939.2548598.16484152740107099806.b4-ty@konsulko.com>
Date: Mon, 16 Nov 2026 14:04:29 -0600
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 18:03:47 +0100, Quentin Schulz wrote:

> CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/2066
> 
> The following changes since commit ecdcf9e365df6249a57cd8cc946e7026804ff4ae:
> 
>   Prepare v2027.01-rc2 (2026-11-09 15:52:36 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


