Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BEAC54F51
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C31B78146F;
	Tue, 28 Jul 2026 21:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bLzPr5swxdY4; Tue, 28 Jul 2026 21:56:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 291248146D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275815;
	bh=jSMm9Vr9GVkOH3IgKom+XXX0XV+K9TJ/HGv+NSlBBq0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eOB9ZbJZHEXi9F0SrdmVYst2Ntn1jGCgFsLnXAEBuyzSuowkFBCqEUpS9nMmnRd3s
	 SUu716nf9oFbkichiijZVv/uFVVhYQxEBc9zhuqBE9lzS9oU4shxVIAn+F7yrdz0+C
	 ZEfSE8oVJPjvg4jEOkLCvYR247XHFjLWqUwOuiPaowVs6iJhi/Ok8ImnBp7BPZklod
	 +r/4cgS2OOwysPSUS/j9QVY7QYEI1V6cZ8Jaa5GO6de0DBX9asp0YNZoqc/irXLrRq
	 R+20DmdtDlDvvarF4Mqelw3kiHFMypVxxWEoDeMU6vSBxrCyvVL5nDHw1wVywpKAnb
	 3qzfR+taRqwDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 291248146D;
	Tue, 28 Jul 2026 21:56:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D169845B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF242401E3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBd8geZYt4QO for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D251140051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D251140051
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D251140051
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:47 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9ef94c0e2so224595a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275807; x=1785880607;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jSMm9Vr9GVkOH3IgKom+XXX0XV+K9TJ/HGv+NSlBBq0=;
 b=rEO9+Wtq8AG4Y6AZmWfVRentU9WVS+R9Ts8k7PGEpP9Fq2Q/kR9h6cmvoySX4ozSAq
 nEupqhOnlmqiFuN3ro9s6rdsr9R33P9dp28bGHyuz9l0VXf0fHeWtJOZXdG7Ce3Wx+ni
 H3oDxLIhN8QcrJO3+wgZUxVtqiAh4ffMDtado4CVB/BHvi7LJT3FBSBcVA2Ve4XNeCfx
 PPj1lTqYC+bWBEVsAwnVFKt24gVDHLVSzro/nTEMWcRWM4PMEHXQBVg2tHezRwD0Umiv
 ExhzJvxSJFjCSYCv9kH3fgU/IDAXRJE+ewOOiHyqMQmShJrF3DAVhq9OPxWTTPA92AMI
 i+Uw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqArjwwI3fbBm0hLDEo1ZehEeVxWuODoH/SbgGIB3QkjUMdmhEXza+9a2K9smnonTfTJxiG07U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxNU9J2W+PQCE9S3F2xIoEItSrPT0MZI0rU2Rk7SM+HJOWbyyid
 B/Y5gKBkYOTVfjpYAbYZjKsEOUPYDCOu0GECNt3i66VvvrinMGq3dis2oHXCiZeAAGA=
X-Gm-Gg: AR+sD12OWXCov2M39x0dpJsINxBpgd8VXYTiZxUXISLLAnU/qGsITLYdwDx4bnalf8Q
 2K7J5pA88WRmY24uzcK8Z6peua4XOCFyrY8w1i1R5qFcsIp9Kre0ObKVpwHu8LqBD7ujEgkYK4/
 COwZQMgIMc0ZBnvGeflmKU5hhL6GNekYhcuXT4O8MfM27h8+rFkW68j4k3MqQw8Sjl7c8qclTYU
 KNKCpw5VAdHbX3bz4tsHk9RIDyrMmxLQyOHTAikZM/C4hoa4qVMw/nFJIWeSRSYMnwEf9bWEedX
 /8/LQTo2eu2YlcgjH5L0/yMykiBy7AqbFKw3pBNSxKYkYtdV3jM+PNnDa7rYexgn+GV5BcW5278
 bz6YEW5lvp3OXfPE3FiS+ChSxyMXPlFUx3c1QaIAIGuYRsmOfFMOpwKTX8IAKU1rTSR/oIrnJkF
 q0LsXNCTI1sClIdZMPBC+EGV5MwbvJz8l0nUNbimdyL+AlXlcMGipam2lerD0M4n4Qn7ArYrCBi
 VdaxoCbgaIVp7KiidVkaSSKBY8C/uJGgkCvjm6BEG0k2QnH1SFsoBF58KLrMxx9uRQ+h7JGWONo
 s2A/RZLH
X-Received: by 2002:a05:6830:6085:b0:7e6:f406:2cfa with SMTP id
 46e09a7af769-7efff26f0e6mr2362641a34.17.1785275806726; 
 Tue, 28 Jul 2026 14:56:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, quic_timple@quicinc.com, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260715173000.178392-1-aswin.murugan@oss.qualcomm.com>
References: <20260715173000.178392-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] serial: avoid redundant early UART initialization
Message-Id: <178527580591.1742553.11945741838403288750.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275807; x=1785880607;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jSMm9Vr9GVkOH3IgKom+XXX0XV+K9TJ/HGv+NSlBBq0=;
 b=S1hAnbVl1sLipctlhVCRrWiY0SDN5d5oO5ntE+1K915THkICErB1hRizIRT7y9FbUs
 bP40Sa2oN0Jc7eAZ6Xf5Di0pgY9wmAZyQ8UgXRpjJ3Z3+63i9J47MjttzEtQpsYRob7g
 Nr+BhDiX3+bVtxQfTmScOKSI3JpscRkxGI32k=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=S1hAnbVl
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 15 Jul 2026 23:00:00 +0530, Aswin Murugan wrote:

> When DEBUG_UART and SKIP_EARLY_DM are enabled, the serial console
> is still probed before relocation even though DEBUG_UART already
> configures the UART and provides early console output. The debug
> UART configuration is sufficient until relocation, making full
> serial driver initialization at this stage unnecessary.
> Furthermore, the initialization is slow since it runs with dcache
> disabled and is repeated again after relocation.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] serial: avoid redundant early UART initialization
      commit: 8eb3f9ef9e0de0dcea4aa85d770d6aebdb577f4a
-- 
Tom


