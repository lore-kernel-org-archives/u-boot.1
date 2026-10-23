Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E7606A31E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XDYyzGdn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcZ2bbOj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E04D811DC;
	Fri, 23 Oct 2026 10:43:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9GuOJUImkuB; Fri, 23 Oct 2026 10:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 209A5811C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792752185;
	b=RPL+YNqCQJMoFKIQGEpO3sDBmIEtmpuy+YTrh9zJgLXeRIEVbJrEAYIjU99WhD21enIV
	 /BldvNCpThc3S3PJaM/bKa8Slv+9JULbE5euod11KGMW2aCAH2spTqbUJy+tXUI9JcPH9
	 zvKNt+/3OkvmothZrUH3FBL3HQDWVMCdAF6U+5WmCaiGtcY+kBWu4cw1pnAfzuJnYNZCg
	 gtOK4P0ZgTOPD0gTTBzc2YQP+uVOym/lrAhdjRbUQs/BEJwbhWaPZN28sbJTTl04yXdD8
	 U/CQp90DmjmKYjg4KBLrsK5//LqnIV3OotDjboyYCBUn04LKuWzQxpdXnTWmZPnMkJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792752185;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Y4x/NxS52IEFOMjgC229x2rBTXkFaCxktiIFv47gEWw=;
	b=ZI7fw0u4cPVxyVUAykKa1g9pQX8Q7iFMOPAnntdhM8QHKgtGIH4p8ajkIdeyxgQ5E+Bh
	 7nEndW8Fc9SguTx+7igz+wM3uk+5cnnjrEAYN/bgiCFStOQW1CjxkShVl8pXluqJv9y1F
	 Bremx/xA/OQLrmrLd8akFCr1V0HSLkMuAGEXu1df0cUhVLcZDE09dqNJ6s0oOnvoeGKtd
	 gOsC6uW3TaQOZGXKuGQsB/+Lu7jqmPoF53f7+UC1R0gEcLW6CdKaiqPqI1utOlmS6Ypq7
	 r5507wwzIw/Stu8ZuuTjHnb0aXHXJoZHqv6NRSXq75F4/MdUIzZTcpMVKRy7j2EFmsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RcZ2bbOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792752185;
	bh=Y4x/NxS52IEFOMjgC229x2rBTXkFaCxktiIFv47gEWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XDYyzGdnLvaRG6wkN0RGTmfSWe56+4mX8TVWiG/4ATGir2fhjrU2eto7LU8u4Lt3A
	 TExbQbzk82M+O2Ba62Tn8bRx5R2jxtQHjUCFXX8kCv433RXCMLLq297LnpHGUcoQHF
	 VkisBDapsJt3PkNRbFScGM+P8r3GMFaJiRIS5V39ofgyKj/VUqp2LabAkjaTZyFZGN
	 +SKOr23ELmB2uXSwAqokcnsdwpUV+oflR0HpoUQkcmtmWjK8NeKWwxhHpGM+cmCZEA
	 bEi0bZYoVoNZIpIlvFQ5gn09kvg+w9RVmnsqThHA2FdccQIiH/znpJkI2ZIKngMlRI
	 hv8ZpXu+EFaZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 209A5811C0;
	Fri, 23 Oct 2026 10:43:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 027EC235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC607811C0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:43:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3PgRQwTfPt2t for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:43:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F16DE81176
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792752183;
 b=g9f2Co6YAAvBdB7bksUSw5K/wCAbD54mvZXt29gXswnW7RCyPgbrfiJWvsLPNQBmQkZr
 LHXEyrEDpxebWqc/JCpFT/mQAT8FRCaKf3ZI6jNE00I+LVSE4vTNPhh5KctbLmjn/vE3k
 o5j35GAHhjYdxcWMIupnWHQmFgYAkWM122bRd7QHm2LQbUs9hbtREbXpqZnd4flRItsuB
 kni348DGCGes0EZKzWGU9KxEupCGDaUXE21J/l7bN+rpfY1cG6Ldma1Y4vFUckM7PflvE
 V7TZY0yhyjW1CamhCZ/p7TfjIOkiFLe0CJNLFzplUa6+4BHfLg5UispYZX2eTGNov7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792752183;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=Y4x/NxS52IEFOMjgC229x2rBTXkFaCxktiIFv47gEWw=;
 b=aE+QE1xCuILcod5H4mseJQ3n8Zh8FD1wVMgKm/1ycbj2hrv7H0MLtzg7pv6A/5EXZTHP
 FAM0F3H0PXtP/V8JyeGASjNo8T2IYj57OyvrW4zjde9kFdqbwJF4X+vXFAqwPPzCz3ovm
 ijFUWObECtbaS5FGSBgfAHpnhNa7WA5egbCq+S3a30iH7kdNpvbMHcJxgB0L+5zHH8YVx
 Rcp/W9tLUx6nl1RaP7XjrcOCqhqmrkx3BPCWzHw3hm7DdAoEdavC8TMe/hRD5gwtFxujD
 KTuysEOsOY5a4bJpv3ty1bIf438BxpiJrvYWZB4qyRPnVkPXmeENyuqTUwYDeJDwsAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RcZ2bbOj; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RcZ2bbOj
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F16DE81176
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:43:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 384C46022A;
 Fri, 23 Oct 2026 10:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961341F01825;
 Fri, 23 Oct 2026 10:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792752180;
 bh=Y4x/NxS52IEFOMjgC229x2rBTXkFaCxktiIFv47gEWw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=RcZ2bbOjQFD0Zxd5SZKyxO+hxIilOX2ASoCdgKAtY9ex7FTWgBePnTZ+eJEvXR8Sf
 kM5vQuZNpoIwFmHFYk49wZ82E693W91NJV3to8nAy/R1Fc7M6GKlc2pzJr2iES2uKV
 Q15qIKIV/3/9RcTkiE7xLk7Fcfzas23dL3YaMUE1aKOEAoWjrGMrqDz4NUbsp0AF1T
 zWPfsstNCLuaeoJjnxFS4GWjRP4NQAMvL94XD6graw1oNIt5HN63ZOgvgDzJmugQRF
 nj6ExvaVL/qXbh2TRgv6bbi0n6EIpwN8jfgFXozHN55bnzfEnyyKge//dLH/qltn0U
 xfpXkAWAjLHNQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/5] avb: device lock state, root key provisioning
 and in-place verification
Message-Id: <179275217876.886736.6937155990522210284.b4-ty@b4>
Date: Fri, 23 Oct 2026 12:42:58 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, 22 Oct 2026 21:04:41 +0200, Igor Opaniuk wrote:
> This series completes the device state handling of the AVB 2.0
> implementation when the state is kept by the OP-TEE AVB TA, and fixes
> the way the Android bootmeth hands the boot images to libavb.
> 
> Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
> "avb write_pvalue_hex" provision binary persistent values such as the
> SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
> consumes, and "avb lock"/"avb unlock" set the lock state through a new
> avb_write_lock_state() helper. Until now U-Boot could only read the
> lock state, so a device backed by the TA could never leave the unlocked
> (orange) state.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/ae7f94107cf9a1a83799034b1e4165fe49e6d8a7
[2/5] cmd: avb: add lock/unlock commands
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/08d45d705a740c63791441f4b8e0a612dddf15cd
[3/5] avb: verify the boot images in the buffers they are booted from
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/5f6530505fdc0fc01f2df1363febc338fdfbf709
[4/5] fastboot: add flashing lock/unlock/get_unlock_ability
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/c69982f9c9ec2b3f2d91dc9c49e9971f9fe3664a
[5/5] doc: android/avb2: document the root key provisioning and lock state
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/2d105e34525ff9b0c3ee8c434781e5c9ff807b4d

--
Mattijs
