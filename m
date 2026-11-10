Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30D606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JSJqOZ0R;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yn6TkDbx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D78E260871;
	Tue, 10 Nov 2026 19:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DkKLNJP4N7Fx; Tue, 10 Nov 2026 19:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ECD6E60808
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794338972;
	b=YDPDKLLN1+8Lzgeljj502MDC1yKSOGogCpE6QLPYEv4hGJDZKD+D9leWiW+K0Yh0LpS0
	 br+K7ck88MPmKK6w3oMXv1Zfazd0QP+6j3mOU1rqvnNVAi3gUa2d00dkYipUciNIsMhLX
	 2l9ujn+VMiA8EgPz6D6E2to/NNGUhyWc496E/7mAdKbRmdpxHyT8jios1WOdiO9FIbbqX
	 xiRny6jEYMhftyioJqwdCKJRF3hBaXYGKfhRToz199meGAbG97C6bZx7dxu9w/m5N3oJE
	 V0yYHcH62kPaMVPM1+UGomUOLN9/0JgVQ1VTEgBz/DGNFH+o16qwIlf0X4jmMze8vjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794338972;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kcPYadBcPSVps3s+ubtV8S984NVLKPKSR2FknatuGzg=;
	b=Wd3IytwnTVaGZUpeiSBtpvn/ueG4LiBo8VB6uGfNe7Oscq7Gh3+zV51em2++OQNMXUvh
	 V3+0AnwCONBO8tnWD9KwJQDumdp78kjPFSBYsMDPmT5FBHfz1sy/8r+xCxgmmalOBvcng
	 Lq3aUdNhCe/iniaAplFrBN8R2rutGDoEU9C/8XqriX1YS2mbmxoylbhdvnVQRAxt+bjCh
	 DAC2QbtdIGxJLyyuH3NTV4bAKxvH0XvBR3czxIVR5tT1cRbZwp4k8wG4EzWzr43/sgZ27
	 dNq2wJcV7Tq0Ap1igUgkZYX+7w1kTMNmJpH3lr7JEBh7yEP0GGpUapSY/BDpNh4UAwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yn6TkDbx;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794338972;
	bh=kcPYadBcPSVps3s+ubtV8S984NVLKPKSR2FknatuGzg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JSJqOZ0R6x4p6+fBLt+T8eZcbraIA8xtpF2XHNfSTYWZTyTSBuSDonoGdkP1u3XMJ
	 37J0HQR84a0N8B7UWW5M+ew7BNLQ1wLopfs9+RjV0hsVCGOoa5FRfdf5UsitEVt06I
	 +/wFjT+k/z3j+yk5hNx81o4Xy748tkogXJXfR6B2kf/kRFsSHppN9My2VHZjjJNQ5w
	 1hXe+R3EA3hcE8aZ3wgQtoUIcRaBzDm03PufiNrOXvikfwQ0qdUiojYoJpSCW1Zogz
	 5269YKMC7tSXu47BdayWc0Jzi1v3rUSESqhxwHcKBdBJlzNV+R+NVGVlZFGeB20vEu
	 5m/mPCI6MYm3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECD6E60808;
	Tue, 10 Nov 2026 19:29:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 57A7128C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 19:29:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 48F1A60808
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 19:29:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ftlEMRcjDRpA for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 19:29:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBDA06073E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::5;
 helo=mail-wm2-x05.google.com; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yn6TkDbx
Received: from mail-wm2-x05.google.com (mail-wm2-x05.google.com
 [IPv6:2a00:1450:4864:31::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBDA06073E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 19:29:28 +0000 (UTC)
Received: by mail-wm2-x05.google.com with SMTP id
 5b1f17b1804b1-4b886ebe069so7891865e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794338966; x=1794943766;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kcPYadBcPSVps3s+ubtV8S984NVLKPKSR2FknatuGzg=;
 b=yn6TkDbxxvIE9DmTORQea67KO273yR7WLNG3CWMx9z+GK/aLhAnSnlzQ1fo7uJwCVr
 u4hMzxckX7H5/WPIS/BBSlOiUEu5rZ6vERT6knapzQjte1hAttxMwFxaPdFYz97FqfCb
 M72iE5Aq6XWfcLAUJlzM5VkMJC8f8JWOVKrNcr+siuKb1nsDSi13rXmHiSrJZ3wwwJ0J
 BYcc7SYYX0VbGVp8FZpHk59IkshNJiVyY0qhbRS+IB3MKk5WzzbCfexOJ2WdV0AKsohj
 T7KRtK1AsBcBE7BoL5KZUiLYxJYcD2u9WeOlrqdWV7UsV9VA79WDxIlxBBQt9fYo7dE+
 dniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794338966; x=1794943766;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kcPYadBcPSVps3s+ubtV8S984NVLKPKSR2FknatuGzg=;
 b=h87kr5zvxubdc/hljXHrHdd+htTGMIhBDqC7QxX74wQS0AeLq8nFdLocB180scV7Pf
 XlXfR+T+RXwMqq6l5/Ls9PKLgXTBIC6fPjJaNKEx40Y1/fz4rsF9SEAN6wf4kaH7WghW
 n+vNHGcb3NYFHz6b/hlhE/mCk5S067bntM1+FYTDVNbzxXNGPVHoXqz11USOjRNgRyMB
 yYbEUrKee+OYIwiiKhmjFIMUR3WG7f4xLVEd1WkaqoQ/YccRi9V0S93BuBhjyfAct1dR
 DS25X4Is86sR91NWN5WlfJu/sylLbg/DorpzlqV7AWZcpBgpLyQzTiAyGbzRYDREna8U
 sGlw==
X-Forwarded-Encrypted: i=1;
 AL+hErFpMQxp+NTVmeoXBrBjbWXwJoldBs44fCC9qK4x5UWKnzreyu2N6F4ORBooLGbqGAPZ8NzprdI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+5rUJ3fIFwZL73H35mtCukRinUYkrZeFpzOalthLGEOPyFd682
 BWvCuQMbVj6gA5Vms1Lgb4bqidPz1G+cCWRHc0zGQyfJoZSPE7JSt/+cZVWuB+rKrj8=
X-Gm-Gg: AYBFou0N9I/GhKkD4Ni12Bd6LN3B9O3qY2daynyXkMptTxx3exxlsMbp7PR4PBOAg1q
 sILoj6ma7R/psUCSqTink65L+HYb8NWIeAjve8IjlvIvg9GR9whc5nN9cPav8f2Wsae/JWfKt6L
 MX8r3NLRoXdFEVFuHGoo6jQHJeIPoI/tpa88I3vsnehngOBKzYcWO9rJOQViYGrTnw+cdbcqVf1
 OfXbAHkF4qeDCVsoN7FPUQVtLTXUxEbIG32a23akrZxohqR0bak/xLTva49PXqAHp4eLiEKeJRB
 E3m/DCLMJOpEBQRdW5N1tAiXNc8TfjyIOdNsaxiypv2oO4PnR84gEEnyJvl/OfDSZMRb0mZKObA
 cjpPWtWyuyhbx3e6L5+Dti0nZlNN6E/FOrztKF00VisAngrFAPmu1v5PHUPtG8nJtIrh/fJmW9l
 jZG0go3BtYL8X6XQ0tfG0Yd3FvSDjSd7xaWSGvD6vVOgor3XLGyfF99CocZOwyHBQJwCMr4/cXT
 FkFWGA+VAg8/ueYcNLRxIes/UOFAnzZRfl8BkJbnE4w9dM74owcVyPqOhtY3gvJOtV27IhUXxko
 OsTTZA0Ksq1C7UcXi6SbWGxvpju+9zMr5z7WYGDe+zZzl42mwponQpPj2V3M
X-Received: by 2002:a05:600c:190a:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4ba0931da12mr2481315e9.4.1794338966248; 
 Tue, 10 Nov 2026 11:29:26 -0800 (PST)
Received: from cheetah (p549d4ba8.dip0.t-ipconnect.de. [84.157.75.168])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fdac9csm123971385e9.0.2026.11.10.11.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 11:29:25 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org, Aswin
 Murugan <aswin.murugan@oss.qualcomm.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Petr Hodina
 <petr.hodina@protonmail.com>, Petr Vorel <petr.vorel@gmail.com>
Subject: [PULL] Please pull qcom-main
Date: Tue, 10 Nov 2026 19:28:42 +0000
Message-ID: <20261110192842.869a758d460c83ea@pwishid>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

A few fixes for 2027.01

* spmi: msm: Fix V5 ownership table offset
* mach-snapdragon: skip serial# env set if already present
* mach-snapdragon: fix the serial number taken from the command line
* doc: board/qualcomm: Fix kconfig formatting

The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba243:

  Merge tag 'u-boot-imx-main-20261107' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx (2026-11-07 12:04:01 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to cfadd2b4848086701a456b4cf74bed70e9f485b8:

  doc: board/qualcomm: Fix kconfig formatting (2026-11-09 01:15:28 +0100)

----------------------------------------------------------------
Aswin Murugan (1):
      spmi: msm: Fix V5 ownership table offset

Balaji Selvanathan (1):
      mach-snapdragon: skip serial# env set if already present

Petr Hodina (1):
      mach-snapdragon: fix the serial number taken from the command line

Petr Vorel (1):
      doc: board/qualcomm: Fix kconfig formatting

 arch/arm/mach-snapdragon/board.c | 19 +++++++++++--------
 doc/board/qualcomm/debugging.rst |  5 ++++-
 drivers/spmi/spmi-msm.c          | 20 +++++++++++++++-----
 3 files changed, 30 insertions(+), 14 deletions(-)
