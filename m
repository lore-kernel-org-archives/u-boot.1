Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8072606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xA2RIVgC;
	dkim=pass (2048-bit key, unprotected) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=XoO984jY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF59C80C23;
	Tue, 27 Oct 2026 16:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 457Av4suL25U; Tue, 27 Oct 2026 16:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 031FE80B49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793118856;
	b=O+3AoD4IKXPrV3frE50oIALZFql6r2aY5wWstviB2sHyoEM4fbyMzMZNfhj/nFVCgudl
	 YzpYUq+NlVCwv4GYJ1gQeD6QUkWzHo28rv3eraH6zdAzBTerbPXejJ5ZtLDuH3ooCWO0F
	 mvYl2FXQCu2As/WOs8qmut96LZYp21XgYYU8eAN2jGkDAc+73MPFiAhZxdBQFD6K2svdT
	 8w22U9et+h8MEj5i52WYsj7T7NYhIksNIm7oHQxyLbG/WBKtAK8y4f9TQj6CxwORCK+/g
	 kbLiGPgz2DJ4iIGs25GbE3SNxd3zIaHWlLAZpwZvTdr4ExnH772FsalJ14oqRKNQjOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793118856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lFOElifbt5rxx0AhDMlHk/nL0jd/qmj3ykHIigu1vZ4=;
	b=XvMvaWnv9zsKWGYX7e2gvAQmikXkBdxIiybC3Ls2Xf4IxlQ7Nix+lGmFJDhKaj0JzatQ
	 R4Kg2ftUUSyCC0ebhJ5qNckra6T8HQFoPSbOFEw7jMNZLf1YHUYWfphwRlPkteGqzjJlZ
	 JJwZQWoLPboGIPD8GM18x2dyj14QvNtuN5n15xeN2BgNMZu8Qz0nZ1ZtKGMKNog9d4DbP
	 zBC3ewb3qk2m8pGDgnTS56ADlVIscOjVxILtjTfatojQIE1eTGhq3w+b/2bbnrBgdANLp
	 C9ScO1/Pj4/5UWrKxarMXdBfs2bJvnyx7PWGWl3EmorgWEOXufsy2LckPAQjaJmxVUA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793118856;
	bh=lFOElifbt5rxx0AhDMlHk/nL0jd/qmj3ykHIigu1vZ4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xA2RIVgCapAAfevYRA8IoWFyOvQTNSv3jafEuBi3IFUxHlabl786um/EfC/axRnlv
	 BryhBwhlQfSVP/qAcl/XMAP09O4OOU740UpHNEjBrjOJhxzo4SGM+P4MEJvWVyRHm2
	 XV3GbcTGuLIlTnsEYVFTIA14I+4Qi3vblG6iEFRtyajhXCmQw0IadHdngBzow6Z39s
	 Ukm7JI9bp+sBedoKJWHGUdG15ritSHZ8Reb0/pPCyFdJmwz3YHDp2uPGfLe8NHvd1G
	 k6yqEzDNpiwj2odw+ciFrbff/bXnDpwf+s3IU4Ay3Tsl/8U+clv0ms1DXt3sIi39pM
	 Sc4sK4n0pRFKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 031FE80B49;
	Tue, 27 Oct 2026 16:34:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 301474D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 160DC40076
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UfuxNg-_r1VB for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:34:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BEF1440024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793118854;
 b=tdQ1DEMBXRAIJQilThUxCd/DRJ4xZYc+fQgsPd7u84H5Dqy0JrZZvaCTWfakezUU+159
 0zFrCfCiTCYJso106wumirrKRRuZ2OxFTJh3nu7Zcfx7Z+wpsAo9srbN96ofgBxh9YGaC
 PMJVHqja6D2LHkEwTa26KUEdDTuZAGr3Q9TyuwuK5yBlouGbN7C6gdfHC3uToW8lQ4m+T
 9Ph+GkSf/mhe4LA3zAu4OtoGiB+FaklTb1ux0z7MyPh4UHp/BtHkIlRluULsTV9U9fQEB
 IZXRnk5fkH8U2IM0x2rr3i3kzlgleK1VvqxATnEugYmJeU9IxtaBMjGXr0OY3t76qxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793118854;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=lFOElifbt5rxx0AhDMlHk/nL0jd/qmj3ykHIigu1vZ4=;
 b=kdKndPCwyEMO71eYIDj5ngNFKN/I8Y1zMCDJIo3NLXUCno6l+/g6uXvr67ZOx7CNsfHv
 sSJAWthB6Vc5SzQ+CiCyg3GLEBtTjlgcX8m1Q8Tn0KWZCRhbUIpp8l/HEbZTs9+qcbK8+
 +tK4/R9PWejgpshfPsvi009UJ62IP4z/R8ZfrOuymHNdqxNhi8c36VBCTsptGEZ3dlYRj
 6zfsRzvm5RT1yynyQ3e7eMpU3maaQnZQ2Gv2836W8pRk4901I2U1b1+saVYjFomYq1nMY
 C1hWeoh8FjoOKbDffhjAtT0xX38vBWAMm4z5VMhwSnUj4DLdbXG72Ofp4lo/aAbOIkg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=9elements.com;
 dkim=pass header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256
 header.s=google header.b=XoO984jY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=tan.siewert@9elements.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=9elements.com header.i=@9elements.com
 header.a=rsa-sha256 header.s=google header.b=XoO984jY
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEF1440024
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:34:12 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso317855e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1793118851; x=1793723651;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lFOElifbt5rxx0AhDMlHk/nL0jd/qmj3ykHIigu1vZ4=;
 b=XoO984jYV3iuUAoLRAb7ofWzYnIXnpE31ql7452bWXsyc+ajqFzc+odlsHmjVbqHu4
 dsQHMdpJwVIOo5DnOwIqt/p2FcMgEsRmMUGsxeJ9jcvRjCmwuMc1MMj8Z8FX4LBJa8/A
 hqfAuhayhVEew8j9gsWHsE/Oe+95k9ru3uZZ2aZtsfVSmXWQihtkT+9akDBzySMp2Ho9
 lARaez/OfJsM8bG0wQ9/KjPw9H6J1DstCIy481VHgYPLhN+1+iWQJQ30aTd/ZEz4JF6g
 tWRHUpWMmM8v3UdXdosslbe+zF2751ia3uuBtNV3x0fyD3tv9nfxEH8bQpurW2EI+839
 JwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793118851; x=1793723651;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lFOElifbt5rxx0AhDMlHk/nL0jd/qmj3ykHIigu1vZ4=;
 b=aV6aGC9Csz/D+Kx6egwIA7g7w0uXi4xnZtY8pCC6oeMfZABsQ9iceG5BtGn9M19G21
 CubMRIRzFpxucFyiXqflaHGEFz1nKCkLJdejqXsSCnLCw4dF9jOANsbDBDkmXUArJYpp
 tEH8SPt11WfYCO6MZEILywE8YDrYJnl+7/RksdUUl66hve38lexlSoUVzFL13J0vSo2G
 6TY1j/IC2dc6kHqfVhFtEyFv3TsJjKdyVgIh5Kk3idUe/BdFzVsl0/azTD8T5yk4Brp1
 sI4Ut2lo5c2bJlAbeIoTixV1vKjaYReo73aKt2BWTkQ7mvZf1Pytt7kAg4sGcfgEcWMC
 b4fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3MYsQ3eYEM+q720NW6HMEHuJg6TQBtvIQjAJZck/+SpVoNoVCHlQ/W9wTsy1+WBif9ov8WlE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKFHLpQSA+m5GAWy7pJ1iTetlVWGPrH+1hJ2mYAzwm/l/fTMoBS
 zRv7fZ3raG4Z6SRQ3hTLW2mpUTYy2ZLrF5nITUKsBmy5L9ePvGmkc+zl8+DArup1RWY=
X-Gm-Gg: AYBFou34MLlS6yHzTbZZ/GFMt1GRwxWoi8NX/Reomnob0QG0Qsv8pysJOzZC2yU97qc
 zoTMQHoWXwowAZzfgnCi/XdhnNydVc9RG2gYWXdlzcHXE99lEKe/R0zgenQ+00g2+/TyHcu4yYK
 yrcWdklX8t050Y/HTIOezPOlOrg8l5l3R50R3o7u3gkR4ZonBXDhX4by5p24QDSzriLejWRbVky
 Z1i8DoJ7pfcoLYjkhnrwfc4pFNm/+vI0OgPrCqB12rTUqrxsFtdY9Pu+j+B+cNpZbKJH14q9mpY
 4L/OnfO0I0hEbk5WQruwnuR9nTqU4N8prruIS7k7COj9sHK9/OK+ebeGVZka9xM/eyGPSbQvDjt
 y7pl4IPDSuQzUlTC4XTrj/clxpFqfYH+822nfIX3BvpC47BxYkQDmMZjjW6rVh9joZ2/YLiWU0k
 BY/yJosmipda0AnrP1aTuhX3Guzi4TxwR8tV1ZXuM1yb/qsEFEvNa0ip4QP1iCmU0m0ASAiMR/t
 1WToGpFMq57TUaz7hGEvgN/ydHl8MiGjVYA/tejgvgycPrtsoFfWcObxMXo+wawhNFiW8+1
X-Received: by 2002:a05:600c:a013:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4a35acb3e07mr226972905e9.23.1793118850793; 
 Tue, 27 Oct 2026 09:34:10 -0700 (PDT)
Received: from white-mocha.local ([2a01:599:b42:14a4:863e:28cc:6e45:ef80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a93103f029sm328955e9.5.2026.10.27.09.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 09:34:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] spi: aspeed: Add read timing calibration
From: Tan Siewert <tan.siewert@9elements.com>
To: Cooper Huang <cooper_huang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, u-boot@lists.u-boot-project.org, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Tan Siewert <tan.siewert@9elements.com>, 
 Vince Chang <vince_chang@aspeedtech.com>
In-Reply-To: <20261027-spi-aspeed-calibration-v2-1-26359ab2d86d@aspeedtech.com>
References: <20261027-spi-aspeed-calibration-v2-1-26359ab2d86d@aspeedtech.com>
Date: Tue, 27 Oct 2026 17:33:58 +0100
Message-Id: <179311883873.1551796.2270292846726980025.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793118840; l=826;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=0Br+0unijrzO7lwf+Xfluomyz9c4K0vVdfye5Q0/CkM=;
 b=5amZT7mJ/GwQoVMt1ZkfxTR/fx7gkWWTpD/nB7X3iZYGis2OwsHQ0tLe89zSdZtqVdvvoNdv/
 j0wTvLKEO9JBVUZRDPhx94XwUtWfNFkavpHeA15CBAG31LLbkPAa8Xy
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 17:24:33 +0800, Cooper Huang <cooper_huang@aspeedtech.com> wrote:
> At high SPI clock frequencies, the controller must delay the sampling
> of the read data, and the right delay depends on the board. Port the
> read timing calibration from the Linux driver: golden data is read at
> HCLK/16, then the timing settings of each HCLK divider, from the
> fastest one allowed down to HCLK/5, are scanned until the reads match.
> 
> Until the calibration is done, the flash is accessed at HCLK/16, as in
> Linux, since faster settings may not work without the timing
> compensation. If no setting passes, or the calibration cannot be done,
> the flash stays at HCLK/16 with a warning.
> 
> [...]

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>
