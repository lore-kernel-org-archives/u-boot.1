Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C57606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pDnwtvMF;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FYbE4ChB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA71680FA2;
	Thu, 29 Oct 2026 18:46:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2NqDDO6p0VEo; Thu, 29 Oct 2026 18:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED7E580F76
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793299588;
	b=ijVXGjY7X628C+U2eI5X3+v9zxiDPhFyUhgMi/yb6jNuLZRdRGGJPrls0OFyYaKbVtEQ
	 SO/eHBOdzqI5O+7/UpuTUChChTCUZGOZHf9KGu2hbEzehLHBj7YELZxmG6ySQ910ielAz
	 5ldc7r0EgXZXXUstwwrDSkLdj22g7iXC1BPAyyAl3KRa9lv8OAKTnlRyc7WFsylZ94n6p
	 esGWBz8mb3fPKQJhIrCz13wM1iizScgLrh+0KSf1A6rTNxaxcp9dYN04/I/3zzTiVAYWj
	 cfSYI+zS28KjVUREs06zDOkr11vrqOaoI5q8xCuFwS5eODdIA8jvm7aObR6GLo/7zxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793299588;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=N7wZZbhlQoA0KW1SIjH729Xy2I+PyTWFuv1RZtQ9Pog=;
	b=p/1cxbIYQw4GPKSsjA60FMqnyuS0GYtyrbJRNHCrGv77uEpiMxiwrBlr4AuZB1D4coqJ
	 lNruz1XOCiz/Iy8MUbA8diDqBjfxL+dBWeXjI+daMApLxYLJW0nnu5JAq8Nr9/xUehrK5
	 9A2KfUYEAcZag78sLqnmEt8GZn4CSuJkzOaaUkx+pNoFDZiKgiCJUf9Czc3m4oH84aeTV
	 BiQSuqe6djZCr6P5IJlJt+bNisg9pt0LxZbRpxi+wv3DTlOkwGfgrOG96l3WPCj3O0NZR
	 JgV6kv3rzeMfIeKwN7xjcamPrCSoQzMvwqumbq7ziEuHEkGzdDrT08E7djjh6vh+AKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793299588;
	bh=N7wZZbhlQoA0KW1SIjH729Xy2I+PyTWFuv1RZtQ9Pog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pDnwtvMFKonJ0x0k1D4JbHM0Cc9b+O4dayVLKSCB6U7XruDhyhVNqDCqLwhkUe2q6
	 Pk/FqL6UypPrHE9hCZpuXjpAVMgTjuxBESxzIHS7W7CZU3+50rMXJUyV+070bZ0Hs0
	 y52NTE48dXYAvOb+98yOEavZnAx+RJ67FlMsGrnN8rms/FnSrJwblSPvAIphPakLS+
	 IJNyXHwQQ01LYthdRvHp0f+NIzq0IqezZ3ZiZeKEc1knCoBE2BiTkOFJwl/M4OBPCP
	 y9YG9LPvkfAHbJF81eR5wCEbG7hW8hIqh4SozMENRkr6nutvbw5VWd1Oqx9p6q+751
	 +K2CU76pawJCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED7E580F76;
	Thu, 29 Oct 2026 18:46:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 979C6120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D31B400C7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:46:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7RFkTGOEA4P for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 18:46:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2685240048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793299585;
 b=Ny3fmoSfxWD6ebPvc8vK59ffSdFnz06IQksZp2TDqcHzFMmiM4UkRwgTORArwHTnDaIX
 veYp4225DALDKj60vdMHbXCpswxcu99K9GalRdU1coYVQVdDUTM2A3BP1vG3ndhBKR/qP
 ag5+ILsahTBVNNUV3Hcu9KlyaldXzf2/h9+gP+KwrwE+O6blAM0IYMP++JBzOdQ+GlaiS
 UnWJhEnZGdcHW547aeB066XgwK7auj+q1gugoZaYcbgmnCJ/ACAlxbbU6FaTgOoHkZ5M1
 RA4ucIrmhI8ORx1v7YgmimprNavvVv1np89TMAu/y0MbUokkGTkKEILev+bEQ4ESnxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793299585;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=N7wZZbhlQoA0KW1SIjH729Xy2I+PyTWFuv1RZtQ9Pog=;
 b=K/tnqUVBNwKT4JMNQJjE1YPD4OJBCMsfrW4QiMZXjtfpteR2uw+DUcXBch/Jv+gWHkIf
 QoUdVyQmvhPw18tVfxQ8r2q6foC2BSKyTwiDf2XSRvbqR5NSnMaV8suj2qBfJyEdE3177
 OvaGu3vN4KOKBxAVxVX544TfF1jSrAZdVu56Nu8yf/sOQWPKNmWQhBNFICf6P/iMmJBGO
 Fe/gsiJu4Gc6XR1kvl6ySSklrjO3F+jmrFmDWSTIMyDkVCd/T6rWWpw6aVvqW6yulOGub
 nHW5UNksu3XlimOOdSb0krtG+EjErUlX9RJvhIhAXOR847D2vLv0flGvD9YJ6yuCKbA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FYbE4ChB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FYbE4ChB
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2685240048
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 18:46:24 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2108038f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793299583; x=1793904383;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N7wZZbhlQoA0KW1SIjH729Xy2I+PyTWFuv1RZtQ9Pog=;
 b=FYbE4ChBraDUS4lxi4jjKInt1vSq9nMGKPg9LshmdQGzenf4j+aQsKaeVnyY12V19k
 gBAGMFBw+PSHH8mjRkPuq9iDf8Ho7hjVgxHJQ34uL3ldhWvhhDWCIs+od6tuzpVOMizm
 nNf3XHfr7YI21HsYe3dWuwwiS2574bKr43g/zbOUGnOlGejBr6o3I8hts/2hmKKO0A7m
 M63JHB3rzo/6hu0nkOX0GKNu/kugkF8p07iRK2WIFT1ZBHz31GcEfcHYJDk7lPE2nl83
 eQxsu1L4xsI5sChvJn1nZFocfdR73aAVa4HJCCETV61KsVV+pind6mly/f0HVjafZ7/h
 FJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793299583; x=1793904383;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N7wZZbhlQoA0KW1SIjH729Xy2I+PyTWFuv1RZtQ9Pog=;
 b=TfxIdhBknaZ8bc4X+y1nyGIPgPWdtOW6WcQZMOTXQfQ84hLPhbJs+62ImQWPmGrBc7
 tvlAnDvYUW7xrIz12N68XHeEawrsU7cEZdSVJRzSDlAPZNuPBiXW3N+n+xnWcyWWkRxY
 Yv5wEarobYsnsLf6BA/XamNFwXIqfkcssMoXyQ7IlSTfcv9a9i5qO997cT4f86iRhSsq
 1wC2hyD5l+eLSzwxgjvZzP/IoUkH3sMBcLGMUG6l1oSrYUGXQKygrsy3CI+i2sGeNeRl
 8lDC/XMjjCePHwjkyo6skAb/VETi3zx4grLpupClVtxoMgFWBMWqd915ZoR1/8kpmRc3
 fP1w==
X-Gm-Message-State: AFq9FYJGJNzugxWsl0k5YOYP/GUwzqdv/UZMhq90lWu17zilLr/sqUgP
 ndcZ2WVcJxvdBbwSPgU/9+fTExusnOA8nE6CvSz6X+giwJN1LVoZmO3kCfHqPo4bJ/M=
X-Gm-Gg: AYBFou37JNWkK7WDydHmUzcCFmq6e2MgZ4W8MDEbee3Hgswj3MYs7pwNUWr8HA30glg
 nK7/LGzafG2FO51+oWmk83mkfmsvLDlvDMM6jCv1qV3GUVhMqI1Db3tPJJTLLcKK8PS2Wuth9sv
 XEMgmfzR5RP3qFVMLMQ5g/HWixhof4Ud7nnaha2B5SsqytimvKVWJ8C1ViK5prn2dRIIe78VOFx
 OEm3NqkngRzcWFrIbCr508GlWCZDhIkgLPMNQo77euyZ5UE/Oyur4olZSI5oeJRWmw2sLJQ7jRY
 /Tf6+AbIi40hC5Sn5BHAcWB46IgR2RiBbrp6oWd8x+kbPxtQwlheNiQhZO/4eFlBQHh0viE3uy5
 uU48LR8WGXbF+pReARLr4E7+Nq46kJE/FhQbJebpfRH89JAuVGy/4E0lk4YE0C8lbPZdik+sJAe
 qkHRe9idxhvbgU3bhX/JOOA438fz8Qo1SR9vln54o+yD3rqzrk96bu0cUao4MHJkVkGtAQifLDp
 ux35nXWKFKV14o5IHeqDRlT9mQu5E1vE4tvx7irwLuHYniD37w0NAET4LBQQBdRQm6V+W0n8tir
 tBhLnJ4r4Qph+xng+avkIgKPDCFfBLOEQkc2RBBMzeDD7B9x0eNSCtq+oZeLqNpsUwqltFECo4k
 HuLnqIEx/hbr3lJE=
X-Received: by 2002:a05:6000:2893:b0:48c:58d5:30fb with SMTP id
 ffacd0b85a97d-48e6e2db3cbmr697953f8f.5.1793299582609; 
 Thu, 29 Oct 2026 11:46:22 -0700 (PDT)
Received: from [192.168.1.37] (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6eba32c1sm151652f8f.58.2026.10.29.11.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 11:46:21 -0700 (PDT)
Message-ID: <c0a18656-0e0f-4a70-8080-ac0525577967@linaro.org>
Date: Thu, 29 Oct 2026 19:46:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL] Please pull qcom-main
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Heidelberg <david@ixit.cz>, Francois Berder <fberder@outlook.fr>,
 Han Gao <gaohan@iscas.ac.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Petr Hodina <petr.hodina@protonmail.com>
References: <20261028205507.1705522-2-casey.connolly@linaro.org>
 <20261029003217.GE2677024@bill-the-cat>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20261029003217.GE2677024@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 29/10/2026 01:32, Tom Rini wrote:
> On Wed, Oct 28, 2026 at 09:51:26PM +0100, Casey Connolly wrote:
> 
>> Hi Tom,
>>
>> Sorry this missed -rc1.
>>
>> The larger changes will follow (likely for -next unless there's some
>> folks are particularly keen to get in?).
>>
>> * Add scsi_scan_new(), handle scsi scan in mach-snapdragon without relying on preboot
>> * Small docs cleanup
>> * MMC HS200/HS400 support
>> * SDM845 rpmh regulator and USB3 PHY support
>> * Support for switching to EL2 (replacing gunyah) via SMC call
>> * GENI UART minor RX fixes
>> * GENI minicore support (GENI QUPs which don't require firmware)
>> * Added proper support for various GDSC reset flags
>> * SDM845 pinctrl/clk fixes
>> * QMP USB phy orientation support
>> * Fix SMEM memory map not including some carveouts
>>
>> * ufetch: fixed LBA size wrapping on 32-bit systems
>>
>> Small rebase, CI run from before: https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon/-/pipelines/1779
> 
> Erm, that CI run fails on qcom_sdm845_spl which also merging this fails
> to build.

urgh, the SPL build right... I'm dropping the MMC HS patches, they're
clearly still not cooked. I'll resend once CI passes

> 

-- 
// Casey (she/her)

