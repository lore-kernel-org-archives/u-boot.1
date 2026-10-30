Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE4606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sE2ObQz8;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZlJ45Q9C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DDF640A8D;
	Fri, 30 Oct 2026 10:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHAbKeS1DUDz; Fri, 30 Oct 2026 10:39:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8035140A90
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793356762;
	b=BT1mYG/EMSj3SbE3/DHzulbAfjAxCv6mb5FED9f+br8mVCpVlZJZfArkfU6Czrww6mco
	 eqkzCE/lTIMAHIZW+0BO3QdYYjrQojhkNsAYIsVkGOJYauH2Lm9brVNKgsYZgnw3uh8Kz
	 FSCd3riyv2PhZsJsQrxBuoVl6dCTrJYoMw+f9YD3FjpJQehoa8No/QTNHxlCWDzi13JJt
	 ITIKvtNMPye+pxRBfqbQrM/2P1OYE7ZlP7nRZCuHGTYAfUhlbdbrijXfEEgmTA2EYh0nB
	 vQXcUIZPyqHf24Udebwcja5r1ih30QRIOgNit+P1AGzM4rXi57cZ9xNiOHTQmTYqA1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793356762;
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
	bh=104YHbW4Koe7bwyo9vkfOeff2/+gqay7B6sXhpHGT2A=;
	b=kORBrYvSAKcCbGY8YOu9Ad3z7xJULiLhd0h/jQVy2zKEX/7q6vNe4k2ty6LvILrQCM5Y
	 muHRdR3X2wAPL5kkzzK804+roxx5JkBQhfHk/6n94uljx38T6A6NSjIANi3r8fH7VFsuX
	 0iuIeg8OQRQRcqf64iMHgSaEJD9BFRjHz+9uOQ7JJcb1oO2M3v++vPxH/k9yjUwC9oOWp
	 7NodqjhRMbbaUUjnA7XLexbL1GD1VyyQVgLavuxT+nII6TIo/BBNzPfCAURD4T1bE+BCn
	 YGrXj/xEi2kLDkaXayTXDpuHYahZKx5M1130Y3Uh+vA29K9amsZk9vfnc7pxVfvyfQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ZlJ45Q9C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793356762;
	bh=104YHbW4Koe7bwyo9vkfOeff2/+gqay7B6sXhpHGT2A=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sE2ObQz8E/mN2d1IK7mxjR9QQJ/+XTUV+l/DiCxY+wQfOHnXRId8W/9XqaLUcYMuO
	 YDemD5KM3A+TocSNkMv+p3WVq/AYzccpNXBDOhpkgu7dt8ZydwGG9LuVHV9FbGEacm
	 acq64EcAF+5quUgJnPkKV9wABXlE0QZfGaWtlUtTPtx2iBP+rOsHEGLGghv1murIuX
	 aeXCAq4DIWjju+cRE6+wUUSLyTxQW5HFjKbCwHfJjopY14liAqK+Nn/9d4d4DgLtdV
	 pPrEynbZJNu58SKIdNcFGXhlW3sfORU3kbig5N/gSvE626UwsOzbk9mx8NmOwFeV+I
	 H0/vPgefzaIQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8035140A90;
	Fri, 30 Oct 2026 10:39:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 770B64BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7442B40A90
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YR4cAxJYr759 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 10:39:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0BD7A40A8D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793356759;
 b=j/xgn3aG/2v9C8ichEG8+fFI2jOfV3lX+EoD4C+vGrswC1jSImPPIiIe7xOwaMVzVvng
 IhLhShnleFcUuMeVCZGSWjAyrXFJz92ygR8mJm7/gts+qLQnokjSCSrGSXwTc6wRYE2dp
 hgkwOsk2RuauMigcfjdX2uG1thWjW6xDzIXhmFlPUL8t3Xt0IKro5Ond1Dustoc+nFTOQ
 IHFpXWXTzjONrqVH0PuW2HSZOXERpTG4PxJV1TYNYcxr2X03tYdgGPMc5zXkyILbGa7pJ
 ncRew19ZwgsljPtzl+0vgqP8xS3On8fK+w82Gsoq/d3egK10vyPW4WAUdkDOXq0OFgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793356759;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=104YHbW4Koe7bwyo9vkfOeff2/+gqay7B6sXhpHGT2A=;
 b=PAlPmB5kPksAk8FbS6VNQMYG4hJP4hSfCHFqPkMII9Iwe3gopmvGFIyg9cyGYpQEyRKB
 aR7qSDzfuyp8RaDT9vfgjriCv3KMalQ9YI0myVmvXPUoag2Vp54p07KXdPv+1TXzRifEP
 A56HvljZokwQotpkN0IKVdfI5bAsbKZvy+xjpjuHEujSAVfHyVg0Q61p6xsWEf4XIE6B8
 h/LKrAfFTxB5BbG7zCxLtpMfQnH1vu1fYzbz3DdTqBF6Kuf2j0gN2uDX3eLQReKvkIto2
 DyJnHYot80t6Dd+/tddjiHCQfe42TTWHUIj3JMFh47Xr9GHf0ZxLnk/LR0JxX/7U2qQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZlJ45Q9C; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZlJ45Q9C
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BD7A40A8D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 10:39:17 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso4611995e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 03:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793356755; x=1793961555;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=104YHbW4Koe7bwyo9vkfOeff2/+gqay7B6sXhpHGT2A=;
 b=ZlJ45Q9CTMDpKwK5SA8G2tbOIXq3uyyQ1HESpOHqaQ8t+SqNWfdQWfRNIxFokNRtI9
 icsoiWDBZbU74UqsCpfWQZYMb4VYwIM5+YzrCe0Y4OiZ6UJwCpL1kx/v00rB44HgWJ8x
 NU3R1tCAs6XK4NCxWOqPIdCAD7OOei+RJ4Kp9uRLJht6d3RyYSCTS5Re6XJyuE9xdT5Q
 gLcv6b2EFzoPgSPjvM5FVY2EQ7rekUcfjUiIcfOZmjwit1u6k4DhabOV1OiD4EBifBv/
 KFuXOoQdUyF7c3fC6KIXc9X20HSCNQScJtwb9L1BjqyfIbfBXbuWyiWx6ynj/ALVqGjM
 ATqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356755; x=1793961555;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=104YHbW4Koe7bwyo9vkfOeff2/+gqay7B6sXhpHGT2A=;
 b=tCPxSLqS4n+L3g1ZfbAucJYY4QefzyREm1FMEO/mWxdisbsjSR3M078ChI8JGLMTJ/
 C+yJ8YVw+SHojpWSqcYZWxRXydt+pV2Rp4cB0xjphx0CR76FCiZAtJcofo5eS/olaVRW
 zrCIj7k6vHFK3fxCLfxYsoEo5CQOfItC7IUAfbqMh6tiGLc6nzOCgEQOjlnNX6HLUQDU
 2Us1jPCNhcY1w0G+wEHL8uyngC8dNyoAjCSDTHd5IEa/xsIH7JQAzIF/0el446/v8yfZ
 Ei2y61ZuChFNoDv1zRdRM8HC1mMIeilSRdphUleu4avgh3TmF2WNdEZY5qDQhgH1B9ZN
 /TrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwh9QMkZoSBtQvcskRrVoDC2mTA+wVE3wOaRf9/BwdWFQNhOoxBhtOev7NqzT0+UKwfvysHdMo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKR38a7RF2fFQNnBuRTZE/HIMQpTvNqTAiBWqRdORn9WAYOWrw1
 viUAvtBYsBsgAceXgIyB3UAPaHxUtcCL5yZOK7DR0uHWHV9Q//6EtxafF25D3YkRM8o=
X-Gm-Gg: AYBFou32duCdRjO4thvROKU7OarnogjbkkWPBtDSfFtEeE5bkNyFOHUJyNhNqmIn9IL
 Jr+dBvibPGeQZd8F7F4CTR1bBbv9zuzYnxgWiJHjfQdrEXQhs2BGACwwEB0SMnihWIViIe4Lhe7
 sRTF+0vUkbH+vL0fIHqIABfi4o2sJPXVSNYg3Bo/WVHcnc5AKKoiUu3D5Va4E1V/PC892SN7t5V
 nb9Blz2ySnOfP9dswtgTwb3P+5w0+rcRPlJL5b5rt715kghRZv1dUVilIbVq4lBoJ8vXg5NVUie
 OzvTijAN0F1lNj+UTtCv7JKsdaoYaYMw8ERuIu+iqHTA15k8n7a6xQvaMMVr9ti3oLJ2hf3HanF
 PyPeIIOiwomd6aNi6c2N/sy/aCOC8KnS5CMSm35who3m998nBaiPBVfQIaYMTwE6nmwH8hwL4H9
 xGG0zpPCUd8ZKrfj7rbDMoC1h1kFRK3pOJI5EeOqMxPVrDvg4x6ufn+o4envIlMfywVt72mRvXy
 snCLyYf2T7aJp7DI6+rC/Scx366LdovvEjiqf3qChvOp1b4II99U9Sjpo6JyxKTVrAMpT77UNbY
 vN1gLH4xSZ9JwIWRNM+e8EZ+grcy30Dszc5MHPUeYJRGxznr2H1u60yzSgJ26dUz+J0Wid/FZZH
 zDuuQN5/996qTbG1SqGf86wjFrwLVcUc/zBgZB6WWBKfVw9P7bIQzAghlLjT5/Tciswx8js42Sj
 9Rx3UQdoKJUA==
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id
 5b1f17b1804b1-4ac14ec7947mr35077565e9.2.1793356755350; 
 Fri, 30 Oct 2026 03:39:15 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net.
 [2a02:8434:7c41:c701:8278:849f:666b:c282])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm130073175e9.4.2026.10.30.03.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 03:39:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] power: pmic: mtk-pwrap: honor fallback compatible
 strings
From: Julien Stephan <jstephan@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Masson <jmasson@baylibre.com>
In-Reply-To: <20261029-ccaione-upstream-mtk-g700-usb-v1-1-6b0dda25be38@baylibre.com>
References: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
 <20261029-ccaione-upstream-mtk-g700-usb-v1-1-6b0dda25be38@baylibre.com>
Date: Fri, 30 Oct 2026 11:39:35 +0100
Message-Id: <179335677538.4117849.292438249217980426.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1793356778; l=1862;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=ZwQrutC/Bf5oyqB/nXzNGl9Xbqy1H0F45C8sj/5Il3s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAh3YR1WhiRXc/pyzs86OKyCN+52DYH/cGuqUeekd8HEAYC72DA7x8Q4U+iJAVfJ9ueJwL3H/yq
 gBEqHRoyDGwM=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The MT6365 device tree lists mediatek,mt6359 as a fallback, but slave
> selection compares only the first compatible string. Consequently the
> wrapper reports that no PMIC slave was found even though its existing
> MT6359 support matches the node.
>
> Use ofnode_device_is_compatible() to consider the full compatible list,
> as the regulator-binding path already does. This allows the Genio 510
> and 700 USB supplies to be resolved without changing the device tree's
> PMIC identity.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
>
> diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
> index 468af1fba04..2e206207136 100644
> --- a/drivers/power/pmic/mtk-pwrap.c
> +++ b/drivers/power/pmic/mtk-pwrap.c
> @@ -692,7 +692,7 @@ static int mtk_pwrap_find_slave(const struct pwrap_slv_type **slave, ofnode pmic
>  	}
>
>  	while (of_match->compatible) {
> -		if (!strcmp(of_match->compatible, pmic_name)) {
> +		if (ofnode_device_is_compatible(pmic_node, of_match->compatible)) {
>  			*slave = (struct pwrap_slv_type *)of_match->data;

Hi Carlo,

With this change, the pmic_name lookup at the top of the function can be
dropped:

  pmic_name = ofnode_get_property(pmic_node, "compatible", NULL);
  if (!pmic_name) {
        log_err("%s: missing compatible property\n", __func__);
        return -EINVAL;
  }

pmic_name is now only used to check that the compatible property exists,
and ofnode_device_is_compatible() already handles that case: it returns
false and we end up returning -ENOENT. The pmic_name declaration can be
dropped as well.


Also the "REVISIT" comment above the mediatek,mt6366 compatible entry in
mtk_pmic_ids can be reworded: this patch fixes half of the issue (the
limitation of ofnode_get_property())

Cheers

-- 
Julien Stephan <jstephan@baylibre.com>
