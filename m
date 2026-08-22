Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFC5C5B572
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 15:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35A4380F77;
	Sat, 22 Aug 2026 15:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwqYyTJ_pgOw; Sat, 22 Aug 2026 15:21:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787412111;
	bh=w9z8Ei21uRBTwgv5j2MeG/xbrq0Vk8HQZSY/nVP7i+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xr99J0pgt8V7lbDCXzpgJ7jm6Fj9YyTOzlc0T0MsT1I6o48olzOquNFclIKiZp+M9
	 IWeGwyj/KbDPamTpv8Jg+qwGVvIcLG9i9/8KvVhd5UYTrgp0yHmQIfnWZker9sJMoS
	 MBVi4ALK2q5suN2VopA+MenvORI/HmihPcHmxRsH81Vuug2zAPnoTK1iy5nKzdqED9
	 T6Au23LCNgPXUrNXwrJBE8s569SzNv7d3dYEHYG48tMfFE/eb6CqgiCi0EYdX8NonY
	 7Kq08uG2wHTs+wzuCroog9dn5Ky/EoKVIgl4cLh0MrclN3/H4W0krshofJ/iIFVvP1
	 RU33jFjEqbYmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56ED980F80;
	Sat, 22 Aug 2026 15:21:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 64D22EA3
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56CF16061E
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1x3y5nd1wWqo for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 15:21:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N8GO4RUl
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1515960666
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:46 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4ab8cb2a6e4so1802714b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 08:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787412105; x=1788016905;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w9z8Ei21uRBTwgv5j2MeG/xbrq0Vk8HQZSY/nVP7i+8=;
 b=N8GO4RUlaVTPQfnsJG2COn9DeXA1BnkBiWuq2N1WhMIj4xmn5gsVkZprvlDnT2d97E
 d9uz8nYG2Sq8QIX7lvb6xf68Qk1kfquHu4iDryyiJwpfUQJlsvrIqGq5R9x6dS2np0DY
 I7jkPJ0SY+VP/0KzCeW5gHAR3knIL99lQAYy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787412105; x=1788016905;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w9z8Ei21uRBTwgv5j2MeG/xbrq0Vk8HQZSY/nVP7i+8=;
 b=XHFgdK185QmZFgpbrFPmg38fTVketN+SGeXdkYrgUGciTKOFtMGSuxlcOoHd+lKwa3
 BdzlpW9mWQNwqMRDH5QdQBW9e0urbhL0701yatVx0E042zWg8sAnMPaNk40CnHZNBNs+
 MrlQgLOwZ6twnmaizVvu6w9GqqT117PZMbbMAtUQPA7Fc8RFg0dMdylD6JoH8a5Ko4Nq
 jqATQdJbxocUocZqSX0jSgG6Ir1aMpwEMTalbZlGwjwdsDhJdUoj9LfP9XCkz1bsh1Ve
 GdgCtsli39dqLIk8N1nNMdV0pzGziq/G+urO7P18vttsJLk/k8nwRxTi/CwH5oE1JSX2
 QXyQ==
X-Gm-Message-State: AFuF++nE9o25ngSIW0owVPNQrV2szEd4NcwfierD1IipT84HFdv0zHIe
 G14BzQLa7Twi6FViLisRo1fEnvyT17Q/cXrjAGVtpDqLhHF1hzZUR/8WgUmCy6uWvRg=
X-Gm-Gg: AR+sD12EEktu9l0Tk7BeTVMPAhZGeyhWenmbjaayec4d36oa7ZVJZ0u/9szu0+6Tgzp
 i5Jihuxcv7S5UhoBzLGVMSbzj0x3HCW1UyycUxCQhRUYxeKOJE9zE6TLbgKK6Yjq78iIGhc4abL
 /BgLB3fztlWZrEy9Ws0zarq7fX2y8MIt1hIISYRorR8Xo6aJhXI/HxEdRpaNyPCohwbLq9YeIpJ
 FRwikIJJ5Jhl50WEAQAooBR7zTNLhqanHYt4h0OXHjJemAclbGEsrONK1LmEZPzkYwXpbbS2IYF
 EiOIodzAxlqBzGohMxUOekvgDIk2GaElWLnmqYdMqYWtk5pk7kCzZKFEwTkoSpQsSX3kwgjAJlo
 mrpp6E7JmdDEW/f3toUoE3dmeDcX9Crzwuxco0gz4RZMwSjRI4TO/RtK1EEzgi85mTC7B1bR/AD
 LleZUHjAK0rEX8adIl/AQmyqux3Wp1CdKIrZL+dZ9vTZ1T8/sBs6dtW0rOaw5ErN/1s3Y9OosPT
 I8X+1lFdSX48kFLuLahqhf+rcViqcpQEKgGP5l4yl7qMzyvgMeQmQvqrpHSyq4zot4EVr/nfQEb
 6obT7Fa2
X-Received: by 2002:a05:6808:2e4a:b0:4b1:b9f1:e893 with SMTP id
 5614622812f47-4b2ef1bda52mr15766977b6e.3.1787412105373; 
 Sat, 22 Aug 2026 08:21:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d6cdd6cbsm7345983b6e.10.2026.08.22.08.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:21:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, 
 Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cover.1786605072.git.michal.simek@amd.com>
References: <cover.1786605072.git.michal.simek@amd.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Cleanup non existing files
Message-Id: <178741210412.4158046.11294904588036854394.b4-ty@konsulko.com>
Date: Sat, 22 Aug 2026 09:21:44 -0600
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

On Thu, 13 Aug 2026 09:11:15 +0200, Michal Simek wrote:

> I found in my Microblaze fragment that cmd_mfsl.c doesn't exist but still
> it is recorded. That's why I wanted to check all entries and found that
> there are also other files which doesn't exist.
> 
> Tom: maybe good to run it in a CI to make sure that we don't get out of
> sync.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] scripts: Add MAINTAINERS F: file existence checker
      commit: ec5843cd784630496864d684965ff17c1edefd36
[2/2] MAINTAINERS: Remove references to not existing files
      commit: 35d27192f8725a294dae5af568e8ae1d2860701c
-- 
Tom


