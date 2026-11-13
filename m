Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BFF60A3834
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lRNVVBhk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhYaLOJ/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31EE960619;
	Fri, 13 Nov 2026 16:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LyoJRLCY8ac9; Fri, 13 Nov 2026 16:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A57660634
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794585710;
	b=QOVbbxOdaIkTnLQsuoUUfVOySTPDP3V3BtkKo5XADAwL0PfsxjimGeKUqDNiGfL3D2zY
	 Lj1ZYvxjVEdeKraxtSTEsHbfjR8P06F9xWTQOaMq8a7ZPdN9N2rBE8ozQVkMhVyCr0Ul4
	 mG0WoBjwnrbIJcFMfjvYE8jpztz00nwwEqQ/RPwhaUwgQk3P7i4vDvGXMnoTpbsUeV3K8
	 wvfh7ruDO7xE6R4pKx3TpE64ZX4KsKiv+75UMfQQpK0wTx/NT/ad8XPFxF0Gj7l76fWv4
	 FbQ5n8oWOj11QW3EkPXh2SxTMmt3Xi6WX/uP6//EVU3eRj7Q3nSG7B1AjpEnOjJ8GEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794585710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wut590Jp6ohQQ9VkpnNM/XWFYb7SKReywe85NuzYQMM=;
	b=W1KzPpFiUT+f1q42K2jkpa4yOfnvQpgWKukwFmo2U/CfzMHnOYRnArCdA2sB56T7+UMg
	 6sjQOWH4zh3Y9M0/5KvL5H4ZVx6eOLWOYDym1r3cNKIOXtZyZoZNTKHPrdvSQct+xNxaV
	 qVSZItEU/pOTh2/4uLKZJfX9e5e/+3iexLEXicQ8RE+eFh7U6YczrIuWE+ZZo2Gn25C56
	 QCYGBorvQXw86LZhhp1D31ko4VITpL3SlpVYk0+zhTsImwfQJX0pR+p1CvxFIy5PKJ2ot
	 e1nH2pnSAUGWjEOtJgWx3gExDtVlq1POn1xkWFj5wPjzRYOTO3x2u6TMtYKnfMdCOHQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794585710;
	bh=wut590Jp6ohQQ9VkpnNM/XWFYb7SKReywe85NuzYQMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lRNVVBhkjU9k9MM3Q4/5y/vIDXKhFMxVzV18ZP/zxLDwYu5nlMPOInVcXPAf/aKIq
	 kSjnLmM+FPzCeQydtqK7/pLHqbr8L9yqyxM0DKt0vdBGFcDKX3fmjsGn1xfpTi6NmF
	 pL+Uqw6/cUKx21JsUnBOz0iMbIP1zf6Y8kHWM5gHZnkYCLuxDAI4Gu+SksYAA7wFhP
	 WVi8cHCxN/vFZouSGAFSErtqapU9+Jlb6thd3cG6XHKjmTgYaBKmrx3stEtSjjidJf
	 wg+be7W0cmMSGqwOfIz4a1+EEGwgyRfq3okXKsElFpSg3lqGTaOo+lWIbC8dh/eqUk
	 3kD5+e6/Kq8Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A57660634;
	Fri, 13 Nov 2026 16:01:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2088FAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1263F40116
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hzhgdJzMuhcv for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 16:01:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 50779400F9
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jhYaLOJ/
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50779400F9
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 16:01:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3532468EB;
 Fri, 13 Nov 2026 16:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4161C1F000C4;
 Fri, 13 Nov 2026 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794585706;
 bh=wut590Jp6ohQQ9VkpnNM/XWFYb7SKReywe85NuzYQMM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=jhYaLOJ/xSOv6Px44xKYrinyvSL55XioBsH5xxhdp0Fbpz/KNrSGRxSmvMoo4KbXP
 1dGTgpnoPF9MRWjWAaao8T4+/GfPmqkdoxMUeTRR9XorM9VXWekD2BXTpTSjDapIJy
 Ng8IizFYcqPQ4qID+FbOgtjuQimmKl7RUa8cMeQ1QZgMxOGMRY6+HSdsAMqMHtl4K6
 dpttso2Nfh1WRZyMAflUTqP04FWPPzzsismZW0+pXhAd1kgKgZzNZINm6PKu3Boh8C
 q2aJjYM4e6i7gqqn+cO7TI7S4xrYGCCBB5P6FZEc856rlPJYWkl6OE9ZejjuUBVhoF
 Lz0yFBCnDrntw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io, 
 E Shattow <e@freeshell.de>
In-Reply-To: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
References: <20261102-fastboot-addr-r-v2-1-65ee21f29fec@oss.qualcomm.com>
Subject: Re: [PATCH v2] cmd: fastboot: default the buffer address to
 $fastboot_addr_r
Message-Id: <179458570163.70612.14439503854049813461.b4-ty@b4>
Date: Fri, 13 Nov 2026 17:01:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=432;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=EWghlHHOpncra6qKkLmaMIVS1WSzD4A2fonTSmD6kls=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq9zRot3kdBanTXK9ZSO1G1sYF/xWIt+cDYuCWK
 1YXSmhNGkOJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavc0aAAKCRAZDR20Zk4Z
 NcOOCACVHIw2e7viQQFlDDs8j6M6OYxk3xGa+l4Sy9hTs2udCIU/0s0pmKWO63rMgXncIPP9Brz
 PDeDjMNZSHO0oD755ol3nu5OGKgP4ZAu7Yfj5LgI11ym0Mm8DgzLvS6kU6f3B1l8pjWeD+m6iGD
 Khf25oUBT10hA04+TIj38LJdIf1S+X7P+mHm90fm/ajfczQpvb/7UWJgdPSWiWmLcnoW2yCAid2
 5ShFJObtgrRRXLenQTyNdovB4/s0Q2JVOgE3iaRGoR8SwqfA8pAHpk/ux/nnGF0TlHimZIPhgHr
 fVewGPuMGd2RrlrhyFWG5g2PVM5A4JIkftOdxpYbZgYwt8F1
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, 02 Nov 2026 23:08:00 +0100, Igor Opaniuk wrote:
> cmd: fastboot: default the buffer address to $fastboot_addr_r

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] cmd: fastboot: default the buffer address to $fastboot_addr_r
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/ea06563e7b647ef124a9b89450855950c9b569e9

--
Mattijs
