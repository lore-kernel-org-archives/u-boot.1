Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F8606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Csv7ai+t;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzRKPNfD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41A806089A;
	Fri,  6 Nov 2026 13:16:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFUWgmWUbvH2; Fri,  6 Nov 2026 13:16:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01D23607CD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793971014;
	b=rD8BdeFQFdLjoJ/eJecQzaGbJmU6pn7v/HY5iSMR/vza3jKbLHnjQCbDR4rYCt0GTEFb
	 /NZuik46luFxnnjdPJbyvEGaAT262L0kls/Vhk5iVrQbiWgb7mSW1/yFSn2IVXx2omR6t
	 ZSjvWl/UO5+dSgeXldLJ2hLanbOnaV31aCyK4ifWTcUR51TmPtNYDbwuXXSkoecbNpKWj
	 u/M7FVixMvHQvGZ+bqBoEtCXSh4kpwGOm2o2/MehZeQYMH9lZqrxSQhZBqz9EKBZYcQdz
	 ZzctHskTkOhe06zT4RpRaURm8WuypInhO2DM6biSG+zyEvtd71lxLUyWoK5l8RB9W8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793971014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hSZA4gvtd1rV1rAz803fM1zF8KnPiuII5myvJb+A2Vs=;
	b=K5wN3AdxKlMYNSARU04zZTy5p02guXwCKeQg2erm+ESuV3LfoPqq+QRrD9vqP63Ed2JV
	 lvdkBsYvzEE3wn9+fy7fShE8TNaCAuuFg2igiVHx00rYbMAhUUK/mgjuhj7wwYUgKIQ3R
	 TzqQCZMxT1vA6ZrYs2BLequPggu2LtA2j2FaISbHbiaCyYl1/coDkeRtet4/D72WNHYlN
	 iyPP7RdKIJ5PyzNZRdvSlqJYiSl5HJ2MsPEdFJnc+PrwXgg+A1vo6WTMtJWqkxTXfA2H6
	 k6M6bMPj2qXSr26HB3/TimCojmQK9W1jHQ3R/2t0FWDcRzFOmWnwAusejKqjcCFhbZA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793971014;
	bh=hSZA4gvtd1rV1rAz803fM1zF8KnPiuII5myvJb+A2Vs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Csv7ai+t/c4Kpv53zRvccP8OHyDCW9vsWoXjzKZvetdyFg5WTqHAeuaT4HoGXVSSD
	 GZFonKWjSPQA36XksTpLGOhoWv+rIWOVTW4ntiThpYrrvyZhmoQAZ9pBwF67JDwviy
	 udDx2BwKAVD2btcUSpZjr0eHP9DwWra+mSAdWMoOcLPJOPAxTOl2QhTOo8AFsn1tfm
	 gLSN5nEylIUEnBiUurKdiKdhSofzS2Xc20RF3KMefeGDmVQTjUPqLmM4tFCArQ1PZY
	 jzgkOWG9BuWhBhdjMGMu2hBk9015l76W+ReJA8hDYI5z2sDk8lcduiM37065c9wWXl
	 JgU6PiQrmnhog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01D23607CD;
	Fri,  6 Nov 2026 13:16:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ACA832A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50C0680F30
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMIfhjF0m1Rf for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 13:16:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 816A280F3E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UzRKPNfD
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 816A280F3E
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 13:16:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E1BA435E7;
 Fri,  6 Nov 2026 13:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF4F1F0089F;
 Fri,  6 Nov 2026 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971010;
 bh=hSZA4gvtd1rV1rAz803fM1zF8KnPiuII5myvJb+A2Vs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=UzRKPNfDBMM7XVsxZEjHWA5jJXJfSA0V/CwzMySJEdgRryzVRlAdLjHBl+RH1P3gc
 d54Uplga7bDKDbiyA0u411itzflRK+vouYf1piYg6pYGtqwoLbNPudl1QyHlbE1h23
 G37wOm8LJh2OpLXKTY4PepNjsCJ9R7Ay853XZS8B2J2gYW9g5h8G7wc0wzYRS054//
 NVpyHanhDXkMALEiI+I+22+Rw602a7ttzfZMX56C8MNoODuGC+SdBHaC+81ZzLy31n
 lb1IGjSZUwnN/PlNDW9eOhX477by01LBKjaIMAWOwcICK9uiKUwOpWJiGzag9FZbuf
 2ejSX4RBDPoog==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+usb@mailbox.org>, 
 u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
In-Reply-To: <20261102-dwc3-depcfg-macros-v1-1-0def219ced9c@oss.qualcomm.com>
References: <20261102-dwc3-depcfg-macros-v1-1-0def219ced9c@oss.qualcomm.com>
Subject: Re: [PATCH] usb: dwc3: gadget: make Set Endpoint Configuration
 macros safe
Message-Id: <179397097860.1025206.16203385660982410597.b4-ty@b4>
Date: Fri, 06 Nov 2026 14:16:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=429;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=DqjRQalRvmflKDrhR0IjnrG8P2XZ0VqRdm1b1XppRpk=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7dM/+EmOX3WaHybjX7RLw+fvs3pIkyYtN9Ovk
 pCpfQhAt06JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3TPwAKCRAZDR20Zk4Z
 NU5QB/0cqsOcHmme8l3Ho8ApqmTKezR/8VaeUeLAERL7XdwLVYqPNR11eP8ul2o/cRRx2QbsNWd
 jyALB+KLsyiNflGu5qooMEmOwilM6iMiezMaZVWSAAiwdwn7I4UzyvMdSvpATxt5eLa9HmvE1q7
 POxRV3j9tBJKBzhnDBbXQHFhIimNmvLqwjXXKmc843hdvLQpEDc3qwpA7C42X+s1yUZ2CKD0mBh
 Th9wI2MG51SuwhDxJdoRPw3u3wTjnPxvBuyTcieF5vOBTnNIHWQcj9M8vyTXLnQGtSmHJM9nhTS
 Xz5f/YOjw/QKzFMeffINUly3P4l9/MlYp5/Q+Ie9aZUp+6zW
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, 02 Nov 2026 10:11:47 +0100, Igor Opaniuk wrote:
> usb: dwc3: gadget: make Set Endpoint Configuration macros safe

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: dwc3: gadget: make Set Endpoint Configuration macros safe
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/58ac309aa8c68e4b76d22e177b9eb93ba90b7b0c

--
Mattijs
