Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD364606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mYM0YzXI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EC21XzBv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9458C8110A;
	Thu, 26 Nov 2026 13:07:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ofs5kHf4E0Ec; Thu, 26 Nov 2026 13:07:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B4B4B81161
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795698470;
	b=avR7x1/Ubm8WMJJMGMkKdHwP7NF0TgwmBdaUhIikDVkq3RKhf3tr3AFf5UMiEl1kh0xs
	 Nl8Lpa95sk4wxiyDaBaGMQfrT+m26Rs206WJpUndPLwzW4Jlll7gqomGXvBgE+DqQpDG6
	 pOz8g8iam8Whv9pfAoO4u8sdC7ZNyCNcfe5KGpYpwRWb8MJ+7EC+FaUtVvn0hcOB61mkQ
	 FX+fOqQ9C4kMmm36fdHSRrsaQhtwxf1A6i4boUNNQu3S4uOpGQBr55z36jLd+/Jx8ll/j
	 v6HRkxW5dLxbBWlNtOENUSbgxsl2weDKxVLAj3hXGmYfg2jBoA4OusRsfHievItiCCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795698470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ubY9dIgjnBnE1jT7rFAqYvMBkQx103CfffQUR+JgUSU=;
	b=A6LxUNyHrkGiE1wKUcmThAuEZzHgJuHdLJPApEry2Pc/NVkTWlfvA5HKadDf5aGXPF2/
	 BMvjxhU3tat512u8jPuAvGzFdw7kosQw7KDiZA2LVuztl82kv0GZWfg72M0DAEMucerWS
	 oLiWmC/G8AKJyyt4mmJWUln7kfGgmknCZwL4RJhticwQq/D5jIRVQjo9WlOdYI4RStJnZ
	 JCDodpw+eGa5yzTxRb7gj5Z2ZcvR+GscTDlid3L7ABBeKO/mCfTVQTUJZWTURvcHo3+ug
	 R0afubP6rW/xZhccYQuPmkUezaba260MaJutE14BRVZV4Hb013jvrrWvTOjd452wlnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795698470;
	bh=ubY9dIgjnBnE1jT7rFAqYvMBkQx103CfffQUR+JgUSU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mYM0YzXIQlcPF/ldNRxR0ZtR+hijKGLN/C76NXQ9RSKHeXwO66zaRUiHSGlFwL8XW
	 7/xksPgiaoFd6FkaD9tWxYAg7thQ3U+s1KOPIEaLDhAEe3lTvzoCHXYJ6ADZCoLEC9
	 2j497PHLNEoqyWM1T3G77nbVBn0bzixQRQmUfAVwANTm/fdFqFCul21FzrJ1+xdHpv
	 TcbKb+ZYU7SWd1BPCCFkPH+sT7inGu383YHvXckQUCu/NVUiudY3aAftukd1wcPeC2
	 5Ym7Fit8YKbkLcXu38qvF5Efp2gqYrSrv4Kwfn46zIic8QfY91JVEw/c5qIDK58C0P
	 YRo4zEIxO067w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4B4B81161;
	Thu, 26 Nov 2026 13:07:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90DCC325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E53D40952
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:07:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ie1bgWcEID84 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:07:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B19D540935
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EC21XzBv
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B19D540935
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:07:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43B9660F36;
 Thu, 26 Nov 2026 13:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE511F000C6;
 Thu, 26 Nov 2026 13:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795698465;
 bh=ubY9dIgjnBnE1jT7rFAqYvMBkQx103CfffQUR+JgUSU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=EC21XzBvogzQ2/dwGhMm+hhIxbxjyzeGGbwPDASVxfhYPQdM1PsT4KS+Qmmw063Cw
 6q2RscAkeoBc94t4AjX9NSolRtKBmTP005VQIcT3tbU8tJVpjuY+I3fSKshWR5hach
 xvfylAMCo0G0cYBj6Qgnhem5isNyVzy3RfVwNRvYlRguOx44KTs2OosWBYKW4V898r
 kJPAIyfwPQxjebM4pdWdO3CIVDLB3jgQtWBG0oCJEV5ZYu9Wr0/iRIkCQDT4r5NIcr
 j29MUlAatlCCBXpQfASZRT2BijkSvegeueCfnFoYJGPBJWySs4EIM4GSCRb1Q/47U2
 AXDdjh3lQ6gjg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
References: <20261118-fastboot-spi-flash-fail-response-v1-0-98c2a4748bae@baylibre.com>
Subject: Re: [PATCH 0/3] fastboot: spi_flash: fix error handling
Message-Id: <179569845952.2171115.8553052091101476962.b4-ty@b4>
Date: Thu, 26 Nov 2026 14:07:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=932;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=AtqKNUgciykAcxhReJ3jhVxnSGEU71eSJxgUB/nd7/s=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCC8fL3rsPsiq0E4tm+2Hq5WW898XNTJLnOL7/
 xN6y6jVm2iJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgvHwAKCRAZDR20Zk4Z
 Nc1qB/9VI2M2i2+sAdMzLJXH2d0EF6uvbAZf0v2FbRfNWMeMInkJu79Ei+tMyf6+4y0fSFA+SJr
 tAsOqDo9r7UvlpHIPUYpTQKjKuG6lSJXVwVf0jRO4lSciuCbDI3PuPShBOw7tZqiZsygW1uHIFF
 zxf5vgdmZLVMhTN4+14b2MQwX8wAgiGbpuD6pjkz+B76tIIeznh8QOWOhwGB/yjynm4EeSyFqVR
 a6HySIxQLnhVZlkFz75+9wgLlpnecluRahwM/gMjm1UaJFy3ORtSTgpmp61+XxE1e2U9VDEB26b
 YmcpzwWGkbzVEUZLLNf3vArSLvJlI0vQr+0bzm7HiTpfMriT
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

On Wed, 18 Nov 2026 11:33:09 -0600, David Lechner wrote:
> fastboot: spi_flash: fix error handling
> 
> While working on fastboot SPI flash support on a MediaTek board, I
> managed to trigger some error paths that revealed some bugs. So here
> are some fixes.
> 
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] fastboot: spi_flash: fix probe error check
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/5edd05c0e90f07a5e8e7d76bf4aa3910dd7522e0
[2/3] fastboot: spi_flash: fix missing failure responses
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/6e2fe8ef268a7717ea613c2938f89eff5103ec01
[3/3] fastboot: spi_flash: add missing newline to erase error message
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/d72f06d356ad527adcb55116a83e6633966a27fc

--
Mattijs
