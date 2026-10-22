Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB5606A321
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FeAg7Zjg;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jfQAnbxg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28F8B811D7;
	Thu, 22 Oct 2026 14:39:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UcaDYTen6iQR; Thu, 22 Oct 2026 14:39:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67A9A80D58
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792679965;
	b=Cks7h7WO7k0WKIOYnwbqTYDOXFc77X6cErhqtIv8Sj9AiqI8+kVYSTZTYb6ffDIhaz7d
	 GkPWgyhHCCQkNVAMa4CKIMpzGsMaLzCnquir90bSBL6qbqRgAjAeIDdQVrcvcW/9507C0
	 AfjDcLYXMWPveyw9/4LEh0Z8pJsPKVGhwVAKd36c3XjtEjdA30eKK4bEpcA+h+UW+pPAH
	 nrHW+M2VHDmEouTonrbQUJycMIxxmuTqCgmPI2TnJOIKjVCUVlRX4c2dZBvjYV+flaixU
	 bRIGjk+Hw+DEnuFlfu+uCsHLEMiG90+z8OnjFXP8IKeqrL4uE6nqdjdwWOGWfreGAtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679965;
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
	bh=aZGzVCKmCOOWfvZgRlZfqlkN8xrMW6zHY1IAZUGFW7k=;
	b=Tr7Dd9kQvqlUH4Xt3ekes5LcGXgZErxhTwaej8efWvEM4fCxjhiID8iVEk/bDk6X/ZMf
	 g1w0tbRi/vw8MQqGTAJgYQz2v/kCk+3R6Gk+XqXqzVM5ipbd7EBMMIvQza2PiupFHecPf
	 WNcKSnTELkqXW+BJ4yK65We4L0sWHfWgyhU4C8CSIVeunp7P0bCpz4tHva98cNxlqgFN5
	 R5u+3VrzrUO3t/OS6o943GR3xxKX1oljBgPEhkLcmEUrnZYkejZHorRv4//ksdI3CICYn
	 vJoiqLcwwzpBNgLiVJc6ewjrwM5szOrcqm0p5QlmM9LQC/c9TXLIrr0tX8eT8w36iDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792679965;
	bh=aZGzVCKmCOOWfvZgRlZfqlkN8xrMW6zHY1IAZUGFW7k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FeAg7Zjg6qzc7U0ccmNWJZGbB5WrGC7pj3y9zXLXpsY2CruAQwvaquXj+mMqUx+ql
	 ++VRV3SDzoK3RzY9MPGtja27K6aGsdqKc4/BJ0w7lZECjMaWtPDYyvphDZMUGqznnc
	 ICpHkhYgZ3WKxcRFy+NfaIfLNrZQfjUHcrSzkyMpxF1Sf1lR8tS/ugFYo2422IBFNi
	 25xWWkO+43O0Ffz62ecJ9KS4tK8tfUNr7ZJyvp8IfE7nDnni8sSZHaqRaQ/bXyytH9
	 yeTfF6o/4glLvOeRhPx2pz9lR87ykQGXtkfqry5UpGwvyXjfGspNd2ZnnqXnWyPxkX
	 6sXG2Dby1I1Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67A9A80D58;
	Thu, 22 Oct 2026 14:39:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2F88769
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B43BB405C2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXdzZm20QEfm for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4C23E405B3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792679963;
 b=Pzh1OBFylMTaA/UzS+q6nc6PnO2nJo5xf9G/nI0tntz/wY5I9pvQTd5E+JKdbimerkM5
 JqSm1rwQ4Q3MWJlfh4YtK0QIuPLilMhgpTwplKgHVo4D2jZ1WH4GNOkxnZaEEvzyXNLjl
 0TCuyWn0BeLPeJ0UReGb0puWYgUMi155bj9EKRGh2D7wcXITg2gVyOImIBxtZLcwTSini
 7X28ijE6NPAsQeoRuLPh3BxCuu7i8DhrRIMc7N6RuAqSPYUgSYnlnuk+BNzBUD6Zc1721
 FY9CMt26dObWMuDQ4YJBn5grqivD7/7fx//JeC/vtMDHYSoJpN8WBLo3BvR+PiJ6MlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792679963;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=aZGzVCKmCOOWfvZgRlZfqlkN8xrMW6zHY1IAZUGFW7k=;
 b=S4FyGodbloGC1V3TQ/yLhoH9TiWpK2vI3f3HlOYhCbCPp/n2RJY2z/0mMgrDaFo9FJy9
 V4v1L+zbsC6i8PpJzOrT28jcTiCwRU3arYhxEXufvBqjW6S9Gh9q8vWuMttiHPrFmsInH
 ujAIjoet0Jm8Y+h6Neaa1xv9f0Pged1TBYED9Rf4CfNrcTcPQFEmUoTTobbQBVBYSe4rh
 Vje8zwqtq7nOhNzYZoBPVV8mvhXwDCi8zBU5lE2IPI05TNCjlt+6VWapmy/Yaofj8v3bC
 uSWdFS8c9O9y5ZSmQdKxveA+8tPw2zcuB07dLUE6o9RyvoKrE6oBn3HoeMP7Vg8Xqrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jfQAnbxg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jfQAnbxg
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4C23E405B3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:39:21 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1380437f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792679960; x=1793284760;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aZGzVCKmCOOWfvZgRlZfqlkN8xrMW6zHY1IAZUGFW7k=;
 b=jfQAnbxgKF2Mb9xsNF9DOn6vFYXcz6nTouMJh9mgoZC8OG5aKGJqXeJGZ+jT5knnW4
 M6oSGmcB8DzigdalGq73CiQ6Z3JYAqX6FdoT+jbFTrI9GCXyqYKnfitA63AxGy3YHiL2
 2isvgcZ8heOHt6lBBMTwgM8Ua8b5peX3tMGLeKpm7mFjR6mvC/2m1gt2rYQMm8omDL4w
 aq7j4AuBnp1gFsrh+T30RWNLf/TrWkEXNHyWK3NVkjVklPbLeqU4dGKo3mYdB8JQ5xfo
 XyRf75VgDTE9DYDJoCZKMcdZPu+vrPF2ghKl/ESO1CHvyigb0Xd6wejZAqDedarSdoWy
 V9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792679960; x=1793284760;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aZGzVCKmCOOWfvZgRlZfqlkN8xrMW6zHY1IAZUGFW7k=;
 b=DynDdUtKSud/G21K/cPTvRpbAJ92Wem5dUos5bhWBXDNABw3yxnp/LuHp+EcnL6qse
 3IphLO59/5tzpl9uKyk1OV7C91SjPner8HylFIchy+Dm3ojmvySvR7R7CXTt917Jdqa6
 YyfmRJkng3mzf+d19tnnZ88wIdgB3H+p78ft1x2h8SX/gY80pnaIKs8bGeV8okkGmJRG
 JGTTbqCVTkpHuGJKVT/Al6qldG2j5V9QX83EyKkTKmjA7no/u9HYa5J5TMQK+pBXnO6b
 IQjgxho3JrTspY0Wm7zIfv91OOO3e/nH/roKy1y1p5PPh0pzLkkz5D1WA/isG8rZwhHK
 9yTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2EVlJn37wl9ytaJyRIk3L1XQl/zbUUJu8KvkWBBQBoT0xueWHR8P3eDlYBuBW4nLOQ5WTvvQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJfa5KJhoYcN6bW6cSppr4hdT28q3EKydOBll1DKJw1TxUMJ42W
 Szqm6NTobJtjLScE+vYXcIfD8YJ4iXiCGCtmFFKK1B2f4SzAPFOBhX2XsMa8osRDTBQ=
X-Gm-Gg: AYBFou2cDSSK9HTyV41g0zGa6Ly6USRcbSlUqBlRACnb3L2q0OZRNNN+te250MltWXi
 bvH883iYNCb2HaK954mwYhE7PHjs5DSfPQ7KSiKjFvcU8PFM3cuee3scpdcYlWrP398u6y968uq
 txrJkmSwC8Piwg3TrnlfOJOl1EcphXqvpv2Gn/0LQlveOMD3hxemQ8JFN7Bs+4g/5tVVuNjI/Q6
 Z5lZKYs5g+GIRQQVJzMu1GAxOOcnVD0RFtb3YxKa4VCnwlYF5JUkGwuKFPB8fJPOb3TrNIcpSeB
 Bmf7PsxTuo2IIrVnjtxkg4WxKkP5opaKA6598XOlAs4vCIG/AF4DGNZbe21QBg8hjh9BN7T8kbe
 xhqu/3v+swh5cRu70rVtjJ8QUK5IQ6VCMVU6qJFgz5X+gmUrtwo0W3PSNxl32JCEWfBHFt5hIaC
 6IXfxCG1AhUglnwm4HgJqIH/tFCpQf+ORWsMU9T2fFRs9OSH8l/41Zw3LTbb6AROp7/153CAyMI
 7mBwzk7a/ZLdBqJqyQgGpYywHAciCZGwCGdbtJpruz4ZmaxQefjl0c1DTS55keytsgFM+3Ujf3F
 sQ==
X-Received: by 2002:adf:f8cc:0:b0:48c:6d9d:9f90 with SMTP id
 ffacd0b85a97d-48e264e1a6bmr9017128f8f.26.1792679959901; 
 Thu, 22 Oct 2026 07:39:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e3bsm12415852f8f.31.2026.10.22.07.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:39:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 3/5] avb: verify the boot images in the buffers they
 are booted from
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261020-upstream-avb_lock_unlock_b4-v3-3-e280795a98cc@oss.qualcomm.com>
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
 <20261020-upstream-avb_lock_unlock_b4-v3-3-e280795a98cc@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 16:39:12 +0200
Message-Id: <179267995216.3508122.15097053878512752660.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679958; l=634;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=lp60AS3F3jyvoDar21djRnX1+OB9ZdeyNnMB3Od2s4M=;
 b=CTwb5a2JkpIRc7btgA8jC5phVRdXyW4xFWImJuqjn44njS0FJOtuqelgnMaabUMve1I5YXXtU
 TI5KyAaIYPFA5CyGOIzybXRRr5Rm7Jw0uaimhfJe+9cucWJtjMPLxy7
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 17:38:10 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> bootmeth_android let libavb read boot and vendor_boot into its own buffers,
> hash them and free them, and then read both partitions again to boot them.
> The bytes that were verified and the bytes that were booted were therefore
> two separate reads of the storage device, which an attacker able to
> interpose the device can tell apart (reported on the list as a TOCTOU
> issue). It also read every image twice.
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
