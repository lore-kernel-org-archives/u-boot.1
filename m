Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB70C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 00:46:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B3CA80AC8;
	Tue, 25 Aug 2026 00:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jeswQHHaQPOB; Tue, 25 Aug 2026 00:46:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787618765;
	bh=TqgFpm87jAIRmts7OVHmLJKoMeTfkCHMidfMVVbgH5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ijpO4DDoOY8OxA/L6tihiZP05fOuPUzIgBMUUBQZZ4uIGqeh7r45JWEpZC5LRKmGH
	 SjqftpPn7CpLuqO0JMkh1yaWKL0RvjtZLysgQftOznjvGcMkwobKENedF6kjnlXdkM
	 k8oF+UtIHXjyDRZx2RsEoulMFhTFcK6zsuH0syrnuL2iMgeyIihTkK/j/5LR+zBOit
	 XsNT1YBjnWMJvSVce3Dt7uS2Tf42sHG5NxNYEzi4/p/cpp4ONPSo1BIDH4caHQkKgB
	 N8Z76ncSuJB3A6+fJ1GokrNGxspCGlb3ZpH5GOlffZlkiC1sfLEo4+rkVg7hVQyroN
	 +xp/etpCUcsOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4A7480ACC;
	Tue, 25 Aug 2026 00:46:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 008DB35E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6A0380ACC
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:46:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5QalctiN1ugR for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 00:46:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Qmt1Aajm
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1AFF980AC8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:46:02 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb61bbeb25so5138202a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787618761; x=1788223561;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TqgFpm87jAIRmts7OVHmLJKoMeTfkCHMidfMVVbgH5Q=;
 b=Qmt1AajmP9ljoNPdZmCXOqYObFLIH9jy87ZsP10WnEOqS8k4DKxCnjX6712RJsWU4E
 Khqq9jjBvL9zd7E9KM1uskLSHs5pp1/Iy/aktnJpcp0kvX9D4LjRSMJJf67JLy9LVmjr
 IFwXQ7fr+qzV0wAtb8Cr+c+dHwhzeE9pPE3dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787618761; x=1788223561;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TqgFpm87jAIRmts7OVHmLJKoMeTfkCHMidfMVVbgH5Q=;
 b=tCxb3cuOKyKaMwInWIOy+qJPNeY1rFw1Pp38zTmLSyo68VJdvFhzxYnjipkjSvX6kQ
 YUaYHpB8N3YBHYZUExqiLOkSf/SR6rAxYkynM6kNtOW/EWGE8jvfYSsi+ppvuMW0EUuF
 3s+MDK6/DyCfnFykZvVULNc9KcbWTOlUYTPgQbP6s4jOjo3xVaCjK7W1mcI7INfo7RvD
 ypPoUNAAKykDoZjhzVCVPmhoLd0xK7kPPDebkm8nJzCcU503v0MctAVxop2ft8WlSFcn
 g3+JlM7/F36wCqojvKZ0lkeImyjxbpY5F5r8NOU6dg7Be1lPaxRYyaMG4AK9vyOhcm+c
 Obnw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoI9G91lCXEnuwMv5WuIhZA+4XcSwqISQrIwSOtnHMYFpDmp9MRrx8JxBs0cQ0DalrZLtYQlcA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kpVgAzE0HpQNdzizfnHITftmZ9GbBVRTmpbMMsQpK/U7U3wAaf
 xbPElIyhKCBgBwKSyyfiP7+dUzzn0nkKjg4xClYOfn3yEOpImDgNqLxVKKqDIQpIXhE=
X-Gm-Gg: AR+sD11CINYu12KERLoloWm8Uq7gLleHj0h27xEf6ohIHCeAPxiE+TVskfcIAEgGgZC
 +pbHwGKddOeL9lpggodIilru7dsBBeyWLCvEKS7oIaUBRbtkFlh2svrjaXmPLPl//9IlL5WrEsp
 pIeNJ4wYME9ilyO2JCs3BPsDpgAoW7OCBfbppGVkv0Dqz5awKkrCFQpM4hwjWjX/u+wxVNuYkyZ
 2CdYCrJaMXQNZphLR4dw38Rha08m3DIUzbPLILC4XoMs52NRg71NKyeBfQbFbb8iNgKgsqH7Icm
 /4ZBu59ZPgtTft3AotCkpd2T2r+bZduGOFhtMWs9x3kEyqdfVk8hnhSFFEqg9HcXyphCzxbeneY
 zRW5Eh9kiKxpf1DTIcfhw1Vy3tkXZTLANOCiRud3Qsfb3Ry+f6M2hMy39zHZMyUfrXUZPIlIZUB
 f6/uOqeqL3M/DIwIXHvCfCKuEQgz3CIw7Qg2zUcv3XWWxglIjL5p6zlU3NwA22pPogcl6mlwzXa
 xUFm9oHoYWL0V7MvZW3NEvtqoMDwHNuq1cmLH6Rh1bfQmTBSA2IyPqN7z5NXU9fOQOfiYLDTVTa
 Mygu/M7b
X-Received: by 2002:a05:6820:810:b0:6b1:4fa4:76c5 with SMTP id
 006d021491bc7-6b19033d71bmr2267250eaf.4.1787618761624; 
 Mon, 24 Aug 2026 17:46:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463831af959sm6502486fac.5.2026.08.24.17.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:46:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>, Kyungmin Park <kmpark@infradead.org>, 
 Daniel Golle <daniel@makrotopia.org>
Cc: Alexey Romanov <avromanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <aoCA_QD7x5-Z7Tpt@makrotopia.org>
References: <aoCA_QD7x5-Z7Tpt@makrotopia.org>
Subject: Re: [PATCH] disk: ubi: use a format string when copying the volume
 name
Message-Id: <178761876023.724197.14977620653929389664.b4-ty@konsulko.com>
Date: Mon, 24 Aug 2026 18:46:00 -0600
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

On Sat, 15 Aug 2026 16:08:45 +0100, Daniel Golle wrote:

> part_get_info_ubi() passes the UBI volume name straight to snprintf() as
> its format argument:
> 
> 	snprintf(info->name, PART_NAME_LEN, vol->name);
> 
> A volume name that contains a '%' is then interpreted as a printf
> conversion specifier, yielding a wrong partition name or reading
> unintended variadic arguments; a '%n' would be undefined behaviour.
> Volume names are user-defined and boot methods select images by volume
> name, so copy the name through a "%s" format instead.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] disk: ubi: use a format string when copying the volume name
      commit: fb79a4fcb09b49c6d6ef0a9a030e1abef32358e9
-- 
Tom


