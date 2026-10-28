Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA5606A321
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VsjiJDAu;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lS7kkJ1x
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18E7B8113B;
	Wed, 28 Oct 2026 16:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dlkg8rbaAjz7; Wed, 28 Oct 2026 16:01:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A75381110
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203307;
	b=KZck9gPry8riAyj7wc9hCX5YYEb6fS+i5qPhpmcBWllQKj1bTDilplcbzVXpJKDNVmys
	 0kxedbVvy+Dq75yVaoKDPXGXOxPISBvU5yhF+12esC86kUURN5sRqi6Qok2g5FwTTP2Yz
	 nx9tWDH+BF/GpO4H99sdNdKVn+Y5jjshWx0YaT7cB26waiUo5sark8xl4wmxyxw+2pA6D
	 x4qFCyoQsRdPf3zv1M8K26dKm2WibSq1WOKy1QYF1KQ8MbNp8iIhUPVlNoKv9Dn1IpHdx
	 n66HAUbLo4EGRov5mnQ3Qx0+EbaYryv33RWUnNNNTTsWsg96VczrW0mAhMePmZ+M9Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203307;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZtWfr++El2/1z7QCybt6en25r7UpTE1S9vJa8B6XFzM=;
	b=bpRx8aCP+cLBGdR0VdIIz4zfnDcHIv7zK8PmmNEGysP4cS0UDSwF9kx8ysPwEdLoL78Y
	 baTjsjqChpSlGPTy/VJ616F2x70uI1aPO92E49Fo957Gf7AOnFcd8z1m9ndbXEjMbT6Pq
	 mA+B0ghSQ5ClDwCGb0N2k/LIE5rULCrXXvrB3i5EysEs8l0ZOnKj1SKZmo79xKsybX/wf
	 FbMkxs4cApCigEXjgZl6Coc52PO5nsr9U2Ae4ZyPueP5D5jT3l9Xzvrpr4hY2dZp/CB2Y
	 Mq5AmRl/sE0gPgWFISjy6Wa0GQDAvCBh5S+96aBZTorCIL6KS3ub5lOk2qlMY/1T9vg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lS7kkJ1x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203307;
	bh=ZtWfr++El2/1z7QCybt6en25r7UpTE1S9vJa8B6XFzM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VsjiJDAuOlkhaqOM3uVmpPQbLIAaMz2Ym8k95Uwjc37pYtzrZZiJQHgqJFizp8CA6
	 0HBGzCq8By4Deg9yYkeNiCBJTRFA8Wi/qVBwZ3422XC0xqJNXRSED9ddUsKjp5BtJX
	 MObVqkx/HeINBc5og0bMlB+U3atR05ngbL6+MqIV114fSLCiKRkWNbkjsd2BPFuEHz
	 wQUCrQYG9lg+18c4/pTLsRXBs3f1SJD/cdaYf0wF9uEELK4jIT65CxHpRVY99lLeeE
	 XlA7CcZF88xuU764l9rk690n5HFBwzBqmwsKorHfWL7x7G36pfiwxL2DBp8QqY88yS
	 FVSlj3DoMxk1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A75381110;
	Wed, 28 Oct 2026 16:01:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0458A380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E378281110
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Io_7qX8V8z70 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9872E81107
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203303;
 b=ZyuB6Xq3a1uHTpkExkZtkh/AQrzA302AnHE9NdqLDsSFKwEIi+gad4e+BTusBOjAZ8od
 HdrkdCOHfXu+JY5cHxwCOBtWtKxZhe4a/HZVZuH6AExtZI7YbsJAIRulIebgcx8rh6AQm
 4ONJJF+rCUT3pkzXlrmscykuOuxSiqn8aOn6m+825CXokWBD+QFL1+sMAy3eXsUDgBxUh
 Kz5+/AUQWV+Ss+ihNuol7xZi5flcdOW/8lGhQxjqZZfx8lQ/vxFBQFBgsU/niOGfPnij5
 5EDGFMxZmfvP4iXy1BWj+M8VNmCDCxN3jFytSHBL9G3ErVW6FMPzEfFF/T9dr7GfYIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203303;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=ZtWfr++El2/1z7QCybt6en25r7UpTE1S9vJa8B6XFzM=;
 b=VMr+1TcKLZw0l8FdVZ3Yjz9FgfmIISsxcuWzJHNMt7BXrtCYRijZe4g8icJoZainTyOo
 OkHIQIjV9trdDTkJzBrzDvS1fhpmpKlIeOx7NLnc8M8WJyej4cWoXeTG046l7fPcCPyNU
 n9/Vt8V/BzHMtS1Q6/cubvaznL0y1NieAs0C9i2rSghkdLvuk/Bfe4j2Et5FRJ77KV0vc
 IGDs4aBYbjQSqjfWVR6ETD3b9uJhwiVDaqtqShcITtDyBep4NNqk2Y6BRxaKrsNtVgdxS
 TVVX9FnZTCJrTNB8uR+ZU0F+PioTkuKDPD5n6Rt+/luUqZv6GGCIHTgRwETe1p/MHJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lS7kkJ1x; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lS7kkJ1x
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9872E81107
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:42 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so8669755e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203300; x=1793808100;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZtWfr++El2/1z7QCybt6en25r7UpTE1S9vJa8B6XFzM=;
 b=lS7kkJ1xVaQT2UAnlYGk9FxadSKbxqdz085twhMHF3q2X59chhJ/5341pVSW9V3bPd
 Cd6F3lkPs6felcOcyskyJY1/Vpk25L54dwPM9tgRFWtoG4HPYsU8IYXQi2DBdMqo2gyf
 hnmUf0DGMOl5aYo6LImesAmw+Suz/bhRezk2U7iED9roj8ARrTVhsfmOMoSYw9NvXcYr
 XSeEL6RyoAgrDgvS5tMylAf3XXfQYJY1d9g8jjeVVoGDPSFHb8SACDEmjr1qOWdUeeMZ
 Or45EXmFyAoNINu9y673eCFBxbo7AKUgOAGHBgVwOPos46E6Unbv8ox4denF/8rirgaP
 vw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203300; x=1793808100;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZtWfr++El2/1z7QCybt6en25r7UpTE1S9vJa8B6XFzM=;
 b=nW/snmEwCS7Gp0dDD4dmUXdLSw1+9M/LfiHXpKhzjIyfabalr2ZKtRiGVzLoPZBwub
 Iq+fUb0VCHzRmSiuQomiEhxcX51KSnHXojQqk0guKL5o0RW+D0Sa/ZLd4WnSM594PdMd
 qsD06WCPXFeB6zjAfrf82AWT3/z51AmR6NB5WLOtvaPL1QqE69nuaUuutCmbvaa8ygY5
 z0nH4dm0f46iEbcIu4I6oKIaD8YPcMa6ltsaomHxUUTL5gHfJamP8HBAK7nMM6lAWLun
 9kaPEh259D8DUKyH1O1P1rnmeCHb2DNrwQM0TcuWvsc9UraZ4A5JC2a9dqJUay0mTP8p
 8e9w==
X-Gm-Message-State: AFq9FYI/4cN4yqdxLCpR6SLx2ZqEIXOmKQ8XrdF1/biScbFrJpT16qel
 txVZPfDY67OQQ7LFW+QoIIZxMv8urckakZKc7b1dBtrKNF4vGms2EX9Fc0CCuevEM9A=
X-Gm-Gg: AYBFou2ONKvk8/tHKZ8fNxWGsSrHJqMzHyrJ+Y3/VhvXp8POz9D3VOW9Swn4SnBg2j8
 hDGsX5rD0nlKqnL1kZNcqnhichN6kQhUOJKKXf6Kp/3tQRSS8mQelirCmfBj2MKBcRBPTYrwBF7
 US6l4/yTfHerf6IW8xFs8NwYfFej8t2QYeuRtxoTafeTqhEJjS7DYWphooZlP55QXz9ClbriOwO
 CynBJAvdpir9+cBIeQ/PvNTP+cXEFDTjLQXgW6i+HICMKNBreav0UB/ZXspf/2DWw2S5QRquW2n
 Zx3hXiTJnL1cVbUZSPUsKJ/x8AWE4Ym94ASvKIa+MaFDalxQRf4bZv544sz2iA6eWGBSoT+NjNR
 z4yRdL8v/90o/7q17A3i1cH9X7A+oyYgPKkzg+qe1lDOUuaegj2rkXO+aPBGnDJg8zu+l/1zHn0
 zDbYwSk0kYR7M5dP9pO07Cfk8OGUUT5ztW4RMstH7smmUh7YvLVA1Of4uwwS/gQOuMaj2ohxhyc
 2ogQpByMBgwmupmqUCVM9Dk55fqHghTkRwsFyADh7hJGR75AxRYTIIo8mBOpj6/r6KsWe/irXET
 DGaX3uEJ8rFtpZKOmlYoHkPIEQH+4693LbszxoJ5MNFMk588aCpj5VKabUhOZMOkhSmsRdOdvnX
 kUxovvu2aKr8mzi/S
X-Received: by 2002:a05:600c:524c:b0:4a4:7a8d:c736 with SMTP id
 5b1f17b1804b1-4a9661ab662mr63856775e9.9.1793203300127; 
 Wed, 28 Oct 2026 09:01:40 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:38 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
In-Reply-To: <20260902142736.2419504-3-casey.connolly@linaro.org>
References: <20260902142736.2419504-3-casey.connolly@linaro.org>
Subject: Re: [PATCH] gpio: qcom_spmi_gpio: fix bias-pull-down
Message-Id: <179320329744.1454330.17558959746508828860.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
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


On Wed, 02 Sep 2026 16:27:00 +0200, Casey Connolly wrote:
> A small logic error resulted in bias-pull-down being interpreted as
> bias-pull-up, fix this.

Applied, thanks!

[1/1] gpio: qcom_spmi_gpio: fix bias-pull-down
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/904bb986c52e

Best regards,
-- 
// Casey (she/they)


