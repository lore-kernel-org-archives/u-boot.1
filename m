Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FE606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uWd7RlII;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=lAVO+cIW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87D4281423;
	Thu, 22 Oct 2026 23:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oit6Z0dLbiop; Thu, 22 Oct 2026 23:16:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3E0C8144C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792710979;
	b=Vf93f+vfIcMHhWtAV4RKd7PC7v6LA+hIrxzwLw/Op+/I20E8KxvEZyttK99XkCRqC1B/
	 UbjxwV9qIrfI18lrZRRDfBOQSlIdtLJgEXbUEzlXdULKiadZP1tTHnSopMmUan3G5FrIc
	 gu45zBxxQYAgJvMDjnEhrDn+fpGUXMZHLHykBiVwjxedC2azZFW+rgUdWiaE5k3wUw53w
	 CRh2yUNiYtu4kx/3chvstK23KwD2OOyRvsNkmng735LAnlaq1EATA2ilPF70jYIHGp3ND
	 4nVwAaSGOIduEgl/xd/U51iiJslnwqXZinWOp96rvn7PFp/E2Sn6qWKl9wkvk7LfyVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792710979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Y80BSuK0WK5rSe4mXY3xlDA1h2OBu4s461gsGMfhCHY=;
	b=IDf25gmrNhAI8wOcSc+/wA21CpNkpg16lDHOsBqJ9PeJ+hbfwyTlmDOgvAuWyj3AqAcl
	 xtpL0kH+1hI6eOjpYvtD/vBe4EnjkUYp9Vv3TmSA+isdCJ1sPAmnNk0p254CcxoiJNcZg
	 RWck42cZ4lFvt7Ohc8yJnehpM4NHDaRihT2r0VyChAaNVlF4bSCqTjAM6fkLIb7ebj3Ys
	 fMSsfHBQzEMYD7lCINj32BfIUyabIxIB87DeDoTEwf5dkZiFtHW34QF89rOOA364P9u/H
	 WEw5S02I+cWNyCzbf/NeStPHwEqAcQ9xnVnK0gbZtbE45X+wm5881ch0jVwwstNFh2w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792710979;
	bh=Y80BSuK0WK5rSe4mXY3xlDA1h2OBu4s461gsGMfhCHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uWd7RlII6L7jqO1ze7KpzV+/aMrhanLQV8J0Rsj2aPXzet2h5KDVe6/tj5a9GV+2L
	 t5yeA+ubvHTaOrARGxqK07CvLPnYByXqDpcM87jvxs0gjSwOSERXSHgSEzVOVgDQsI
	 shIldaZZxXq4GsOMDUhN8h7I97dhHbfWzNlv5lv2ha9ICux97MFj9AJPuQVrPyzYP0
	 g+sc5m/Sl+MmZalFvfYsL7FWhfOhP8sljMTooYaWAhb6I/uoukzNV+r5f/UvuT7ppV
	 e+WzIB3Q1GY77WHN8HLmKFyWDZ0EbD9QMF7f9jGkKiXNbF7jmCvRmER+21U6eeumv8
	 Szhf4UFa5rVEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3E0C8144C;
	Thu, 22 Oct 2026 23:16:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83724499
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 749D8608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:16:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WrFFKB7daoBP for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:16:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 74EAC60883
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792710977;
 b=Bk47x5nLolxTa542JRVwiO8mMvRBYbdZ5AQi+eEDSoxIOXJa+IM/S5Iov9lgu+zvUx/Q
 uJdo736mtl37ZTlQiIR2SmLUxIPFo0OdCGPeoezBvaHZEPdjRtUtSb6t0w5Ng0zKhmbSD
 +5jh0RVuf6a9dneqPpdcfU17Bm204dfyAp/1KGCu7YLSEvT3X4RBGKOOn21cmCDTcOihN
 f14BK+q+Cqbx6LjnxZkc8b1AC3SHL0rmBb3ibz3AiyHSwXzg690P58AEZJ0tqjgc86Q3Q
 2XRKCQYU/ioCEbaKriFnXqfE8szV1crVG9UshqtPWM+DPC5tDqaEIpvNjjdXctTLCIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792710977;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Y80BSuK0WK5rSe4mXY3xlDA1h2OBu4s461gsGMfhCHY=;
 b=GPadow0GOw3xceFQDqpQSBqUaiok+7IyHK/5EFU/EWIJh6HQh5odXRXT05vsB3wtXnSq
 Y8QsZnV5U/+bfPsoq8lKsDtuzGCOOihW5iwZjM3AMkUGdWav3nMIXfLYKP+7Ix1EY1mLh
 j+4OQT9Fd1KzDkJI/1njCLTDVycSBdxqCOM9cGP/M7Bjl2I1eO6Tqa2H8XGOCw3/D4c67
 aMyzWO++lkunTJ64afKPmwP1Bts/XcQwaLqX7zpyIrqtcL8voApl6rXSchoEORa2Rw4yT
 +YzUeZVVT/NCEv7UJEauScd8KfH7QLTs0jkOBZW0/+VzLA2B0ClQVKqIoDzLw1UtAJQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=lAVO+cIW; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22e; helo=mail-oi1-x22e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=lAVO+cIW
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74EAC60883
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:16:16 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-54cd7de2d42so234675b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792710976; x=1793315776;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y80BSuK0WK5rSe4mXY3xlDA1h2OBu4s461gsGMfhCHY=;
 b=lAVO+cIWVy0REa7gTtmqT+WeckMp4F6zD/GrrF5oTHFJ6VM60SCbBfg7REy5Izs9S3
 mc+19wWrLOSRwcR7b9MtzuSCjDoIsddZQ6tg+li3UgBuKEqJlfgat8yLWCbWPmH8iJmE
 VESYUZ7MHdLjFUvYjfoz1iTtYE0rVnRWunF6DraEBJ9He4zUMlGvzQxDixUuGGKROJBA
 RFFZO3kdQ7xErDg92eYsZr7lIgqhFTz7mKRdQl83mq7jhjwMF03yGj581K/lgH/JkbCq
 CUeVPN+IiOs4z3vqVbNY6Jsue/txW/L5ystlE/rjYLWMJr7IvQmRL4DMW7imQCn5W/nF
 YYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710976; x=1793315776;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y80BSuK0WK5rSe4mXY3xlDA1h2OBu4s461gsGMfhCHY=;
 b=X5T2js8/GoFOyZsBJqrxQNqLe24nvLVvTRw+nJA6jYLAFrusdV7CggX/vWRPeKl+r9
 As7ClrNuMO1dGBSjIA54ypE1u5QnjASFrQKPOuLSmCK5bOdFV+A2YjcUf7ymzwfKMvk7
 D1ajOPnl5uxKLsI2cBmb9wNMc1wgBCqo5wZcDpbwkGT2pxQszhHO6/Exr4rACqokgFeB
 xwF/s7l7g1exV2j+2M1cCRM+Z1Dpmpk54lW7LBvujIVRm40rAblyi0TM0tXDiytvsvSW
 VWpjOO1+5puSY/h6MqsD3p0GgiMS+HT7qcajUsGliTp+/8pP+Z0WvIVFWI+l7MJPcRRi
 jTqA==
X-Gm-Message-State: AFq9FYKieuug2gN5OfZk29gYRp5E4qJAXGlMisiNMR4bWRp9Emoz7IFq
 4xeMl4gqmwvGRGDbazuCwPWhNnDzRu64n71QWEGFfyr+dIigEMXe6WYbvCFgZfAW/gU=
X-Gm-Gg: AYBFou33EML4/GyeJcmfQRbdmNmh6XauFO0+x5MZhnTLjTljtVv7ECr6jNSWUHtx1eg
 4kwnONfLpAj49VcNNaxpzfYJPVZAEYweuNogtphdTh6H8dEJJa0uJ5Kxk7LmLFbdqyyXSVWjYZO
 oJ45uv264TpIbM+uwu1xk8bAt4iINQ28Bkwfte4yuOeJwZ6Xk4S6uljmObCBDOQlWE1gq1P45XM
 sp5pJz/09ALDua6I4NrP93Lzip5csS55BRO8MlgBSNeU27JpfQDTeSk0ilwLw00tT+RlJcd6jZQ
 iYydsXAn7JdXhTwxME2iKZvc+5ALc4fBJgzXALdwBfwA8W5yVPZrkE94qQqbz3nflvqnQVyi1+S
 vtkUjc9iKdLzsS6GXI/x5S3ECEzKJz7zpeQO9HaNqPKhho+LBuYIitjWfEVUpL36GmCvLfCEzXl
 HLmToqyKOa0KzmCG7Zlxo++fN2j2d4cZyAEiPVilWyjkXxVAaSd4fRI2Nb17TuKPZss0kQrgZRV
 UuK0jXUzNiRMoX1HM6islzCqRbtQtAL8F3KMqNFtwNKYPIPs+KIm0I7kMAvTg==
X-Received: by 2002:a05:6808:1494:b0:4f4:6421:5efe with SMTP id
 5614622812f47-55be82b70bamr370546b6e.36.1792710975656; 
 Thu, 22 Oct 2026 16:16:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55be987bb39sm261960b6e.11.2026.10.22.16.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:16:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
Subject: Re: [PATCH 00/13] arm: mediatek: add eDP display support for Genio
 520 and 720 EVKs
Message-Id: <179271096443.3711947.9356363480272848332.b4-ty@b4>
Date: Thu, 22 Oct 2026 18:16:04 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/DLtlk1Jrfrl0AY4VCls6SuiGlWzzta3AOVN/LLazYo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2pk10QS0DN071oA5le4joKcA6jq+tv/oU8F0q
 CGVDpsRVpyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatqZNRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9ZgIAIJQirP3nC4YeP1eQQEVFddFhz7o1Jm5goFnOCZ
 UJtC6votEfQMn6zlGpVCOE2EMX5xF8PYaHXJ5K+IMIPXjE7DIjEhTj1vbQz/TXeOPGhFASFwh89
 LggB5EbzP4wkDdkCpnAoE1V2KPAf3//TmH8u48zsJiL1QlI6r10jnSlIwBbHBCsqfWWQAy9nzVU
 v1HkZBcvHCsFeIWnmvNq+YlvWjDz0WNAMkOWzXiw5PPCndG/uMU1XXqubzfkeE9Dcaq3woLuZF3
 zinhxiJG/7QO8KnyqOQECY/pLMUx2VPw+kdNj8txFo1zDqTLc1TDtfcJm1eUTYiLbBl/9wUv3PQ
 M4pY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

On Fri, 09 Oct 2026 11:14:03 -0500, David Lechner wrote:
> arm: mediatek: add eDP display support for Genio 520 and 720 EVKs
> 
> Add an eDP display path for the MT8189 and use it for the panel on the
> eDP connector of the Genio 520 and 720 EVKs. The pipeline is the same
> OVL -> RDMA one the DSI path uses, with the output crossbar switched to
> a DVO stage that feeds the eDP transmitter. The panel mode comes from
> its EDID over the AUX channel.
> 
> [...]

Applied to mediatek-for-main, thanks!

[01/13] board: mediatek: MAINTAINERS: match the Genio 520/720 files with globs
        commit: 6d72b1abf5cb163f2c9d3c421c31d69d4a6ad854
[02/13] linux: drm_dp_helper: add the definitions needed for eDP link training
        commit: bafda3d17fd50dd881bcb1043e85100b1ebfd4c5
[03/13] phy: add the DisplayPort PHY configuration options
        commit: 08018248963536da838d7904655c2739577034c5
[04/13] phy: mediatek: add an MT8189 eDP PHY driver
        commit: df7f4c295a251273e3250f22278b6de7bedcbd23
[05/13] video: mediatek: mtk_ddp: allow routing the OVL output to DVO
        commit: d11e730a2807cda9f3c97a3209e8e30a2ccf90ff
[06/13] video: mediatek: mtk_disp_mutex: add DVO support
        commit: ee31b38bdf49d31f4cb929854cb69445d78fafbd
[07/13] video: mediatek: add a DVO driver
        commit: 47e4f02283e2179c8948e4e283d3570f777c4b82
[08/13] video: mediatek: build the overlay with the shared pipeline
        commit: 44f4846ca09cbebfb5d1fdb5f6810a69e0c7481b
[09/13] video: mediatek: add an eDP driver
        commit: 0cf066fe2e331fac4d5e62590ef3a4a2f9c080c8
[10/13] arm: dts: mediatek: mt8189: add the eDP display path
        commit: 87174f126e2ff59ed20aeccd851455e47809b874
[11/13] arm: dts: mediatek: describe the eDP panel on the Genio 520 and 720 EVKs
        commit: 54d33f94f8df1e76ad2133224bcc439b351dc34d
[12/13] arm: dts: mediatek: add an eDP overlay for the Genio 520 and 720 EVKs
        commit: 68cf5df03974e8ae8cbb300cba0b93280c49e913
[13/13] configs: mt8189: enable the eDP display path
        commit: 65c7c895e0c919612f15ccdbe113c84546a342ed

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

