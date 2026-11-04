Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8316606A32D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lB899TQR;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBQ2I5u9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF1F780E42;
	Wed,  4 Nov 2026 13:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-cSO47yT4PE; Wed,  4 Nov 2026 13:00:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBD1480DFD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793797213;
	b=GX8O7NoSGkq277iqrhH669p9PUvZUWap2U0OOBu43vSoIaFYsmcNGVRTQPX+DbBS2rVM
	 MxiEl51bZznNKBOL1lBYYYDhJFbA1anpDZpNYlfdNRJa0YCyC9fKMmQLu3GwCrsStpHc0
	 FzQ6jIpiSewwWe0OTOuOTimc30pRu5vjGsEKWQVSQa4soMia+uKROejtwGGTGdPJwqGtu
	 bsukIQtt32wcbBRUGKssyxw9e8Jc9jTrMe1kwVA98v1E2WIJMKPkeMjTSDxcVbK7qNx/n
	 jq2n6Ie+49iwm9Ms8YF31eR3K87HbwVxsln+souPvuRLUEX1h0vzJUQp4uN1nzkGgqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793797213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Bk5vUCrrNmCpnyaCXFwyv23uNkd+IocPgn31wCDp2hk=;
	b=kL7CYQU8uNPkCZxInSvOnHzybd0OwF5YPCtxi1Ny3VeYNFnk/z72Ar3+piBAlGcQNZfk
	 82k3OR093RqsUNFu1wC+7anILhXguxh3BoNwrPSVgOWi8QToMCwNWVMdEZCC64R6cUpkE
	 GxbYiV2zrP0M+O6Pxg2Zf9GvEdoRzoQA4VV5+1SDwLfd3KXZEcnhFJeHo4I04s2rCNB9u
	 tQzdVdyE9/7u9lYCPME72BLDWWu3Ak+jt5m2ZvFnSP6QfHCcgR8FHwa627SIx5ktIceMK
	 nkfNpVAjAFCt2eUTtMDw0SU7gpRQt6b41BprTsf6ihXruIX08YwTlt/ITrZKFhdwNvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793797213;
	bh=Bk5vUCrrNmCpnyaCXFwyv23uNkd+IocPgn31wCDp2hk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lB899TQR/x1dhN8eio8F3tFGQALuvw2LfNUWEC6J2sSD8kjx+ZoG+SRFjoxNO4H+O
	 c29SlyCbA4e5aDOP/tCvfAdwfDr6JXcXR+LRNlhWA2QbcqyHKkBL1oR/8Jg1N7asBD
	 Ud9Z2ZunAour5vHM3jHxXpgbvvVF0C0aDAb+5rkKyZS5We9py5L98UHWDVGwu78tHg
	 yh4O8s2nqI32ZDZWv+EXLRXt9sLTwGUDuKZAeCZZqr7HLBt9Rd8IB/7GYVLT8kOWWy
	 Vnyh+WxcplAzDmNW/0HwiEKN0SstUDQv47enrlQSTaYlmxYVGbQof0yroPPBPgwxqe
	 2KU7rId+g9yLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBD1480DFD;
	Wed,  4 Nov 2026 13:00:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8939A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE21740068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5chGfw2PmvqA for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 13:00:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1DDDB40063
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793797210;
 b=rIpoyZkuOJB0kUO2yKbzQmY7iYZScymUFhi1z8mgt7pJq3AzO6L5c7Rqnu0VpWc5fR6p
 /eEXtoL/rwTOPd9H5mWb2jviPLi9egDjfTYQM/w9dP1qjBnVvWSs8SRotiiQUd11Kn9Qz
 nPFnRlAA1I0Zb6LysLttppYdPYsGkd+YAQuBi7pfW12J4EeQIzvE5gHgNbpgvJmWIFSNr
 ZWC80leXhhpVHijOVporZiXApmc5PrjAQdBplIC2H2B5LJV5K0SrzPTSSn9vkwRmWn0xS
 pVSdwKDfSxIph5B0QZ9Raj+WrJ8PEmZBYSjz0GOYhnGoCxGE2Arl1ffFdKp4rwMsnWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793797210;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Bk5vUCrrNmCpnyaCXFwyv23uNkd+IocPgn31wCDp2hk=;
 b=McNVG4UFR0jfEX2Q1gwSojVm3BB7KVQj/mf4CvLGjop0YBV1FZCvPuBnBfE5KJSdLqdx
 uDwcgR+srXrU/E63gFBaVLZ+cmqYxHZvBX9ZtrZWadHM+Ap5yz5EL4L40+E+07pjPIXcM
 QRfZ/+Ox/DEkS3GVDznXkCzaz28yw+mgiuIAp1Vs9QPYz+hmqiv8i+OAVtlHSOVPzfiSs
 io7NoYYLROXKYQih7IlHNiyqaB/I/ws/TWJEyVOILKvVxIrqzdL9xAM9e2c948KYL1SSJ
 VEgEONpqk4JDvHAuWr+Av9RkNiOTvMsqOtKtQXo5JBO4wa8W+4aTByUUdqiPBs4KGgQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GBQ2I5u9; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GBQ2I5u9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1DDDB40063
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 13:00:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 321E642A6B;
 Wed,  4 Nov 2026 13:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2BC1F000C1;
 Wed,  4 Nov 2026 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793797209;
 bh=Bk5vUCrrNmCpnyaCXFwyv23uNkd+IocPgn31wCDp2hk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GBQ2I5u9gurg8ELUHIPSlyGhgL/SGIhOW5n7Yzrvz+XmmFEt5TFYlydu2ySG0wsPw
 9XMDBZVSbmHyK9OZ5HXTvH3J/XqJr+7UenrTdSOB8wsAAotNVVr9pYBQqeRmrT39Z/
 KpI4H1BoHni4D7C7SBCjGB8Ve//qzl9s8nwBxUpbEFhDeDl04nCaVFLepkJNF5sPb+
 Ks105IqQ43fZCHZxGJQwQZignOvWZxohQ7uJUGO1kw5at4ke7MRqTwxfP2A0u698xZ
 i9nRP8MUDIiXBlcyPhuwQZEJdovPwz6yFPNVLlZVTDK1aFLZGv2Ryxt6cbkE1S108b
 n66L8Pm1QPO/w==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 04 Nov 2026 12:59:52 +0000
Subject: [PATCH 2/2] gpio: spacemit: propagate GPIO bias flag
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-02-k3-gpio-pull-flag-v1-2-de9f0a9b7669@kernel.org>
References: <20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org>
In-Reply-To: <20261104-02-k3-gpio-pull-flag-v1-0-de9f0a9b7669@kernel.org>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=dlan@kernel.org;
 h=from:subject:message-id; bh=7pEgMKYQfQ4gHUNkeLUPAtem6nx9WEfmzBJlVpQopz8=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq6yxPcb1HUv8s2Vkt/STzbKwiKUZzRK1e+Jsgb
 zrwdfry8xGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaussTxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3REw/+LbHoh59Vl7j6sf2ozyB+nFkmzbnXOMH+CVIj4v0C81wvAuwpUP0F0
 Te3AzEJrPJOBdvqpk2rgEkqJv+Doe3aB/4po4j/oAUH6tP/Hs0l6quZ6ZJ06G9ZS3bBymx1Lfyv
 mPp0A6SsYT3Bm80QeQ+4lxJ6ylwqUyZPqDyJ1R57CD/QdWzrIEC7ABUX13KZoeVhN0qovDBSdcq
 gjgCbJr0Lvwg2h6GPQMGxfNi0DhM006tegg9TUtMIi5uWQLiDJedfn0HLoFHiFOYHWioxpB8Vak
 H2lE4QnVgBzS0PdsabAM+tN3SxxY3siETUwsNF4MQ3OkvG9DEXG3ME3Bx6X/vv7ED7X/ssQiFXZ
 Y3FLisQ9VNYjD/UlZTrQuaqV03uiUHG9yNwau46Uuq3t/ZQCluTPhLeTyLDVbkoRypbtkT84MKe
 QNodbITspbh+eMUuKoPXwjO0Zy/Dqz+GGuIck80v0grR0TZA87vY2EKgXV07rZUySHI84rT44i/
 sUpYBTYe15c4kz/L6vq7RVinyiIRHKHcvGxCWczYnK4paS0B4u3caM16uunAjNpxd+cFfEQqzoV
 QTmZG0AadT+8o/QXLmo8LfS/HYC3bgJQYRC9e8BzCaOHgvH1u6wmIrNPhFEfAsURkUoKlMMjCJo
 k60QF9/eT1JPTJ6oXVBUzAsn4zsWRI=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pass GPIO bias flags down to pinctrl driver, so GPIO_PULL_UP
and GPIO_PULL_DOWN will actually take effect.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/gpio/spacemit_gpio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/spacemit_gpio.c b/drivers/gpio/spacemit_gpio.c
index 6c8184a9818..0733e1472ca 100644
--- a/drivers/gpio/spacemit_gpio.c
+++ b/drivers/gpio/spacemit_gpio.c
@@ -126,6 +126,7 @@ static int spacemit_gpio_set_flags(struct udevice *dev, unsigned int offset,
 				   ulong flags)
 {
 	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
+	const struct pinctrl_ops *ops;
 	void __iomem *base, *addr;
 	int value;
 
@@ -147,6 +148,20 @@ static int spacemit_gpio_set_flags(struct udevice *dev, unsigned int offset,
 		addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GSDR);
 		writel(1 << GPIO_TO_BIT(offset), addr);
 	}
+	if (flags & GPIOD_MASK_PULL) {
+		unsigned int param;
+		int ret;
+
+		ops = pinctrl_get_ops(priv->pinctrl);
+		if (!ops->pinconf_set)
+			return -ENOSYS;
+
+		param = flags & GPIOD_PULL_UP ? PIN_CONFIG_BIAS_PULL_UP :
+			PIN_CONFIG_BIAS_PULL_DOWN;
+		ret = ops->pinconf_set(priv->pinctrl, offset, param, 1);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 

-- 
2.56.0

