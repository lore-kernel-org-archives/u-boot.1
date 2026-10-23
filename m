Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E50606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WmHE0r3t;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAGalb1o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8E6C6065C;
	Fri, 23 Oct 2026 01:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NAk-v6_htuww; Fri, 23 Oct 2026 01:15:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B71E560650
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792718134;
	b=oK/K71GTn2eps3j640z+3PlWzShbIE7NPz80NYGNpYLjeb8S7le6ykSmszfSMi5dx3C6
	 WLBYvId6OZ5pMz3wKzSxAi39usD+gH24aas/8Xn5D4p6N4zW2zEpu8Qq+QwOosfADpPzT
	 ljKtNjfosKxhTvLnxZs4OBXLcegujtXb1jUshkytWG+y6q4X5R+5+2dGcOvrt8Ac1xDYZ
	 rfqEdXY7hcpLK9jLrmW4qE8ukP7+oWiICLb5k1dfOXE9oxTV/IQFBPP/BNLAmFQsUz0Dq
	 6BDTPkYUu9jnmMt68x6QQWtfO4sCO+z2/7WTeZ549UptW+15sSsMFLQutyoY6Jhru8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792718134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g3P5IlD+WRjcrV7HtYUO2tAiWgrD+NjD9HhFBw/HctY=;
	b=PlnvOzIHnAeq2jJqXO6GhB/CsDmHoI4bnDVtoToMdsFwRE1ejQ5LSyaXgUABxcpsuFR4
	 9Iex1FKuqDIlbOF77OsoHUWx0BVLb2VNhUhRHYOPeIYRAOJ8CtWv63L3pcyxDxgptGOxz
	 UHFWSqE/J9c7XDM2goLzwUEc0YJx8wK3ER3gXPvl7ACFYF9CInTgYm4EiHrtRbSJumyGY
	 wbBJxbYZSnZMpXavDz1gg5p0DovUVV3EP7+DpmUVlu98xzcZNkKiV1hwvV2g5AEcj9PKS
	 03X4j37dhMxSv740Gqj8bgt6/QTEPZY+poPgTDjAGnKDeAPDT2YNKJzK8tEjeg5FVew==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792718134;
	bh=g3P5IlD+WRjcrV7HtYUO2tAiWgrD+NjD9HhFBw/HctY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WmHE0r3tDO1FvgoivuLLXkosEDm3LNCUTCbmfUU5fKKi8086OTXshBrD+GUgrxQ13
	 tpeMIlBX3geomEr7/AFRnfkTqgM/c7bVecrlB1h8wkJztOhygbiqNknoZn0SqfPIA4
	 mgEgolf2OYPU+l9dP0OY8JP3dkpm7vXo3Y3Q/2XWiHmZ/TcXkbCe7IK8fAYLh9/D61
	 wyYCN3hLM7gKg+ZlZrP+i0fu9mkQ1hNuRRXfhx3g0TzI599ozTFOcQM2SZpOj13B0f
	 KXzlNt0xAZAZRWFWKsKOrC2fWizwNbDTNhc/1RxOZqxETqilQeZ1sQ3yN+WdsK62x3
	 optJ/rH2DKs8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B71E560650;
	Fri, 23 Oct 2026 01:15:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 959AA49D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93056407C3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iz-nbIlkvyhS for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 01:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 949A1406CE
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792718132;
 b=AOwpvKMDYtLdPW8efvleqA+sAIJlxH/2kGzgwZ4bCW3aigf2UvqqWP2GNePRz0d6a0/k
 YAJXJthtmxLzTd2iVVmKGY+oUDPwJcG4qswJpIP2JByr0sF+BLkJldatFMZg7GnJQHd9N
 Krd0i7xCrDFuTh9BDhtPG7Wa+SB0Pe5gfJmx7vpItosFNYMqotkdOHlWixU6iDxC8HJFG
 8W3+nG6I0XyiaWxQ47BQ220I2SRMNg5nEmcMICmgMZA/x41J5gpd3pJxMcJZSo2/pk+S6
 yxJSuKzaL50d6PQ/M2Hi490hRCuOUBiIj2VPFXFHpk3ScEQEmvUAfYCusrhmdNzlrYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792718132;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=g3P5IlD+WRjcrV7HtYUO2tAiWgrD+NjD9HhFBw/HctY=;
 b=nN67rayVVFD5LD2zD8zv9b1CbUu2IYnRJKri4ANDw+LCJRrrAlsCxLAd7ePxB1Dzg0Jw
 NLkTd+mK613GnZgcOxeD8Zj+rXTkFhHATbmzE/6ZpFItuydUvda8emtJfkJZ1zAee45Ab
 a1mFSTRn3BCldF3espl0U3Fhc/4gaQFYuSIWsaRHziFMMcu0nPmJEC4w39ROZPA5Bvyxz
 VIPVX7wNsixxTgQLu9XOu95dGxUikiNcCkPjMSzLdkfrymymoG/OHjptXhof+J7KLhLcX
 PaILGu7xPYf+HXrFEE7NnCc07uAmEkUOdxWntXD+Txn6Jc35nLkobVRXcAs1Bsty94g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AAGalb1o; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AAGalb1o
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 949A1406CE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:15:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6809B404B0;
 Fri, 23 Oct 2026 01:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788BD1F01825;
 Fri, 23 Oct 2026 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792718129;
 bh=g3P5IlD+WRjcrV7HtYUO2tAiWgrD+NjD9HhFBw/HctY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AAGalb1oenZffp8XPaaQJOAFy4fvdV6p7lEK5KPEArboae8JptPBtDsAndEnEG8yB
 BnpAZVYjy+LPjWIyDx5lNpVi08kcxrhdNTdjBy33KTJNzJfGYyX+ssoZGjgG2dkkvZ
 lvNBMkLAZy+ptgR74Sdy0vbqFXKaiiqNubUOxlv42ITsJrDWt3ZeaV7zH4ZKi/PiNF
 dhDvQ3WBXhteJKjbwMO34x17UkKjGh3uv/SxjF6CwjkBlyOBKBOUWpmFRYghpeSCDF
 ZQOGsJ0Xj8gw18YYmdm4ah7zz1LZWJGqXpkEVtJQrb6tmZh6ZTBauO40LhLN3Wal8l
 JuqV8fIdcmmXg==
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org,
	E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Subject: Re: [PATCH v2 0/1] Enable eeprom tlv command for SpacemiT K3 in main
 app
Date: Fri, 23 Oct 2026 01:15:26 +0000
Message-ID: <179271793933.297907.2256671941117337358.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021154226.1391944-1-e@freeshell.de>
References: <20261021154226.1391944-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 21 Oct 2026 08:42:14 -0700, E Shattow wrote:
> A few commits that have the required eeprom nodes landed recently with
> the import of Linux v7.3 devicetree-rebasing to U-Boot dts subtree, so
> let's enable the eeprom tlv command in SpacemiT K3 config. There's not
> any SPL in-tree so don't worry yet about implementing such hooks or
> config options.
> 
> Changes since v1:
> 
> [...]

Applied, thanks!

[1/1] configs: spacemit: k3: enable eeprom tlv command in main app
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/2d79480aad04cb36043963cb4be1caab2fe35da3

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
